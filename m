Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B42208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeHFQ0y (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:26:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:43786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729374AbeHFQ0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:26:54 -0400
Received: (qmail 10271 invoked by uid 109); 6 Aug 2018 14:17:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 14:17:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25708 invoked by uid 111); 6 Aug 2018 14:17:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 10:17:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 10:17:33 -0400
Date:   Mon, 6 Aug 2018 10:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
Message-ID: <20180806141733.GD31282@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org>
 <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
 <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 05, 2018 at 08:53:19PM +0200, Christian Couder wrote:

> - 'layer' is used in add_to_write_order() which is called from many
> places in add_descendants_to_write_order() and compute_write_order()
> for example like this:
> 
>             for (s = DELTA_SIBLING(e); s; s = DELTA_SIBLING(s)) {
>                 add_to_write_order(wo, endp, s);
>             }
> 
> So it seems to me that moving 'layer' to 'struct packing_data' would
> require changing the DELTA_SIBLING macros or adding a hack to easily
> find the index in an array corresponding to a 'struct object_entry'.

Right, that hack is how the various the existing memory-shrinking macros
work. Every "struct object_entry *" that we deal with _must_ be in the
list in "packing_data", so that we can compute an index as
"entry - to_pack.objects".

So I think Duy is just suggesting:

  void oe_set_layer(struct packing_data *pack,
                    struct object_entry *entry,
		    int layer)
  {
          if (!pack->layers)
	          ALLOC_ARRAY(pack->layers, pack->nr_objects);
	  pack->layers[entry - pack->objects] = layer;
  }

  int oe_get_layer(struct packing_data *pack,
                   struct object_entry *entry)
  {
          if (!pack->layers)
	          return 0;
          return pack->layers[entry - pack->nr_objects];
  }

That said, I wonder if need to cache the layer at all. We compute the
layers all at once in the new compute_pack_layers(). But it is just a
linear walk over the objects, asking for each "is this in the core
island?".

Could we just ask "is this in the core island?" when we consider each
object? That's a hash lookup each time we ask instead of looking at our
int, but I'd think we would only ask in linear proportion to the number
of objects. So there's no algorithmic speedup, though maybe a
constant-time one (for two layers, I'd expect we'd probably ask about
each object twice).

> - I don't see why it is different from other fields in 'struct
> object_entry' that are also used in compute_write_order(), for
> example:
> 
>     uint32_t delta_idx;    /* delta base object */
>     uint32_t delta_child_idx; /* deltified objects who bases me */
>     uint32_t delta_sibling_idx; /* other deltified objects who ... */
> 
> Would we also want to move these fields to 'struct packing_data'? Why
> or why not? If we want to move them, then it might be a good idea to
> do all the moving at the same time to make sure we get something
> coherent.

We actually use those multiple times. They're reset and used in
compute_write_order(), but I think we use them earlier as part of the
delta search (at the very least we use delta_idx; maybe no the
child/sibling stuff).

-Peff
