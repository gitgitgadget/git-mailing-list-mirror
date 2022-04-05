Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B1C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 03:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiDEDKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 23:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiDEDKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 23:10:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF17424B1
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 19:53:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id br1so3229471qvb.4
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=7jQbrw6lSnlfMZgouicCu5tIVGtZ9djjfnQ2J94g8jc=;
        b=hXuKiUfW0PhGYv4ygTMnf630lBdO6J+ChRsZunjuWExGJImAC4n55MKyRj0s67ZBKv
         uavVnHPl69UoD4hhbmceOUd5cg7jcG3mM2px+MmxF9ZPS5tPjr/VqL2sy/P8bBfgaz7y
         HnuV2dXebZxW90FG2OhTU60rgrPTq0FVG9Ix8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7jQbrw6lSnlfMZgouicCu5tIVGtZ9djjfnQ2J94g8jc=;
        b=vrolf+ZcO4ncM7T1jwvJNCgSg1mbaLgByifLceWnpKcWQWwrqLmjPXnYZf0YedY7lg
         lNjqXhyoS8cKWiRk3+naihhBoIOkpepDzUY43X/F2t+synSY0194GPU2NbRhmGBNT+V2
         ZzZw/mZQyyUagWbKtseOjGHW6fIKFb9WZlQxbUEDPt+tOLHZw+o7fdluZjaQGiBrozFB
         PL1qgoK2Rj7fERWRu9e6bq3l3CXiYHKMfuQQw5m9/5g1s8fy9hpcnJkrGWhDU7QeDm3D
         ex3dEQGUCAwPoZ5BzJWdAi8vjXl9upg5Euhl4zBIl3S9wcr6A5ddW39qdsZs4ksDje/M
         srPg==
X-Gm-Message-State: AOAM531KQ5jvnveRoOHd4Uv1ft9M2AVREabKcdim/V70E/t/SzElL7/w
        25uLsDjRPGk7c9bzZspgVmgFeaaBFQrpIov+g9Rt3k8DiKk=
X-Google-Smtp-Source: ABdhPJxysvBOKSv7cvs7XnA638mkO4WHqh6UzC/HrlTIdQowG+5iP2HzlKwtI+VdNTydlI8sgZY4tikew5Yi9b+d5WY=
X-Received: by 2002:a05:6214:c85:b0:441:2bb9:92fa with SMTP id
 r5-20020a0562140c8500b004412bb992famr920790qvr.21.1649127219559; Mon, 04 Apr
 2022 19:53:39 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 5 Apr 2022 02:53:28 +0000
Message-ID: <CACPK8Xdkd6XPCG2fd3p7qMAOoErg2oeHhXa+29nBTc0EzGTvow@mail.gmail.com>
Subject: bug report: git aborted after ctrl+c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I managed to crash git with ctrl+c. I suspect this is because I caught
it in malloc, which aborted. If that's the case then it might not be
interesting for git developers, but I include the bug report here for
completeness.

I performed a clone, using an existing clone as a reference. I then pressed
ctrl+c a second or so later:

$ git clone --reference linus https://github.com/shenki/linux shenki
^Cgit: malloc.c:2517: sysmalloc: Assertion `(old_top == initial_top (av) &&
old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse
(old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
Aborted (core dumped)

There was a directory created, but I removed it before thinking it
might be interesting to keep around.

Unfortunately systemd ate the core dump, as I can't find it on my system.

coredumpctl dump 1916302
[sudo] password for joel:
           PID: 1916302 (git)
           UID: 1007 (joel)
           GID: 1007 (joel)
        Signal: 6 (ABRT)
     Timestamp: Mon 2022-04-04 20:23:11 EDT (2h 22min ago)
  Command Line: git clone --reference linus
https://github.com/shenki/linux shenki
    Executable: /usr/bin/git
 Control Group: /user.slice/user-1007.slice/session-849.scope
          Unit: session-849.scope
         Slice: user-1007.slice
       Session: 849
     Owner UID: 1007 (joel)
       Boot ID: ad25355486094e3d986595692797a966
    Machine ID: af0681c1d3194b8a9f9e1dd4c056ec09
      Hostname: kal1
       Storage: none
       Message: Process 1916302 (git) of user 1007 dumped core.
Coredump entry has no core attached (neither internally in the journal
nor externally on disk).

[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.0-1.6.1.el9.x86_64 #1 SMP Mon Oct 4 14:14:47 EDT 2021 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash
