Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F5C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A48613CE
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFWVyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 17:54:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhFWVyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 17:54:18 -0400
Received: (qmail 7654 invoked by uid 109); 23 Jun 2021 21:51:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jun 2021 21:51:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6949 invoked by uid 111); 23 Jun 2021 21:52:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 17:52:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 17:51:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Message-ID: <YNOs/w5JwfBDLbUD@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
 <YNKgkGkPiMgNubNE@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNKgkGkPiMgNubNE@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 10:46:40PM -0400, Taylor Blau wrote:

> On Tue, Jun 22, 2021 at 12:08:40PM -0400, Jeff King wrote:
> > If the packed-refs file ever learns to store all of the peeled layers,
> > then we could switch to it. Or even if it stored a flag to indicate the
> > peel was not multi-layer (because most of them aren't), then we could
> > use it most of the time and fall back to a manual peel for the rare
> > cases.
> 
> Yeah, I would be in favor of either of these. Of the two, the latter
> seems like the simplest thing, but the former provides you all of the
> information you could hope for.
> 
> I suppose that if you are already changing the format of packed-refs,
> then we might as well do the thing which provides the most information
> and allows us to optimize *all* cases, not just the vast majority of
> them.

One reason not to include all of them is that the list can be
arbitrarily long, and regular readers of packed-refs (who may not even
care about peeling at all) have to skip past it. That matters a little
less these since we binary-search it (but you still might be iterating
over the ref).

So I think either way it is a tradeoff, and you are making assumptions
about which cases are less likely.

If I were to work on this (and I don't have any immediate plans to do
so), I'd probably do whichever is easiest to implement, and to maintain
backwards-compatibility. And I suspect that is the "flag" approach, but
a lot would depend on the details of our parser and what it permits.

-Peff
