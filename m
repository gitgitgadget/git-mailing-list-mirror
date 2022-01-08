Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB1C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiAHAgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHAgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:36:40 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E4C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 16:36:39 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d1so21277900ybh.6
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GMbgM7qriD2BXjZ13UtTeukLvxuLxzemTFvit5gN7cg=;
        b=g7AaX0NygK0I02yFCxpXDSOh3B9uBD/OVuLn//3t53f/IK5INCyKrwimxp9jusvq2+
         zxrR5Cx2Xqw6fBcHsjT9cw1UdEiFOOh8feSbKRyr/EfPx6aH4GR6WFrze7iZSN8uupCt
         HF87prPoUAvxSlWqy9TaJqsWP3quF4Eg7qQcAJy+lXAxmypj3aiLMQWrnki2SkngJVAJ
         Y3GSXBtSWkuRFrkmC3MmIRC8l70GuSTUIF9o769dN7wdtAS1rMDC3vCN8NgvR+0PKGeO
         R0fksu41WksOYvoNe/JWdxAptyl3fw7B1oVbyr92HSrj+I8Aij2rgaX73ayeOLtyhvg5
         E7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GMbgM7qriD2BXjZ13UtTeukLvxuLxzemTFvit5gN7cg=;
        b=2bOYGZzyINbBP9h8Lo5mX2JG+UM5F7a5vTkbx0dFRWhfQg1gInkFEfeb+L4iIOoBj4
         eSOmybaFovoYRjTqi48cn9gQa4aUoEHcQZuqjqkj1pC9BEvN0vjhu3/r7G7vORipMk/8
         SgMM+yMLIJBUGcJ0UcIVl2qG6Qsog9A4WNaXuMpygykSyNLsG8WrLZVMfeyloFFrYGQS
         gKZNymj3ChDoOiJbnDPpsyvWUQrwnwqHRIjwOp7pgU+wIWeTLvxc65rzLT23Wn8gDNj4
         jO607ehnAGHWT/pyk+myb0NqMkSxTHncP69xfL0UJ/dsQKmixBoss8k+2MPF+Aqmt0ZB
         Cxyg==
X-Gm-Message-State: AOAM533HeW0ZwF/rHalJSk5RTvp1X3uMdfi3sXEaLhhn2ZDf2hdM4cJI
        NbNBwvQj/00oc+DsMQxxTTChT1mWf5OjW+BYsr37GD4MWTc=
X-Google-Smtp-Source: ABdhPJyOv5pPlbRnAI3UpcMtxvMKUNc+VciTmnE8qF7PEYhBC/PoK0ivpA9tPc1jJXcwchH1J8wd1CopZxps4UeX3rQ=
X-Received: by 2002:a25:e654:: with SMTP id d81mr74505190ybh.445.1641602198887;
 Fri, 07 Jan 2022 16:36:38 -0800 (PST)
MIME-Version: 1.0
From:   Keith Thompson <Keith.S.Thompson@gmail.com>
Date:   Fri, 7 Jan 2022 16:36:27 -0800
Message-ID: <CAAHpriMPdahH2xbrrQbeCJPYpLhr6tuvT6xsG3nACmskKF1v2w@mail.gmail.com>
Subject: Bug: With diff.noprefix=true, `git format-patch` creates a patch that
 `git am` rejects
To:     git@vger.kernel.org
Cc:     Keith Thompson <Keith.S.Thompson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git format-patch master

What did you expect to happen? (Expected behavior)
I expected `git format-patch` to create a patch consumable by `git am`.

What happened instead? (Actual behavior)
`git am` choked on the patch because it was missing the `a/` and `b/`
prefixes.

For a simple example, a patch affecting only a top-level file, the error was:

    Applying: Fix typo
    error: git diff header lacks filename information when removing 1
leading pathname component (line 9)
    Patch failed at 0001 Fix typo

For a patch affecting a file in a subdirectory ("DIR/README"), the error was:

    Applying: Fix typo
    error: README: does not exist in index
    Patch failed at 0001 Fix typo

What's different between what you expected and what actually happened?
See above.

Anything else you want to add:
The details: I had this in my $HOME/.gitconfig:

[diff]
        noprefix = true

This caused `git format-patch` *not* to generate the `a/` and `b/`
prefixes in the patch file.  Setting "noprefix = false" works around
the problem.

Here are the first few lines of the resulting patch file:
===
cat 0001-Fix-documented-argv-and-envp-params-for-posix_spawn.patch,000
From f4a41189d86bc208a90e754387294b9c4c11cdfc Mon Sep 17 00:00:00 2001
From: Keith Thompson <Keith.S.Thompson@gmail.com>
Date: Wed, 5 Jan 2022 13:30:16 -0800
Subject: [PATCH] Fix documented argv and envp params for posix_spawn

---
 newlib/libc/posix/posix_spawn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git newlib/libc/posix/posix_spawn.c newlib/libc/posix/posix_spawn.c
index 005471fde..85bfa6477 100644
--- newlib/libc/posix/posix_spawn.c
+++ newlib/libc/posix/posix_spawn.c
===

Feeding this patch to `git am` caused it to strip the `newlib/`
prefix from the file name.  There doesn't seem to be a way to coax
`git format-patch` to ignore the current diff.noprefix setting,
or `git am` to tolerate the missing prefixes.

Changing my .gitconfig to set diff.noprefix to false avoids the problem.
I could probably have done that in the local repo rather than in my
$HOME/.gitconfig .

Suggested possible fixes:

1. Make `git format-patch` ignore the `diff.noprefix` setting, or at
   least provide an option to do so.  In my opinion this is the best
   solution.  There's no point in letting `git format-patch` create
   a patch that `git am` can't handle.

2. Make `git am` tolerate the missing prefixes, perhaps by not
   removing prefixes that match, or at least provide an option to
   do so.  For example, given
       a/newlib/libc/posix/posix_spawn.c
       b/newlib/libc/posix/posix_spawn.c
    delete the a/ and b/ prefixes, but given
       newlib/libc/posix/posix_spawn.c
       newlib/libc/posix/posix_spawn.c
    leave the path alone because the top-level directory is identical.

3. Make `git format-patch` print a warning if diff.noprefix is true,
   letting the person creating the patch know how to avoid the problem.

4. Make `git am` recognize this issue and print a warning, letting
   the recipient of the patch know they need to manually edit the patch
   or request a new one.  (This would still be inconvenient.)

This issue is likely to affect other commands including `git apply`
and possibly others.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1
cpu: x86_64
built from commit: af6d1d602a8f64164b266364339c4e936d5bbc33
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-91-generic #102-Ubuntu SMP Fri Nov 5 16:31:28 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /o/bin/bash
