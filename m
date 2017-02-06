Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A241FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 22:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdBFWH6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 17:07:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:50163 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbdBFWH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 17:07:57 -0500
Received: (qmail 4062 invoked by uid 109); 6 Feb 2017 22:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 22:07:57 +0000
Received: (qmail 19360 invoked by uid 111); 6 Feb 2017 22:08:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 17:08:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 17:07:55 -0500
Date:   Mon, 6 Feb 2017 17:07:55 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their
 corresponding commits in `pu`
Message-ID: <20170206220754.5q2oddr5ej7c6qcg@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
 <20170206204820.GA7128@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170206204820.GA7128@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 08:48:20PM +0000, Eric Wong wrote:

> I haven't hit insurmountable performance problems, even on
> low-end hardware; especially since I started storing blob ids in
> Xapian itself, avoiding the expensive tree lookup via git.

The painful thing is traversing the object graph for clones and fetches.
Bitmaps help, but you still have to generate them.

> The main problem seems to be tree size.  Deepening (2/2/36 vs
> 2/38) might be an option (I think Peff brought that up); but it
> might be easier to switch to YYYYMM refs (working like
> logrotate) and rely on Xapian to tie the entire thing together.

Yes, the hashing is definitely one issue. Some numbers here:

  http://public-inbox.org/git/20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net/

If you have C commits on a tree with T entries, you have to do C*T hash
lookups for a flat tree (for each commit, you have to see "yup, already
saw that object"). Sharding that across H entries at the top level drops
the tree cost from T to H + T/H (actually, it's a bit worse because we
have to read the secondary tree, too). Sharding again (at H') gets you
H + H' + T/H/H'.

Let's imagine you do one message per commit, so C=T. At 400K messages,
that's about 160 billion hash lookups flat. At H=256, it's about 700
million. If you shard again with H'=256, it's 200 million. After that,
the additive terms start to dominate, and it's not worth going any
further (and also, we're ignoring the extra-tree cost to each level).

At that point you're better off to start having fewer commits. I know
that the schema you use does put useful information into the commit
message, but it's also redundant with what's in the messages themselves.
And it sounds like you push most of that out to Xapian anyway.

Imagine your repo had one commit with 400K historical messages, and then
grouped the new messages so that on average we got about 10 messages per
commit (this doesn't seem unrealistic for something that commits every
few minutes; the messages tend to be bunched in time; I ran some
numbers against a 10-minute mark in the earlier message).

Then after another 100K messages, we'd have C=10,001 and T=500K. With
two levels of hashing at 256 each, that's ~5 million hash lookups to
walk the graph. And those numbers would be reasonable for a hosting site
like GitHub.

I don't know what C is for the kernel repo, but I suspect with the right
tuning it could be made into large-but-reasonable.

-Peff
