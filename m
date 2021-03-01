Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC56C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD9B6024A
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbhCAXci (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:32:38 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:36224 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbhCAWhh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:37:37 -0500
Received: by mail-ej1-f53.google.com with SMTP id do6so31413773ejc.3
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 14:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQPjiMYJSPNL0hHKnTCN2RlzuZmaKCpPJzXDN4Zrny8=;
        b=DkECLTTP6pMRoEbMj8QPrwPUqOdDAIvb2eR8/tffi86SpDHHCre8dLn4D3p+KqaTlX
         wtKW2Fefj9ca4qpZfhrPHZm9RcskBZurEysmnTWWTMeIGX0Kd+AiHfRXQ9bl6vssfQRR
         yvOEy1Uf6mtamUoUyj2XtMucQlzPh1IOdyqR1/IJHJKFYLgQNKv44/rw5biutXFEn3CI
         Ssqt03gjvAu5ePFZnvOHGdyQ2bsRBPrcZyI3T0ZxphCD5Baw3LyvUY/rek59RT+h/AwJ
         ZyJ0MgkDIA1m3UpxPzJLIbEvXdZlCOL+37H9481w+kqLc2oPp5Tj032giwzsA8IwruqS
         JO9w==
X-Gm-Message-State: AOAM531wsxdal949UznKBmDXrgI02anUBntKR4yU6f5pZrIPw2tL18FC
        mt9hHgg7GLEBUBaBslLRAfSVP5NumXi153sogVs=
X-Google-Smtp-Source: ABdhPJy9EEToEt3T7b5Fdl1nwRqefWvCdAXkmXcJ9o6ZFdb/UKg8AIQCIjooX4k0fGjVQx4c0mbABFDxUuZjC+3VfLI=
X-Received: by 2002:a17:906:ca58:: with SMTP id jx24mr18088599ejb.482.1614638214782;
 Mon, 01 Mar 2021 14:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-4-charvi077@gmail.com>
In-Reply-To: <20210301084512.27170-4-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Mar 2021 17:36:44 -0500
Message-ID: <CAPig+cQR2ibdc1CQdwWKdk=mZM4FyaMsfw2Mpgk7Rdc-1R4PRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] commit: add a reword suboption to --fixup
To:     20210217072904.16257-1-charvi077@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> `git commit --fixup=reword:<commit>` creates an empty "amend!" commit
> that will reword <commit> without changing its contents when it is
> rebased with --autosquash.
>
> Apart from ignoring staged changes it works similarly to
> `--fixup=amend:<commit>`.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1186,6 +1186,27 @@ static void finalize_deferred_config(struct wt_status *s)
> +static void check_fixup_reword_options(int argc, const char *argv[]) {
> +       if (whence != FROM_COMMIT) {
> +               if (whence == FROM_MERGE)
> +                       die(_("You are in the middle of a merge -- cannot reword."));
> +               else if (is_from_cherry_pick(whence))
> +                       die(_("You are in the middle of a cherry-pick -- cannot reword."));
> +       }
> +       if (argc)
> +               die(_("cannot combine reword option of --fixup with path %s"), *argv);
> +       if (patch_interactive)
> +               die(_("cannot combine reword option of --fixup with --patch"));
> +       if (interactive)
> +               die(_("cannot combine reword option of --fixup with --interactive"));
> +       if (all)
> +               die(_("cannot combine reword option of --fixup with --all"));
> +       if (also)
> +               die(_("cannot combine reword option of --fixup with --include"));
> +       if (only)
> +               die(_("cannot combine reword option of --fixup with --only"));
> +}

Or, more concisely:

    if (argc)
        die(_("--fixup mutually exclusive with path '%s'), ...);
    if (patch_interactive || interactive || all || also || only)
        die(_("--fixup mutually exclusive with
--patch/--interactive/--all/--include/--only);

The mix of two different error message styles (capitalized with
full-stop vs. lowercase no-full-stop) is a bit jarring, but minor.

Not worth re-roll.
