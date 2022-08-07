Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB6C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 17:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiHGRBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiHGRBe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 13:01:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EE6324
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 10:01:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z19so6660967plb.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=6nfbsVuXH2N9gVIPbwg2RMOyVAaQGgE2ShUi1q+i4sk=;
        b=qRtG94/Phe29dKJsjuBz7Js4OVsL1owWebMaF+RgKu4Wh810XPgqFUOj+6Hm2HyU2W
         sgmdtsFAYPNNF6PXTQzjKIsQQm1BdsTZnemHDI0c5/7nXA7efxCI8SlXw1Lbafpedtbs
         pyukPcp97XEKgQMmCKRYgDf5C21g/Wqu/2C6NwAkMtRnrGLvGz4amjP7U1V3tL20ZsSI
         wTCtGKt505WDypG2nq3f+tAaPb7IukUYaQiYygBEbcSQ1phYawpPUxDcRJzUoGXr6KiK
         ffgtjaM4NGC2urVjnkmm6FIJ+77GnnlRCQJ76Z1m/h6LxPLeAO3NFB0S2POQqHSA4kdy
         L6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=6nfbsVuXH2N9gVIPbwg2RMOyVAaQGgE2ShUi1q+i4sk=;
        b=j6WeygrLky5ibMurfvAtes31gTbxyDP9El+0Vv5ZbIvDyuJVR+HBYhClRBR+ySP5qr
         cchUBEcpxLV+VKjlngBKnSn/FuoEVRJDoWem3hE5cHIzH5iN++J1eJIa4eR35ETpuss+
         ukxNwoIVb20OfAe5jxejFQ3ySgtsBpHfZCcBQ4hGkUdvSbtHUok9WXRv8XV8htmPsNp2
         7/PnI8aDWqcXkQQOE69OCsT2fAIoIFCY+UeSTa7bqSVx0WGhro1I1Ez22VE6tOuPQJl8
         qSlv/Xw8uN2pe/whDK4d6Mtw2KvUXP7WnljrUwZ/ExWGS6vl2qb3LvBzmwVfSoVq467O
         l+Qg==
X-Gm-Message-State: ACgBeo2fGjzVFhVayfcs8JyBQ6pdQZY1luuoCocTZmRfjZCamHWtnaQi
        7IUv61V7MXLjwhn8uGtw5FL6azdcg6PMGks6ZHzdZ9fJj6Te3VQc
X-Google-Smtp-Source: AA6agR7XuqEoXzPNDKLClvTVAj12mLtrO2JPLTx2Zr3vQiDfAUs35AYZ9vIB5SRR0u9ac3xaBDnWRaSNL4rdWl7yJjo=
X-Received: by 2002:a17:902:ce90:b0:16e:f7c3:c478 with SMTP id
 f16-20020a170902ce9000b0016ef7c3c478mr15631553plg.82.1659891692718; Sun, 07
 Aug 2022 10:01:32 -0700 (PDT)
MIME-Version: 1.0
From:   "Alex A. Davronov" <al.neodim@gmail.com>
Date:   Sun, 7 Aug 2022 20:01:21 +0300
Message-ID: <CAKBAyV4XaXC=Gw5SN9So9UAMJ9ZQE=8dA7B5D8+Wn4JKuFRDeA@mail.gmail.com>
Subject: Init-add-reset bug in a fresh repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce your issue

If you have files in a folder and then initiate-add-reset git
then you lose everything:

Run the following in your bash shell to see:
    clear; \
    [[ -d /tmp/evilgit ]] && rm -rdI /tmp/evilgit; \
    mkdir /tmp/evilgit/; \
    cd /tmp/evilgit/; \
    echo "----------------- Create some files:"; \
    pwd; \
    echo -n "ls -l: "; \
    touch a.txt b.txt c.txt; \
    ls; \
    echo "----------------- Now, init the repo:"; \
    echo -n "git init: "; \
    git init 2> /dev/null; \
    echo "git add: a.txt b.txt c.txt"; \
    git add ./*; \
    echo -n "git reset --hard: "; \
    git reset --hard; \
    echo "\n----------------- Check files again:"; \
    echo "ls -l: "; \
    ls; \
    echo "No files! " ; \
    echo "\n----------------- Now, all the files we have created are gone!"; \
    cd .. ; \
    rm -rdI /tmp/evilgit


What did you expect to happen? (Expected behavior)
- Files created prior to repo aren't getting removed
- OR
- git user is warned that the files are going to get deleted if
resetting hard indexed ones

What happened instead? (Actual behavior)
- Files are gone.

What's different between what you expected and what actually happened?
- Pre-existing files should be kept

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-43-generic #46-Ubuntu SMP Tue Jul 12 10:30:17 UTC
2022 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]

[Additional info]
See for reference:
- https://gist.github.com/hinell/e023bad4652364b477decb036fc6a60a
