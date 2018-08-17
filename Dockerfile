# pull 4.7.1 sdk and use for building
FROM microsoft/dotnet-framework:4.7.1-sdk AS build

# our destination will start at /app
WORKDIR /app

# bring in sln to the root, and .csproj/.config to root/legaysite
COPY *.sln .
COPY legacysite/*.csproj ./legacysite/
COPY legacysite/*.config ./legacysite/

# run nuget restore at root, which will hit the sln from line 8
RUN nuget resore

# go back and grab everything else we need
#	copy rest of site source to root/legacysite
COPY legacysite/. ./legacysite/
# change root to the site path, which was /root/legacysite
WORKDIR /app/legacysite
# run msbuild on current directory, which is where csproj is
RUN msbuild /p:Configuration=Release