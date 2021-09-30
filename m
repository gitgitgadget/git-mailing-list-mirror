Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA4C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 00:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B354615E2
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 00:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbhI3AvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 20:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3AvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 20:51:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC0C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 17:49:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z24so17965665lfu.13
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitpod.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=VdDIzX+sZzEJ5wdd9AxroEHrEoqKOM4eNE+8Ng06vYU=;
        b=dy3wgiUDL1f0R9rcVbAU98xiqqPQhsz8pynCYS5vUQ6bnPK/5gXCUk/nisVdMgol8T
         urbjAs/AkGWnvqPTYtoORCAK4SUcLlbeOvc83Vz6fOw5DVfRohzFp/quof+S6CfiGUXG
         K+5b5uJalQQsDb+MR0+U4twCHg8h8wo7Iqgl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VdDIzX+sZzEJ5wdd9AxroEHrEoqKOM4eNE+8Ng06vYU=;
        b=InjZFsRCh0LSKULcJ3kxIWf9v0HT0UqyEXnSD8TR2c41eFaG9OpwiIY3Dk2Aa3a2js
         fPnQ/gNZKiZD8s9tI9SQS268i2qe8Ch8tGI/zl7oqV23Io+g40JoJIjluD34cYSrSf6X
         muH2MuZWgv4ZT2IcPnD3J585cnQYmiM6KqOKeKyJv5992sucPuOeTo87kFEOTjuhtTa4
         3eXiIwc2mf8jo7rDEEIrit2KkOHoA6ChjOThcWH5kSTMmFSTgJn4MKtE5U2BvsyqApjk
         lt2IeomRNryWYy6ndHDRb2hmDbNI8YM7brgfrCrQJZc2vP/aXJkKrzSbteL2tqdwE7BH
         TQAg==
X-Gm-Message-State: AOAM532wHVqvqN//+h+QQQ6rMTp+uLfJ1XIKqxCDAjep2qqKIdnT1O9A
        X+lqJ3jm2O15+4/OOf10OBQ2fT5t+u54P84hmyKN0ceFYu6HOQ==
X-Google-Smtp-Source: ABdhPJw3E4ptc89ATKpicvg/NFXqbXoWWTytNfINSyqCh01Oro2Dy2zh1FFtosh1HINMia0w1GJzVzM2fOuzs0NOnIY=
X-Received: by 2002:a2e:7804:: with SMTP id t4mr3076280ljc.346.1632962968757;
 Wed, 29 Sep 2021 17:49:28 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Leftwich <robert@gitpod.io>
Date:   Thu, 30 Sep 2021 10:49:20 +1000
Message-ID: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Subject: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
  Initialised a repo and added a file or cloned a repo inside an existing
repo (think dependencies).
  See https://github.com/gitpod-io/gitpod/issues/5675 for background.

  In an existing repo:
    $ mkdir sub_test && cd sub_test/ && git init . && touch test.txt && git
add test.txt
    OR
    $ git clone https://github.com/stencila/test.git sub_test
    THEN
    $ git stash push -u

What did you expect to happen? (Expected behavior)
  Command should complete without error but ignore the directory (this is
the existing behavior prior to v2.31)
    $ git stash push -u
    Ignoring path sub_test
    Saved working directory and index state WIP on (no branch): 94f6e3e283
Git 2.30.2

What happened instead? (Actual behavior)
  Command failed
    $ git stash push -u
    error: sub_test/: is a directory - add files inside instead
    fatal: Unable to process path sub_test/
    Cannot save the untracked files

What's different between what you expected and what actually happened?
  Command failed

Anything else you want to add:
  It happens on all versions from v2.31 to current master.
  It is specifically related to this change:

https://github.com/git/git/commit/6e773527b6b03976cefbb0f9571bd40dd5995e6c#diff-70525b6b89c7cac91e520085d954a68671038d218b77d22855e938ab075a68d8L1006

  If this is the new expected behavior perhaps it can result in a better
error message and related documentation?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.0.610.gcefe983a32
cpu: x86_64
built from commit: cefe983a320c03d7843ac78e73bd513a27806845
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-1051-gke #54-Ubuntu SMP Thu Aug 5 18:52:13 UTC 2021
x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
