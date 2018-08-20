Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E4E1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeHUA7n (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 20:59:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:49772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726461AbeHUA7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 20:59:43 -0400
Received: (qmail 22924 invoked by uid 109); 20 Aug 2018 21:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Aug 2018 21:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11142 invoked by uid 111); 20 Aug 2018 21:42:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 Aug 2018 17:42:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2018 17:42:23 -0400
Date:   Mon, 20 Aug 2018 17:42:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180820214223.GB14995@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
 <20180817210604.GF20088@sigill.intra.peff.net>
 <xmqqa7pgbvie.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7pgbvie.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 02:03:53PM -0700, Junio C Hamano wrote:

> > So taking all of those options into account, what I ended up
> > with is a separate list of "external bases" that are not
> > part of the main packing list. Each delta entry that points
> > to an external base has a single-bit flag to do so; we have a
> > little breathing room in the bitfield section of
> > object_entry.
> >
> > This lets us limit the change primarily to the oe_delta()
> > and oe_set_delta_ext() functions. And as a bonus, most of
> > the rest of the code does not consider these dummy entries
> > at all, saving both runtime CPU and code complexity.
> 
> Tricky ;-)
> 
> I wonder if we can move the preferred base objects that we are not
> going to send also off of the "main packing list" to this new
> mechanism?

That gets trickier. Obviously we don't need to actually send them, so
they're ignored during the write phase. But we do put them into the
delta-search window along with the other objects, and we care about
things like their size and type (which our dummy objects do not even
have; they really are just placeholders for the oids).

So I'd guess that we'd end up with three arrays of entries:

 - objects we want to send, with full details including delta bases

 - preferred base objects with _some_ details

 - dummy thin objects for reused deltas

The trick is that I don't know which details fall under the "some" in
the second class. That could be extracted from a careful reading of the
code, but it seems like it has a high chance of regression (and I'm not
sure there's a huge upside, given that the code is already written
as-is).

I also worried about the same thing with these new reused dummy objects.
but I think by now I'd have shaken out any problems in production use.

> > +static struct bitmap_index *bitmap_git;
> > ...
> > +static int thin = 0;
> 
> Please trust what BSS will do to your static vars.

Heh. I copied the non-static declaration, but didn't think about
shortening it. Looks like there were one or two minor comments, so I'll
do a re-roll that addresses them.

-Peff
