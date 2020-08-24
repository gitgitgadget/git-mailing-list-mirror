Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF1C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE0D2078D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHXUZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:25:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:39146 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgHXUZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:25:57 -0400
Received: (qmail 23724 invoked by uid 109); 24 Aug 2020 20:25:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2020 20:25:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17170 invoked by uid 111); 24 Aug 2020 20:25:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 16:25:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 16:25:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Possible bug with git restore
Message-ID: <20200824202556.GB709709@coredump.intra.peff.net>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
 <20200820134013.GA2526241@coredump.intra.peff.net>
 <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
 <20200820182720.GA2537643@coredump.intra.peff.net>
 <73bddcfc-f8c9-6ec1-328d-a2f427c4aef2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73bddcfc-f8c9-6ec1-328d-a2f427c4aef2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 12:29:23PM +0200, René Scharfe wrote:

> > So the fundamental issue is treating the pathspec in two different ways,
> > and then correlating the results. We need to either do a recursive match
> > for the tree match (as your patch does), or do non-recursive for this
> > index match (which I don't think is trivial, because of the way the
> > recursive flag works).
> 
> If using the same pathspec with both tree_entry_interesting and
> match_pathspec gives inconsistent results and can even lead to data loss
> as we've seen here, then we better prevent it.

Yeah, it would be nice to do away with this inconsistency entirely. I
don't know if that even causes user-visible behavior changes at this
point, though.

> The easiest way to do that would be to BUG out in match_pathspec if
> recursive is unset, to indicate that it doesn't support non-recursive
> matching.  Finding all the places that didn't bothered to set this flag
> since it doesn't affect match_pathspec anyway would be quite tedious,
> though.

Yeah. I think it's easier to approach it from the tree-entry side, and
say: which spots are not recursive, and could/should they be. Which I
think is where your patch below is going.

> At least the test suite still completes with the following evil patch
> and the fix I sent earlier (evil because it ignores const), so we
> currently don't have any other mismatches in covered code.

That's kind-of good news, in that it lends support to the notion that
basically everything wants to be recursive. But I'd be worried there's a
lingering code path that is not covered in the test suite. Certainly
shipping your BUG() patch would flush it out, but it's not very friendly
to users who do run into it.

I wonder if we can drop it to a warning() and see if anybody reports it.

Or the more-work but more-responsible version: manually trace all of the
pathspec calls to see which code paths might rely on leaving "recursive"
unset.

-Peff
