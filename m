Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D33C1F454
	for <e@80x24.org>; Thu, 20 Sep 2018 19:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbeIUBMp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:12:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:54202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726582AbeIUBMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:12:45 -0400
Received: (qmail 3327 invoked by uid 109); 20 Sep 2018 19:27:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Sep 2018 19:27:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28208 invoked by uid 111); 20 Sep 2018 19:27:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Sep 2018 15:27:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2018 15:27:41 -0400
Date:   Thu, 20 Sep 2018 15:27:41 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     ttaylorr@github.com, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] Filter alternate references
Message-ID: <20180920192741.GB29603@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <CAGZ79kYv-n_x_Z3K=zsiTAQ9RCFMVE=6ZYCWRQMgioGRPnhVOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYv-n_x_Z3K=zsiTAQ9RCFMVE=6ZYCWRQMgioGRPnhVOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 11:35:23AM -0700, Stefan Beller wrote:

> > This optimization is a good one and works well, particularly when the
> > upstream repository has a relatively normal number of references. When
> > the upstream has a pathologically _large_ number of references, the
> > advertisement alone can be so time consuming, that it's faster to send
> > redundant objects to the fork.
> 
> (tangent:)
> The current fetch protocol consists of 2 parts:
> negotiation + sending the packfile, and the negotiation only tries
> to trim down the size of the packfile to send, without taking its own
> cost (in terms of time and band width) into account, just to produce
> a perfect pack to send to the client.
> 
> When talking about designing protocol v2 for push (which has not
> landed yet[1]), we had some in-office discussions whether we
> want to have a proper negotiation on push, as it would help
> pushing to remotes that have non-ff pushes, but not necessarily
> regular pushes, as they should be fine with just the refs advertisement.

I don't think that materially changes anything. We already do this same
trick on fetch (but just with the client advertising the extra haves,
since it's the receiver). So if push started doing a real negotiation,
we'd still want to feed those haves in the same way.

> Would it make sense to estimate the value of each .have before
> advertising them and then advertise only the <n> most valuable
> .haves ?
> (e.g. if a .have is only one small commit ahead of origin/master,
> it may not bring a lot of value as the potential savings are small,
> but if that .have contains history between master..TIP that has lots
> of big blobs or objects in general, this may be valuable to know)

That sounds neat, but I think is mostly orthogonal here. We're primarily
interested in just narrowing down the initial set of possibilities, so
you could cull it further.

And I see Taylor just responded with the idea that you could do this in
your hook. Which is neat, but definitely not something we are planning
on doing with it immediately. ;)

-Peff
