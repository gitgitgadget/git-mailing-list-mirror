From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/14] add a hashtable implementation that supports O(1) removal
Date: Thu, 07 Nov 2013 13:40:36 -0800
Message-ID: <xmqq4n7nriuj.fsf@gitster.dls.corp.google.com>
References: <527BA483.6040803@gmail.com> <527BA4F3.3040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 22:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXJn-0003mr-Ao
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 22:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab3KGVko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 16:40:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab3KGVkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 16:40:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B19155064B;
	Thu,  7 Nov 2013 16:40:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=dmTwYN4KxZ8F5CMzzjFudYKYqp0=; b=eMN+tNsZ43fBcaNUqIHu
	irYcjq6RL/5p+x8wMESO34kc7ZlFoi22U4o6DIs5+UEgS+SrDB1nR8oOJRmRXOB9
	lL/DVFEe/PpP97J6VN1v7k9yQBPjtKXa4Zg1vyTyJnfn+B8xaWgM0DLsyjuF47JI
	t+sOv7rFFr7kSQ9h2wwso5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Du4NaZv+zgT4IHKBQTsc0089c6YGDG3VIE3LCpOKoLOVAg
	N96MD5z/yBMLINVFT0idcGJYgCV/GdB7GUUVaBRronqqOdxbOL0ALW2xH1bDmkzD
	Qmvdukb23JmKujZVDAizumz24qjLDH//gXWlDeEie/xuTT8oTwq8ykE7l5p/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A66EF5064A;
	Thu,  7 Nov 2013 16:40:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E299050643;
	Thu,  7 Nov 2013 16:40:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E520ADE-47F5-11E3-903B-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237430>

Karsten Blees <karsten.blees@gmail.com> writes:

> +`void hashmap_add(struct hashmap *map, void *entry)`::
> +
> +	Adds a hashmap entry. This allows to add duplicate entries (i.e.
> +	separate values with the same key according to hashmap_cmp_fn).
> ++
> +`map` is the hashmap structure.
> ++
> +`entry` is the entry to add.
> +
> +`void *hashmap_put(struct hashmap *map, void *entry)`::
> +
> +	Adds or replaces a hashmap entry.
> ++
> +`map` is the hashmap structure.
> ++
> +`entry` is the entry to add or update.
> ++
> +Returns the previous entry, or NULL if not found (i.e. the entry was added).

What happens when there were duplicate entries previously added?
All are replaced?  One of them is randomly chosen and gets replaced?

With s/replaced/removed/, the same question applies to hashmap_remove().

I am guessing that "we pick one at random and pretend as if other
duplicates do not exist" is the answer, and I do not immediately
have an objection to that semantics, but whatever the rule is, it
needs to be spelled out.

> +`void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)`::
> +
> +	Removes a hashmap entry matching the specified key.
> ...
> +Usage example
> +-------------
> +
> +Here's a simple usage example that maps long keys to double values.
> +[source,c]
> +------------
> +struct hashmap map;
> +
> +struct long2double {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	long key;
> +	double value;
> +};
> +
> +static int long2double_cmp(const struct long2double *e1, const struct long2double *e2, const void *unused)
> +{
> +	return !(e1->key == e2->key);
> +}
> +
> +void long2double_init()

void long2double_init(void)

> +{
> +	hashmap_init(&map, (hashmap_cmp_fn) long2double_cmp, 0);
> +}
> +
> +void long2double_free()

Likewise.

> diff --git a/hashmap.c b/hashmap.c
> new file mode 100644
> index 0000000..3a9f8c1
> --- /dev/null
> +++ b/hashmap.c
> ...
> +unsigned int memhash(const void *buf, size_t len)
> +{
> +	unsigned int hash = FNV32_BASE;
> +	unsigned char *ucbuf = (unsigned char*) buf;

"(unsigned char *)buf"; pointer-asterisk does not stick to type.

> +	while (len--) {
> +		unsigned int c = *ucbuf++;
> +		hash = (hash * FNV32_PRIME) ^ c;
> +	}
> +	return hash;
> +}
> +
> +unsigned int memihash(const void *buf, size_t len)
> +{
> +	unsigned int hash = FNV32_BASE;
> +	unsigned char *ucbuf = (unsigned char*) buf;
> +	while (len--) {
> +		unsigned int c = *ucbuf++;
> +		if (c >= 'a' && c <= 'z')
> +			c -= 'a' - 'A';
> +		hash = (hash * FNV32_PRIME) ^ c;
> +	}
> +	return hash;
> +}
> +
> +#define HASHMAP_INITIAL_SIZE 64
> +/* grow / shrink by 2^2 */
> +#define HASHMAP_GROW 2
> +/* grow if > 80% full (to 20%) */
> +#define HASHMAP_GROW_AT 1.25
> +/* shrink if < 16.6% full (to 66.6%) */
> +#define HASHMAP_SHRINK_AT 6

May be I am too old fashioned, but seeing a floating-point constant
in our otherwise pretty-much integer-only code makes me feel uneasy.
"gcc -S -O2" does seem to generate floating point instruction for
"i" but not for "j":

    extern void inspect(unsigned int i, unsigned int j);

    void grow(unsigned int i, unsigned int j)
    {
            i *= 1.25;
            j += j >> 2;
            inspect(i, j);
    }

Perhaps

#define HASHMAP_GROW_AT(current) ((current) + (current) >> 2)
#define HASHMAP_SHRINK_AT(current) ((current) * 6)
#define HASHMAP_GROW(current) ((current) << 2)
#define HASHMAP_SHRINK(current) ((current) >> 2)

may alleviate my worries; I dunno.

> +
> +static inline int entry_equals(const struct hashmap *map,
> +		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
> +		const void *keydata)
> +{
> +	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2, keydata));

Our code tends not to say "this is a pointer to a function"
explicitly, i.e.

	!map->cmpfn(e1, e2, keydata)

is more in-line with our code and should also be sufficient.

> +}
> +
> +static inline unsigned int bucket(const struct hashmap *map,
> +		const struct hashmap_entry *key)
> +{
> +	return key->hash & (map->tablesize - 1);
> +}
> +
> +static void rehash(struct hashmap *map, unsigned int newsize)
> +{
> +	unsigned int i, oldsize = map->tablesize;
> +	struct hashmap_entry **oldtable = map->table;
> +
> +	map->tablesize = newsize;
> +	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);

Even though multiplication is commutative, please match the official
function signature, i.e.

	calloc(size_t nmemb, size_t size)

where the number of elements comes first and size of an element
comes next.  I.e.

	xcalloc(map->tablesize, sizeof(struct hashmap_entry *));

Also don't forget the SP between type and asterisk.

> +	for (i = 0; i < oldsize; i++) {
> +		struct hashmap_entry *e = oldtable[i];
> +		while (e) {
> +			struct hashmap_entry *next = e->next;
> +			unsigned int b = bucket(map, e);
> +			e->next = map->table[b];
> +			map->table[b] = e;
> +			e = next;
> +		}
> +	}
> +	free(oldtable);
> +}
> +
> +static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
> +		const struct hashmap_entry *key, const void *keydata)
> +{
> +	struct hashmap_entry **e = &map->table[bucket(map, key)];
> +	while (*e && !entry_equals(map, *e, key, keydata))
> +		e = &(*e)->next;
> +	return e;
> +}
> +
> +static int always_equal(const void *unused1, const void *unused2, const void *unused3)
> +{
> +	return 0;
> +}
> +
> +void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
> +		size_t initial_size)
> +{
> +	map->size = 0;
> +	map->cmpfn = equals_function ? equals_function : always_equal;
> +	/* calculate initial table size and allocate the table */
> +	map->tablesize = HASHMAP_INITIAL_SIZE;
> +	initial_size *= HASHMAP_GROW_AT;
> +	while (initial_size > map->tablesize)
> +		map->tablesize <<= HASHMAP_GROW;
> +	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
> +}
> +
> +void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
> +{

Why is free_function not part of the constants defiend at
hashmap_init() time?  Your API allows the same hashmap, depending on
the way it has been used, to be cleaned up with different
free_function, but I am not sure if that "flexibility" is intended
(and in what application it would be useful).

Just like a NULL passed for equals_function gets the internal
always_equal fallback function, if you make this a part of
hashmap_init(), a NULL passed for free_funcion can be used as a
signal to use the system's free(3) and you no longer have to say
"free from stdlib" in the docs and the comment.

> +	if (!map || !map->table)
> +		return;
> +	if (free_function) {
> +		struct hashmap_iter iter;
> +		struct hashmap_entry *e;
> +		hashmap_iter_init(map, &iter);
> +		while ((e = hashmap_iter_next(&iter)))
> +			(*free_function)(e);
> +	}
> +	free(map->table);
> +	memset(map, 0, sizeof(*map));
> +}
> +
> +void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
> +{
> +	return *find_entry_ptr(map, key, keydata);
> +}
> +
> +void *hashmap_get_next(const struct hashmap *map, const void *entry)
> +{
> +	struct hashmap_entry *e = ((struct hashmap_entry*) entry)->next;
> +	for (; e; e = e->next)
> +		if (entry_equals(map, entry, e, NULL))
> +			return e;
> +	return NULL;
> +}
> +
> +void hashmap_add(struct hashmap *map, void *entry)
> +{
> +	unsigned int b = bucket(map, entry);
> +
> +	/* add entry */
> +	((struct hashmap_entry*) entry)->next = map->table[b];
> +	map->table[b] = entry;
> +
> +	/* fix size and rehash if appropriate */
> +	map->size++;
> +	if (map->size * HASHMAP_GROW_AT > map->tablesize)
> +		rehash(map, map->tablesize << HASHMAP_GROW);
> +}
> +
> +void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
> +{
> +	struct hashmap_entry *old;
> +	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
> +	if (!*e)
> +		return NULL;
> +
> +	/* remove existing entry */
> +	old = *e;
> +	*e = old->next;
> +	old->next = NULL;
> +
> +	/* fix size and rehash if appropriate */
> +	map->size--;
> +	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
> +	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
> +		rehash(map, map->tablesize >> HASHMAP_GROW);

This "we shrink by the same amount" looks inconsistent with the use
of separate grow-at and shrink-at constants (see above for four
suggested #define's).

Thanks.
