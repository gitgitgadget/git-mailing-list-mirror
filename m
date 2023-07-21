Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84703EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 20:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGUUJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGUUJy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 16:09:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CD359C
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 13:09:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D90242FF90;
        Fri, 21 Jul 2023 16:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a6RGiSHuF4Ue
        VN1qV5MpvjUHaLJWmBTjEq4jkN2FPrk=; b=w7f1scmcpbF5H/0xKUOai6fTTc32
        9fzwOocHS5GRc/ltUICTIbSyupd2Zd+5DSCO7QD3NE+Hxi/zvJrHb/ldYBn1QXTl
        FSoT142BYGgUwN5VC2+9GZcxQCx0pu95ZuJWp5jxtVxyCoG9l2fsL57QaPS2BA2t
        1mFUuKPwDqO+H8A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D08D62FF8F;
        Fri, 21 Jul 2023 16:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 514142FF8E;
        Fri, 21 Jul 2023 16:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
        <xmqq351hz5xp.fsf@gitster.g>
        <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
Date:   Fri, 21 Jul 2023 13:09:45 -0700
In-Reply-To: <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jul 2023 21:29:35 +0200")
Message-ID: <xmqq4jlxuiuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89E38C32-2802-11EE-AE3B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Some test expectations in t0040 and t1502 would have to be adjusted.
>
> This reveals, by the way, that t1502 doesn't yet exercise the "!" flag
> of "git rev-parse --parseopt" that turns on PARSE_OPT_NONEG.  I find
> the "-h, --[no-]help" option strangely amusing..
>
> --- >8 ----
> Subject: [PATCH] parse-options: show negatability of options in short h=
elp
>
> Add a "[no-]" prefix to options without the flag PARSE_OPT_NONEG to
> document the fact that you can negate them.
>
> This looks a bit strange for options that already start with "no-", e.g=
.
> for the option --no-name of git show-branch:
>
>     --[no-]no-name        suppress naming strings
>
> You can actually use --no-no-name as an alias of --name, so the short
> help is not wrong.  If we strip off any of the "no-"s, we lose either
> the ability to see if the remaining one belongs to the documented
> variant or to see if it can be negated.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  parse-options.c               | 10 ++++-
>  t/t0040-parse-options.sh      | 44 ++++++++++---------
>  t/t1502-rev-parse-parseopt.sh | 80 ++++++++++++++++++++---------------
>  3 files changed, 77 insertions(+), 57 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index f8a155ee13..6323ca191d 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1136,8 +1136,14 @@ static enum parse_opt_result usage_with_options_=
internal(struct parse_opt_ctx_t
>  		}
>  		if (opts->long_name && opts->short_name)
>  			pos +=3D fprintf(outfile, ", ");
> -		if (opts->long_name)
> -			pos +=3D fprintf(outfile, "--%s", opts->long_name);
> +		if (opts->long_name) {
> +			const char *long_name =3D opts->long_name;
> +			if (opts->flags & PARSE_OPT_NONEG)
> +				pos +=3D fprintf(outfile, "--%s", long_name);
> +			else
> +				pos +=3D fprintf(outfile, "--[no-]%s", long_name);
> +		}

This is a good starting point, but we should at least exempt
OPT_BOOL from this exercise, I would think, because ...

>      A helper function for the parse-options API.
>
> -    --yes                 get a boolean
> +    --[no-]yes            get a boolean

... they are designed to be prefixed with an optional "no-".


> -    -D, --no-doubt        begins with 'no-'
> +    -D, --[no-]no-doubt   begins with 'no-'

Hmph, I really really loved the neat trick to allow "no-doubt"
option to be "positivised" by _dropping_ the leading "no-" at around
0f1930c5 (parse-options: allow positivation of options starting,
with no-, 2012-02-25).

>  EOF

Many of the above are amusing and served as good demonstration to
show the blast radius, but it seems that most of them should be
marked with PARSE_OPT_NONEG.

> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
.sh
> index dd811b7fb4..0a67e2dd4f 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -64,33 +64,38 @@ test_expect_success 'test --parseopt help output' '
>  |
>  |    some-command does foo and bar!
>  |
> -|    -h, --help            show the help
> -|    --foo                 some nifty option --foo
> -|    --bar ...             some cool option --bar with an argument
> -|    -b, --baz             a short and long option
> +|    -h, --[no-]help       show the help

Indeed it is amusing, but we probably should give PARSE_OPT_NONEG
appropriately, instead of changing the expectations, for many of the
changes we see here, I think.

