From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 0/5] New hash table implementation
Date: Tue, 24 Sep 2013 11:50:16 +0200
Message-ID: <52416058.90008@gmail.com>
References: <522FAAC4.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:50:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPGD-0002VG-N3
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab3IXJuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:50:20 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:38973 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3IXJuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 05:50:18 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so4226362wes.21
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=6LnnnTanx1BuyD6XWBBIlMyAbQ+pfvasGh9WHDeot1c=;
        b=ALZj/Cgpl0dJKu17MUgdFtbUque9P7ilfnvM7CiJbTen6I6jYGNs47wvap7Uj1QSct
         UY5UTSfIRZkOSVrFqO4Act04aHLrDP5nKtMjbE/dubJSIhUoBtbPsgHh+wdg6UBUb5Kr
         bVeOCQ/P0vVryqy+cppD2lR1l9WnVp4z6TIrFCScz1lpmxnR9eMMEkwHbkhPSxrml1iC
         3e7B275bxKiqOf0f6f3ON1Ar3xki4cFl4+XEL1vnb+qkzChnhQ4+WhrDwL4jSMgjNr6V
         CRrgfOBvAs9Cgm/tDVj1YT3EP3d/OXxj+9s7SZoYf3gssFgVitO2A4suQeK8YIYvEZDX
         3DsQ==
X-Received: by 10.180.221.38 with SMTP id qb6mr17091293wic.8.1380016216839;
        Tue, 24 Sep 2013 02:50:16 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id li9sm5799168wic.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 02:50:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FAAC4.2080601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235290>

Also here: https://github.com/kblees/git/tree/kb/hashmap-v2

Changes since initial version:
- removed struct typedefs
- clarified documentation of hashmap_entry
- renamed find_entry -> find_entry_ptr
- added performance tests for lookup


I've also tried to resize the table based on the number of used buckets (instead of total entries). However, this doesn't work with hash functions that produce 'gaps'. E.g. a hash function that returns only even numbers would fill only every second bucket (i.e. max. 50% buckets used), and the 80% resize threshold is never reached.


Regarding performance, I have to admit that the difference between the two implementations is far greater than I had anticipated. The following times (in seconds) are from Linux x64 (Debian Sarge) on a Core i7 860 @2.8GHz. All tests have been run with 1,000 rounds of 100,000 entries each.

The 'get 10% hits' test does 100,000 lookups on a table with 10,000 entries (i.e. 90% unsuccessful lookups).

The rows denote different hash functions with different qualities:
- FNV: FNV-1 hash on stringified loop counter (i.e. fnv1(itoa(i))), as
  an example of a high quality / low collision hash
- i: just the loop counter (i.e. 0, 1, 2,...), guaranteed collision free
- i/10: every 10 entries share the same hash code, lots of collisions

The i and i/10 tests show that open addressing suffers badly from clustering, i.e. with adjacent hash codes, it degrades to linear search. The *2 versions provide for some space between used buckets to better compare it to the chaining version.


        |       add        |  get 100% hits  |    get 10% hits
        |  hash  | hashmap | hash  | hashmap |  hash   | hashmap
--------+--------+---------+-------+---------+---------+--------
FNV     | 14.815 |   2.345 | 3.059 |   1.642 |   4.085 |   0.976
FNV  x2 | 14.409 |   2.706 | 2.888 |   1.959 |   3.905 |   1.393
i       |  7.432 |   1.593 | 1.364 |   1.142 | 413.023 |   0.589
i    x2 |  9.169 |   1.866 | 1.427 |   1.163 |   0.757 |   0.670
i/10    |  1.800 |   1.555 | 5.365 |   6.465 |  32.918 |   1.052
i/10 x2 |  1.892 |   1.555 | 5.386 |   6.474 |   1.123 |   1.206

Tests can be reproduced with 'time echo "perfhash[map] <method> 1000" | ./test-hashmap', see test-hashmap.c for definition of method flags.


Karsten Blees (5):
  add a hashtable implementation that supports O(1) removal
  buitin/describe.c: use new hash map implementation
  diffcore-rename.c: move code around to prepare for the next patch
  diffcore-rename.c: simplify finding exact renames
  diffcore-rename.c: use new hash map implementation

 Makefile           |   3 +
 builtin/describe.c |  53 ++++----
 diffcore-rename.c  | 185 ++++++++++------------------
 hashmap.c          | 211 +++++++++++++++++++++++++++++++
 hashmap.h          | 200 ++++++++++++++++++++++++++++++
 t/t0011-hashmap.sh | 236 +++++++++++++++++++++++++++++++++++
 test-hashmap.c     | 354 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1092 insertions(+), 150 deletions(-)
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c


---
git diff kb/hashmap..kb/hashmap-v2:

diff --git a/builtin/describe.c b/builtin/describe.c
index bbc7159..5db5d89 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -25,7 +25,7 @@ static int longformat;
 static int first_parent;
 static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
-static hashmap names;
+static struct hashmap names;
 static int have_util;
 static const char *pattern;
 static int always;
@@ -38,7 +38,7 @@ static const char *diff_index_args[] = {
 
 
 struct commit_name {
-	hashmap_entry entry;
+	struct hashmap_entry entry;
 	unsigned char peeled[20];
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
@@ -280,7 +280,7 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, _("searching to describe %s\n"), arg);
 
 	if (!have_util) {
-		hashmap_iter iter;
+		struct hashmap_iter iter;
 		struct commit *c;
 		struct commit_name *n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6271af9..2e70d31 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -243,7 +243,7 @@ static int score_compare(const void *a_, const void *b_)
 }
 
 struct file_similarity {
-	hashmap_entry entry;
+	struct hashmap_entry entry;
 	int index;
 	struct diff_filespec *filespec;
 };
@@ -260,7 +260,7 @@ static unsigned int hash_filespec(struct diff_filespec *filespec)
 	return hash;
 }
 
-static int find_identical_files(hashmap *srcs,
+static int find_identical_files(struct hashmap *srcs,
 				int dst_index,
 				struct diff_options *options)
 {
@@ -310,7 +310,7 @@ static int find_identical_files(hashmap *srcs,
 	return renames;
 }
 
-static void insert_file_table(hashmap *table, int index, struct diff_filespec *filespec)
+static void insert_file_table(struct hashmap *table, int index, struct diff_filespec *filespec)
 {
 	struct file_similarity *entry = xmalloc(sizeof(*entry));
 
@@ -331,7 +331,7 @@ static void insert_file_table(hashmap *table, int index, struct diff_filespec *f
 static int find_exact_renames(struct diff_options *options)
 {
 	int i, renames;
-	hashmap file_table;
+	struct hashmap file_table;
 
 	/* Add all sources to the hash table */
 	hashmap_init(&file_table, NULL, rename_src_nr);
diff --git a/hashmap.c b/hashmap.c
index 686ee6f..75a8578 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -58,28 +58,29 @@ unsigned int memihash(const void *buf, size_t len)
 /* shrink if < 16.6% full (to 66.6%) */
 #define HASHMAP_SHRINK_AT 6
 
-static inline int entry_equals(const hashmap *map, const hashmap_entry *e1,
-		const hashmap_entry *e2)
+static inline int entry_equals(const struct hashmap *map,
+		const struct hashmap_entry *e1, const struct hashmap_entry *e2)
 {
 	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2));
 }
 
-static inline unsigned int bucket(const hashmap *map, const hashmap_entry *key)
+static inline unsigned int bucket(const struct hashmap *map,
+		const struct hashmap_entry *key)
 {
 	return key->hash & (map->tablesize - 1);
 }
 
-static void rehash(hashmap *map, unsigned int newsize)
+static void rehash(struct hashmap *map, unsigned int newsize)
 {
 	unsigned int i, oldsize = map->tablesize;
-	hashmap_entry **oldtable = map->table;
+	struct hashmap_entry **oldtable = map->table;
 
 	map->tablesize = newsize;
-	map->table = xcalloc(sizeof(hashmap_entry*), map->tablesize);
+	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
 	for (i = 0; i < oldsize; i++) {
-		hashmap_entry *e = oldtable[i];
+		struct hashmap_entry *e = oldtable[i];
 		while (e) {
-			hashmap_entry *next = e->next;
+			struct hashmap_entry *next = e->next;
 			unsigned int b = bucket(map, e);
 			e->next = map->table[b];
 			map->table[b] = e;
@@ -89,10 +90,10 @@ static void rehash(hashmap *map, unsigned int newsize)
 	free(oldtable);
 }
 
-static inline hashmap_entry **find_entry(const hashmap *map,
-		const hashmap_entry *key)
+static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
+		const struct hashmap_entry *key)
 {
-	hashmap_entry **e = &map->table[bucket(map, key)];
+	struct hashmap_entry **e = &map->table[bucket(map, key)];
 	while (*e && !entry_equals(map, *e, key))
 		e = &(*e)->next;
 	return e;
@@ -103,7 +104,7 @@ static int always_equal(const void *unused1, const void *unused2)
 	return 0;
 }
 
-void hashmap_init(hashmap *map, hashmap_cmp_fn equals_function,
+void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size)
 {
 	map->size = 0;
@@ -113,16 +114,16 @@ void hashmap_init(hashmap *map, hashmap_cmp_fn equals_function,
 	initial_size *= HASHMAP_GROW_AT;
 	while (initial_size > map->tablesize)
 		map->tablesize <<= HASHMAP_GROW;
-	map->table = xcalloc(sizeof(hashmap_entry*), map->tablesize);
+	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
 }
 
-void hashmap_free(hashmap *map, hashmap_free_fn free_function)
+void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
 {
 	if (!map || !map->table)
 		return;
 	if (free_function) {
-		hashmap_iter iter;
-		hashmap_entry *e;
+		struct hashmap_iter iter;
+		struct hashmap_entry *e;
 		hashmap_iter_init(map, &iter);
 		while ((e = hashmap_iter_next(&iter)))
 			(*free_function)(e);
@@ -131,26 +132,26 @@ void hashmap_free(hashmap *map, hashmap_free_fn free_function)
 	memset(map, 0, sizeof(*map));
 }
 
-void *hashmap_get(const hashmap *map, const void *key)
+void *hashmap_get(const struct hashmap *map, const void *key)
 {
-	return *find_entry(map, key);
+	return *find_entry_ptr(map, key);
 }
 
-void *hashmap_get_next(const hashmap *map, const void *entry)
+void *hashmap_get_next(const struct hashmap *map, const void *entry)
 {
-	hashmap_entry *e = ((hashmap_entry*) entry)->next;
+	struct hashmap_entry *e = ((struct hashmap_entry*) entry)->next;
 	for (; e; e = e->next)
 		if (entry_equals(map, entry, e))
 			return e;
 	return NULL;
 }
 
-void hashmap_add(hashmap *map, void *entry)
+void hashmap_add(struct hashmap *map, void *entry)
 {
 	unsigned int b = bucket(map, entry);
 
 	/* add entry */
-	((hashmap_entry*) entry)->next = map->table[b];
+	((struct hashmap_entry*) entry)->next = map->table[b];
 	map->table[b] = entry;
 
 	/* fix size and rehash if appropriate */
@@ -159,10 +160,10 @@ void hashmap_add(hashmap *map, void *entry)
 		rehash(map, map->tablesize << HASHMAP_GROW);
 }
 
-void *hashmap_remove(hashmap *map, const void *key)
+void *hashmap_remove(struct hashmap *map, const void *key)
 {
-	hashmap_entry *old;
-	hashmap_entry **e = find_entry(map, key);
+	struct hashmap_entry *old;
+	struct hashmap_entry **e = find_entry_ptr(map, key);
 	if (!*e)
 		return NULL;
 
@@ -174,28 +175,28 @@ void *hashmap_remove(hashmap *map, const void *key)
 	/* fix size and rehash if appropriate */
 	map->size--;
 	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
-		map->size * HASHMAP_SHRINK_AT < map->tablesize)
+	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
 		rehash(map, map->tablesize >> HASHMAP_GROW);
 	return old;
 }
 
-void *hashmap_put(hashmap *map, void *entry)
+void *hashmap_put(struct hashmap *map, void *entry)
 {
-	hashmap_entry *old = hashmap_remove(map, entry);
+	struct hashmap_entry *old = hashmap_remove(map, entry);
 	hashmap_add(map, entry);
 	return old;
 }
 
-void hashmap_iter_init(hashmap *map, hashmap_iter *iter)
+void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)
 {
 	iter->map = map;
 	iter->tablepos = 0;
 	iter->next = NULL;
 }
 
-void *hashmap_iter_next(hashmap_iter *iter)
+void *hashmap_iter_next(struct hashmap_iter *iter)
 {
-	hashmap_entry *current = iter->next;
+	struct hashmap_entry *current = iter->next;
 	for (;;) {
 		if (current) {
 			iter->next = current->next;
diff --git a/hashmap.h b/hashmap.h
index 59f8489..98c4ebc 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -40,15 +40,15 @@ extern unsigned int memhash(const void *buf, size_t len);
 extern unsigned int memihash(const void *buf, size_t len);
 
 /*
- * Hashmap entry data structure, intended to be used as first member of user
- * data structures. Consists of a pointer and an int. Ideally it should be
- * followed by an int-sized member to prevent unused memory on 64-bit systems
- * due to alignment.
+ * Hashmap entry data structure, must be used as first member of user data
+ * structures. Consists of a pointer and an int. Ideally it should be followed
+ * by an int-sized member to prevent unused memory on 64-bit systems due to
+ * alignment.
  */
-typedef struct hashmap_entry {
+struct hashmap_entry {
 	struct hashmap_entry *next;
 	unsigned int hash;
-} hashmap_entry;
+};
 
 /*
  * User-supplied function to test two hashmap entries for equality, shall
@@ -67,20 +67,20 @@ typedef void (*hashmap_free_fn)(void *entry);
 /*
  * Hashmap data structure, use with hashmap_* functions.
  */
-typedef struct hashmap {
-	hashmap_entry **table;
+struct hashmap {
+	struct hashmap_entry **table;
 	hashmap_cmp_fn cmpfn;
 	unsigned int size, tablesize;
-} hashmap;
+};
 
 /*
  * Hashmap iterator data structure, use with hasmap_iter_* functions.
  */
-typedef struct hashmap_iter {
-	hashmap *map;
-	hashmap_entry *next;
+struct hashmap_iter {
+	struct hashmap *map;
+	struct hashmap_entry *next;
 	unsigned int tablepos;
-} hashmap_iter;
+};
 
 /*
  * Initializes a hashmap_entry structure.
@@ -90,9 +90,9 @@ typedef struct hashmap_iter {
  */
 static inline void hashmap_entry_init(void *entry, int hash, int key_only)
 {
-	hashmap_entry *e = entry;
+	struct hashmap_entry *e = entry;
 	e->hash = hash;
-	e->next = key_only ? (hashmap_entry*) -1 : NULL;
+	e->next = key_only ? (struct hashmap_entry*) -1 : NULL;
 }
 
 /*
@@ -108,8 +108,8 @@ static inline void hashmap_entry_init(void *entry, int hash, int key_only)
  */
 static inline int hashmap_entry_is_key(const void *entry)
 {
-	const hashmap_entry *e = entry;
-	return e->next == (hashmap_entry*) -1;
+	const struct hashmap_entry *e = entry;
+	return e->next == (struct hashmap_entry*) -1;
 }
 
 /*
@@ -119,7 +119,7 @@ static inline int hashmap_entry_is_key(const void *entry)
  *  NULL, entries are considered equal if their hash codes are equal.
  * initial_size: optional number of initial entries, 0 if unknown
  */
-extern void hashmap_init(hashmap *map, hashmap_cmp_fn equals_function,
+extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size);
 
 /*
@@ -127,7 +127,7 @@ extern void hashmap_init(hashmap *map, hashmap_cmp_fn equals_function,
  * map: hashmap to free
  * free_function: optional function to free the hashmap entries
  */
-extern void hashmap_free(hashmap *map, hashmap_free_fn free_function);
+extern void hashmap_free(struct hashmap *map, hashmap_free_fn free_function);
 
 /*
  * Returns the hashmap entry for the specified key, or NULL if not found.
@@ -135,7 +135,7 @@ extern void hashmap_free(hashmap *map, hashmap_free_fn free_function);
  * key: key of the entry to look up
  * returns matching hashmap entry, or NULL if not found
  */
-extern void *hashmap_get(const hashmap *map, const void *key);
+extern void *hashmap_get(const struct hashmap *map, const void *key);
 
 /*
  * Returns the next equal hashmap entry if the map contains duplicates (see
@@ -144,7 +144,7 @@ extern void *hashmap_get(const hashmap *map, const void *key);
  * entry: current entry, obtained via hashmap_get or hashmap_get_next
  * returns next equal hashmap entry, or NULL if not found
  */
-extern void *hashmap_get_next(const hashmap *map, const void *entry);
+extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
 
 /*
  * Adds a hashmap entry. This allows to add duplicate entries (i.e. separate
@@ -152,7 +152,7 @@ extern void *hashmap_get_next(const hashmap *map, const void *entry);
  * map: the hashmap
  * entry: the entry to add
  */
-extern void hashmap_add(hashmap *map, void *entry);
+extern void hashmap_add(struct hashmap *map, void *entry);
 
 /*
  * Adds or replaces a hashmap entry.
@@ -160,7 +160,7 @@ extern void hashmap_add(hashmap *map, void *entry);
  * entry: the entry to add or replace
  * returns previous entry, or NULL if the entry is new
  */
-extern void *hashmap_put(hashmap *map, void *entry);
+extern void *hashmap_put(struct hashmap *map, void *entry);
 
 /*
  * Removes a hashmap entry matching the specified key.
@@ -168,21 +168,21 @@ extern void *hashmap_put(hashmap *map, void *entry);
  * key: key of the entry to remove
  * returns removed entry, or NULL if not found
  */
-extern void *hashmap_remove(hashmap *map, const void *key);
+extern void *hashmap_remove(struct hashmap *map, const void *key);
 
 /*
  * Initializes a hashmap iterator structure.
  * map: the hashmap
  * iter: hashmap iterator structure
  */
-extern void hashmap_iter_init(hashmap *map, hashmap_iter *iter);
+extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
 
 /**
  * Returns the next hashmap entry.
  * iter: hashmap iterator
  * returns next entry, or NULL if there are no more entries
  */
-extern void *hashmap_iter_next(hashmap_iter *iter);
+extern void *hashmap_iter_next(struct hashmap_iter *iter);
 
 /**
  * Initializes a hashmap iterator and returns the first hashmap entry.
@@ -190,8 +190,8 @@ extern void *hashmap_iter_next(hashmap_iter *iter);
  * iter: hashmap iterator
  * returns first entry, or NULL if there are no entries
  */
-static inline void *hashmap_iter_first(hashmap *map,
-		hashmap_iter *iter)
+static inline void *hashmap_iter_first(struct hashmap *map,
+		struct hashmap_iter *iter)
 {
 	hashmap_iter_init(map, iter);
 	return hashmap_iter_next(iter);
diff --git a/test-hashmap.c b/test-hashmap.c
index a4b3440..de94c6d 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -2,113 +2,197 @@
 #include "hashmap.h"
 #include <stdio.h>
 
-typedef struct test_entry
+struct test_entry
 {
-	hashmap_entry ent;
+	struct hashmap_entry ent;
 	/* key and value as two \0-terminated strings */
 	char key[FLEX_ARRAY];
-} test_entry;
+};
 
-typedef struct test_key
+struct test_key
 {
-	hashmap_entry ent;
+	struct hashmap_entry ent;
 	char *key;
-} test_key;
+};
 
-static const char *get_key(const test_entry *e)
+static const char *get_key(const struct test_entry *e)
 {
-	return hashmap_entry_is_key(e) ? ((test_key*) e)->key : e->key;
+	return hashmap_entry_is_key(e) ? ((struct test_key*) e)->key : e->key;
 }
 
-static const char *get_value(const test_entry *e)
+static const char *get_value(const struct test_entry *e)
 {
 	return e->key + strlen(e->key) + 1;
 }
 
-static int test_entry_cmp(const test_entry *e1, const test_entry *e2)
+static int test_entry_cmp(const struct test_entry *e1,
+		const struct test_entry *e2)
 {
 	return strcmp(e1->key, get_key(e2));
 }
 
-static int test_entry_cmp_icase(const test_entry *e1, const test_entry *e2)
+static int test_entry_cmp_icase(const struct test_entry *e1,
+		const struct test_entry *e2)
 {
 	return strcasecmp(e1->key, get_key(e2));
 }
 
-static test_entry *alloc_test_entry(int hash, char *key, int klen, char *value,
-		int vlen)
+static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
+		char *value, int vlen)
 {
-	test_entry *entry = malloc(sizeof(test_entry) + klen + vlen + 2);
+	struct test_entry *entry = malloc(sizeof(struct test_entry) + klen
+			+ vlen + 2);
 	hashmap_entry_init(entry, hash, 0);
 	memcpy(entry->key, key, klen + 1);
 	memcpy(entry->key + klen + 1, value, vlen + 1);
 	return entry;
 }
 
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
 /*
  * Test insert performance of hashmap.[ch]
- * Usage: time echo "perfhashmap size rounds" | test-hashmap
+ * Usage: time echo "perfhashmap method rounds" | test-hashmap
  */
-static void perf_hashmap(unsigned int size, unsigned int rounds)
+static void perf_hashmap(unsigned int method, unsigned int rounds)
 {
-	hashmap map;
+	struct hashmap map;
 	char buf[16];
-	test_entry **entries;
+	struct test_entry **entries;
+	unsigned int *hashes;
 	unsigned int i, j;
 
-	entries = malloc(size * sizeof(test_entry*));
-	for (i = 0; i < size; i++) {
+	entries = malloc(TEST_SIZE * sizeof(struct test_entry*));
+	hashes = malloc(TEST_SIZE * sizeof(int));
+	for (i = 0; i < TEST_SIZE; i++) {
 		snprintf(buf, sizeof(buf), "%i", i);
 		entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
+		hashes[i] = hash(method, i, entries[i]->key);
 	}
 
-	for (j = 0; j < rounds; j++) {
-		// initialize the map
+	if (method & TEST_ADD) {
+		/* test adding to the map */
+		for (j = 0; j < rounds; j++) {
+			hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
+
+			/* add entries */
+			for (i = 0; i < TEST_SIZE; i++) {
+				hashmap_entry_init(entries[i], hashes[i], 0);
+				hashmap_add(&map, entries[i]);
+			}
+
+			hashmap_free(&map, NULL);
+		}
+	} else {
+		/* test map lookups */
 		hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
 
-		// add entries
-		for (i = 0; i < size; i++) {
-			unsigned int hash = strhash(entries[i]->key);
-			hashmap_entry_init(entries[i], hash, 0);
+		/* fill the map (sparsely if specified) */
+		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
+		for (i = 0; i < j; i++) {
+			hashmap_entry_init(entries[i], hashes[i], 0);
 			hashmap_add(&map, entries[i]);
 		}
 
+		for (j = 0; j < rounds; j++) {
+			for (i = 0; i < TEST_SIZE; i++) {
+				struct test_key k;
+				hashmap_entry_init(&k, hashes[i], 1);
+				k.key = entries[i]->key;
+				hashmap_get(&map, &k);
+			}
+		}
+
 		hashmap_free(&map, NULL);
 	}
 }
 
-typedef struct hash_entry
+struct hash_entry
 {
 	struct hash_entry *next;
 	char key[FLEX_ARRAY];
-} hash_entry;
+};
 
 /*
  * Test insert performance of hash.[ch]
- * Usage: time echo "perfhashtable size rounds" | test-hashmap
+ * Usage: time echo "perfhash method rounds" | test-hashmap
  */
-static void perf_hashtable(unsigned int size, unsigned int rounds)
+static void perf_hash(unsigned int method, unsigned int rounds)
 {
 	struct hash_table map;
 	char buf[16];
-	hash_entry **entries, **res;
+	struct hash_entry **entries, **res, *entry;
+	unsigned int *hashes;
 	unsigned int i, j;
 
-	entries = malloc(size * sizeof(hash_entry*));
-	for (i = 0; i < size; i++) {
+	entries = malloc(TEST_SIZE * sizeof(struct hash_entry*));
+	hashes = malloc(TEST_SIZE * sizeof(int));
+	for (i = 0; i < TEST_SIZE; i++) {
 		snprintf(buf, sizeof(buf), "%i", i);
-		entries[i] = malloc(sizeof(hash_entry) + strlen(buf) + 1);
+		entries[i] = malloc(sizeof(struct hash_entry) + strlen(buf) + 1);
 		strcpy(entries[i]->key, buf);
+		hashes[i] = hash(method, i, entries[i]->key);
 	}
 
-	for (j = 0; j < rounds; j++) {
-		// initialize the map
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
 		init_hash(&map);
 
-		// add entries
-		for (i = 0; i < size; i++) {
-			unsigned int hash = strhash(entries[i]->key);
-			res = (hash_entry**) insert_hash(hash, entries[i], &map);
+		/* fill the map (sparsely if specified) */
+		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
+		for (i = 0; i < j; i++) {
+			res = (struct hash_entry**) insert_hash(hashes[i],
+					entries[i], &map);
 			if (res) {
 				entries[i]->next = *res;
 				*res = entries[i];
@@ -117,7 +201,19 @@ static void perf_hashtable(unsigned int size, unsigned int rounds)
 			}
 		}
 
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
 		free_hash(&map);
+
 	}
 }
 
@@ -133,13 +229,13 @@ static void perf_hashtable(unsigned int size, unsigned int rounds)
  * iterate -> key1 value1\nkey2 value2\n...
  * size -> tablesize numentries
  *
- * perfhashmap size rounds -> hashmap.[ch]: add <size> entries <rounds> times
- * perfhashtable size rounds -> hash.[ch]: add <size> entries <rounds> times
+ * perfhashmap method rounds -> test hashmap.[ch] performance
+ * perfhash method rounds -> test hash.[ch] performance
  */
 int main(int argc, char *argv[])
 {
 	char line[1024];
-	hashmap map;
+	struct hashmap map;
 	int icase;
 
 	/* init hash map */
@@ -151,7 +247,7 @@ int main(int argc, char *argv[])
 	while (fgets(line, sizeof(line), stdin)) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
 		int l1 = 0, l2 = 0, hash = 0;
-		test_entry *entry;
+		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
 		cmd = strtok(line, DELIM);
@@ -197,7 +293,7 @@ int main(int argc, char *argv[])
 		} else if (!strcmp("get", cmd) && l1) {
 
 			/* setup static key */
-			test_key key;
+			struct test_key key;
 			hashmap_entry_init(&key, hash, 1);
 			key.key = p1;
 
@@ -215,7 +311,7 @@ int main(int argc, char *argv[])
 		} else if (!strcmp("remove", cmd) && l1) {
 
 			/* setup static key */
-			test_key key;
+			struct test_key key;
 			hashmap_entry_init(&key, hash, 1);
 			key.key = p1;
 
@@ -228,7 +324,7 @@ int main(int argc, char *argv[])
 
 		} else if (!strcmp("iterate", cmd)) {
 
-			hashmap_iter iter;
+			struct hashmap_iter iter;
 			hashmap_iter_init(&map, &iter);
 			while ((entry = hashmap_iter_next(&iter)))
 				printf("%s %s\n", get_key(entry), get_value(entry));
@@ -242,9 +338,9 @@ int main(int argc, char *argv[])
 
 			perf_hashmap(atoi(p1), atoi(p2));
 
-		} else if (!strcmp("perfhashtable", cmd) && l1 && l2) {
+		} else if (!strcmp("perfhash", cmd) && l1 && l2) {
 
-			perf_hashtable(atoi(p1), atoi(p2));
+			perf_hash(atoi(p1), atoi(p2));
 
 		} else {
 
