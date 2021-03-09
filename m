Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBCC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A3F64F8E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 09:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhCIJAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:00:49 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36736 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhCIJAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 04:00:22 -0500
Received: by mail-ej1-f42.google.com with SMTP id e19so25916166ejt.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 01:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeQQ9fxBWI+KehS41ARikVIwl1+pRFFBw4mRnR2QNyc=;
        b=XR3Kz6ZbZKbcoVY5b01YzZ3mB3MfihW3W+zERcRlZvWFekOuVOUCamgGONaYhzmFlC
         6EPXMP2/skwrNdBgvWr+VnbyzLeo75pGBmgPQIDcNUNwOU1Bw1o3vtuvyA62zj8ssz0k
         bOJzPNaI2x23j4KKoNhwu1vmVTOGUbvnOxbgZqrGrpxseB56lHq/EciB4fXG2hnymM9l
         e/zuOI8h13F9WeaTrwr5iT/s5KYz7xwg4bQLClK0i2xPmnwcytTevNuf0AZiNGNicQ7+
         II6nxbjGjwd+GdvrWzJoxqhrtn6c6VW0K01FUuRqz7sFZIXs2kHHCuOTX5qhWTaQ/bVb
         VJVQ==
X-Gm-Message-State: AOAM533liMHFdXUYHYIndOyYaMEfve55n1yUEw8AWk5MaCNlXgmxWplz
        qZ0XMaxlhymEnQbpfwy+CVuSBZgvC3bRAi7X1ak=
X-Google-Smtp-Source: ABdhPJw5itomQK2xVZCQtKWaMD+DWZb3CgiDrGtUyJ/gQr2z6X+UfxS4vO03VwC5twQHrLu1/f26WlQm7UHmxY90CVU=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr18407546ejb.311.1615280421019;
 Tue, 09 Mar 2021 01:00:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com> <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
In-Reply-To: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Mar 2021 04:00:10 -0500
Message-ID: <CAPig+cQ6oS8S1-AmRhM=Gb3EQ+7sdQxExoVPCoHKSRFivZq9Vw@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC][RFC] format-patch: pass --left-only to range-diff
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2021 at 3:35 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
> Taylor Blau proposing `git format-patch --cover-letter
> --range-diff` may mistakenly place upstream commit in the
> range-diff output. Teach `format-patch` pass `--left-only`
> to range-diff,can avoid this kind of mistake.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -2085,9 +2089,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>         if (creation_factor < 0)
>                 creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> -       else if (!rdiff_prev)
> -               die(_("--creation-factor requires --range-diff"));
> -
> +       else if (!rdiff_prev) {
> +               if (creation_factor >= 0)
> +                       die(_("--creation-factor requires --range-diff"));
> +               if (left_only)
> +                       die(_("--left-only requires --range-diff"));
> +       }

This logic starts getting difficult to reason about. It would be
easier to understand if written like this:

    if (!rdiff_prev) {
        if (creation_factor >= 0)
            die(_("--creation-factor requires --range-diff"));
        if (left_only)
            die(_("--left-only requires --range-diff"));
    }

    if (creation_factor < 0)
        creation_factor = RANGE_DIFF_..._DEFAULT;

or this (which reduces the indentation a bit):

    if (creation_factor >= 0 && !rdiff_prev)
        die(_("--creation-factor requires --range-diff"));
    if (left_only && !rdiff_prev)
        die(_("--left-only requires --range-diff"));

    if (creation_factor < 0)
        creation_factor = RANGE_DIFF_..._DEFAULT;

Subjective; not necessarily worth a re-roll.

> @@ -2134,7 +2141,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 make_cover_letter(&rev, !!output_directory,
> -                                 origin, nr, list, branch_name, quiet);
> +                                 origin, nr, list, branch_name, quiet,
> +                                       left_only);

Nit: This indentation looks odd. One would expect `origin` and
`left_only` to have the same indentation.

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> @@ -748,4 +748,32 @@ test_expect_success '--left-only/--right-only' '
> +test_expect_success 'format-patch --range-diff --left-only' '
> +       rm -fr repo &&
> +       git init repo &&
> +       ...
> +       ! grep  "> 1: .* feature$"  0000-cover-letter.patch
> +'
> +
> +
>  test_done

Nit: One blank line before test_done() is typical, not two.
