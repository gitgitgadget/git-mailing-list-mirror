Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8109C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C1D6108D
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHRUxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:53:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52774 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRUxv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 16:53:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBFA3D7E8B;
        Wed, 18 Aug 2021 16:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=exl37TfC+XKT
        aYW7dnowP43FFH1jTK4cz1KDhKaOqSY=; b=PIx/EE3hSbL1xt5LXeeWEcFLmCs1
        a+uZfPL7qB+3nAmxz6QcubracNlBBko5fpQwcK/rCjyqpSxSlIyqwN0ZUpgbv81k
        9O4INsbF52cClbE0g6Rzt2udttTLiEI7a7VWPL8hT+Wj1n3yJKi21i2yYZm2l268
        MF+peffZUvU39xo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2D16D7E88;
        Wed, 18 Aug 2021 16:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40585D7E87;
        Wed, 18 Aug 2021 16:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] column: fix parsing of the '--nl' option
References: <20210818092456.3045808-1-szeder.dev@gmail.com>
Date:   Wed, 18 Aug 2021 13:53:14 -0700
In-Reply-To: <20210818092456.3045808-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 18 Aug 2021 11:24:56 +0200")
Message-ID: <xmqqy28y4gqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4EF203B2-0066-11EC-B97B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> 'git column's '--nl' option can be used to specify a "string to be
> printed at the end of each line" (quoting the man page), but this
> option and its mandatory argument has been parsed as OPT_INTEGER since
> the introduction of the command in 7e29b8254f (Add column layout
> skeleton and git-column, 2012-04-21).  Consequently, any non-number
> argument is rejected by parse-options, and any number other than 0
> leads to segfault:
>
>   $ printf "%s\n" one two |git column --mode=3Dplain --nl=3Dfoo
>   error: option `nl' expects a numerical value
>   $ printf "%s\n" one two |git column --mode=3Dplain --nl=3D42
>   Segmentation fault (core dumped)
>   $ printf "%s\n" one two |git column --mode=3Dplain --nl=3D0
>   one
>   two

... and another thing to notice is that number 0 would have meant
"use LF" due to columns.c::print_columns()

	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";

which is the same as the default, so it is not likely that people
have (mistakenly) used to trigger NUL terminated records, or
anything fancy like that.

> Parse this option as OPT_STRING.

So a possible "regression" by this fix could be that those who took
advantage of the fact that --nl=3D0 is an absolute no-op would
suddenly start seeing their output terminated with a digit "0".  I
would have to say that it is not all that likely ;-)

I agree with Dscho's comment on the test script addition, but other
than that this looks good to me.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/git-column.txt |  2 +-
>  builtin/column.c             |  2 +-
>  t/t9002-column.sh            | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-column.txt b/Documentation/git-column.tx=
t
> index f58e9c43e6..6cea9ab463 100644
> --- a/Documentation/git-column.txt
> +++ b/Documentation/git-column.txt
> @@ -39,7 +39,7 @@ OPTIONS
>  --indent=3D<string>::
>  	String to be printed at the beginning of each line.
> =20
> ---nl=3D<N>::
> +--nl=3D<string>::
>  	String to be printed at the end of each line,
>  	including newline character.
> =20
> diff --git a/builtin/column.c b/builtin/column.c
> index 40d4b3bee2..158fdf53d9 100644
> --- a/builtin/column.c
> +++ b/builtin/column.c
> @@ -29,7 +29,7 @@ int cmd_column(int argc, const char **argv, const cha=
r *prefix)
>  		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
>  		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
>  		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding spa=
ce on left border")),
> -		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border"))=
,
> +		OPT_STRING(0, "nl", &copts.nl, N_("string"), N_("padding space on ri=
ght border")),
>  		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between =
columns")),
>  		OPT_END()
>  	};
> diff --git a/t/t9002-column.sh b/t/t9002-column.sh
> index 89983527b6..6d3dbde3fe 100755
> --- a/t/t9002-column.sh
> +++ b/t/t9002-column.sh
> @@ -42,6 +42,24 @@ EOF
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success '--nl' '
> +	cat >expected <<\EOF &&
> +oneZ
> +twoZ
> +threeZ
> +fourZ
> +fiveZ
> +sixZ
> +sevenZ
> +eightZ
> +nineZ
> +tenZ
> +elevenZ
> +EOF
> +	git column --nl=3D"Z$LF" --mode=3Dplain <lista >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success '80 columns' '
>  	cat >expected <<\EOF &&
>  one    two    three  four   five   six    seven  eight  nine   ten    =
eleven
