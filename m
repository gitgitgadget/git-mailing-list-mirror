Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80FB1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 19:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbcGKTBi (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 15:01:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932489AbcGKTBh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 15:01:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2443F2C21F;
	Mon, 11 Jul 2016 15:01:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJXP2FrInz2JbCvold20kyDFjFU=; b=j/Fdu8
	H0NdjpdkMJyXf5F5cqSyNDaFMmJf3zPy4bhrPZOJhw8efcqdy0g2JA/UEXpUSa2d
	mU60Tfwdi8ra00OZKNlz3Wp8rbNb1xb84g8c8IXdcDkV3yJCrghyZLfrpJ0LRRkV
	4jOWYzw06y9qvm9a5IxQ0bVZ2uq19t/igZbGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bvo8CJL+ksLFKSZCG2gHFLgO2AH73oVH
	5r8/RLml5UPx2HCgucQOmjxhmEU7ru946ShcPk6gl7YXbBkPMLsJQnPEda6s/MOx
	RkRITbdImtXUuXela8Pcf1Z1PLum1x1V74ePNU8HzI44ptgOsBZt2zYfli6Y4Qju
	jy51a4dWPEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B41F2C21E;
	Mon, 11 Jul 2016 15:01:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93CB82C21D;
	Mon, 11 Jul 2016 15:01:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Naja Melan <najamelan@autistici.org>
Subject: Re: [PATCH 2/2] diff: fix a double off-by-one with --ignore-space-at-eol
References: <cover.1468048754.git.johannes.schindelin@gmx.de>
	<daf43539479acdebe1c5799c38f3be75c2399feb.1468048754.git.johannes.schindelin@gmx.de>
Date:	Mon, 11 Jul 2016 12:01:33 -0700
In-Reply-To: <daf43539479acdebe1c5799c38f3be75c2399feb.1468048754.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sat, 9 Jul 2016 09:23:55 +0200
	(CEST)")
Message-ID: <xmqqeg709eya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3A4EB4A-4799-11E6-ACAB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 62cb23d..027192a 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -200,8 +200,10 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  				return 0;
>  		}
>  	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
> -		while (i1 < s1 && i2 < s2 && l1[i1++] == l2[i2++])
> -			; /* keep going */
> +		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
> +			i1++;
> +			i2++;
> +		}
>  	}

When we notice l1[i1] and l2[i2] does not match, we want i1 and i2
to stay pointing at that unmatch.  The code before this fix however
ends up incrementing them before leaving the loop.

This breakage seems to come from 2344d47f (diff: fix 2 whitespace
issues, 2006-10-12)?  That's quite old and it is somewhat surprising
that nobody complained.

Well spotted.  Will queue.

Thanks.



