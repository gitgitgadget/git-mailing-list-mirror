From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Rename/copy detection fix.
Date: Sun, 22 May 2005 21:26:09 -0700
Message-ID: <7vd5ribmam.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
	<7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
	<7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 06:26:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da4Vh-0004A9-Gp
	for gcvg-git@gmane.org; Mon, 23 May 2005 06:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVEWE1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 00:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEWE1J
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 00:27:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63738 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261834AbVEWE0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 00:26:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523042611.COLS7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 00:26:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vy8a7cavf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 22 May 2005 12:35:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The rename/copy detection logic in earlier round was only good
enough to show patch output and discussion on the mailing list
about the diff-raw format updates revealed many problems with
it.  This patch fixes all the ones known to me, without making
things I want to do later impossible, mostly related to patch
reordering.

 (1) Earlier rename/copy detector determined which one is rename
     and which one is copy too early, which made it impossible
     to later introduce diffcore transformers to reorder
     patches.  This patch fixes it by moving that logic to the
     very end of the processing.

 (2) Earlier output routine diff_flush() was pruning all the
     "no-change" entries indiscriminatingly.  This was done due
     to my false assumption that one of the requirements in the
     diff-raw output was not to show such an entry (which
     resulted in my incorrect comment about "diff-helper never
     being able to be equivalent to built-in diff driver").  My
     special thanks go to Linus for correcting me about this.
     When we produce diff-raw output, for the downstream to be
     able to tell renames from copies, sometimes it _is_
     necessary to output "no-change" entries, and this patch
     adds diffcore_prune() function for doing it.

 (3) Earlier diff_filepair structure was trying to be not too
     specific about rename/copy operations, but the purpose of
     the structure was to record one or two paths, which _was_
     indeed about rename/copy.  This patch discards xfrm_msg
     field which was trying to be generic for this wrong reason,
     and introduces a couple of fields (rename_score and
     rename_rank) that are explicitly specific to rename/copy
     logic.  One thing to note is that the information in a
     single diff_filepair structure _still_ does not distinguish
     renames from copies, and it is deliberately so.  This is to
     allow patches to be reordered in later stages.

 (4) This patch also adds some tests about diff-raw format
     output and makes sure that necessary "no-change" entries
     appear on the output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c                   |  145 +++++++++++++++++++++++++++++++----------------
diffcore-pathspec.c      |    2 
diffcore-pickaxe.c       |    2 
diffcore-rename.c        |  112 +++++++++++-------------------------
diffcore.h               |   13 +++-
t/t4003-diff-rename-1.sh |   26 ++++----
t/t4005-diff-rename-2.sh |   82 ++++++++++++++++++++++++++
7 files changed, 244 insertions(+), 138 deletions(-)
new file (100644): t/t4005-diff-rename-2.sh

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -283,12 +283,6 @@ int diff_populate_filespec(struct diff_f
 	return 0;
 }
 
-void diff_free_filepair(struct diff_filepair *p)
-{
-	free(p->xfrm_msg);
-	free(p);
-}
-
 void diff_free_filespec_data(struct diff_filespec *s)
 {
 	if (s->should_free)
@@ -501,9 +495,9 @@ struct diff_filepair *diff_queue(struct 
 	struct diff_filepair *dp = xmalloc(sizeof(*dp));
 	dp->one = one;
 	dp->two = two;
-	dp->xfrm_msg = NULL;
+	dp->score = 0;
 	dp->orig_order = queue->nr;
-	dp->xfrm_work = 0;
+	dp->rename_rank = 0;
 	diff_q(queue, dp);
 	return dp;
 }
@@ -522,23 +516,7 @@ static void diff_flush_raw(struct diff_f
 	       p->two->path, line_termination);
 }
 
-static void diff_flush_patch(struct diff_filepair *p)
-{
-	const char *name, *other;
-
-	name = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
-	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
-	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */ 
-
-	if (DIFF_PAIR_UNMERGED(p))
-		run_external_diff(name, NULL, NULL, NULL, NULL);
-	else
-		run_external_diff(name, other, p->one, p->two, p->xfrm_msg);
-}
-
-static int uninteresting(struct diff_filepair *p)
+int diff_unmodified_pair(struct diff_filepair *p)
 {
 	/* This function is written stricter than necessary to support
 	 * the currently implemented transformers, but the idea is to
@@ -570,12 +548,70 @@ static int uninteresting(struct diff_fil
 	return 0;
 }
 
+static void diff_flush_patch(struct diff_filepair *p, const char *msg)
+{
+	const char *name, *other;
+
+	/* diffcore_prune() keeps "stay" entries for diff-raw
+	 * copy/rename detection, but when we are generating
+	 * patches we do not need them.
+	 */
+	if (diff_unmodified_pair(p))
+		return;
+
+	name = p->one->path;
+	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
+		return; /* no tree diffs in patch format */ 
+
+	if (DIFF_PAIR_UNMERGED(p))
+		run_external_diff(name, NULL, NULL, NULL, NULL);
+	else
+		run_external_diff(name, other, p->one, p->two, msg);
+}
+
+int diff_needs_to_stay(struct diff_queue_struct *q, int i,
+		       struct diff_filespec *it)
+{
+	/* If it will be used in later entry (either stay or used
+	 * as the source of rename/copy), we need to copy, not rename.
+	 */
+	while (i < q->nr) {
+		struct diff_filepair *p = q->queue[i++];
+		if (!DIFF_FILE_VALID(p->two))
+			continue; /* removed is fine */
+		if (strcmp(p->one->path, it->path))
+			continue; /* not relevant */
+
+		/* p has its src set to *it and it is not a delete;
+		 * it will be used for in-place change, rename/copy,
+		 * or just stays there.  We cannot rename it out.
+		 */
+		return 1;
+	}
+	return 0;
+}
+
+static int diff_used_as_source(struct diff_queue_struct *q, int lim,
+			       struct diff_filespec *it)
+{
+	int i;
+	for (i = 0; i < lim; i++) {
+		struct diff_filepair *p = q->queue[i++];
+		if (!strcmp(p->one->path, it->path))
+			return 1;
+	}
+	return 0;
+}
+
 void diffcore_prune(void)
 {
 	/*
 	 * Although rename/copy detection wants to have "no-change"
 	 * entries fed into them, the downstream do not need to see
-	 * them.  This function removes such entries.
+	 * them, unless we had rename/copy for the same path earlier.
+	 * This function removes such entries.
 	 *
 	 * The applications that use rename/copy should:
 	 *
@@ -585,6 +621,7 @@ void diffcore_prune(void)
 	 * (3) call diffcore_prune
 	 * (4) call other diffcore_xxx that do not need to see
 	 *     "no-change" entries.
+	 * (5) call diff_flush().
 	 */
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
@@ -595,22 +632,21 @@ void diffcore_prune(void)
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (!uninteresting(p))
+		if (!diff_unmodified_pair(p) ||
+		    diff_used_as_source(q, i, p->one))
 			diff_q(&outq, p);
 		else
-			diff_free_filepair(p);
+			free(p);
 	}
 	free(q->queue);
 	*q = outq;
 	return;
 }
 
-static void diff_flush_one(struct diff_filepair *p)
+static void diff_flush_one(struct diff_filepair *p, const char *msg)
 {
-	if (uninteresting(p))
-		return;
 	if (generate_patch)
-		diff_flush_patch(p);
+		diff_flush_patch(p, msg);
 	else
 		diff_flush_raw(p);
 }
@@ -618,14 +654,7 @@ static void diff_flush_one(struct diff_f
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
-
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		if (!uninteresting(p))
-			return 0;
-	}
-	return 1;
+	return q->nr == 0;
 }
 
 void diff_flush(int diff_output_style)
@@ -646,13 +675,35 @@ void diff_flush(int diff_output_style)
 		generate_patch = 1;
 		break;
 	}
-	for (i = 0; i < q->nr; i++)
-		diff_flush_one(q->queue[i]);
+	for (i = 0; i < q->nr; i++) {
+		char msg_[PATH_MAX*2+200], *msg = NULL;
+		struct diff_filepair *p = q->queue[i];
+		if (strcmp(p->one->path, p->two->path)) {
+			/* This is rename or copy.  Which one is it? */
+			if (diff_needs_to_stay(q, i+1, p->one)) {
+				sprintf(msg_,
+					"similarity index %d%%\n"
+					"copy from %s\n"
+					"copy to %s\n",
+					(int)(0.5 + p->score * 100/MAX_SCORE),
+					p->one->path, p->two->path);
+			}
+			else
+				sprintf(msg_,
+					"similarity index %d%%\n"
+					"rename old %s\n"
+					"rename new %s\n",
+					(int)(0.5 + p->score * 100/MAX_SCORE),
+					p->one->path, p->two->path);
+			msg = msg_;
+		}
+		diff_flush_one(p, msg);
+	}
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		diff_free_filespec_data(p->one);
 		diff_free_filespec_data(p->two);
-		free(p->xfrm_msg);
 		free(p);
 	}
 	free(q->queue);
@@ -674,10 +725,10 @@ void diff_addremove(int addremove, unsig
 	 * entries to the diff-core.  They will be prefixed
 	 * with something like '=' or '*' (I haven't decided
 	 * which but should not make any difference).
-	 * Feeding the same new and old to diff_change() should
-	 * also have the same effect.  diff_flush() should
-	 * filter uninteresting ones out at the final output
-	 * stage.
+	 * Feeding the same new and old to diff_change() 
+	 * also has the same effect.  diffcore_prune() should
+	 * be used to filter uninteresting ones out before the
+	 * final output happens.
 	 */
 	if (reverse_diff)
 		addremove = (addremove == '+' ? '-' :
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -55,7 +55,7 @@ void diffcore_pathspec(const char **path
 		    matches_pathspec(p->two->path, spec, speccnt))
 			diff_q(&outq, p);
 		else
-			diff_free_filepair(p);
+			free(p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -48,7 +48,7 @@ void diffcore_pickaxe(const char *needle
 			 contains(p->two, needle, len))
 			diff_q(&outq, p);
 		if (onum == outq.nr)
-			diff_free_filepair(p);
+			free(p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -119,27 +119,34 @@ static void record_rename_pair(struct di
 			       int rank,
 			       int score)
 {
-	/* The rank is used to sort the final output, because there
-	 * are certain dependencies.
+	/*
+	 * These ranks are used to sort the final output, because there
+	 * are certain dependencies:
 	 *
-	 *  - rank #0 depends on deleted ones.
-	 *  - rank #1 depends on kept files before they are modified.
-	 *  - rank #2 depends on kept files after they are modified;
-	 *    currently not used.
-	 *
-	 * Therefore, the final output order should be:
-	 *
-	 *  1. rank #0 rename/copy diffs.
+	 *  1. rename/copy that depends on deleted ones.
 	 *  2. deletions in the original.
-	 *  3. rank #1 rename/copy diffs.
-	 *  4. additions and modifications in the original.
-	 *  5. rank #2 rename/copy diffs; currently not used.
+	 *  3. rename/copy that depends on the pre-edit image of kept files.
+	 *  4. additions, modifications and no-modifications in the original.
+	 *  5. rename/copy that depends on the post-edit image of kept files
+	 *     (note that we currently do not detect such rename/copy).
 	 *
-	 * To achieve this sort order, we give xform_work the number
-	 * above.
+	 * The downstream diffcore transformers are free to reorder
+	 * the entries as long as they keep file pairs that has the
+	 * same p->one->path in earlier rename_rank to appear before
+	 * later ones.  This ordering is used by the diff_flush()
+	 * logic to tell renames from copies, and also used by the
+	 * diffcore_prune() logic to omit unnecessary
+	 * "no-modification" entries.
+	 *
+	 * To the final output routine, and in the diff-raw format
+	 * output, a rename/copy that is based on a path that has a
+	 * later entry that shares the same p->one->path and is not a
+	 * deletion is a copy.  Otherwise it is a rename.
 	 */
+
 	struct diff_filepair *dp = diff_queue(outq, src, dst);
-	dp->xfrm_work = (rank * 2 + 1) | (score<<RENAME_SCORE_SHIFT);
+	dp->rename_rank = rank * 2 + 1;
+	dp->score = score;
 	dst->xfrm_flags |= RENAME_DST_MATCHED;
 }
 
@@ -161,10 +168,8 @@ static void debug_filepair(const struct 
 {
 	debug_filespec(p->one, i, "one");
 	debug_filespec(p->two, i, "two");
-	fprintf(stderr, "pair flags %d, orig order %d, score %d\n",
-		(p->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1)),
-		p->orig_order,
-		(p->xfrm_work >> RENAME_SCORE_SHIFT));
+	fprintf(stderr, "pair rank %d, orig order %d, score %d\n",
+		p->rename_rank, p->orig_order, p->score);
 }
 
 static void debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -191,8 +196,8 @@ static int rank_compare(const void *a_, 
 {
 	const struct diff_filepair *a = *(const struct diff_filepair **)a_;
 	const struct diff_filepair *b = *(const struct diff_filepair **)b_;
-	int a_rank = a->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1);
-	int b_rank = b->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1);
+	int a_rank = a->rename_rank;
+	int b_rank = b->rename_rank;
 
 	if (a_rank != b_rank)
 		return a_rank - b_rank;
@@ -209,28 +214,6 @@ static int score_compare(const void *a_,
 	return b->score - a->score;
 }
 
-static int needs_to_stay(struct diff_queue_struct *q, int i,
-			 struct diff_filespec *it)
-{
-	/* If it will be used in later entry (either stay or used
-	 * as the source of rename/copy), we need to copy, not rename.
-	 */
-	while (i < q->nr) {
-		struct diff_filepair *p = q->queue[i++];
-		if (!DIFF_FILE_VALID(p->two))
-			continue; /* removed is fine */
-		if (strcmp(p->one->path, it->path))
-			continue; /* not relevant */
-
-		/* p has its src set to *it and it is not a delete;
-		 * it will be used for in-place change or rename/copy,
-		 * so we cannot rename it out.
-		 */
-		return 1;
-	}
-	return 0;
-}
-
 int diff_scoreopt_parse(const char *opt)
 {
 	int diglen, num, scale, i;
@@ -359,27 +342,24 @@ void diffcore_rename(int detect_rename, 
 	 * downstream, so we assign the sort keys in this loop.
 	 *
 	 * See comments at the top of record_rename_pair for numbers used
-	 * to assign xfrm_work.
-	 *
-	 * Note that we have not annotated the diff_filepair with any comment
-	 * so there is nothing other than p to free.
+	 * to assign rename_rank.
 	 */
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *dp, *p = q->queue[i];
 		if (!DIFF_FILE_VALID(p->one)) {
 			/* creation or unmerged entries */
 			dp = diff_queue(&outq, p->one, p->two);
-			dp->xfrm_work = 4;
+			dp->rename_rank = 4;
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			/* deletion */
 			dp = diff_queue(&outq, p->one, p->two);
-			dp->xfrm_work = 2;
+			dp->rename_rank = 2;
 		}
 		else {
 			/* modification, or stay as is */
 			dp = diff_queue(&outq, p->one, p->two);
-			dp->xfrm_work = 4;
+			dp->rename_rank = 4;
 		}
 		free(p);
 	}
@@ -415,39 +395,21 @@ void diffcore_rename(int detect_rename, 
 			/* rename or copy */
 			struct diff_filepair *dp =
 				diff_queue(q, p->one, p->two);
-			int msglen = (strlen(p->one->path) +
-				      strlen(p->two->path) + 100);
-			int score = (p->xfrm_work >> RENAME_SCORE_SHIFT);
-			dp->xfrm_msg = xmalloc(msglen);
+			dp->score = p->score;
 
 			/* if we have a later entry that is a rename/copy
 			 * that depends on p->one, then we copy here.
 			 * otherwise we rename it.
 			 */
-			if (needs_to_stay(&outq, i+1, p->one)) {
-				/* copy it */
-				sprintf(dp->xfrm_msg,
-					"similarity index %d%%\n"
-					"copy from %s\n"
-					"copy to %s\n",
-					(int)(0.5 + score * 100 / MAX_SCORE),
-					p->one->path, p->two->path);
-			}
-			else {
-				/* rename it, and mark it as gone. */
+			if (!diff_needs_to_stay(&outq, i+1, p->one))
+				/* this is the last one, so mark it as gone.
+				 */
 				p->one->xfrm_flags |= RENAME_SRC_GONE;
-				sprintf(dp->xfrm_msg,
-					"similarity index %d%%\n"
-					"rename old %s\n"
-					"rename new %s\n",
-					(int)(0.5 + score * 100 / MAX_SCORE),
-					p->one->path, p->two->path);
-			}
 		}
 		else
-			/* otherwise it is a modified (or stayed) entry */
+			/* otherwise it is a modified (or "stay") entry */
 			diff_queue(q, p->one, p->two);
-		diff_free_filepair(p);
+		free(p);
 	}
 
 	free(outq.queue);
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -41,13 +41,18 @@ extern void diff_free_filespec_data(stru
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
-	char *xfrm_msg;
+	int score; /* only valid when one and two are different paths */
 	int orig_order; /* the original order of insertion into the queue */
-	int xfrm_work; /* for use by tramsformers, not by diffcore */
+	int rename_rank; /* rename/copy dependency needs to enforce
+			  * certain ordering of patches that later
+			  * diffcore transformations should not break.
+			  */
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
+extern int diff_unmodified_pair(struct diff_filepair *);
+
 struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
@@ -59,6 +64,8 @@ extern struct diff_filepair *diff_queue(
 					struct diff_filespec *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
-extern void diff_free_filepair(struct diff_filepair *);
+
+extern int diff_needs_to_stay(struct diff_queue_struct *, int,
+			      struct diff_filespec *);
 
 #endif
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -11,7 +11,8 @@ test_description='More rename detection
 test_expect_success \
     'prepare reference tree' \
     'cat ../../COPYING >COPYING &&
-    git-update-cache --add COPYING &&
+     echo frotz >rezrov &&
+    git-update-cache --add COPYING rezrov &&
     tree=$(git-write-tree) &&
     echo $tree'
 
@@ -22,9 +23,10 @@ test_expect_success \
     rm -f COPYING &&
     git-update-cache --add --remove COPYING COPYING.?'
 
-# tree has COPYING.  work tree has COPYING.1 and COPYING.2,
-# both are slightly edited.  So we say you copy-and-edit one,
-# and rename-and-edit the other.
+# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+# both are slightly edited, and unchanged rezrov.  So we say you
+# copy-and-edit one, and rename-and-edit the other.  We do not say
+# anything about rezrov.
 
 GIT_DIFF_OPTS=--unified=0 git-diff-cache -M -p $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current &&
@@ -64,9 +66,10 @@ test_expect_success \
     'mv COPYING.2 COPYING &&
      git-update-cache --add --remove COPYING COPYING.1 COPYING.2'
 
-# tree has COPYING.  work tree has COPYING and COPYING.1,
-# both are slightly edited.  So we say you edited one,
-# and copy-and-edit the other.
+# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+# both are slightly edited, and unchanged rezrov.  So we say you
+# edited one, and copy-and-edit the other.  We do not say
+# anything about rezrov.
 
 GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current
@@ -103,10 +106,11 @@ test_expect_success \
     'cat ../../COPYING >COPYING &&
      git-update-cache --add --remove COPYING COPYING.1'
 
-# tree has COPYING.  work tree has the same COPYING and COPYING.1,
-# but COPYING is not edited.  We say you copy-and-edit COPYING.1;
-# this is only possible because -C mode now reports the unmodified
-# file to the diff-core.
+# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+# but COPYING is not edited.  We say you copy-and-edit COPYING.1; this
+# is only possible because -C mode now reports the unmodified file to
+# the diff-core.  Unchanged rezrov, although being fed to
+# git-diff-cache as well, should not be mentioned.
 
 GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
new file mode 100644
--- /dev/null
+++ b/t/t4005-diff-rename-2.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Same rename detection as t4003 but testing diff-raw.
+
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare reference tree' \
+    'cat ../../COPYING >COPYING &&
+     echo frotz >rezrov &&
+    git-update-cache --add COPYING rezrov &&
+    tree=$(git-write-tree) &&
+    echo $tree'
+
+test_expect_success \
+    'prepare work tree' \
+    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
+    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+    rm -f COPYING &&
+    git-update-cache --add --remove COPYING COPYING.?'
+
+# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+# and COPYING.2 are based on COPYING, and do not say anything about
+# rezrov.
+
+git-diff-cache -M $tree >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178	COPYING	COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471	COPYING	COPYING.2
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection' \
+    'diff -u current expected'
+
+test_expect_success \
+    'prepare work tree again' \
+    'mv COPYING.2 COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1 COPYING.2'
+
+# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+# is based on COPYING and COPYING is still there, and do not say anything
+# about rezrov.
+
+git-diff-cache -C $tree >current
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178	COPYING	COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471	COPYING	COPYING
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection' \
+    'diff -u current expected'
+
+test_expect_success \
+    'prepare work tree once again' \
+    'cat ../../COPYING >COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1'
+
+# tree has COPYING and rezrov.  work tree has the same COPYING and
+# copy-edited COPYING.1, and unchanged rezrov.  We should see
+# unmodified COPYING in the output, so that downstream diff-helper can
+# notice.  We should not say anything about rezrov.
+
+git-diff-cache -C $tree >current
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178	COPYING	COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3	COPYING	COPYING
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection' \
+    'diff -u current expected'
+
+test_done
------------------------------------------------

