Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDEC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 04:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiGAE15 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 1 Jul 2022 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAE1v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 00:27:51 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C5396BE
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:27:49 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v38so2061114ybi.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O86vVmx/yBpMgh75GMamDZYxn7iNJRyY58piw7tfcJs=;
        b=lP6S9y0htUX9hCOO5qXusuHYUER4KE9RJTmkkS3pU3AhUI2L7z8lGNrK7HfedzNT9k
         xAwYYoEvLvaCnCg7Yim7JHkPFKJOQyeuGEZ6C2SrYFU9MCryKgm41SB3BxVctbkgmXDZ
         uMSPYb7IZl/qfSX7FtMblfta8xLh4Ce3pRkkvsRsrbpXP8aqTc9VmRB/+mfIs17YNofY
         AlpoUqHrOwhKE4B83t5ip+MReMNC1jiUGaV/F9p5Da8ha6U/ymwQ32ud9eKI4Z08FIqa
         xuZqaQfrvv3/cUFPMilDEPwz1LJWerj85xrhvdpTDcPHNz9T2JOYGVIzIVtU5OcCyAFy
         3g9g==
X-Gm-Message-State: AJIora8w2fhQrrZeYNaElAvfYw71Iw3JzUhuPDfClHfLWwmin7vMiVPt
        3TnAlMFezS/8OrX/wztIqFkr6DcRnTUzBS8WmDk=
X-Google-Smtp-Source: AGRyM1tFn0R8nilXhBnfKe8wHcoTgvUB/mJCxxSHGLhJWNF+HZ9ksy5cKQQUlcW+n3PpW1q6S3EGlIAkjV2GgtXC1o0=
X-Received: by 2002:a5b:982:0:b0:63e:7d7e:e2f2 with SMTP id
 c2-20020a5b0982000000b0063e7d7ee2f2mr13234432ybq.549.1656649669057; Thu, 30
 Jun 2022 21:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <patch-2.9-06b2dcf4f12-20220630T180129Z-avarab@gmail.com>
In-Reply-To: <patch-2.9-06b2dcf4f12-20220630T180129Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jul 2022 00:27:38 -0400
Message-ID: <CAPig+cT5jETAi5extz2tHwSzp4a=b7qqaK0S=mcjQr1m_1jAQQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] test-tool path-utils: fix a memory leak
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 7:51 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Fix a memory leak in "test-tool path-utils", as a result we can mark
> the corresponding test as passing with SANITIZE=leak using
> "TEST_PASSES_SANITIZE_LEAK=true".
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> @@ -294,11 +294,13 @@ static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
>  int cmd__path_utils(int argc, const char **argv)
>  {
>         if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
> -               char *buf = xmallocz(strlen(argv[2]));
> +               char *to_free = NULL;
> +               char *buf = to_free = xmallocz(strlen(argv[2]));

Is there a non-obvious reason that `to_free` is initialized to NULL
before being immediately overwritten with the result of xmallocz()?

Also, pure nit, but it may be a bit more idiomatic (though I could be
wrong) written as:

    char *buf, *to_free;
    buf = to_free = xmallocz(...);
