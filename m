From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 1/3] change hash table calling conventions
Date: Tue, 30 Oct 2007 00:23:28 -0400
Message-ID: <20071030042328.GA14954@sigill.intra.peff.net>
References: <20071030042118.GA14729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy C <andychup@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imidk-0006zu-1M
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbXJ3EXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXJ3EXb
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:23:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1278 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbXJ3EXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:23:30 -0400
Received: (qmail 29709 invoked by uid 111); 30 Oct 2007 04:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Oct 2007 00:23:28 -0400
Received: (qmail 14974 invoked by uid 1000); 30 Oct 2007 04:23:28 -0000
Content-Disposition: inline
In-Reply-To: <20071030042118.GA14729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62656>

The recent hash table code has two limitations in its
calling conventions that are addressed here:

  1. Insertion either inserts a value, returning NULL, or
     returns a pointer to the previously inserted value.
     This is fine if you are making a linked list of the
     colliding values, but is awkward if your goal is to:
       a. modify the value if it already exists
       b. otherwise, allocate and insert the value
     With the old convention, you must either allocate the
     structure (and throw it away in case a), or perform two
     lookups (one to see if the entry exists, then another
     to perform the insertion).

     Instead, insertion no longer inserts any value; it
     simply returns a pointer to where you _can_ insert a
     value (which will be non-NULL if a value already
     existed).

  2. for_each_hash now allows a void 'data' pointer to be
     passed to the callback function along with each hash
     entry.

Signed-off-by: Jeff King <peff@peff.net>
---

The insertion feels kind of hack-ish. Suggestions are welcome.

 diffcore-rename.c |   14 +++++---------
 hash.c            |   18 +++++++++---------
 hash.h            |    5 +++--
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f9ebea5..ba038af 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -288,7 +288,7 @@ static void free_similarity_list(struct file_similarity *p)
 	}
 }
 
-static int find_same_files(void *ptr)
+static int find_same_files(void *ptr, void *data)
 {
 	int ret;
 	struct file_similarity *p = ptr;
@@ -343,13 +343,9 @@ static void insert_file_table(struct hash_table *table, int src_dst, int index,
 	entry->next = NULL;
 
 	hash = hash_filespec(filespec);
-	pos = insert_hash(hash, entry, table);
-
-	/* We already had an entry there? */
-	if (pos) {
-		entry->next = *pos;
-		*pos = entry;
-	}
+	pos = insert_hash(hash, table);
+	entry->next = *pos;
+	*pos = entry;
 }
 
 /*
@@ -372,7 +368,7 @@ static int find_exact_renames(void)
 		insert_file_table(&file_table, 1, i, rename_dst[i].two);
 
 	/* Find the renames */
-	i = for_each_hash(&file_table, find_same_files);
+	i = for_each_hash(&file_table, find_same_files, NULL);
 
 	/* .. and free the hash data structure */
 	free_hash(&file_table);
diff --git a/hash.c b/hash.c
index 7b492d4..dc5d20e 100644
--- a/hash.c
+++ b/hash.c
@@ -33,15 +33,13 @@ static struct hash_table_entry *lookup_hash_entry(unsigned int hash, struct hash
  * pointers or do anything else). If it didn't exist, return
  * NULL (and the caller knows the pointer has been inserted).
  */
-static void **insert_hash_entry(unsigned int hash, void *ptr, struct hash_table *table)
+static void **insert_hash_entry(unsigned int hash, struct hash_table *table)
 {
 	struct hash_table_entry *entry = lookup_hash_entry(hash, table);
 
 	if (!entry->ptr) {
-		entry->ptr = ptr;
 		entry->hash = hash;
 		table->nr++;
-		return NULL;
 	}
 	return &entry->ptr;
 }
@@ -60,8 +58,10 @@ static void grow_hash_table(struct hash_table *table)
 	for (i = 0; i < old_size; i++) {
 		unsigned int hash = old_array[i].hash;
 		void *ptr = old_array[i].ptr;
-		if (ptr)
-			insert_hash_entry(hash, ptr, table);
+		if (ptr) {
+			void **pos = insert_hash_entry(hash, table);
+			*pos = ptr;
+		}
 	}
 	free(old_array);
 }
@@ -73,15 +73,15 @@ void *lookup_hash(unsigned int hash, struct hash_table *table)
 	return &lookup_hash_entry(hash, table)->ptr;
 }
 
-void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
+void **insert_hash(unsigned int hash, struct hash_table *table)
 {
 	unsigned int nr = table->nr;
 	if (nr >= table->size/2)
 		grow_hash_table(table);
-	return insert_hash_entry(hash, ptr, table);
+	return insert_hash_entry(hash, table);
 }
 
-int for_each_hash(struct hash_table *table, int (*fn)(void *))
+int for_each_hash(struct hash_table *table, int (*fn)(void *, void *), void *d)
 {
 	int sum = 0;
 	unsigned int i;
@@ -92,7 +92,7 @@ int for_each_hash(struct hash_table *table, int (*fn)(void *))
 		void *ptr = array->ptr;
 		array++;
 		if (ptr) {
-			int val = fn(ptr);
+			int val = fn(ptr, d);
 			if (val < 0)
 				return val;
 			sum += val;
diff --git a/hash.h b/hash.h
index a8b0fbb..f9a50da 100644
--- a/hash.h
+++ b/hash.h
@@ -29,8 +29,9 @@ struct hash_table {
 };
 
 extern void *lookup_hash(unsigned int hash, struct hash_table *table);
-extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table);
-extern int for_each_hash(struct hash_table *table, int (*fn)(void *));
+extern void **insert_hash(unsigned int hash, struct hash_table *table);
+extern int for_each_hash(struct hash_table *table, int (*fn)(void *, void*),
+		void *data);
 extern void free_hash(struct hash_table *table);
 
 static inline void init_hash(struct hash_table *table)
-- 
1.5.3.4
