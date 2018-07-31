Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9A91F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeGaWDh (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:03:37 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44191 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:03:37 -0400
Received: by mail-yb0-f193.google.com with SMTP id l16-v6so6660786ybk.11
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Aio4/00qHUYysYD7lUcoJq709lL4RQa0fMOnmw2jZ8=;
        b=J1pef4uBrcHYxX4MnoFxER1QEDnF82+hZgUZUHsizYB//NqbEpW7o4wkithUsmQS14
         E0HNCZnfkxGOdFsgC2GY0Sw5w23alf7Bfk1yIAXN6e9pOgaxlqACxD0TC8j0XJ7hYWCG
         dvxAdg7zvWGq7AfsTZrt0iwg2w5kTnHSRarfU/6OxNNE3rA93MPuE5bJcYSyqKhPjADw
         zzjtLaBNAgOYuKHdMCmHf3bSdd7iLgwMfGnlRb8EqD9mSBqELrCp6qLYNponcIdPXeos
         AdNRFLINgkdRoVToSK7SlUnq+PdVuUdTHdTiCtKFHGbUUas/CartjnkH8w0OGBCUivGt
         hagw==
X-Gm-Message-State: AOUpUlG5mLL+G4XgJEzfXETMV0icMVcy08S8V4fBZN05R6yjtqCvlert
        DHrn51JjI+o7HW8VE1XkzjDlgOY9drK8dKwrl7k=
X-Google-Smtp-Source: AAOMgpcn1mUkkAxb74UjXNyW6fKfXopAgohcXLrYO6ODMbiuXIbhOlMmKmveyc4c1w0/FszlC3hVL3f6y6gLqKFJfAM=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr12495623yba.263.1533068495466;
 Tue, 31 Jul 2018 13:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
In-Reply-To: <20180731173651.184716-3-hanwen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 16:21:24 -0400
Message-ID: <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 1:37 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> Highlight keywords in remote sideband output.

Prefix with the module you're touching, don't capitalize, and drop the
period. Perhaps:

    sideband: highlight keywords in remote sideband output

> The highlighting is done on the client-side. Supported keywords are
> "error", "warning", "hint" and "success".
>
> The colorization is controlled with the config setting "color.remote".

What's the motivation for this change? The commit message should say
something about that and give an explanation of why this is done
client-side rather than server-side.

> Co-authored-by: Duy Nguyen <pclouds@gmail.com>

Helped-by: is more typical.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1229,6 +1229,15 @@ color.push::
> +color.remote::
> +       A boolean to enable/disable colored remote output. If unset,
> +       then the value of `color.ui` is used (`auto` by default).

If this is "boolean", what does "auto" mean? Perhaps update the
description to better match other color-related options.

> diff --git a/sideband.c b/sideband.c
> @@ -1,6 +1,97 @@
> +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> +{
> +       int i;
> +
> +       load_sideband_colors();
> +       if (!want_color_stderr(sideband_use_color)) {
> +               strbuf_add(dest, src, n);
> +               return;
> +       }

Can load_sideband_colors() be moved below the !want_color_stderr() conditional?

> +
> +       while (isspace(*src)) {
> +               strbuf_addch(dest, *src);
> +               src++;
> +               n--;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +               struct kwtable* p = keywords + i;
> +               int len = strlen(p->keyword);

Would it make sense to precompute each keyword length so you don't
have to recompute them repeatedly, or is that premature optimization?

> +               if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {

So, the strncasecmp() is checking if one of the recognized keywords is
at the 'src' position, and the !isalnum() ensures that you won't pick
up something of which the keyword is merely a prefix. For instance,
you won't mistakenly highlight "successful". It also works correctly
when 'len' happens to reference the end-of-string NUL. Okay.

> +                       strbuf_addstr(dest, p->color);
> +                       strbuf_add(dest, src, len);
> +                       strbuf_addstr(dest, GIT_COLOR_RESET);
> +                       n -= len;
> +                       src += len;
> +                       break;
> +               }

So, despite the explanation in the commit message, this function isn't
_generally_ highlighting keywords in the sideband. Instead, it is
highlighting a keyword only if it finds it at the start of string
(ignoring whitespace). Perhaps the commit message could be more clear
about that.

A natural follow-on question is whether strings are fed to this
function one line at a time or if the incoming string may have
embedded newlines (in which case, you might need to find a prefix
following a newline, as well?).

> +       }
> +
> +       strbuf_add(dest, src, n);
> +}
