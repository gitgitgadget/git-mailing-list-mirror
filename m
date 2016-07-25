Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764A6203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbcGYWKP (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:10:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:48883 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755118AbcGYVlR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 17:41:17 -0400
Received: (qmail 17056 invoked by uid 102); 25 Jul 2016 21:41:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 17:41:17 -0400
Received: (qmail 29349 invoked by uid 107); 25 Jul 2016 21:41:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 17:41:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 17:41:13 -0400
Date:	Mon, 25 Jul 2016 17:41:13 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
Message-ID: <20160725214113.GA13589@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net>
 <20160725185010.GA12974@sigill.intra.peff.net>
 <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 12:56:23PM -0700, Junio C Hamano wrote:

> > This function loops through each existing packfile, looking
> > for the object. When we find it, we mark the pack/offset
> > combo for later use. However, we can't just return "yes, we
> > want it" at that point. If --honor-pack-keep is in effect,
> > we must keep looking to find it in _all_ packs, to make sure
> > none of them has a .keep. Likewise, if --local is in effect,
> > we must make sure it is not present in any local pack.
> 
> s/any local pack/any non-local pack/, no?

Oops, yeah.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index a2f8cfd..55ef5a8 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -981,6 +981,8 @@ static int want_object_in_pack(const unsigned char *sha1,
> >  				return 0;
> >  			if (ignore_packed_keep && p->pack_local && p->pack_keep)
> >  				return 0;
> > +			if (!ignore_packed_keep && !local)
> > +				break;
> >  		}
> >  	}
> 
> OK, so in this loop, we may return "false" (meaning, we do not want
> to pack the object) if "local" (do not pack objects that appear in
> non-local packs) or "ignore_packed_keep" (do not pack objects that
> appear in locally kept packs) are in effect, but if neither of the
> options is set, we know that one of the preconditions ("local" or
> "ignore_packed_keep") for these two "reject by returning false" if
> statements would never trigger for any pack on packed_git list, so
> it is safe to break out and return the one that we have found.

Correct.

> If that is what is going on, I would have expected to see this early
> break before these "we found that this is available in borrowed pack
> and we are only packing local" and "we ignore objects in locally
> kept packs" checks return false.
> 
> Or am I not following the logic in the loop correctly?

Yeah, I think that would work. It has to come after "did we find this in
the pack", obviously. And it has to come after the other unrelated
checks ("are we just finding it to exclude?" and "are we
incremental?"). But you could do:

  if (!*found_pack) {
    ... first find! fill in found pack, etc ...
  }
  if (exclude)
	return 1;
  if (incremental)
	return 0;
  if (!ignore_packed_keep && !local)
	break; /* effectively return 1, but I think the break is more clear */
  if (local && !p->pack_local)
	return 0;
  if (ignore_packed_keep && p->pack_local && p->pack_keep)
	return 0;

which just bumps it up. I don't think there is a way to make it more
elegant, e.g., by only checking ignore_packed_keep once, because we have
to distinguish between each condition being set independently, or the
case where neither is set.

So I stuck the new check at the end, because to me logically it was "can
we break out of the loop instead of looking at p->next". But I agree it
would be equivalent to place it before the related checks, and I don't
mind doing that if you think it's more readable.

-Peff
