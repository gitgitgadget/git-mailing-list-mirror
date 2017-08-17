Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D20208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 09:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdHQJPH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 05:15:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:41494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750939AbdHQJPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 05:15:06 -0400
Received: (qmail 3596 invoked by uid 109); 17 Aug 2017 09:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 09:15:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25398 invoked by uid 111); 17 Aug 2017 09:15:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 05:15:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 05:15:04 -0400
Date:   Thu, 17 Aug 2017 05:15:04 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
Message-ID: <20170817091503.vsd4lncogphy5gxx@sigill.intra.peff.net>
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
 <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
 <20170817090308.yh3jnztgfmkwtqpr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170817090308.yh3jnztgfmkwtqpr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 05:03:08AM -0400, Jeff King wrote:

> But that does the opposite of what we want: it makes this case work when
> --allow-overlap isn't specified. I think my first attempt is probably
> closer to the right direction (but we'd want to have it kick in only
> when --allow-overlap is specified; well formed patches shouldn't overlap
> but we'd want to barf loudly if they do).
> 
> I'll stop here for now before digging any further. I'm not all that
> familiar with the apply code, so I have a feeling Junio's comments may
> stop me from going down an unproductive dead end. :)

OK, last email, I promise. :)

My first attempt which turns off match_beginning for the overlapping
hunk really does feel wrong. It would blindly match a similar hunk later
in the file. So if you did something like:

  1. The first hunk deletes context line "x".

  2. The second overlapping hunk claims to start at the beginning of the
     file (line 1), and then adds a line after "x".

  3. Later in the file, we have another line "x".

Then the second hunk should be rejected, and not find the unrelated "x"
from (3). But with my patch, I suspect it would be found (because we
dropped the requirement to find it at the beginning).

Of course this is a pretty ridiculous input in the first place. In
theory it _could_ be figured out, but overlapping hunks like this are
always going to cause problems (in this case, context from the second
hunk became a removal, and the second hunk no longer applies).

So maybe it's not worth caring about.  But I think the most robust
solution would involve checking the lines between try_lno and the start
to make sure they were all added. I just don't know that we have an easy
way of checking that. Perhaps if we recorded the cumulative number of
lines added in previous hunks, and used that as our starting point
(instead of "line 0").

I also suspect that match_end has a similar problem, but I couldn't
trigger it in practice (perhaps it's impossible, or perhaps my brain is
just not up to the challenge today).

-Peff
