Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8783203E3
	for <e@80x24.org>; Mon, 25 Jul 2016 22:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbcGYWOR (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:14:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:48916 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756447AbcGYWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:14:15 -0400
Received: (qmail 18459 invoked by uid 102); 25 Jul 2016 22:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 18:14:15 -0400
Received: (qmail 29787 invoked by uid 107); 25 Jul 2016 22:14:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 18:14:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 18:14:11 -0400
Date:	Mon, 25 Jul 2016 18:14:11 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
Message-ID: <20160725221411.GA14131@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net>
 <20160725185010.GA12974@sigill.intra.peff.net>
 <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
 <20160725214113.GA13589@sigill.intra.peff.net>
 <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 02:52:24PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   if (!*found_pack) {
> >     ... first find! fill in found pack, etc ...
> >   }
> >   if (exclude)
> > 	return 1;
> >   if (incremental)
> > 	return 0;
> >   if (!ignore_packed_keep && !local)
> > 	break; /* effectively return 1, but I think the break is more clear */
> >   if (local && !p->pack_local)
> > 	return 0;
> >   if (ignore_packed_keep && p->pack_local && p->pack_keep)
> > 	return 0;
> >
> > which just bumps it up. I don't think there is a way to make it more
> > elegant, e.g., by only checking ignore_packed_keep once, because we have
> > to distinguish between each condition being set independently, or the
> > case where neither is set.
> >
> > So I stuck the new check at the end, because to me logically it was "can
> > we break out of the loop instead of looking at p->next". But I agree it
> > would be equivalent to place it before the related checks, and I don't
> > mind doing that if you think it's more readable.
> 
> I do not mind too much about having to check two bools twice.  But
> given that the reason why I was confused was because I didn't see
> why we need to pass the two "return 0" conditions at least once
> before we decide that we do not need the "return 0" thing at all,
> and started constructing a case where this might break by writing
> "Suppose you have two packs, one remote and one local in packed_git
> list in this order, and ..." before I realized that the new "early
> break" can be hoisted up like the above, I definitely feel that "we
> found one, and we aren't conditionally pretending that this thing
> does not need to be packed at all, so return early and say we want
> to pack it" is easier to understand before the two existing "if"
> statements.

Ah, right. Now you had me second-guessing for a moment that there might
be a bad case in hoisting it up where we would want to return 0 but
would break out early to the "return 1".

But it cannot be the case, because the break is mutually exclusive with
the two conditions.

-Peff
