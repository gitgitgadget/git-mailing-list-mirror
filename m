Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F413A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeCPV3X (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:29:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:60106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750877AbeCPV3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:29:23 -0400
Received: (qmail 10630 invoked by uid 109); 16 Mar 2018 21:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Mar 2018 21:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1237 invoked by uid 111); 16 Mar 2018 21:30:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Mar 2018 17:30:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Mar 2018 17:29:21 -0400
Date:   Fri, 16 Mar 2018 17:29:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     mhagger@alum.mit.edu, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [ANNOUNCE] git-sizer: compute various size-related metrics for
 your Git repository
Message-ID: <20180316212920.GD12333@sigill.intra.peff.net>
References: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
 <87370zeqmx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87370zeqmx.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 09:01:42PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Suggestion for a thing to add to it, I don't have the time on the Go
> tuits:
> 
> One thing that can make repositories very pathological is if the ratio
> of trees to commits is too low.
> 
> I was dealing with a repo the other day that had several thousand files
> all in the same root directory, and no subdirectories.

We've definitely run into this problem before (CocoaPods/Specs, for
example). The metric that would hopefully show this off is "what is the
tree object with the most entries". Or possibly "what is the average
number of entries in a tree object".

That's not the _whole_ story, because the really pathological case is
when you then touch that giant tree a lot. But if you assume the paths
touched by commits are reasonably distributed over the tree, then having
a huge number of entries in one tree will also mean that more commits
will touch that tree. Sort of a vaguely quadratic problem.

Doing it at the root is obviously the worst case, but the same thing can
happen if you have "foo/bar" as a huge tree, and every single commit
needs to touch some variant of "foo/bar/baz".

That's why I suspect some "average per tree object" may show this type
of problem, because you'd have a lot of near-identical copies of that
giant tree if it's being modified a lot.

> But it's not something where you can just say having more trees is
> better, because on the other end of the spectrume we can imagine a repo
> like linux.git where each file like COPYING instead exists at
> C/O/P/Y/I/N/G, that would also be pathological.
> 
> It would be very interesting to do some tests to see what the optimal
> value would be.

I suspect there's some math that could give us the solution. You want
approximately equal-sized trees, so maybe log(N) levels?

-Peff
