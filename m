From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC 1/5] add a hashtable implementation that supports O(1)
 removal
Date: Wed, 11 Sep 2013 01:28:25 +0200
Message-ID: <522FAB19.3080704@gmail.com>
References: <522FAAC4.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXMF-0008Fj-KP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab3IJX21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:28:27 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:63616 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3IJX20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:28:26 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so4200679eek.22
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=VJ2XP5t7RWR3jUUvb8SSTiVWuwd6CirVaJjF0d96hZ0=;
        b=bLR5qD3nraRjqJ+Ql27xdpD0GnEquH93oJRun+gAn+u4aNWbb448qp+5+E2e9DzbY6
         SsfqgSLnh8qdMvywkY2PAdSrFi6ycqSuCG7YuziWe/n/x/odeQB3lIRQrh9Ex6hLo1gQ
         cyuefP4TpoLqSULvD1M3YS//X8P0g9r3rj80I6nKJPV/2od38RL7HTQPhC0ZWoz2VKO+
         +Aryfhka7kN3jAGxi+bNfgEMv6K9SyBLc1rH4m7NOUBtjQy1busYXrPHgSk9/LcIioYn
         iCRKmaYpP1LJvgf/B4mPl3glXPxXzG2yI8gf0zcQoA+5t4OqKuR1bkM8OIjpV8RyB39g
         X1aw==
X-Received: by 10.15.74.197 with SMTP id j45mr41921431eey.40.1378855704980;
        Tue, 10 Sep 2013 16:28:24 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n48sm35442940eeg.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:28:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FAAC4.2080601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234509>

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

The per-entry data structure (hashmap_entry) is meant to be piggybacked
in front of the client's data structure to save memory. See test-hashmap.c
for usage examples.

The hashtable is resized by a factor of four when 80% full. With these
settings, average memory consumption is about 2/3 of hash.[ch], and
insertion is about twice as fast due to less frequent resizing.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Makefile           |   3 +
 hashmap.c          | 210 +++++++++++++++++++++++++++++++++++++++++++
 hashmap.h          | 200 +++++++++++++++++++++++++++++++++++++++++
 t/t0011-hashmap.sh | 236 ++++++++++++++++++++++++++++++++++++++++++++++++
 test-hashmap.c     | 258 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 907 insertions(+)
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c

diff --git a/Makefile b/Makefile
index 3588ca1..e6ad011 100644
--- a/Makefile
+++ b/Makefile
@@ -562,6 +562,7 @@ TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
@@ -681,6 +682,7 @@ LIB_H += gpg-interface.h
 LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
+LIB_H += hashmap.h
 LIB_H += help.h
 LIB_H += http.h
 LIB_H += kwset.h
@@ -811,6 +813,7 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
+LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
diff --git a/hashmap.c b/hashmap.c
new file mode 100644
index 0000000..686ee6f
--- /dev/null
+++ b/hashmap.c
@@ -0,0 +1,210 @@
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
+static inline int entry_equals(const hashmap *map, const hashmap_entry *e1,
+		const hashmap_entry *e2)
+{
+	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2));
+}
+
+static inline unsigned int bucket(const hashmap *map, const hashmap_entry *key)
+{
+	return key->hash & (map->tablesize - 1);
+}
+
+static void rehash(hashmap *map, unsigned int newsize)
+{
+	unsigned int i, oldsize = map->tablesize;
+	hashmap_entry **oldtable = map->table;
+
+	map->tablesize = newsize;
+	map->table = xcalloc(sizeof(hashmap_entry*), map->tablesize);
+	for (i = 0; i < oldsize; i++) {
+		hashmap_entry *e = oldtable[i];
+		while (e) {
+			hashmap_entry *next = e->next;
+			unsigned int b = bucket(map, e);
+			e->next = map->table[b];
+			map->table[b] = e;
+			e = next;
+		}
+	}
+	free(oldtable);
+}
+
+static inline hashmap_entry **find_entry(const hashmap *map,
+		const hashmap_entry *key)
+{
+	hashmap_entry **e = &map->table[bucket(map, key)];
+	while (*e && !entry_equals(map, *e, key))
+		e = &(*e)->next;
+	return e;
+}
+
+static int always_equal(const void *unused1, const void *unused2)
+{
+	return 0;
+}
+
+void hashmap_init(hashmap *map, hashmap_cmp_fn equals_function,
+		size_t initial_size)
+{
+	map->size = 0;
+	map->cmpfn = equals_function ? equals_function : always_equal;
+	/* calculate initial table size and allocate the table */
+	map->tablesize = HASHMAP_INITIAL_SIZE;
+	initial_size *= HASHMAP_GROW_AT;
+	while (initial_size > map->tablesize)
+		map->tablesize <<= HASHMAP_GROW;
+	map->table = xcalloc(sizeof(hashmap_entry*), map->tablesize);
+}
+
+void hashmap_free(hashmap *map, hashmap_free_fn free_function)
+{
+	if (!map || !map->table)
+		return;
+	if (free_function) {
+		hashmap_iter iter;
+		hashmap_entry *e;
+		hashmap_iter_init(map, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			(*free_function)(e);
+	}
+	free(map->table);
+	memset(map, 0, sizeof(*map));
+}
+
+void *hashmap_get(const hashmap *map, const void *key)
+{
+	return *find_entry(map, key);
+}
+
+void *hashmap_get_next(const hashmap *map, const void *entry)
+{
+	hashmap_entry *e = ((hashmap_entry*) entry)->next;
+	for (; e; e = e->next)
+		if (entry_equals(map, entry, e))
+			return e;
+	return NULL;
+}
+
+void hashmap_add(hashmap *map, void *entry)
+{
+	unsigned int b = bucket(map, entry);
+
+	/* add entry */
+	((hashmap_entry*) entry)->next = map->table[b];
+	map->table[b] = entry;
+
+	/* fix size and rehash if appropriate */
+	map->size++;
+	if (map->size * HASHMAP_GROW_AT > map->tablesize)
+		rehash(map, map->tablesize << HASHMAP_GROW);
+}
+
+void *hashmap_remove(hashmap *map, const void *key)
+{
+	hashmap_entry *old;
+	hashmap_entry **e = find_entry(map, key);
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
+		map->size * HASHMAP_SHRINK_AT < map->tablesize)
+		rehash(map, map->tablesize >> HASHMAP_GROW);
+	return old;
+}
+
+void *hashmap_put(hashmap *map, void *entry)
+{
+	hashmap_entry *old = hashmap_remove(map, entry);
+	hashmap_add(map, entry);
+	return old;
+}
+
+void hashmap_iter_init(hashmap *map, hashmap_iter *iter)
+{
+	iter->map = map;
+	iter->tablepos = 0;
+	iter->next = NULL;
+}
+
+void *hashmap_iter_next(hashmap_iter *iter)
+{
+	hashmap_entry *current = iter->next;
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
index 0000000..59f8489
--- /dev/null
+++ b/hashmap.h
@@ -0,0 +1,200 @@
+#ifndef HASHMAP_H
+#define HASHMAP_H
+
+/*
+ * Generic implementation of hash-based key value mappings.
+ * Supports basic operations get, add/put, remove and iteration.
+ *
+ * Also contains a set of ready-to-use hash functions for strings, using the
+ * FNV-1 algorithm (see http://www.isthe.com/chongo/tech/comp/fnv).
+ */
+
+/*
+ * Case-sensitive FNV-1 hash of 0-terminated string.
+ * str: the string
+ * returns hash code
+ */
+extern unsigned int strhash(const char *buf);
+
+/*
+ * Case-insensitive FNV-1 hash of 0-terminated string.
+ * str: the string
+ * returns hash code
+ */
+extern unsigned int strihash(const char *buf);
+
+/*
+ * Case-sensitive FNV-1 hash of a memory block.
+ * buf: start of the memory block
+ * len: length of the memory block
+ * returns hash code
+ */
+extern unsigned int memhash(const void *buf, size_t len);
+
+/*
+ * Case-insensitive FNV-1 hash of a memory block.
+ * buf: start of the memory block
+ * len: length of the memory block
+ * returns hash code
+ */
+extern unsigned int memihash(const void *buf, size_t len);
+
+/*
+ * Hashmap entry data structure, intended to be used as first member of user
+ * data structures. Consists of a pointer and an int. Ideally it should be
+ * followed by an int-sized member to prevent unused memory on 64-bit systems
+ * due to alignment.
+ */
+typedef struct hashmap_entry {
+	struct hashmap_entry *next;
+	unsigned int hash;
+} hashmap_entry;
+
+/*
+ * User-supplied function to test two hashmap entries for equality, shall
+ * return 0 if the entries are equal. This function is always called with
+ * non-NULL parameters that have the same hash code. When looking up an entry,
+ * the key parameter to hashmap_get and hashmap_remove is always passed as
+ * second argument.
+ */
+typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key);
+
+/*
+ * User-supplied function to free a hashmap entry.
+ */
+typedef void (*hashmap_free_fn)(void *entry);
+
+/*
+ * Hashmap data structure, use with hashmap_* functions.
+ */
+typedef struct hashmap {
+	hashmap_entry **table;
+	hashmap_cmp_fn cmpfn;
+	unsigned int size, tablesize;
+} hashmap;
+
+/*
+ * Hashmap iterator data structure, use with hasmap_iter_* functions.
+ */
+typedef struct hashmap_iter {
+	hashmap *map;
+	hashmap_entry *next;
+	unsigned int tablepos;
+} hashmap_iter;
+
+/*
+ * Initializes a hashmap_entry structure.
+ * entry: pointer to the entry to initialize
+ * hash: hash code of the entry
+ * key_only: true if entry is a key-only structure, see hashmap_entry_is_key
+ */
+static inline void hashmap_entry_init(void *entry, int hash, int key_only)
+{
+	hashmap_entry *e = entry;
+	e->hash = hash;
+	e->next = key_only ? (hashmap_entry*) -1 : NULL;
+}
+
+/*
+ * Checks if hashmap_entry was initialized with the key_only flag. This is
+ * useful if the entry structure is variable-sized (e.g. ending in a FLEX_ARRAY)
+ * and the key is part of the variable portion. To prevent dynamic allocation of
+ * a full-fledged entry structure for each lookup, a smaller, statically sized
+ * structure can be used as key (i.e. replacing the FLEX_ARRAY member with a
+ * char pointer). The hashmap_cmp_fn comparison function can then check whether
+ * entry_or_key is a full-fledged entry or a key-only structure.
+ * entry: pointer to the entry to check
+ * returns 0 for key-value entries and non-0 for key-only entries
+ */
+static inline int hashmap_entry_is_key(const void *entry)
+{
+	const hashmap_entry *e = entry;
+	return e->next == (hashmap_entry*) -1;
+}
+
+/*
+ * Initializes a hashmap structure.
+ * map: hashmap to initialize
+ * equals_function: optional function to test equality of hashmap entries. If
+ *  NULL, entries are considered equal if their hash codes are equal.
+ * initial_size: optional number of initial entries, 0 if unknown
+ */
+extern void hashmap_init(hashmap *map, hashmap_cmp_fn equals_function,
+		size_t initial_size);
+
+/*
+ * Frees a hashmap structure and allocated memory.
+ * map: hashmap to free
+ * free_function: optional function to free the hashmap entries
+ */
+extern void hashmap_free(hashmap *map, hashmap_free_fn free_function);
+
+/*
+ * Returns the hashmap entry for the specified key, or NULL if not found.
+ * map: the hashmap
+ * key: key of the entry to look up
+ * returns matching hashmap entry, or NULL if not found
+ */
+extern void *hashmap_get(const hashmap *map, const void *key);
+
+/*
+ * Returns the next equal hashmap entry if the map contains duplicates (see
+ * hashmap_add).
+ * map: the hashmap
+ * entry: current entry, obtained via hashmap_get or hashmap_get_next
+ * returns next equal hashmap entry, or NULL if not found
+ */
+extern void *hashmap_get_next(const hashmap *map, const void *entry);
+
+/*
+ * Adds a hashmap entry. This allows to add duplicate entries (i.e. separate
+ * values with the same key according to hashmap_cmp_fn).
+ * map: the hashmap
+ * entry: the entry to add
+ */
+extern void hashmap_add(hashmap *map, void *entry);
+
+/*
+ * Adds or replaces a hashmap entry.
+ * map: the hashmap
+ * entry: the entry to add or replace
+ * returns previous entry, or NULL if the entry is new
+ */
+extern void *hashmap_put(hashmap *map, void *entry);
+
+/*
+ * Removes a hashmap entry matching the specified key.
+ * map: the hashmap
+ * key: key of the entry to remove
+ * returns removed entry, or NULL if not found
+ */
+extern void *hashmap_remove(hashmap *map, const void *key);
+
+/*
+ * Initializes a hashmap iterator structure.
+ * map: the hashmap
+ * iter: hashmap iterator structure
+ */
+extern void hashmap_iter_init(hashmap *map, hashmap_iter *iter);
+
+/**
+ * Returns the next hashmap entry.
+ * iter: hashmap iterator
+ * returns next entry, or NULL if there are no more entries
+ */
+extern void *hashmap_iter_next(hashmap_iter *iter);
+
+/**
+ * Initializes a hashmap iterator and returns the first hashmap entry.
+ * map: the hashmap
+ * iter: hashmap iterator
+ * returns first entry, or NULL if there are no entries
+ */
+static inline void *hashmap_iter_first(hashmap *map,
+		hashmap_iter *iter)
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
index 0000000..a4b3440
--- /dev/null
+++ b/test-hashmap.c
@@ -0,0 +1,258 @@
+#include "cache.h"
+#include "hashmap.h"
+#include <stdio.h>
+
+typedef struct test_entry
+{
+	hashmap_entry ent;
+	/* key and value as two \0-terminated strings */
+	char key[FLEX_ARRAY];
+} test_entry;
+
+typedef struct test_key
+{
+	hashmap_entry ent;
+	char *key;
+} test_key;
+
+static const char *get_key(const test_entry *e)
+{
+	return hashmap_entry_is_key(e) ? ((test_key*) e)->key : e->key;
+}
+
+static const char *get_value(const test_entry *e)
+{
+	return e->key + strlen(e->key) + 1;
+}
+
+static int test_entry_cmp(const test_entry *e1, const test_entry *e2)
+{
+	return strcmp(e1->key, get_key(e2));
+}
+
+static int test_entry_cmp_icase(const test_entry *e1, const test_entry *e2)
+{
+	return strcasecmp(e1->key, get_key(e2));
+}
+
+static test_entry *alloc_test_entry(int hash, char *key, int klen, char *value,
+		int vlen)
+{
+	test_entry *entry = malloc(sizeof(test_entry) + klen + vlen + 2);
+	hashmap_entry_init(entry, hash, 0);
+	memcpy(entry->key, key, klen + 1);
+	memcpy(entry->key + klen + 1, value, vlen + 1);
+	return entry;
+}
+
+/*
+ * Test insert performance of hashmap.[ch]
+ * Usage: time echo "perfhashmap size rounds" | test-hashmap
+ */
+static void perf_hashmap(unsigned int size, unsigned int rounds)
+{
+	hashmap map;
+	char buf[16];
+	test_entry **entries;
+	unsigned int i, j;
+
+	entries = malloc(size * sizeof(test_entry*));
+	for (i = 0; i < size; i++) {
+		snprintf(buf, sizeof(buf), "%i", i);
+		entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
+	}
+
+	for (j = 0; j < rounds; j++) {
+		// initialize the map
+		hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
+
+		// add entries
+		for (i = 0; i < size; i++) {
+			unsigned int hash = strhash(entries[i]->key);
+			hashmap_entry_init(entries[i], hash, 0);
+			hashmap_add(&map, entries[i]);
+		}
+
+		hashmap_free(&map, NULL);
+	}
+}
+
+typedef struct hash_entry
+{
+	struct hash_entry *next;
+	char key[FLEX_ARRAY];
+} hash_entry;
+
+/*
+ * Test insert performance of hash.[ch]
+ * Usage: time echo "perfhashtable size rounds" | test-hashmap
+ */
+static void perf_hashtable(unsigned int size, unsigned int rounds)
+{
+	struct hash_table map;
+	char buf[16];
+	hash_entry **entries, **res;
+	unsigned int i, j;
+
+	entries = malloc(size * sizeof(hash_entry*));
+	for (i = 0; i < size; i++) {
+		snprintf(buf, sizeof(buf), "%i", i);
+		entries[i] = malloc(sizeof(hash_entry) + strlen(buf) + 1);
+		strcpy(entries[i]->key, buf);
+	}
+
+	for (j = 0; j < rounds; j++) {
+		// initialize the map
+		init_hash(&map);
+
+		// add entries
+		for (i = 0; i < size; i++) {
+			unsigned int hash = strhash(entries[i]->key);
+			res = (hash_entry**) insert_hash(hash, entries[i], &map);
+			if (res) {
+				entries[i]->next = *res;
+				*res = entries[i];
+			} else {
+				entries[i]->next = NULL;
+			}
+		}
+
+		free_hash(&map);
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
+ * perfhashmap size rounds -> hashmap.[ch]: add <size> entries <rounds> times
+ * perfhashtable size rounds -> hash.[ch]: add <size> entries <rounds> times
+ */
+int main(int argc, char *argv[])
+{
+	char line[1024];
+	hashmap map;
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
+		test_entry *entry;
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
+			test_key key;
+			hashmap_entry_init(&key, hash, 1);
+			key.key = p1;
+
+			/* lookup entry in hashmap */
+			entry = hashmap_get(&map, &key);
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
+			test_key key;
+			hashmap_entry_init(&key, hash, 1);
+			key.key = p1;
+
+			/* remove entry from hashmap */
+			entry = hashmap_remove(&map, &key);
+
+			/* print result and free entry*/
+			puts(entry ? get_value(entry) : "NULL");
+			free(entry);
+
+		} else if (!strcmp("iterate", cmd)) {
+
+			hashmap_iter iter;
+			hashmap_iter_init(&map, &iter);
+			while ((entry = hashmap_iter_next(&iter)))
+				printf("%s %s\n", get_key(entry), get_value(entry));
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
+		} else if (!strcmp("perfhashtable", cmd) && l1 && l2) {
+
+			perf_hashtable(atoi(p1), atoi(p2));
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
1.8.4.8243.gbcbdefd
