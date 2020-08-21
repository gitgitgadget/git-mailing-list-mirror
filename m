Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755EC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BE5208DB
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHUTtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:49:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37522 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgHUTs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:48:59 -0400
Received: (qmail 20141 invoked by uid 109); 21 Aug 2020 19:48:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 19:48:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31634 invoked by uid 111); 21 Aug 2020 19:48:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 15:48:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 15:48:57 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] strmap: new utility functions
Message-ID: <20200821194857.GD1165@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <a86fd5fdcc47baf85046eb07257f4db9f9498084.1598035949.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a86fd5fdcc47baf85046eb07257f4db9f9498084.1598035949.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:26PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Add strmap as a new struct and associated utility functions,
> specifically for hashmaps that map strings to some value.  The API is
> taken directly from Peff's proposal at
> https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Uh oh. You are encouraging me in the belief that I can send half-baked
ideas to the list and somebody will come along and implement them for
me. ;)

> Peff only included the header, not the implementation, so it isn't clear what
> the structure was he was going to use for the hash entries.  Instead of having
> my str_entry struct have three subfields (the hashmap_entry, the string, and
> the void* value), I made it only have two -- the hashmap_entry and a
> string_list_item, for two reasons:

I'd probably have done:

  struct strmap_entry {
	struct hashmap_entry ent;
	void *value;
	char key[FLEX_ALLOC];
  };

That saves 8 bytes (plus malloc overhead)per item, plus avoids an extra
pointer-chase for each item we consider when looking up.

>   1) a strmap is often the data structure we want where string_list has
>      been used in the past.  Using the same building block for
>      individual entries in both makes it easier to adopt and reuse
>      parts of the string_list API in strmap.

I can see that there might be some value in being able to interchange
the items for code that's expecting a string_list_item. But I have to
wonder if the potential for confusion is worth it. I.e., should that
code really be expecting a raw string pointer (possibly with a separate
void pointer, or even better an actual typed pointer).

I'll keep an eye out as I read the rest of the series for code which
uses this.

>   2) In some cases, after doing lots of other work, I want to be able
>      to iterate over the items in my strmap in sorted order.  hashmap
>      obviously doesn't support that, but I wanted to be able to export
>      the strmap to a string_list easily and then use its functions.
>      (Note: I do not need the data structure to both be sorted and have
>      efficient lookup at all times.  If I did, I might use a B-tree
>      instead, as suggested by brian in response to Peff in the thread
>      noted above.  In my case, most strmaps will never need sorting, but
>      in one special case at the very end of a bunch of other work I want
>      to iterate over the items in sorted order without doing any more
>      lookups afterward.)

Hmm. Likewise, I'll keep an eye open for how this works in practice. I
do suspect that a B-tree might be a better solution here, but
implementing it is non-trivial, and most callers don't care about this
property.

If the interim solution is to just dump it to a string_list and sort
that, that's really not that bad, assuming it just happens once after
we've added everything. I'm not sure there's that big a benefit to using
string_list_item internally, since presumably that conversion needs to
write a whole new array of string_list_items anyway.

> Also, I removed the STRMAP_INIT macro, since it cannot be used to
> correctly initialize a strmap; the underlying hashmap needs a call to
> hashmap_init() to allocate the hash table first.

Since access to the underlying hashmap happens through strmap functions,
they could lazily initialize it. That's how oidmap works.

> diff --git a/strmap.c b/strmap.c
> new file mode 100644
> index 0000000000..1c9fdb3b1e
> --- /dev/null
> +++ b/strmap.c
> @@ -0,0 +1,81 @@
> +#include "git-compat-util.h"
> +#include "strmap.h"
> +
> +static int cmp_str_entry(const void *hashmap_cmp_fn_data,
> +			 const struct hashmap_entry *entry1,
> +			 const struct hashmap_entry *entry2,
> +			 const void *keydata)
> +{
> +	const struct str_entry *e1, *e2;
> +
> +	e1 = container_of(entry1, const struct str_entry, ent);
> +	e2 = container_of(entry2, const struct str_entry, ent);
> +	return strcmp(e1->item.string, e2->item.string);
> +}

If you do go the FLEX_ALLOC route, obviously lookups won't want to
allocate a str_entry struct for the lookup key. You'd use keydata there
(and prefer it over looking at entry2 at all). See remotes_hash_cmp()
for an example.

> +static struct str_entry *find_str_entry(struct strmap *map,
> +					const char *str)
> +{
> +	struct str_entry entry;
> +	hashmap_entry_init(&entry.ent, strhash(str));
> +	entry.item.string = (char *)str;
> +	return hashmap_get_entry(&map->map, &entry, ent, NULL);
> +}

Casting away constness here is awkward. It could likewise benefit from
using keydata, so you wouldn't need to create a temporary
string_list_item (which is where the non-constness comes from).

> +void strmap_clear(struct strmap *map, int free_util)
> +{
> +	struct hashmap_iter iter;
> +	struct str_entry *e;
> +
> +	if (!map)
> +		return;

In a lazy-init world, this becomes:

  if (!map || !map->map.table)

Of course it would be better still if the hashmap code learned to do the
lazy-init stuff itself.

> +	hashmap_for_each_entry(&map->map, &iter, e, ent /* member name */) {
> +		free(e->item.string);
> +		if (free_util)
> +			free(e->item.util);
> +	}
> +	hashmap_free_entries(&map->map, struct str_entry, ent);

With a flex-alloc struct, you can avoid the extra string free. But I
guess you still wouldn't avoid the loop if you want to support
free_entries().

I wonder if it would make the API simpler if the struct knew whether it
owned the void pointer values or not. Then you'd do:

  struct strmap foo = { .free_values = 1 };
  ...
  strmap_put(&foo, "key", value);
  ...
  strmap_clear(&foo);

and wouldn't have to remember to do the right thing at clear-time. It is
a little less flexible (e.g., if you transfer ownership after a certain
point in the code), but I wonder if any callers actually need that (and
they could always set the free_values flag then).

> +/*
> + * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
> + * it does not need to persist after the this function is called.
> + *
> + * If an entry for "str" already exists, its data pointer is overwritten, and
> + * the original data pointer returned. Otherwise, returns NULL.
> + */
> +void *strmap_put(struct strmap *map, const char *str, void *data)

Minor, but IMHO we should avoid copying the docstrings to the
implementation, since it gives two places that people have to remember
to update if the API changes.

> +void *strmap_put(struct strmap *map, const char *str, void *data)
> +{
> +	struct str_entry *entry = find_str_entry(map, str);
> +	void *old = NULL;

In a lazy-init world, this is:

  if (!map->map.table) {
	strmap_init(map);
	entry = NULL;
  } else {
        entry = find_str_entry(map, str);
  }

(or just call find_str_entry() in both cases and let it realize there's
nothing to find).

> +	if (entry) {
> +		old = entry->item.util;
> +		entry->item.util = data;
> +	} else {
> +		entry = xmalloc(sizeof(*entry));
> +		hashmap_entry_init(&entry->ent, strhash(str));
> +		entry->item.string = strdup(str);
> +		entry->item.util = data;
> +		hashmap_add(&map->map, &entry->ent);
> +	}

And in a flex-alloc world, this second block is:

  FLEX_ALLOC_STR(entry, key, str);
  hashmap_entry_init(&entry->ent, strhash(str));
  entry->value = data;
  hashmap_add(&map->map, &entry->ent);

> +void *strmap_get(struct strmap *map, const char *str)
> +{
> +	struct str_entry *entry = find_str_entry(map, str);
> +	return entry ? entry->item.util : NULL;
> +}

In a lazy world, this is:

  if (!map->map.table)
          return NULL;

> +int strmap_contains(struct strmap *map, const char *str)
> +{
> +	return find_str_entry(map, str) != NULL;
> +}

And likewise:

  if (!map->map.table)
          return NULL;

It might actually be easier to stick that in find_str_entry().

The rest of it all looked good to me.

-Peff
