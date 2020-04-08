Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3267C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B99B2078E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDHWIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:08:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:37608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726607AbgDHWIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 18:08:41 -0400
Received: (qmail 13926 invoked by uid 109); 8 Apr 2020 22:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 22:08:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13290 invoked by uid 111); 8 Apr 2020 22:19:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 18:19:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 18:08:40 -0400
From:   Jeff King <peff@peff.net>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] oidmap: rework iterators to return typed pointer
Message-ID: <20200408220840.GB3468797@coredump.intra.peff.net>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
 <20200408070346.24872-1-abhishekkumar8222@gmail.com>
 <20200408070346.24872-2-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408070346.24872-2-abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 12:33:46PM +0530, Abhishek Kumar wrote:

> 87571c3f (hashmap: use *_entry APIs for iteration, 2019-10-06) modified
> hashmap_iter_next() to return a hashmap_entry pointer instead of void
> pointer.
> 
> However, oidmap_iter_next() is unaware of the struct type containing
> oidmap_entry and explicitly returns a void pointer.
> 
> Rework oidmap_iter_next() to include struct type and return appropriate
> pointer. This allows for compile-time type checks.

Yes, I think returning a pointer to an oidmap_entry makes sense. And
then we get type safety, and anybody who wants embed an oidmap_entry can
use container_of() to get back to their original struct.

But...

> +/*
> + * Returns the next entry, or NULL if there are no more entries.
> + *
> + * The entry is of @type (e.g. "struct foo") and has a member of type struct
> + * oidmap_entry.
> + */
> +#define oidmap_iter_next(iter, type) \
> +	(type *) hashmap_iter_next(&(iter)->h_iter)

This cast is turning a hashmap_entry into whatever type the caller
passed in.  But it's doing it with a straight cast. We know that
hashmap_entry and oidmap_entry pointers are equivalent, but we don't
know where the oidmap_entry is with respect to the user's type.

I think oidmap_iter_next() should continue to be a function that returns
an oidmap_entry pointer (and use container_of_or_null() to get to it
from the hashmap_entry, even though we know the offset is 0).

And then the caller can either use container_of() to get to their
original struct, or we can provide a helper macro. See the difference
between hashmap_iter_first() and hashmap_iter_first_entry().

There's no hashmap_iter_next_entry(). There could be, but instead it
skipped straight to hashmap_for_each_entry(), which uses an offset
within the variable rather than the type. But likewise, we could add
oidmap_for_each_entry() here.

> diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
> index 0acf99931e..a28bf007a8 100644
> --- a/t/helper/test-oidmap.c
> +++ b/t/helper/test-oidmap.c
> @@ -96,7 +96,7 @@ int cmd__oidmap(int argc, const char **argv)
>  
>  			struct oidmap_iter iter;
>  			oidmap_iter_init(&map, &iter);
> -			while ((entry = oidmap_iter_next(&iter)))
> +			while ((entry = oidmap_iter_next(&iter, struct test_entry)))
>  				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);

This works because "test_entry" has the oidmap_entry at the start.

But it wouldn't work with a struct where that wasn't the case, nor would
it provide any compile-time safety (because of the cast).

Note that if we do want to support that and get type safety (and I think
it is worth doing), oidmap_get() would need similar treatment (it
returns a void pointer, but it is really a pointer to an oidmap_entry).
And I guess oidmap_put() and oidmap_remove(), which returns pointers to
existing entries.

-Peff
