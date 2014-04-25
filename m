From: David Kastrup <dak@gnu.org>
Subject: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 01:56:49 +0200
Message-ID: <1398470210-28746-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:57:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdpzr-0006vI-EC
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbaDYX50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2014 19:57:26 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50885 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbaDYX5V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 19:57:21 -0400
Received: from localhost ([127.0.0.1]:49927 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wdpzc-0007pZ-0K; Fri, 25 Apr 2014 19:57:20 -0400
Received: by lola (Postfix, from userid 1000)
	id 00738E05FE; Sat, 26 Apr 2014 01:56:54 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247136>

The previous implementation used a single sorted linear list of blame
entries for organizing all partial or completed work.  Every subtask ha=
d
to scan the whole list, with most entries not being relevant to the
task.  The resulting run-time was quadratic to the number of separate
chunks.

This change gives every subtask its own data to work with.  Subtasks ar=
e
organized into "struct origin" chains hanging off particular commits.
Commits are organized into a priority queue, processing them in commit
date order in order to keep most of the work affecting a particular blo=
b
collated even in the presence of an extensive merge history.

=46or large files with a diversified history, a=C2=A0speedup by a facto=
r of 3
or more is not unusual.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 builtin/blame.c | 865 +++++++++++++++++++++++++++++++++++++-----------=
--------
 1 file changed, 567 insertions(+), 298 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 88cb799..224f0ff 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1,7 +1,8 @@
 /*
  * Blame
  *
- * Copyright (c) 2006, Junio C Hamano
+ * Copyright (c) 2006, 2014 by its authors
+ * See COPYING for licensing conditions
  */
=20
 #include "cache.h"
@@ -18,7 +19,9 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "mergesort.h"
 #include "parse-options.h"
+#include "prio-queue.h"
 #include "utf8.h"
 #include "userdiff.h"
 #include "line-range.h"
@@ -83,11 +86,42 @@ static unsigned blame_copy_score;
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
+	/* guilty gets set when shipping any suspects to the final
+	 * blame list instead of other commits
+	 */
+	char guilty;
 	char path[FLEX_ARRAY];
 };
=20
@@ -176,10 +210,22 @@ static inline struct origin *origin_incref(struct=
 origin *o)
 static void origin_decref(struct origin *o)
 {
 	if (o && --o->refcnt <=3D 0) {
+		struct origin *p, *l =3D NULL;
 		if (o->previous)
 			origin_decref(o->previous);
 		free(o->file.ptr);
-		free(o);
+		/* Should be present exactly once in commit chain */
+		for (p =3D o->commit->util; p; l =3D p, p =3D p->next) {
+			if (p =3D=3D o) {
+				if (l)
+					l->next =3D p->next;
+				else
+					o->commit->util =3D p->next;
+				free(o);
+				return;
+			}
+		}
+		die("internal error in blame::origin_decref");
 	}
 }
=20
@@ -193,8 +239,12 @@ static void drop_origin_blob(struct origin *o)
=20
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
@@ -210,15 +260,6 @@ struct blame_entry {
 	/* the commit that introduced this group into the final image */
 	struct origin *suspect;
=20
-	/* true if the suspect is truly guilty; false while we have not
-	 * checked if the group came from one of its parents.
-	 */
-	char guilty;
-
-	/* true if the entry has been scanned for copies in the current paren=
t
-	 */
-	char scanned;
-
 	/* the line number of the first line of this group in the
 	 * suspect's file; internally all line numbers are 0 based.
 	 */
@@ -231,11 +272,112 @@ struct blame_entry {
 };
=20
 /*
+ * Any merge of blames happens on lists of blames that arrived via
+ * different parents in a single suspect.  In this case, we want to
+ * sort according to the suspect line numbers as opposed to the final
+ * image line numbers.  The function body is somewhat longish because
+ * it avoids unnecessary writes.
+ */
+
+static struct blame_entry *blame_merge(struct blame_entry *list1,
+				       struct blame_entry *list2)
+{
+	struct blame_entry *p1 =3D list1, *p2 =3D list2,
+		**tail =3D &list1;
+
+	if (!p1)
+		return p2;
+	if (!p2)
+		return p1;
+
+	if (p1->s_lno <=3D p2->s_lno) {
+		do {
+			tail =3D &p1->next;
+			if ((p1 =3D *tail) =3D=3D NULL) {
+				*tail =3D p2;
+				return list1;
+			}
+		} while (p1->s_lno <=3D p2->s_lno);
+	}
+	for (;;) {
+		*tail =3D p2;
+		do {
+			tail =3D &p2->next;
+			if ((p2 =3D *tail) =3D=3D NULL)  {
+				*tail =3D p1;
+				return list1;
+			}
+		} while (p1->s_lno > p2->s_lno);
+		*tail =3D p1;
+		do {
+			tail =3D &p1->next;
+			if ((p1 =3D *tail) =3D=3D NULL) {
+				*tail =3D p2;
+				return list1;
+			}
+		} while (p1->s_lno <=3D p2->s_lno);
+	}
+}
+
+static void *get_next_blame(const void *p)
+{
+	return ((struct blame_entry *)p)->next;
+}
+
+static void set_next_blame(void *p1, void *p2)
+{
+	((struct blame_entry *)p1)->next =3D p2;
+}
+
+/*
+ * Final image line numbers are all different, so we don't need a
+ * three-way comparison here.
+ */
+
+static int compare_blame_final(const void *p1, const void *p2)
+{
+	return ((struct blame_entry *)p1)->lno > ((struct blame_entry *)p2)->=
lno
+		? 1 : -1;
+}
+
+static int compare_blame_suspect(const void *p1, const void *p2)
+{
+	const struct blame_entry *s1 =3D p1, *s2 =3D p2;
+	/*
+	 * to allow for collating suspects, we sort according to the
+	 * respective pointer value as the primary sorting criterion.
+	 * The actual relation is pretty unimportant as long as it
+	 * establishes a total order.  Comparing as integers gives us
+	 * that.
+	 */
+	if (s1->suspect !=3D s2->suspect)
+		return (intptr_t)s1->suspect > (intptr_t)s2->suspect ? 1 : -1;
+	if (s1->s_lno =3D=3D s2->s_lno)
+		return 0;
+	return s1->s_lno > s2->s_lno ? 1 : -1;
+}
+
+static struct blame_entry *blame_sort(struct blame_entry *head,
+				      int (*compare_fn)(const void *, const void *))
+{
+	return llist_mergesort (head, get_next_blame, set_next_blame, compare=
_fn);
+}
+
+static int compare_commits_by_reverse_commit_date(const void *a,
+						  const void *b,
+						  void *c)
+{
+	return -compare_commits_by_commit_date(a, b, c);
+}
+
+/*
  * The current state of the blame assignment.
  */
 struct scoreboard {
 	/* the final commit (i.e. where we started digging from) */
 	struct commit *final;
+	/* Priority queue for commits with unassigned blame records */
+	struct prio_queue commits;
 	struct rev_info *revs;
 	const char *path;
=20
@@ -268,7 +410,6 @@ static void coalesce(struct scoreboard *sb)
=20
 	for (ent =3D sb->ent; ent && (next =3D ent->next); ent =3D next) {
 		if (ent->suspect =3D=3D next->suspect &&
-		    ent->guilty =3D=3D next->guilty &&
 		    ent->s_lno + ent->num_lines =3D=3D next->s_lno) {
 			ent->num_lines +=3D next->num_lines;
 			ent->next =3D next->next;
@@ -284,6 +425,30 @@ static void coalesce(struct scoreboard *sb)
 }
=20
 /*
+ * Merge the given sorted list of blames into a preexisting origin.
+ * If there were no previous blames to that commit, it is entered into
+ * the commit priority queue of the score board.
+ */
+
+static void queue_blames(struct scoreboard *sb, struct origin *porigin=
,
+			 struct blame_entry *sorted)
+{
+	if (porigin->suspects)
+		porigin->suspects =3D blame_merge(porigin->suspects, sorted);
+	else {
+		struct origin *o;
+		for (o =3D porigin->commit->util; o; o =3D o->next) {
+			if (o->suspects) {
+				porigin->suspects =3D sorted;
+				return;
+			}
+		}
+		porigin->suspects =3D sorted;
+		prio_queue_put(&sb->commits, porigin->commit);
+	}
+}
+
+/*
  * Given a commit and a path in it, create a new origin structure.
  * The callers that add blame to the scoreboard should use
  * get_origin() to obtain shared, refcounted copy instead of calling
@@ -295,23 +460,32 @@ static struct origin *make_origin(struct commit *=
commit, const char *path)
 	o =3D xcalloc(1, sizeof(*o) + strlen(path) + 1);
 	o->commit =3D commit;
 	o->refcnt =3D 1;
+	o->next =3D commit->util;
+	commit->util =3D o;
 	strcpy(o->path, path);
 	return o;
 }
=20
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
=20
-	for (e =3D sb->ent; e; e =3D e->next) {
-		if (e->suspect->commit =3D=3D commit &&
-		    !strcmp(e->suspect->path, path))
-			return origin_incref(e->suspect);
+	for (o =3D commit->util, l =3D NULL; o; l =3D o, o =3D o->next) {
+		if (!strcmp(o->path, path)) {
+			/* bump to front */
+			if (l) {
+				l->next =3D o->next;
+				o->next =3D commit->util;
+				commit->util =3D o;
+			}
+			return origin_incref(o);
+		}
 	}
 	return make_origin(commit, path);
 }
@@ -350,41 +524,19 @@ static struct origin *find_origin(struct scoreboa=
rd *sb,
 				  struct commit *parent,
 				  struct origin *origin)
 {
-	struct origin *porigin =3D NULL;
+	struct origin *porigin;
 	struct diff_options diff_opts;
 	const char *paths[2];
=20
-	if (parent->util) {
-		/*
-		 * Each commit object can cache one origin in that
-		 * commit.  This is a freestanding copy of origin and
-		 * not refcounted.
-		 */
-		struct origin *cached =3D parent->util;
-		if (!strcmp(cached->path, origin->path)) {
+	/* First check any existing origins */
+	for (porigin =3D parent->util; porigin; porigin =3D porigin->next)
+		if (!strcmp(porigin->path, origin->path)) {
 			/*
 			 * The same path between origin and its parent
 			 * without renaming -- the most common case.
 			 */
-			porigin =3D get_origin(sb, parent, cached->path);
-
-			/*
-			 * If the origin was newly created (i.e. get_origin
-			 * would call make_origin if none is found in the
-			 * scoreboard), it does not know the blob_sha1/mode,
-			 * so copy it.  Otherwise porigin was in the
-			 * scoreboard and already knows blob_sha1/mode.
-			 */
-			if (porigin->refcnt =3D=3D 1) {
-				hashcpy(porigin->blob_sha1, cached->blob_sha1);
-				porigin->mode =3D cached->mode;
-			}
-			return porigin;
+			return origin_incref (porigin);
 		}
-		/* otherwise it was not very useful; free it */
-		free(parent->util);
-		parent->util =3D NULL;
-	}
=20
 	/* See if the origin->path is different between parent
 	 * and origin first.  Most of the time they are the
@@ -450,19 +602,6 @@ static struct origin *find_origin(struct scoreboar=
d *sb,
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
-		cached =3D make_origin(porigin->commit, porigin->path);
-		hashcpy(cached->blob_sha1, porigin->blob_sha1);
-		cached->mode =3D porigin->mode;
-		parent->util =3D cached;
-	}
 	return porigin;
 }
=20
@@ -509,46 +648,31 @@ static struct origin *find_rename(struct scoreboa=
rd *sb,
 }
=20
 /*
- * Link in a new blame entry to the scoreboard.  Entries that cover th=
e
- * same line range have been removed from the scoreboard previously.
+ * Append a new blame entry to a given output queue.
  */
-static void add_blame_entry(struct scoreboard *sb, struct blame_entry =
*e)
+static void add_blame_entry(struct blame_entry ***queue, struct blame_=
entry *e)
 {
-	struct blame_entry *ent, *prev =3D NULL;
-
 	origin_incref(e->suspect);
=20
-	for (ent =3D sb->ent; ent && ent->lno < e->lno; ent =3D ent->next)
-		prev =3D ent;
-
-	/* prev, if not NULL, is the last one that is below e */
-
-	if (prev) {
-		e->next =3D prev->next;
-		prev->next =3D e;
-	}
-	else {
-		e->next =3D sb->ent;
-		sb->ent =3D e;
-	}
+	e->next =3D **queue;
+	**queue =3D e;
+	*queue =3D &e->next;
 }
=20
 /*
  * src typically is on-stack; we want to copy the information in it to
- * a malloced blame_entry that is already on the linked list of the
- * scoreboard.  The origin of dst loses a refcnt while the origin of s=
rc
- * gains one.
+ * a malloced blame_entry that gets added to the given queue.  The
+ * origin of dst loses a refcnt.
  */
-static void dup_entry(struct blame_entry *dst, struct blame_entry *src=
)
+static void dup_entry(struct blame_entry ***queue,
+		      struct blame_entry *dst, struct blame_entry *src)
 {
-	struct blame_entry *n;
-
-	n =3D dst->next;
 	origin_incref(src->suspect);
 	origin_decref(dst->suspect);
 	memcpy(dst, src, sizeof(*src));
-	dst->next =3D n;
-	dst->score =3D 0;
+	dst->next =3D **queue;
+	**queue =3D dst;
+	*queue =3D &dst->next;
 }
=20
 static const char *nth_line(struct scoreboard *sb, long lno)
@@ -620,10 +744,11 @@ static void split_overlap(struct blame_entry *spl=
it,
=20
 /*
  * split_overlap() divided an existing blame e into up to three parts
- * in split.  Adjust the linked list of blames in the scoreboard to
+ * in split.  Any assigned blame is moved to queue to
  * reflect the split.
  */
-static void split_blame(struct scoreboard *sb,
+static void split_blame(struct blame_entry ***blamed,
+			struct blame_entry ***unblamed,
 			struct blame_entry *split,
 			struct blame_entry *e)
 {
@@ -631,61 +756,39 @@ static void split_blame(struct scoreboard *sb,
=20
 	if (split[0].suspect && split[2].suspect) {
 		/* The first part (reuse storage for the existing entry e) */
-		dup_entry(e, &split[0]);
+		dup_entry(unblamed, e, &split[0]);
=20
 		/* The last part -- me */
 		new_entry =3D xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
+		add_blame_entry(unblamed, new_entry);
=20
 		/* ... and the middle part -- parent */
 		new_entry =3D xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
+		add_blame_entry(blamed, new_entry);
 	}
 	else if (!split[0].suspect && !split[2].suspect)
 		/*
 		 * The parent covers the entire area; reuse storage for
 		 * e and replace it with the parent.
 		 */
-		dup_entry(e, &split[1]);
+		dup_entry(blamed, e, &split[1]);
 	else if (split[0].suspect) {
 		/* me and then parent */
-		dup_entry(e, &split[0]);
+		dup_entry(unblamed, e, &split[0]);
=20
 		new_entry =3D xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
+		add_blame_entry(blamed, new_entry);
 	}
 	else {
 		/* parent and then me */
-		dup_entry(e, &split[1]);
+		dup_entry(blamed, e, &split[1]);
=20
 		new_entry =3D xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
-	}
-
-	if (DEBUG) { /* sanity */
-		struct blame_entry *ent;
-		int lno =3D sb->ent->lno, corrupt =3D 0;
-
-		for (ent =3D sb->ent; ent; ent =3D ent->next) {
-			if (lno !=3D ent->lno)
-				corrupt =3D 1;
-			if (ent->s_lno < 0)
-				corrupt =3D 1;
-			lno +=3D ent->num_lines;
-		}
-		if (corrupt) {
-			lno =3D sb->ent->lno;
-			for (ent =3D sb->ent; ent; ent =3D ent->next) {
-				printf("L %8d l %8d n %8d\n",
-				       lno, ent->lno, ent->num_lines);
-				lno =3D ent->lno + ent->num_lines;
-			}
-			die("oops");
-		}
+		add_blame_entry(unblamed, new_entry);
 	}
 }
=20
@@ -702,74 +805,146 @@ static void decref_split(struct blame_entry *spl=
it)
 }
=20
 /*
- * Helper for blame_chunk().  blame_entry e is known to overlap with
- * the patch hunk; split it and pass blame to the parent.
+ * reverse_blame reverses the list given in head, appending tail.
+ * That allows us to build lists in reverse order, then reverse them
+ * afterwards.  This can be faster than building the list in proper
+ * order right away.  The reason is that building in proper order
+ * requires writing a link in the _previous_ element, while building
+ * in reverse order just requires placing the list head into the
+ * _current_ element.
  */
-static void blame_overlap(struct scoreboard *sb, struct blame_entry *e=
,
-			  int tlno, int plno, int same,
-			  struct origin *parent)
-{
-	struct blame_entry split[3];
-
-	split_overlap(split, e, tlno, plno, same, parent);
-	if (split[1].suspect)
-		split_blame(sb, split, e);
-	decref_split(split);
-}
=20
-/*
- * Find the line number of the last line the target is suspected for.
- */
-static int find_last_in_target(struct scoreboard *sb, struct origin *t=
arget)
+static struct blame_entry *reverse_blame(struct blame_entry *head,
+					 struct blame_entry *tail)
 {
-	struct blame_entry *e;
-	int last_in_target =3D -1;
-
-	for (e =3D sb->ent; e; e =3D e->next) {
-		if (e->guilty || e->suspect !=3D target)
-			continue;
-		if (last_in_target < e->s_lno + e->num_lines)
-			last_in_target =3D e->s_lno + e->num_lines;
+	while (head) {
+		struct blame_entry *next =3D head->next;
+		head->next =3D tail;
+		tail =3D head;
+		head =3D next;
 	}
-	return last_in_target;
+	return tail;
 }
=20
 /*
  * Process one hunk from the patch between the current suspect for
- * blame_entry e and its parent.  Find and split the overlap, and
- * pass blame to the overlapping part to the parent.
+ * blame_entry e and its parent.  This first blames any unfinished
+ * entries before the chunk (which is where target and parent start
+ * differing) on the parent, and then splits blame entries at the
+ * start and at the end of the difference region.  Since use of -M and
+ * -C options may lead to overlapping/duplicate source line number
+ * ranges, all we can rely on from sorting/merging is the order of the
+ * first suspect line number.
  */
-static void blame_chunk(struct scoreboard *sb,
-			int tlno, int plno, int same,
-			struct origin *target, struct origin *parent)
+static void blame_chunk(struct blame_entry ***dstq, struct blame_entry=
 ***srcq,
+			int tlno, int offset, int same,
+			struct origin *parent)
 {
-	struct blame_entry *e;
+	struct blame_entry *e =3D **srcq;
+	struct blame_entry *samep =3D NULL, *diffp =3D NULL;
=20
-	for (e =3D sb->ent; e; e =3D e->next) {
-		if (e->guilty || e->suspect !=3D target)
-			continue;
-		if (same <=3D e->s_lno)
-			continue;
-		if (tlno < e->s_lno + e->num_lines)
-			blame_overlap(sb, e, tlno, plno, same, parent);
+	while (e && e->s_lno < tlno) {
+		struct blame_entry *next =3D e->next;
+		/*
+		 * current record starts before differing portion.  If
+		 * it reaches into it, we need to split it up and
+		 * examine the second part separately.
+		 */
+		if (e->s_lno + e->num_lines > tlno) {
+			/* Move second half to a new record */
+			int len =3D tlno - e->s_lno;
+			struct blame_entry *n =3D xcalloc(1, sizeof (struct blame_entry));
+			n->suspect =3D e->suspect;
+			n->lno =3D e->lno + len;
+			n->s_lno =3D e->s_lno + len;
+			n->num_lines =3D e->num_lines - len;
+			e->num_lines =3D len;
+			e->score =3D 0;
+			/* Push new record to diffp */
+			n->next =3D diffp;
+			diffp =3D n;
+		} else
+			origin_decref(e->suspect);
+		/* Pass blame for everything before the differing
+		 * chunk to the parent */
+		e->suspect =3D origin_incref(parent);
+		e->s_lno +=3D offset;
+		e->next =3D samep;
+		samep =3D e;
+		e =3D next;
+	}
+	/*
+	 * As we don't know how much of a common stretch after this
+	 * diff will occur, the currently blamed parts are all that we
+	 * can assign to the parent for now.
+	 */
+
+	if (samep) {
+		**dstq =3D reverse_blame(samep, **dstq);
+		*dstq =3D &samep->next;
 	}
+	/*
+	 * Prepend the split off portions: everything after e starts
+	 * after the blameable portion.
+	 */
+	e =3D reverse_blame(diffp, e);
+
+	/*
+	 * Now retain records on the target while parts are different
+	 * from the parent.
+	 */
+	samep =3D NULL;
+	diffp =3D NULL;
+	while (e && e->s_lno < same) {
+		struct blame_entry *next =3D e->next;
+
+		/*
+		 * If current record extends into sameness, need to split.
+		 */
+		if (e->s_lno + e->num_lines > same) {
+			/*
+			 * Move second half to a new record to be
+			 * processed by later chunks
+			 */
+			int len =3D same - e->s_lno;
+			struct blame_entry *n =3D xcalloc(1, sizeof (struct blame_entry));
+			n->suspect =3D origin_incref(e->suspect);
+			n->lno =3D e->lno + len;
+			n->s_lno =3D e->s_lno + len;
+			n->num_lines =3D e->num_lines - len;
+			e->num_lines =3D len;
+			e->score =3D 0;
+			/* Push new record to samep */
+			n->next =3D samep;
+			samep =3D n;
+		}
+		e->next =3D diffp;
+		diffp =3D e;
+		e =3D next;
+	}
+	**srcq =3D reverse_blame(diffp, reverse_blame(samep, e));
+	/* Move across elements that are in the unblamable portion */
+	if (diffp)
+		*srcq =3D &diffp->next;
 }
=20
 struct blame_chunk_cb_data {
-	struct scoreboard *sb;
-	struct origin *target;
 	struct origin *parent;
-	long plno;
-	long tlno;
+	long offset;
+	struct blame_entry **dstq;
+	struct blame_entry **srcq;
 };
=20
+/* diff chunks are from parent to target */
 static int blame_chunk_cb(long start_a, long count_a,
 			  long start_b, long count_b, void *data)
 {
 	struct blame_chunk_cb_data *d =3D data;
-	blame_chunk(d->sb, d->tlno, d->plno, start_b, d->target, d->parent);
-	d->plno =3D start_a + count_a;
-	d->tlno =3D start_b + count_b;
+	if (start_a - start_b !=3D d->offset)
+		die("internal error in blame::blame_chunk_cb");
+	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
+		    start_b + count_b, d->parent);
+	d->offset =3D start_a + count_a - (start_b + count_b);
 	return 0;
 }
=20
@@ -778,29 +953,32 @@ static int blame_chunk_cb(long start_a, long coun=
t_a,
  * for the lines it is suspected to its parent.  Run diff to find
  * which lines came from parent and pass blame for them.
  */
-static int pass_blame_to_parent(struct scoreboard *sb,
-				struct origin *target,
-				struct origin *parent)
+static void pass_blame_to_parent(struct scoreboard *sb,
+				 struct origin *target,
+				 struct origin *parent)
 {
-	int last_in_target;
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
+	struct blame_entry *newdest =3D NULL;
=20
-	memset(&d, 0, sizeof(d));
-	d.sb =3D sb; d.target =3D target; d.parent =3D parent;
-	last_in_target =3D find_last_in_target(sb, target);
-	if (last_in_target < 0)
-		return 1; /* nothing remains for this target */
+	if (!target->suspects)
+		return; /* nothing remains for this target */
+
+	d.parent =3D parent;
+	d.offset =3D 0;
+	d.dstq =3D &newdest; d.srcq =3D &target->suspects;
=20
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
 	num_get_patch++;
=20
 	diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d);
-	/* The rest (i.e. anything after tlno) are the same as the parent */
-	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
+	/* The rest are the same as the parent */
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
+	*d.dstq =3D NULL;
+	queue_blames(sb, parent, newdest);
=20
-	return 0;
+	return;
 }
=20
 /*
@@ -945,43 +1123,80 @@ static void find_copy_in_blob(struct scoreboard =
*sb,
 	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
=20
+/* Move all blame entries from list *source that have a score smaller
+ * than score_min to the front of list *small.
+ * Returns a pointer to the link pointing to the old head of the small=
 list.
+ */
+
+static struct blame_entry **filter_small(struct scoreboard *sb,
+					 struct blame_entry **small,
+					 struct blame_entry **source,
+					 unsigned score_min)
+{
+	struct blame_entry *p =3D *source;
+	struct blame_entry *oldsmall =3D *small;
+	while (p) {
+		if (ent_score(sb, p) <=3D score_min) {
+			*small =3D p;
+			small =3D &p->next;
+			p =3D *small;
+		} else {
+			*source =3D p;
+			source =3D &p->next;
+			p =3D *source;
+		}
+	}
+	*small =3D oldsmall;
+	*source =3D NULL;
+	return small;
+}
+
 /*
  * See if lines currently target is suspected for can be attributed to
  * parent.
  */
-static int find_move_in_parent(struct scoreboard *sb,
-			       struct origin *target,
-			       struct origin *parent)
+static void find_move_in_parent(struct scoreboard *sb,
+				struct blame_entry ***blamed,
+				struct blame_entry **toosmall,
+				struct origin *target,
+				struct origin *parent)
 {
-	int last_in_target, made_progress;
 	struct blame_entry *e, split[3];
+	struct blame_entry *unblamed =3D target->suspects;
+	struct blame_entry *leftover =3D NULL;
 	mmfile_t file_p;
=20
-	last_in_target =3D find_last_in_target(sb, target);
-	if (last_in_target < 0)
-		return 1; /* nothing remains for this target */
+	if (!unblamed)
+		return; /* nothing remains for this target */
=20
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
 	if (!file_p.ptr)
-		return 0;
+		return;
=20
-	made_progress =3D 1;
-	while (made_progress) {
-		made_progress =3D 0;
-		for (e =3D sb->ent; e; e =3D e->next) {
-			if (e->guilty || e->suspect !=3D target ||
-			    ent_score(sb, e) < blame_move_score)
-				continue;
+	/* At each iteration, unblamed has a NULL-terminated list of
+	 * entries that have not yet been tested for blame.  leftover
+	 * contains the reversed list of entries that have been tested
+	 * without being assignable to the parent.
+	 */
+	do {
+		struct blame_entry **unblamedtail =3D &unblamed;
+		struct blame_entry *next;
+		for (e =3D unblamed; e; e =3D next) {
+			next =3D e->next;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
 			    blame_move_score < ent_score(sb, &split[1])) {
-				split_blame(sb, split, e);
-				made_progress =3D 1;
+				split_blame(blamed, &unblamedtail, split, e);
+			} else {
+				e->next =3D leftover;
+				leftover =3D e;
 			}
 			decref_split(split);
 		}
-	}
-	return 0;
+		*unblamedtail =3D NULL;
+		toosmall =3D filter_small(sb, toosmall, &unblamed, blame_move_score)=
;
+	} while (unblamed);
+	target->suspects =3D reverse_blame(leftover, NULL);
 }
=20
 struct blame_list {
@@ -993,62 +1208,46 @@ struct blame_list {
  * Count the number of entries the target is suspected for,
  * and prepare a list of entry and the best split.
  */
-static struct blame_list *setup_blame_list(struct scoreboard *sb,
-					   struct origin *target,
-					   int min_score,
+static struct blame_list *setup_blame_list(struct blame_entry *unblame=
d,
 					   int *num_ents_p)
 {
 	struct blame_entry *e;
 	int num_ents, i;
 	struct blame_list *blame_list =3D NULL;
=20
-	for (e =3D sb->ent, num_ents =3D 0; e; e =3D e->next)
-		if (!e->scanned && !e->guilty &&
-		    e->suspect =3D=3D target &&
-		    min_score < ent_score(sb, e))
-			num_ents++;
+	for (e =3D unblamed, num_ents =3D 0; e; e =3D e->next)
+		num_ents++;
 	if (num_ents) {
 		blame_list =3D xcalloc(num_ents, sizeof(struct blame_list));
-		for (e =3D sb->ent, i =3D 0; e; e =3D e->next)
-			if (!e->scanned && !e->guilty &&
-			    e->suspect =3D=3D target &&
-			    min_score < ent_score(sb, e))
-				blame_list[i++].ent =3D e;
+		for (e =3D unblamed, i =3D 0; e; e =3D e->next)
+			blame_list[i++].ent =3D e;
 	}
 	*num_ents_p =3D num_ents;
 	return blame_list;
 }
=20
 /*
- * Reset the scanned status on all entries.
- */
-static void reset_scanned_flag(struct scoreboard *sb)
-{
-	struct blame_entry *e;
-	for (e =3D sb->ent; e; e =3D e->next)
-		e->scanned =3D 0;
-}
-
-/*
  * For lines target is suspected for, see if we can find code movement
  * across file boundary from the parent commit.  porigin is the path
  * in the parent we already tried.
  */
-static int find_copy_in_parent(struct scoreboard *sb,
-			       struct origin *target,
-			       struct commit *parent,
-			       struct origin *porigin,
-			       int opt)
+static void find_copy_in_parent(struct scoreboard *sb,
+				struct blame_entry ***blamed,
+				struct blame_entry **toosmall,
+				struct origin *target,
+				struct commit *parent,
+				struct origin *porigin,
+				int opt)
 {
 	struct diff_options diff_opts;
 	int i, j;
-	int retval;
 	struct blame_list *blame_list;
 	int num_ents;
+	struct blame_entry *unblamed =3D target->suspects;
+	struct blame_entry *leftover =3D NULL;
=20
-	blame_list =3D setup_blame_list(sb, target, blame_copy_score, &num_en=
ts);
-	if (!blame_list)
-		return 1; /* nothing remains for this target */
+	if (!unblamed)
+		return; /* nothing remains for this target */
=20
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
@@ -1078,9 +1277,9 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
 		diffcore_std(&diff_opts);
=20
-	retval =3D 0;
-	while (1) {
-		int made_progress =3D 0;
+	do {
+		struct blame_entry **unblamedtail =3D &unblamed;
+		blame_list =3D setup_blame_list(unblamed, &num_ents);
=20
 		for (i =3D 0; i < diff_queued_diff.nr; i++) {
 			struct diff_filepair *p =3D diff_queued_diff.queue[i];
@@ -1117,27 +1316,21 @@ static int find_copy_in_parent(struct scoreboar=
d *sb,
 			struct blame_entry *split =3D blame_list[j].split;
 			if (split[1].suspect &&
 			    blame_copy_score < ent_score(sb, &split[1])) {
-				split_blame(sb, split, blame_list[j].ent);
-				made_progress =3D 1;
+				split_blame(blamed, &unblamedtail, split,
+					    blame_list[j].ent);
+			} else {
+				blame_list[j].ent->next =3D leftover;
+				leftover =3D blame_list[j].ent;
 			}
-			else
-				blame_list[j].ent->scanned =3D 1;
 			decref_split(split);
 		}
 		free(blame_list);
-
-		if (!made_progress)
-			break;
-		blame_list =3D setup_blame_list(sb, target, blame_copy_score, &num_e=
nts);
-		if (!blame_list) {
-			retval =3D 1;
-			break;
-		}
-	}
-	reset_scanned_flag(sb);
+		*unblamedtail =3D NULL;
+		toosmall =3D filter_small(sb, toosmall, &unblamed, blame_copy_score)=
;
+	} while (unblamed);
+	target->suspects =3D reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
 	free_pathspec(&diff_opts.pathspec);
-	return retval;
 }
=20
 /*
@@ -1147,20 +1340,21 @@ static int find_copy_in_parent(struct scoreboar=
d *sb,
 static void pass_whole_blame(struct scoreboard *sb,
 			     struct origin *origin, struct origin *porigin)
 {
-	struct blame_entry *e;
+	struct blame_entry *e, *suspects;
=20
 	if (!porigin->file.ptr && origin->file.ptr) {
 		/* Steal its file */
 		porigin->file =3D origin->file;
 		origin->file.ptr =3D NULL;
 	}
-	for (e =3D sb->ent; e; e =3D e->next) {
-		if (e->suspect !=3D origin)
-			continue;
+	suspects =3D origin->suspects;
+	origin->suspects =3D NULL;
+	for (e =3D suspects; e; e =3D e->next) {
 		origin_incref(porigin);
 		origin_decref(e->suspect);
 		e->suspect =3D porigin;
 	}
+	queue_blames(sb, porigin, suspects);
 }
=20
 /*
@@ -1184,6 +1378,27 @@ static int num_scapegoats(struct rev_info *revs,=
 struct commit *commit)
 	return cnt;
 }
=20
+/* Distribute collected unsorted blames to the respected sorted lists
+ * in the various origins.
+ */
+static void distribute_blame(struct scoreboard *sb, struct blame_entry=
 *blamed)
+{
+	blamed =3D blame_sort(blamed, compare_blame_suspect);
+	while (blamed)
+	{
+		struct origin *porigin =3D blamed->suspect;
+		struct blame_entry *suspects =3D NULL;
+		do {
+			struct blame_entry *next =3D blamed->next;
+			blamed->next =3D suspects;
+			suspects =3D blamed;
+			blamed =3D next;
+		} while (blamed && blamed->suspect =3D=3D porigin);
+		suspects =3D reverse_blame(suspects, NULL);
+		queue_blames(sb, porigin, suspects);
+	}
+}
+
 #define MAXSG 16
=20
 static void pass_blame(struct scoreboard *sb, struct origin *origin, i=
nt opt)
@@ -1194,6 +1409,8 @@ static void pass_blame(struct scoreboard *sb, str=
uct origin *origin, int opt)
 	struct commit_list *sg;
 	struct origin *sg_buf[MAXSG];
 	struct origin *porigin, **sg_origin =3D sg_buf;
+	struct blame_entry *toosmall =3D NULL;
+	struct blame_entry *blames, **blametail =3D &blames;
=20
 	num_sg =3D num_scapegoats(revs, commit);
 	if (!num_sg)
@@ -1255,38 +1472,71 @@ static void pass_blame(struct scoreboard *sb, s=
truct origin *origin, int opt)
 			origin_incref(porigin);
 			origin->previous =3D porigin;
 		}
-		if (pass_blame_to_parent(sb, origin, porigin))
+		pass_blame_to_parent(sb, origin, porigin);
+		if (!origin->suspects)
 			goto finish;
 	}
=20
 	/*
 	 * Optionally find moves in parents' files.
 	 */
-	if (opt & PICKAXE_BLAME_MOVE)
-		for (i =3D 0, sg =3D first_scapegoat(revs, commit);
-		     i < num_sg && sg;
-		     sg =3D sg->next, i++) {
-			struct origin *porigin =3D sg_origin[i];
-			if (!porigin)
-				continue;
-			if (find_move_in_parent(sb, origin, porigin))
-				goto finish;
+	if (opt & PICKAXE_BLAME_MOVE) {
+		filter_small(sb, &toosmall, &origin->suspects, blame_move_score);
+		if (origin->suspects) {
+			for (i =3D 0, sg =3D first_scapegoat(revs, commit);
+			     i < num_sg && sg;
+			     sg =3D sg->next, i++) {
+				struct origin *porigin =3D sg_origin[i];
+				if (!porigin)
+					continue;
+				find_move_in_parent(sb, &blametail, &toosmall, origin, porigin);
+				if (!origin->suspects)
+					break;
+			}
 		}
+	}
=20
 	/*
 	 * Optionally find copies from parents' files.
 	 */
-	if (opt & PICKAXE_BLAME_COPY)
+	if (opt & PICKAXE_BLAME_COPY) {
+		if (blame_copy_score > blame_move_score)
+			filter_small(sb, &toosmall, &origin->suspects, blame_copy_score);
+		else if (blame_copy_score < blame_move_score) {
+			origin->suspects =3D blame_merge(origin->suspects, toosmall);
+			toosmall =3D NULL;
+			filter_small(sb, &toosmall, &origin->suspects, blame_copy_score);
+		}
+		if (!origin->suspects)
+			goto finish;
+
 		for (i =3D 0, sg =3D first_scapegoat(revs, commit);
 		     i < num_sg && sg;
 		     sg =3D sg->next, i++) {
 			struct origin *porigin =3D sg_origin[i];
-			if (find_copy_in_parent(sb, origin, sg->item,
-						porigin, opt))
+			find_copy_in_parent(sb, &blametail, &toosmall,
+					    origin, sg->item, porigin, opt);
+			if (!origin->suspects)
 				goto finish;
 		}
+	}
=20
- finish:
+finish:
+	*blametail =3D NULL;
+	distribute_blame(sb, blames);
+	/*
+	 * prepend toosmall to origin->suspects
+	 *
+	 * There is no point in sorting: this ends up on a big
+	 * unsorted list in the caller anyway.
+	 */
+	if (toosmall) {
+		struct blame_entry **tail =3D &toosmall;
+		while (*tail)
+			tail =3D &(*tail)->next;
+		*tail =3D origin->suspects;
+		origin->suspects =3D toosmall;
+	}
 	for (i =3D 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
 			drop_origin_blob(sg_origin[i]);
@@ -1481,14 +1731,11 @@ static int emit_one_suspect_detail(struct origi=
n *suspect, int repeat)
 }
=20
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
-	ent->guilty =3D 1;
 	if (incremental) {
 		struct origin *suspect =3D ent->suspect;
=20
@@ -1502,32 +1749,34 @@ static void found_guilty_entry(struct blame_ent=
ry *ent)
 }
=20
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
 	struct rev_info *revs =3D sb->revs;
+	struct commit *commit =3D prio_queue_get(&sb->commits);
=20
-	while (1) {
+	while (commit) {
 		struct blame_entry *ent;
-		struct commit *commit;
-		struct origin *suspect =3D NULL;
+		struct origin *suspect =3D commit->util;
=20
 		/* find one suspect to break down */
-		for (ent =3D sb->ent; !suspect && ent; ent =3D ent->next)
-			if (!ent->guilty)
-				suspect =3D ent->suspect;
-		if (!suspect)
-			return; /* all done */
+		while (suspect && !suspect->suspects)
+			suspect =3D suspect->next;
+
+		if (!suspect) {
+			commit =3D prio_queue_get(&sb->commits);
+			continue;
+		}
+
+		assert(commit =3D=3D suspect->commit);
=20
 		/*
 		 * We will use this suspect later in the loop,
 		 * so hold onto it in the meantime.
 		 */
 		origin_incref(suspect);
-		commit =3D suspect->commit;
 		parse_commit(commit);
 		if (reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
@@ -1543,9 +1792,22 @@ static void assign_blame(struct scoreboard *sb, =
int opt)
 			commit->object.flags |=3D UNINTERESTING;
=20
 		/* Take responsibility for the remaining entries */
-		for (ent =3D sb->ent; ent; ent =3D ent->next)
-			if (ent->suspect =3D=3D suspect)
+		ent =3D suspect->suspects;
+		if (ent) {
+			suspect->guilty =3D 1;
+			for (;;) {
+				struct blame_entry *next =3D ent->next;
 				found_guilty_entry(ent);
+				if (next) {
+					ent =3D next;
+					continue;
+				}
+				ent->next =3D sb->ent;
+				sb->ent =3D suspect->suspects;
+				suspect->suspects =3D NULL;
+				break;
+			}
+		}
 		origin_decref(suspect);
=20
 		if (DEBUG) /* sanity */
@@ -1602,9 +1864,8 @@ static void emit_porcelain(struct scoreboard *sb,=
 struct blame_entry *ent,
 	char hex[41];
=20
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
-	printf("%s%c%d %d %d\n",
+	printf("%s %d %d %d\n",
 	       hex,
-	       ent->guilty ? ' ' : '*', /* purely for debugging */
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
@@ -1717,17 +1978,16 @@ static void output(struct scoreboard *sb, int o=
ption)
=20
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent =3D sb->ent; ent; ent =3D ent->next) {
-			struct blame_entry *oth;
-			struct origin *suspect =3D ent->suspect;
-			struct commit *commit =3D suspect->commit;
+			int count =3D 0;
+			struct origin *suspect;
+			struct commit *commit =3D ent->suspect->commit;
 			if (commit->object.flags & MORE_THAN_ONE_PATH)
 				continue;
-			for (oth =3D ent->next; oth; oth =3D oth->next) {
-				if ((oth->suspect->commit !=3D commit) ||
-				    !strcmp(oth->suspect->path, suspect->path))
-					continue;
-				commit->object.flags |=3D MORE_THAN_ONE_PATH;
-				break;
+			for (suspect =3D commit->util; suspect; suspect =3D suspect->next) =
{
+				if (suspect->guilty && count++) {
+					commit->object.flags |=3D MORE_THAN_ONE_PATH;
+					break;
+				}
 			}
 		}
 	}
@@ -2092,7 +2352,6 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
-	commit->util =3D origin;
=20
 	/*
 	 * Read the current index, replace the path entry with
@@ -2403,12 +2662,16 @@ parse_done:
 	memset(&sb, 0, sizeof(sb));
=20
 	sb.revs =3D &revs;
-	if (!reverse)
+	if (!reverse) {
 		final_commit_name =3D prepare_final(&sb);
+		sb.commits.compare =3D compare_commits_by_commit_date;
+	}
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
-	else
+	else {
 		final_commit_name =3D prepare_initial(&sb);
+		sb.commits.compare =3D compare_commits_by_reverse_commit_date;
+	}
=20
 	if (!sb.final) {
 		/*
@@ -2497,12 +2760,16 @@ parse_done:
 		ent->next =3D next;
 		origin_incref(o);
 	}
+
+	o->suspects =3D ent;
+	prio_queue_put(&sb.commits, o->commit);
+
 	origin_decref(o);
=20
 	range_set_release(&ranges);
 	string_list_clear(&range_list, 0);
=20
-	sb.ent =3D ent;
+	sb.ent =3D NULL;
 	sb.path =3D path;
=20
 	read_mailmap(&mailmap, NULL);
@@ -2515,6 +2782,8 @@ parse_done:
 	if (incremental)
 		return 0;
=20
+	sb.ent =3D blame_sort(sb.ent, compare_blame_final);
+
 	coalesce(&sb);
=20
 	if (!(output_option & OUTPUT_PORCELAIN))
--=20
1.9.1
