Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0EB2018E
	for <e@80x24.org>; Thu, 11 Aug 2016 04:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbcHKEsO (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 00:48:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:53379 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750949AbcHKEsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 00:48:12 -0400
Received: (qmail 17283 invoked by uid 109); 11 Aug 2016 04:48:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 04:48:12 +0000
Received: (qmail 6741 invoked by uid 111); 11 Aug 2016 04:48:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 00:48:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 00:48:09 -0400
Date:	Thu, 11 Aug 2016 00:48:09 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/2] pack-objects mru
Message-ID: <20160811044809.ep22lybdyfzmx4pl@sigill.intra.peff.net>
References: <20160729054536.GA27343@sigill.intra.peff.net>
 <xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
 <20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
 <xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
 <20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
 <xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
 <20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
 <xmqq7fbp8tki.fsf@gitster.mtv.corp.google.com>
 <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
 <xmqqbn107epz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn107epz.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 09:47:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> This is not new with this change, but I am not quite sure what in
> >> the current code prevents us from busting the delta limit for reused
> >> ones, though.
> >
> > I think in the current code you are limited by the depth you might find
> > in a single existing pack (since we never reuse cross-pack deltas).
> 
> Sorry for going deeper in the tangent, but I vaguely recall raising
> it long time ago as a potential issue that delta reuse out of an
> original pack created with deep delta chain may bust a delta chain
> limit when repacking with shorter delta chain limit; I just do not
> remember where that discussion went (i.e. decided to be a non-issue?
> we added code to avoid it? etc.)

Digging on the list and in the history, I found your e4c9327
(pack-objects: avoid delta chains that are too long., 2006-02-17). That
approach went away with Nico's 898b14c (pack-objects: rework
check_delta_limit usage, 2007-04-16), which I think is where we are at
today.

I found the patches for both on the list, but no interesting discussion.

It looks like 898b14c does the depth check dynamically in find_delta. So
we would not build on a too-long chain, but I do not see anything that
prevents us from creating a too-long chain purely out of reused deltas.

Which means that even without my patches, repacking with a shorter delta
chain does not guarantee you do not have a longer chain. And mine
introduces a potential "packs * max_depth" problem (I also think
check_delta_limit could recurse very deeply if given a pathologically
weird pack that has insane delta limits, but presumably we would just
run out of stack and crash, which seems like an OK outcome for such
maliciousness).

I guess it would not be that hard to break the reused chains as part of
the DFS search I introduced (we are recursing already; just stop
recursing and break when we hit the max-depth).

> > However, I think with cross-pack deltas, you could have a situation
> > like:
> >
> >   pack 1: A -> B -> C
> >   pack 2: C -> D -> E
> >
> > and pick A and B from the first pack, and C, D, and E from the second.
> > Then you end up with:
> >
> >   A -> B -> C -> D -> E
> >
> > in the output. IOW, I think the absolute worst case chain is the
> > max_depth times the number of packs.
> 
> Also if pack1 and pack2 were created with depth limit of 3 and we
> are repacking with depth limit of 2, then we are busting the limit
> already with or without cross-pack chaining, I would think.

Right, though that is at least bounded to "what you packed with before",
which people do not usually change (OTOH, we accept packs from random
strangers via the protocol).

-Peff
