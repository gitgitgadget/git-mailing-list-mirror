Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD1BC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 16:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbiAUQiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 11:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiAUQiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 11:38:09 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF4DC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 08:38:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c3so8961779pls.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rooden-ee.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SKOXeXRIG5BniTVPxvjJTLWilhD2sKQhC3Ko9uzBRE4=;
        b=dHwVsuy5jcUqZYd/TJDJwNAqLo9xG46D+kxKUMvjZQM4cjP5FFsO5hC7s4zE16XIQh
         pHYUWQC6EXFnyrG16X2KYanYGf+2SVzXAjx0ysv9g+C8qQ2W/v6VlJthp1Snd4K3rgHm
         2zeAKQ+cUDHyZE4mF4YDKabGpwDwBqN0XKKsXj0zqeXBRfOLKx3mViiOkgwGYEDEoJ9M
         DX15I/cYHpV5m+7jGd7MaoMFxHxLPtg/wW3XdprM9f3vhvUTe77Syr5yC7+yH/dYyTiy
         THHuLorQ9kT27oklFxw5kMOBZ/EEm8sII5fNKeXuSXSQUc3hb2MyaQMfiPjLiTJtXk0Q
         plgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SKOXeXRIG5BniTVPxvjJTLWilhD2sKQhC3Ko9uzBRE4=;
        b=x4FYmGZB6JqVqV2PIIwQlzcg6rhv93DSMLWHsp6Rbq7zO+hieN9loiUyWLAZRkXm4m
         a2PbaefOzMg6fTB6LXMmao73JX8FdHph1pYS9T5bP/Gm48Q8jsuAgy2x3kQhqbNr2obR
         cfORthNtGl/EMPodR62dyzlMLRxuB971g4TTUyce+KGQTEgGIjH6/wpDdGAiPXvtYI2x
         JZEeEqKtUYrtzVR96X5GcH/L86WwS3ZD7DEzQ0CE5W2Bcmvmw7VZ7Ex1U6x3VrO7HE3Q
         vJG7k3AD7L8zkaZ1v3p+TR562+Q/3oYkD0md3ZEdJCKq4X84UqWVwxxXQSI/vO8vl8a4
         0ryw==
X-Gm-Message-State: AOAM531FMw7NLqVGqAuvjzpB0dF0b2WsLqo1G2wQFDYCdD6akF1HFWoF
        ztYGxwOVIf3E1PAop4q/xwZI3VWDccu6PkS51oJgy1abUHg=
X-Google-Smtp-Source: ABdhPJz+3BBTTOdTYj0IF9Bf8Zvr5MAi3oHYNeD5vzwR16pFroZ6W6/Phn6YmVx3A+urnsogDjKur3BMxvGSpup6Kfw=
X-Received: by 2002:a17:90b:3808:: with SMTP id mq8mr1530192pjb.173.1642783089053;
 Fri, 21 Jan 2022 08:38:09 -0800 (PST)
MIME-Version: 1.0
From:   Lauri Rooden <lauri@rooden.ee>
Date:   Fri, 21 Jan 2022 18:37:58 +0200
Message-ID: <CAHqym3xs_M7BvvFDq2pHM-+DgK_nJcBakVEBL-GiNwnCRzMwWA@mail.gmail.com>
Subject: Strange checkout with GIT_WORK_TREE
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does the GIT_WORK_TREE get lost on the middle of process
or I am misunderstand the git checkout?

What did you do before the bug happened? (Steps to reproduce your issue)
- I wrote a shell script to reproduce

```git-test.sh
GIT_ROOT=$(mktemp -d)
GIT_COPY=$(mktemp -d)

echo "Create git repo with two commits: $GIT_ROOT"
cd $GIT_ROOT
git init
echo 1 > a.txt
echo 1 > b.txt
git add *.txt
git commit -m "Initial commit"
echo 2 > b.txt
git add b.txt
git commit -m "Second commit"

echo "Checkout to other work-tree: $GIT_COPY"
GIT_WORK_TREE=$GIT_COPY git checkout HEAD~1
git status

echo "ORIGIN $GIT_ROOT"
ls -la $GIT_ROOT
echo "COPY $GIT_COPY"
ls -la $GIT_COPY
```

What did you expect to happen? (Expected behavior)
- a.txt and b.txt checkouted to $GIT_COPY both with content `1`
- current folder unchanged

What happened instead? (Actual behavior)
- only b.txt checkouted to $GIT_COPY
- HEAD~1 checkouted in current folder but folder content remains HEAD
(modified:   b.txt)


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.16.0-arch1-1 #1 SMP PREEMPT Mon, 10 Jan 2022 20:11:47
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/bash


[Enabled Hooks]
prepare-commit-msg
