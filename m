Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381D31F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeKTXJc (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:09:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:45662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725843AbeKTXJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:09:32 -0500
Received: (qmail 28237 invoked by uid 109); 20 Nov 2018 12:40:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 12:40:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28682 invoked by uid 111); 20 Nov 2018 12:39:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 07:39:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 07:40:34 -0500
Date:   Tue, 20 Nov 2018 07:40:34 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
Message-ID: <20181120124033.GA7596@sigill.intra.peff.net>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
 <20181120113423.GA29319@sigill.intra.peff.net>
 <80690e4b-4fc4-7846-009f-59dee9fbdd86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80690e4b-4fc4-7846-009f-59dee9fbdd86@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 07:17:46AM -0500, Derrick Stolee wrote:

> > And I think that's a pattern with the delta-island code. What we really
> > care about most is that if we throw a real fork-network repository at
> > it, it produces faster clones with fewer un-reusable deltas. So I think
> > a much more interesting approach here would be perf tests. But:
> > 
> >    - we'd want to count those as coverage, and that likely makes your
> >      coverage tests prohibitively expensive
> > 
> >    - it requires a specialized repo to demonstrate, which most people
> >      aren't going to have handy
> 
> Do you have regularly-running tests that check this in your infrastructure?
> As long as someone would notice if this code starts failing, that would be
> enough.

We do integration tests, and this feature gets exercised quite a bit in
production at GitHub. But none of that caught the breakage I fixed this
morning for the simple fact that we don't keep up with upstream master
in real-time. We're running the delta-island code I wrote years ago, and
the bug was introduced by the upstreaming. Probably in a month or three
I'll merge v2.20 into our fork, and we would have noticed then.

I've had dreams of following upstream more closely, but there are two
blockers:

  - we have enough custom bits that the merges are time-consuming (and
    introduce the possibility of funny interactions or regressions). I'd
    like to reduce our overall diff from upstream, but it's slow going
    and time is finite. (And ironically, it's made harder in some ways
    by the lag, because many of our topics are backports of things I
    send upstream).

  - deploying the ".0" release from master can be scary. For instance, I
    was really happy to have a fix for 9ac3f0e5b3 (pack-objects: fix
    performance issues on packing large deltas, 2018-07-22) before
    putting the bug into production.

> > Yeah, this triggers if your regex has more than one capture group (and
> > likewise, we almost certainly don't run the "you have too many groups"
> > warning).
> 
> Did you know that regexes are notoriously under-tested [1]? When looking at
> this code, I didn't even know regexes were involved (but I didn't look
> enough at the context).
> 
> [1] https://dl.acm.org/citation.cfm?id=3236072

Heh. Well, fortunately we are compiling regexes from the user's config,
so it's not Git's fault if the regexes are bad. ;)

(Of course on our production servers I'm on the hook for both sides!)

-Peff
