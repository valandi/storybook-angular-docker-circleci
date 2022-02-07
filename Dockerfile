# STEP 1 build static website
FROM node:14.15.4-alpine3.12
# RUN apk update && apk add --no-cache make git
# Installs latest Chromium (85) package.
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      freetype-dev \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      yarn

ENV NPM_CONFIG_LOGLEVEL warn
# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
# Create app directory
WORKDIR /usr/src/app

# Copy project files into the docker image
COPY . .

# Install app dependencies
RUN npm set progress=false && npm install

EXPOSE 6006
CMD ["npx", "eyes-storybook"]
