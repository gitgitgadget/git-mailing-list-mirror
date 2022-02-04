Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98873C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiBDXlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:41:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62723 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBDXlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:41:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60E00175FFA;
        Fri,  4 Feb 2022 18:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JJfKvjlR0dE3
        OpKcQ0plrr7FkbyRjntmKtYC5NlhqxI=; b=UaL6kXf3GpJoaZSycbY7xCV090Xc
        QQuCbEzJHfu3diEvobkRj8s/QCNab7GJTvsOu1frT1aQ7oowMTSD+M3bBssMYBS5
        1S2pJzFOjJt1UMfwOIS/bisfPRH4OJxrJvqoCPIE3aY7AP+G6tYfBy227Q/UNZKn
        FgVrc0si8tnMvYc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59C53175FF9;
        Fri,  4 Feb 2022 18:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B349B175FF7;
        Fri,  4 Feb 2022 18:41:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v10 9/9] grep: simplify config parsing and option parsing
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
        <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
        <patch-v10-9.9-ccbdfa48315-20220204T211534Z-avarab@gmail.com>
Date:   Fri, 04 Feb 2022 15:41:35 -0800
In-Reply-To: <patch-v10-9.9-ccbdfa48315-20220204T211534Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 4 Feb
 2022 22:20:51
        +0100")
Message-ID: <xmqqk0eai4i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE1D6F1A-8613-11EC-A047-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Note that as the previously added tests indicate this cannot be done
> on-the-fly as we see the config variables, without introducing more
> state keeping. I.e. if we see:
>
>     -c grep.extendedRegexp=3Dfalse
>     -c grep.patternType=3Ddefault
>     -c extendedRegexp=3Dtrue
>
> We need to select ERE, since grep.patternType=3Ddefault unselects that
> variable, which normally has higher precedence, but we also need to
> select BRE in cases of:
>
>     -c grep.extendedRegexp=3Dtrue \
>     -c grep.extendedRegexp=3Dfalse
>
> Which would not be the case for this, which select ERE:
>
>     -c grep.patternType=3Dextended \
>     -c grep.extendedRegexp=3Dfalse

I think the latter two examples can lose the backslash at the end
(and all of them can lose "-c").  We can rewrite the preamble of the
first one to clarify what we are trying to say with this notation,
perhaps like

	I.e. if we see these configuration variable definitions in
	this order:

> -static void grep_set_pattern_type_option(enum grep_pattern_type patter=
n_type, struct grep_opt *opt)
> -{
> -	/*
> -	 * When committing to the pattern type by setting the relevant
> -	 * fields in grep_opt it's generally not necessary to zero out
> -	 * the fields we're not choosing, since they won't have been
> -	 * set by anything. The extended_regexp_option field is the
> -	 * only exception to this.
> -	 *
> -	 * This is because in the process of parsing grep.patternType
> -	 * & grep.extendedRegexp we set opt->pattern_type_option and
> -	 * opt->extended_regexp_option, respectively. We then
> -	 * internally use opt->extended_regexp_option to see if we're
> -	 * compiling an ERE. It must be unset if that's not actually
> -	 * the case.
> -	 */
> -	if (pattern_type !=3D GREP_PATTERN_TYPE_ERE &&
> -	    opt->extended_regexp_option)
> -		opt->extended_regexp_option =3D 0;
> -
> -	switch (pattern_type) {
> -	case GREP_PATTERN_TYPE_UNSPECIFIED:
> -		/* fall through */
> -
> -	case GREP_PATTERN_TYPE_BRE:
> -		break;
> -
> -	case GREP_PATTERN_TYPE_ERE:
> -		opt->extended_regexp_option =3D 1;
> -		break;
> -
> -	case GREP_PATTERN_TYPE_FIXED:
> -		opt->fixed =3D 1;
> -		break;
> -
> -	case GREP_PATTERN_TYPE_PCRE:
> -		opt->pcre2 =3D 1;
> -		break;
> -	}
> -}
>
> -void grep_commit_pattern_type(enum grep_pattern_type pattern_type, str=
uct grep_opt *opt)
> -{
> -	if (pattern_type !=3D GREP_PATTERN_TYPE_UNSPECIFIED)
> -		grep_set_pattern_type_option(pattern_type, opt);
> -	else if (opt->pattern_type_option !=3D GREP_PATTERN_TYPE_UNSPECIFIED)
> -		grep_set_pattern_type_option(opt->pattern_type_option, opt);
> -	else if (opt->extended_regexp_option)
> -		/*
> -		 * This branch *must* happen after setting from the
> -		 * opt->pattern_type_option above, we don't want
> -		 * grep.extendedRegexp to override grep.patternType!
> -		 */
> -		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
> -}

It is great that we can lose this, together with the associated
fields like fixed and pcre2.

> @@ -488,11 +432,16 @@ static void compile_regexp(struct grep_pat *p, st=
ruct grep_opt *opt)
>  	int err;
>  	int regflags =3D REG_NEWLINE;
> =20
> +	if (opt->pattern_type_option =3D=3D GREP_PATTERN_TYPE_UNSPECIFIED)
> +		opt->pattern_type_option =3D (opt->extended_regexp_option
> +					    ? GREP_PATTERN_TYPE_ERE
> +					    : GREP_PATTERN_TYPE_BRE);

It is nice that we can forget about .extended_regrexp_option member
after this point, and .pattern_type_option will be the only thing
that matters.

>  	p->word_regexp =3D opt->word_regexp;
>  	p->ignore_case =3D opt->ignore_case;
> -	p->fixed =3D opt->fixed;
> +	p->fixed =3D opt->pattern_type_option =3D=3D GREP_PATTERN_TYPE_FIXED;

This makes readers wonder if we can further lose members in p
(specifically .fixed), but cleaning up the grep_opt members is
already a great progress.

Looking good.  Other than minor tweaks I mentioned on the proposed
log message, I didn't see anything wrong in this version.

Thanks.
