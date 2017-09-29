Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA6F20A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdI2T03 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 15:26:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:54698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752365AbdI2T01 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 15:26:27 -0400
Received: (qmail 27699 invoked by uid 109); 29 Sep 2017 19:26:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 19:26:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6432 invoked by uid 111); 29 Sep 2017 19:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 15:27:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Sep 2017 15:26:25 -0400
Date:   Fri, 29 Sep 2017 15:26:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-ID: <20170929192624.4ukvpjujgiyzgibb@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170928004137.GD68699@google.com>
 <20170928104616.be61b394b50dc5193be275be@google.com>
 <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
 <20170929120456.3bb8021de1c7aebee7bb5026@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170929120456.3bb8021de1c7aebee7bb5026@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 12:04:56PM -0700, Jonathan Tan wrote:

> > So depending how you count it, we're wasting between 28% (sha1 and no
> > extra hash) and 16% (sha256 plus reusing hashmap). That's not great, but
> > it's probably not breaking the bank.
> 
> Hmm...how did you get the 16% figure? The values, as I see it, are:
>  - 32 for the sha256 hash itself
>  - 8 for the "next" chain pointer
>  - 8 for the padded hash
>  - 8 for the "util" pointer
> 
> For an oidset, the padded hash and the "util" pointer are wasted, which is
> 16/56=0.286. (If you assume, say, 8 bytes of malloc bookkeeping overhead, then
> 16/64=0.25.)

Sorry to be unclear. I was just counting the waste for the "util"
pointer, not the extra padded hash bit (which AFAIK is already wasted in
oidset). So I computed 48 bytes without the util pointer, which means we
waste an additional 16% to add it.

Anyway, my point was mostly to say that this is a fractional percentage
of the total memory. So it falls into the category of "this might help
in tight situations" and less "this will blow up in our faces".

> In a 100-million-object monorepo, we will probably end up only operating on the
> "frontier" objects (objects that we do not have but we know about because some
> object we have reference them) at the worst. I don't have numbers but I think
> that that is at least an order of magnitude less than 100M.

Agreed.

> > So I think we may be better off going with the solution here that's
> > simpler and requires introducing less code. If it does turn out to be a
> > memory problem in the future, this is a _really_ easy thing to optimize
> > after the fact, because we have these nice abstractions.
> 
> Optimizing away the padded hash should be straightforward. Optimizing away the
> "util" pointer after we have code that uses it is (slightly?) less
> straightforward, but still doable.

I was thinking here of just oidset. It has a limited API, so swapping
out the implementation for one that does not depend on oidmap and waste
the "util" pointer would be the "easy" part.

> I still lean towards saving memory by eliminating the padded hash and
> not using the "util" pointer, because the complication is contained
> within only two files (oidmap.{c,h}), and because the constant factors
> in memory savings might end up mattering. But I don't feel strongly
> about that - I think any of the oidmaps that we have discussed is an
> improvement over what we have now.

My main concern is not so much about complexity bleeding out of the
oidmap code, but that now we have two parallel near-identical hashmap
implementations.  When one gets an optimization, bugfix, or new feature,
we have to port it over manually to the other.

-Peff
