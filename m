Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0B92047F
	for <e@80x24.org>; Thu, 28 Sep 2017 03:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbdI1DNE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 23:13:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58024 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752343AbdI1DND (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 23:13:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2292AAFC4F;
        Wed, 27 Sep 2017 23:13:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wcV47RA4xl52
        wMfB6XxK30Bsmek=; b=bg503dH2d0szDZn5iDWZ3x4jkAs8+nm/yqSsLaAmxKYR
        3yPXYVayjA50FZURmDVpvu7uBbgDYM5YO2E/D7FAop/dDPMX8TYU5Q4JEoZhs0TQ
        4VuXff6na1nJlS/OxpKKfGdG35SF6I3bRHw6tcEdKxf9xTOzGpYm1KO7YSji06E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iP6wPD
        fQqRskQvaINxSyO8vwUWg2cJ2aZaCvNFfYr5hJvcmuQ7LKyJwywK9Q1m2xNfJu6u
        ejW/uNMqsA1gm3fadMx9qK/IG9SnV0+cWeymuJY/mmMjdXqRoRQbkn/wS1AI+kOu
        JmR3UOkD/4f8mLVRuHsM55fSC2kxW4WICTVCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A352AFC4E;
        Wed, 27 Sep 2017 23:13:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 647E6AFC4D;
        Wed, 27 Sep 2017 23:13:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
References: <20170927221910.164552-1-jonathantanmy@google.com>
Date:   Thu, 28 Sep 2017 12:13:00 +0900
In-Reply-To: <20170927221910.164552-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 27 Sep 2017 15:19:10 -0700")
Message-ID: <xmqqr2ur348z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F025948C-A3FA-11E7-BA95-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is similar to using the hashmap in hashmap.c, but with an
> easier-to-use API. In particular, custom entry comparisons no longer
> need to be written, and lookups can be done without constructing a
> temporary entry structure.

A na=C3=AFve question is why this needs to duplicate so much code, just
to build something similar in spirit to hashmap but unlike hashmap
that can take caller-defined keys, limited to using oid as the keys,
instead of just being a thin API wrapper that uses hashmap as its
internal implementation detail. =20

Is the way hashmap API is structured so hard to use it in such a
way, or something?

>  Makefile |   1 +
>  oidmap.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  oidmap.h |  98 ++++++++++++++++++++++++++++++++++++++++
>  oidset.c |  38 ++++------------
>  oidset.h |   4 +-
>  5 files changed, 263 insertions(+), 30 deletions(-)
>  create mode 100644 oidmap.c
>  create mode 100644 oidmap.h
>
> diff --git a/Makefile b/Makefile
> index ed4ca438b..64136dde4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -821,6 +821,7 @@ LIB_OBJS +=3D notes-cache.o
>  LIB_OBJS +=3D notes-merge.o
>  LIB_OBJS +=3D notes-utils.o
>  LIB_OBJS +=3D object.o
> +LIB_OBJS +=3D oidmap.o
>  LIB_OBJS +=3D oidset.o
>  LIB_OBJS +=3D packfile.o
>  LIB_OBJS +=3D pack-bitmap.o
> diff --git a/oidmap.c b/oidmap.c
> new file mode 100644
> index 000000000..40e696cee
> --- /dev/null
> +++ b/oidmap.c
> @@ -0,0 +1,152 @@
> +#include "cache.h"
> +#include "oidmap.h"
> +
> +#define OIDMAP_INITIAL_SIZE 64
> +/* grow / shrink by 2^2 */
> +#define OIDMAP_RESIZE_BITS 2
> +/* load factor in percent */
> +#define OIDMAP_LOAD_FACTOR 80
> +
> +static void alloc_table(struct oidmap *map, unsigned int size)
> +{
> +	map->tablesize =3D size;
> +	map->table =3D xcalloc(size, sizeof(struct oidmap_entry *));
> +
> +	/* calculate resize thresholds for new size */
> +	map->grow_at =3D (unsigned int) ((uint64_t) size * OIDMAP_LOAD_FACTOR=
 / 100);
> +	if (size <=3D OIDMAP_INITIAL_SIZE)
> +		map->shrink_at =3D 0;
> +	else
> +		/*
> +		 * The shrink-threshold must be slightly smaller than
> +		 * (grow-threshold / resize-factor) to prevent erratic resizing,
> +		 * thus we divide by (resize-factor + 1).
> +		 */
> +		map->shrink_at =3D map->grow_at / ((1 << OIDMAP_RESIZE_BITS) + 1);
> +}
> +
> +static inline unsigned int bucket(const struct oidmap *map,
> +				  const struct object_id *key)
> +{
> +	unsigned int hash;
> +	memcpy(&hash, key->hash, sizeof(hash));
> +	return hash & (map->tablesize - 1);
> +}
> +
> +static void rehash(struct oidmap *map, unsigned int newsize)
> +{
> +	unsigned int i, oldsize =3D map->tablesize;
> +	struct oidmap_entry **oldtable =3D map->table;
> +
> +	alloc_table(map, newsize);
> +	for (i =3D 0; i < oldsize; i++) {
> +		struct oidmap_entry *e =3D oldtable[i];
> +		while (e) {
> +			struct oidmap_entry *next =3D e->next;
> +			unsigned int b =3D bucket(map, &e->oid);
> +			e->next =3D map->table[b];
> +			map->table[b] =3D e;
> +			e =3D next;
> +		}
> +	}
> +	free(oldtable);
> +}
> +
> +static inline struct oidmap_entry **find_entry_ptr(const struct oidmap=
 *map,
> +						   const struct object_id *key)
> +{
> +	struct oidmap_entry **e =3D &map->table[bucket(map, key)];
> +	while (*e && oidcmp(&(*e)->oid, key))
> +		e =3D &(*e)->next;
> +	return e;
> +}
> +
> +void oidmap_init(struct oidmap *map, size_t initial_size)
> +{
> +	unsigned int size =3D OIDMAP_INITIAL_SIZE;
> +
> +	memset(map, 0, sizeof(*map));
> +
> +	/* calculate initial table size and allocate the table */
> +	initial_size =3D (unsigned int) ((uint64_t) initial_size * 100
> +			/ OIDMAP_LOAD_FACTOR);
> +	while (initial_size > size)
> +		size <<=3D OIDMAP_RESIZE_BITS;
> +	alloc_table(map, size);
> +
> +	/*
> +	 * Keep track of the number of items in the map and
> +	 * allow the map to automatically grow as necessary.
> +	 */
> +	map->do_count_items =3D 1;
> +}
> +
> +void oidmap_free(struct oidmap *map, int free_entries)
> +{
> +	if (!map || !map->table)
> +		return;
> +	if (free_entries) {
> +		int i;
> +		for (i =3D 0; i < map->tablesize; i++) {
> +			struct oidmap_entry *e =3D map->table[i];
> +			while (e) {
> +				struct oidmap_entry *next =3D e->next;
> +				free(e);
> +				e =3D next;
> +			}
> +		}
> +	}
> +	free(map->table);
> +	memset(map, 0, sizeof(*map));
> +}
> +
> +void *oidmap_get(const struct oidmap *map, const struct object_id *key=
)
> +{
> +	return *find_entry_ptr(map, key);
> +}
> +
> +static void oidmap_add(struct oidmap *map, struct oidmap_entry *entry)
> +{
> +	unsigned int b =3D bucket(map, &entry->oid);
> +
> +	/* add entry */
> +	entry->next =3D map->table[b];
> +	map->table[b] =3D entry;
> +
> +	/* fix size and rehash if appropriate */
> +	if (map->do_count_items) {
> +		map->private_size++;
> +		if (map->private_size > map->grow_at)
> +			rehash(map, map->tablesize << OIDMAP_RESIZE_BITS);
> +	}
> +}
> +
> +void *oidmap_remove(struct oidmap *map, const struct object_id *key)
> +{
> +	struct oidmap_entry *old;
> +	struct oidmap_entry **e =3D find_entry_ptr(map, key);
> +	if (!*e)
> +		return NULL;
> +
> +	/* remove existing entry */
> +	old =3D *e;
> +	*e =3D old->next;
> +	old->next =3D NULL;
> +
> +	/* fix size and rehash if appropriate */
> +	if (map->do_count_items) {
> +		map->private_size--;
> +		if (map->private_size < map->shrink_at)
> +			rehash(map, map->tablesize >> OIDMAP_RESIZE_BITS);
> +	}
> +
> +	return old;
> +}
> +
> +void *oidmap_put(struct oidmap *map, void *entry)
> +{
> +	struct oidmap_entry *to_put =3D entry;
> +	struct oidmap_entry *old =3D oidmap_remove(map, &to_put->oid);
> +	oidmap_add(map, to_put);
> +	return old;
> +}
> diff --git a/oidmap.h b/oidmap.h
> new file mode 100644
> index 000000000..a543ed828
> --- /dev/null
> +++ b/oidmap.h
> @@ -0,0 +1,98 @@
> +#ifndef OIDMAP_H
> +#define OIDMAP_H
> +
> +/*
> + * struct oidmap_entry is a structure representing an entry in the has=
h table,
> + * which must be used as first member of user data structures. It must=
 be
> + * zero-initialized (or use OIDMAP_ENTRY_INIT).
> + */
> +struct oidmap_entry {
> +	/*
> +	 * next points to the next entry in case of collisions (i.e. if
> +	 * multiple entries map to the same bucket). For oidmap's internal us=
e
> +	 * only.
> +	 */
> +	struct oidmap_entry *next;
> +
> +	struct object_id oid;
> +};
> +#define OIDMAP_ENTRY_INIT { NULL }
> +
> +/*
> + * struct oidmap is the hash table structure. Members can be used as f=
ollows,
> + * but should not be modified directly.
> + */
> +struct oidmap {
> +	struct oidmap_entry **table;
> +
> +	/* total number of entries (0 means the hashmap is empty) */
> +	unsigned int private_size; /* use oidmap_get_size() */
> +
> +	/*
> +	 * tablesize is the allocated size of the hash table. A non-0 value
> +	 * indicates that the hashmap is initialized. It may also be useful
> +	 * for statistical purposes (i.e. `size / tablesize` is the current
> +	 * load factor).
> +	 */
> +	unsigned int tablesize;
> +
> +	unsigned int grow_at;
> +	unsigned int shrink_at;
> +
> +	unsigned int do_count_items : 1;
> +};
> +
> +/* oidmap functions */
> +
> +/*
> + * Initializes an oidmap structure.
> + *
> + * `map` is the oidmap to initialize.
> + *
> + * If the total number of entries is known in advance, the `initial_si=
ze`
> + * parameter may be used to preallocate a sufficiently large table and=
 thus
> + * prevent expensive resizing. If 0, the table is dynamically resized.
> + */
> +extern void oidmap_init(struct oidmap *map, size_t initial_size);
> +
> +/*
> + * Frees an oidmap structure and allocated memory.
> + *
> + * If `free_entries` is true, each oidmap_entry in the map is freed as=
 well
> + * using stdlibs free().
> + */
> +extern void oidmap_free(struct oidmap *map, int free_entries);
> +
> +/*
> + * Return the number of items in the map.
> + */
> +static inline unsigned int oidmap_get_size(struct oidmap *map)
> +{
> +	if (map->do_count_items)
> +		return map->private_size;
> +
> +	BUG("oidmap_get_size: size not set");
> +	return 0;
> +}
> +
> +/*
> + * Returns the oidmap entry for the specified oid, or NULL if not foun=
d.
> + */
> +extern void *oidmap_get(const struct oidmap *map,
> +			const struct object_id *key);
> +
> +/*
> + * Adds or replaces an oidmap entry.
> + *
> + * Returns the replaced entry, or NULL if not found (i.e. the entry wa=
s added).
> + */
> +extern void *oidmap_put(struct oidmap *map, void *entry);
> +
> +/*
> + * Removes an oidmap entry matching the specified oid.
> + *
> + * Returns the removed entry, or NULL if not found.
> + */
> +extern void *oidmap_remove(struct oidmap *map, const struct object_id =
*key);
> +
> +#endif
> diff --git a/oidset.c b/oidset.c
> index a6a08ba52..6fe7036c4 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -1,50 +1,30 @@
>  #include "cache.h"
>  #include "oidset.h"
> =20
> -struct oidset_entry {
> -	struct hashmap_entry hash;
> -	struct object_id oid;
> -};
> -
> -static int oidset_hashcmp(const void *unused_cmp_data,
> -			  const void *va, const void *vb,
> -			  const void *vkey)
> -{
> -	const struct oidset_entry *a =3D va, *b =3D vb;
> -	const struct object_id *key =3D vkey;
> -	return oidcmp(&a->oid, key ? key : &b->oid);
> -}
> -
>  int oidset_contains(const struct oidset *set, const struct object_id *=
oid)
>  {
> -	struct hashmap_entry key;
> -
> -	if (!set->map.cmpfn)
> +	if (!set->map.tablesize)
>  		return 0;
> -
> -	hashmap_entry_init(&key, sha1hash(oid->hash));
> -	return !!hashmap_get(&set->map, &key, oid);
> +	return !!oidmap_get(&set->map, oid);
>  }
> =20
>  int oidset_insert(struct oidset *set, const struct object_id *oid)
>  {
> -	struct oidset_entry *entry;
> -
> -	if (!set->map.cmpfn)
> -		hashmap_init(&set->map, oidset_hashcmp, NULL, 0);
> +	struct oidmap_entry *entry;
> =20
> -	if (oidset_contains(set, oid))
> +	if (!set->map.tablesize)
> +		oidmap_init(&set->map, 0);
> +	else if (oidset_contains(set, oid))
>  		return 1;
> =20
> -	entry =3D xmalloc(sizeof(*entry));
> -	hashmap_entry_init(&entry->hash, sha1hash(oid->hash));
> +	entry =3D xcalloc(1, sizeof(*entry));
>  	oidcpy(&entry->oid, oid);
> =20
> -	hashmap_add(&set->map, entry);
> +	oidmap_put(&set->map, entry);
>  	return 0;
>  }
> =20
>  void oidset_clear(struct oidset *set)
>  {
> -	hashmap_free(&set->map, 1);
> +	oidmap_free(&set->map, 1);
>  }
> diff --git a/oidset.h b/oidset.h
> index b7eaab5b8..b1ec82bfc 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -1,6 +1,8 @@
>  #ifndef OIDSET_H
>  #define OIDSET_H
> =20
> +#include "oidmap.h"
> +
>  /**
>   * This API is similar to sha1-array, in that it maintains a set of ob=
ject ids
>   * in a memory-efficient way. The major differences are:
> @@ -17,7 +19,7 @@
>   * A single oidset; should be zero-initialized (or use OIDSET_INIT).
>   */
>  struct oidset {
> -	struct hashmap map;
> +	struct oidmap map;
>  };
> =20
>  #define OIDSET_INIT { { NULL } }
