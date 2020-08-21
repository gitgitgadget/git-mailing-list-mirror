Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822BCC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618ED20702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHUQ7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:59:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38984 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgHUQ5K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:57:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id c10so2010238edk.6
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMU7HK7ZpYRIZHEdiWAxzdhbcT4pLalxZ4NIp+jjZ8E=;
        b=KenihLqX7mYA7f8Op6LdYJNPJ9aJ8vLSqbu7qYrNHsiVD6U9XP0i2XMKPVd1yJ+Wf/
         IGm6rge12LriHuNKli6ARQ/FNWJmBNxM0H0LWnNmaFmrmA1JtQutImAqMWcJL5L5kmFf
         YyIy9vtRUD/asiJe5ffn8/yBhBcRKuIgOZseXQ8TQqY2Xd32k6lidyE9kinJShWoszlx
         ryHA/EYcQR+cuXNoVD+KMCCTbAwcRyeaSEkS6fRfbWQJFCfYnfiXNQ0gfnLfh5h9va24
         rNDRl4avq9NI+mmkb61OHh36vTxK9FUL20ZQaoKyOf5WBL5jfe1lOpoIds8YYmhH26os
         NF1A==
X-Gm-Message-State: AOAM533qZbJ0OHvUFR9J7zglO6rREm3/4e2i2eyCjwT94FkE45oDq4Cy
        MXpan89DEERhFFZmlN7wa3ZredpQW2OM6PSAvYMe9EAL7XE=
X-Google-Smtp-Source: ABdhPJwg11+Ex8BdeeqkynNa/73HV9etoji2XJnJj/MAJ1pJ1W/1vYznd5XPKFubwLlK+qm8iOoNobKcDaZMf3UW7fM=
X-Received: by 2002:aa7:d286:: with SMTP id w6mr3712754edq.221.1598029027299;
 Fri, 21 Aug 2020 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
In-Reply-To: <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Aug 2020 12:56:56 -0400
Message-ID: <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 6:11 AM Hariom Verma via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The 'contents' atom does not show any error if used with 'trailers'
> atom and semicolon is missing before trailers arguments.

Do you mean s/semicolon/colon/ ?

> e.g %(contents:trailersonly) works, while it shouldn't.
>
> It is definitely not an expected behavior.
>
> Let's fix this bug.
>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -332,6 +332,22 @@ static int trailers_atom_parser(const struct ref_format *format, struct used_ato
> +static int check_format_field(const char *arg, const char *field, const char **option)
> +{
> +       const char *opt;
> +       if (skip_prefix(arg, field, &opt)) {
> +               if (*opt == '\0') {
> +                       *option = NULL;
> +                       return 1;
> +               }
> +               else if (*opt == ':') {
> +                       *option = opt + 1;
> +                       return 1;
> +               }
> +       }
> +       return 0;
> +}

Not necessarily worth a re-roll, but rather than introducing all the
above new code...

> @@ -345,9 +361,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
> -       else if (skip_prefix(arg, "trailers", &arg)) {
> -               skip_prefix(arg, ":", &arg);
> -               if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
> +       else if (check_format_field(arg, "trailers", &arg)) {
> +               if (trailers_atom_parser(format, atom, arg, err))
>                         return -1;

...an alternative would have been something like:

    else if (!strcmp(arg, "trailers")) {
        if (trailers_atom_parser(format, atom, NULL, err))
            return -1;
    } else if (skip_prefix(arg, "trailers:", &arg)) {
        if (trailers_atom_parser(format, atom, arg, err))
            return -1;
    }

which is quite simple to reason about (though has the cost of a tiny
bit of duplication).

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> @@ -823,6 +823,15 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
> +test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '

s/semicolon/colon/

> +       # error message cannot be checked under i18n

What is this comment about? I realize that you copied it from other
nearby tests, but I find that it muddies rather than clarifies.

> +       cat >expect <<-EOF &&
> +       fatal: unrecognized %(contents) argument: trailersonly
> +       EOF
> +       test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
> +       test_i18ncmp expect actual
> +'
