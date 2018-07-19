Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3AB1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbeGSUBx (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 16:01:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:53054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731442AbeGSUBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 16:01:53 -0400
Received: (qmail 5900 invoked by uid 109); 19 Jul 2018 19:17:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 19:17:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14831 invoked by uid 111); 19 Jul 2018 19:17:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 15:17:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 15:17:20 -0400
Date:   Thu, 19 Jul 2018 15:17:20 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719191719.GA22504@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
 <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net>
 <20180719173135.GA24563@duynguyen.home>
 <20180719182442.GA5796@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719182442.GA5796@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 08:24:42PM +0200, Duy Nguyen wrote:

> > > Looking at that output, my _guess_ is that we somehow end up with a
> > > bogus delta_size value and write out a truncated entry. But I couldn't
> > > reproduce the issue with smaller test cases.
> > 
> > Could it be a race condition?
> 
> I'm convinced my code is racy (between two writes). I created a broken
> pack once with 32 threads. Elijah please try again with this new
> patch. It should fix this (I only tried repack a few times so far but
> will continue)

Good thinking, it's definitely racy. And that's why my tiny reproduction
didn't work. I even tried bumping it up to 10 blobs instead of 2, but
that's not nearly enough.

> The race is this
> 
> 1. Thread one sees a large delta size and NULL delta_size[] array,
>    allocates the new array and in the middle of copying old delta
>    sizes over.
> 
> 2. Thread two wants to write a new (large) delta size. It sees that
>    delta_size[] is already allocated, it writes the correct size there
>    (and truncated one in object_entry->delta_size_)
> 
> 3. Back to thread one, it now copies the truncated value in
>    delta_size_ from step 2 to delta_size[] array, overwriting the good
>    value that thread two wrote.

Right. Or we could even allocate two delta_size arrays, since the
NULL-check and the allocation are not atomic.

> There is also a potential read/write race where a read from
> pack_size[] happens when the array is not ready. But I don't think it
> can happen with current try_delta() code. I protect it anyway to be
> safe.

Hrm. That one's disappointing, because we read much more often than we
write, and this introduces potential lock contention. It may not matter
much in practice, though.

> +static unsigned long oe_delta_size(struct packing_data *pack,
> +				   const struct object_entry *e)
> +{
> +	unsigned long size;
> +
> +	read_lock();	 /* to protect access to pack->delta_size[] */
> +	if (pack->delta_size)
> +		size = pack->delta_size[e - pack->objects];
> +	else
> +		size = e->delta_size_;
> +	read_unlock();
> +	return size;
> +}

Yuck, we even have to pay the read_lock() cost when we don't overflow
into the pack->delta_size array (but I agree we have to for
correctness).

Again, though, this amount of contention probably doesn't make a big
difference, since we're holding the lock for such a short time
(especially compared to all the work of computing the deltas).

This could be separate from the read_lock(), though, since that one does
block for much longer (e.g., while zlib inflating objects from disk).

> +static void oe_set_delta_size(struct packing_data *pack,
> +			      struct object_entry *e,
> +			      unsigned long size)
> +{
> +	read_lock();	 /* to protect access to pack->delta_size[] */
> +	if (!pack->delta_size && size < pack->oe_delta_size_limit) {
> +		e->delta_size_ = size;
> +		read_unlock();
> +		return;
> +	}

And ditto for this one. I thought we could get away with the "fast case"
skipping the lock, but we have to check pack->delta_size atomically to
even use it.

If each individual delta_size had an overflow bit that indicates "use me
literally" or "look me up in the array", then I think the "quick" ones
could avoid locking. It may not be worth the complexity though.

> @@ -160,6 +162,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
>  
>  		if (!pdata->in_pack_by_idx)
>  			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
> +		if (pdata->delta_size)
> +			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
>  	}
>  

This realloc needs to happen under the lock, too, I think. It would be
OK without locking for an in-place realloc, but if the chunk has to be
moved, somebody in oe_set_delta_size() might write to the old memory.

This is in a file that doesn't even know about read_lock(), of course.
Probably you need a delta mutex as part of the "struct packing_data",
and then it can just be handled inside pack-objects.c entirely.

-Peff
