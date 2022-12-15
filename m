Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36BFC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 03:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLOD7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 22:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOD7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 22:59:20 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223422A422
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 19:59:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id g14so8725431ljh.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 19:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=irXRc/ZdDHf4z6HDbTByeW5ufLBAP+jrzBV/7SJ93Xc=;
        b=j2gXXx8QaTXyEVMSJDBML6ByEEhGeRys+xMqjlCXmJ8e4KNbGvFLINzT0PT3mTzchi
         iO7m0t3DFvXOPKGTYf5YP8t/KN9/KCyd2bTvQdoOTrZEKhd6XZVUU+WgirnCuW33ahQR
         DT1YN4FtnY7Hfyk22BL6QDtoh4mys9IZEo/9mHjqSHK4wUlScYfrX/jrs20yGh7vs3p9
         95UWLvDaNvtQwjwEDvntQUCMmZA0wm6qC6j96/RJC4s6oi4fzoW3VLqatlaBmrqt5wKi
         qzFbXqPeVM4QZAh8shi1sGNMtjQFX/SggtXCPd+iTURWfOnrHVyTZO1hyPu/uTUjGehs
         Snkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irXRc/ZdDHf4z6HDbTByeW5ufLBAP+jrzBV/7SJ93Xc=;
        b=fXIuT3Nc3G42CNfXnMCHQO8+1kOLLq83h6f+Q+LhMRVuKBVZZUO9u50AY8eGt2RF/N
         lKrOGpMHEAJVmg53xtGpHFsGpnaHT36wXWxvJYV0roAmQgRL5wB2Eu58eKIo0Ltvg/5d
         62ekF+hd0ExNXNFLuGbmhzEQzFidf+vNnQ3RaqX/eiPvcazJqFWNk6PgNzG79VgIihUC
         Y2liyAT0+UWmH4JBsxTPB17YNOqLL7guEtrwepUR4ECrlauAID56oHfWdmZkVNU3ZEqp
         qQbGGMy+6ks/P+7rmOMLY7Qu1AbbRAWuRdhybajdp61qYf0WxrXIfP3WhUEPzvsY4oTw
         rooQ==
X-Gm-Message-State: ANoB5pn6DaCmZJlRg94PSW1M7muwmmCgewq/Ih4/CNHWzFYXtoS33GSP
        MsOAwkd9/vLrelEvhQpXavDS9+Ze4KuGBG1H4ojJRjqxIHUDHQ==
X-Google-Smtp-Source: AA0mqf7YK+c7Ux8BIc5VrwkMn2wTGmeKuP7AfKJXb93KISNU9WHNJehxT6/QFNnsRLJpl9klolTOantPDLZhjgddsrs=
X-Received: by 2002:a05:651c:150c:b0:277:c7c:c573 with SMTP id
 e12-20020a05651c150c00b002770c7cc573mr26853589ljf.316.1671076756863; Wed, 14
 Dec 2022 19:59:16 -0800 (PST)
MIME-Version: 1.0
From:   Stephen Hicks <stephenhicks@gmail.com>
Date:   Wed, 14 Dec 2022 22:59:05 -0500
Message-ID: <CAKNkOnNAvV0tTkQXyRXjTiiUqPpu2cJSg5emrODu3AoGm79v+A@mail.gmail.com>
Subject: Prematurely-closed stdin using async NodeJS to smudge large file on Mac
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently observed some odd behavior when setting up a repo on a new
computer.  I isolated it to some weird behavior where git seems to be
closing stdin prematurely.

Repro steps:
```
# Make a new repo
mkdir smudge-test
cd smudge-test
git init

# Grab the first directory on the path (NOTE: we'll write to $BIN/smudge)
BIN=${PATH%%:*}

# Set up the smudge filter
echo 'file filter=smudge' > .gitattributes
cat >> .git/config <<EOF
[filter "smudge"]
  clean = smudge
  smudge = smudge
  required
EOF

# Write the smudge script into $BIN/smudge
cat > $BIN/smudge <<EOF
#!/usr/bin/env node
const fs = require('fs');
fs.promises.readFile('/dev/stdin').then(src => {
  console.error('Read ' + src.length + ' bytes');
  process.exit(1);
});
EOF
chmod +x $BIN/smudge

# Make a 2mb file to smudge
head -c 2000000 /dev/random > file

# Add it to the repo
git add .
```

What I see is that every time I run `git add .`, it quotes me a
different number of bytes read.  If I truncate the file down to (say)
1mb, it works consistently every time (note: the add still fails
because smudge exits 1, but the bytes read is consistent, which is
what I'm looking for).  The problems seem to start somewhere around
1.2mb or 1.3mb for me.

Changing the NodeJS script to use `fs.readFileSync` seems to fix it,
so it appears to be something peculiar to how NodeJS handles the main
task exiting before all of its async work is done (FWIW this is my
current workaround).  Piping the file to smudge directly (rather than
via git) works consistently as well, so it's apparently an interaction
with how git is handling the pipe.  I also put together a quick shell
script as a wrapper.  If the shell script `cat`s stdin to a temp file
first and redirects the temp file to NodeJS, it works consistently.
If it just redirects /dev/stdin directly to NodeJS, it's inconsistent.

I'm running git 2.39.0 freshly-installed via MacPorts on macOS
Monterey 12.6.1, Darwin Kernel 21.6.0, Node v18.12.1.
