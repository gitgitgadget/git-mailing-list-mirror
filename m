Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61027C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0085A20782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgKDUnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:43:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:48052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbgKDUnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:43:50 -0500
Received: (qmail 11472 invoked by uid 109); 4 Nov 2020 20:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 20:43:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15508 invoked by uid 111); 4 Nov 2020 20:43:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 15:43:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 15:43:49 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 12/13] strmap: take advantage of FLEXPTR_ALLOC_STR
 when relevant
Message-ID: <20201104204349.GD3629238@coredump.intra.peff.net>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <7f93cbb525704c0bd254181082e3ed1a2782a2d2.1604343314.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f93cbb525704c0bd254181082e3ed1a2782a2d2.1604343314.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 06:55:12PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> By default, we do not use a mempool and strdup_strings is true; in this
> case, we can avoid both an extra allocation and an extra free by just
> over-allocating for the strmap_entry leaving enough space at the end to
> copy the key.  FLEXPTR_ALLOC_STR exists for exactly this purpose, so
> make use of it.
> 
> Also, adjust the case when we are using a memory pool and strdup_strings
> is true to just do one allocation from the memory pool instead of two so
> that the strmap_clear() and strmap_remove() code can just avoid freeing
> the key in all cases.

This turned out to be much less painful than I feared, and I think is
worth doing. Thanks for digging on it.

> +		if (map->strdup_strings) {
> +			if (!map->pool) {
> +				FLEXPTR_ALLOC_STR(entry, key, str);
> +			} else {
> +				/* Remember +1 for nul byte twice below */
> +				size_t len = strlen(str);
> +				entry = mem_pool_alloc(map->pool,
> +					       st_add3(sizeof(*entry), len, 1));
> +				memcpy(entry->keydata, str, len+1);
> +			}

Perhaps:

  size_t len = st_add(strlen(str), 1); /* include NUL */
  entry = mem_pool_alloc(map->pool, st_add(sizeof(*entry), len));
  memcpy(entry->keydata, str, len);

would be more obvious than the "remember to do it twice" comment?

With a FLEXPTR, I don't think you need keydata at all (since we would
never use that name; note that we don't even pass it in at all to
FLEXPTR_ALLOC_STR). Without that, I think your memcpy becomes:

  memcpy(entry + 1, str, len);

Remember that "entry" is a typed pointer, so "1" is really moving
sizeof(*entry) bytes.

> +		} else if (!map->pool) {
> +			entry = xmalloc(sizeof(*entry));
> +		} else {
> +			entry = mem_pool_alloc(map->pool, sizeof(*entry));
> +		}

OK, so if we're not strdup-ing then we either get a mempool or a fresh
entry. Makes sense.

>  		hashmap_entry_init(&entry->ent, strhash(str));
> -
> -		if (map->strdup_strings)
> -			key = map->pool ? mem_pool_strdup(map->pool, str)
> -					: xstrdup(str);
> -		entry->key = key;
> +		entry->key = map->strdup_strings ? entry->keydata : str;

I think this is subtly wrong in the FLEXPTR case. The data isn't in
keydata; it's directly after the struct. That's _usually_ the same
thing, but:

  - the compiler can put struct padding at the end if it wants

  - FLEX_ARRAY is usually zero, but for compatibility on some platforms
    it must be 1

The call to FLEXPTR_ALLOC_STR() will have already set it up properly
(and this is at best writing the same value, and at worst messing it
up).

I think you probably want to leave the FLEXPTR_ALLOC_STR() part alone,
put a:

  entry->key = (void *)(entry + 1);

line in the mem_pool code path, and then here do:

  if (!strdup_strings)
	entry->key = str;

-Peff
