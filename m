Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1526C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917E120759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgKDUVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:21:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47852 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgKDUVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:21:53 -0500
Received: (qmail 11268 invoked by uid 109); 4 Nov 2020 20:21:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 20:21:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14752 invoked by uid 111); 4 Nov 2020 20:21:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 15:21:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 15:21:52 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 09/13] strmap: add functions facilitating use as a
 string->int map
Message-ID: <20201104202152.GB3629238@coredump.intra.peff.net>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <c1d217217180cff0b048d5dbac57b8e363db7848.1604343314.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1d217217180cff0b048d5dbac57b8e363db7848.1604343314.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 06:55:09PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Although strmap could be used as a string->int map, one either had to
> allocate an int for every entry and then deallocate later, or one had to
> do a bunch of casting between (void*) and (intptr_t).
> 
> Add some special functions that do the casting.  Also, rename put->set
> for such wrapper functions since 'put' implied there may be some
> deallocation needed if the string was already found in the map, which
> isn't the case when we're storing an int value directly in the void*
> slot instead of using the void* slot as a pointer to data.
> 
> A note on the name: if anyone has a better name suggestion than
> strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
> not been able to come up with a better name.

You can probably drop this last paragraph. It's good for review, but
probably not in the commit message. :)

> +void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
> +{
> +	struct strmap_entry *entry = find_strmap_entry(&map->map, str);
> +	if (entry) {
> +		intptr_t *whence = (intptr_t*)&entry->value;
> +		*whence += amt;
> +	}
> +	else
> +		strintmap_set(map, str, map->default_value + amt);
> +}

Here we use the new default_value. Neat.

> diff --git a/strmap.h b/strmap.h
> index 10b4642860..31474f781e 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -23,6 +23,11 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
>  			.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
>  			.strdup_strings = 1,                          \
>  		    }
> +#define STRINTMAP_INIT { \
> +			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
> +			.map.strdup_strings = 1,                          \
> +			.default_value = 0,                               \
> +		    }

Re-using STRMAP_INIT would shorten this (and avoid repeating internal
details of how strmap works). Like:

  #define STRINTMAP_INIT { \
	.map = STRMAP_INIT, \
	.default_value = 0, \
  }

You can also omit default_value, as the value of any un-mentioned
elements will get the usual C zero-initialization. So:

  #define STRINTMAP_INIT { .map = STRMAP_INIT }

would be sufficient (though I don't mind making the .default_value part
explicit). It could also be a parameter to the macro, but I suspect it
would be rarely used. I don't mind leaving it as something that advanced
callers can get from using strintmap_init().

> +/*
> + * strintmap:
> + *    A map of string -> int, typecasting the void* of strmap to an int.
> + *
> + * Primary differences:
> + *    1) Since the void* value is just an int in disguise, there is no value
> + *       to free.  (Thus one fewer argument to strintmap_clear)
> + *    2) strintmap_get() returns an int; it also requires an extra parameter to
> + *       be specified so it knows what value to return if the underlying strmap
> + *       has not key matching the given string.
> + *    3) No strmap_put() equivalent; strintmap_set() and strintmap_incr()
> + *       instead.
> + */

I think (2) here is out-of-date, as we now use map->default_value.

> +/*
> + * Returns the value for str in the map.  If str isn't found in the map,
> + * the map's default_value is returned.
> + */
> +static inline int strintmap_get(struct strintmap *map, const char *str)
> +{
> +	struct strmap_entry *result = strmap_get_entry(&map->map, str);
> +	if (!result)
> +		return map->default_value;
> +	return (intptr_t)result->value;
> +}

And we get to reuse default_value here again. Nice.

-Peff
