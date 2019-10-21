Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99EC21F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 08:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJUIv4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 04:51:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63217 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUIv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 04:51:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EED0B2199C;
        Mon, 21 Oct 2019 04:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wnWamjQh8KKI+XbDHOTcu5gbMzc=; b=dRZSCD
        zsvCTJ3fNaTcbqUbT4mSWfbR5N2IDMGFh3vdOtF8rMnx0Ew/9TLhELRhvfw9HqY0
        puqs1gMxiFUxUVaF+P9K/twrZbtQ2nLRDrRQ9+dnubgD6cxbUHbUuzYeOaa9536A
        svk861Q/psCQ8n1fh1tCw8Y77R726FvaJ/tZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=edkBizJ/ps4NiFLDv/UJgUqEoGTHVCcP
        f/Z6Qi+Ga+JL7lyP5DvIlVlgFO7AMIc165JLckGjAvlk3/d2vwAPbn3IqMlbVPg7
        CKs5xi0J/ZM74QuuWsQCUIEa+rEg8OIpk57M2WC3lpvA6h2rW2kAzVBF6yYLL4fb
        NqJdAQoyr28=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5D502199B;
        Mon, 21 Oct 2019 04:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 521BA2199A;
        Mon, 21 Oct 2019 04:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
        <20190731071755.GF4545@pobox.com>
        <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
        <20191019233706.GM29845@szeder.dev>
        <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
        <20191021032144.GB13083@sigill.intra.peff.net>
Date:   Mon, 21 Oct 2019 17:51:52 +0900
In-Reply-To: <20191021032144.GB13083@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 20 Oct 2019 23:21:44 -0400")
Message-ID: <xmqqftjmlbvb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0761CFDA-F3E0-11E9-BEAC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered if we could be a bit more clever with the definition of
> "struct option". Something like:
>
> diff --git a/parse-options.h b/parse-options.h
> index 38a33a087e..99c7ff466d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -126,7 +126,10 @@ struct option {
>  	enum parse_opt_type type;
>  	int short_name;
>  	const char *long_name;
> -	void *value;
> +	union {
> +		int *intp;
> +		const char *strp;
> +	} value;
>  	const char *argh;
>  	const char *help;
>  
>
> which would let the compiler complain about the type mismatch (of course
> it can't help you if you assign to "intp" while trying to parse a
> string).
>
> Initializing the union from a compound literal becomes more painful,
> but:
>
>   1. That's mostly hidden behind OPT_INTEGER(), etc.
>
>   2. I think we're OK with named initializers these days. I.e., I think:
>
>         { OPTION_INTEGER, 'f', "--foo", { .intp = &foo } }
>
>      would work OK.

The side that actually use .vale would need to change for obvious
reasons, which may be painful, but I agree it would have easily
prevented the regression from happening in the first place.

Thanks for a food for thought.
