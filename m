Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D121F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcHAVPS (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:15:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751090AbcHAVPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB33A31DA3;
	Mon,  1 Aug 2016 17:00:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbrAWG125yCzgScS//3d12Tc+/M=; b=JIUGgo
	PrSU9Lmr/ykfLAnBzMarOczrgkV2evn+qQ+MJKPhSMQIEluEPTmasgsDPtHd+XvD
	YZMZvo8ERUZ3fQO7xUqOtAgPiTxWLnot2/fY1jXsQPysEnwCk1A664HrmL7jmK3R
	iPSeMPkEsG7rtr8fwW+3vSX266nFj5zxqcZ8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUKsVMi07Xt0VpQVsTxljP0tVVLhJV31
	Rbzv4jTsIM7pQMGBUh3OhJpx8hTCW3/EgG6Ka3jA/2FmIUzLZV3858ZgO7g6c0d9
	LIfTUlguN9hDkV5OoO6cSzeO6yTqFG1Exl3SIEODpXSbGkjRkh0uYBDdkcI8V1pz
	eaTTkO9SON4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3A3231DA2;
	Mon,  1 Aug 2016 17:00:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 609B831DA1;
	Mon,  1 Aug 2016 17:00:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
References: <579CEF77.9070202@web.de>
	<20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 14:00:46 -0700
In-Reply-To: <20160801164723.mober7em6znt56w4@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 12:47:24 -0400")
Message-ID: <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05B669D8-582B-11E6-B599-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -	mx = xcalloc(st_mult(num_create, NUM_CANDIDATE_PER_DST), sizeof(*mx));
>> +	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
>
> I didn't look at all of the calls, but I wonder if it is a natural
> pattern to put the constant second.  

Between

    st_mult(GIT_SHA1_RAWSZ, i)
    st_mult(i, GIT_SHA1_RAWSZ)

the former is more intuitive at least to me [*1*], but calloc(3) disagrees
with me.

> Since multiplication is
> commutative, it would be correct for st_mult() to just flip the order of
> arguments it feeds to unsigned_mult_overflows().
>
> That may introduce the same inefficiency in other callsites, but I
> wonder if it would be fewer.

"git grep -A3 st_mult \*.c" seems to tell me that the callsites with
a constant in their first parameter are the majority (many are
sizeof(something)).  The three places in the patch under discussion
are the only places that got them in the different order.


[Footnote]

*1* I have a slight suspicion that this is cultural, i.e. how
arithmetic is taught in grade schools.  When an apple costs 30 yen
and I have 5 of them, I was taught to multiply 30x5 to arrive at
150, not 5x30=150, and I am guessing that is because the former
matches the natural order of these two numbers (cost, quantity) in
the language I was taught.
