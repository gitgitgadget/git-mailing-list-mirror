Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17693208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 20:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeGPVHx (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:07:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:48422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728075AbeGPVHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:07:53 -0400
Received: (qmail 14472 invoked by uid 109); 16 Jul 2018 20:38:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 20:38:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15326 invoked by uid 111); 16 Jul 2018 20:38:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 16:38:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 16:38:48 -0400
Date:   Mon, 16 Jul 2018 16:38:47 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716203847.GE25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 01:16:45PM -0700, Elijah Newren wrote:

> >> The basic problem here, at least for us, is that gc has enough
> >> information to know it could expunge some objects, but because of how
> >> it is structured in terms of several substeps (reflog expiration,
> >> repack, prune), the information is lost between the steps and it
> >> instead writes them out as unreachable objects.  If we could prune (or
> >> avoid exploding) loose objects that are only reachable from reflog
> >> entries that we are expiring, then the problem goes away for us.  (I
> >> totally understand that other repos may have enough unreachable
> >> objects for other reasons that Peff's suggestion to just pack up
> >> unreachable objects is still a really good idea.  But on its own, it
> >> seems like a waste since it's packing stuff that we know we could just
> >> expunge.)
> >
> > No, we should have expunged everything that could be during the "repack"
> > and "prune" steps. We feed the expiration time to repack, so that it
> > knows to drop objects entirely instead of exploding them loose.
> 
> Um, except it doesn't actually do that.  The testcase I provided shows
> that it leaves around 10000 objects that are totally deletable and
> were only previously referenced by reflog entries -- entries that gc
> removed without removing the corresponding objects.

What's your definition of "totally deletable"?

If the pack they were in is less than 2 weeks old, then they are
unreachable but "fresh", and are intentionally retained. If it was older
than 2 weeks, they should have been deleted.

If you don't like that policy, you can set gc.pruneExpire to something
lower (including "now", but watch out, as that can race with other
operations!). But I don't think that's an implementation short-coming.
It's intentional to keep those objects. It's just that the format
they're in is inefficient and confuses later gc runs.

-Peff
