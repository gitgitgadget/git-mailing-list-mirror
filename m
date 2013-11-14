From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 00/14] New hash table implementation
Date: Thu, 14 Nov 2013 20:08:37 +0100
Message-ID: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:08:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2HS-0007MM-DV
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab3KNTIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:08:38 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:44669 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3KNTIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:08:37 -0500
Received: by mail-we0-f173.google.com with SMTP id u56so2493890wes.18
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=3q/CzcfXsTprNDxkSV+YPQulPDp1KL//m00Glw40j9w=;
        b=LXPY4uW/yhJ5Ke5YPHc/Iyg3yVod/gVOWFm+I4CwfLhnBmExw2CzjzSezX/BIP3SEm
         sJzOlwNBDO7Z0IkSW3LV0eELkftj9fm4dwnENRhA5iKEYOciSLSvi4LzoYk2Mx2LVOem
         AOjPw2Lfsbl9sc/Jg+FccaR9Q2CykskIFyezhXM31tV/HAS8XagX629XnNboyLL1n3Kd
         YGUrssZfD9iVBtfONhxva7TPGoCFWC9uAT3x4IHIM2xK//tyWvuYuD0dFsYCgKMZmWD7
         CwyQceXXJr/7kEYSjRwfVNVpsh5/4EPykR4CjIP2hWhIBLIjfs9yHfKvdWF5cb3QFjuc
         nlug==
X-Received: by 10.194.58.104 with SMTP id p8mr3502320wjq.1.1384456115445;
        Thu, 14 Nov 2013 11:08:35 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id x19sm1494376wia.5.2013.11.14.11.08.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:08:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237860>

Also here:
https://github.com/kblees/git/commits/kb/hashmap-v5

Changes since v3:
- changed table resizing and grow / shrink thresholds (#02)
- hashmap_free: changed free_function to boolean (#02, #06, #07, #09)
- swapped xcalloc args (num elements, element size) (#02)
- fixed pointer cast formatting "(type*)" -> "(type *)" (#02)
- removed function pointer casts "(*fn)(...)" -> "fn(...)" (#02)
- api-hashmap.txt: clarified removal / replacement of entries (#02)
- update-index.c: fixed const-casts (#13, #14)

Karsten


Jens Lehmann (1):
  submodule: don't access the .gitmodules cache entry after removing it

Karsten Blees (13):
  add a hashtable implementation that supports O(1) removal
  buitin/describe.c: use new hash map implementation
  diffcore-rename.c: move code around to prepare for the next patch
  diffcore-rename.c: simplify finding exact renames
  diffcore-rename.c: use new hash map implementation
  name-hash.c: use new hash map implementation for directories
  name-hash.c: remove unreferenced directory entries
  name-hash.c: use new hash map implementation for cache entries
  name-hash.c: remove cache entries instead of marking them CE_UNHASHED
  remove old hash.[ch] implementation
  fix 'git update-index --verbose --again' output
  builtin/update-index.c: cleanup update_one
  read-cache.c: fix memory leaks caused by removed cache entries

 Documentation/technical/api-hash.txt    |  52 -------
 Documentation/technical/api-hashmap.txt | 235 +++++++++++++++++++++++++++++
 Makefile                                |   5 +-
 builtin/describe.c                      |  53 +++----
 builtin/rm.c                            |   2 +-
 builtin/update-index.c                  |  39 +++--
 cache.h                                 |  18 +--
 diffcore-rename.c                       | 185 ++++++++---------------
 hash.c                                  | 110 --------------
 hash.h                                  |  50 -------
 hashmap.c                               | 228 ++++++++++++++++++++++++++++
 hashmap.h                               |  71 +++++++++
 name-hash.c                             | 156 +++++++------------
 read-cache.c                            |  10 +-
 resolve-undo.c                          |   7 +-
 submodule.c                             |  25 +---
 t/t0011-hashmap.sh                      | 240 ++++++++++++++++++++++++++++++
 test-hashmap.c                          | 256 ++++++++++++++++++++++++++++++++
 unpack-trees.c                          |   3 +-
 19 files changed, 1216 insertions(+), 529 deletions(-)
 delete mode 100644 Documentation/technical/api-hash.txt
 create mode 100644 Documentation/technical/api-hashmap.txt
 delete mode 100644 hash.c
 delete mode 100644 hash.h
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c

--

git diff kb/hashmap-v4:

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index fc46e56..b2280f1 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -42,11 +42,6 @@ parameters that have the same hash code. When looking up an entry, the `key`
 and `keydata` parameters to hashmap_get and hashmap_remove are always passed
 as second and third argument, respectively. Otherwise, `keydata` is NULL.
 
-`void (*hashmap_free_fn)(void *entry)`::
-
-	User-supplied function to free a hashmap_entry. If entries are simply
-	malloc'ed memory, use stdlib's free() function.
-
 Functions
 ---------
 
@@ -76,14 +71,14 @@ If the total number of entries is known in advance, the `initial_size`
 parameter may be used to preallocate a sufficiently large table and thus
 prevent expensive resizing. If 0, the table is dynamically resized.
 
-`void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)`::
+`void hashmap_free(struct hashmap *map, int free_entries)`::
 
 	Frees a hashmap structure and allocated memory.
 +
 `map` is the hashmap to free.
 +
-If `free_function` is specified (not NULL), it is called to free each
-hashmap_entry in the map. If entries are simply malloc'ed, use stdlib's free().
+If `free_entries` is true, each hashmap_entry in the map is freed as well
+(using stdlib's free()).
 
 `void hashmap_entry_init(void *entry, int hash)`::
 
@@ -127,17 +122,20 @@ call to `hashmap_get` or `hashmap_get_next`.
 
 `void *hashmap_put(struct hashmap *map, void *entry)`::
 
-	Adds or replaces a hashmap entry.
+	Adds or replaces a hashmap entry. If the hashmap contains duplicate
+	entries equal to the specified entry, only one of them will be replaced.
 +
 `map` is the hashmap structure.
 +
-`entry` is the entry to add or update.
+`entry` is the entry to add or replace.
 +
-Returns the previous entry, or NULL if not found (i.e. the entry was added).
+Returns the replaced entry, or NULL if not found (i.e. the entry was added).
 
 `void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)`::
 
-	Removes a hashmap entry matching the specified key.
+	Removes a hashmap entry matching the specified key. If the hashmap
+	contains duplicate entries equal to the specified key, only one of
+	them will be removed.
 +
 `map` is the hashmap structure.
 +
@@ -183,14 +181,14 @@ static int long2double_cmp(const struct long2double *e1, const struct long2doubl
 	return !(e1->key == e2->key);
 }
 
-void long2double_init()
+void long2double_init(void)
 {
 	hashmap_init(&map, (hashmap_cmp_fn) long2double_cmp, 0);
 }
 
-void long2double_free()
+void long2double_free(void)
 {
-	hashmap_free(&map, free);
+	hashmap_free(&map, 1);
 }
 
 static struct long2double *find_entry(long key)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index acd992d..00313f3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -559,7 +559,7 @@ static int do_reupdate(int ac, const char **av,
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
-		const char *path;
+		char *path;
 
 		if (ce_stage(ce) || !ce_path_match(ce, &pathspec))
 			continue;
@@ -838,7 +838,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			free(p);
+			free((char *)p);
 			ctx.argc--;
 			ctx.argv++;
 			break;
@@ -880,7 +880,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			free(p);
+			free((char *)p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d996c6a..9b4f068 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -343,7 +343,7 @@ static int find_exact_renames(struct diff_options *options)
 		renames += find_identical_files(&file_table, i, options);
 
 	/* Free the hash data structure and entries */
-	hashmap_free(&file_table, free);
+	hashmap_free(&file_table, 1);
 
 	return renames;
 }
diff --git a/hashmap.c b/hashmap.c
index 3a9f8c1..d1b8056 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -29,7 +29,7 @@ unsigned int strihash(const char *str)
 unsigned int memhash(const void *buf, size_t len)
 {
 	unsigned int hash = FNV32_BASE;
-	unsigned char *ucbuf = (unsigned char*) buf;
+	unsigned char *ucbuf = (unsigned char *) buf;
 	while (len--) {
 		unsigned int c = *ucbuf++;
 		hash = (hash * FNV32_PRIME) ^ c;
@@ -40,7 +40,7 @@ unsigned int memhash(const void *buf, size_t len)
 unsigned int memihash(const void *buf, size_t len)
 {
 	unsigned int hash = FNV32_BASE;
-	unsigned char *ucbuf = (unsigned char*) buf;
+	unsigned char *ucbuf = (unsigned char *) buf;
 	while (len--) {
 		unsigned int c = *ucbuf++;
 		if (c >= 'a' && c <= 'z')
@@ -52,17 +52,33 @@ unsigned int memihash(const void *buf, size_t len)
 
 #define HASHMAP_INITIAL_SIZE 64
 /* grow / shrink by 2^2 */
-#define HASHMAP_GROW 2
-/* grow if > 80% full (to 20%) */
-#define HASHMAP_GROW_AT 1.25
-/* shrink if < 16.6% full (to 66.6%) */
-#define HASHMAP_SHRINK_AT 6
+#define HASHMAP_RESIZE_BITS 2
+/* load factor in percent */
+#define HASHMAP_LOAD_FACTOR 80
+
+static void alloc_table(struct hashmap *map, unsigned int size)
+{
+	map->tablesize = size;
+	map->table = xcalloc(size, sizeof(struct hashmap_entry *));
+
+	/* calculate resize thresholds for new size */
+	map->grow_at = (unsigned int) ((uint64_t) size * HASHMAP_LOAD_FACTOR / 100);
+	if (size <= HASHMAP_INITIAL_SIZE)
+		map->shrink_at = 0;
+	else
+		/*
+		 * The shrink-threshold must be slightly smaller than
+		 * (grow-threshold / resize-factor) to prevent erratic resizing,
+		 * thus we divide by (resize-factor + 1).
+		 */
+		map->shrink_at = map->grow_at / ((1 << HASHMAP_RESIZE_BITS) + 1);
+}
 
 static inline int entry_equals(const struct hashmap *map,
 		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
 		const void *keydata)
 {
-	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2, keydata));
+	return (e1 == e2) || (e1->hash == e2->hash && !map->cmpfn(e1, e2, keydata));
 }
 
 static inline unsigned int bucket(const struct hashmap *map,
@@ -76,8 +92,7 @@ static void rehash(struct hashmap *map, unsigned int newsize)
 	unsigned int i, oldsize = map->tablesize;
 	struct hashmap_entry **oldtable = map->table;
 
-	map->tablesize = newsize;
-	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
+	alloc_table(map, newsize);
 	for (i = 0; i < oldsize; i++) {
 		struct hashmap_entry *e = oldtable[i];
 		while (e) {
@@ -108,26 +123,28 @@ static int always_equal(const void *unused1, const void *unused2, const void *un
 void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size)
 {
+	unsigned int size = HASHMAP_INITIAL_SIZE;
 	map->size = 0;
 	map->cmpfn = equals_function ? equals_function : always_equal;
+
 	/* calculate initial table size and allocate the table */
-	map->tablesize = HASHMAP_INITIAL_SIZE;
-	initial_size *= HASHMAP_GROW_AT;
-	while (initial_size > map->tablesize)
-		map->tablesize <<= HASHMAP_GROW;
-	map->table = xcalloc(sizeof(struct hashmap_entry*), map->tablesize);
+	initial_size = (unsigned int) ((uint64_t) initial_size * 100
+			/ HASHMAP_LOAD_FACTOR);
+	while (initial_size > size)
+		size <<= HASHMAP_RESIZE_BITS;
+	alloc_table(map, size);
 }
 
-void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
+void hashmap_free(struct hashmap *map, int free_entries)
 {
 	if (!map || !map->table)
 		return;
-	if (free_function) {
+	if (free_entries) {
 		struct hashmap_iter iter;
 		struct hashmap_entry *e;
 		hashmap_iter_init(map, &iter);
 		while ((e = hashmap_iter_next(&iter)))
-			(*free_function)(e);
+			free(e);
 	}
 	free(map->table);
 	memset(map, 0, sizeof(*map));
@@ -140,7 +157,7 @@ void *hashmap_get(const struct hashmap *map, const void *key, const void *keydat
 
 void *hashmap_get_next(const struct hashmap *map, const void *entry)
 {
-	struct hashmap_entry *e = ((struct hashmap_entry*) entry)->next;
+	struct hashmap_entry *e = ((struct hashmap_entry *) entry)->next;
 	for (; e; e = e->next)
 		if (entry_equals(map, entry, e, NULL))
 			return e;
@@ -152,13 +169,13 @@ void hashmap_add(struct hashmap *map, void *entry)
 	unsigned int b = bucket(map, entry);
 
 	/* add entry */
-	((struct hashmap_entry*) entry)->next = map->table[b];
+	((struct hashmap_entry *) entry)->next = map->table[b];
 	map->table[b] = entry;
 
 	/* fix size and rehash if appropriate */
 	map->size++;
-	if (map->size * HASHMAP_GROW_AT > map->tablesize)
-		rehash(map, map->tablesize << HASHMAP_GROW);
+	if (map->size > map->grow_at)
+		rehash(map, map->tablesize << HASHMAP_RESIZE_BITS);
 }
 
 void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
@@ -175,9 +192,8 @@ void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
 
 	/* fix size and rehash if appropriate */
 	map->size--;
-	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
-	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
-		rehash(map, map->tablesize >> HASHMAP_GROW);
+	if (map->size < map->shrink_at)
+		rehash(map, map->tablesize >> HASHMAP_RESIZE_BITS);
 	return old;
 }
 
diff --git a/hashmap.h b/hashmap.h
index eea003a..f5b3b61 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -22,12 +22,11 @@ struct hashmap_entry {
 
 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
 		const void *keydata);
-typedef void (*hashmap_free_fn)(void *entry);
 
 struct hashmap {
 	struct hashmap_entry **table;
 	hashmap_cmp_fn cmpfn;
-	unsigned int size, tablesize;
+	unsigned int size, tablesize, grow_at, shrink_at;
 };
 
 struct hashmap_iter {
@@ -40,7 +39,7 @@ struct hashmap_iter {
 
 extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size);
-extern void hashmap_free(struct hashmap *map, hashmap_free_fn free_function);
+extern void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
 
diff --git a/name-hash.c b/name-hash.c
index 8871d8e..9a3bd3f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -240,6 +240,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	hashmap_free(&istate->name_hash, NULL);
-	hashmap_free(&istate->dir_hash, free);
+	hashmap_free(&istate->name_hash, 0);
+	hashmap_free(&istate->dir_hash, 1);
 }
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 6c699d5..391e2b6 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -221,13 +221,17 @@ test_expect_success 'grow / shrink' '
 	echo NULL >> expect
 	echo size >> in &&
 	echo 256 52 >> expect &&
-	for n in $(test_seq 10)
+	for n in $(test_seq 12)
 	do
 		echo remove key$n >> in &&
 		echo value$n >> expect
 	done &&
 	echo size >> in &&
-	echo 64 42 >> expect &&
+	echo 256 40 >> expect &&
+	echo remove key40 >> in &&
+	echo value40 >> expect &&
+	echo size >> in &&
+	echo 64 39 >> expect &&
 	cat in | test-hashmap > out &&
 	test_cmp expect out
 
diff --git a/test-hashmap.c b/test-hashmap.c
index 333b7b3..7e86f88 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -71,7 +71,7 @@ static unsigned int hash(unsigned int method, unsigned int i, const char *key)
 }
 
 /*
- * Test insert performance of hashmap.[ch]
+ * Test performance of hashmap.[ch]
  * Usage: time echo "perfhashmap method rounds" | test-hashmap
  */
 static void perf_hashmap(unsigned int method, unsigned int rounds)
@@ -82,7 +82,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	unsigned int *hashes;
 	unsigned int i, j;
 
-	entries = malloc(TEST_SIZE * sizeof(struct test_entry*));
+	entries = malloc(TEST_SIZE * sizeof(struct test_entry *));
 	hashes = malloc(TEST_SIZE * sizeof(int));
 	for (i = 0; i < TEST_SIZE; i++) {
 		snprintf(buf, sizeof(buf), "%i", i);
@@ -101,7 +101,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 				hashmap_add(&map, entries[i]);
 			}
 
-			hashmap_free(&map, NULL);
+			hashmap_free(&map, 0);
 		}
 	} else {
 		/* test map lookups */
@@ -122,7 +122,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 			}
 		}
 
-		hashmap_free(&map, NULL);
+		hashmap_free(&map, 0);
 	}
 }
 
@@ -251,6 +251,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	hashmap_free(&map, free);
+	hashmap_free(&map, 1);
 	return 0;
 }
