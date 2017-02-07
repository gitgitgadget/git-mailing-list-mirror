Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409081FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbdBGAOw (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:14:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59046 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbdBGAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:14:52 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 37DBC1FAFC;
        Tue,  7 Feb 2017 00:14:46 +0000 (UTC)
Date:   Tue, 7 Feb 2017 00:14:46 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their
 corresponding commits in `pu`
Message-ID: <20170207001446.GB7128@starla>
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
 <20170206204820.GA7128@starla>
 <20170206220754.5q2oddr5ej7c6qcg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170206220754.5q2oddr5ej7c6qcg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Mon, Feb 06, 2017 at 08:48:20PM +0000, Eric Wong wrote:
> 
> > I haven't hit insurmountable performance problems, even on
> > low-end hardware; especially since I started storing blob ids in
> > Xapian itself, avoiding the expensive tree lookup via git.
> 
> The painful thing is traversing the object graph for clones and fetches.
> Bitmaps help, but you still have to generate them.

Yep.  "public-inbox-init" defaults to enabling bitmaps in the
config for this reason.

> > The main problem seems to be tree size.  Deepening (2/2/36 vs
> > 2/38) might be an option (I think Peff brought that up); but it
> > might be easier to switch to YYYYMM refs (working like
> > logrotate) and rely on Xapian to tie the entire thing together.
> 
> Yes, the hashing is definitely one issue. Some numbers here:
> 
>   http://public-inbox.org/git/20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net/
> 
> If you have C commits on a tree with T entries, you have to do C*T hash
> lookups for a flat tree (for each commit, you have to see "yup, already
> saw that object"). Sharding that across H entries at the top level drops
> the tree cost from T to H + T/H (actually, it's a bit worse because we
> have to read the secondary tree, too). Sharding again (at H') gets you
> H + H' + T/H/H'.
> 
> Let's imagine you do one message per commit, so C=T. At 400K messages,
> that's about 160 billion hash lookups flat. At H=256, it's about 700
> million. If you shard again with H'=256, it's 200 million. After that,
> the additive terms start to dominate, and it's not worth going any
> further (and also, we're ignoring the extra-tree cost to each level).

Just to make sure I'm following, here; the entire formulas are:

	C * H + H' + (T / H / H')     # 2/2/36
	C * H + (T / H)               # 2/38 (current)

Right?

> At that point you're better off to start having fewer commits. I know
> that the schema you use does put useful information into the commit
> message, but it's also redundant with what's in the messages themselves.
> And it sounds like you push most of that out to Xapian anyway.

Yeah, there's no benefit to Xapian users for having any info in
the commit.  However, keeping commit-per-message is still
important to me to for better robustness from hardware and
network failures.

But yes, historical stuff could be squashed into a single commit
(much like how linux.git started with v2.6.12-rc2 without
history).  Perhaps some folks will care about NNTP article
numbering being non-chronological...

> Imagine your repo had one commit with 400K historical messages, and then
> grouped the new messages so that on average we got about 10 messages per
> commit (this doesn't seem unrealistic for something that commits every
> few minutes; the messages tend to be bunched in time; I ran some
> numbers against a 10-minute mark in the earlier message).
> 
> Then after another 100K messages, we'd have C=10,001 and T=500K. With
> two levels of hashing at 256 each, that's ~5 million hash lookups to
> walk the graph. And those numbers would be reasonable for a hosting site
> like GitHub.
> 
> I don't know what C is for the kernel repo, but I suspect with the right
> tuning it could be made into large-but-reasonable.

LKML probably has an upper bound of 30K messages per month;
so it could hit 100K in less than 4 months.  Worst case might
be 360K messages a year

	360000 * (256 + 256 + ((360000 + old) / 256 / 256))

That's still at least 180 million hash lookups after a year or
so of real-time updates; right?  (But probably closer to 240
million if there's 10 million old messages in there.

Instead, I think I will add an option to support logrotate-style
monthly heads (YYYYMM); keeping 2/38 and C == T:

	30000 * (256 + (30000 / 256))               => 11 million
	30000 * (256 + 256 + (30000 / 256 / 256))   => 15 million

The monthly heads would each be discontiguous history-wise;
so Xapian would become a requirement for users of this option
for Message-ID lookups, but histories would still be readable
with "git log"

One good side-effect of using monthly heads is --single-branch
clones may be used if someone lacks the bandwidth or space to do
a full mirror.  I'm not sure if the server-side (pack reuse,
bitmaps) will benefit other aside from bandwidth reductions,
though.


A (far-fetched) option I've considered would be to store entire
messages in the commit and have no trees or blobs at all.  But
that would require a significant rework, and would also make
Xapian a hard requirement for even checking if a message is
deleted or not.
