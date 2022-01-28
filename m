Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F644C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbiA1BQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:16:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbiA1BQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:16:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBDE2177C0C;
        Thu, 27 Jan 2022 20:16:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jnfLoQmHfuKkcfptXVCrfz02hko6r27Dp/slCA
        WX0Gw=; b=Lnibj1XV52ytZncmddr/szSoslOXuVmAjlxFxEDqWTFxJcmC9WyKE8
        6mKpk+ws3GQZOLAR8DFuWvUH2tQaN5WiLHl8HRHTCnzt+8PNyhsCI/rZJyQMkh7V
        qRNeFYFpLHNjwzzjhmlc5iNS/UNQQ1d2FYFR0szPcBlixl7OJoZCQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3AC6177C0A;
        Thu, 27 Jan 2022 20:16:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 410B9177C06;
        Thu, 27 Jan 2022 20:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] diff-filter: be more careful when looking for
 negative bits
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
        <b041d2b7a3bd4433e86438cddbd52857e5f375a6.1643310510.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 17:16:46 -0800
In-Reply-To: <b041d2b7a3bd4433e86438cddbd52857e5f375a6.1643310510.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 27 Jan 2022
        19:08:29 +0000")
Message-ID: <xmqq35l8zmkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F68D791C-7FD7-11EC-983F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/diff.c b/diff.c
> index 5081052c431..4ab4299b817 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4720,6 +4720,12 @@ void diff_setup_done(struct diff_options *options)
>  	if (!options->use_color || external_diff())
>  		options->color_moved = 0;
>  
> +	if (options->filter_not) {
> +		if (!options->filter)
> +			options->filter = ~filter_bit[DIFF_STATUS_FILTER_AON];

Unlike the original, options->filter will have excess higher bit all
on, in addition to all the filter bits except for the all-or-none
bit.  I do not know offhand if that makes the difference, but I
trust that you have audited all uses of the options->filter flag
word and these high bits are truly unused and the difference does
not matter.

> +		options->filter &= ~options->filter_not;
> +	}

>  	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
>  		unsigned int bit;
>  		int negate;
> @@ -4851,7 +4842,7 @@ static int diff_opt_diff_filter(const struct option *option,
>  			return error(_("unknown change class '%c' in --diff-filter=%s"),
>  				     optarg[i], optarg);
>  		if (negate)
> -			opt->filter &= ~bit;
> +			opt->filter_not |= bit;
>  		else
>  			opt->filter |= bit;
>  	}

And this ... 

> diff --git a/diff.h b/diff.h
> index 8ba85c5e605..a70e7c478c1 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -283,7 +283,7 @@ struct diff_options {
>  	struct diff_flags flags;
>  
>  	/* diff-filter bits */
> -	unsigned int filter;
> +	unsigned int filter, filter_not;

... is exactly I wrote in the NEEDSWORK comment I gave you in my
earlier review.  Excellent.

> +test_expect_success 'multiple --diff-filter bits' '
> +
> +	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
> +	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
> +	test_cmp expect actual &&
> +	git log -M --pretty="format:%s" --diff-filter=aR HEAD >actual &&
> +	test_cmp expect actual &&
> +	git log -M --pretty="format:%s" \
> +		--diff-filter=a --diff-filter=R HEAD >actual &&
> +	test_cmp expect actual
> +
> +'

Good.

Thanks for noticing and fixing the long-standing issue.
