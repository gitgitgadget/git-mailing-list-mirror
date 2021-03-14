Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC9C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 01:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6726E64ECE
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 01:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhCNBcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 20:32:50 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:38791 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhCNBc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 20:32:27 -0500
Received: by mail-ej1-f49.google.com with SMTP id mj10so60512805ejb.5
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 17:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2DzFi1DMx+AOVtxVDGTfH3d+Ij+Z2ndcL4ncNLYL8g=;
        b=hd5Cdf70OXOnPxX24G0ykVYSzAjJUgV97VvioBk1z48FbE6S2aWlZPTjedh9XUO/hP
         WhaDQouvzgnaJY1p2f+tUSLKaO0VL5PxGGBfNBF6kGyaYV68ty5QYCxGP30uNU1fO8sb
         1nM63TIKRjNx+UZLdNpBuPTGyVeB+VCfhRXt3pC+H9GiNTZFt2YGkmqZt9rvP0J9+AeP
         TRuBk9TNAcEYHP/K+QC6vJeXVzLG2NLTCX1x1p+7NjWu3rG5ngbMW9VBe/iW0iHR3cPF
         HMSpGLsIRqjX222SVBGHZdbSB2yWAtl3bfOQEf1/vkX0ni6JVl5AUJgqLGEpGwmrF2al
         WZcA==
X-Gm-Message-State: AOAM530F3FJvfYVFFp6c29nF/KCUbGM4xrDwxzu/XBSqrzsYyG7WDIX0
        Cw2e4UP9Z1Rew/YXVvAboUsfCakYZ4esCb/B678=
X-Google-Smtp-Source: ABdhPJyPYeJBKQivAAOzY41RAReKBkUTD4FFsO2LIA+vGffzvT6LeOmezFyi1FTDTm62+rwmRSh6p8nL4XBcLGckwn4=
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr16802623ejc.231.1615685546542;
 Sat, 13 Mar 2021 17:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20210310194306.32565-1-charvi077@gmail.com> <20210313134012.20658-3-charvi077@gmail.com>
In-Reply-To: <20210313134012.20658-3-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 13 Mar 2021 20:32:15 -0500
Message-ID: <CAPig+cQVcTFmafeGo-BbugzOHCEcrEe8O24Jkcu+k=7QFQ4tAg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 13, 2021 at 8:42 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> `git commit --fixup=amend:<commit>` will create an "amend!" commit.
> The resulting commit message subject will be "amend! ..." where
> "..." is the subject line of <commit> and the initial message
> body will be <commit>'s message.
>
> The "amend!" commit when rebased with --autosquash will fixup the
> contents and replace the commit message of <commit> with the
> "amend!" commit's message body.
>
> In order to prevent rebase from creating commits with an empty
> message we refuse to create an "amend!" commit if commit message
> body is empty.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1152,6 +1188,12 @@ static void finalize_deferred_config(struct wt_status *s)
> +/* returns the length of intial segment of alpha characters only */
> +static size_t skip_suboption(char *fixup_message) {
> +       const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
> +       return strspn(fixup_message, alphas);
> +}

With the function name change, the comment above the function has
become outdated. Instead, it should instead explain the function's
purpose at a high-level (not at the low-level of skipping over
alpha-only characters -- especially since the alpha-only restriction
may change in the future). By high-level, I mean talking about
skipping past a token which is likely to be a --fixup suboption, and
giving the reason why the set of characters which comprise the token
is limited (perhaps citing the example Junio had given earlier in
which the code should not mistakenly scan too far to a legitimate ":"
in <commit>).

> @@ -1227,6 +1269,34 @@ static int parse_and_validate_options(int argc, const char *argv[],
> +       if (fixup_message) {
> +               /*
> +                * We limit --fixup's suboptions to only alpha characters.
> +                * If the first character after a run of alpha is colon,
> +                * then the part before the colon may be a known suboption
> +                * name `amend` or a misspelt suboption name. In this case,
> +                * we treat it as --fixup=<suboption>:<arg>.
> +                *
> +                * Otherwise, we are dealing with --fixup=<commit>.
> +                */

This comment is also now out of date following the function name
change. It no longer makes sense for this comment to talk about
skipping alpha-only characters; it should be written at a semantically
higher level, talking instead about skipping the suboption prefix (or
something) since that's what the function call is all about.

> +               size_t len = skip_suboption(fixup_message);
> +               if (len && fixup_message[len] == ':') {
> +                       fixup_message[len++] = '\0';
> +                       fixup_commit = fixup_message + len;
> +                       if (!strcmp("amend", fixup_message)) {
> +                               fixup_prefix = "amend";
> +                               allow_empty = 1;
> +                       } else {
> +                               die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
> +                       }

These are quite minor issues, not necessarily worth a re-roll. (It
might be perfectly fine to send a patch later on which addresses these
issues.)
