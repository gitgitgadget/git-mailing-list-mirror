Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C1C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335BA60F21
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhG2UNP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 29 Jul 2021 16:13:15 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:38620 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhG2UNP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 16:13:15 -0400
Received: by mail-ej1-f51.google.com with SMTP id nd39so12736139ejc.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 13:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ViyyqrgHgirkBH1oV+mbqFLq6NY4TjFmoyRU4n5ZR0g=;
        b=ZTvTWCuRbAKjmDwrThH09cg7uQyk2faulVpWrJditIFji/IY1f8AbFmFoGeGODO6Mh
         zGNvQBX733JzRx1kA2SL/KFZqw0he6vKAcp690UOJPiMzkgRDRKsM9FbrU5X7iDdVpxi
         4z5cX5S/yRza9E214KrUaaRF6LWBDwFI6XUovhE09xX0FeSNKpu4QESUi6xPh03KpMqW
         26pVCiL9inm3jgTtkT0TUjT5sxCT8SxPFvh3ZYs183sVZ/1MgjrHlkIkr1pfLvxXS94n
         +BxYlzBdW+j77Ve4/qlv/SFhSQjzLjxvzw9kimGAwq0kcPMIdAv2MXsx4IwluOyUXuGx
         Osmw==
X-Gm-Message-State: AOAM531QP7C/3WKgr1Q588K7WgzgrGtCLbSFYq79ypLe4R9IuvXSWNcO
        YAVXo6z6KW9whz5xqdO5/szBTv/vzeA3Y5zc7eY=
X-Google-Smtp-Source: ABdhPJzM3D357o1n95rQ+Crl5zr/sXVt8Y3XBju/96LUAe4ND/cYk74giotC5+JE8gMv9u4M3iT/trJWsvQjuJHLmJs=
X-Received: by 2002:a17:906:eb4c:: with SMTP id mc12mr6057020ejb.311.1627589589561;
 Thu, 29 Jul 2021 13:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Jul 2021 16:12:58 -0400
Message-ID: <CAPig+cR9rb+ydc5age+2FzLtTtXhg1t77p5NrA7bqN0iyU6Kyg@mail.gmail.com>
Subject: Re: [PATCH] mingw: align symlinks-related rmdir() behavior with Linux
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 3:21 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When performing a rebase, rmdir() is called on the folder .git/logs. On
> Unix rmdir() exits without deleting anything in case .git/logs is a
> symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
> and RemoveDirectoryW) do not behave the same and remove the folder if it
> is symlinked even if it is not empty.
>
> This creates issues when folders in .git/ are symlinks which is
> especially the case when git-repo[1] is used.

"issues" is a rather nebulous word. It doesn't help the reader
understand what actually goes wrong. Presumably some step later in the
rebase fails? Or is the problem that subsequent interaction with
git-repo fails because the link which git-repo (presumably) created
disappears out from underneath it?

> This commit updates mingw_rmdir() so that its behavior is the same as
> Linux rmdir() in case of symbolic links.

Okay, makes sense so far as the above explanation goes. But it also
feels like a band-aid fix to support a use-case which only works by
accident on Unix, if I'm reading between the lines correctly. That is,
presumably rmdir(".git/logs") is an intended cleanup action but the
fact that the cleanup doesn't happen as intended when it is a symlink
is not intentional behavior, thus git-repo's reliance upon that
behavior is questionable.

I guess this would also help tools which replace .git/worktrees with a
symlink since git-worktree -- as a cleanup -- removes its
.git/worktrees directory when the last worktree is removed...

> Signed-off-by: Thomas Bétous <tomspycell@gmail.com>
> ---
>  compat/mingw.c    | 15 +++++++++++++++
> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -341,6 +341,21 @@ int mingw_rmdir(const char *pathname)
> +       /*
> +       * Contrary to Linux rmdir(), Windows' _wrmdir() and _rmdir()
> +       * will remove the directory at the path if it is a symbolic link
> +       * which leads to issues when symlinks are used in the .git folder
> +       * (in the context of git-repo for instance). So before calling _wrmdir()
> +       * we first check if the path is a symbolic link. If it is, we exit
> +       * and return the same error as Linux rmdir() in this case (ENOTDIR).
> +       */
> +       if (!mingw_lstat(pathname, &st) && S_ISLNK(st.st_mode)) {
> +               errno = ENOTDIR;
> +               return -1;
> +       }

Unfortunately, this code comment doesn't help future readers
understand when/how this case can be triggered, which means that
anyone working on this code in the future will have to consult the
commit message anyhow in order to obtain the necessary understanding.
This suggests that either the comment should be dropped altogether,
thus forcing the person to consult the commit message (probably
undesirable), or improved to give enough information to understand
when/how it can be triggered.
