From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH, take 1] Linear-time/space rename logic (exact renames
 only)
Date: Sun, 21 Oct 2007 16:59:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 01:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijkhw-0003mv-AY
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 01:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXJUX7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 19:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXJUX7d
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 19:59:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57162 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751164AbXJUX7b (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2007 19:59:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9LNx4AW024663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Oct 2007 16:59:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9LNx36t001235;
	Sun, 21 Oct 2007 16:59:03 -0700
X-Spam-Status: No, hits=-6.218 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61922>


This is a first effort at avoiding various O(n*m) effects in the rename 
detection. Right now it does so only for the exact renames, which is 
admittedly a rather easier case to handle, but having emailed a bit with 
Andy Chu, I think it's possible to do even the non-exact renames using a 
similar approach.

This depends on the previous diffcore-rename() cleanup, and introduces a 
new set of helpers for doing hash tables (hash.[ch]). We could probably 
move some of the other of our hash table users over to this (it's designed 
to be fairly generic), but that's a separate issue.

What it does is to rather than iterate over all sources and destinations 
and checking if they are identical (which is O(src*dst)), it hashes each 
of the sources and destinations into a hash table, using the SHA1 hash of 
the contents as the hash. That's O(n+m). It then walks the hash table 
(which is also O(m+n) in size), and only pairs up files for comparison 
that hashed to the same spot.

Doing this for more than just the exact same contents would be basically 
the same thing, except it starts hashing up fingerprints of the contents 
and linking up file pairs that get linked up by those fingerprints. More 
involved, but not impossible.

I tried a trivial case where I moved 100,000 files from one directory to 
another, and this patch speeds that up from ~13s to just under 2s for me.

However! Please note:
 - it looks ok, and I've tested it some, but this needs more people 
   looking at it.
 - because it only helps the exact rename case, it by no means "solves" 
   the rename cost issue. It just makes one particular case go much 
   faster.
 - in fact, the big optimization isn't the actual hash table, but the 
   independent and much simpler "diff_filespec->used" optimization for a 
   deleted filename that was used for a rename/copy.

But I'd like to have people give it a look,

		Linus

---

 Makefile          |    4 +-
 diffcore-rename.c |  214 ++++++++++++++++++++++++++++++++++------------------
 diffcore.h        |    1 +
 hash.c            |  110 +++++++++++++++++++++++++++
 hash.h            |   43 +++++++++++
 5 files changed, 296 insertions(+), 76 deletions(-)

diff --git a/Makefile b/Makefile
index 8db4dbe..17c31ba 100644
--- a/Makefile
+++ b/Makefile
@@ -291,7 +291,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h hash.o
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -301,7 +301,7 @@ DIFF_OBJS = \
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
-	interpolate.o \
+	interpolate.o hash.o \
 	lockfile.o \
 	patch-ids.o \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2077a9b..05d39db 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hash.h"
 
 /* Table of rename/copy destinations */
 
@@ -96,29 +97,6 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
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
@@ -216,6 +194,7 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 		die("internal error: dst already matched.");
 
 	src = rename_src[src_index].one;
+	src->used = 1;
 	one = alloc_filespec(src->path);
 	fill_filespec(one, src->sha1, src->mode);
 
@@ -262,56 +241,152 @@ static int compute_stays(struct diff_queue_struct *q,
 	return 1;
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
+	do {
+		struct diff_filespec *one = src->filespec;
+		struct file_similarity *p, *best;
+		int i = 100;
+
+		best = NULL;
+		for (p = dst; p; p = p->next) {
+			struct diff_filespec *two = p->filespec;
+
+			/* Already picked as a destination? */
+			if (!p->src_dst)
+				continue;
+			/* False hash collission? */
+			if (hashcmp(one->sha1, two->sha1))
+				continue;
+			best = p;
+			if (basename_same(one, two))
+				break;
+
+			/* Too many identical alternatives? Pick one */
+			if (!--i)
+				break;
+		}
+		if (best) {
+			best->src_dst = 0;
+			record_rename_pair(best->index, src->index, MAX_SCORE);
+			renames++;
+		}
+	} while ((src = src->next) != NULL);
+	return renames;
+}
+
+static int find_same_files(void *ptr)
+{
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
+	return (src && dst) ? find_identical_files(src, dst) : 0;
+}
+
+/*
+ * Note: the rest of the rename logic depends on this
+ * phase also populating all the filespecs for any
+ * entry that isn't matched up with an exact rename.
+ */
+static int free_file_table(void *ptr)
+{
+	struct file_similarity *p = ptr;
+	do {
+		struct file_similarity *entry = p;
+		p = p->next;
+
+		/* Stupid special case, see note above! */
+		diff_populate_filespec(entry->filespec, 0);
+		free(entry);
+	} while (p);
+	return 0;
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
-
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
+	int i;
+	struct hash_table file_table;
+
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
+	/* .. and free the hash data structures */
+	for_each_hash(&file_table, free_file_table);
+	free_hash(&file_table);
+
+	return i;
 }
 
 void diffcore_rename(struct diff_options *options)
@@ -474,16 +549,7 @@ void diffcore_rename(struct diff_options *options)
 					pair_to_free = p;
 			}
 			else {
-				for (j = 0; j < rename_dst_nr; j++) {
-					if (!rename_dst[j].pair)
-						continue;
-					if (strcmp(rename_dst[j].pair->
-						   one->path,
-						   p->one->path))
-						continue;
-					break;
-				}
-				if (j < rename_dst_nr)
+				if (p->one->used)
 					/* this path remains */
 					pair_to_free = p;
 			}
diff --git a/diffcore.h b/diffcore.h
index eb618b1..a58d345 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -40,6 +40,7 @@ struct diff_filespec {
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
 	unsigned checked_attr : 1;
 	unsigned is_binary : 1; /* data should be considered "binary" */
+	unsigned used : 1;	/* this pathspec was used for copy/delete */
 };
 
 extern struct diff_filespec *alloc_filespec(const char *);
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
index 0000000..5056c9a
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
