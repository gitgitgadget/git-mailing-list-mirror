From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/6] Do linear-time/space rename logic for exact renames
Date: Thu, 25 Oct 2007 11:23:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:29:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7SU-0005oC-9J
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbXJYS3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbXJYS3O
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:29:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43498 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052AbXJYS3N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:29:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PINRCF019199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:23:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PINQ1b008029;
	Thu, 25 Oct 2007 11:23:26 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-6.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62353>


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/6] Do linear-time/space rename logic for exact renames

This implements a smarter rename detector for exact renames, which
rather than doing a pairwise comparison (time O(m*n)) will just hash the
files into a hash-table (size O(n+m)), and only do pairwise comparisons
to renames that have the same hash (time O(n+m) except for unrealistic
hash collissions, which we just cull aggressively).

Admittedly the exact rename case is not nearly as interesting as the
generic case, but it's an important case none-the-less.A similar general
approach should work for the generic case too, but even then you do need
to handle the exact renames/copies separately (to avoid the inevitable
added cost factor that comes from the _size_ of the file), so this is
worth doing.

In the expectation that we will indeed do the same hashing trick for the
general rename case, this code uses a generic hash-table implementation
that can be used for other things too.  In fact, we might be able to
consolidate some of our existing hash tables with the new generic code
in hash.[ch].

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is obviously the actual meat of the new exact rename detection: 
everything else was just leading up to this.

I could have split out "hash.[ch]" as a separate patch just to introduce 
the infrastructure, but I hate patches that add code that isn't used at 
all. But hash.[ch] really is potentially independently useful, and has 
nothing that is specific to the rename detection per se in it.

 Makefile          |    4 +-
 diffcore-rename.c |  211 +++++++++++++++++++++++++++++++++++++----------------
 hash.c            |  110 +++++++++++++++++++++++++++
 hash.h            |   43 +++++++++++
 4 files changed, 303 insertions(+), 65 deletions(-)
 create mode 100644 hash.c
 create mode 100644 hash.h

diff --git a/Makefile b/Makefile
index 8a0082d..845f811 100644
--- a/Makefile
+++ b/Makefile
@@ -290,7 +290,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h transport.h diffcore.h
+	mailmap.h remote.h transport.h diffcore.h hash.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -300,7 +300,7 @@ DIFF_OBJS = \
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
-	interpolate.o \
+	interpolate.o hash.o \
 	lockfile.o \
 	patch-ids.o \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index edb2424..e7e370b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hash.h"
 
 /* Table of rename/copy destinations */
 
@@ -93,29 +94,6 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 	return &(rename_src[first]);
 }
 
-static int is_exact_match(struct diff_filespec *src,
-			  struct diff_filespec *dst,
-			  int contents_too)
-{
-	if (src->sha1_valid && dst->sha1_valid &&
-	    !hashcmp(src->sha1, dst->sha1))
-		return 1;
-	if (!contents_too)
-		return 0;
-	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
-		return 0;
-	if (src->size != dst->size)
-		return 0;
-	if (src->sha1_valid && dst->sha1_valid)
-	    return !hashcmp(src->sha1, dst->sha1);
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
-		return 0;
-	if (src->size == dst->size &&
-	    !memcmp(src->data, dst->data, src->size))
-		return 1;
-	return 0;
-}
-
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
 {
 	int src_len = strlen(src->path), dst_len = strlen(dst->path);
@@ -242,56 +220,163 @@ static int score_compare(const void *a_, const void *b_)
 	return b->score - a->score;
 }
 
+struct file_similarity {
+	int src_dst, index;
+	struct diff_filespec *filespec;
+	struct file_similarity *next;
+};
+
+static int find_identical_files(struct file_similarity *src,
+				struct file_similarity *dst)
+{
+	int renames = 0;
+
+	/*
+	 * Walk over all the destinations ...
+	 */
+	do {
+		struct diff_filespec *one = dst->filespec;
+		struct file_similarity *p, *best;
+		int i = 100;
+
+		/*
+		 * .. to find the best source match
+		 */
+		best = NULL;
+		for (p = src; p; p = p->next) {
+			struct diff_filespec *two = p->filespec;
+
+			/* False hash collission? */
+			if (hashcmp(one->sha1, two->sha1))
+				continue;
+			/* Non-regular files? If so, the modes must match! */
+			if (!S_ISREG(one->mode) || !S_ISREG(two->mode)) {
+				if (one->mode != two->mode)
+					continue;
+			}
+			best = p;
+			if (basename_same(one, two))
+				break;
+
+			/* Too many identical alternatives? Pick one */
+			if (!--i)
+				break;
+		}
+		if (best) {
+			record_rename_pair(dst->index, best->index, MAX_SCORE);
+			renames++;
+		}
+	} while ((dst = dst->next) != NULL);
+	return renames;
+}
+
+/*
+ * Note: the rest of the rename logic depends on this
+ * phase also populating all the filespecs for any
+ * entry that isn't matched up with an exact rename.
+ */
+static void free_similarity_list(struct file_similarity *p)
+{
+	while (p) {
+		struct file_similarity *entry = p;
+		p = p->next;
+
+		/* Stupid special case, see note above! */
+		diff_populate_filespec(entry->filespec, 0);
+		free(entry);
+	}
+}
+
+static int find_same_files(void *ptr)
+{
+	int ret;
+	struct file_similarity *p = ptr;
+	struct file_similarity *src = NULL, *dst = NULL;
+
+	/* Split the hash list up into sources and destinations */
+	do {
+		struct file_similarity *entry = p;
+		p = p->next;
+		if (entry->src_dst < 0) {
+			entry->next = src;
+			src = entry;
+		} else {
+			entry->next = dst;
+			dst = entry;
+		}
+	} while (p);
+
+	/*
+	 * If we have both sources *and* destinations, see if
+	 * we can match them up
+	 */
+	ret = (src && dst) ? find_identical_files(src, dst) : 0;
+
+	/* Free the hashes and return the number of renames found */
+	free_similarity_list(src);
+	free_similarity_list(dst);
+	return ret;
+}
+
+static unsigned int hash_filespec(struct diff_filespec *filespec)
+{
+	unsigned int hash;
+	if (!filespec->sha1_valid) {
+		if (diff_populate_filespec(filespec, 0))
+			return 0;
+		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
+	}
+	memcpy(&hash, filespec->sha1, sizeof(hash));
+	return hash;
+}
+
+static void insert_file_table(struct hash_table *table, int src_dst, int index, struct diff_filespec *filespec)
+{
+	void **pos;
+	unsigned int hash;
+	struct file_similarity *entry = xmalloc(sizeof(*entry));
+
+	entry->src_dst = src_dst;
+	entry->index = index;
+	entry->filespec = filespec;
+	entry->next = NULL;
+
+	hash = hash_filespec(filespec);
+	pos = insert_hash(hash, entry, table);
+
+	/* We already had an entry there? */
+	if (pos) {
+		entry->next = *pos;
+		*pos = entry;
+	}
+}
+
 /*
  * Find exact renames first.
  *
  * The first round matches up the up-to-date entries,
  * and then during the second round we try to match
  * cache-dirty entries as well.
- *
- * Note: the rest of the rename logic depends on this
- * phase also populating all the filespecs for any
- * entry that isn't matched up with an exact rename,
- * see "is_exact_match()".
  */
 static int find_exact_renames(void)
 {
-	int rename_count = 0;
-	int contents_too;
-
-	for (contents_too = 0; contents_too < 2; contents_too++) {
-		int i;
-
-		for (i = 0; i < rename_dst_nr; i++) {
-			struct diff_filespec *two = rename_dst[i].two;
-			int j;
-
-			if (rename_dst[i].pair)
-				continue; /* dealt with an earlier round */
-			for (j = 0; j < rename_src_nr; j++) {
-				int k;
-				struct diff_filespec *one = rename_src[j].one;
-				if (!is_exact_match(one, two, contents_too))
-					continue;
+	int i;
+	struct hash_table file_table;
 
-				/* see if there is a basename match, too */
-				for (k = j; k < rename_src_nr; k++) {
-					one = rename_src[k].one;
-					if (basename_same(one, two) &&
-						is_exact_match(one, two,
-							contents_too)) {
-						j = k;
-						break;
-					}
-				}
-
-				record_rename_pair(i, j, (int)MAX_SCORE);
-				rename_count++;
-				break; /* we are done with this entry */
-			}
-		}
-	}
-	return rename_count;
+	init_hash(&file_table);
+	for (i = 0; i < rename_src_nr; i++)
+		insert_file_table(&file_table, -1, i, rename_src[i].one);
+
+	for (i = 0; i < rename_dst_nr; i++)
+		insert_file_table(&file_table, 1, i, rename_dst[i].two);
+
+	/* Find the renames */
+	i = for_each_hash(&file_table, find_same_files);
+
+	/* .. and free the hash data structure */
+	free_hash(&file_table);
+
+	return i;
 }
 
 void diffcore_rename(struct diff_options *options)
diff --git a/hash.c b/hash.c
new file mode 100644
index 0000000..7b492d4
--- /dev/null
+++ b/hash.c
@@ -0,0 +1,110 @@
+/*
+ * Some generic hashing helpers.
+ */
+#include "cache.h"
+#include "hash.h"
+
+/*
+ * Look up a hash entry in the hash table. Return the pointer to
+ * the existing entry, or the empty slot if none existed. The caller
+ * can then look at the (*ptr) to see whether it existed or not.
+ */
+static struct hash_table_entry *lookup_hash_entry(unsigned int hash, struct hash_table *table)
+{
+	unsigned int size = table->size, nr = hash % size;
+	struct hash_table_entry *array = table->array;
+
+	while (array[nr].ptr) {
+		if (array[nr].hash == hash)
+			break;
+		nr++;
+		if (nr >= size)
+			nr = 0;
+	}
+	return array + nr;
+}
+
+
+/*
+ * Insert a new hash entry pointer into the table.
+ *
+ * If that hash entry already existed, return the pointer to
+ * the existing entry (and the caller can create a list of the
+ * pointers or do anything else). If it didn't exist, return
+ * NULL (and the caller knows the pointer has been inserted).
+ */
+static void **insert_hash_entry(unsigned int hash, void *ptr, struct hash_table *table)
+{
+	struct hash_table_entry *entry = lookup_hash_entry(hash, table);
+
+	if (!entry->ptr) {
+		entry->ptr = ptr;
+		entry->hash = hash;
+		table->nr++;
+		return NULL;
+	}
+	return &entry->ptr;
+}
+
+static void grow_hash_table(struct hash_table *table)
+{
+	unsigned int i;
+	unsigned int old_size = table->size, new_size;
+	struct hash_table_entry *old_array = table->array, *new_array;
+
+	new_size = alloc_nr(old_size);
+	new_array = xcalloc(sizeof(struct hash_table_entry), new_size);
+	table->size = new_size;
+	table->array = new_array;
+	table->nr = 0;
+	for (i = 0; i < old_size; i++) {
+		unsigned int hash = old_array[i].hash;
+		void *ptr = old_array[i].ptr;
+		if (ptr)
+			insert_hash_entry(hash, ptr, table);
+	}
+	free(old_array);
+}
+
+void *lookup_hash(unsigned int hash, struct hash_table *table)
+{
+	if (!table->array)
+		return NULL;
+	return &lookup_hash_entry(hash, table)->ptr;
+}
+
+void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
+{
+	unsigned int nr = table->nr;
+	if (nr >= table->size/2)
+		grow_hash_table(table);
+	return insert_hash_entry(hash, ptr, table);
+}
+
+int for_each_hash(struct hash_table *table, int (*fn)(void *))
+{
+	int sum = 0;
+	unsigned int i;
+	unsigned int size = table->size;
+	struct hash_table_entry *array = table->array;
+
+	for (i = 0; i < size; i++) {
+		void *ptr = array->ptr;
+		array++;
+		if (ptr) {
+			int val = fn(ptr);
+			if (val < 0)
+				return val;
+			sum += val;
+		}
+	}
+	return sum;
+}
+
+void free_hash(struct hash_table *table)
+{
+	free(table->array);
+	table->array = NULL;
+	table->size = 0;
+	table->nr = 0;
+}
diff --git a/hash.h b/hash.h
new file mode 100644
index 0000000..a8b0fbb
--- /dev/null
+++ b/hash.h
@@ -0,0 +1,43 @@
+#ifndef HASH_H
+#define HASH_H
+
+/*
+ * These are some simple generic hash table helper functions.
+ * Not necessarily suitable for all users, but good for things
+ * where you want to just keep track of a list of things, and
+ * have a good hash to use on them.
+ *
+ * It keeps the hash table at roughly 50-75% free, so the memory
+ * cost of the hash table itself is roughly
+ *
+ *	3 * 2*sizeof(void *) * nr_of_objects
+ *
+ * bytes.
+ *
+ * FIXME: on 64-bit architectures, we waste memory. It would be
+ * good to have just 32-bit pointers, requiring a special allocator
+ * for hashed entries or something.
+ */
+struct hash_table_entry {
+	unsigned int hash;
+	void *ptr;
+};
+
+struct hash_table {
+	unsigned int size, nr;
+	struct hash_table_entry *array;
+};
+
+extern void *lookup_hash(unsigned int hash, struct hash_table *table);
+extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table);
+extern int for_each_hash(struct hash_table *table, int (*fn)(void *));
+extern void free_hash(struct hash_table *table);
+
+static inline void init_hash(struct hash_table *table)
+{
+	table->size = 0;
+	table->nr = 0;
+	table->array = NULL;
+}
+
+#endif
-- 
1.5.3.4.330.g1dec6
