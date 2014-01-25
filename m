From: David Kastrup <dak@gnu.org>
Subject: [PATCH 3/3] builtin/blame.c: large-scale rewrite
Date: Sat, 25 Jan 2014 19:23:41 +0100
Message-ID: <1390674221-25767-4-git-send-email-dak@gnu.org>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
 <1390674221-25767-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 19:24:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W77u2-0004KE-64
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 19:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbaAYSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 13:24:19 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55940 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbaAYSYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 13:24:17 -0500
Received: from localhost ([127.0.0.1]:54979 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W77tv-0001J1-Jk; Sat, 25 Jan 2014 13:24:16 -0500
Received: by lola (Postfix, from userid 1000)
	id 29F00E0765; Sat, 25 Jan 2014 19:24:01 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1390674221-25767-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241070>

The previous implementation uses a sorted linear list of struct
blame_entry in a struct scoreboard for organizing all partial or
completed work.  Every task that is done requires going through the
whole list where most entries are not relevant to the task at hand.

This commit reorganizes the data structures in order to have each
remaining subtask work with its own sorted linear list it can work off
front to back.  Subtasks are organized into "struct origin" chains
hanging off particular commits.  Commits are organized into a priority
queue, processing them in commit date order in order to keep most of
the work affecting a particular blob collated even in the presence of
an extensive merge history.  In that manner, linear searches can be
basically avoided anywhere.  They still are done for identifying one
of multiple analyzed files in a given commit, but the degenerate case
of a single large file being assembled from a multitude of smaller
files in the past is not likely to occur often enough to warrant
special treatment.
---
 builtin/blame.c | 569 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 367 insertions(+), 202 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ead6148..994a9e8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -18,7 +18,9 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "mergesort.h"
 #include "parse-options.h"
+#include "prio-queue.h"
 #include "utf8.h"
 #include "userdiff.h"
 #include "line-range.h"
@@ -83,11 +85,43 @@ static unsigned blame_copy_score;
  */
 struct origin {
 	int refcnt;
+	/* Record preceding blame record for this blob */
 	struct origin *previous;
+	/* origins are put in a list linked via `next' hanging off the
+	 * corresponding commit's util field in order to make finding
+	 * them fast.  The presence in this chain does not count
+	 * towards the origin's reference count.  It is tempting to
+	 * let it count as long as the commit is pending examination,
+	 * but even under circumstances where the commit will be
+	 * present multiple times in the priority queue of unexamined
+	 * commits, processing the first instance will not leave any
+	 * work requiring the origin data for the second instance.  An
+	 * interspersed commit changing that would have to be
+	 * preexisting with a different ancestry and with the same
+	 * commit date in order to wedge itself between two instances
+	 * of the same commit in the priority queue _and_ produce
+	 * blame entries relevant for it.  While we don't want to let
+	 * us get tripped up by this case, it certainly does not seem
+	 * worth optimizing for.
+	 */
+	struct origin *next;
 	struct commit *commit;
+	/* `suspects' contains blame entries that may be attributed to
+	 * this origin's commit or to parent commits.  When a commit
+	 * is being processed, all suspects will be moved, either by
+	 * assigning them to an origin in a different commit, or by
+	 * shipping them to the scoreboard's ent list because they
+	 * cannot be attributed to a different commit.
+	 */
+	struct blame_entry *suspects;
 	mmfile_t file;
 	unsigned char blob_sha1[20];
 	unsigned mode;
+	/* shipped gets set when shipping any suspects to the final
+	 * blame list instead of other commits
+	 */
+	char shipped;
+	char guilty;
 	char path[FLEX_ARRAY];
 };
 
@@ -176,10 +210,23 @@ static inline struct origin *origin_incref(struct origin *o)
 static void origin_decref(struct origin *o)
 {
 	if (o && --o->refcnt <= 0) {
+		struct origin *p, *l = NULL;
 		if (o->previous)
 			origin_decref(o->previous);
 		free(o->file.ptr);
-		free(o);
+		/* Should be present exactly once in commit chain */
+		for (p = o->commit->util; p; l = p, p = p->next) {
+			if (p == o)
+			{
+				if (l)
+					l->next = p->next;
+				else
+					o->commit->util = p->next;
+				free(o);
+				return;
+			}
+		}
+		die("internal error in blame::origin_decref");
 	}
 }
 
@@ -193,8 +240,12 @@ static void drop_origin_blob(struct origin *o)
 
 /*
  * Each group of lines is described by a blame_entry; it can be split
- * as we pass blame to the parents.  They form a linked list in the
- * scoreboard structure, sorted by the target line number.
+ * as we pass blame to the parents.  They are arranged in linked lists
+ * kept as `suspects' of some unprocessed origin, or entered (when the
+ * blame origin has been finalized) into the scoreboard structure.
+ * While the scoreboard structure is only sorted at the end of
+ * processing (according to final image line number), the lists
+ * attached to an origin are sorted by the target line number.
  */
 struct blame_entry {
 	struct blame_entry *next;
@@ -210,11 +261,6 @@ struct blame_entry {
 	/* the commit that introduced this group into the final image */
 	struct origin *suspect;
 
-	/* true if the suspect is truly guilty; false while we have not
-	 * checked if the group came from one of its parents.
-	 */
-	char guilty;
-
 	/* true if the entry has been scanned for copies in the current parent
 	 */
 	char scanned;
@@ -230,12 +276,94 @@ struct blame_entry {
 	unsigned score;
 };
 
+/* This is subtle.  Any _merge_ of blames happens on lists of blames
+ * that arrived via different parents in a single suspect.  In this
+ * case, we want to sort according to the _suspect_ line numbers.  In
+ * contrast to that, blame_sort is used for the final sorting of blame
+ * data and consequently works with final image line numbers.
+ */
+
+static struct blame_entry *
+blame_merge(struct blame_entry *list1,
+	    struct blame_entry *list2)
+{
+	struct blame_entry *p1 = list1, *p2 = list2,
+		**tail = &list1;
+	
+	if (!p1)
+		return p2;
+	if (!p2)
+		return p1;
+
+	if (p1->s_lno <= p2->s_lno)
+	{
+		do {
+			tail = &p1->next;
+			if ((p1 = *tail) == NULL)
+			{
+				*tail = p2;
+				return list1;
+			}
+		} while (p1->s_lno <= p2->s_lno);
+	}
+	for (;;)
+	{
+		*tail = p2;
+		do {
+			tail = &p2->next;
+			if ((p2 = *tail) == NULL)  {
+				*tail = p1;
+				return list1;
+			}
+		} while (p1->s_lno > p2->s_lno);
+		*tail = p1;
+		do {
+			tail = &p1->next;
+			if ((p1 = *tail) == NULL) {
+				*tail = p2;
+				return list1;
+			}
+		} while (p1->s_lno <= p2->s_lno);
+	}
+}
+
+static void *
+get_next_blame (const void *p)
+{
+	return ((struct blame_entry *)p)->next;
+}
+
+static void
+set_next_blame (void *p1, void *p2)
+{
+	((struct blame_entry *)p1)->next = p2;
+}
+
+static int
+compare_blame (const void *p1, const void *p2)
+{
+	return ((struct blame_entry *)p1)->lno - ((struct blame_entry *)p2)->lno;
+}
+
+static struct blame_entry *
+blame_sort (struct blame_entry *head)
+{
+	return llist_mergesort (head, get_next_blame, set_next_blame, compare_blame);
+}
+
+int compare_commits_by_reverse_commit_date(const void *a, const void *b, void *c)
+{
+	return -compare_commits_by_commit_date(a, b, c);
+}
+
 /*
  * The current state of the blame assignment.
  */
 struct scoreboard {
 	/* the final commit (i.e. where we started digging from) */
 	struct commit *final;
+	/* Priority queue for commits with unassigned blame records */
+	struct prio_queue commits;
 	struct rev_info *revs;
 	const char *path;
 
@@ -268,7 +396,6 @@ static void coalesce(struct scoreboard *sb)
 
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
-		    ent->guilty == next->guilty &&
 		    ent->s_lno + ent->num_lines == next->s_lno) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
@@ -295,23 +422,33 @@ static struct origin *make_origin(struct commit *commit, const char *path)
 	o = xcalloc(1, sizeof(*o) + strlen(path) + 1);
 	o->commit = commit;
 	o->refcnt = 1;
+	o->next = commit->util;
+	commit->util = o;
 	strcpy(o->path, path);
 	return o;
 }
 
 /*
  * Locate an existing origin or create a new one.
+ * This moves the origin to front position in the commit util list.
  */
 static struct origin *get_origin(struct scoreboard *sb,
 				 struct commit *commit,
 				 const char *path)
 {
-	struct blame_entry *e;
+	struct origin *o, *l;
 
-	for (e = sb->ent; e; e = e->next) {
-		if (e->suspect->commit == commit &&
-		    !strcmp(e->suspect->path, path))
-			return origin_incref(e->suspect);
+	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
+		if (!strcmp(o->path, path))
+		{
+			/* bump to front */
+			if (l) {
+				l->next = o->next;
+				o->next = commit->util;
+				commit->util = o;
+			}
+			return origin_incref(o);
+		}
 	}
 	return make_origin(commit, path);
 }
@@ -350,41 +487,19 @@ static struct origin *find_origin(struct scoreboard *sb,
 				  struct commit *parent,
 				  struct origin *origin)
 {
-	struct origin *porigin = NULL;
+	struct origin *porigin;
 	struct diff_options diff_opts;
 	const char *paths[2];
 
-	if (parent->util) {
-		/*
-		 * Each commit object can cache one origin in that
-		 * commit.  This is a freestanding copy of origin and
-		 * not refcounted.
-		 */
-		struct origin *cached = parent->util;
-		if (!strcmp(cached->path, origin->path)) {
+	/* First check any existing origins */
+	for (porigin = parent->util; porigin; porigin = porigin->next)
+		if (!strcmp(porigin->path, origin->path)) {
 			/*
 			 * The same path between origin and its parent
 			 * without renaming -- the most common case.
 			 */
-			porigin = get_origin(sb, parent, cached->path);
-
-			/*
-			 * If the origin was newly created (i.e. get_origin
-			 * would call make_origin if none is found in the
-			 * scoreboard), it does not know the blob_sha1/mode,
-			 * so copy it.  Otherwise porigin was in the
-			 * scoreboard and already knows blob_sha1/mode.
-			 */
-			if (porigin->refcnt == 1) {
-				hashcpy(porigin->blob_sha1, cached->blob_sha1);
-				porigin->mode = cached->mode;
-			}
-			return porigin;
+			return origin_incref (porigin);
 		}
-		/* otherwise it was not very useful; free it */
-		free(parent->util);
-		parent->util = NULL;
-	}
 
 	/* See if the origin->path is different between parent
 	 * and origin first.  Most of the time they are the
@@ -450,19 +565,6 @@ static struct origin *find_origin(struct scoreboard *sb,
 	}
 	diff_flush(&diff_opts);
 	free_pathspec(&diff_opts.pathspec);
-	if (porigin) {
-		/*
-		 * Create a freestanding copy that is not part of
-		 * the refcounted origin found in the scoreboard, and
-		 * cache it in the commit.
-		 */
-		struct origin *cached;
-
-		cached = make_origin(porigin->commit, porigin->path);
-		hashcpy(cached->blob_sha1, porigin->blob_sha1);
-		cached->mode = porigin->mode;
-		parent->util = cached;
-	}
 	return porigin;
 }
 
@@ -508,49 +610,53 @@ static struct origin *find_rename(struct scoreboard *sb,
 	return porigin;
 }
 
+#if 0
 /*
- * Link in a new blame entry to the scoreboard.  Entries that cover the
- * same line range have been removed from the scoreboard previously.
+ * Add a new blame entry to a given output queue.
  */
-static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
+static void add_blame_entry(struct blame_entry ***queue, struct blame_entry *e)
 {
-	struct blame_entry *ent, *prev = NULL;
-
 	origin_incref(e->suspect);
 
-	for (ent = sb->ent; ent && ent->lno < e->lno; ent = ent->next)
-		prev = ent;
-
-	/* prev, if not NULL, is the last one that is below e */
-
-	if (prev) {
-		e->next = prev->next;
-		prev->next = e;
-	}
-	else {
-		e->next = sb->ent;
-		sb->ent = e;
-	}
+	e->next = **queue;
+	**queue = e;
+	*queue = &e->next;
 }
 
 /*
  * src typically is on-stack; we want to copy the information in it to
- * a malloced blame_entry that is already on the linked list of the
- * scoreboard.  The origin of dst loses a refcnt while the origin of src
- * gains one.
+ * a blame_entry that is allocated in one queue and will be relocated
+ * to another.
  */
-static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
+static void dup_entry(struct blame_entry ***dstq, struct blame_entry ***srcq,
+		      struct blame_entry *src)
 {
-	struct blame_entry *n;
-
-	n = dst->next;
+	struct blame_entry *dst = **srcq;
 	origin_incref(src->suspect);
 	origin_decref(dst->suspect);
+	**srcq = dst->next;	/* unlinked from source queue */
 	memcpy(dst, src, sizeof(*src));
-	dst->next = n;
 	dst->score = 0;
+	dst->next = **dstq;
+	*dstq = &dst->next;	/* linked into destination queue */
 }
 
+/* This copies a changed entry over the existing entry in the queue */
+static void trim_entry(struct blame_entry ***queue, struct blame_entry *src)
+{
+	struct blame_entry *dst = **queue;
+	struct blame_entry *n = dst->next;
+	/* No need to mess with reference counts as we stay with the
+	 * same suspect
+	 */
+	memcpy(dst, src, sizeof(*src));
+	dst->score = 0;
+	dst->next = n;
+	*queue = &dst->next;	/* move after entry */
+}
+
+#endif
+
 static const char *nth_line(struct scoreboard *sb, long lno)
 {
 	return sb->final_buf + sb->lineno[lno];
@@ -561,6 +667,7 @@ static const char *nth_line_cb(void *data, long lno)
 	return nth_line((struct scoreboard *)data, lno);
 }
 
+#if 0
 /*
  * It is known that lines between tlno to same came from parent, and e
  * has an overlap with that range.  it also is known that parent's
@@ -573,7 +680,10 @@ static const char *nth_line_cb(void *data, long lno)
  *             <------------------>
  *
  * Split e into potentially three parts; before this chunk, the chunk
- * to be blamed for the parent, and after that portion.
+ * to be blamed for the parent, and after that portion.  As the chunks
+ * are processed in sequence, any part before the overlap can be
+ * terminally blamed on the target while parts after the overlap can
+ * only be properly evaluated after examining future diffs.
  */
 static void split_overlap(struct blame_entry *split,
 			  struct blame_entry *e,
@@ -620,72 +730,55 @@ static void split_overlap(struct blame_entry *split,
 
 /*
  * split_overlap() divided an existing blame e into up to three parts
- * in split.  Adjust the linked list of blames in the scoreboard to
- * reflect the split.
+ * in split.  Adjust the linked list of blames to reflect the split,
+ * the first part being common to target and parent and consequently
+ * being blamed on the parent, the second part being different and
+ * consequently blamed on the target, and the third part starting out
+ * as being the same but without conclusive information where to place
+ * the blame, so leaving it in the target subject to further
+ * processing.
  */
-static void split_blame(struct scoreboard *sb,
-			struct blame_entry *split,
-			struct blame_entry *e)
+static void split_blame(struct blame_entry *split,
+			struct blame_entry ***dstq,
+			struct blame_entry ***srcq)
 {
 	struct blame_entry *new_entry;
 
 	if (split[0].suspect && split[2].suspect) {
 		/* The first part (reuse storage for the existing entry e) */
-		dup_entry(e, &split[0]);
+		trim_entry(srcq, &split[0]);
 
 		/* The last part -- me */
 		new_entry = xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
+		add_blame_entry(srcq, new_entry);
 
 		/* ... and the middle part -- parent */
 		new_entry = xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
+		add_blame_entry(dstq, new_entry);
 	}
 	else if (!split[0].suspect && !split[2].suspect)
 		/*
 		 * The parent covers the entire area; reuse storage for
 		 * e and replace it with the parent.
 		 */
-		dup_entry(e, &split[1]);
+		dup_entry(dstq, srcq, &split[1]);
 	else if (split[0].suspect) {
 		/* me and then parent */
-		dup_entry(e, &split[0]);
+		trim_entry(srcq, &split[0]);
 
 		new_entry = xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
+		add_blame_entry(dstq, new_entry);
 	}
 	else {
 		/* parent and then me */
-		dup_entry(e, &split[1]);
-
 		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
-	}
-
-	if (DEBUG) { /* sanity */
-		struct blame_entry *ent;
-		int lno = sb->ent->lno, corrupt = 0;
+		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
+		add_blame_entry(dstq, new_entry);
 
-		for (ent = sb->ent; ent; ent = ent->next) {
-			if (lno != ent->lno)
-				corrupt = 1;
-			if (ent->s_lno < 0)
-				corrupt = 1;
-			lno += ent->num_lines;
-		}
-		if (corrupt) {
-			lno = sb->ent->lno;
-			for (ent = sb->ent; ent; ent = ent->next) {
-				printf("L %8d l %8d n %8d\n",
-				       lno, ent->lno, ent->num_lines);
-				lno = ent->lno + ent->num_lines;
-			}
-			die("oops");
-		}
+		trim_entry(srcq, &split[2]);
 	}
 }
 
@@ -702,74 +795,116 @@ static void decref_split(struct blame_entry *split)
 }
 
 /*
- * Helper for blame_chunk().  blame_entry e is known to overlap with
+ * Helper for blame_chunk().  blame_entry in srcq is known to overlap with
  * the patch hunk; split it and pass blame to the parent.
  */
-static void blame_overlap(struct scoreboard *sb, struct blame_entry *e,
+static void blame_overlap(struct blame entry ***dstq, struct blame_entry ***srcq,
 			  int tlno, int plno, int same,
 			  struct origin *parent)
 {
 	struct blame_entry split[3];
 
-	split_overlap(split, e, tlno, plno, same, parent);
+	split_overlap(split, **srcq, tlno, plno, same, parent);
 	if (split[1].suspect)
-		split_blame(sb, split, e);
+	  split_blame(split, dstq, srcq);
 	decref_split(split);
 }
+#endif
 
 /*
- * Find the line number of the last line the target is suspected for.
+ * Process one hunk from the patch between the current suspect for
+ * blame_entry e and its parent.  This first blames any unfinished
+ * entries before the chunk (which is where target and parent start
+ * differing) on the parent, and then splits blame entries at the
+ * start and at the end of the difference region.
  */
-static int find_last_in_target(struct scoreboard *sb, struct origin *target)
+static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
+			int tlno, int offset, int same,
+			struct origin *target, struct origin *parent)
 {
-	struct blame_entry *e;
-	int last_in_target = -1;
-
-	for (e = sb->ent; e; e = e->next) {
-		if (e->guilty || e->suspect != target)
-			continue;
-		if (last_in_target < e->s_lno + e->num_lines)
-			last_in_target = e->s_lno + e->num_lines;
+	struct blame_entry *e = **srcq;
+	
+/* Pass blame for everything before the differing chunk to the parent */
+	while (e && e->s_lno + e->num_lines <= tlno) {
+		**dstq = e;
+		origin_decref(e->suspect);
+		e->suspect = origin_incref(parent);
+		e->s_lno += offset;
+		e = *(*dstq = &e->next);
 	}
-	return last_in_target;
-}
-
+	**srcq = e;
+	if (!e)
+		return;
 /*
- * Process one hunk from the patch between the current suspect for
- * blame_entry e and its parent.  Find and split the overlap, and
- * pass blame to the overlapping part to the parent.
+ * current record _ends_ after the start of the difference region.  If
+ * it starts before it, we need to split it up and pass blame for its
+ * first part to the parent.
  */
-static void blame_chunk(struct scoreboard *sb,
-			int tlno, int plno, int same,
-			struct origin *target, struct origin *parent)
-{
-	struct blame_entry *e;
-
-	for (e = sb->ent; e; e = e->next) {
-		if (e->guilty || e->suspect != target)
-			continue;
-		if (same <= e->s_lno)
-			continue;
-		if (tlno < e->s_lno + e->num_lines)
-			blame_overlap(sb, e, tlno, plno, same, parent);
+	if (e->s_lno < tlno) {
+		/* we move the first half to a new record */
+		int len = tlno - e->s_lno;
+		struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
+		n->suspect = origin_incref(parent);
+		n->lno = e->lno;
+		n->s_lno = e->s_lno + offset;
+		n->num_lines = len;
+		n->score = 0;
+		**dstq = n;
+		*dstq = &n->next;
+
+		e->lno += len;
+		e->s_lno = tlno;
+		e->num_lines -= len;
+		e->score = 0;
 	}
+/*
+ * Now retain records on the target while it is different from the parent.
+ */
+	while (e->s_lno + e->num_lines <= same) {
+		e = *(*srcq = &e->next);
+		if (!e)
+			return;
+	}
+/*
+ * If current record starts before sameness, need to split.
+ */
+	if (e->s_lno < same) {
+		int len = same - e->s_lno;
+		struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
+		n->suspect = origin_incref(target);
+		n->lno = e->lno;
+		n->s_lno = e->s_lno;
+		n->num_lines = len;
+		n->score = 0;
+		**srcq = n;
+		*(*srcq = &n->next) = e;
+		/* keep second half in target queue */
+		e->lno += len;
+		e->s_lno = same;
+		e->num_lines -= len;
+		e->score = 0;
+	}
+	return;
 }
 
 struct blame_chunk_cb_data {
-	struct scoreboard *sb;
 	struct origin *target;
 	struct origin *parent;
-	long plno;
-	long tlno;
+	long offset;
+	struct blame_entry **dstq;
+	struct blame_entry **srcq;
 };
 
+/* diff chunks are from parent to target */
 static int blame_chunk_cb(long start_a, long count_a,
 			  long start_b, long count_b, void *data)
 {
 	struct blame_chunk_cb_data *d = data;
-	blame_chunk(d->sb, d->tlno, d->plno, start_b, d->target, d->parent);
-	d->plno = start_a + count_a;
-	d->tlno = start_b + count_b;
+	if (start_a - start_b != d->offset)
+		die("internal error in blame::blame_chunk_cb");
+	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
+		    start_b + count_b, d->target, d->parent);
+	d->offset = start_a + count_a - (start_b + count_b);
 	return 0;
 }
 
@@ -782,23 +917,28 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 				struct origin *target,
 				struct origin *parent)
 {
-	int last_in_target;
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
+	struct blame_entry *newdest = NULL;
 
-	memset(&d, 0, sizeof(d));
-	d.sb = sb; d.target = target; d.parent = parent;
-	last_in_target = find_last_in_target(sb, target);
-	if (last_in_target < 0)
+	if (!target->suspects)
 		return 1; /* nothing remains for this target */
 
+	d.target = target; d.parent = parent;
+	d.offset = 0;
+	d.dstq = &newdest; d.srcq = &target->suspects;
+
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
 	num_get_patch++;
 
 	diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d);
-	/* The rest (i.e. anything after tlno) are the same as the parent */
-	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
+	/* The rest are the same as the parent */
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, target, parent);
+	*d.dstq = NULL;
+	parent->suspects = blame_merge (parent->suspects, newdest);
+	if (parent->suspects)
+		prio_queue_put(&sb->commits, parent->commit);
 
 	return 0;
 }
@@ -833,6 +973,7 @@ static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
 	return score;
 }
 
+#if 0
 /*
  * best_so_far[] and this[] are both a split of an existing blame_entry
  * that passes blame to the parent.  Maintain best_so_far the best split
@@ -1147,6 +1288,8 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	return retval;
 }
 
+#endif
+
 /*
  * The blobs of origin and porigin exactly match, so everything
  * origin is suspected for can be blamed on the parent.
@@ -1154,20 +1297,22 @@ static int find_copy_in_parent(struct scoreboard *sb,
 static void pass_whole_blame(struct scoreboard *sb,
 			     struct origin *origin, struct origin *porigin)
 {
-	struct blame_entry *e;
+	struct blame_entry *e, *suspects;
 
 	if (!porigin->file.ptr && origin->file.ptr) {
 		/* Steal its file */
 		porigin->file = origin->file;
 		origin->file.ptr = NULL;
 	}
-	for (e = sb->ent; e; e = e->next) {
-		if (e->suspect != origin)
-			continue;
+	suspects = origin->suspects;
+	origin->suspects = NULL;
+	for (e = suspects; e; e = e->next) {
 		origin_incref(porigin);
 		origin_decref(e->suspect);
 		e->suspect = porigin;
 	}
+	porigin->suspects = blame_merge(porigin->suspects, suspects);
+	prio_queue_put(&sb->commits, porigin->commit);
 }
 
 /*
@@ -1266,6 +1411,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 			goto finish;
 	}
 
+#if 0
 	/*
 	 * Optionally find moves in parents' files.
 	 */
@@ -1292,6 +1438,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 						porigin, opt))
 				goto finish;
 		}
+#endif
 
  finish:
 	for (i = 0; i < num_sg; i++) {
@@ -1488,14 +1635,11 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 }
 
 /*
- * The blame_entry is found to be guilty for the range.  Mark it
- * as such, and show it in incremental output.
+ * The blame_entry is found to be guilty for the range.
+ * Show it in incremental output.
  */
 static void found_guilty_entry(struct blame_entry *ent)
 {
-	if (ent->guilty)
-		return;
-	ent->guilty = 1;
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
 
@@ -1509,32 +1653,34 @@ static void found_guilty_entry(struct blame_entry *ent)
 }
 
 /*
- * The main loop -- while the scoreboard has lines whose true origin
- * is still unknown, pick one blame_entry, and allow its current
- * suspect to pass blames to its parents.
- */
+ * The main loop -- while we have blobs with lines whose true origin
+ * is still unknown, pick one blob, and allow its lines to pass blames
+ * to its parents. */
 static void assign_blame(struct scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
+	struct commit *commit = prio_queue_get (&sb->commits);
 
-	while (1) {
+	while (commit) {
 		struct blame_entry *ent;
-		struct commit *commit;
-		struct origin *suspect = NULL;
+		struct origin *suspect = commit->util;
 
 		/* find one suspect to break down */
-		for (ent = sb->ent; !suspect && ent; ent = ent->next)
-			if (!ent->guilty)
-				suspect = ent->suspect;
-		if (!suspect)
-			return; /* all done */
+		while (suspect && !suspect->suspects)
+			suspect = suspect->next;
+		
+		if (!suspect) {
+			commit = prio_queue_get(&sb->commits);
+			continue;
+		}
+
+		assert(commit == suspect->commit);
 
 		/*
 		 * We will use this suspect later in the loop,
 		 * so hold onto it in the meantime.
 		 */
 		origin_incref(suspect);
-		commit = suspect->commit;
 		parse_commit(commit);
 		if (reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
@@ -1550,9 +1696,22 @@ static void assign_blame(struct scoreboard *sb, int opt)
 			commit->object.flags |= UNINTERESTING;
 
 		/* Take responsibility for the remaining entries */
-		for (ent = sb->ent; ent; ent = ent->next)
-			if (ent->suspect == suspect)
+		ent = suspect->suspects;
+		if (ent) {
+			for (;;) {
+				struct blame_entry *next = ent->next;
 				found_guilty_entry(ent);
+				if (next)
+				{
+					ent = next;
+					continue;
+				}
+				ent->next = sb->ent;
+				sb->ent = suspect->suspects;
+				suspect->suspects = NULL;
+				break;
+			}
+		}
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -1609,9 +1768,8 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	char hex[41];
 
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
-	printf("%s%c%d %d %d\n",
+	printf("%s %d %d %d\n",
 	       hex,
-	       ent->guilty ? ' ' : '*', /* purely for debugging */
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
@@ -1724,17 +1882,16 @@ static void output(struct scoreboard *sb, int option)
 
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
-			struct blame_entry *oth;
-			struct origin *suspect = ent->suspect;
-			struct commit *commit = suspect->commit;
+			int count = 0;
+			struct origin *suspect;
+			struct commit *commit = ent->suspect->commit;
 			if (commit->object.flags & MORE_THAN_ONE_PATH)
 				continue;
-			for (oth = ent->next; oth; oth = oth->next) {
-				if ((oth->suspect->commit != commit) ||
-				    !strcmp(oth->suspect->path, suspect->path))
-					continue;
-				commit->object.flags |= MORE_THAN_ONE_PATH;
-				break;
+			for (suspect = commit->util; suspect; suspect = suspect->next) {
+				if (suspect->guilty && count++) {
+					commit->object.flags |= MORE_THAN_ONE_PATH;
+					break;
+				}
 			}
 		}
 	}
@@ -2083,7 +2240,6 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
-	commit->util = origin;
 
 	/*
 	 * Read the current index, replace the path entry with
@@ -2394,12 +2550,16 @@ parse_done:
 	memset(&sb, 0, sizeof(sb));
 
 	sb.revs = &revs;
-	if (!reverse)
+	if (!reverse) {
 		final_commit_name = prepare_final(&sb);
+		sb.commits.compare = compare_commits_by_commit_date;
+	}
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
-	else
+	else {
 		final_commit_name = prepare_initial(&sb);
+		sb.commits.compare = compare_commits_by_reverse_commit_date;
+	}
 
 	if (!sb.final) {
 		/*
@@ -2493,7 +2653,7 @@ parse_done:
 	range_set_release(&ranges);
 	string_list_clear(&range_list, 0);
 
-	sb.ent = ent;
+	sb.ent = NULL;
 	sb.path = path;
 
 	read_mailmap(&mailmap, NULL);
@@ -2501,11 +2661,16 @@ parse_done:
 	if (!incremental)
 		setup_pager();
 
+	prio_queue_put(&sb.commits, o->commit);
+	o->suspects = ent;
+	
 	assign_blame(&sb, opt);
 
 	if (incremental)
 		return 0;
 
+	sb.ent = blame_sort(sb.ent);
+
 	coalesce(&sb);
 
 	if (!(output_option & OUTPUT_PORCELAIN))
-- 
1.8.3.2
