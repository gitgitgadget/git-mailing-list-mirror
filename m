Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C81B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbcHJSF2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:05:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932648AbcHJSFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFAB53093C;
	Wed, 10 Aug 2016 12:47:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CtNascEyIQ7J49hQPA/b/LAPM7c=; b=Vz9PkS
	pqzVvCaCOMZrRebWBvm3Kf/22gQv0m5B5K23v6OZYUxMlR7XFPewtnfjMJzHqz/u
	oW0uTWSLKmdchdVSqGTIC/NkwpbBjSaSQhfWMWvIjE88WGpazlQMKRPrtBmkqQey
	2wp+XfUugs/6eCjZCEwEp6b89UYoXGl84DMa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YMYGbpTnuMfuPL3CMpQBPVr2LNQd3MC5
	c+1zfcKt+Yvfu5+7NqhMP0DQ5hbkb21h5+WaVFptcovh6O5sdydy893/wO4ycHyo
	HAYkT3vknUhkVqLZwwhEQ5ZpOj/t5Nsa9PPK4qAUqdJnd6AHYs0VndiJPOkZe7GO
	fa1PVoPvv0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C858C3093B;
	Wed, 10 Aug 2016 12:47:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 501643093A;
	Wed, 10 Aug 2016 12:47:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/2] pack-objects mru
References: <20160729040422.GA19678@sigill.intra.peff.net>
	<20160729041524.GG22408@sigill.intra.peff.net>
	<20160729054536.GA27343@sigill.intra.peff.net>
	<xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
	<20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
	<xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
	<20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
	<xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
	<20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
	<xmqq7fbp8tki.fsf@gitster.mtv.corp.google.com>
	<20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 09:47:52 -0700
In-Reply-To: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 10 Aug 2016 07:52:06 -0400")
Message-ID: <xmqqbn107epz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EFB80E4-5F1A-11E6-9D54-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This is not new with this change, but I am not quite sure what in
>> the current code prevents us from busting the delta limit for reused
>> ones, though.
>
> I think in the current code you are limited by the depth you might find
> in a single existing pack (since we never reuse cross-pack deltas).

Sorry for going deeper in the tangent, but I vaguely recall raising
it long time ago as a potential issue that delta reuse out of an
original pack created with deep delta chain may bust a delta chain
limit when repacking with shorter delta chain limit; I just do not
remember where that discussion went (i.e. decided to be a non-issue?
we added code to avoid it? etc.)

> However, I think with cross-pack deltas, you could have a situation
> like:
>
>   pack 1: A -> B -> C
>   pack 2: C -> D -> E
>
> and pick A and B from the first pack, and C, D, and E from the second.
> Then you end up with:
>
>   A -> B -> C -> D -> E
>
> in the output. IOW, I think the absolute worst case chain is the
> max_depth times the number of packs.

Also if pack1 and pack2 were created with depth limit of 3 and we
are repacking with depth limit of 2, then we are busting the limit
already with or without cross-pack chaining, I would think.

> I'm not sure how much we should be worried about it. We could fill in
> the depth values when adding a reused delta, but I don't think we have
> the number handy; we'd have to actually walk the chain (though with
> delta-base-offset, that is reasonably cheap).

True.  It is something we may want to keep back in our mind and
revisit later.  It is definitely not a low-hanging fruit, but
something that should go to the leftover-bits list.

> The second patch is the same as before, though I tweaked the commit
> message a bit, so please replace what is at the tip of
> jk/pack-objects-optim-mru.
>
>   [1/2]: pack-objects: break delta cycles before delta-search phase
>   [2/2]: pack-objects: use mru list when iterating over packs

Thanks.
