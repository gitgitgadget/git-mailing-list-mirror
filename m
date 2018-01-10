Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369FB1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 07:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933052AbeAJHmC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 02:42:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:39706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753842AbeAJHmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 02:42:01 -0500
Received: (qmail 16202 invoked by uid 109); 10 Jan 2018 07:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 07:42:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13337 invoked by uid 111); 10 Jan 2018 07:42:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 02:42:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 02:41:59 -0500
Date:   Wed, 10 Jan 2018 02:41:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
Message-ID: <20180110074159.GA16315@sigill.intra.peff.net>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
 <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
 <20180109072044.GD32257@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 09, 2018 at 02:15:47PM +0100, Johannes Schindelin wrote:

> > I like this direction a lot. I had hoped we could say "100+ commits
> > ahead",
> 
> How about "100+ commits apart" instead?

Yeah, that is probably more accurate for the general case.

> > but I don't think we can do so accurately without generation numbers.
> 
> Even with generation numbers, it is not possible to say whether two given
> commits reflect diverging branches or have an ancestor-descendant
> relationship (or in graph speak: whether they are comparable).
> 
> It could potentially make it possible to cut off the commit traversal, but
> I do not even see how that would be possible.
> 
> The only thing you could say for sure is that two different commits with
> the same generation number are for sure "uncomparable", i.e. reflect
> diverging branches.

I think sometimes we can say more. E.g., imagine we have two commits, A
and B, with generation numbers N and N+1000. We walk back 100 commits
deep from B and end up at a commit around N+900. We know that there are
at least 100 commits in B that are not in A (the 100 we walked, which we
know cannot be ancestors of A because of their generation numbers).
That's true even if there is no ancestry relationship between the two
commits at all.

But we cannot say in that case how many (if any) commits are in A but
not B. So we can say "100+ commits ahead, unknown behind" (or if the two
generation numbers are reversed, we can say "unknown ahead, 100+ commits
behind).

In the more general case, we could actually walk _past_ generation N,
and end up at N-25 or similar. There we can't say anything intelligent
about the commits with generations <= N. But we could say something like
"there are 75 commits in B that cannot be in A" (note that it's probably
_not_ actually 75; it's however many we walked until we crossed N).

So that was what I was getting at in the earlier mail. We can sometimes
give a partial answer. But I think giving that partial answer is likely
to be more confusing than useful to a user, because there are a lot of
caveats about how much we know for a given situation.

And I think from what you wrote below that you probably agree with that
(that we can make a few claims, but not enough to really be useful).

-Peff
