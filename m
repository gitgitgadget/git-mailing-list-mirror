From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 02/14] add a hashtable implementation that supports O(1)
 removal
Date: Thu, 07 Nov 2013 15:34:27 +0100
Message-ID: <527BA4F3.3040806@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQfG-0004aj-5u
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab3KGOe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:34:27 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:56931 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab3KGOeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:34:25 -0500
Received: by mail-wg0-f52.google.com with SMTP id k14so605966wgh.19
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ju3TmxJ0UBpF7IbhCgjKfq7i3aqebxZ1M4MlQidtQBg=;
        b=hNzL6pnh/HwAl42AK/0oSd8KQiTYAXEpbDly7sXRYSiOp+vKe6wwmAsER+38yNoKNu
         g3L8+s14bHS3vqTFd5Iqp6mOzzKEo8uuP85fsysrClpGD82ONojyl2I2E7Xtogbia5jl
         ecLNrsLcwUaULt5irt6guUpVKYZAQnxqNuLYK5Mom5ujNvPkNYEBMTlFjdn+5kqfYpLm
         ZGatLFquEsQ55vwoXw86pF3FIrLYvnbpCrZiCEHE9nFgQfHmBAjN+G/LGF3T5LJnUkpW
         KccvKrI1aaXLVT7YcHioEmgHmV2gS/YiqFXPiciBhFmcZWae2Qq1kL9GDnz+cuuF6T7V
         JdHQ==
X-Received: by 10.180.11.166 with SMTP id r6mr2999788wib.9.1383834863574;
        Thu, 07 Nov 2013 06:34:23 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey4sm7459595wic.11.2013.11.07.06.34.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:34:22 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237397>

The existing hashtable implementation (in hash.[ch]) uses open addressing
(i.e. resolve hash collisions by distributing entries across the table).
Thus, removal is difficult to implement with less than O(n) complexity.
Resolving collisions of entries with identical hashes (e.g. via chaining)
is left to the client code.

Add a hashtable implementation that supports O(1) removal and is slightly
easier to use due to builtin entry chaining.

Supports all basic operations init, free, get, add, remove and iteration.

Also includes ready-to-use hash functions based on the public domain FNV-1
algorithm (http://www.isthe.com/chongo/tech/comp/fnv).

The per-entry data structure (hashmap_entry) is piggybacked in front of
the client's data structure to save memory. See test-hashmap.c for usage
examples.

The hashtable is resized by a factor of four when 80% full. With these
settings, average memory consumption is about 2/3 of hash.[ch], and
insertion is about twice as fast due to less frequent resizing.

Lookups are also slightly faster, because entries are strictly confined to
their bucket (i.e. no data of other buckets needs to be traversed).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-hashmap.txt | 237 ++++++++++++++++++++++
 Makefile                                |   3 +
 hashmap.c                               | 212 ++++++++++++++++++++
 hashmap.h                               |  72 +++++++
 t/t0011-hashmap.sh                      | 236 ++++++++++++++++++++++
 test-hashmap.c                          | 340 ++++++++++++++++++++++++++++++++
 6 files changed, 1100 insertions(+)
 create mode 100644 Documentation/technical/api-hashmap.txt
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
new file mode 100644
index 0000000..fc46e56
--- /dev/null
+++ b/Documentation/technical/api-hashmap.txt
@@ -0,0 +1,237 @@
+hashmap API
+===========
+
+The hashmap API is a generic implementation of hash-based key-value mappings.
+
+Data Structures
+---------------
+
+`struct hashmap`::
+
+	The hash table structure.
++
+The `size` member keeps track of the total number of entries. The `cmpfn`
+member is a function used to compare two entries for equality. The `table` and
+`tablesize` members store the hash table and its size, respectively.
+
+`struct hashmap_entry`::
+
+	An opaque structure representing an entry in the hash table, which must
+	be used as first member of user data structures. Ideally it should be
+	followed by an int-sized member to prevent unused memory on 64-bit
+	systems due to alignment.
++
+The `hash` member is the entry's hash code and the `next` member points to the
+next entry in case of collisions (i.e. if multiple entries map to the same
+bucket).
+
+`struct hashmap_iter`::
+
+	An iterator structure, to be used with hashmap_iter_* functions.
+
+Types
+-----
+
+`int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key, const void *keydata)`::
+
+	User-supplied function to test two hashmap entries for equality. Shall
+	return 0 if the entries are equal.
++
+This function is always called with non-NULL `entry` / `entry_or_key`
+parameters that have the same hash code. When looking up an entry, the `key`
+and `keydata` parameters to hashmap_get and hashmap_remove are always passed
+as second and third argument, respectively. Otherwise, `keydata` is NULL.
+
+`void (*hashmap_free_fn)(void *entry)`::
+
+	User-supplied function to free a hashmap_entry. If entries are simply
+	malloc'ed memory, use stdlib's free() function.
+
+Functions
+---------
+
+`unsigned int strhash(const char *buf)`::
+`unsigned int strihash(const char *buf)`::
+`unsigned int memhash(const void *buf, size_t len)`::
+`unsigned int memihash(const void *buf, size_t len)`::
+
+	Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
+	http://www.isthe.com/chongo/tech/comp/fnv).
++
+`strhash` and `strihash` take 0-terminated strings, while `memhash` and
+`memihash` operate on arbitrary-length memory.
++
+`strihash` and `memihash` are case insensitive versions.
+
+`void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function, size_t initial_size)`::
+
+	Initializes a hashmap structure.
++
+`map` is the hashmap to initialize.
++
+The `equals_function` can be specified to compare two entries for equality.
+If NULL, entries are considered equal if their hash codes are equal.
++
+If the total number of entries is known in advance, the `initial_size`
+parameter may be used to preallocate a sufficiently large table and thus
+prevent expensive resizing. If 0, the table is dynamically resized.
+
+`void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)`::
+
+	Frees a hashmap structure and allocated memory.
++
+`map` is the hashmap to free.
++
+If `free_function` is specified (not NULL), it is called to free each
+hashmap_entry in the map. If entries are simply malloc'ed, use stdlib's free().
+
+`void hashmap_entry_init(void *entry, int hash)`::
+
+	Initializes a hashmap_entry structure.
++
+`entry` points to the entry to initialize.
++
+`hash` is the hash code of the entry.
+
+`void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)`::
+
+	Returns the hashmap entry for the specified key, or NULL if not found.
++
+`map` is the hashmap structure.
++
+`key` is a hashmap_entry structure (or user data structure that starts with
+hashmap_entry) that has at least been initialized with the proper hash code
+(via `hashmap_entry_init`).
++
+If an entry with matching hash code is found, `key` and `keydata` are passed
+to `hashmap_cmp_fn` to decide whether the entry matches the key.
+
+`void *hashmap_get_next(const struct hashmap *map, const void *entry)`::
+
+	Returns the next equal hashmap entry, or NULL if not found. This can be
+	used to iterate over duplicate entries (see `hashmap_add`).
++
+`map` is the hashmap structure.
++
+`entry` is the hashmap_entry to start the search from, obtained via a previous
+call to `hashmap_get` or `hashmap_get_next`.
+
+`void hashmap_add(struct hashmap *map, void *entry)`::
+
+	Adds a hashmap entry. This allows to add duplicate entries (i.e.
+	separate values with the same key according to hashmap_cmp_fn).
++
+`map` is the hashmap structure.
++
+`entry` is the entry to add.
+
+`void *hashmap_put(struct hashmap *map, void *entry)`::
+
+	Adds or replaces a hashmap entry.
++
+`map` is the hashmap structure.
++
+`entry` is the entry to add or update.
++
+Returns the previous entry, or NULL if not found (i.e. the entry was added).
+
+`void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)`::
+
+	Removes a hashmap entry matching the specified key.
++
+`map` is the hashmap structure.
++
+`key` is a hashmap_entry structure (or user data structure that starts with
+hashmap_entry) that has at least been initialized with the proper hash code
+(via `hashmap_entry_init`).
++
+If an entry with matching hash code is found, `key` and `keydata` are
+passed to `hashmap_cmp_fn` to decide whether the entry matches the key.
++
+Returns the removed entry, or NULL if not found.
+
+`void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)`::
+`void *hashmap_iter_next(struct hashmap_iter *iter)`::
+`void *hashmap_iter_first(struct hashmap *map, struct hashmap_iter *iter)`::
+
+	Used to iterate over all entries of a hashmap.
++
+`hashmap_iter_init` initializes a `hashmap_iter` structure.
++
+`hashmap_iter_next` returns the next hashmap_entry, or NULL if there are no
+more entries.
++
+`hashmap_iter_first` is a combination of both (i.e. initializes the iterator
+and returns the first entry, if any).
+
+Usage example
+-------------
+
+Here's a simple usage example that maps long keys to double values.
+[source,c]
+------------
+struct hashmap map;
+
+struct long2double {
+	struct hashmap_entry ent; /* must be the first member! */
+	long key;
+	double value;
+};
+
+static int long2double_cmp(const struct long2double *e1, const struct long2double *e2, const void *unused)
+{
+	return !(e1->key == e2->key);
+}
+
+void long2double_init()
+{
+	hashmap_init(&map, (hashmap_cmp_fn) long2double_cmp, 0);
+}
+
+void long2double_free()
+{
+	hashmap_free(&map, free);
+}
+
+static struct long2double *find_entry(long key)
+{
+	struct long2double k;
+	hashmap_entry_init(&k, memhash(&key, sizeof(long)));
+	k.key = key;
+	return hashmap_get(&map, &k, NULL);
+}
+
+double get_value(long key)
+{
+	struct long2double *e = find_entry(key);
+	return e ? e->value : 0;
+}
+
+void set_value(long key, double value)
+{
+	struct long2double *e = find_entry(key);
+	if (!e) {
+		e = malloc(sizeof(struct long2double));
+		hashmap_entry_init(e, memhash(&key, sizeof(long)));
+		e->key = key;
+		hashmap_add(&map, e);
+	}
+	e->value = value;
+}
+------------
+
+Using variable-sized keys
+-------------------------
+
+The `hashmap_entry_get` and `hashmap_entry_remove` functions expect an ordinary
+`hashmap_entry` structure as key to find the correct entry. If the key data is
+variable-sized (e.g. a FLEX_ARRAY string) or quite large, it is undesirable
+to create a full-fledged entry structure on the heap and copy all the key data
+into the structure.
+
+In this case, the `keydata` parameter can be used to pass
+variable-sized key data directly to the comparison function, and the `key`
+parameter can be a stripped-down, fixed size entry structure allocated on the
+stack.
+
+See test-hashmap.c for an example using arbitrary-length strings as keys.
diff --git a/Makefile b/Makefile
index af847f8..05c5b4d 100644
--- a/Makefile
+++ b/Makefile
@@ -556,6 +556,7 @@ TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
@@ -676,6 +677,7 @@ LIB_H += gpg-interface.h
 LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
+LIB_H += hashmap.h
 LIB_H += help.h
 LIB_H += http.h
 LIB_H += kwset.h
@@ -807,6 +809,7 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
+LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
diff --git a/hashmap.c b/hashmap.c
new file mode 100644
index 0000000..3a9f8c1
--- /dev/null
+++ b/hashmap.c
@@ -0,0 +1,212 @@
+/*
+ * Generic implementation of hash-based key value mappings.
+ */
+#include "cache.h"
+#include "hashmap.h"
+
+#define FNV32_BASE ((unsigned int) 0x811c9dc5)
+#define FNV32_PRIME ((unsigned int) 0x01000193)
+
+unsigned int strhash(const char *str)
+{
+	unsigned int c, hash = FNV32_BASE;
+	while ((c = (unsigned char) *str++))
+		hash = (hash * FNV32_PRIME) ^ c;
+	return hash;
+}
+
+unsigned int strihash(const char *str)
+{
+	unsigned int c, hash = FNV32_BASE;
+	while ((c = (unsigned char) *str++)) {
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+unsigned int memhash(const void *buf, size_t len)
+{
+	unsigned int hash = FNV32_BASE;
+	unsigned char *ucbuf = (unsigned char*) buf;
+	while (len--) {
+		unsigned int c = *ucbuf++;
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+unsigned int memihash(const void *buf, size_t len)
+{
+	unsigned int hash = FNV32_BASE;
+	unsigned char *ucbuf = (unsigned char*) buf;
+	while (len--) {
+		unsigned int c = *ucbuf++;
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+#define HASHMAP_INITIAL_SIZE 64
+/* grow / shrink by 2^2 */
+#define HASHMAP_GROW 2
+/* grow if > 80% full (to 20%) */
+#define HASHMAP_GROW_AT 1.25
+/* shrink if < 16.6% full (to 66.6%) */
+#define HASHMAP_SHRINK_AT 6
+
+static inline int entry_equals(const struct hashmap *map,
+		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
+		const void *keydata)
+{
+	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2, keydata));
+}
+
+static inline unsigned int bucket(const struct hashmap *map,
+		const struct hashmap_entry *key)
+{
+	return key->hash & (map->tablesize - 1);
+}
+
+static void rehash(struct hashmap *map, unsigned int newsize)
+{
+	unsigned int i, oldsize = map->tablesize;
+	struct hashmap_entry **oldtable = map->table;
+
+	map->tablesize = newsize;
+	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
+	for (i = 0; i < oldsize; i++) {
+		struct hashmap_entry *e = oldtable[i];
+		while (e) {
+			struct hashmap_entry *next = e->next;
+			unsigned int b = bucket(map, e);
+			e->next = map->table[b];
+			map->table[b] = e;
+			e = next;
+		}
+	}
+	free(oldtable);
+}
+
+static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
+		const struct hashmap_entry *key, const void *keydata)
+{
+	struct hashmap_entry **e = &map->table[bucket(map, key)];
+	while (*e && !entry_equals(map, *e, key, keydata))
+		e = &(*e)->next;
+	return e;
+}
+
+static int always_equal(const void *unused1, const void *unused2, const void *unused3)
+{
+	return 0;
+}
+
+void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
+		size_t initial_size)
+{
+	map->size = 0;
+	map->cmpfn = equals_function ? equals_function : always_equal;
+	/* calculate initial table size and allocate the table */
+	map->tablesize = HASHMAP_INITIAL_SIZE;
+	initial_size *= HASHMAP_GROW_AT;
+	while (initial_size > map->tablesize)
+		map->tablesize <<= HASHMAP_GROW;
+	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
+}
+
+void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
+{
+	if (!map || !map->table)
+		return;
+	if (free_function) {
+		struct hashmap_iter iter;
+		struct hashmap_entry *e;
+		hashmap_iter_init(map, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			(*free_function)(e);
+	}
+	free(map->table);
+	memset(map, 0, sizeof(*map));
+}
+
+void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
+{
+	return *find_entry_ptr(map, key, keydata);
+}
+
+void *hashmap_get_next(const struct hashmap *map, const void *entry)
+{
+	struct hashmap_entry *e = ((struct hashmap_entry*) entry)->next;
+	for (; e; e = e->next)
+		if (entry_equals(map, entry, e, NULL))
+			return e;
+	return NULL;
+}
+
+void hashmap_add(struct hashmap *map, void *entry)
+{
+	unsigned int b = bucket(map, entry);
+
+	/* add entry */
+	((struct hashmap_entry*) entry)->next = map->table[b];
+	map->table[b] = entry;
+
+	/* fix size and rehash if appropriate */
+	map->size++;
+	if (map->size * HASHMAP_GROW_AT > map->tablesize)
+		rehash(map, map->tablesize << HASHMAP_GROW);
+}
+
+void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
+{
+	struct hashmap_entry *old;
+	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
+	if (!*e)
+		return NULL;
+
+	/* remove existing entry */
+	old = *e;
+	*e = old->next;
+	old->next = NULL;
+
+	/* fix size and rehash if appropriate */
+	map->size--;
+	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
+	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
+		rehash(map, map->tablesize >> HASHMAP_GROW);
+	return old;
+}
+
+void *hashmap_put(struct hashmap *map, void *entry)
+{
+	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
+	hashmap_add(map, entry);
+	return old;
+}
+
+void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)
+{
+	iter->map = map;
+	iter->tablepos = 0;
+	iter->next = NULL;
+}
+
+void *hashmap_iter_next(struct hashmap_iter *iter)
+{
+	struct hashmap_entry *current = iter->next;
+	for (;;) {
+		if (current) {
+			iter->next = current->next;
+			return current;
+		}
+
+		if (iter->tablepos >= iter->map->tablesize)
+			return NULL;
+
+		current = iter->map->table[iter->tablepos++];
+	}
+}
diff --git a/hashmap.h b/hashmap.h
new file mode 100644
index 0000000..eea003a
--- /dev/null
+++ b/hashmap.h
@@ -0,0 +1,72 @@
+#ifndef HASHMAP_H
+#define HASHMAP_H
+
+/*
+ * Generic implementation of hash-based key-value mappings.
+ * See Documentation/technical/api-hashmap.txt.
+ */
+
+/* FNV-1 functions */
+
+extern unsigned int strhash(const char *buf);
+extern unsigned int strihash(const char *buf);
+extern unsigned int memhash(const void *buf, size_t len);
+extern unsigned int memihash(const void *buf, size_t len);
+
+/* data structures */
+
+struct hashmap_entry {
+	struct hashmap_entry *next;
+	unsigned int hash;
+};
+
+typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
+		const void *keydata);
+typedef void (*hashmap_free_fn)(void *entry);
+
+struct hashmap {
+	struct hashmap_entry **table;
+	hashmap_cmp_fn cmpfn;
+	unsigned int size, tablesize;
+};
+
+struct hashmap_iter {
+	struct hashmap *map;
+	struct hashmap_entry *next;
+	unsigned int tablepos;
+};
+
+/* hashmap functions */
+
+extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
+		size_t initial_size);
+extern void hashmap_free(struct hashmap *map, hashmap_free_fn free_function);
+
+/* hashmap_entry functions */
+
+static inline void hashmap_entry_init(void *entry, int hash)
+{
+	struct hashmap_entry *e = entry;
+	e->hash = hash;
+	e->next = NULL;
+}
+extern void *hashmap_get(const struct hashmap *map, const void *key,
+		const void *keydata);
+extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
+extern void hashmap_add(struct hashmap *map, void *entry);
+extern void *hashmap_put(struct hashmap *map, void *entry);
+extern void *hashmap_remove(struct hashmap *map, const void *key,
+		const void *keydata);
+
+/* hashmap_iter functions */
+
+extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
+extern void *hashmap_iter_next(struct hashmap_iter *iter);
+static inline void *hashmap_iter_first(struct hashmap *map,
+		struct hashmap_iter *iter)
+{
+	hashmap_iter_init(map, iter);
+	return hashmap_iter_next(iter);
+}
+
+#endif
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
new file mode 100755
index 0000000..6c699d5
--- /dev/null
+++ b/t/t0011-hashmap.sh
@@ -0,0 +1,236 @@
+#!/bin/sh
+
+test_description='test hashmap and string hash functions'
+. ./test-lib.sh
+
+test_hashmap() {
+	echo "$1" | test-hashmap $3 > actual &&
+	echo "$2" > expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'hash functions' '
+
+test_hashmap "hash key1" "2215982743 2215982743 116372151 116372151" &&
+test_hashmap "hash key2" "2215982740 2215982740 116372148 116372148" &&
+test_hashmap "hash fooBarFrotz" "1383912807 1383912807 3189766727 3189766727" &&
+test_hashmap "hash foobarfrotz" "2862305959 2862305959 3189766727 3189766727"
+
+'
+
+test_expect_success 'put' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+put foobarfrotz value4
+size" "NULL
+NULL
+NULL
+NULL
+64 4"
+
+'
+
+test_expect_success 'put (case insensitive)' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+size" "NULL
+NULL
+NULL
+64 3" ignorecase
+
+'
+
+test_expect_success 'replace' '
+
+test_hashmap "put key1 value1
+put key1 value2
+put fooBarFrotz value3
+put fooBarFrotz value4
+size" "NULL
+value1
+NULL
+value3
+64 2"
+
+'
+
+test_expect_success 'replace (case insensitive)' '
+
+test_hashmap "put key1 value1
+put Key1 value2
+put fooBarFrotz value3
+put foobarfrotz value4
+size" "NULL
+value1
+NULL
+value3
+64 2" ignorecase
+
+'
+
+test_expect_success 'get' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+put foobarfrotz value4
+get key1
+get key2
+get fooBarFrotz
+get notInMap" "NULL
+NULL
+NULL
+NULL
+value1
+value2
+value3
+NULL"
+
+'
+
+test_expect_success 'get (case insensitive)' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+get Key1
+get keY2
+get foobarfrotz
+get notInMap" "NULL
+NULL
+NULL
+value1
+value2
+value3
+NULL" ignorecase
+
+'
+
+test_expect_success 'add' '
+
+test_hashmap "add key1 value1
+add key1 value2
+add fooBarFrotz value3
+add fooBarFrotz value4
+get key1
+get fooBarFrotz
+get notInMap" "value2
+value1
+value4
+value3
+NULL"
+
+'
+
+test_expect_success 'add (case insensitive)' '
+
+test_hashmap "add key1 value1
+add Key1 value2
+add fooBarFrotz value3
+add foobarfrotz value4
+get key1
+get Foobarfrotz
+get notInMap" "value2
+value1
+value4
+value3
+NULL" ignorecase
+
+'
+
+test_expect_success 'remove' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+remove key1
+remove key2
+remove notInMap
+size" "NULL
+NULL
+NULL
+value1
+value2
+NULL
+64 1"
+
+'
+
+test_expect_success 'remove (case insensitive)' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+remove Key1
+remove keY2
+remove notInMap
+size" "NULL
+NULL
+NULL
+value1
+value2
+NULL
+64 1" ignorecase
+
+'
+
+test_expect_success 'iterate' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+iterate" "NULL
+NULL
+NULL
+key2 value2
+key1 value1
+fooBarFrotz value3"
+
+'
+
+test_expect_success 'iterate (case insensitive)' '
+
+test_hashmap "put key1 value1
+put key2 value2
+put fooBarFrotz value3
+iterate" "NULL
+NULL
+NULL
+fooBarFrotz value3
+key2 value2
+key1 value1" ignorecase
+
+'
+
+test_expect_success 'grow / shrink' '
+
+	rm -f in &&
+	rm -f expect &&
+	for n in $(test_seq 51)
+	do
+		echo put key$n value$n >> in &&
+		echo NULL >> expect
+	done &&
+	echo size >> in &&
+	echo 64 51 >> expect &&
+	echo put key52 value52 >> in &&
+	echo NULL >> expect
+	echo size >> in &&
+	echo 256 52 >> expect &&
+	for n in $(test_seq 10)
+	do
+		echo remove key$n >> in &&
+		echo value$n >> expect
+	done &&
+	echo size >> in &&
+	echo 64 42 >> expect &&
+	cat in | test-hashmap > out &&
+	test_cmp expect out
+
+'
+
+test_done
diff --git a/test-hashmap.c b/test-hashmap.c
new file mode 100644
index 0000000..2d2b834
--- /dev/null
+++ b/test-hashmap.c
@@ -0,0 +1,340 @@
+#include "cache.h"
+#include "hashmap.h"
+#include <stdio.h>
+
+struct test_entry
+{
+	struct hashmap_entry ent;
+	/* key and value as two \0-terminated strings */
+	char key[FLEX_ARRAY];
+};
+
+static const char *get_value(const struct test_entry *e)
+{
+	return e->key + strlen(e->key) + 1;
+}
+
+static int test_entry_cmp(const struct test_entry *e1,
+		const struct test_entry *e2, const char* key)
+{
+	return strcmp(e1->key, key ? key : e2->key);
+}
+
+static int test_entry_cmp_icase(const struct test_entry *e1,
+		const struct test_entry *e2, const char* key)
+{
+	return strcasecmp(e1->key, key ? key : e2->key);
+}
+
+static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
+		char *value, int vlen)
+{
+	struct test_entry *entry = malloc(sizeof(struct test_entry) + klen
+			+ vlen + 2);
+	hashmap_entry_init(entry, hash);
+	memcpy(entry->key, key, klen + 1);
+	memcpy(entry->key + klen + 1, value, vlen + 1);
+	return entry;
+}
+
+#define HASH_METHOD_FNV 0
+#define HASH_METHOD_I 1
+#define HASH_METHOD_IDIV10 2
+#define HASH_METHOD_0 3
+#define HASH_METHOD_X2 4
+#define TEST_SPARSE 8
+#define TEST_ADD 16
+#define TEST_SIZE 100000
+
+static unsigned int hash(unsigned int method, unsigned int i, const char *key)
+{
+	unsigned int hash;
+	switch (method & 3)
+	{
+	case HASH_METHOD_FNV:
+		hash = strhash(key);
+		break;
+	case HASH_METHOD_I:
+		hash = i;
+		break;
+	case HASH_METHOD_IDIV10:
+		hash = i / 10;
+		break;
+	case HASH_METHOD_0:
+		hash = 0;
+		break;
+	}
+
+	if (method & HASH_METHOD_X2)
+		hash = 2 * hash;
+	return hash;
+}
+
+/*
+ * Test insert performance of hashmap.[ch]
+ * Usage: time echo "perfhashmap method rounds" | test-hashmap
+ */
+static void perf_hashmap(unsigned int method, unsigned int rounds)
+{
+	struct hashmap map;
+	char buf[16];
+	struct test_entry **entries;
+	unsigned int *hashes;
+	unsigned int i, j;
+
+	entries = malloc(TEST_SIZE * sizeof(struct test_entry*));
+	hashes = malloc(TEST_SIZE * sizeof(int));
+	for (i = 0; i < TEST_SIZE; i++) {
+		snprintf(buf, sizeof(buf), "%i", i);
+		entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
+		hashes[i] = hash(method, i, entries[i]->key);
+	}
+
+	if (method & TEST_ADD) {
+		/* test adding to the map */
+		for (j = 0; j < rounds; j++) {
+			hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
+
+			/* add entries */
+			for (i = 0; i < TEST_SIZE; i++) {
+				hashmap_entry_init(entries[i], hashes[i]);
+				hashmap_add(&map, entries[i]);
+			}
+
+			hashmap_free(&map, NULL);
+		}
+	} else {
+		/* test map lookups */
+		hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
+
+		/* fill the map (sparsely if specified) */
+		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
+		for (i = 0; i < j; i++) {
+			hashmap_entry_init(entries[i], hashes[i]);
+			hashmap_add(&map, entries[i]);
+		}
+
+		for (j = 0; j < rounds; j++) {
+			for (i = 0; i < TEST_SIZE; i++) {
+				struct hashmap_entry key;
+				hashmap_entry_init(&key, hashes[i]);
+				hashmap_get(&map, &key, entries[i]->key);
+			}
+		}
+
+		hashmap_free(&map, NULL);
+	}
+}
+
+struct hash_entry
+{
+	struct hash_entry *next;
+	char key[FLEX_ARRAY];
+};
+
+/*
+ * Test insert performance of hash.[ch]
+ * Usage: time echo "perfhash method rounds" | test-hashmap
+ */
+static void perf_hash(unsigned int method, unsigned int rounds)
+{
+	struct hash_table map;
+	char buf[16];
+	struct hash_entry **entries, **res, *entry;
+	unsigned int *hashes;
+	unsigned int i, j;
+
+	entries = malloc(TEST_SIZE * sizeof(struct hash_entry*));
+	hashes = malloc(TEST_SIZE * sizeof(int));
+	for (i = 0; i < TEST_SIZE; i++) {
+		snprintf(buf, sizeof(buf), "%i", i);
+		entries[i] = malloc(sizeof(struct hash_entry) + strlen(buf) + 1);
+		strcpy(entries[i]->key, buf);
+		hashes[i] = hash(method, i, entries[i]->key);
+	}
+
+	if (method & TEST_ADD) {
+		/* test adding to the map */
+		for (j = 0; j < rounds; j++) {
+			init_hash(&map);
+
+			/* add entries */
+			for (i = 0; i < TEST_SIZE; i++) {
+				res = (struct hash_entry**) insert_hash(
+						hashes[i], entries[i], &map);
+				if (res) {
+					entries[i]->next = *res;
+					*res = entries[i];
+				} else {
+					entries[i]->next = NULL;
+				}
+			}
+
+			free_hash(&map);
+		}
+	} else {
+		/* test map lookups */
+		init_hash(&map);
+
+		/* fill the map (sparsely if specified) */
+		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
+		for (i = 0; i < j; i++) {
+			res = (struct hash_entry**) insert_hash(hashes[i],
+					entries[i], &map);
+			if (res) {
+				entries[i]->next = *res;
+				*res = entries[i];
+			} else {
+				entries[i]->next = NULL;
+			}
+		}
+
+		for (j = 0; j < rounds; j++) {
+			for (i = 0; i < TEST_SIZE; i++) {
+				entry = lookup_hash(hashes[i], &map);
+				while (entry) {
+					if (!strcmp(entries[i]->key, entry->key))
+						break;
+					entry = entry->next;
+				}
+			}
+		}
+
+		free_hash(&map);
+
+	}
+}
+
+#define DELIM " \t\r\n"
+
+/*
+ * Read stdin line by line and print result of commands to stdout:
+ *
+ * hash key -> strhash(key) memhash(key) strihash(key) memihash(key)
+ * put key value -> NULL / old value
+ * get key -> NULL / value
+ * remove key -> NULL / old value
+ * iterate -> key1 value1\nkey2 value2\n...
+ * size -> tablesize numentries
+ *
+ * perfhashmap method rounds -> test hashmap.[ch] performance
+ * perfhash method rounds -> test hash.[ch] performance
+ */
+int main(int argc, char *argv[])
+{
+	char line[1024];
+	struct hashmap map;
+	int icase;
+
+	/* init hash map */
+	icase = argc > 1 && !strcmp("ignorecase", argv[1]);
+	hashmap_init(&map, (hashmap_cmp_fn) (icase ? test_entry_cmp_icase
+			: test_entry_cmp), 0);
+
+	/* process commands from stdin */
+	while (fgets(line, sizeof(line), stdin)) {
+		char *cmd, *p1 = NULL, *p2 = NULL;
+		int l1 = 0, l2 = 0, hash = 0;
+		struct test_entry *entry;
+
+		/* break line into command and up to two parameters */
+		cmd = strtok(line, DELIM);
+		/* ignore empty lines */
+		if (!cmd || *cmd == '#')
+			continue;
+
+		p1 = strtok(NULL, DELIM);
+		if (p1) {
+			l1 = strlen(p1);
+			hash = icase ? strihash(p1) : strhash(p1);
+			p2 = strtok(NULL, DELIM);
+			if (p2)
+				l2 = strlen(p2);
+		}
+
+		if (!strcmp("hash", cmd) && l1) {
+
+			/* print results of different hash functions */
+			printf("%u %u %u %u\n", strhash(p1), memhash(p1, l1),
+					strihash(p1), memihash(p1, l1));
+
+		} else if (!strcmp("add", cmd) && l1 && l2) {
+
+			/* create entry with key = p1, value = p2 */
+			entry = alloc_test_entry(hash, p1, l1, p2, l2);
+
+			/* add to hashmap */
+			hashmap_add(&map, entry);
+
+		} else if (!strcmp("put", cmd) && l1 && l2) {
+
+			/* create entry with key = p1, value = p2 */
+			entry = alloc_test_entry(hash, p1, l1, p2, l2);
+
+			/* add / replace entry */
+			entry = hashmap_put(&map, entry);
+
+			/* print and free replaced entry, if any */
+			puts(entry ? get_value(entry) : "NULL");
+			free(entry);
+
+		} else if (!strcmp("get", cmd) && l1) {
+
+			/* setup static key */
+			struct hashmap_entry key;
+			hashmap_entry_init(&key, hash);
+
+			/* lookup entry in hashmap */
+			entry = hashmap_get(&map, &key, p1);
+
+			/* print result */
+			if (!entry)
+				puts("NULL");
+			while (entry) {
+				puts(get_value(entry));
+				entry = hashmap_get_next(&map, entry);
+			}
+
+		} else if (!strcmp("remove", cmd) && l1) {
+
+			/* setup static key */
+			struct hashmap_entry key;
+			hashmap_entry_init(&key, hash);
+
+			/* remove entry from hashmap */
+			entry = hashmap_remove(&map, &key, p1);
+
+			/* print result and free entry*/
+			puts(entry ? get_value(entry) : "NULL");
+			free(entry);
+
+		} else if (!strcmp("iterate", cmd)) {
+
+			struct hashmap_iter iter;
+			hashmap_iter_init(&map, &iter);
+			while ((entry = hashmap_iter_next(&iter)))
+				printf("%s %s\n", entry->key, get_value(entry));
+
+		} else if (!strcmp("size", cmd)) {
+
+			/* print table sizes */
+			printf("%u %u\n", map.tablesize, map.size);
+
+		} else if (!strcmp("perfhashmap", cmd) && l1 && l2) {
+
+			perf_hashmap(atoi(p1), atoi(p2));
+
+		} else if (!strcmp("perfhash", cmd) && l1 && l2) {
+
+			perf_hash(atoi(p1), atoi(p2));
+
+		} else {
+
+			printf("Unknown command %s\n", cmd);
+
+		}
+	}
+
+	hashmap_free(&map, free);
+	return 0;
+}
-- 
1.8.4.msysgit.0.12.g88f5ed0
