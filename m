Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8285F20193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933982AbcHDSn7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:43:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753657AbcHDSn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:43:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11B9D328AF;
	Thu,  4 Aug 2016 14:43:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NINr3NRVfzdiqKx0Eyy/CFYqhqQ=; b=eozbW5
	4P6nlD4CWMQCTlqPukRTVclr1iZOf4wUqgrGWF9ld36vVwHWz2FJKOmK5ZxAuHqU
	dl6hWenHKsKF8lXGNBl9Y66cvKGuZ2+mq6lbiK1Bwo6bDC1oif9PcHkcl4GsZa94
	l17utxF45SRxI5TAqRQ5cLDEU2Xjixf2DF1gE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1q5zK2S/X9E7zinb8WnCis4Qq6ohQWG
	+aPKWaxoHFAG0t7hH3BdFg4+hiE/E5CecudZpvNCB2bJZTR7w9h1xDgk9YTSsaPw
	tc8Q5Jhs5Rdo7P5oRzQOC/y639ncHgupF2oz9hBBJmK4vLiFbKjW6u9qoxUAmnkB
	5AmJkRE5WuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08803328AE;
	Thu,  4 Aug 2016 14:43:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F03C328AD;
	Thu,  4 Aug 2016 14:43:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to adjust io
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
Date:	Thu, 04 Aug 2016 11:43:54 -0700
In-Reply-To: <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Thu, 4 Aug 2016 00:00:33 +0200")
Message-ID: <xmqqshuk2x3p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 664B0778-5A73-11E6-8AC7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The code branch used for the compaction heuristic incorrectly forgot to
> keep io in sync while the group was shifted. I think that could have
> led to reading past the end of the rchgo array.

I had to read the first sentence three times as "incorrectly forgot"
was a bit strange thing to say (as if there is a situation where
'forgetting to do' is the correct thing to do, but in that case we
would phrase it to stress that not doing is a deliberate choice,
e.g. 'refraining from doing').  Perhaps s/incorrectly // is the
simplest readability improvement?

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> I didn't actually try to verify the presence of a bug, because it
> seems like more work than worthwhile. But here is my reasoning:
>
> If io is not decremented correctly during one iteration of the outer
> `while` loop, then it will loose sync with the `end` counter. In
> particular it will be too large.
>
> Suppose that the next iterations of the outer `while` loop (i.e.,
> processing the next block of add/delete lines) don't have any sliders.
> Then the `io` counter would be incremented by the number of
> non-changed lines in xdf, which is the same as the number of
> non-changed lines in xdfo that *should have* followed the group that
> experienced the malfunction. But since `io` was too large at the end
> of that iteration, it will be incremented past the end of the
> xdfo->rchg array, and will try to read that memory illegally.

I agree with Peff that these should be in the log message.
