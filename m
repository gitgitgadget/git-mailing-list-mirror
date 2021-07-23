Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F68C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FDF600D3
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhGWG5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:57:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:55396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhGWG5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:57:19 -0400
Received: (qmail 10210 invoked by uid 109); 23 Jul 2021 07:37:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:37:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22913 invoked by uid 111); 23 Jul 2021 07:37:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:37:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:37:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YPpx0KoGUX0KfdSw@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <YPft87yCjR9e+93E@coredump.intra.peff.net>
 <YPhXb9Zns8S6aIod@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPhXb9Zns8S6aIod@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 01:20:47PM -0400, Taylor Blau wrote:

> > > @@ -463,8 +488,11 @@ void bitmap_writer_build(struct packing_data *to_pack)
> > >  		struct commit *child;
> > >  		int reused = 0;
> > >
> > > -		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
> > > -				   old_bitmap, mapping);
> > > +		if (fill_bitmap_commit(ent, commit, &queue, &tree_queue,
> > > +				       old_bitmap, mapping) < 0) {
> > > +			closed = 0;
> > > +			break;
> > > +		}
> > >
> > >  		if (ent->selected) {
> > >  			store_selected(ent, commit);
> >
> > This is the right thing to do because we still want to free memory, stop
> > progress, etc. I gave a look over what will run after breaking out of
> > the loop, and compute_xor_offsets(), which you already handled, is the
> > only thing we'd want to avoid running. Good.
> 
> Right. The key is that we return "closed ? 0 : -1" (of course, being
> careful to invert "closed" where "1" OK into a suitable return value for
> bitmap_writer_build, where "0" means OK, and a negative number means
> "error").
> 
> While I'm thinking about that inversion, we *could* call this variable
> "open" and set it to "0" until proven otherwise. Then the conditional
> becomes "if (!open)", but the return value is still "return open ? -1 :
> 0" (since I assume we'd want to use 0/1 values for "open" instead of -1,
> meaning we'd have to do some translation).

I thought about suggesting that it be called "err" or "ret" or
something. And then we do not have to care that fill_bitmap_commit()
only returns an error in the non-closed state. We are simply propagating
its error-return back up the stack.

And then you can just write:

  ret = fill_bitmap_commit(...);
  if (ret < 0)
	break;

  ...
  return ret;

without an extra conversion. I don't care that much either way, though
(but if you like it and are re-rolling anyway... :) ).

-Peff
