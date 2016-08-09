Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57911F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbcHISG3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:06:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752359AbcHISG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:06:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C17633242E;
	Tue,  9 Aug 2016 14:06:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aqDbW3YgcofWhFY3HnEmHA65EYM=; b=dh0DH+
	fMslYVa6U78/Ihnh3yJcWOGOv/3Q04GP9L7fd+hxvp+vjo9hw772uTbk0UhSm5T0
	s5NK41zcG4NK2NEYUaChHV5ty5iYhcLA4M9ClDmOMHpRM7/DeSdYN48O92+T+edz
	v52G3ZeMnLNLxW88E4DBCSxgz6I9pcUHLnzJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1FymTDNvXN07IS6WVLwWVl/rgA1Z2yj
	cX/yc/stCzfFFxHrdNbFgaWKC9YE28y/m3vb6ddFUi45PnSWB2ZmmxbqJGD7/fX2
	kNPR3aTOPk6quuaiR9zUft6coBIuF6yFLzCoEF+b2fW1R5vmM2YfDbaFr3D4QXsW
	yashF20kGVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B99473242D;
	Tue,  9 Aug 2016 14:06:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 452403242C;
	Tue,  9 Aug 2016 14:06:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over packs
References: <20160729040422.GA19678@sigill.intra.peff.net>
	<20160729041524.GG22408@sigill.intra.peff.net>
	<20160729054536.GA27343@sigill.intra.peff.net>
	<xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
	<20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
	<xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
	<20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
	<xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
	<20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
	<20160809174528.2ydgkhd7ayclat3t@sigill.intra.peff.net>
Date:	Tue, 09 Aug 2016 11:06:23 -0700
In-Reply-To: <20160809174528.2ydgkhd7ayclat3t@sigill.intra.peff.net> (Jeff
	King's message of "Tue, 9 Aug 2016 13:45:29 -0400")
Message-ID: <xmqqvaz9akbk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD1CDD8E-5E5B-11E6-9F82-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I ran the repack again with stock git (no MRU patch), and the number of
> objects in the delta phase jumped to 3087880, around 56,000 more than
> with the MRU patch. So that's probably where the magic "3%" is coming
> from.  By looking at the smaller packs first, we are more likely to find
> copies of objects which _aren't_ deltas, and then consider them for
> delta compression. And that compression tends to find a better match
> than reusing what was in the big pack, and we end up with a slightly
> smaller output pack.

Yeah, that is a very plausible explanation.

> So why are the deltas we find so much better than what is in the big
> pack?
>
> There's something rather subtle going on, and it has to do with the fact
> that the existing pack was _not_ made by a stock version of git.

;-)

> I may have mentioned before that I have some patches which restrict the
> delta selection process. The goal is that if you have several "islands"
> of refs (in my case, refs corresponding to particular forks of a
> repository), it's desirable that you don't make a delta against a base
> that is not reachable from all of the same islands. 

That also explains it.  It is expected (small) price to pay to
ensure the islands are standalone.

> I also suspect that one of the tricks I tried, simply reversing the pack
> order (so the big pack is at the front, but the order is stable) would
> work very well for this case. But as I mentioned before, I prefer the
> MRU strategy because it's less susceptible to pathological cases.

Yup, excellent.  Thanks for working on this.
