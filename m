From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 11/14] remove old hash.[ch] implementation
Date: Thu, 14 Nov 2013 20:23:12 +0100
Message-ID: <52852320.9010401@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2VY-0003FZ-6b
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab3KNTXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:23:12 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:33160 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab3KNTXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:23:11 -0500
Received: by mail-we0-f173.google.com with SMTP id u56so2519701wes.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Z8Pg95Bi3oJB8OPwdNd3nthj5NqvVmlkojiPLutmO8A=;
        b=LBGpSYLB77NvKgXjHLS2qi/6Icd6HoSKtvPDWk9L6884075DUDjMRxNCyQI4hMzMLH
         G5C0YH77jxh4DC5AgVDSoGEE74q7E3ehoK4H3MDdf8RpNIbJwTP+ikOKyCfvNv9F6NCf
         8/frbBe6zPyoe84Sv6KfR38fnH/VhnOTAEx7oDgCfLmeov8ruTpubuvurYopyrjz9aDT
         pglFnG/H6Xv8859rOdfBV8/f/JSswQ0WWuqGYef+0FEFosLV5AfzVDgP0Zp1oedfimee
         Jy+CV+tIh4FghPo7KpGDoo5rXMnhltfOH5NPL7qhXPWV51ujaQy//cE8x95Dta2m1orC
         NPLQ==
X-Received: by 10.194.175.133 with SMTP id ca5mr3479556wjc.19.1384456989934;
        Thu, 14 Nov 2013 11:23:09 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id mq4sm1636041wic.1.2013.11.14.11.23.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:23:09 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237872>

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 75bb1a6..d566768 100644
--- a/Makefile
+++ b/Makefile
@@ -673,7 +673,6 @@ LIB_H += git-compat-util.h
 LIB_H += gpg-interface.h
 LIB_H += graph.h
 LIB_H += grep.h
-LIB_H += hash.h
 LIB_H += hashmap.h
 LIB_H += help.h
 LIB_H += http.h
@@ -805,7 +804,6 @@ LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
-LIB_OBJS += hash.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
diff --git a/cache.h b/cache.h
index 05b8011..27067b8 100644
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
index 581d296..7e86f88 100644
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
- * Test performance of hash.[ch]
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
-	entries = malloc(TEST_SIZE * sizeof(struct hash_entry *));
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
-				res = (struct hash_entry **) insert_hash(
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
-			res = (struct hash_entry **) insert_hash(hashes[i],
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
1.8.5.rc0.333.g5394214
