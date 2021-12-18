Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE2BC433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 16:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhLRQrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 11:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLRQrL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 11:47:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9348C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 08:47:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id co15so5158090pjb.2
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wRBI3m0fYcRz8Zvn0vv020spOZa2GiiYii6gKDVwvrM=;
        b=Riz0OheEiLjfATewX8pVS8zhkBgDvILTwL4wPuxfYYowu7vGS6WG5En2v/vbldDfZc
         otYBPIMqlcIno3EIPYwlsejFgf4ipGkKayfNyTG4oYLr68RHomFhIDYr3qU/wjFCVV9/
         S/eb2/PbsEaho8c+1uNsKYcc8FyQOZMhoOR340MT2soluClOH7uL6L8FHVrikdvMqCmu
         NPiAG3PxFoiK+V4XTuK16ANyapqZ4T9hmqz0/bK3marenUJEp8x4O9AGRGlA/r6NcQKr
         /GJWAdORMWBvpR2kq4YfFDrq8XU+3D09b4RoPhN0hn/DVZMdIWsFJNrTLM7QQPlP7Zud
         aZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wRBI3m0fYcRz8Zvn0vv020spOZa2GiiYii6gKDVwvrM=;
        b=hfTnDxRvvaYfQeNw/DUBZH9IbDcMB6pRakEyo0+sZ1WfN3xu9BsCquWH9IGRJdwG6C
         5A3OpMSKt6H5NgUWneUVKWBQ5wke3x0zwcJVgkDWmbQGUxYFHDQY4d1bXPotOsuufkIg
         ZX6JJa/mS7rFVvujAPjQHllNEKIsnLeSbiJp3ZPcr4hB4rNkWC8uTTZqMSGXK3Nzo2ds
         HMQ+9s1vA1uWaIGuximYPuUsu552cR6hoTWl34r745d3yGrbKDMcgwbD5GCzTAvAJaqO
         F25mixbvnrM1u4Ijv6MVGqbYupBlwI4pUr3/GPzqAErIzt1OECfOYQQcXdyJK6cdnmCw
         rwag==
X-Gm-Message-State: AOAM530rZymRAc595B+3lFOXsg7hbRTjZHDrLd2NKpjVzKXfDhVWyc3H
        Mxiu0O1hJMr4aCLQvqvkwWFl92QpK4RuOfymJ9fgPValxeU=
X-Google-Smtp-Source: ABdhPJxQicYz5yR9eTxF6zucr/BjVX1cPTv6QKPA48ahDg9vhn7UqVHkYKaX36pSnuPxS7uLNJY9St6DmreXu6edatA=
X-Received: by 2002:a17:902:e749:b0:148:a4e1:4fb4 with SMTP id
 p9-20020a170902e74900b00148a4e14fb4mr8653259plf.111.1639846029888; Sat, 18
 Dec 2021 08:47:09 -0800 (PST)
MIME-Version: 1.0
From:   Sean Allred <allred.sean@gmail.com>
Date:   Sat, 18 Dec 2021 10:46:58 -0600
Message-ID: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
Subject: Bug report - Can create worktrees from bare repo / such worktrees can
 fool is_bare_repository()
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks! See the following bug report. Let me know if anything is
unclear -- in all honesty, I neglectfully `git worktree remove
--force`'d the first one I wrote...

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

    ~$ git clone --bare https://github.com/git/git.git
    ---clip---

    ~/gitbare$ git config --list --show-origin
    file:config     core.repositoryformatversion=1
    file:config     core.filemode=false
    file:config     core.bare=true
    file:config     core.ignorecase=true
    file:config     remote.origin.url=https://github.com/git/git.git

    ~/gitbare$ git worktree add --no-checkout ../next
    Preparing worktree (checking out 'next')

    ~/gitbare$ git config --list --show-origin
    file:config     core.repositoryformatversion=1
    file:config     core.filemode=false
    file:config     core.bare=true
    file:config     core.ignorecase=true
    file:config     remote.origin.url=https://github.com/git/git.git

    ~/gitbare$ cd ../next/

    ~/next$ git config --list --show-origin
    file:../gitbare/config    core.repositoryformatversion=1
    file:../gitbare/config    core.filemode=false
    file:../gitbare/config    core.bare=true
    file:../gitbare/config    core.ignorecase=true
    file:../gitbare/config    remote.origin.url=https://github.com/git/git.git

    ~/next$ git rev-parse --is-bare-repository
    false

    ~/next$ git config extensions.worktreeconfig true
    ~/next$ git rev-parse --is-bare-repository
    true

    ~/next$ git config --unset extensions.worktreeconfig
    ~/next$ git rev-parse --is-bare-repository
    false

I actually found this situation (and narrowed it to the above) by
trying to perform a sparse-checkout in the worktree.  It appears
sparse-checkout by default uses a worktree-specific config (which
does make sense).

What did you expect to happen? (Expected behavior)

    I expected one of the following to happen:

    1. I should have been blocked from creating a worktree from a bare
    repository.

    2. is_bare_repository() shouldn't be fooled by this situation,
    assuming it's valid.

    All things being equal, I would more expect to have been blocked
    from creating a worktree from a bare repository.  Personally, this
    bare repo + worktree setup doesn't not align with my experience so
    far with how bare repos are normally used (i.e., as a convenience
    for centralized remotes that will never be doing a checkout).

What happened instead? (Actual behavior)

    is_bare_repository() is fooled and I'm prevented from performing
    any operation that requires a worktree (like performing a sparse
    checkout).

What's different between what you expected and what actually happened?

    is_bare_repository() is fooled into thinking the worktree is not a
    worktree / I'm able to create a worktree from a bare repo.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43
UTC 2020 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

Best,
-Sean
