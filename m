Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC2FC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiG1X15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiG1X1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:27:54 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387B71731
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:27:53 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j63so5619681ybb.13
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rgVCVE1sm7jav2d1zl0mlQDCjOwDU8niT4W21qrJbMc=;
        b=hqMg2iIR+uzC/S3fPje+XA8m4877rWMlGAM/VDI0pU8p3ZFEV6ICKascWPwl1pZE2r
         aN5ca4TcCenkFHTXWepx6ZiQU3bRFh8I76/IRI0rkx6+iDqw1z3az0cQlzgRGvycSvaG
         dwYcZ9i6cgTj8qCtlioJ10xBuDTXOduLjfl68Z51/QfDFXfC9rDVOg4YF40ldeWC79CR
         YDH30lPUmPO8RxDsVFCNx47rRFvZdLPJM0zvnTGlyE8iUSna9InJGIPL5X0z1EeQOUgF
         tFOOPW/B2avJomHl0hvOeib5Hm0ZaKbhZ2VQ7hM1R32/v+y3YP94TIzsnoWMlVLl3cpr
         ILkA==
X-Gm-Message-State: ACgBeo1s9vKULdl1FNT2Pzx7PTZqpa8wdReyJt74v9I40kOWcgCMg+nw
        xdyjbrPJX9kcG32JxcWtvzTHPknXqREPb7vftJpJ2CV80JA=
X-Google-Smtp-Source: AA6agR4LPaCWBu3im9gjasxC/jiOnUAUTAGTOpm5WcytiQWHb4vcSqZ0AZoupXZL1FlE6y84A6MoPj7Kvq8tgOXV2dM=
X-Received: by 2002:a25:d013:0:b0:671:8628:9753 with SMTP id
 h19-20020a25d013000000b0067186289753mr739909ybg.462.1659050872328; Thu, 28
 Jul 2022 16:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com> <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com>
In-Reply-To: <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Jul 2022 19:27:41 -0400
Message-ID: <CAPig+cSpjchBUMi9qjLTu_3B3BbVDFKueeTKJNOgR4BtA-8arQ@mail.gmail.com>
Subject: Re: [PATCH v2] lstat(mingw): correctly detect ENOTDIR scenarios
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 10:29 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Files' attributes can indicate more than just whether they are files or
> directories. It was reported in Git for Windows that on certain network
> shares, this let to a nasty problem trying to create tags:

s/let/led/

(not worth a re-roll)

>         $ git tag -a -m "automatic tag creation"  test_dir/test_tag
>         fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable to resolve reference 'refs/tags/test_dir/test_tag': Not a directory
>
> Note: This does not necessarily happen with all types of network shares.
> One setup where it _did_ happen is a Windows Server 2019 VM, and as
> hinted in
>
>         http://woshub.com/slow-network-shared-folder-refresh-windows-server/
>
> in the indicated instance the following commands worked around the bug:
>
>         Set-SmbClientConfiguration -DirectoryCacheLifetime 0
>         Set-SmbClientConfiguration -FileInfoCacheLifetime 0
>         Set-SmbClientConfiguration -FileNotFoundCacheLifetime 0
>
> This would impact performance negatively, though, as it essentially
> turns off all caching, therefore we do not want to require users to do
> that just to be able to use Git on Windows.
>
> The underlying bug is in the code added in 4b0abd5c695 (mingw: let
> lstat() fail with errno == ENOTDIR when appropriate, 2016-01-26) that
> emulates the POSIX behavior where `lstat()` should return `ENOENT` if
> the file or directory simply does not exist but could be created, and
> `ENOTDIR` if there is no file or directory nor could there be because a
> leading path already exists and is not a directory.
>
> In that code, the return value of `GetFileAttributesW()` is interpreted
> as an enum value, not as a bit field, so that a perfectly fine leading
> directory can be misdetected as "not a directory".
>
> As a consequence, the `read_refs_internal()` function would return
> `ENOTDIR`, suggesting not only that the tag in the `git tag` invocation
> above does not exist, but that it cannot even be created.
>
> Let's fix the code so that it interprets the return value of the
> `GetFileAtrtibutesW()` call correctly.
>
> This fixes https://github.com/git-for-windows/git/issues/3727
>
> Reported-by: Pierre Garnier <pgarnier@mega.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
