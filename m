From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v4 02/14] add a hashtable implementation that supports
 O(1) removal
Date: Fri, 08 Nov 2013 11:27:26 +0100
Message-ID: <527CBC8E.6050507@gmail.com>
References: <527BA483.6040803@gmail.com> <527BA4F3.3040806@gmail.com> <xmqq4n7nriuj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 11:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VejHs-0003xf-QH
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 11:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab3KHK1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 05:27:30 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:51630 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab3KHK11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 05:27:27 -0500
Received: by mail-we0-f176.google.com with SMTP id w62so1729005wes.21
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 02:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xXFyh+OorN7HruN8ltvzoboSOTImkzNYfZMeZvLqsV8=;
        b=VM5Ji962eGihjl85thZGDBhp00okfeq2go9NangLkultoRGLIkF+4PY46x9bIsNU4V
         EyKbkoOOjnJSv9hRZZ7cQ3zrkX60Kadr8yE2scrjHcuUFXKBQRn+xVMfjyr9TI9kUhuB
         +1fqhm37lPu5MOoFwYO7InEwbwmOC+AmV5dhsngeC+BAmYey1xMwMELzd98sT+iF+FXH
         h8UVbst0KL3akfDB8DPWxQncGWxwNlTjtj2/7tDkm43eXabi5zHYhb/NZ60oyOvw5xut
         vjUj1PlJgdpMJsjooPpaTAmrY2/PU1SUgzz4Tlm2GMYIVJvbJYl/S2emBRwRj+vDJcxi
         +Hqg==
X-Received: by 10.180.97.5 with SMTP id dw5mr1756457wib.42.1383906445769;
        Fri, 08 Nov 2013 02:27:25 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ee10sm4162850wic.4.2013.11.08.02.27.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 02:27:25 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq4n7nriuj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237449>

Am 07.11.2013 22:40, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> +`void hashmap_add(struct hashmap *map, void *entry)`::
>> +
>> +	Adds a hashmap entry. This allows to add duplicate entries (i.e.
>> +	separate values with the same key according to hashmap_cmp_fn).
>> ++
>> +`map` is the hashmap structure.
>> ++
>> +`entry` is the entry to add.
>> +
>> +`void *hashmap_put(struct hashmap *map, void *entry)`::
>> +
>> +	Adds or replaces a hashmap entry.
>> ++
>> +`map` is the hashmap structure.
>> ++
>> +`entry` is the entry to add or update.
>> ++
>> +Returns the previous entry, or NULL if not found (i.e. the entry was added).
> 
> What happens when there were duplicate entries previously added?
> All are replaced?  One of them is randomly chosen and gets replaced?
> 
> With s/replaced/removed/, the same question applies to hashmap_remove().
> 
> I am guessing that "we pick one at random and pretend as if other
> duplicates do not exist" is the answer, 

Exactly, however, you won't have duplicates if you use put exclusively.

> and I do not immediately
> have an objection to that semantics, but whatever the rule is, it
> needs to be spelled out.
> 

I'll clarify this.

>> +`void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)`::
>> +
>> +	Removes a hashmap entry matching the specified key.
>> ...
>> +Usage example
>> +-------------
>> +
>> +Here's a simple usage example that maps long keys to double values.
>> +[source,c]
>> +------------
>> +struct hashmap map;
>> +
>> +struct long2double {
>> +	struct hashmap_entry ent; /* must be the first member! */
>> +	long key;
>> +	double value;
>> +};
>> +
>> +static int long2double_cmp(const struct long2double *e1, const struct long2double *e2, const void *unused)
>> +{
>> +	return !(e1->key == e2->key);
>> +}
>> +
>> +void long2double_init()
> 
> void long2double_init(void)
> 
>> +{
>> +	hashmap_init(&map, (hashmap_cmp_fn) long2double_cmp, 0);
>> +}
>> +
>> +void long2double_free()
> 
> Likewise.
> 
>> diff --git a/hashmap.c b/hashmap.c
>> new file mode 100644
>> index 0000000..3a9f8c1
>> --- /dev/null
>> +++ b/hashmap.c
>> ...
>> +unsigned int memhash(const void *buf, size_t len)
>> +{
>> +	unsigned int hash = FNV32_BASE;
>> +	unsigned char *ucbuf = (unsigned char*) buf;
> 
> "(unsigned char *)buf"; pointer-asterisk does not stick to type.
> 

Ok, I'll recheck all casts.

>> +	while (len--) {
>> +		unsigned int c = *ucbuf++;
>> +		hash = (hash * FNV32_PRIME) ^ c;
>> +	}
>> +	return hash;
>> +}
>> +
>> +unsigned int memihash(const void *buf, size_t len)
>> +{
>> +	unsigned int hash = FNV32_BASE;
>> +	unsigned char *ucbuf = (unsigned char*) buf;
>> +	while (len--) {
>> +		unsigned int c = *ucbuf++;
>> +		if (c >= 'a' && c <= 'z')
>> +			c -= 'a' - 'A';
>> +		hash = (hash * FNV32_PRIME) ^ c;
>> +	}
>> +	return hash;
>> +}
>> +
>> +#define HASHMAP_INITIAL_SIZE 64
>> +/* grow / shrink by 2^2 */
>> +#define HASHMAP_GROW 2
>> +/* grow if > 80% full (to 20%) */
>> +#define HASHMAP_GROW_AT 1.25
>> +/* shrink if < 16.6% full (to 66.6%) */
>> +#define HASHMAP_SHRINK_AT 6
> 
> May be I am too old fashioned, but seeing a floating-point constant
> in our otherwise pretty-much integer-only code makes me feel uneasy.
> "gcc -S -O2" does seem to generate floating point instruction for
> "i" but not for "j":
> 
>     extern void inspect(unsigned int i, unsigned int j);
> 
>     void grow(unsigned int i, unsigned int j)
>     {
>             i *= 1.25;
>             j += j >> 2;
>             inspect(i, j);
>     }
> 

I guess there's no more i486SXs around, so using floating point should not be a problem (at least performance-wise...).

However, defining the constants inversely is a bit unintuitive (i.e. 1.25 instead of 0.8, 6 instead of 0.166). Perhaps the thresholds should also be calculated once on resize, not on every add / remove.

What about this:

#define HASHMAP_GROW_AT 80
#define HASHMAP_SHRINK_AT 16

...in rehash:

map->grow_at = (unsigned int)((uint64_t) map->tablesize * HASHMAP_GROW_AT / 100);
map->shrink_at = (unsigned int)((uint64_t) map->tablesize * HASHMAP_SHRINK_AT / 100);

...in add:

size++;
if (map->size > map->grow_at)

...in remove:

size--;
if (map->size < map->shrink_at)

> Perhaps
> 
> #define HASHMAP_GROW_AT(current) ((current) + (current) >> 2)
> #define HASHMAP_SHRINK_AT(current) ((current) * 6)
> #define HASHMAP_GROW(current) ((current) << 2)
> #define HASHMAP_SHRINK(current) ((current) >> 2)
> 
> may alleviate my worries; I dunno.
> 
>> +
>> +static inline int entry_equals(const struct hashmap *map,
>> +		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
>> +		const void *keydata)
>> +{
>> +	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2, keydata));
> 
> Our code tends not to say "this is a pointer to a function"
> explicitly, i.e.
> 
> 	!map->cmpfn(e1, e2, keydata)
> 
> is more in-line with our code and should also be sufficient.
> 
>> +}
>> +
>> +static inline unsigned int bucket(const struct hashmap *map,
>> +		const struct hashmap_entry *key)
>> +{
>> +	return key->hash & (map->tablesize - 1);
>> +}
>> +
>> +static void rehash(struct hashmap *map, unsigned int newsize)
>> +{
>> +	unsigned int i, oldsize = map->tablesize;
>> +	struct hashmap_entry **oldtable = map->table;
>> +
>> +	map->tablesize = newsize;
>> +	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
> 
> Even though multiplication is commutative, please match the official
> function signature, i.e.
> 
> 	calloc(size_t nmemb, size_t size)
> 
> where the number of elements comes first and size of an element
> comes next.  I.e.
> 
> 	xcalloc(map->tablesize, sizeof(struct hashmap_entry *));
> 
> Also don't forget the SP between type and asterisk.
> 
>> +	for (i = 0; i < oldsize; i++) {
>> +		struct hashmap_entry *e = oldtable[i];
>> +		while (e) {
>> +			struct hashmap_entry *next = e->next;
>> +			unsigned int b = bucket(map, e);
>> +			e->next = map->table[b];
>> +			map->table[b] = e;
>> +			e = next;
>> +		}
>> +	}
>> +	free(oldtable);
>> +}
>> +
>> +static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
>> +		const struct hashmap_entry *key, const void *keydata)
>> +{
>> +	struct hashmap_entry **e = &map->table[bucket(map, key)];
>> +	while (*e && !entry_equals(map, *e, key, keydata))
>> +		e = &(*e)->next;
>> +	return e;
>> +}
>> +
>> +static int always_equal(const void *unused1, const void *unused2, const void *unused3)
>> +{
>> +	return 0;
>> +}
>> +
>> +void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
>> +		size_t initial_size)
>> +{
>> +	map->size = 0;
>> +	map->cmpfn = equals_function ? equals_function : always_equal;
>> +	/* calculate initial table size and allocate the table */
>> +	map->tablesize = HASHMAP_INITIAL_SIZE;
>> +	initial_size *= HASHMAP_GROW_AT;
>> +	while (initial_size > map->tablesize)
>> +		map->tablesize <<= HASHMAP_GROW;
>> +	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
>> +}
>> +
>> +void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
>> +{
> 
> Why is free_function not part of the constants defiend at
> hashmap_init() time?  Your API allows the same hashmap, depending on
> the way it has been used, to be cleaned up with different
> free_function, but I am not sure if that "flexibility" is intended
> (and in what application it would be useful).
> 

The free_function is a convenience so you don't have to loop over the entries yourself. It is only needed by hashmap_free (e.g. remove() and put() return the entry without freeing it), so I don't see a reason to carry the free_function around from construction time.

Git uses overallocated structs a lot (i.e. ending in char name[FLEX_ARRAY]), so stdlib free is all we need so far. If the entries have char *name1; char *name2; which are individually allocated, you need a special free function. But perhaps this is a case of premature generalization and a simple 'to free or not to free' boolean would suffice.

> Just like a NULL passed for equals_function gets the internal
> always_equal fallback function, if you make this a part of
> hashmap_init(), a NULL passed for free_funcion can be used as a
> signal to use the system's free(3) and you no longer have to say
> "free from stdlib" in the docs and the comment.
> 

No, there are cases where the entries are not owned by the hashmap, so passing NULL = 'don't free entries' is a valid case. See name-hash.c:

	hashmap_free(&istate->name_hash, NULL);
	hashmap_free(&istate->dir_hash, free);

The cache_entries are owned by index_state.cache, while the dir_entries are our own.

>> +	if (!map || !map->table)
>> +		return;
>> +	if (free_function) {
>> +		struct hashmap_iter iter;
>> +		struct hashmap_entry *e;
>> +		hashmap_iter_init(map, &iter);
>> +		while ((e = hashmap_iter_next(&iter)))
>> +			(*free_function)(e);
>> +	}
>> +	free(map->table);
>> +	memset(map, 0, sizeof(*map));
>> +}
>> +
>> +void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
>> +{
>> +	return *find_entry_ptr(map, key, keydata);
>> +}
>> +
>> +void *hashmap_get_next(const struct hashmap *map, const void *entry)
>> +{
>> +	struct hashmap_entry *e = ((struct hashmap_entry*) entry)->next;
>> +	for (; e; e = e->next)
>> +		if (entry_equals(map, entry, e, NULL))
>> +			return e;
>> +	return NULL;
>> +}
>> +
>> +void hashmap_add(struct hashmap *map, void *entry)
>> +{
>> +	unsigned int b = bucket(map, entry);
>> +
>> +	/* add entry */
>> +	((struct hashmap_entry*) entry)->next = map->table[b];
>> +	map->table[b] = entry;
>> +
>> +	/* fix size and rehash if appropriate */
>> +	map->size++;
>> +	if (map->size * HASHMAP_GROW_AT > map->tablesize)
>> +		rehash(map, map->tablesize << HASHMAP_GROW);
>> +}
>> +
>> +void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
>> +{
>> +	struct hashmap_entry *old;
>> +	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
>> +	if (!*e)
>> +		return NULL;
>> +
>> +	/* remove existing entry */
>> +	old = *e;
>> +	*e = old->next;
>> +	old->next = NULL;
>> +
>> +	/* fix size and rehash if appropriate */
>> +	map->size--;
>> +	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
>> +	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
>> +		rehash(map, map->tablesize >> HASHMAP_GROW);
> 
> This "we shrink by the same amount" looks inconsistent with the use
> of separate grow-at and shrink-at constants (see above for four
> suggested #define's).
> 

These values account for a small hysteresis so that there is no size at which a sequence of add, remove, add, remove (or put, put, put, put) results in permanent resizes.

We grow at 80% (* 4 = 20% full after grow), and shrink at 16.6% ( / 4 = 66.6% full after shrink).
