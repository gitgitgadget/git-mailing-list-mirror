Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ABF5203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbcGYSxS (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:53:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:48747 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752867AbcGYSxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 14:53:16 -0400
Received: (qmail 9964 invoked by uid 102); 25 Jul 2016 18:53:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:53:16 -0400
Received: (qmail 27523 invoked by uid 107); 25 Jul 2016 18:53:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:53:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 14:53:13 -0400
Date:	Mon, 25 Jul 2016 14:53:13 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160725185313.GA13007@sigill.intra.peff.net>
References: <20160713083044.GB18144@sigill.intra.peff.net>
 <20160713082653.GA18144@sigill.intra.peff.net>
 <20160713105216.GB16000@teco.navytux.spb.ru>
 <20160725184025.GA12297@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160725184025.GA12297@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 02:40:25PM -0400, Jeff King wrote:

> > @@ -1052,6 +1053,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
> >  {
> >  	uint32_t index_pos;
> >  
> > +	if (local && has_loose_object_nonlocal(sha1))
> > +		return 0;
> > +
> >  	if (have_duplicate_entry(sha1, 0, &index_pos))
> >  		return 0;
> 
> Hrm. Adding entries from the bitmap should ideally be very fast, but
> here we're introducing extra lookups in the object database. I guess it
> only kicks in when --local is given, though, which most bitmap-using
> paths would not do.
> 
> But is this check enough? The non-bitmap code path calls
> want_object_in_pack, which checks not only loose objects, but also
> non-local packs, and .keep.
> 
> Those don't kick in for your use case. I wonder if we should simply have
> something like:
> 
>   if (local || ignore_packed_keep)
> 	use_bitmap_index = 0;
> 
> and just skip bitmaps for those cases. That's easy to reason about, and
> I don't think anybody would care (your use case does not, and the repack
> use case is already not going to use bitmaps).

BTW, I thought we had more optimizations in this area, but I realized
that I had never sent them to the list. I just did, and you may want to
take a peek at:

  http://thread.gmane.org/gmane.comp.version-control.git/300218

I doubt it will speed up your case much (unless you really do have tons
of packs in your extraction). And I think it is still worth doing
disabling I showed above, even with the optimizations, just because it's
easier to reason about.

So I _think_ those optimizations are orthogonal to what we're discussing
here, but I wanted to point you at them just in case.

-Peff
