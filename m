Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B4920437
	for <e@80x24.org>; Fri, 13 Oct 2017 13:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757807AbdJMNGl (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 09:06:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:52014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753231AbdJMNGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 09:06:40 -0400
Received: (qmail 19864 invoked by uid 109); 13 Oct 2017 13:06:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:06:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24998 invoked by uid 111); 13 Oct 2017 13:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 09:06:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 09:06:38 -0400
Date:   Fri, 13 Oct 2017 09:06:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
 <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
 <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 12:37:57PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > OK. For the record, I'm not against scrapping this whole thing and
> > trying to rollback to your "plumbing never looks at color.ui" proposal.
> > It's quite late in the -rc cycle to do that, but there's nothing that
> > says we can't bump the release date if that's what we need to do to get
> > it right.
> 
> I think that it is too late, regardless of our release cycle.
> 
> "Plumbing never looks at color.ui" implies that "plumbing must not
> get color.ui=auto from 4c7f1819", but given that 4c7f1819 is from
> 2013, I'd be surprised if we stopped coloring output from plumbing
> without getting any complaints from third-party script writers.

I agree that 4c7f1819 is the root of things. But there also weren't a
lot of people complaining about it. I only noticed it as part of other
work I was doing, and (perhaps foolishly) tried to clean it up.

All of the regressions people have actually _noticed_ stem from my
136c8c8b8f in v2.14.2. So I think it is a viable option to try to go
back to the pre-v2.14.2 state. I.e.:

  1. Revert my 20120618c1 (color: downgrade "always" to "auto" only for
     on-disk configuration, 2017-10-10) and the test changes that came
     with it.

  2. Teach for-each-ref and tag to use git_color_default_config(). These
     are the two I _know_ need this treatment as part of the series that
     contained 136c8c8b8f. As you've noted there may be others, but I'd
     be surprised if there are many. There hasn't been a lot of color
     work in the last few months besides what I've done.

  3. Revert 136c8c8b8f.

That takes us back to the pre-regression state. The ancient bug from
4c7f1819 still exists, but that would be OK for v2.15. We'd probably
want to bump the -rc cycle a bit to give more confidence that (2) caught
everything.

Post-release, we would either:

  a. Do nothing. As far as we know, nobody has cared deeply about
     4c7f1819 for the past 4 years.

  b. Teach git_default_config() to respect "never" but not "always", so
     that you can disable the auto-color in the plumbing (but not shoot
     yourself in the foot).

  c. Go all-out and remove the "auto" behavior from plumbing. This is
     much more likely to have fallouts since we've had 4 years of the
     wrong behavior. But we'd have a whole cycle to identify
     regressions.

I'd probably vote for (b), followed by (a). Option (c) seems like a lot
of risk for little benefit.

But we could punt on that part until after the release. The only thing
we'd need to decide on now is that first set of reversions. What I
really _don't_ want to do is ship v2.15 with "always works like auto"
and then flip that back in v2.16.

I know you're probably infuriated with me because I'm essentially
arguing the opposite of what I did earlier in the cycle. And I really am
OK with going either way (shipping what's in -rc1 plus the "let 'always'
work from the command line", or doing something like what I outlined
above). But you've convinced me that the road I was going down really is
piling up the hacks, and I want to make it clear that I'm not married to
following the path I outlined earlier, and that I think there _is_ a
viable alternative.

-Peff
