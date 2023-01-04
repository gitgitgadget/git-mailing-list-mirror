Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C9C53210
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 22:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjADWDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 17:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjADWDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 17:03:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EACD1BE92
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 14:03:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso40428865pjt.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+qc1zcgrkd2cYjbELa4qtocDy5B6bWu4xMf5SWxi1s=;
        b=BDWmige13RVdEHEbwSgF6aGDhGpeI/5doyzPhm+/+3jRKpPNnafMNrfBooM76rBOWk
         OwaZFAlU7jeE+P1daKyuY6RGMfo7i3PfMSda544KLOsVsDcymZqJNF4YoiBeHgtZQiu/
         cbKOmaTObvnHdoicSVrBRRm8dTZq5whx0d2+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+qc1zcgrkd2cYjbELa4qtocDy5B6bWu4xMf5SWxi1s=;
        b=hQMcOJFKN5AKqm33xeU3tEy8g5y2QZfUm9Y3PWkUZUAiz/8c9IHrbCg8UjHrKFKhs8
         1kIheQjPjVZwhRCcW1hcc87gZ//zsM0gOMb7BABgYo3EjY6Y7WCpwnFglFiQ9S2jSvy5
         CCCQb/5XPRHcunJcPD6Q5RCpHb+Sj6l6j3o4l5YSJthgnFrWqKDLN/un75S0+4O7Rur1
         fxDFU+9CXzcxZ4BBFlNkoBwUlA0/4rGoYi7HDbD0IfwVCIt+tywBbXDqXfUXO8gotrmy
         czJ+7J2NourcF5XLfV2BHa0ieaPbw8G/OFFE3wlJrgOfnlKYeL5GPLiZuY5Jt6d/6KAx
         lfKw==
X-Gm-Message-State: AFqh2kqJWWUn/6mb/cAbulEXkwgBeSUfCJWwVziz7+PCXClfZlJY/Q0k
        aMYtv7yq5nVWG/PwKF00aZ19ZpSNdAVlqIXpjoHZSx2FhL8r20igl/o=
X-Google-Smtp-Source: AMrXdXt8mHAIHy59gy/sW8J3xXX3LMbFa4h5s3DhfZnheVA5ruzc5KEmeX7ueLv0sVOjgi3X7WBcuzylwX8mZunn6Bo=
X-Received: by 2002:a17:90a:9b8b:b0:223:f691:14d3 with SMTP id
 g11-20020a17090a9b8b00b00223f69114d3mr3929235pjp.139.1672869809029; Wed, 04
 Jan 2023 14:03:29 -0800 (PST)
MIME-Version: 1.0
From:   Carl Baldwin <carl@ecbaldwin.net>
Date:   Wed, 4 Jan 2023 15:03:17 -0700
Message-ID: <CALiLy7raQsK3j+f6+dpYrEiegvFZRra5F9JwPWu---4h_AR49w@mail.gmail.com>
Subject: Problem with git diff --relative, diff.external, run from a sub-directory
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

    I created a simple external diff program called `mydiff` and added it to
    $PATH with exe permissions. It looks like this:

    #!/bin/bash
    # So that I can see how git calls me
    echo $0 ${1+"$@"}
    # || true is just so that git doesn't think that the external diff failed
    diff -u $2 $5 || true

    Next, I created a new repository with one file in a sub-directory. I put
    five paragraphs of generated lorem ipsum in the file. Here are the precise
    commands I ran to do this:

    $ mkdir lorem-ipsum
    $ cd lorem-ipsum
    $ git init
    $ mkdir subdir
    $ : Add some text to this file ... (I added the five paragraphs here)
    $ paste > subdir/text
    $ git add subdir/text
    $ git commit -m "initial commit"
    $ : Make a minor change to the file
    $ vim subdir/text
    $ : With the local modification in place, the following looks correct
    $ git diff --relative
    $ : This also looks correct
    $ GIT_EXTERNAL_DIFF=mydiff git diff --relative
    $ : However, cd to the sub-directory and try it again...
    $ cd subdir
    $ : The following looks as if the file was deleted
    $ GIT_EXTERNAL_DIFF=mydiff git diff --relative
    $ : However, this still looks correct
    $ git diff --relative

What did you expect to happen? (Expected behavior)

    When using a diff.external command with --relative, the diff output should
    show the minor change that I made to the file.

What happened instead? (Actual behavior)

    The diff output shows the entire old contents of the file as deleted. The
    header of the patch looked like this (indent added for this report):

        --- /private/tmp/git-blob-DQP9aO/text   2023-01-04
14:33:00.000000000 -0700
        +++ /dev/null   2023-01-04 14:33:00.000000000 -0700

    Here are the arguments that git passed to mydiff:

        /<path>/<to>/bin/mydiff text /private/tmp/git-blob-KTGAg0/text
0515a69f4ce73e295f4a7824f475bf75793cadb9 100644 /dev/null . .

What's different between what you expected and what actually happened?

    Git failed to pass the new contents of the file as the fifth argument to
    the external diff command which led to showing that the file had apparently
    been deleted when it had not. The sixth and seventh arguments aren't
    correct either but mydiff doesn't use them.

Anything else you want to add:

    The following three things ALL appear to be necessary to reprouduce this
    behavior:

    1. Setting an external diff program (either with env var or
through .gitconfig)
    2. Using --relative (either on the command line or using .gitconfig)
    3. Running `git diff` from a sub-directory under the root of the repository.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Thu Sep 29 20:12:57
PDT 2022; root:xnu-8020.240.7~1/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
