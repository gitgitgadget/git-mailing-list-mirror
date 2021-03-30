Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0FAC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE34D614A7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhC3Xp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:45:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54010 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhC3XpR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:45:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CBB4C1B11;
        Tue, 30 Mar 2021 19:45:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AgapmN0nqMYk
        MLfSVpiKYi2IAZs=; b=TNDOcscKy8s246ifOqj5zOillccHS5J7PAz8rS6meusV
        bEz+fajtTZ1AiXfPkJM+Pg641djd5QTYi7s8WwE3PLdhcs1ax2Esig+G9wjuQ3DN
        yLXOwO3DIQRBr5ubXKBw+kneQvzgOoxlkG0w1Oz643JxauO0+5FbLaLdmOMa0aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pGtYxK
        aWmLuJHKyp/cdCk8YlVR4Wdj942DaLJdPrehOgZEhFxuimSprbdhtJPk8VN/HJAM
        T3MdCl99yz/21tLqjbTCMAgqujLWMG2x07Tx/amtfCs8cKOZHzGOlIRF2zP7ulA1
        dDArWD+M8tu+pucn54vYgwwsyPx/NgTNggKTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 230ABC1B10;
        Tue, 30 Mar 2021 19:45:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90F5BC1B0F;
        Tue, 30 Mar 2021 19:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 14/22] pickaxe: refactor function selection in
 diffcore-pickaxe()
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-15-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:45:15 -0700
In-Reply-To: <20210216115801.4773-15-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:53 +0100")
Message-ID: <xmqqr1jw9pf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAB14F38-91B1-11EB-9FF7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	pickaxe_fn fn;
> =20
>  	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
>  		int cflags =3D REG_EXTENDED | REG_NEWLINE;
> @@ -235,6 +236,14 @@ void diffcore_pickaxe(struct diff_options *o)
>  			cflags |=3D REG_ICASE;
>  		regcomp_or_die(&regex, needle, cflags);
>  		regexp =3D &regex;
> +
> +		/* diff.c errors on -G and --pickaxe-regex for us */

I had to read this twice; I am guessing that the comment wants to
say that this if/else if/else cascade is correct because KIND_G and
PICKAXE_REGEX are mutually incompatible (ensured in diff.c).  And I
think that is true (but as I said, I am not sure if we want to cast
in stone that kind-g and regex are mutually exclusive---rather, I'd
want to see them eventually orthogonal).

> +		if (opts & DIFF_PICKAXE_KIND_G)
> +			fn =3D diff_grep;
> +		else if (opts & DIFF_PICKAXE_REGEX)
> +			fn =3D has_changes;
> +		else
> +			BUG("unreachable");
>  	} else if (opts & DIFF_PICKAXE_KIND_S) {
>  		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
>  		    has_non_ascii(needle)) {
> @@ -251,10 +260,14 @@ void diffcore_pickaxe(struct diff_options *o)
>  			kwsincr(kws, needle, strlen(needle));
>  			kwsprep(kws);
>  		}
> +		fn =3D has_changes;
> +	} else if (opts & DIFF_PICKAXE_KIND_OBJFIND) {
> +		fn =3D NULL;

This is the most valuable line in this patch ;-)  It makes tons of sense.

> +	} else {
> +		BUG("unknown pickaxe_opts flag");
>  	}
> =20
> -	pickaxe(&diff_queued_diff, o, regexp, kws,
> -		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
> +	pickaxe(&diff_queued_diff, o, regexp, kws, fn);
> =20
>  	if (regexp)
>  		regfree(regexp);
