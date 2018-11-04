Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937B01F453
	for <e@80x24.org>; Sun,  4 Nov 2018 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387393AbeKEDah (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 22:30:37 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:46228 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeKEDah (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 22:30:37 -0500
Received: by mail-qk1-f173.google.com with SMTP id q1so11112103qkf.13
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 10:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HT0exxToNIikEUJ4+hKIlIsFSRgxcUH637NT2rdpJ4o=;
        b=YHGJMYIyDW/yyLdJKq8MrQ1dzpTcL+6iczeoElAzPtGT9ow8nBLzhIdbiWfVwcz5ti
         O8iYcBTxWf3TqhVesZP9QiZJ99k/f5SveCg7yCpRV6FyqfAP/5aCdCmBizfWhlLT8J29
         nUdDq2dRufqPS7CYXckUdUcosZonjx8rNex8LX7GxA4BRm7KhaNcrDM4auGdJat7pjSO
         GLzFPhxlprc3MTG84phomYYBtSIbAqGWKJYIFKlk09kN8AcjCh3EbTKboS5BvWhBZm5b
         Yn2DxmorooSv+kh1leqJvXXDJoVp06KYx9QUETi0T/WrlsGLqxMIajb9hpuxMWR2jKtO
         d23g==
X-Gm-Message-State: AGRZ1gIbN86KUIikcLk3K5PM4AIBpIoVbQeRZtNlnFdyUs8BwQt/q1Iq
        6pkYKkux0tOZTkn64mVfi85fDhPBwb3THS/FLdU=
X-Google-Smtp-Source: AJdET5cq5ZaKjU0KFQ+VbVSgN/jMTo2dpwGGvkJuTmIf+cavu306ubTlt8rO6UjD0l4nPnWrGnP0CAABM2CstBEMOWk=
X-Received: by 2002:ac8:2a97:: with SMTP id b23-v6mr18802169qta.110.1541355285894;
 Sun, 04 Nov 2018 10:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu>
 <20181104152232.20671-3-anders@0x63.nu>
In-Reply-To: <20181104152232.20671-3-anders@0x63.nu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Nov 2018 13:14:34 -0500
Message-ID: <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pretty: allow showing specific trailers
To:     anders@0x63.nu
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 10:24 AM Anders Waldenborg <anders@0x63.nu> wrote:
> Adds a new "key=X" option to "%(trailers)" which will cause it to only
> print trailers lines which matches the specified key.
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
> ---
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> @@ -209,11 +209,14 @@ endif::git-rev-list[]
>  - %(trailers[:options]): display the trailers of the body as interpreted
>    by linkgit:git-interpret-trailers[1]. The `trailers` string may be
> +  followed by a colon and zero or more comma-separated options. The
> +  allowed options are `only` which omits non-trailer lines from the
> +  trailer block, `unfold` to make it behave as if interpret-trailer's
> +  `--unfold` option was given, and `key=T` to only show trailers with
> +  specified key (matching is done
> +  case-insensitively).

Does the user have to include the colon when specifying <val> of
'key=<val>'? I can see from peeking at the implementation that the
colon must not be used, but this should be documented. Should the code
tolerate a trailing colon? (Genuine question; it's easy to do and
would be more user-friendly.)

Does 'key=<val>', do a full or partial match on trailers? And, if
partial, is the match anchored at the start or can it match anywhere
in the trailer key? I see from the implementation that it does a full
match, but this behavior should be documented.

What happens if 'key=...' is specified multiple times? Are the
multiple keys conjunctive? Disjunctive? Last-wins? I can see from the
implementation that it is last-wins, but this behavior should be
documented. (I wonder how painful it will be for people who want to
match multiple keys. This doesn't have to be answered yet, as the
behavior can always be loosened later to allow multiple-key matching
since the current syntax does not disallow such expansion.)

Thinking further on the last two points, should <val> be a regular expression?

> +  shows all trailer lines, `%(trailers:key=Reviewed-by,unfold)`
> +  unfolds and shows trailer lines with key `Reviewed-by`.
> diff --git a/pretty.c b/pretty.c
> @@ -1323,7 +1323,19 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
> +                                       opts.filter_key = xstrndup(arg, end - arg);
> @@ -1331,6 +1343,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>                         format_trailers_from_commit(sb, msg + c->subject_off, &opts);
>                 }
> +               free(opts.filter_key);

If I understand correctly, this is making a copy of <val> so that it
will be NUL-terminated since the code added to trailer.c uses a simple
strcasecmp() to match it. Would it make sense to avoid the copy by
adding fields 'opts.filter_key' and 'opts.filter_key_len' and using
strncasecmp() instead? (Genuine question; not necessarily a request
for change.)

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> @@ -598,6 +598,51 @@ test_expect_success ':only and :unfold work together' '
> +test_expect_success 'pretty format %(trailers:key=foo) shows that trailer' '
> +       git log --no-walk --pretty="%(trailers:key=Acked-by)" >actual &&
> +       {
> +               echo "Acked-by: A U Thor <author@example.com>" &&
> +               echo
> +       } >expect &&
> +       test_cmp expect actual
> +'

I guess these new tests are modeled after one or two existing tests
which use a series of 'echo' statements, but an alternative would be:

    cat <<-\EOF >expect &&
    Acked-by: A U Thor <author@example.com>

    EOF

or, even:

    test_write_lines "Acked-by: A U Thor <author@example.com>" "" &&

though, that's probably less readable.
