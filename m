From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH, take 2] Linear-time/space rename logic (exact renames
 only)
Date: Mon, 22 Oct 2007 10:29:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
 <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
 <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Sven Verdoolaege <skimo@liacs.nl>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 19:30:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik16I-0006FF-L0
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbXJVR3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbXJVR3r
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 13:29:47 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60092 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752140AbXJVR3p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 13:29:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MHTHT3020760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 10:29:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MHTGKQ005140;
	Mon, 22 Oct 2007 10:29:16 -0700
In-Reply-To: <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org>
X-Spam-Status: No, hits=-6.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62029>


Ok, as some people notices, there were a few bugs in the previous patch. I 
didn't free the hashes correctly (stupid) and the Makefile had "hash.o" 
instead of "hash.h".

But more importantly, my "testing" had been totally broken, because I had 
forgotten to actually move the rename limiting code to after the exact 
rename phase, so when I tested the 100,000 file rename, almost none of the 
new code triggered, so my performance testing was totally bogus.

When fixing that, I noticed that while my new exact rename detection was 
essentially instantaneous, there were some O(n*m) effects in the generic 
diff code from the extremely stupid way we handled the "was it a copy or a 
rename" issue.

To fix that, I just made the "was the path used by a rename" be a counter 
instead of a single "it was used"

With that in place, I could actually time the rename detection of 100,000 
files in my big-rename test repository. This is what it looks like when 
you rename a hundred thousand files:

	[torvalds@woody big-rename]$ time ~/git/git show -C | wc -l
	400006

	real    0m2.675s
	user    0m2.148s
	sys     0m0.540s

(each renamed file is 4 lines: they looks like

	diff --git a/really-big-dir/file-1-1-1-1-1 b/moved-big-dir/file-1-1-1-1-1
	similarity index 100%
	rename from really-big-dir/file-1-1-1-1-1
	rename to moved-big-dir/file-1-1-1-1-1

and the extra six lines is from a one-liner commit message and all the 
commit information and spacing).

So two seconds to do that exact rename detection.

Now, I can't really compare it to the "before" stage, because that is just 
so horrible. The rename detection limit triggers, so you never even get 
any renames, but if I were to move the limit check later (like I do in 
this patch) without my other fixes, it would take hours. Trying to do ten 
billion (100k x 100k) SHA1 and pathname compares simply isn't going to 
work.

But I *can* compare it to the old code *with* the rename limiting, which 
still wastes all the time on the whole "copy usage" crap. So here are the 
numbers on that repo without the patch:

	[torvalds@woody big-rename]$ time git show -C | wc -l
	1400006
	
	real    0m12.383s
	user    0m12.365s
	sys     0m0.160s

That's right: we used to take 12 seconds and not even do renames (now you 
see fourteen lines per file moved: seven lines each for the delete and the 
create of a one-liner file, and the same extra six lines of commit 
information).

So it not only makes the rename detection possible in the first place, it 
removes some stupid code that made it take a long time even when it 
failed!

Now, I'd still be careful with this patch, and I'd really like people to 
double-check all my logic, but I think it's worthy of some 'pu' love.

		Linus
---

 Makefile          |    4 +-
 diff.c            |   24 +----
 diffcore-rename.c |  275 ++++++++++++++++++++++++++++++----------------------
 diffcore.h        |    2 +-
 hash.c            |  110 +++++++++++++++++++++
 hash.h            |   43 ++++++++
 6 files changed, 321 insertions(+), 137 deletions(-)

diff --git a/Makefile b/Makefile
index 8db4dbe..b1ca186 100644
--- a/Makefile
+++ b/Makefile
@@ -291,7 +291,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h hash.h
 
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
diff --git a/diff.c b/diff.c
index 6648e01..e892030 100644
--- a/diff.c
+++ b/diff.c
@@ -2586,9 +2586,9 @@ void diff_debug_filepair(const struct diff_filepair *p, int i)
 {
 	diff_debug_filespec(p->one, i, "one");
 	diff_debug_filespec(p->two, i, "two");
-	fprintf(stderr, "score %d, status %c stays %d broken %d\n",
+	fprintf(stderr, "score %d, status %c rename_used %d broken %d\n",
 		p->score, p->status ? p->status : '?',
-		p->source_stays, p->broken_pair);
+		p->rename_used, p->broken_pair);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -2606,8 +2606,8 @@ void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
 
 static void diff_resolve_rename_copy(void)
 {
-	int i, j;
-	struct diff_filepair *p, *pp;
+	int i;
+	struct diff_filepair *p;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
 	diff_debug_queue("resolve-rename-copy", q);
@@ -2629,27 +2629,15 @@ static void diff_resolve_rename_copy(void)
 		 * either in-place edit or rename/copy edit.
 		 */
 		else if (DIFF_PAIR_RENAME(p)) {
-			if (p->source_stays) {
-				p->status = DIFF_STATUS_COPIED;
-				continue;
-			}
 			/* See if there is some other filepair that
 			 * copies from the same source as us.  If so
 			 * we are a copy.  Otherwise we are either a
 			 * copy if the path stays, or a rename if it
 			 * does not, but we already handled "stays" case.
 			 */
-			for (j = i + 1; j < q->nr; j++) {
-				pp = q->queue[j];
-				if (strcmp(pp->one->path, p->one->path))
-					continue; /* not us */
-				if (!DIFF_PAIR_RENAME(pp))
-					continue; /* not a rename/copy */
-				/* pp is a rename/copy from the same source */
+			if (--p->one->rename_used > 0)
 				p->status = DIFF_STATUS_COPIED;
-				break;
-			}
-			if (!p->status)
+			else
 				p->status = DIFF_STATUS_RENAMED;
 		}
 		else if (hashcmp(p->one->sha1, p->two->sha1) ||
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2077a9b..cc105db 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hash.h"
 
 /* Table of rename/copy destinations */
 
@@ -55,12 +56,10 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 static struct diff_rename_src {
 	struct diff_filespec *one;
 	unsigned short score; /* to remember the break score */
-	unsigned src_path_left : 1;
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
 static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
-						   int src_path_left,
 						   unsigned short score)
 {
 	int first, last;
@@ -92,33 +91,9 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
 	rename_src[first].one = one;
 	rename_src[first].score = score;
-	rename_src[first].src_path_left = src_path_left;
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
@@ -216,6 +191,7 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 		die("internal error: dst already matched.");
 
 	src = rename_src[src_index].one;
+	src->rename_used++;
 	one = alloc_filespec(src->path);
 	fill_filespec(one, src->sha1, src->mode);
 
@@ -229,7 +205,6 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 		dp->score = rename_src[src_index].score;
 	else
 		dp->score = score;
-	dp->source_stays = rename_src[src_index].src_path_left;
 	rename_dst[dst_index].pair = dp;
 }
 
@@ -247,19 +222,127 @@ static int score_compare(const void *a_, const void *b_)
 	return b->score - a->score;
 }
 
-static int compute_stays(struct diff_queue_struct *q,
-			 struct diff_filespec *one)
+struct file_similarity {
+	int src_dst, index;
+	struct diff_filespec *filespec;
+	struct file_similarity *next;
+};
+
+static int find_identical_files(struct file_similarity *src,
+				struct file_similarity *dst)
 {
-	int i;
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		if (strcmp(one->path, p->two->path))
-			continue;
-		if (DIFF_PAIR_RENAME(p)) {
-			return 0; /* something else is renamed into this */
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
 		}
+		if (best) {
+			best->src_dst = 0;
+			record_rename_pair(best->index, src->index, MAX_SCORE);
+			renames++;
+		}
+	} while ((src = src->next) != NULL);
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
 	}
-	return 1;
 }
 
 /*
@@ -268,50 +351,26 @@ static int compute_stays(struct diff_queue_struct *q,
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
+	/* .. and free the hash data structure */
+	free_hash(&file_table);
+
+	return i;
 }
 
 void diffcore_rename(struct diff_options *options)
@@ -340,20 +399,36 @@ void diffcore_rename(struct diff_options *options)
 				locate_rename_dst(p->two, 1);
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
-			/* If the source is a broken "delete", and
+			/*
+			 * If the source is a broken "delete", and
 			 * they did not really want to get broken,
 			 * that means the source actually stays.
+			 * So we increment the "rename_used" score
+			 * by one, to indicate ourselves as a user
 			 */
-			int stays = (p->broken_pair && !p->score);
-			register_rename_src(p->one, stays, p->score);
+			if (p->broken_pair && !p->score)
+				p->one->rename_used++;
+			register_rename_src(p->one, p->score);
+		}
+		else if (detect_rename == DIFF_DETECT_COPY) {
+			/*
+			 * Increment the "rename_used" score by
+			 * one, to indicate ourselves as a user.
+			 */
+			p->one->rename_used++;
+			register_rename_src(p->one, p->score);
 		}
-		else if (detect_rename == DIFF_DETECT_COPY)
-			register_rename_src(p->one, 1, p->score);
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
 		goto cleanup; /* nothing to do */
 
 	/*
+	 * We really want to cull the candidates list early
+	 * with cheap tests in order to avoid doing deltas.
+	 */
+	rename_count = find_exact_renames();
+
+	/*
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
@@ -369,12 +444,6 @@ void diffcore_rename(struct diff_options *options)
 	if (rename_dst_nr * rename_src_nr > rename_limit * rename_limit)
 		goto cleanup;
 
-	/*
-	 * We really want to cull the candidates list early
-	 * with cheap tests in order to avoid doing deltas.
-	 */
-	rename_count = find_exact_renames();
-
 	/* Have we run out the created file pool?  If so we can avoid
 	 * doing the delta matrix altogether.
 	 */
@@ -474,16 +543,7 @@ void diffcore_rename(struct diff_options *options)
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
+				if (p->one->rename_used)
 					/* this path remains */
 					pair_to_free = p;
 			}
@@ -509,23 +569,6 @@ void diffcore_rename(struct diff_options *options)
 	*q = outq;
 	diff_debug_queue("done collapsing", q);
 
-	/* We need to see which rename source really stays here;
-	 * earlier we only checked if the path is left in the result,
-	 * but even if a path remains in the result, if that is coming
-	 * from copying something else on top of it, then the original
-	 * source is lost and does not stay.
-	 */
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		if (DIFF_PAIR_RENAME(p) && p->source_stays) {
-			/* If one appears as the target of a rename-copy,
-			 * then mark p->source_stays = 0; otherwise
-			 * leave it as is.
-			 */
-			p->source_stays = compute_stays(q, p->one);
-		}
-	}
-
 	for (i = 0; i < rename_dst_nr; i++) {
 		diff_free_filespec_data(rename_dst[i].two);
 		free(rename_dst[i].two);
diff --git a/diffcore.h b/diffcore.h
index eb618b1..ceda932 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -30,6 +30,7 @@ struct diff_filespec {
 	const char *funcname_pattern_ident;
 	unsigned long size;
 	int xfrm_flags;		 /* for use by the xfrm */
+	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
 	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
 				  * if false, use the name and read from
@@ -56,7 +57,6 @@ struct diff_filepair {
 	struct diff_filespec *two;
 	unsigned short int score;
 	char status; /* M C R N D U (see Documentation/diff-format.txt) */
-	unsigned source_stays : 1; /* all of R/C are copies */
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
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
