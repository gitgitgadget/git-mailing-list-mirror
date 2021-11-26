Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B56C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 13:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346523AbhKZNi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 08:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349761AbhKZNg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 08:36:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D4C061A83
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 04:44:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m24so6625471pls.10
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zgIXurC1iMmcSzLhKT7ZU+wICyWyBkIYZgsGHWG7iXk=;
        b=EnPIZrdtLcTlgMozO3PREb5JN6Mx2fVvF71v13kzNbxiu057h5fWttQvCsKi+K7Dfn
         o+bxvhYnhAIuwjTlLiFLgt5D8vVYOaiEw21bbzAlVbMNNdfoyeybGU98UI544qDb38bx
         AaodMc4zz6uFGUALm3WDO1LoYhPsl6ez1mL7HwJ0uYi/QRwPr3ljiSXjq14FBGQnvfJx
         I7IzGr6VwoKqgCA8FRu++eWuK+ZDkZtbaz3/W+5P1tPPbVneYXVmJ/qhUa4xPE8uue5I
         hMMtTsTvtiC4Oz2etkm8Vr8ltlCOyV1xmvoqRWk5RjcgnlCISRDrQ9uu2zUf6I1iewKF
         LaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zgIXurC1iMmcSzLhKT7ZU+wICyWyBkIYZgsGHWG7iXk=;
        b=wz/KAPdARjBDU0AIUjzi3uPBoxvPVTwtt1FihbX1AK7iMErcmhqq2dC79MqE9JLqGv
         459NNGJlPbq3W/a3HKnlrVFD12PdZ0kshjVDdDVfIRt+Etouy4tUYEOpynBdoSDGd4l2
         crSlalIyNCc2rLXX9/yRowA7OP2xDpyQB2hwmjlaxCGn503+Jr04RBK7vLs6t1KUNpu7
         Roi47wHrcKc+zTy/PXotuZdouiYix5iG/o71MfTKv9rtX8xr9rsBZuzT3ixJ0Oh8gXCG
         6ZWwHpF2b2YtOTxuOtYV+91M41LqE1/8nx62HlNKceQMuBnpFMLqqtahnP1U1ThFFTA7
         OETQ==
X-Gm-Message-State: AOAM532J4XnkznSGm09WEu30xYMEc/THw9Wh/gfxtD2r4q1qPXzeHi4C
        3RjKurNoeFuYKIbb7Tx6AuXHtAbAmg7NFS48kzLwoYZ+vrw=
X-Google-Smtp-Source: ABdhPJwKhbsg4D3Xzt7fuP/fsexbwl7zzo8v7b4OYf0zTFIx0336AwJWIPNFtORQxrFqP9OnQ2KKJUxhNlRpMCnJqTg=
X-Received: by 2002:a17:90a:4d0c:: with SMTP id c12mr15512803pjg.151.1637930674350;
 Fri, 26 Nov 2021 04:44:34 -0800 (PST)
MIME-Version: 1.0
From:   Nikita Bobko <nikitabobko@gmail.com>
Date:   Fri, 26 Nov 2021 13:44:14 +0100
Message-ID: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
Subject: [BUG REPORT] `git rebase --exec` shouldn't run the exec command when
 there is nothing to rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps:
git rebase HEAD --exec "echo foo"

EXPECTED: since 0 commits are going to be rebased then I expect "foo"
NOT to be printed
ACTUAL:   "foo" is printed

A real-world example where such behavior is really unexpected - I have
a script that signs a series of commits like this:
```bash
head="$(git rev-parse HEAD)"

# Generate some commits (in my case it's cherry-picking commits from
public GitHub subtree repo to internal monorepo)

file="$(mktemp)"
git rebase $head --exec "git log -1 --pretty='%B' > $file" \
--exec "echo 'closes
'https://github.com/JetBrains/intellij-community/pull/$1' >> $file" \
--exec "git commit --amend -F $file"
```
But if none of the commits were generated then `git rebase --exec`
will amend the HEAD which is not expected. It means that I have to
process the case when 0 zero commits are generated separately.

If you agree that it's a bug then, most likely, it won't be possible
to fix it because it would break compatibility. Well, yes then this
bug report is JFYI.

[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.98-1-lts #1 SMP Sat, 13 Feb 2021 19:22:14 +0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
