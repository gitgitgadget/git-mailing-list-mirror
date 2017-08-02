Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B0D20899
	for <e@80x24.org>; Wed,  2 Aug 2017 20:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbdHBU2x (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 16:28:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:56110 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752442AbdHBU2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 16:28:52 -0400
Received: (qmail 25719 invoked by uid 109); 2 Aug 2017 20:28:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 20:28:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12320 invoked by uid 111); 2 Aug 2017 20:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 16:29:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 16:28:50 -0400
Date:   Wed, 2 Aug 2017 16:28:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
Message-ID: <20170802202850.y2gja3qnpw35olty@sigill.intra.peff.net>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 12:50:39PM -0700, Junio C Hamano wrote:

> With the traditional "packed-refs plus loose" layout, no matter how
> many times a handful of selected busy refs are updated during the
> day, you'd need to open at most two files to find out the current
> value of a single ref (admittedly, the accessing of the second file,
> after we realize that there is no loose one, would be very costly).
> If you make a few commits on a topic branch A, then build a 100
> commit series on top of another topic branch B, finding the current
> value of A is still one open and read of refs/heads/A.
> 
> With the reftable format, we'd need to open and read all 100
> incremental transactions that touch branch B before realizing that
> none of them talk about A, and read the next transaction file to
> find the current value of A.  To keep this number low, we'd need
> quite a frequent compaction.

I think this is where compaction cleverness can come in.

One relatively easy optimization would be to note when the most recent
reftable contains a subset of the refs we are currently updating (and
the obvious string-of-updates to a single ref falls under that), and do
a "quick" compaction where we simply drop[1] that reftable in favor of
ours. That compaction is essentially free, because we know those entries
aren't valid anymore anyway.

I'm actually not sure if this is a strict "drop", though, because of
reflogs. If the reflog is written into the same file as the ref update,
then you'd need to roll its entry into your new update, too. But see
below anyway.

For more complicated cases, there's some cleverness you can do with
small on-the-fly compactions. Even if there are entries in the last few
reftables that we're not currently updating, it's pretty cheap to roll a
few of them up into our new reftable if it lets us drop some
intermediate reftables. E.g., if we're writing a new reftable with a 4K
block size but only have 100 bytes of new data, we're probably best to
roll up a previous 500-byte reftable.

That one's an obvious optimization because we know that the filesystem
is going to make us spend 4K either way, so rounding up to that is
generally free-ish.

What's less obvious is when we should roll up a bunch of 4K tables into
one (let's say) 32K table.  I think there's a formula for doing this
geometrically so that the amortized cost of writing stays under a
certain bound (linear?). But I haven't thought it through (or looked it
up); I was hoping Shawn had already done so and could dump that wisdom
on us.

> We can just declare that reftable format is not for desktop clients
> but for server implementations where frequent compaction would not
> be an annoyance to the users, but I'd wish we do not have to.

Yeah, I agree we should avoid that. I would love to eventually kill off
the loose/packed backend (or at least make it historical and read-only,
so that a reasonable response to people complaining about its races and
lack of atomicity is "please upgrade to reftables").

-Peff
