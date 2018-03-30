Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26AE1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeC3VSr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:18:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752753AbeC3VSq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:18:46 -0400
Received: (qmail 372 invoked by uid 109); 30 Mar 2018 21:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 21:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 591 invoked by uid 111); 30 Mar 2018 21:19:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 17:19:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 17:18:44 -0400
Date:   Fri, 30 Mar 2018 17:18:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 11/13] pack-objects: shrink size field in struct
 object_entry
Message-ID: <20180330211844.GI14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-12-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-12-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:51AM +0100, Nguyễn Thái Ngọc Duy wrote:

> It's very very rare that an uncompressed object is larger than 4GB
> (partly because Git does not handle those large files very well to
> begin with). Let's optimize it for the common case where object size
> is smaller than this limit.
> 
> Shrink size field down to 32 bits [1] and one overflow bit. If the
> size is too large, we read it back from disk. As noted in the previous
> patch, we need to return the delta size instead of canonical size when
> the to-be-reused object entry type is a delta instead of a canonical
> one.
> 
> Add two compare helpers that can take advantage of the overflow
> bit (e.g. if the file is 4GB+, chances are it's already larger than
> core.bigFileThreshold and there's no point in comparing the actual
> value).
> 
> Another note about oe_get_size_slow(). This function MUST be thread
> safe because SIZE() macro is used inside try_delta() which may run in
> parallel. Outside parallel code, no-contention locking should be dirt
> cheap (or insignificant compared to i/o access anyway). To exercise
> this code, it's best to run the test suite with something like
> 
>     make test GIT_TEST_OE_SIZE_BITS=2
> 
> which forces this code on all objects larger than 3 bytes.

OK, makes sense. Since we need it to be thread-safe, we have to use
read_lock(). Which means that oe_get_size_slow() is defined in
builtin/pack-objects.c. But the object_entry is defined in the
more-generic pack-objects.h.

So anybody besides builtin/pack-objects.c will have to implement their
own fallback when e->size_valid isn't true. Which is a little odd, but I
guess nobody else needs that field. It might bite us in the future, but
I'm willing to cross my fingers for now (the pack-objects.h header is
really just there to support the bitmap writing code, but even that
could in theory all get shoved into a single translation unit if we had
to).

> [1] it's actually already 32 bits on Windows

And linux-i386. :)

> +unsigned long oe_get_size_slow(struct packing_data *pack,
> +			       const struct object_entry *e)
> +{

I think I already replied about this earlier, so I'll skim over it this
time.

> diff --git a/pack-objects.c b/pack-objects.c
> index 13f2b2bff2..59c6e40a02 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -120,8 +120,15 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
>  {
>  	struct object_entry *new_entry;
>  
> -	if (!pdata->nr_objects)
> +	if (!pdata->nr_objects) {
>  		prepare_in_pack_by_idx(pdata);
> +		if (getenv("GIT_TEST_OE_SIZE_BITS")) {
> +			int bits = atoi(getenv("GIT_TEST_OE_SIZE_BITS"));;
> +			pdata->oe_size_limit = 1 << bits;
> +		}
> +		if (!pdata->oe_size_limit)
> +			pdata->oe_size_limit = 1 << OE_SIZE_BITS;
> +	}

This needs to be "1U << OE_SIZE_BITS". Shifting a signed integer 31 bits
is undefined.

No, I'm not that clever or careful myself. I ran the whole test suite
with SANITIZE=address,undefined and it turned this up, as well as a
similar case for OE_DELTA_SIZE_BITS.

> +	uint32_t size_:OE_SIZE_BITS;
> +	uint32_t size_valid:1;

A uint32_t bitfield? Would it make more sense to just call these
"unsigned", since we're specifying the precision already?

> +unsigned long oe_get_size_slow(struct packing_data *pack,
> +			       const struct object_entry *e);
> +static inline unsigned long oe_size(struct packing_data *pack,
> +				    const struct object_entry *e)
> +{
> +	if (e->size_valid)
> +		return e->size_;
> +
> +	return oe_get_size_slow(pack, e);
> +}

If oe_get_size_slow() fails to find an object's size, it dies. I'm
trying to think of whether that might hit funny corner cases with
racing. I don't _think_ so, because if the object truly goes away, we'd
be screwed during the writing phase anyway.

> +static inline int oe_size_less_than(struct packing_data *pack,
> +				    const struct object_entry *lhs,
> +				    unsigned long rhs)
> +{
> +	if (lhs->size_valid)
> +		return lhs->size_ < rhs;
> +	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
> +		return 0;
> +	return oe_get_size_slow(pack, lhs) < rhs;
> +}

Clever.

> +static inline void oe_set_size(struct packing_data *pack,
> +			       struct object_entry *e,
> +			       unsigned long size)
> +{
> +	if (size < pack->oe_size_limit) {
> +		e->size_ = size;
> +		e->size_valid = 1;
> +	} else {
> +		e->size_valid = 0;
> +		if (oe_get_size_slow(pack, e) != size)
> +			die("BUG: 'size' is supposed to be the object size!");
> +	}
> +}

That's an expensive assertion. But I guess this isn't supposed to happen
very frequently, so it's probably OK.

-Peff
