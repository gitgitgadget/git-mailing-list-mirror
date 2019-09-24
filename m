Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FA31F463
	for <e@80x24.org>; Tue, 24 Sep 2019 06:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbfIXG6I (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 02:58:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:58004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388503AbfIXG6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 02:58:08 -0400
Received: (qmail 3131 invoked by uid 109); 24 Sep 2019 06:58:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 06:58:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7586 invoked by uid 111); 24 Sep 2019 07:00:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 03:00:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 02:58:06 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        rohit.ashiwal265@gmail.com, philip.wood123@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Git Test Coverage Report (Sept 19)
Message-ID: <20190924065806.GB30419@sigill.intra.peff.net>
References: <9fdd15ab-b2dc-f5fa-9969-90bd57014ff5@gmail.com>
 <1ed86989-9ba2-0cd7-b6f7-654d1943b1d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ed86989-9ba2-0cd7-b6f7-654d1943b1d7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 10:00:37AM -0400, Derrick Stolee wrote:

> > builtin/pack-objects.c
> > 7c59828b 2694) (reuse_packfile_bitmap &&
> > 7c59828b 2695)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
> 
> This change to obj_is_packed(oid) is a small change in a
> really big commit. Here is the change:

I'd suggest not looking too closely at this one yet. This was a
preliminary split by Christian of some older code that I had written. I
think it needs to be split up more, and probably does need more test
coverage (bitmaps are only enabled in a few specific scripts).

> @@ -2571,7 +2706,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>  
>  static int obj_is_packed(const struct object_id *oid)
>  {
> -       return !!packlist_find(&to_pack, oid, NULL);
> +       return packlist_find(&to_pack, oid, NULL) ||
> +               (reuse_packfile_bitmap &&
> +                bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
>  }
> 
> So, every time this is called, the || is short-circuited because
> packlist_find() returns true.

That does surprise me, though. I'm not sure if it's insufficient
testing, or if there's a bug. 

> Does this change the meaning of this method? obj_is_packed() would
> only return true if we found the object specifically in the to_pack
> list. Now, we would also return true if the object is in the bitmap
> walk.
> 
> If this is only a performance improvement, and the bitmap_walk_contains()
> method would return the same as packlist_find(), then should the order
> be swapped? Or rather, should reuse_packfile_bitmap indicate which to use
> as the full result?

No, there should be cases where the walk mentions some objects that
aren't added to the to_pack list (that's the point of the reuse code; it
fast-tracks a big chunk of objects directly to the output).

-Peff
