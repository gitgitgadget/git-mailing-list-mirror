Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEDC4167B
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiCIBOM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Mar 2022 20:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiCIBNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:20 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E313113F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 17:02:39 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id k25so1067744iok.8
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 17:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qBzSPDvZQpbzBNK3OQ83JiJ6OR6Ct90UXNLpBLLGaB8=;
        b=j53+ct+cjtvhnPXn89Z6PxhtwnaSDK0xtvrzR4iTEOTkfBlDIY+Gd6mmC9O1yISmcU
         SUVgANCNv8lxV9UNAuXZpuCWMEmehoEMOtMra2EESYOrbgdCcf8d2YCH4SVaYWu0YNt3
         5lueA4xagY7sgqVt2rIsjvHcCWiQH4MSQnM1C2qc+Ueohh+558nB2F6K1dsYUzzvgv8L
         xjCmq/AwJzgP8UdocFMqo1MVP7kAti7E8BPiMYGBS7FhMdbxneJ2MefGHMeL5xvoBIPi
         AfuVxDb26J2KbJisNwugy2hvpNxCFH+RjURslKlG4gbu9jO/dceNyFpB6y2dvfEE6Pei
         764g==
X-Gm-Message-State: AOAM5302GrOtI054mKiCV2bZggbTigPptRvOlg0YGAcjr571alyIT82P
        lbH/cCENbAAKziEhkdXMC9nC7U7a8lbkaSKb8l1zKG7eU5E=
X-Google-Smtp-Source: ABdhPJwWF2AdfGCoM/b8RkiX8JgdsFkQS1yEBS8kuzVZVSoWvgHVPmpGKoYkVVUMOnhP/t2u0CnuUt5zITcY9DOlvUg=
X-Received: by 2002:a63:9245:0:b0:377:7e40:1905 with SMTP id
 s5-20020a639245000000b003777e401905mr15756459pgn.139.1646783770134; Tue, 08
 Mar 2022 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com> <20220308113305.39395-1-carenas@gmail.com>
In-Reply-To: <20220308113305.39395-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Mar 2022 18:55:59 -0500
Message-ID: <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 6:44 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Restrict the glibc version to a single version number and compare it
> arithmetically against the base glibc version to avoid accidentally
> matching against "2.3" and better supporting versions like "2.34.9000"
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> @@ -518,9 +518,9 @@ else
> -               if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> -                  _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> -                  expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +               local _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null)
> +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
> +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'

No need for `cut` since `awk` can accomplish the same by itself.

    if echo "$_GLIBC_VERSION" | awk '/^glibc / { if ($2 - 2.34 < 0) exit 1 }'

should work, I would think.
