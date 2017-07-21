Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10CAB20288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbdGUQ5O (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:57:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754422AbdGUQ4C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:56:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80517956AE;
        Fri, 21 Jul 2017 12:55:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=czGQKFFTfrIA/3s/tgkxv+0tExY=; b=hC4LKq
        m22fyUgZ8CtLcQUSOqTOiNi9K7XpMs4RITbMl+OhSy/lw0lzHANzXBFlmsFXp6HE
        5l/yGPeEX14lGKxsencq5/4BwyYPsSEITaD71F+bbuxeRW5XFGnW4CgMgo4ilzob
        k9jD9K/Mt8QtppaPSahwDJL6qWzPSBBkN8AZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eIlZdlmHDM/WD4QMVuwwDfBp/QCDu6RU
        3FI5KW0KqJNZ9VEOaNY9Wg4cjyw1Ul81a/asyymyNaMKm0xoDwb31vY5mCFCi8kO
        0x3UUyxP8Yc5yFY9TH4hSfdej+gpgiKGcd9NC+gBVyhYCCg+Y9Gl/wj3TxvMf/QO
        yiz6lRJpMy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78BEB956AD;
        Fri, 21 Jul 2017 12:55:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFA22956AC;
        Fri, 21 Jul 2017 12:55:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Lukas Fleischer <lfleischer@lfos.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] refs: use skip_prefix() in ref_is_hidden()
References: <20170721095757.28373-1-chriscool@tuxfamily.org>
Date:   Fri, 21 Jul 2017 09:55:52 -0700
In-Reply-To: <20170721095757.28373-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 21 Jul 2017 11:57:57 +0200")
Message-ID: <xmqqk231hgpz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 755AD104-6E35-11E7-B3FB-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This saves one line, makes the code a bit easier to understand
> and perhaps a bit faster too.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  refs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ba22f4acef..15cb36d426 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1160,7 +1160,7 @@ int ref_is_hidden(const char *refname, const char *refname_full)
>  		const char *match = hide_refs->items[i].string;
>  		const char *subject;
>  		int neg = 0;
> -		int len;
> +		const char *p;
>  
>  		if (*match == '!') {
>  			neg = 1;
> @@ -1175,10 +1175,9 @@ int ref_is_hidden(const char *refname, const char *refname_full)
>  		}
>  
>  		/* refname can be NULL when namespaces are used. */
> -		if (!subject || !starts_with(subject, match))
> +		if (!subject || !skip_prefix(subject, match, &p))
>  			continue;
> -		len = strlen(match);
> -		if (!subject[len] || subject[len] == '/')
> +		if (!*p || *p == '/')
>  			return !neg;
>  	}
>  	return 0;

If we were to rewrite this using skip_prefix(), I would imagine we
would rather write it this way:

	if (subject &&
	    skip_prefix(subject, match, &p) &&
	    (*p || *p != '/'))
		return !neg;

because it would be shorter and make the logic easier to follow: 

    We make the final decision only when "subject" is there, its
    early part matches "match", and the match is at the slash
    boundary (or the whole thing).

The original wanted to say the same thing, but it had to split that
logic into two only because it needed an assignment to "len" in the
middle, and because doing an assignment inside a conditional part of
if() statement is frowned upon.



