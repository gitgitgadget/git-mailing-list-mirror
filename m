Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25AF1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 18:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeITAW5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 20:22:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732190AbeITAW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 20:22:57 -0400
Received: (qmail 8006 invoked by uid 109); 19 Sep 2018 18:43:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Sep 2018 18:43:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20287 invoked by uid 111); 19 Sep 2018 18:43:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Sep 2018 14:43:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2018 14:43:43 -0400
Date:   Wed, 19 Sep 2018 14:43:43 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] pack-objects: handle island check for "external" delta
 base
Message-ID: <20180919184343.GA13014@sigill.intra.peff.net>
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
 <20180919034907.GA7626@sigill.intra.peff.net>
 <CAN0heSpMRfDd7=E_kYL6ucL9bL2VWMGLTAkT72BUrVwR6YTezQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpMRfDd7=E_kYL6ucL9bL2VWMGLTAkT72BUrVwR6YTezQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 08:34:05PM +0200, Martin Ågren wrote:

> > +       /*
> > +        * First see if we're already sending the base (or it's explicitly in
> > +        * our "excluded" list.
> > +        */
> 
> Missing ')'.

Oops, yes.

> > +               if (use_delta_islands) {
> > +                       struct object_id base_oid;
> > +                       hashcpy(base_oid.hash, base_sha1);
> > +                       if (!in_same_island(&delta->idx.oid, &base_oid))
> > +                               return 0;
> 
> This does some extra juggling to avoid using `base->idx.oid`, which
> would have been the moral equivalent of the original code, but which
> won't fly since `base` is NULL.

Yeah, this is the actual bug-fix.

I wasn't happy about having to write in_same_island() twice, but writing
it the other way ended up pretty nasty, too. Something like:

  struct object_id ext_oid;
  struct object_id *base_oid;

  base = packlist_find(&to_pack, base_sha1, NULL);
  if (base) {
	base_oid = &base->idx.oid;
	*base_out = base;
  }
  else if (thin && bitmap_has_sha1_in_uninteresting(bitmap_git, base_sha1)) {
	hashcpy(ext_oid.hash, base_sha1);
	base_oid = &ext_oid;
	*base_out = NULL;
  } else {
	return 0;
  }

  if (use_island_marks && !in_same_island(&delta->idx.oid, base_oid))
	return 0;

  return 1;

That's less repetitive, but I feel like it's harder to follow which
variables are valid when.

> > +               if (can_reuse_delta(base_ref, entry, &base_entry)) {
> >                         oe_set_type(entry, entry->in_pack_type);
> >                         SET_SIZE(entry, in_pack_size); /* delta size */
> >                         SET_DELTA_SIZE(entry, in_pack_size);
> 
> Without being at all familiar with this code, this looks sane to me.
> Just had a small nit about the missing closing ')'.

Thanks for the review!

-Peff
