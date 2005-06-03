From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] diff: Update -B heuristics.
Date: Fri, 03 Jun 2005 01:40:28 -0700
Message-ID: <7vpsv3omtf.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
	<7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
	<7vis0wusv5.fsf@assigned-by-dhcp.cox.net>
	<7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:39:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De7h1-0007wO-HH
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 10:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFCIlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 04:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVFCIlY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 04:41:24 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54002 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261183AbVFCIka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 04:40:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603084028.FANU550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 04:40:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 03 Jun 2005 01:32:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As Linus pointed out on the mailing list discussion, -B should
break a files that has many inserts even if it still keeps
enough of the original contents, so that the broken pieces can
later be matched with other files by -M or -C.  However, if such
a broken pair does not get picked up by -M or -C, we would want
to apply different criteria; namely, regardless of the amount of
new material in the result, the determination of "rewrite"
should be done by looking at the amount of original material
still left in the result.  If you still have the original 97
lines from a 100-line document, it does not matter if you add
your own 13 lines to make a 110-line document, or if you add 903
lines to make a 1000-line document.  It is not a rewrite but an
in-place edit.  On the other hand, if you did lose 97 lines from
the original, it does not matter if you added 27 lines to make a
30-line document or if you added 997 lines to make a 1000-line
document.  You did a complete rewrite in either case.

This patch introduces a post-processing phase that runs after
diffcore-rename matches up broken pairs diffcore-break creates.
The purpose of this post-processing is to pick up these broken
pieces and merge them back into in-place modifications.  For
this, the score parameter -B option takes is changed into a pair
of numbers, and it takes "-B99/80" format when fully spelled
out.  The first number is the minimum amount of "edit" (same
definition as what diffcore-rename uses, which is "sum of
deletion and insertion") that a modification needs to have to be
broken, and the second number is the minimum amount of "delete"
a surviving broken pair must have to avoid being merged back
together.  It can be abbreviated to "-B" to use default for
both, "-B9" or "-B9/" to use 90% for "edit" but default (80%)
for merge avoidance, or "-B/75" to use default (99%) "edit" and
75% for merge avoidance.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diffcore.h       |   11 ++
 diff.c           |   18 ++++
 diffcore-break.c |  240 +++++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 225 insertions(+), 44 deletions(-)

diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -8,9 +8,19 @@
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
  */
+
+/* We internally use unsigned short as the score value,
+ * and rely on an int capable to hold 32-bits.  -B can take
+ * -Bmerge_score/break_score format and the two scores are
+ * passed around in one int (high 16-bit for merge and low 16-bit
+ * for break).
+ */
 #define MAX_SCORE 60000
 #define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
 #define DEFAULT_BREAK_SCORE  59400 /* minimum for break to happen (99%)*/
+#define DEFAULT_MERGE_SCORE  48000 /* maximum for break-merge to happen (80%)*/
+
+#define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
 struct diff_filespec {
 	unsigned char sha1[20];
@@ -76,6 +86,7 @@ extern void diff_q(struct diff_queue_str
 extern void diffcore_pathspec(const char **pathspec);
 extern void diffcore_break(int);
 extern void diffcore_rename(int rename_copy, int);
+extern void diffcore_merge_broken(void);
 extern void diffcore_pickaxe(const char *needle, int opts);
 extern void diffcore_order(const char *orderfile);
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -614,7 +614,7 @@ static int parse_num(const char **cp_p)
 
 int diff_scoreopt_parse(const char *opt)
 {
-	int opt1, cmd;
+	int opt1, opt2, cmd;
 
 	if (*opt++ != '-')
 		return -1;
@@ -623,9 +623,21 @@ int diff_scoreopt_parse(const char *opt)
 		return -1; /* that is not a -M, -C nor -B option */
 
 	opt1 = parse_num(&opt);
+	if (cmd != 'B')
+		opt2 = 0;
+	else {
+		if (*opt == 0)
+			opt2 = 0;
+		else if (*opt != '/')
+			return -1; /* we expect -B80/99 or -B80 */
+		else {
+			opt++;
+			opt2 = parse_num(&opt);
+		}
+	}
 	if (*opt != 0)
 		return -1;
-	return opt1;
+	return opt1 | (opt2 << 16);
 }
 
 struct diff_queue_struct diff_queued_diff;
@@ -955,6 +967,8 @@ void diffcore_std(const char **paths,
 		diffcore_break(break_opt);
 	if (detect_rename)
 		diffcore_rename(detect_rename, rename_score);
+	if (0 <= break_opt)
+		diffcore_merge_broken();
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (orderfile)
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -7,28 +7,58 @@
 #include "delta.h"
 #include "count-delta.h"
 
-static int very_different(struct diff_filespec *src,
-			  struct diff_filespec *dst,
-			  int min_score)
+static int should_break(struct diff_filespec *src,
+			struct diff_filespec *dst,
+			int break_score,
+			int *merge_score_p)
 {
 	/* dst is recorded as a modification of src.  Are they so
 	 * different that we are better off recording this as a pair
-	 * of delete and create?  min_score is the minimum amount of
-	 * new material that must exist in the dst and not in src for
-	 * the pair to be considered a complete rewrite, and recommended
-	 * to be set to a very high value, 99% or so.
-	 *
-	 * The value we return represents the amount of new material
-	 * that is in dst and not in src.  We return 0 when we do not
-	 * want to get the filepair broken.
+	 * of delete and create?
+	 *
+	 * There are two criteria used in this algorithm.  For the
+	 * purposes of helping later rename/copy, we take both delete
+	 * and insert into account and estimate the amount of "edit".
+	 * If the edit is very large, we break this pair so that
+	 * rename/copy can pick the pieces up to match with other
+	 * files.
+	 *
+	 * On the other hand, we would want to ignore inserts for the
+	 * pure "complete rewrite" detection.  As long as most of the
+	 * existing contents were removed from the file, it is a
+	 * complete rewrite, and if sizable chunk from the original
+	 * still remains in the result, it is not a rewrite.  It does
+	 * not matter how much or how little new material is added to
+	 * the file.
+	 *
+	 * The score we leave for such a broken filepair uses the
+	 * latter definition so that later clean-up stage can find the
+	 * pieces that should not have been broken according to the
+	 * latter definition after rename/copy runs, and merge the
+	 * broken pair that have a score lower than given criteria
+	 * back together.  The break operation itself happens
+	 * according to the former definition.
+	 *
+	 * The minimum_edit parameter tells us when to break (the
+	 * amount of "edit" required for us to consider breaking the
+	 * pair).  We leave the amount of deletion in *merge_score_p
+	 * when we return.
+	 *
+	 * The value we return is 1 if we want the pair to be broken,
+	 * or 0 if we do not.
 	 */
 	void *delta;
 	unsigned long delta_size, base_size, src_copied, literal_added;
+	int to_break = 0;
+
+	*merge_score_p = 0; /* assume no deletion --- "do not break"
+			     * is the default.
+			     */
 
 	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
 		return 0; /* leave symlink rename alone */
 
-	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */
 
 	delta_size = ((src->size < dst->size) ?
@@ -40,53 +70,95 @@ static int very_different(struct diff_fi
 	 */
 	base_size = ((src->size < dst->size) ? dst->size : src->size);
 
-	/*
-	 * If file size difference is too big compared to the
-	 * base_size, we declare this a complete rewrite.
-	 */
-	if (base_size * min_score < delta_size * MAX_SCORE)
-		return MAX_SCORE;
-
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
-		return 0; /* error but caught downstream */
-
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
 			   &delta_size);
 
-	/* A delta that has a lot of literal additions would have
-	 * big delta_size no matter what else it does.
-	 */
-	if (base_size * min_score < delta_size * MAX_SCORE)
-		return MAX_SCORE;
-
 	/* Estimate the edit size by interpreting delta. */
-	if (count_delta(delta, delta_size, &src_copied, &literal_added)) {
+	if (count_delta(delta, delta_size,
+			&src_copied, &literal_added)) {
 		free(delta);
-		return 0;
+		return 0; /* we cannot tell */
 	}
 	free(delta);
 
-	/* Extent of damage */
-	if (src->size + literal_added < src_copied)
-		delta_size = 0;
+	/* Compute merge-score, which is "how much is removed
+	 * from the source material".  The clean-up stage will
+	 * merge the surviving pair together if the score is
+	 * less than the minimum, after rename/copy runs.
+	 */
+	if (src->size <= src_copied)
+		delta_size = 0; /* avoid wrapping around */
+	else
+		delta_size = src->size - src_copied;
+	*merge_score_p = delta_size * MAX_SCORE / src->size;
+	
+	/* Extent of damage, which counts both inserts and
+	 * deletes.
+	 */
+	if (src->size + literal_added <= src_copied)
+		delta_size = 0; /* avoid wrapping around */
 	else
 		delta_size = (src->size - src_copied) + literal_added;
+	
+	/* We break if the edit exceeds the minimum.
+	 * i.e. (break_score / MAX_SCORE < delta_size / base_size)
+	 */
+	if (break_score * base_size < delta_size * MAX_SCORE)
+		to_break = 1;
 
-	if (base_size < delta_size)
-		return MAX_SCORE;
-
-	return delta_size * MAX_SCORE / base_size; 
+	return to_break;
 }
 
-void diffcore_break(int min_score)
+void diffcore_break(int break_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
+
+	/* When the filepair has this much edit (insert and delete),
+	 * it is first considered to be a rewrite and broken into a
+	 * create and delete filepair.  This is to help breaking a
+	 * file that had too much new stuff added, possibly from
+	 * moving contents from another file, so that rename/copy can
+	 * match it with the other file.
+	 *
+	 * int break_score; we reuse incoming parameter for this.
+	 */
+
+	/* After a pair is broken according to break_score and
+	 * subjected to rename/copy, both of them may survive intact,
+	 * due to lack of suitable rename/copy peer.  Or, the caller
+	 * may be calling us without using rename/copy.  When that
+	 * happens, we merge the broken pieces back into one
+	 * modification together if the pair did not have more than
+	 * this much delete.  For this computation, we do not take
+	 * insert into account at all.  If you start from a 100-line
+	 * file and delete 97 lines of it, it does not matter if you
+	 * add 27 lines to it to make a new 30-line file or if you add
+	 * 997 lines to it to make a 1000-line file.  Either way what
+	 * you did was a rewrite of 97%.  On the other hand, if you
+	 * delete 3 lines, keeping 97 lines intact, it does not matter
+	 * if you add 3 lines to it to make a new 100-line file or if
+	 * you add 903 lines to it to make a new 1000-line file.
+	 * Either way you did a lot of additions and not a rewrite.
+	 * This merge happens to catch the latter case.  A merge_score
+	 * of 80% would be a good default value (a broken pair that
+	 * has score lower than merge_score will be merged back
+	 * together).
+	 */
+	int merge_score;
 	int i;
 
-	if (!min_score)
-		min_score = DEFAULT_BREAK_SCORE;
+	/* See comment on DEFAULT_BREAK_SCORE and
+	 * DEFAULT_MERGE_SCORE in diffcore.h
+	 */
+	merge_score = (break_score >> 16) & 0xFFFF;
+	break_score = (break_score & 0xFFFF);
+
+	if (!break_score)
+		break_score = DEFAULT_BREAK_SCORE;
+	if (!merge_score)
+		merge_score = DEFAULT_MERGE_SCORE;
 
 	outq.nr = outq.alloc = 0;
 	outq.queue = NULL;
@@ -101,12 +173,22 @@ void diffcore_break(int min_score)
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two) &&
 		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
 		    !strcmp(p->one->path, p->two->path)) {
-			score = very_different(p->one, p->two, min_score);
-			if (min_score <= score) {
+			if (should_break(p->one, p->two,
+					 break_score, &score)) {
 				/* Split this into delete and create */
 				struct diff_filespec *null_one, *null_two;
 				struct diff_filepair *dp;
 
+				/* Set score to 0 for the pair that
+				 * needs to be merged back together
+				 * should they survive rename/copy.
+				 * Also we do not want to break very
+				 * small files.
+				 */
+				if ((score < merge_score) ||
+				    (p->one->size < MINIMUM_BREAK_SIZE))
+					score = 0;
+
 				/* deletion of one */
 				null_one = alloc_filespec(p->one->path);
 				dp = diff_queue(&outq, p->one, null_one);
@@ -132,3 +214,77 @@ void diffcore_break(int min_score)
 
 	return;
 }
+
+static void merge_broken(struct diff_filepair *p,
+			 struct diff_filepair *pp,
+			 struct diff_queue_struct *outq)
+{
+	/* p and pp are broken pairs we want to merge */
+	struct diff_filepair *c = p, *d = pp;
+	if (DIFF_FILE_VALID(p->one)) {
+		/* this must be a delete half */
+		d = p; c = pp;
+	}
+	/* Sanity check */
+	if (!DIFF_FILE_VALID(d->one))
+		die("internal error in merge #1");
+	if (DIFF_FILE_VALID(d->two))
+		die("internal error in merge #2");
+	if (DIFF_FILE_VALID(c->one))
+		die("internal error in merge #3");
+	if (!DIFF_FILE_VALID(c->two))
+		die("internal error in merge #4");
+
+	diff_queue(outq, d->one, c->two);
+	diff_free_filespec_data(d->two);
+	diff_free_filespec_data(c->one);
+	free(d);
+	free(c);
+}
+
+void diffcore_merge_broken(void)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	int i, j;
+
+	outq.nr = outq.alloc = 0;
+	outq.queue = NULL;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!p)
+			/* we already merged this with its peer */
+			continue;
+		else if (p->broken_pair &&
+			 p->score == 0 &&
+			 !strcmp(p->one->path, p->two->path)) {
+			/* If the peer also survived rename/copy, then
+			 * we merge them back together.
+			 */
+			for (j = i + 1; j < q->nr; j++) {
+				struct diff_filepair *pp = q->queue[j];
+				if (pp->broken_pair &&
+				    p->score == 0 &&
+				    !strcmp(pp->one->path, pp->two->path) &&
+				    !strcmp(p->one->path, pp->two->path)) {
+					/* Peer survived.  Merge them */
+					merge_broken(p, pp, &outq);
+					q->queue[j] = NULL;
+					break;
+				}
+			}
+			if (q->nr <= j)
+				/* The peer did not survive, so we keep
+				 * it in the output.
+				 */
+				diff_q(&outq, p);
+		}
+		else
+			diff_q(&outq, p);
+	}
+	free(q->queue);
+	*q = outq;
+
+	return;
+}
------------

