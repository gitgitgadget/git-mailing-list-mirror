Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A921FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 10:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdDHKnc (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 06:43:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:58466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdDHKnb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 06:43:31 -0400
Received: (qmail 6381 invoked by uid 109); 8 Apr 2017 10:43:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 10:43:30 +0000
Received: (qmail 10907 invoked by uid 111); 8 Apr 2017 10:43:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 06:43:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 06:43:28 -0400
Date:   Sat, 8 Apr 2017 06:43:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 0/3] read-cache: speed up add_index_entry
Message-ID: <20170408104328.3iuvedkewygkovnb@sigill.intra.peff.net>
References: <20170406163442.36463-1-git@jeffhostetler.com>
 <20170407044626.ypsqnyxguw43gprm@sigill.intra.peff.net>
 <6f31ee65-517e-419c-b0c1-3ccdd3f95b37@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f31ee65-517e-419c-b0c1-3ccdd3f95b37@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 02:27:24PM -0400, Jeff Hostetler wrote:

> > Just thinking about this algorithmically for a moment. You're saving the
> > binary search when the input is given in sorted order. But in other
> > cases you're adding an extra strcmp() before the binary search begins.
> > So it's a tradeoff.
> > 
> > How often is the input sorted?  You save O(log n) strcmps for a "hit"
> > with your patch, and one for a "miss". So it's a net win if we expect at
> > least 1/log(n) of additions to be sorted (I'm talking about individual
> > calls, but it should scale linearly either way over a set of n calls).
> > 
> > I have no clue if that's a reasonable assumption or not.
> 
> I was seeing checkout call merge_working_tree to iterate over the
> source index/trees and call add_index_entry() for each.  For example,
> in a "checkout -b" like operation where both sides are the same, this
> calls keep_entry() which appends the entry to the new index array.
> The append path should always be taken because the iteration is being
> driven from a sorted list.
> 
> I would think calls to add/stage individual files arrive in random
> order, so I'm not suggesting replacing the code -- just checking the
> end first.

Right, what I was wondering is how much this costs in those random-order
cases. We _know_ it speeds up the cases you care about, but I want to
make sure that it is not making some other case worse. How often do the
random-order cases come up, and how much are they slowed?

I suspect in practice that calls here fall into one of two camps:
feeding a small-ish (compared to the total number of entries) set of
paths, or feeding _every_ path. And if you are feeding every path, you
are likely to do so in sorted order, rather than a random jumble. So it
helps in the big cases, and the small cases are presumably small enough
that we don't care much.

At least that seems like a plausible line of reasoning to me. ;)

-Peff
