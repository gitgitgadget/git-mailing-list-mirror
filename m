Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D289C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492A023B01
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbhAVUf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:35:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61124 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbhAVUdT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:33:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5FD610FA12;
        Fri, 22 Jan 2021 15:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94VQ4uEyA6SfXShzXczueDhdGR8=; b=RbOfS7
        HaPCrVC/nfZqWwNl719pwSba276Yiwc6MYDox3we64LXZM8keFp0wDfUXqunCPlF
        hTubCYuAk46vJup19GtskM54hBJMI6QweUqy9h+P05DfPVD2Ghmq5hme1pydfKmD
        cTkET/nsFDWi0rWP3UU82PHISHBKIzTGXB1Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fFKvAOvlhUSvvTwrxyXLEqUheWXDBZsf
        7zE57Iip43vWM2ZJqmHqMcUBKHKvQK5a7uz+4Mmg91cVM34JcuWgf6e4P9SmgGf6
        +TopsTWMUFqJmxc7iQmKEoDvHL1kKT9Ab26y4BYIDQQkglbFpln7yjdWA4CzDldl
        bkd8IgVGMQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF3CE10FA11;
        Fri, 22 Jan 2021 15:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13DFF10FA10;
        Fri, 22 Jan 2021 15:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
        <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 12:32:34 -0800
In-Reply-To: <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 22 Jan 2021
        18:16:11 +0000")
Message-ID: <xmqqv9bo7lwd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F669B924-5CF0-11EB-88E7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	i = strlen(range);
> +	c = i > 2 ? range[--i] : 0;
> +	if (c == '!')
> +		i--; /* might be ...^! */
> +	else if (isdigit(c)) {
> +		/* handle ...^-<n> */
> +		while (i > 2 && isdigit(range[--i]))
> +			; /* keep trimming trailing digits */
> +		if (i < 2 || range[i--] != '-')
> +			return 0;
> +	} else
> +		return 0;
> +
> +	/* Before the `!` or the `-<n>`, we expect `<rev>^` */
> +	return i > 0 && range[i] == '^';

This is still way too complex for my liking, but at least I cannot
immediately spot a glaring off-by-one like the previous round ;-)

This is a tangent ([*1*]), but we often equate an omission to
implicitly specified HEAD; e.g. "git log @{u}.." is what we did
since we started building on top of our upstream.  I wonder if it
makes sense to allow similar short-hand so that ^! alone would mean
HEAD^!, ^@ alone would mean HEAD^@, and so on.

Thanks.


[Footnote]

*1* read: this has nothing to do with how ready I think this patch
    is, but the topic reminds me of it strongly enough that I raise
    it here, because I know the opinions on this unrelated thing on
    recipients of this response are worth listening to.

