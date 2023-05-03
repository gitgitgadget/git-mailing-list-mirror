Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE0C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjECTFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjECTFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:05:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4097D8B
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:05:28 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso8060523276.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683140726; x=1685732726;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3nFWDj95e9FnHi7HAJQYIPQcCNaLbSZIi6gaf7nYRCk=;
        b=ZUeAVsBgxUPMFNADkBDwupLxrpPnIoHYwiFFVwPOcU3AFpaa8hMyrDxy5jTResGLyW
         TPN2y0KIPVkTpqWn2w2CBt0Ssz/OaDJXln418S14mvA4cQgc707otxk+ohdV8H0yfR6h
         GDi5ZXL4SEmizGA10NdXtoZe+Ged6qP7Wijnu1zgk2Ek7RdC1cx+q+NA611ISybrP1yU
         36oVnjhaudCA84iG2i2m7TSzBMAgWytgIB6eAEYToVRgK+wVHoV+4LemRCT7ZBhjSakP
         8kClbTpJv8N+gF7XCfm43WlUd0ddAnUReyU1hEp0j5GovpVaxIo/YQzmQ5ZXYzhopZl4
         VjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683140726; x=1685732726;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nFWDj95e9FnHi7HAJQYIPQcCNaLbSZIi6gaf7nYRCk=;
        b=Qt+90dahr+W1FAYY23a0bGYOR0VQuF/XD6v6ctbfUjuVHuViCmil6mr7lo2vL+gGsw
         sVOPkNLa8WwQqAAva1t7xm0T6Q1sSgqcZaOy3VNJZ7MVn0aMZntGnSdCQd0B7mrmMibW
         W89VChLvxl6RDlOZyHyvwFgHE+8ZqF61cimQlosMwA6MQBlyy6JE2y/Fgsg1s0ee/PfN
         gShhV6/+ghmE3thxT5iY8ugHNyJUzuV0vBiKzt+amTh+J3fLruaJVVeEbq6FpQ9jdvA1
         ZyN5RHuY4trt9NZNmOexBfavKGBk/SS1UPQVpc/CUO2T7iVJNfNF9CuMVsgguiiwBD8V
         O3Fg==
X-Gm-Message-State: AC+VfDwMG9iJUizdV3TleGQqZfhUfUVxcFmVdxxY9fs1A49QyzC58CM1
        rpIqYteTDpk2xFYo0sLlAE6shLtVtXGeDUP+YArR5LyCf1c=
X-Google-Smtp-Source: ACHHUZ5CfK1VDCOJenJ39HhwjOYuP8rFiuVHAxBAxvKPFGjnsv7Gu5Wr3perXaxWKfrk7zWxJEwHQNj8/rRhO+Qa80I=
X-Received: by 2002:a25:6f56:0:b0:b92:4a97:56f with SMTP id
 k83-20020a256f56000000b00b924a97056fmr19755324ybc.14.1683140726339; Wed, 03
 May 2023 12:05:26 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Ushey <kevinushey@gmail.com>
Date:   Wed, 3 May 2023 12:04:47 -0700
Message-ID: <CAJXgQP1j6JYbtikMuWGFn44+FVb3PfmuwiFrxDGLQAYgr92Wfw@mail.gmail.com>
Subject: git grep -E doesn't accept \b word boundaries?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm seeing the following, which I believe is unexpected. I have a file
with contents:

$ cat hello.txt
WholeWord
Whole Word
Whole

I can use `git grep` to search with word boundaries; e.g.

$ git grep --untracked '\bWhole\b'
hello.txt:Whole Word
hello.txt:Whole

However, if I add `-E` to use extended regular expressions, the same
invocation finds no search results.

$ git grep --untracked -E '\bWhole\b'

This does seem to work as expected with the '-w' flag, e.g.

$ git grep --untracked -E -w 'Whole'
hello.txt:Whole Word
hello.txt:Whole

as well as with POSIX word boundaries, e.g.

$ git grep --untracked -E '[[:<:]]Whole[[:>:]]'
hello.txt:Whole Word
hello.txt:Whole

Is this a bug, or am I misunderstanding some behavior in `git grep`?
For posterity:

$ git grep --untracked -G '\bWhole\b'
hello.txt:Whole Word
hello.txt:Whole

$ git grep --untracked -E '\bWhole\b'

$ git grep --untracked -P '\bWhole\b'
hello.txt:Whole Word
hello.txt:Whole

For what it's worth, I don't see this issue with an older version of
`git` on an Ubuntu 22.04 VM:

root@96722b73f316:~/test# git --version
git version 2.34.1
root@96722b73f316:~/test# git grep --untracked -E '\bWhole\b'
hello.txt:Whole Word
hello.txt:Whole

Thanks,
Kevin

------

[System Info]
git version:
git version 2.40.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.4.0 Darwin Kernel Version 22.4.0: Mon Mar  6 20:59:28
PST 2023; root:xnu-8796.101.5~3/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash
