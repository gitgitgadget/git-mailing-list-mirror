Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60BC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiGOI31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiGOI3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 04:29:25 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E284E60E
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:29:23 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id e69so7364032ybh.2
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emOIv8uasUIi53sADKzTaHY+WdQ++xE9/egOMc2WdhA=;
        b=sCFDFA64LgOGFyanGbJ3g2wj8HKnUCTrZLPuR7X/2HDaZop2kpcBIro6UHXvS1tZ4J
         mXCCbXc8yQkPz6/cGfD7dNhgq0qOJiQ7EKp5law8dbKfLqoVPpmiGw08Den07oy1FGel
         pkKK06wrb98SagxSDQht87Wx8OHok+Q4BUkf3Inp8QWmoG5sJrrSyyvsbJrLNwZR+AJt
         W9Wd0m/zBMnyP16DwXW10+1uyh9qgMii+thksfPwut0RmG3TnMtpzj8ICXwrHogXPCam
         9uw9BTJd3p4x38j+mnXBFEHFfN+toP9yewP1Iqoskz1vvTsQSUkoVFwO/iARGUzi/xxl
         y/CA==
X-Gm-Message-State: AJIora+vGylz3JL+oBH2QnbBUvpYneH4mCAsrWYNplC4uXftIj3dAlMV
        0VMlCbAYb1MPUbEvWeBDzieoxP4Pj2hQDCXwFJs=
X-Google-Smtp-Source: AGRyM1vHD5IL0CMoCV6cskmi14P3CIzvuv3CtrSTBD8O2TrUEfkeLW3l64GqX3KqEt+7TzcWtB5qDigm8LYxZiwp6zo=
X-Received: by 2002:a25:2b03:0:b0:664:271f:924 with SMTP id
 r3-20020a252b03000000b00664271f0924mr13174477ybr.211.1657873762486; Fri, 15
 Jul 2022 01:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
In-Reply-To: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jul 2022 04:29:11 -0400
Message-ID: <CAPig+cT17vZcsf2pGQh-S6UjZib3=4Am7RVf=gQq_sDZzKD08w@mail.gmail.com>
Subject: Re: [PATCH] refs: work around network caching on Windows
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pierre Garnier <pgarnier@mega.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 4:18 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Network shares sometimes use aggressive caching, in which case a
> just-created directory might not be immediately visible to Git.
>
> One symptom of this scenario is the following error:
>
>         $ git tag -a -m "automatic tag creation"  test_dir/test_tag
>         fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable to resolve reference 'refs/tags/test_dir/test_tag': Not a directory
>
> Note: This does not necessarily happen in all Windows setups. One setup
> where it _did_ happen is a Windows Server 2019 VM, and as hinted in
>
>         http://woshub.com/slow-network-shared-folder-refresh-windows-server/
>
> the following commands worked around it:
>
>         Set-SmbClientConfiguration -DirectoryCacheLifetime 0
>         Set-SmbClientConfiguration -FileInfoCacheLifetime 0
>         Set-SmbClientConfiguration -FileNotFoundCacheLifetime 0
>
> This would impact performance negatively, though, as it essentially
> turns off all caching, therefore we do not want to require users to do
> that just to be able to use Git on Windows.
>
> The underlying culprit is that `GetFileAttributesExW()` that is called from
> `mingw_lstat()` can raise an error `ERROR_PATH_NOT_FOUND`, which is
> translated to `ENOTDIR`, as opposed to `ENOENT` as expected on Linux.
>
> Therefore, when trying to read a ref, let's allow `ENOTDIR` in addition
> to `ENOENT` to indicate that said ref is missing.
>
> This fixes https://github.com/git-for-windows/git/issues/3727
>
> Signed-off-by: Pierre Garnier <pgarnier@mega.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> @@ -381,7 +381,7 @@ stat_ref:
> -               if (myerr != ENOENT || skip_packed_refs)
> +               if ((myerr != ENOENT && myerr != ENOTDIR) || skip_packed_refs)
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> @@ -480,7 +480,7 @@ static int load_contents(struct snapshot *snapshot)
> -               if (errno == ENOENT) {
> +               if (errno == ENOENT || errno == ENOTDIR) {

The first question which popped into my mind upon reading the patch
was why these changes need to be made to files-backend.c and
packed-backend.c rather than "fixing" mingw_lstat() to return ENOENT
instead of ENOTDIR. Patching mingw_lstat() seems more tractable and
less likely to lead to discovery of other code in the future which
needs to be patched in a similar way to how files-backend.c and
packed-backend.c are being patched here.

Perhaps it's a silly question and the answer is perfectly obvious to
folks directly involved in Git development on Windows, but the commit
message doesn't seem to answer it for people who don't have such
inside knowledge.
