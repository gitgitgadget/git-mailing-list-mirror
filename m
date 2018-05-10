Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82DF21F42D
	for <e@80x24.org>; Thu, 10 May 2018 06:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756713AbeEJGkR (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:40:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:34396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751313AbeEJGkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:40:16 -0400
Received: (qmail 21264 invoked by uid 109); 10 May 2018 06:40:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 06:40:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20991 invoked by uid 111); 10 May 2018 06:40:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 02:40:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 02:40:14 -0400
Date:   Thu, 10 May 2018 02:40:14 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to
 'git-grep'
Message-ID: <20180510064014.GA31779@sigill.intra.peff.net>
References: <cover.1525492696.git.me@ttaylorr.com>
 <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
 <87fu36y4u0.fsf@evledraar.gmail.com>
 <20180508172517.GA934@sigill.intra.peff.net>
 <20180510020010.GA5375@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510020010.GA5375@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 07:00:10PM -0700, Taylor Blau wrote:

> >  - they test with context (-C3) for us. It looks like GNU grep omits
> >    context lines with "-o", but we show a bunch of blank lines. This is
> >    I guess a bug (though it seems kind of an odd combination to specify
> >    in the first place)
> 
> I'm torn on what to do here. Currently, with -C3, I get a bunch of lines
> like:
> 
>   <file>-
> 
> Which I think is technically _right_, but I agree that it is certainly
> an odd combination of things to give to 'git grep'. I think that we
> could either:
> 
>   1. Continue outputting blank lines,
>   2. Ignore '-C<n>' with '-o', or
>   3. die() when given this combination.
> 
> I think that (1) is the most "correct" (for some definition), so I'm
> inclined to adopt that approach. I suppose that (2) is closer to what
> GNU grep offers, and that is the point of this series, so perhaps it
> makes sense to pick that instead.
> 
> I'll go with (2) for now, but I would appreciate others' thoughts before
> sending a subsequent re-roll of this series.

We talked about this off-list, so I want to summarize here for the
archive.

It turns out that the GNU grep behavior isn't universal.  Here's what I
get:

  $ grep -o -C3 the README.md
  the
  the
  the
  the
  the
  the
  the
  the
  --
  the
  the
  the
  the
  the
  the
  the
  the
  the
  the
  the
  the
  the
  the

So that's not _quite_ ignoring -C. It's still showing the "--", which
indicates that the first chunk are all matches within 6 lines of each
other (so their context is melded into a single hunk), but it omits the
lines entirely. Which at least seems like it could be _plausibly_
useful.

BSD grep seems to actually show the context lines. Which is more
information, but if you want to actually see the context, why are you
using "-o" in the first place?

So my general feeling is that disallowing the combination is probably
fine, because it's a vaguely crazy thing to ask for. But that GNU grep's
behavior is the most likely to actually be useful. The BSD behavior
seems more like "this is what we happen to produce" to me.

And it should be pretty easy to reproduce the GNU grep behavior by just
not outputting anything in show_line().

-Peff
