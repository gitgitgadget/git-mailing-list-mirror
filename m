Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 101DF1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeAXVeN (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:34:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:56188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932474AbeAXVeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:34:13 -0500
Received: (qmail 2634 invoked by uid 109); 24 Jan 2018 21:34:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 21:34:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29419 invoked by uid 111); 24 Jan 2018 21:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 16:34:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:34:11 -0500
Date:   Wed, 24 Jan 2018 16:34:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] find_reference_location(): make function safe for
 empty snapshots
Message-ID: <20180124213410.GA8952@sigill.intra.peff.net>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
 <e9f9ed1944c297a68c2b76f5d4ddd73e279bd207.1516791909.git.mhagger@alum.mit.edu>
 <20180124202754.GA7773@sigill.intra.peff.net>
 <xmqq8tcnc68r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tcnc68r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 01:11:00PM -0800, Junio C Hamano wrote:

> > This tightens the binary search termination condition. If we ever did
> > see "hi > lo", we'd want to terminate the loop. Is that ever possible?
> 
> I think you meant "lo > hi", but I shared the same "Huh?" moment.

Er, yeah. Sorry about that.

> Because "While lo is strictly lower than hi" is a so well
> established binary search pattern, even though we know that it is
> equivalent to "While lo and hi is different" due to your analysis
> below, the new code looks somewhat strange at the first glance.

I thought at first that this was due to the way the record-finding
happens, but I think even in our normal binary searches, it is an
invariant that "lo <= hi".

> > I think the answer is "no". Our "hi" here is an exclusive bound, so we
> > should never go past it via find_end_of_record() when assigning "lo".
> > And "hi" is always assigned from the start of the current record. That
> > can never cross "lo", because find_start_of_record() ensures it.
> >
> > So I think it's fine, but I wanted to double check.
> 
> It would be much simpler to reason about if we instead do
> 
> 	#define is_empty_snapshot(s) ((s)->start == NULL)
> 
> 	if (is_empty_snapshot(snapshot))
> 		return NULL;
> 
> or something like that upfront.

Yes, I agree that would also work.

-Peff
