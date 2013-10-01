From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 00/11] New hash table implementation
Date: Tue, 01 Oct 2013 11:33:51 +0200
Message-ID: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwLB-0002fC-R0
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab3JAJd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:33:57 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:60555 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3JAJdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:33:55 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so3284395eek.16
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=oZ88VIPhEmz+ntUQhDxBI+1OjPmUmviVraBapj25JZk=;
        b=e+bSTkf7WXqMpY131bfGmgxduhuyf5cSL9RUhXHrJoz1lY6lhyD5ukpqFtFGSTnmbk
         LGIWG1kBmhUMCi/jb2DO+oMPBLGQwQ1aI4AXFVB8sdxNQEX1SKT4rwDewIosWz55RkKD
         1JuCino25G5VJA8fbvPUyzwqWdkZJyVNwq2EN2oVqKpJfleffBpk/gotIwJ5hkmw4sAe
         9RaBHJHYxwX9+J1bCt/efHKhIE3FbXJoERzPWbCLDJtRkLOs34hRMz2Dc5OWopPCvkmY
         adkhjSMjJaiQjpJFrMzLJhJsX1ppWO4kvMAHhzGzO945Ufwi/fwIAGi6wcXsRi1ptKu1
         up7Q==
X-Received: by 10.15.91.3 with SMTP id r3mr45122053eez.4.1380620032226;
        Tue, 01 Oct 2013 02:33:52 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id k7sm11023692eeg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:33:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235644>

Also here:
https://github.com/kblees/git/tree/kb/hashmap-v3

Previous discussion:
http://thread.gmane.org/gmane.comp.version-control.git/234508


Changes since v2:
- move documentation from hashmap.h to Documentation/technical/api-hashmap.txt
- simpler way to deal with FLEX_ARRAY keys: instead of requiring a special
  key structure (and function hashmap_entry_is_key), hashmap_get and
  hashmap_remove now take an additional parameter that is passed through to
  the comparison function

Added since v2 (patches 06 - 11):
- convert name-hash.c to new hash map implementation
- fix memory leaks caused by not free()ing removed cache_entries
- remove now unused hash.[ch] implementation


Performance:
While the main motivation for the patch series wasn't performance, _actual_ git performance will most likely benefit from the name-hash.c changes. So here's the numbers for 10 git-status runs on the WebKit repo (~200k files, with core.preloadindex=true). Not exactly a quantum leap, but its measurable.

git status -s | hash  | hashmap |    gain
--------------+-------+---------+-------------
real avg      | 0.969 |   0.959 | 0.010 / 1.0%
real min      | 0.910 |   0.895 | 0.015 / 1.6%
real max      | 1.079 |   0.993 | 0.086 / 8.0%


Cheers,
Karsten

Karsten Blees (11):
  add a hashtable implementation that supports O(1) removal
  buitin/describe.c: use new hash map implementation
  diffcore-rename.c: move code around to prepare for the next patch
  diffcore-rename.c: simplify finding exact renames
  diffcore-rename.c: use new hash map implementation
  name-hash.c: use new hash map implementation for directories
  name-hash.c: remove unreferenced directory entries
  name-hash.c: use new hash map implementation for cache entries
  name-hash.c: remove cache entries instead of marking them CE_UNHASHED
  read-cache.c: fix memory leaks caused by removed cache entries
  remove old hash.[ch] implementation

 Documentation/technical/api-hash.txt    |  52 -------
 Documentation/technical/api-hashmap.txt | 237 +++++++++++++++++++++++++++++
 Makefile                                |   5 +-
 builtin/describe.c                      |  53 +++----
 builtin/rm.c                            |   2 +-
 cache.h                                 |  18 +--
 diffcore-rename.c                       | 185 ++++++++---------------
 hash.c                                  | 110 --------------
 hash.h                                  |  50 -------
 hashmap.c                               | 212 ++++++++++++++++++++++++++
 hashmap.h                               |  72 +++++++++
 name-hash.c                             | 156 +++++++------------
 read-cache.c                            |   8 +-
 resolve-undo.c                          |   7 +-
 t/t0011-hashmap.sh                      | 236 +++++++++++++++++++++++++++++
 test-hashmap.c                          | 256 ++++++++++++++++++++++++++++++++
 unpack-trees.c                          |   3 +-
 17 files changed, 1179 insertions(+), 483 deletions(-)
 delete mode 100644 Documentation/technical/api-hash.txt
 create mode 100644 Documentation/technical/api-hashmap.txt
 delete mode 100644 hash.c
 delete mode 100644 hash.h
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c


---
Note: interdiff for patches 01 - 05 only (which have been part of v2):

git diff -p --stat kb/hashmap-v2..kb/hashmap-v3~6
 Documentation/technical/api-hashmap.txt | 237 ++++++++++++++++++++++++++++++++
 builtin/describe.c                      |  12 +-
 diffcore-rename.c                       |   6 +-
 hashmap.c                               |  23 ++--
 hashmap.h                               | 170 +++--------------------
 test-hashmap.c                          |  48 +++----
 6 files changed, 296 insertions(+), 200 deletions(-)

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
diff --git a/builtin/describe.c b/builtin/describe.c
index 5db5d89..ae8d32c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -50,9 +50,10 @@ static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
-static int commit_name_cmp(struct commit_name *cn1, struct commit_name *cn2)
+static int commit_name_cmp(const struct commit_name *cn1,
+		const struct commit_name *cn2, const void *peeled)
 {
-	return hashcmp(cn1->peeled, cn2->peeled);
+	return hashcmp(cn1->peeled, peeled ? peeled : cn2->peeled);
 }
 
 static inline unsigned int hash_sha1(const unsigned char *sha1)
@@ -65,9 +66,8 @@ static inline unsigned int hash_sha1(const unsigned char *sha1)
 static inline struct commit_name *find_commit_name(const unsigned char *peeled)
 {
 	struct commit_name key;
-	hashmap_entry_init(&key, hash_sha1(peeled), 0);
-	hashcpy(key.peeled, peeled);
-	return hashmap_get(&names, &key);
+	hashmap_entry_init(&key, hash_sha1(peeled));
+	return hashmap_get(&names, &key, peeled);
 }
 
 static int replace_name(struct commit_name *e,
@@ -114,7 +114,7 @@ static void add_to_known_names(const char *path,
 		if (!e) {
 			e = xmalloc(sizeof(struct commit_name));
 			hashcpy(e->peeled, peeled);
-			hashmap_entry_init(e, hash_sha1(peeled), 0);
+			hashmap_entry_init(e, hash_sha1(peeled));
 			hashmap_add(&names, e);
 			e->path = NULL;
 		}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2e70d31..c6bd776 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -274,8 +274,8 @@ static int find_identical_files(struct hashmap *srcs,
 	 * Find the best source match for specified destination.
 	 */
 	best = NULL;
-	hashmap_entry_init(&dst, hash_filespec(target), 0);
-	for (p = hashmap_get(srcs, &dst); p; p = hashmap_get_next(srcs, p)) {
+	hashmap_entry_init(&dst, hash_filespec(target));
+	for (p = hashmap_get(srcs, &dst, NULL); p; p = hashmap_get_next(srcs, p)) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
@@ -317,7 +317,7 @@ static void insert_file_table(struct hashmap *table, int index, struct diff_file
 	entry->index = index;
 	entry->filespec = filespec;
 
-	hashmap_entry_init(entry, hash_filespec(filespec), 0);
+	hashmap_entry_init(entry, hash_filespec(filespec));
 	hashmap_add(table, entry);
 }
 
diff --git a/hashmap.c b/hashmap.c
index 75a8578..3a9f8c1 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -59,9 +59,10 @@ unsigned int memihash(const void *buf, size_t len)
 #define HASHMAP_SHRINK_AT 6
 
 static inline int entry_equals(const struct hashmap *map,
-		const struct hashmap_entry *e1, const struct hashmap_entry *e2)
+		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
+		const void *keydata)
 {
-	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2));
+	return (e1 == e2) || (e1->hash == e2->hash && !(*map->cmpfn)(e1, e2, keydata));
 }
 
 static inline unsigned int bucket(const struct hashmap *map,
@@ -91,15 +92,15 @@ static void rehash(struct hashmap *map, unsigned int newsize)
 }
 
 static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
-		const struct hashmap_entry *key)
+		const struct hashmap_entry *key, const void *keydata)
 {
 	struct hashmap_entry **e = &map->table[bucket(map, key)];
-	while (*e && !entry_equals(map, *e, key))
+	while (*e && !entry_equals(map, *e, key, keydata))
 		e = &(*e)->next;
 	return e;
 }
 
-static int always_equal(const void *unused1, const void *unused2)
+static int always_equal(const void *unused1, const void *unused2, const void *unused3)
 {
 	return 0;
 }
@@ -132,16 +133,16 @@ void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
 	memset(map, 0, sizeof(*map));
 }
 
-void *hashmap_get(const struct hashmap *map, const void *key)
+void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
 {
-	return *find_entry_ptr(map, key);
+	return *find_entry_ptr(map, key, keydata);
 }
 
 void *hashmap_get_next(const struct hashmap *map, const void *entry)
 {
 	struct hashmap_entry *e = ((struct hashmap_entry*) entry)->next;
 	for (; e; e = e->next)
-		if (entry_equals(map, entry, e))
+		if (entry_equals(map, entry, e, NULL))
 			return e;
 	return NULL;
 }
@@ -160,10 +161,10 @@ void hashmap_add(struct hashmap *map, void *entry)
 		rehash(map, map->tablesize << HASHMAP_GROW);
 }
 
-void *hashmap_remove(struct hashmap *map, const void *key)
+void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
 {
 	struct hashmap_entry *old;
-	struct hashmap_entry **e = find_entry_ptr(map, key);
+	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
 	if (!*e)
 		return NULL;
 
@@ -182,7 +183,7 @@ void *hashmap_remove(struct hashmap *map, const void *key)
 
 void *hashmap_put(struct hashmap *map, void *entry)
 {
-	struct hashmap_entry *old = hashmap_remove(map, entry);
+	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
 	hashmap_add(map, entry);
 	return old;
 }
diff --git a/hashmap.h b/hashmap.h
index 98c4ebc..eea003a 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -2,194 +2,66 @@
 #define HASHMAP_H
 
 /*
- * Generic implementation of hash-based key value mappings.
- * Supports basic operations get, add/put, remove and iteration.
- *
- * Also contains a set of ready-to-use hash functions for strings, using the
- * FNV-1 algorithm (see http://www.isthe.com/chongo/tech/comp/fnv).
+ * Generic implementation of hash-based key-value mappings.
+ * See Documentation/technical/api-hashmap.txt.
  */
 
-/*
- * Case-sensitive FNV-1 hash of 0-terminated string.
- * str: the string
- * returns hash code
- */
-extern unsigned int strhash(const char *buf);
+/* FNV-1 functions */
 
-/*
- * Case-insensitive FNV-1 hash of 0-terminated string.
- * str: the string
- * returns hash code
- */
+extern unsigned int strhash(const char *buf);
 extern unsigned int strihash(const char *buf);
-
-/*
- * Case-sensitive FNV-1 hash of a memory block.
- * buf: start of the memory block
- * len: length of the memory block
- * returns hash code
- */
 extern unsigned int memhash(const void *buf, size_t len);
-
-/*
- * Case-insensitive FNV-1 hash of a memory block.
- * buf: start of the memory block
- * len: length of the memory block
- * returns hash code
- */
 extern unsigned int memihash(const void *buf, size_t len);
 
-/*
- * Hashmap entry data structure, must be used as first member of user data
- * structures. Consists of a pointer and an int. Ideally it should be followed
- * by an int-sized member to prevent unused memory on 64-bit systems due to
- * alignment.
- */
+/* data structures */
+
 struct hashmap_entry {
 	struct hashmap_entry *next;
 	unsigned int hash;
 };
 
-/*
- * User-supplied function to test two hashmap entries for equality, shall
- * return 0 if the entries are equal. This function is always called with
- * non-NULL parameters that have the same hash code. When looking up an entry,
- * the key parameter to hashmap_get and hashmap_remove is always passed as
- * second argument.
- */
-typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key);
-
-/*
- * User-supplied function to free a hashmap entry.
- */
+typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
+		const void *keydata);
 typedef void (*hashmap_free_fn)(void *entry);
 
-/*
- * Hashmap data structure, use with hashmap_* functions.
- */
 struct hashmap {
 	struct hashmap_entry **table;
 	hashmap_cmp_fn cmpfn;
 	unsigned int size, tablesize;
 };
 
-/*
- * Hashmap iterator data structure, use with hasmap_iter_* functions.
- */
 struct hashmap_iter {
 	struct hashmap *map;
 	struct hashmap_entry *next;
 	unsigned int tablepos;
 };
 
-/*
- * Initializes a hashmap_entry structure.
- * entry: pointer to the entry to initialize
- * hash: hash code of the entry
- * key_only: true if entry is a key-only structure, see hashmap_entry_is_key
- */
-static inline void hashmap_entry_init(void *entry, int hash, int key_only)
-{
-	struct hashmap_entry *e = entry;
-	e->hash = hash;
-	e->next = key_only ? (struct hashmap_entry*) -1 : NULL;
-}
-
-/*
- * Checks if hashmap_entry was initialized with the key_only flag. This is
- * useful if the entry structure is variable-sized (e.g. ending in a FLEX_ARRAY)
- * and the key is part of the variable portion. To prevent dynamic allocation of
- * a full-fledged entry structure for each lookup, a smaller, statically sized
- * structure can be used as key (i.e. replacing the FLEX_ARRAY member with a
- * char pointer). The hashmap_cmp_fn comparison function can then check whether
- * entry_or_key is a full-fledged entry or a key-only structure.
- * entry: pointer to the entry to check
- * returns 0 for key-value entries and non-0 for key-only entries
- */
-static inline int hashmap_entry_is_key(const void *entry)
-{
-	const struct hashmap_entry *e = entry;
-	return e->next == (struct hashmap_entry*) -1;
-}
+/* hashmap functions */
 
-/*
- * Initializes a hashmap structure.
- * map: hashmap to initialize
- * equals_function: optional function to test equality of hashmap entries. If
- *  NULL, entries are considered equal if their hash codes are equal.
- * initial_size: optional number of initial entries, 0 if unknown
- */
 extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size);
-
-/*
- * Frees a hashmap structure and allocated memory.
- * map: hashmap to free
- * free_function: optional function to free the hashmap entries
- */
 extern void hashmap_free(struct hashmap *map, hashmap_free_fn free_function);
 
-/*
- * Returns the hashmap entry for the specified key, or NULL if not found.
- * map: the hashmap
- * key: key of the entry to look up
- * returns matching hashmap entry, or NULL if not found
- */
-extern void *hashmap_get(const struct hashmap *map, const void *key);
+/* hashmap_entry functions */
 
-/*
- * Returns the next equal hashmap entry if the map contains duplicates (see
- * hashmap_add).
- * map: the hashmap
- * entry: current entry, obtained via hashmap_get or hashmap_get_next
- * returns next equal hashmap entry, or NULL if not found
- */
+static inline void hashmap_entry_init(void *entry, int hash)
+{
+	struct hashmap_entry *e = entry;
+	e->hash = hash;
+	e->next = NULL;
+}
+extern void *hashmap_get(const struct hashmap *map, const void *key,
+		const void *keydata);
 extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
-
-/*
- * Adds a hashmap entry. This allows to add duplicate entries (i.e. separate
- * values with the same key according to hashmap_cmp_fn).
- * map: the hashmap
- * entry: the entry to add
- */
 extern void hashmap_add(struct hashmap *map, void *entry);
-
-/*
- * Adds or replaces a hashmap entry.
- * map: the hashmap
- * entry: the entry to add or replace
- * returns previous entry, or NULL if the entry is new
- */
 extern void *hashmap_put(struct hashmap *map, void *entry);
+extern void *hashmap_remove(struct hashmap *map, const void *key,
+		const void *keydata);
 
-/*
- * Removes a hashmap entry matching the specified key.
- * map: the hashmap
- * key: key of the entry to remove
- * returns removed entry, or NULL if not found
- */
-extern void *hashmap_remove(struct hashmap *map, const void *key);
+/* hashmap_iter functions */
 
-/*
- * Initializes a hashmap iterator structure.
- * map: the hashmap
- * iter: hashmap iterator structure
- */
 extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
-
-/**
- * Returns the next hashmap entry.
- * iter: hashmap iterator
- * returns next entry, or NULL if there are no more entries
- */
 extern void *hashmap_iter_next(struct hashmap_iter *iter);
-
-/**
- * Initializes a hashmap iterator and returns the first hashmap entry.
- * map: the hashmap
- * iter: hashmap iterator
- * returns first entry, or NULL if there are no entries
- */
 static inline void *hashmap_iter_first(struct hashmap *map,
 		struct hashmap_iter *iter)
 {
diff --git a/test-hashmap.c b/test-hashmap.c
index de94c6d..2d2b834 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -9,32 +9,21 @@ struct test_entry
 	char key[FLEX_ARRAY];
 };
 
-struct test_key
-{
-	struct hashmap_entry ent;
-	char *key;
-};
-
-static const char *get_key(const struct test_entry *e)
-{
-	return hashmap_entry_is_key(e) ? ((struct test_key*) e)->key : e->key;
-}
-
 static const char *get_value(const struct test_entry *e)
 {
 	return e->key + strlen(e->key) + 1;
 }
 
 static int test_entry_cmp(const struct test_entry *e1,
-		const struct test_entry *e2)
+		const struct test_entry *e2, const char* key)
 {
-	return strcmp(e1->key, get_key(e2));
+	return strcmp(e1->key, key ? key : e2->key);
 }
 
 static int test_entry_cmp_icase(const struct test_entry *e1,
-		const struct test_entry *e2)
+		const struct test_entry *e2, const char* key)
 {
-	return strcasecmp(e1->key, get_key(e2));
+	return strcasecmp(e1->key, key ? key : e2->key);
 }
 
 static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
@@ -42,7 +31,7 @@ static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
 {
 	struct test_entry *entry = malloc(sizeof(struct test_entry) + klen
 			+ vlen + 2);
-	hashmap_entry_init(entry, hash, 0);
+	hashmap_entry_init(entry, hash);
 	memcpy(entry->key, key, klen + 1);
 	memcpy(entry->key + klen + 1, value, vlen + 1);
 	return entry;
@@ -108,7 +97,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 
 			/* add entries */
 			for (i = 0; i < TEST_SIZE; i++) {
-				hashmap_entry_init(entries[i], hashes[i], 0);
+				hashmap_entry_init(entries[i], hashes[i]);
 				hashmap_add(&map, entries[i]);
 			}
 
@@ -121,16 +110,15 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 		/* fill the map (sparsely if specified) */
 		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
 		for (i = 0; i < j; i++) {
-			hashmap_entry_init(entries[i], hashes[i], 0);
+			hashmap_entry_init(entries[i], hashes[i]);
 			hashmap_add(&map, entries[i]);
 		}
 
 		for (j = 0; j < rounds; j++) {
 			for (i = 0; i < TEST_SIZE; i++) {
-				struct test_key k;
-				hashmap_entry_init(&k, hashes[i], 1);
-				k.key = entries[i]->key;
-				hashmap_get(&map, &k);
+				struct hashmap_entry key;
+				hashmap_entry_init(&key, hashes[i]);
+				hashmap_get(&map, &key, entries[i]->key);
 			}
 		}
 
@@ -293,12 +281,11 @@ int main(int argc, char *argv[])
 		} else if (!strcmp("get", cmd) && l1) {
 
 			/* setup static key */
-			struct test_key key;
-			hashmap_entry_init(&key, hash, 1);
-			key.key = p1;
+			struct hashmap_entry key;
+			hashmap_entry_init(&key, hash);
 
 			/* lookup entry in hashmap */
-			entry = hashmap_get(&map, &key);
+			entry = hashmap_get(&map, &key, p1);
 
 			/* print result */
 			if (!entry)
@@ -311,12 +298,11 @@ int main(int argc, char *argv[])
 		} else if (!strcmp("remove", cmd) && l1) {
 
 			/* setup static key */
-			struct test_key key;
-			hashmap_entry_init(&key, hash, 1);
-			key.key = p1;
+			struct hashmap_entry key;
+			hashmap_entry_init(&key, hash);
 
 			/* remove entry from hashmap */
-			entry = hashmap_remove(&map, &key);
+			entry = hashmap_remove(&map, &key, p1);
 
 			/* print result and free entry*/
 			puts(entry ? get_value(entry) : "NULL");
@@ -327,7 +313,7 @@ int main(int argc, char *argv[])
 			struct hashmap_iter iter;
 			hashmap_iter_init(&map, &iter);
 			while ((entry = hashmap_iter_next(&iter)))
-				printf("%s %s\n", get_key(entry), get_value(entry));
+				printf("%s %s\n", entry->key, get_value(entry));
 
 		} else if (!strcmp("size", cmd)) {
 
