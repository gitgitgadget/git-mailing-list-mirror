Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A45C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DCA2076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgJ3OXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:23:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:42520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbgJ3OXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 10:23:51 -0400
Received: (qmail 7281 invoked by uid 109); 30 Oct 2020 14:23:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 14:23:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21653 invoked by uid 111); 30 Oct 2020 14:23:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 10:23:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 10:23:50 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 06/10] strmap: add more utility functions
Message-ID: <20201030142350.GF3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <61b5bf11103a7bd12de8fd066e128c469da3a0a4.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61b5bf11103a7bd12de8fd066e128c469da3a0a4.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:46AM +0000, Elijah Newren via GitGitGadget wrote:

> strmap_get_entry() is similar to strmap_get() except that instead of just
> returning the void* value that the string maps to, it returns the
> strmap_entry that contains both the string and the void* value (or
> NULL if the string isn't in the map).  This is helpful because it avoids
> multiple lookups, e.g. in some cases a caller would need to call:
>   * strmap_contains() to check that the map has an entry for the string
>   * strmap_get() to get the void* value
>   * <do some work to update the value>
>   * strmap_put() to update/overwrite the value

Oh, I guess I should have read ahead when responding to the last patch. :)

Yes, this function makes perfect sense to have (along with the simpler
alternatives for the callers that don't need this complexity).

>  strmap.c | 20 ++++++++++++++++++++
>  strmap.h | 38 ++++++++++++++++++++++++++++++++++++++

The implementation all looks pretty straight-forward.

> +void strmap_remove(struct strmap *map, const char *str, int free_util)
> +{
> +	struct strmap_entry entry, *ret;
> +	hashmap_entry_init(&entry.ent, strhash(str));
> +	entry.key = str;
> +	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
> +	if (!ret)
> +		return;
> +	if (free_util)
> +		free(ret->value);
> +	if (map->strdup_strings)
> +		free((char*)ret->key);
> +	free(ret);
> +}

Another spot that would be simplified by using FLEXPTRs. :)

> +/*
> + * Return whether the strmap is empty.
> + */
> +static inline int strmap_empty(struct strmap *map)
> +{
> +	return hashmap_get_size(&map->map) == 0;
> +}

Maybe:

  return strmap_get_size(&map) == 0;

would be slightly simpler (and more importantly, show callers the
equivalence between the two).

> +/*
> + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
> + */
> +#define strmap_for_each_entry(mystrmap, iter, var)	\
> +	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, \
> +						   OFFSETOF_VAR(var, ent)); \
> +		var; \
> +		var = hashmap_iter_next_entry_offset(iter, \
> +						     OFFSETOF_VAR(var, ent)))

Makes sense. This is like hashmap_for_each_entry, but we don't need
anyone to tell us the offset of "ent" within the struct.

I suspect we need the same "var = NULL" that hashmap recently got in
0ad621f61e (hashmap_for_each_entry(): workaround MSVC's runtime check
failure #3, 2020-09-30). Alternatively, I think you could drop
OFFSETOF_VAR completely in favor offsetof(struct strmap_entry, ent).

In fact, since we know the correct type for "var", we _could_ declare it
ourselves in a new block enclosing the loop. But that is probably making
the code too magic; people reading the code would say "huh? where is
entry declared?".

-Peff
