From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 11/11] remove old hash.[ch] implementation
Date: Tue, 01 Oct 2013 11:40:58 +0200
Message-ID: <524A98AA.70108@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:41:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwS2-0007o4-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3JAJlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:41:01 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:41268 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab3JAJlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:41:00 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so3286915eek.4
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=m503UEKM6k5PeO2f0pDJS5K602D3GXs/sHw7utOLEq0=;
        b=k3X0SYZqoAnpnmJyjYBtU+gE1PMX9mqLWs/b00Gy8huv92NZ7MuCSKm7aHdZBmr+NQ
         GDdvShCC3SpVc9ujlLQMVoch5Jkvkm11/NSMmnrfGFFp/lA/uXJ0dDNj6qKYkd19aYIh
         0rwQE9bL+4hupdHPzIDVHSQ4AvBaG9w3gSNLGszVJvF4tn1YE6ty9atGG/ykSJmBuTtP
         5vuImyStVNhxmvuSkSoyQF8YZHN0f+hZ5SerWZmkmfQ/gSy37hfpE7BeAEVtWgoLOIxB
         HZTwt/PyisjzkRbEXpxnukursbk2HOfScUWTorS8E54tuxU5x6jZEg7rKHP1dw/7Om9i
         nIAw==
X-Received: by 10.14.202.193 with SMTP id d41mr1559149eeo.69.1380620459156;
        Tue, 01 Oct 2013 02:40:59 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b45sm11163876eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:40:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235655>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-hash.txt |  52 -----------------
 Makefile                             |   2 -
 cache.h                              |   1 -
 hash.c                               | 110 -----------------------------------
 hash.h                               |  50 ----------------
 test-hashmap.c                       |  84 --------------------------
 6 files changed, 299 deletions(-)
 delete mode 100644 Documentation/technical/api-hash.txt
 delete mode 100644 hash.c
 delete mode 100644 hash.h

diff --git a/Documentation/technical/api-hash.txt b/Documentation/technical/api-hash.txt
deleted file mode 100644
index e5061e0..0000000
--- a/Documentation/technical/api-hash.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-hash API
-========
-
-The hash API is a collection of simple hash table functions. Users are expected
-to implement their own hashing.
-
-Data Structures
----------------
-
-`struct hash_table`::
-
-	The hash table structure. The `array` member points to the hash table
-	entries. The `size` member counts the total number of valid and invalid
-	entries in the table. The `nr` member keeps track of the number of
-	valid entries.
-
-`struct hash_table_entry`::
-
-	An opaque structure representing an entry in the hash table. The `hash`
-	member is the entry's hash key and the `ptr` member is the entry's
-	value.
-
-Functions
----------
-
-`init_hash`::
-
-	Initialize the hash table.
-
-`free_hash`::
-
-	Release memory associated with the hash table.
-
-`insert_hash`::
-
-	Insert a pointer into the hash table. If an entry with that hash
-	already exists, a pointer to the existing entry's value is returned.
-	Otherwise NULL is returned.  This allows callers to implement
-	chaining, etc.
-
-`lookup_hash`::
-
-	Lookup an entry in the hash table. If an entry with that hash exists
-	the entry's value is returned. Otherwise NULL is returned.
-
-`for_each_hash`::
-
-	Call a function for each entry in the hash table. The function is
-	expected to take the entry's value as its only argument and return an
-	int. If the function returns a negative int the loop is aborted
-	immediately.  Otherwise, the return value is accumulated and the sum
-	returned upon completion of the loop.
diff --git a/Makefile b/Makefile
index e6ad011..7d565c8 100644
--- a/Makefile
+++ b/Makefile
@@ -681,7 +681,6 @@ LIB_H += git-compat-util.h
 LIB_H += gpg-interface.h
 LIB_H += graph.h
 LIB_H += grep.h
-LIB_H += hash.h
 LIB_H += hashmap.h
 LIB_H += help.h
 LIB_H += http.h
@@ -812,7 +811,6 @@ LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
-LIB_OBJS += hash.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
diff --git a/cache.h b/cache.h
index 8833944..ca5ffb6 100644
--- a/cache.h
+++ b/cache.h
@@ -3,7 +3,6 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
-#include "hash.h"
 #include "hashmap.h"
 #include "advice.h"
 #include "gettext.h"
diff --git a/hash.c b/hash.c
deleted file mode 100644
index 749ecfe..0000000
--- a/hash.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * Some generic hashing helpers.
- */
-#include "cache.h"
-#include "hash.h"
-
-/*
- * Look up a hash entry in the hash table. Return the pointer to
- * the existing entry, or the empty slot if none existed. The caller
- * can then look at the (*ptr) to see whether it existed or not.
- */
-static struct hash_table_entry *lookup_hash_entry(unsigned int hash, const struct hash_table *table)
-{
-	unsigned int size = table->size, nr = hash % size;
-	struct hash_table_entry *array = table->array;
-
-	while (array[nr].ptr) {
-		if (array[nr].hash == hash)
-			break;
-		nr++;
-		if (nr >= size)
-			nr = 0;
-	}
-	return array + nr;
-}
-
-
-/*
- * Insert a new hash entry pointer into the table.
- *
- * If that hash entry already existed, return the pointer to
- * the existing entry (and the caller can create a list of the
- * pointers or do anything else). If it didn't exist, return
- * NULL (and the caller knows the pointer has been inserted).
- */
-static void **insert_hash_entry(unsigned int hash, void *ptr, struct hash_table *table)
-{
-	struct hash_table_entry *entry = lookup_hash_entry(hash, table);
-
-	if (!entry->ptr) {
-		entry->ptr = ptr;
-		entry->hash = hash;
-		table->nr++;
-		return NULL;
-	}
-	return &entry->ptr;
-}
-
-static void grow_hash_table(struct hash_table *table)
-{
-	unsigned int i;
-	unsigned int old_size = table->size, new_size;
-	struct hash_table_entry *old_array = table->array, *new_array;
-
-	new_size = alloc_nr(old_size);
-	new_array = xcalloc(sizeof(struct hash_table_entry), new_size);
-	table->size = new_size;
-	table->array = new_array;
-	table->nr = 0;
-	for (i = 0; i < old_size; i++) {
-		unsigned int hash = old_array[i].hash;
-		void *ptr = old_array[i].ptr;
-		if (ptr)
-			insert_hash_entry(hash, ptr, table);
-	}
-	free(old_array);
-}
-
-void *lookup_hash(unsigned int hash, const struct hash_table *table)
-{
-	if (!table->array)
-		return NULL;
-	return lookup_hash_entry(hash, table)->ptr;
-}
-
-void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
-{
-	unsigned int nr = table->nr;
-	if (nr >= table->size/2)
-		grow_hash_table(table);
-	return insert_hash_entry(hash, ptr, table);
-}
-
-int for_each_hash(const struct hash_table *table, int (*fn)(void *, void *), void *data)
-{
-	int sum = 0;
-	unsigned int i;
-	unsigned int size = table->size;
-	struct hash_table_entry *array = table->array;
-
-	for (i = 0; i < size; i++) {
-		void *ptr = array->ptr;
-		array++;
-		if (ptr) {
-			int val = fn(ptr, data);
-			if (val < 0)
-				return val;
-			sum += val;
-		}
-	}
-	return sum;
-}
-
-void free_hash(struct hash_table *table)
-{
-	free(table->array);
-	table->array = NULL;
-	table->size = 0;
-	table->nr = 0;
-}
diff --git a/hash.h b/hash.h
deleted file mode 100644
index 1d43ac0..0000000
--- a/hash.h
+++ /dev/null
@@ -1,50 +0,0 @@
-#ifndef HASH_H
-#define HASH_H
-
-/*
- * These are some simple generic hash table helper functions.
- * Not necessarily suitable for all users, but good for things
- * where you want to just keep track of a list of things, and
- * have a good hash to use on them.
- *
- * It keeps the hash table at roughly 50-75% free, so the memory
- * cost of the hash table itself is roughly
- *
- *	3 * 2*sizeof(void *) * nr_of_objects
- *
- * bytes.
- *
- * FIXME: on 64-bit architectures, we waste memory. It would be
- * good to have just 32-bit pointers, requiring a special allocator
- * for hashed entries or something.
- */
-struct hash_table_entry {
-	unsigned int hash;
-	void *ptr;
-};
-
-struct hash_table {
-	unsigned int size, nr;
-	struct hash_table_entry *array;
-};
-
-extern void *lookup_hash(unsigned int hash, const struct hash_table *table);
-extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table);
-extern int for_each_hash(const struct hash_table *table, int (*fn)(void *, void *), void *data);
-extern void free_hash(struct hash_table *table);
-
-static inline void init_hash(struct hash_table *table)
-{
-	table->size = 0;
-	table->nr = 0;
-	table->array = NULL;
-}
-
-static inline void preallocate_hash(struct hash_table *table, unsigned int elts)
-{
-	assert(table->size == 0 && table->nr == 0 && table->array == NULL);
-	table->size = elts * 2;
-	table->array = xcalloc(sizeof(struct hash_table_entry), table->size);
-}
-
-#endif
diff --git a/test-hashmap.c b/test-hashmap.c
index 2d2b834..333b7b3 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -126,85 +126,6 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	}
 }
 
-struct hash_entry
-{
-	struct hash_entry *next;
-	char key[FLEX_ARRAY];
-};
-
-/*
- * Test insert performance of hash.[ch]
- * Usage: time echo "perfhash method rounds" | test-hashmap
- */
-static void perf_hash(unsigned int method, unsigned int rounds)
-{
-	struct hash_table map;
-	char buf[16];
-	struct hash_entry **entries, **res, *entry;
-	unsigned int *hashes;
-	unsigned int i, j;
-
-	entries = malloc(TEST_SIZE * sizeof(struct hash_entry*));
-	hashes = malloc(TEST_SIZE * sizeof(int));
-	for (i = 0; i < TEST_SIZE; i++) {
-		snprintf(buf, sizeof(buf), "%i", i);
-		entries[i] = malloc(sizeof(struct hash_entry) + strlen(buf) + 1);
-		strcpy(entries[i]->key, buf);
-		hashes[i] = hash(method, i, entries[i]->key);
-	}
-
-	if (method & TEST_ADD) {
-		/* test adding to the map */
-		for (j = 0; j < rounds; j++) {
-			init_hash(&map);
-
-			/* add entries */
-			for (i = 0; i < TEST_SIZE; i++) {
-				res = (struct hash_entry**) insert_hash(
-						hashes[i], entries[i], &map);
-				if (res) {
-					entries[i]->next = *res;
-					*res = entries[i];
-				} else {
-					entries[i]->next = NULL;
-				}
-			}
-
-			free_hash(&map);
-		}
-	} else {
-		/* test map lookups */
-		init_hash(&map);
-
-		/* fill the map (sparsely if specified) */
-		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
-		for (i = 0; i < j; i++) {
-			res = (struct hash_entry**) insert_hash(hashes[i],
-					entries[i], &map);
-			if (res) {
-				entries[i]->next = *res;
-				*res = entries[i];
-			} else {
-				entries[i]->next = NULL;
-			}
-		}
-
-		for (j = 0; j < rounds; j++) {
-			for (i = 0; i < TEST_SIZE; i++) {
-				entry = lookup_hash(hashes[i], &map);
-				while (entry) {
-					if (!strcmp(entries[i]->key, entry->key))
-						break;
-					entry = entry->next;
-				}
-			}
-		}
-
-		free_hash(&map);
-
-	}
-}
-
 #define DELIM " \t\r\n"
 
 /*
@@ -218,7 +139,6 @@ static void perf_hash(unsigned int method, unsigned int rounds)
  * size -> tablesize numentries
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
- * perfhash method rounds -> test hash.[ch] performance
  */
 int main(int argc, char *argv[])
 {
@@ -324,10 +244,6 @@ int main(int argc, char *argv[])
 
 			perf_hashmap(atoi(p1), atoi(p2));
 
-		} else if (!strcmp("perfhash", cmd) && l1 && l2) {
-
-			perf_hash(atoi(p1), atoi(p2));
-
 		} else {
 
 			printf("Unknown command %s\n", cmd);
-- 
1.8.4.11.g4f52745.dirty
