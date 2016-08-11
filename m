Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D381F859
	for <e@80x24.org>; Thu, 11 Aug 2016 06:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcHKG55 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 02:57:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53417 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750992AbcHKG5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 02:57:55 -0400
Received: (qmail 24934 invoked by uid 109); 11 Aug 2016 06:57:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 06:57:54 +0000
Received: (qmail 7265 invoked by uid 111); 11 Aug 2016 06:57:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 02:57:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 02:57:52 -0400
Date:	Thu, 11 Aug 2016 02:57:52 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/2] pack-objects: break delta cycles before
 delta-search phase
Message-ID: <20160811065751.p64bi3sngbeotwc3@sigill.intra.peff.net>
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
 <20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
 <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
 <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 01:02:52AM -0400, Jeff King wrote:

> > > + *   2. Updating our size; check_object() will have filled in the size of our
> > > + *      delta, but a non-delta object needs it true size.
> > 
> > Excellent point.
> 
> I was not clever enough to think of it; the pack-objects code is filled
> with nice assertions (Thanks, Nico!) that help out when you are stupid. :)
> 
> One thing to be careful of is that there are more things this
> drop_reused_delta() should be doing. But I looked through the rest of
> check_object() and could not find anything else.

Argh, I spoke too soon.

It is true that the size lookup is the only part of check_object()
we skip if we are reusing the delta. But what I didn't notice is that
when we choose to reuse a delta, we overwrite entry->type (the real
type!) with the in_pack_type (OFS_DELTA, etc). We need to undo that so
that later stages see the real type.

I'm not sure how my existing tests worked (I confirmed that they do
indeed break the delta). It may be that only some code paths actually
care about the real type. But when playing with the depth-limit (which
uses the same drop_reused_delta() helper), I managed to make some pretty
broken packs.

So please disregard the v4 patch I just sent; I haven't triggered it,
but I imagine it has the same problem, and I just didn't manage to
trigger it.

I'll clean that up and send out a new series.

-Peff
