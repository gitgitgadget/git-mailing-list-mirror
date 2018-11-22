Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775971F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406002AbeKWDaZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 22:30:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:48720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2404359AbeKWDaY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 22:30:24 -0500
Received: (qmail 24776 invoked by uid 109); 22 Nov 2018 16:50:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:50:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23579 invoked by uid 111); 22 Nov 2018 16:49:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:49:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:50:12 -0500
Date:   Thu, 22 Nov 2018 11:50:12 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] pack-objects: fix tree_depth and layer invariants
Message-ID: <20181122165012.GH28192@sigill.intra.peff.net>
References: <20181120094451.GA21725@sigill.intra.peff.net>
 <20181120094638.GA22742@sigill.intra.peff.net>
 <CACsJy8AETNxNnEq-8ROrQTkjy-_9mtoprmc=BQ554f7QECajPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AETNxNnEq-8ROrQTkjy-_9mtoprmc=BQ554f7QECajPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 05:37:18PM +0100, Duy Nguyen wrote:

> > But in (b), we use the number of stored objects, _not_ the allocated
> > size of the objects array. So we can run into a situation like this:
> >
> >   1. packlist_alloc() needs to store the Nth object, so it grows the
> >      objects array to M, where M > N.
> >
> >   2. oe_set_tree_depth() wants to store a depth, so it allocates an
> >      array of length N. Now we've violated our invariant.
> >
> >   3. packlist_alloc() needs to store the N+1th object. But it _doesn't_
> >      grow the objects array, since N <= M still holds. We try to assign
> >      to tree_depth[N+1], which is out of bounds.
> 
> Do you think if this splitting data to packing_data is too fragile
> that we should just scrape the whole thing and move all data back to
> object_entry[]? We would use more memory of course but higher memory
> usage is still better than more bugs (if these are likely to show up
> again).

Certainly that thought crossed my mind while working on these patches. :)

Especially given the difficulties it introduced into the recent
bitmap-reuse topic, and the size fixes we had to deal with in v2.19.

Overall, though, I dunno. This fix, while subtle, turned out not to be
too complicated. And the memory savings are real. I consider 100M
objects to be on the large size of feasible for stock Git these days,
and I think we are talking about on the order of 4GB memory savings
there. You need a big machine to handle a repository of that size, but
4GB is still appreciable.

So I guess at this point, with all (known) bugs fixed, we should stick
with it for now. If it becomes a problem for development of a future
feature, then we can re-evaluate then.

-Peff
