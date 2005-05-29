From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff: move diffcore-break before diffcore-rename.
Date: Sun, 29 May 2005 02:14:33 -0700
Message-ID: <7vll5ypf5y.fsf@assigned-by-dhcp.cox.net>
References: <7vbr6vrvqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 11:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcJrQ-0003eF-IS
	for gcvg-git@gmane.org; Sun, 29 May 2005 11:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVE2JPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 05:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVE2JPr
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 05:15:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:32703 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261290AbVE2JOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 05:14:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529091434.CVZC16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 05:14:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vbr6vrvqf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 28 May 2005 12:33:44 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The order diffcore-break is applied has changed.  Earlier it
came fairly late in the diffcore chain, but now it comes before
diffcore-rename, which makes diffcore-break far more useful than
before.

As the new test t4008-diff-break-rewrite demonstrates, if a file
is a complete rewrite, it is broken and then can be subjected to
the usual rename detection.  For example, if file0 gets
completely rewritten to make it as if it was rather based on
file1 which disappeared, diff-* -B -M would do the following:

    The original change would look like this:

	file0     --> file0' (quite different from file0)
	file1     --> /dev/null

    After diffcore-break, it would become this:

	file0     --> /dev/null
	/dev/null --> file0'
	file1     --> /dev/null

    Then diffcore-rename matches them up:

	file1     --> file0'

The meaning of the parameter the -B option takes has changed
from the previous one.  Earlier it meant the amount of source
materials permitted to remain for the file and still be
considered a rewrite, which meant that the lower the number, the
tighter the detection criteria.  This was changed to match the
way the parameters to the -C and the -M options are used, where
larger parameter value means tighter detection criteria.  The
parameter for the -B option now means how much new material must
be in the resulting file for the filepair to be considered a
rewrite, and defaults to 99%.

The internal score values are finer grained now.  Earlier
maximum of 10000 has been raised to 60000; there is no user
visible changes but there is no reason to waste available bits.

Documentation now mentions the -B option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt |    5 -
Documentation/git-diff-files.txt |    5 -
Documentation/git-diff-tree.txt  |    5 -
diff.c                           |   20 +++-
diffcore-break.c                 |  101 +++++++++++++----------
diffcore-rename.c                |   64 ++++++++++++--
diffcore.h                       |   13 ++-
t/t4008-diff-break-rewrite.sh    |  169 +++++++++++++++++++++++++++++++++++++++
8 files changed, 317 insertions(+), 65 deletions(-)
new file (100755): t/t4008-diff-break-rewrite.sh

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
+'git-diff-cache' [-p] [-r] [-z] [-m] [-B] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,9 @@ OPTIONS
 -z::
 	\0 line termination on output
 
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
 -M::
 	Detect renames.
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-B] [-M] [-C] [-R] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,9 @@ OPTIONS
 -R::
 	Output diff in reverse.
 
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
 -M::
 	Detect renames.
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-B] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -33,6 +33,9 @@ OPTIONS
 	generate patch (see section on generating patches).  For
 	git-diff-tree, this flag implies '-r' as well.
 
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
 -M::
 	Detect renames.
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -609,6 +609,7 @@ struct diff_filepair *diff_queue(struct 
 	dp->two = two;
 	dp->score = 0;
 	dp->source_stays = 0;
+	dp->broken_pair = 0;
 	diff_q(queue, dp);
 	return dp;
 }
@@ -643,6 +644,16 @@ static void diff_flush_raw(struct diff_f
 		sprintf(status, "%c%03d", p->status,
 			(int)(0.5 + p->score * 100.0/MAX_SCORE));
 		break;
+	case 'N': case 'D':
+		two_paths = 0;
+		if (p->score)
+			sprintf(status, "%c%03d", p->status,
+				(int)(0.5 + p->score * 100.0/MAX_SCORE));
+		else {
+			status[0] = p->status;
+			status[1] = 0;
+		}
+		break;
 	default:
 		two_paths = 0;
 		status[0] = p->status;
@@ -799,8 +810,9 @@ void diff_debug_filepair(const struct di
 {
 	diff_debug_filespec(p->one, i, "one");
 	diff_debug_filespec(p->two, i, "two");
-	fprintf(stderr, "score %d, status %c source_stays %d\n",
-		p->score, p->status ? : '?', p->source_stays);
+	fprintf(stderr, "score %d, status %c stays %d broken %d\n",
+		p->score, p->status ? : '?',
+		p->source_stays, p->broken_pair);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -939,12 +951,12 @@ void diffcore_std(const char **paths,
 {
 	if (paths)
 		diffcore_pathspec(paths);
+	if (0 <= break_opt)
+		diffcore_break(break_opt);
 	if (detect_rename)
 		diffcore_rename(detect_rename, rename_score);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
-	if (0 <= break_opt)
-		diffcore_break(break_opt);
 	if (orderfile)
 		diffcore_order(orderfile);
 }
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -9,13 +9,18 @@
 
 static int very_different(struct diff_filespec *src,
 			  struct diff_filespec *dst,
-			  int max_score)
+			  int min_score)
 {
 	/* dst is recorded as a modification of src.  Are they so
 	 * different that we are better off recording this as a pair
-	 * of delete and create?  max_score is maximum size that is
-	 * common between src and dst for the pair to be still considered
-	 * a change (not delete and create), and typically set to 5-10%.
+	 * of delete and create?  min_score is the minimum amount of
+	 * new material that must exist in the dst and not in src for
+	 * the pair to be considered a complete rewrite, and recommended
+	 * to be set to a very high value, 99% or so.
+	 *
+	 * The value we return represents the amount of new material
+	 * that is in dst and not in src.  We return 0 when we do not
+	 * want to get the filepair broken.
 	 */
 	void *delta;
 	unsigned long delta_size, base_size;
@@ -28,15 +33,19 @@ static int very_different(struct diff_fi
 
 	delta_size = ((src->size < dst->size) ?
 		      (dst->size - src->size) : (src->size - dst->size));
-	base_size = ((src->size < dst->size) ? src->size : dst->size);
+
+	/* Notice that we use max of src and dst as the base size,
+	 * unlike rename similarity detection.  This is so that we do
+	 * not mistake a large addition as a complete rewrite.
+	 */
+	base_size = ((src->size < dst->size) ? dst->size : src->size);
 
 	/*
-	 * If delta size is larger than
-	 * (MAX_SCORE-max_score)/MAX_SCORE * min(src->size, dst->size)
-	 * then we declare this is too big a change to be a patch.
+	 * If file size difference is too big compared to the
+	 * base_size, we declare this a complete rewrite.
 	 */
-	if (base_size * (MAX_SCORE-max_score) < delta_size * MAX_SCORE)
-		return 1;
+	if (base_size * min_score < delta_size * MAX_SCORE)
+		return MAX_SCORE;
 
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */
@@ -48,60 +57,68 @@ static int very_different(struct diff_fi
 	/* A delta that has a lot of literal additions would have
 	 * big delta_size no matter what else it does.
 	 */
-	if (base_size * (MAX_SCORE-max_score) < delta_size * MAX_SCORE)
-		return 1;
+	if (base_size * min_score < delta_size * MAX_SCORE)
+		return MAX_SCORE;
 
 	/* Estimate the edit size by interpreting delta. */
 	delta_size = count_delta(delta, delta_size);
 	free(delta);
 	if (delta_size == UINT_MAX)
 		return 0; /* error in delta computation */
-	/*
-	 * So how big is the edit?
-	 */
-	if (base_size * (MAX_SCORE-max_score) < delta_size * MAX_SCORE)
-		return 1;
-	return 0;
+
+	if (base_size < delta_size)
+		return MAX_SCORE;
+
+	return delta_size * MAX_SCORE / base_size; 
 }
 
-void diffcore_break(int max_score)
+void diffcore_break(int min_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	int i;
 
-	if (!max_score)
-		max_score = DEFAULT_MAXIMUM_SCORE;
+	if (!min_score)
+		min_score = DEFAULT_BREAK_SCORE;
 
 	outq.nr = outq.alloc = 0;
 	outq.queue = NULL;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		/* We deal only with in-place edit of non directory */
+		int score;
+
+		/* We deal only with in-place edit of non directory.
+		 * We do not break anything else.
+		 */
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two) &&
 		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
-		    !strcmp(p->one->path, p->two->path) &&
-		    very_different(p->one, p->two, max_score)) {
-			/* Split this into delete and create */
-			struct diff_filespec *one_pre, *one_post,
-				*two_pre, *two_post;
-
-			/* deletion of one */
-			one_pre = alloc_filespec(p->one->path);
-			fill_filespec(one_pre, p->one->sha1, p->one->mode);
-			one_post = alloc_filespec(p->one->path);
-			diff_queue(&outq, one_pre, one_post);
-
-			/* creation of two */
-			two_pre = alloc_filespec(p->two->path);
-			two_post = alloc_filespec(p->two->path);
-			fill_filespec(two_post, p->two->sha1, p->two->mode);
-			diff_queue(&outq, two_pre, two_post);
-			diff_free_filepair(p);
+		    !strcmp(p->one->path, p->two->path)) {
+			score = very_different(p->one, p->two, min_score);
+			if (min_score <= score) {
+				/* Split this into delete and create */
+				struct diff_filespec *null_one, *null_two;
+				struct diff_filepair *dp;
+
+				/* deletion of one */
+				null_one = alloc_filespec(p->one->path);
+				dp = diff_queue(&outq, p->one, null_one);
+				dp->score = score;
+				dp->broken_pair = 1;
+
+				/* creation of two */
+				null_two = alloc_filespec(p->two->path);
+				dp = diff_queue(&outq, null_two, p->two);
+				dp->score = score;
+				dp->broken_pair = 1;
+
+				free(p); /* not diff_free_filepair(), we are
+					  * reusing one and two here.
+					  */
+				continue;
+			}
 		}
-		else
-			diff_q(&outq, p);
+		diff_q(&outq, p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -232,7 +232,7 @@ void diffcore_rename(int detect_rename, 
 	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
-		minimum_score = DEFAULT_MINIMUM_SCORE;
+		minimum_score = DEFAULT_RENAME_SCORE;
 	renq.queue = NULL;
 	renq.nr = renq.alloc = 0;
 
@@ -311,26 +311,66 @@ void diffcore_rename(int detect_rename, 
 	outq.nr = outq.alloc = 0;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct diff_rename_dst *dst = locate_rename_dst(p->two, 0);
 		struct diff_filepair *pair_to_free = NULL;
 
-		if (dst) {
-			/* creation */
-			if (dst->pair) {
-				/* renq has rename/copy to produce
-				 * this file already, so we do not
-				 * emit the creation record in the
-				 * output.
-				 */
+		if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
+			/*
+			 * Creation
+			 *
+			 * We would output this create record if it has
+			 * not been turned into a rename/copy already.
+			 */
+			struct diff_rename_dst *dst =
+				locate_rename_dst(p->two, 0);
+			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
 			}
 			else
-				/* no matching rename/copy source, so record
-				 * this as a creation.
+				/* no matching rename/copy source, so
+				 * record this as a creation.
 				 */
 				diff_q(&outq, p);
 		}
+		else if (DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two)) {
+			/*
+			 * Deletion
+			 *
+			 * We would output this delete record if:
+			 *
+			 * (1) this is a broken delete and the counterpart
+			 *     broken create remains in the output; or
+			 * (2) this is not a broken delete, and renq does
+			 *     not have a rename/copy to create p->two->path.
+			 *
+			 * Otherwise, the counterpart broken create
+			 * has been turned into a rename-edit; or
+			 * delete did not have a matching create to
+			 * begin with.
+			 */
+			if (DIFF_PAIR_BROKEN(p)) {
+				/* broken delete */
+				struct diff_rename_dst *dst =
+					locate_rename_dst(p->one, 0);
+				if (dst && dst->pair)
+					/* counterpart is now rename/copy */
+					pair_to_free = p;
+			}
+			else {
+				for (j = 0; j < renq.nr; j++)
+					if (!strcmp(renq.queue[j]->two->path,
+						    p->one->path))
+						break;
+				if (j < renq.nr)
+					/* this path remains */
+					pair_to_free = p;
+			}
+
+			if (pair_to_free)
+				;
+			else
+				diff_q(&outq, p);
+		}
 		else if (!diff_unmodified_pair(p))
 			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -8,9 +8,9 @@
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
  */
-#define MAX_SCORE 10000
-#define DEFAULT_MINIMUM_SCORE 5000 /* rename/copy similarity minimum */
-#define DEFAULT_MAXIMUM_SCORE 1500 /* similarity maximum for break to happen */
+#define MAX_SCORE 60000
+#define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
+#define DEFAULT_BREAK_SCORE  59400 /* minimum for break to happen (99%)*/
 
 #define RENAME_DST_MATCHED 01
 
@@ -43,14 +43,19 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	unsigned short int score;
-	char source_stays; /* all of R/C are copies */
 	char status; /* M C R N D U (see Documentation/diff-format.txt) */
+	unsigned source_stays : 1; /* all of R/C are copies */
+	unsigned broken_pair : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
 #define DIFF_PAIR_RENAME(p) (strcmp((p)->one->path, (p)->two->path))
 
+#define DIFF_PAIR_BROKEN(p) \
+	( (!DIFF_FILE_VALID((p)->one) != !DIFF_FILE_VALID((p)->two)) && \
+	  ((p)->broken_pair != 0) )
+
 #define DIFF_PAIR_TYPE_CHANGED(p) \
 	((S_IFMT & (p)->one->mode) != (S_IFMT & (p)->two->mode))
 
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
new file mode 100755
--- /dev/null
+++ b/t/t4008-diff-break-rewrite.sh
@@ -0,0 +1,169 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Break and then rename
+
+We have two very different files, file0 and file1, registered in a tree.
+
+We update file1 so drastically that it is more similar to file0, and
+then remove file0.  With -B, changes to file1 should be broken into
+separate delete and create, resulting in removal of file0, removal of
+original file1 and creation of completely rewritten file1.
+
+Further, with -B and -M together, these three modifications should
+turn into rename-edit of file0 into file1.
+
+Starting from the same two files in the tree, we swap file0 and file1.
+With -B, this should be detected as two complete rewrites, resulting in
+four changes in total.
+
+Further, with -B and -M together, these should turn into two renames.
+'
+. ./test-lib.sh
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([CDNR]\)[0-9]*	/ X X \1#	/'
+compare_diff_raw () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
+    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+test_expect_success \
+    setup \
+    'cat ../../README >file0 &&
+     cat ../../COPYING >file1 &&
+    git-update-cache --add file0 file1 &&
+    tree=$(git-write-tree) &&
+    echo "$tree"'
+
+test_expect_success \
+    'change file1 with copy-edit of file0 and remove file0' \
+    'sed -e "s/git/GIT/" file0 >file1 &&
+     rm -f file0 &&
+    git-update-cache --remove file0 file1'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B --cached "$tree" >current'
+
+cat >expected <<\EOF
+:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 11e331465a89c394dc25c780de230043750c1ec8 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B (#1)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B and -M' \
+    'git-diff-cache -B -M "$tree" >current'
+
+cat >expected <<\EOF
+:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 08bb2fb671deff4c03a4d4a0a1315dff98d5732c R100	file0	file1
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#2)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'swap file0 and file1' \
+    'rm -f file0 file1 &&
+     git-read-tree -m $tree &&
+     git-checkout-cache -f -u -a &&
+     mv file0 tmp &&
+     mv file1 file0 &&
+     mv tmp file1 &&
+     git-update-cache file0 file1'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B "$tree" >current'
+
+cat >expected <<\EOF
+:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D100	file0
+:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 N100	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B (#3)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B and -M' \
+    'git-diff-cache -B -M "$tree" >current'
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	file1	file0
+:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 R100	file0	file1
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#4)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'make file0 into something completely different' \
+    'rm -f file0 &&
+     ln -s frotz file0 &&
+     git-update-cache file0 file1'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B "$tree" >current'
+
+cat >expected <<\EOF
+:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B (#5)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B -M "$tree" >current'
+
+# This should not mistake file0 as the copy source of new file1
+# due to type differences.
+cat >expected <<\EOF
+:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#6)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -M' \
+    'git-diff-cache -M "$tree" >current'
+
+# This should not mistake file0 as the copy source of new file1
+# due to type differences.
+cat >expected <<\EOF
+:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M	file1
+EOF
+
+test_expect_success \
+    'validate result of -M (#7)' \
+    'compare_diff_raw current expected'
+
+test_done

