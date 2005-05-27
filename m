From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 10/12] Fix the way diffcore-rename records unremoved source.
Date: Fri, 27 May 2005 15:55:55 -0700
Message-ID: <7vsm082s90.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbnjJ-0002OU-GN
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVE0W5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVE0W5B
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:57:01 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:28848 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262625AbVE0Wz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:55:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225556.YPLG20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:55:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Earier version of diffcore-rename used to keep unmodified
filepair in its output so that the last stage of the processing
that tells renames from copies can make all of rename/copy to
copies.  However this had a bad interaction with other diffcore
filters that wanted to run after diffcore-rename, in that such
unmodified filepair must be retained for proper distinction
between renames and copies to happen.

This patch fixes the problem by changing the way diffcore-rename
records the information needed to distinguish "all are copies"
case and "the last one is a rename" case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c              |   76 ++++++++++++++++++--------------------
diffcore-rename.c   |   63 ++++++++++++-------------------
diffcore.h          |    7 ++-
t/t4007-rename-3.sh |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 169 insertions(+), 80 deletions(-)
new file (100644): t/t4007-rename-3.sh

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -518,6 +518,7 @@ struct diff_filepair *diff_queue(struct 
 	dp->one = one;
 	dp->two = two;
 	dp->score = 0;
+	dp->source_stays = 0;
 	diff_q(queue, dp);
 	return dp;
 }
@@ -675,8 +676,8 @@ void diff_debug_filepair(const struct di
 {
 	diff_debug_filespec(p->one, i, "one");
 	diff_debug_filespec(p->two, i, "two");
-	fprintf(stderr, "score %d, status %c\n",
-		p->score, p->status ? : '?');
+	fprintf(stderr, "score %d, status %c source_stays %d\n",
+		p->score, p->status ? : '?', p->source_stays);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -698,8 +699,6 @@ static void diff_resolve_rename_copy(voi
 	struct diff_filepair *p, *pp;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
-	/* This should not depend on the ordering of things. */
-
 	diff_debug_queue("resolve-rename-copy", q);
 
 	for (i = 0; i < q->nr; i++) {
@@ -707,23 +706,28 @@ static void diff_resolve_rename_copy(voi
 		p->status = 0; /* undecided */
 		if (DIFF_PAIR_UNMERGED(p))
 			p->status = 'U';
-		else if (!DIFF_FILE_VALID((p)->one))
+		else if (!DIFF_FILE_VALID(p->one))
 			p->status = 'N';
-		else if (!DIFF_FILE_VALID((p)->two)) {
-			/* Deletion record should be omitted if there
-			 * are rename/copy entries using this one as
-			 * the source.  Then we can say one of them
-			 * is a rename and the rest are copies.
+		else if (!DIFF_FILE_VALID(p->two)) {
+			/* Deleted entry may have been picked up by
+			 * another rename-copy entry.  So we scan the
+			 * queue and if we find one that uses us as the
+			 * source we do not say delete for this entry.
 			 */
-			p->status = 'D';
 			for (j = 0; j < q->nr; j++) {
 				pp = q->queue[j];
-				if (!strcmp(pp->one->path, p->one->path) &&
-				    strcmp(pp->one->path, pp->two->path)) {
+				if (!strcmp(p->one->path, pp->one->path) &&
+				    pp->score) {
+					/* rename/copy are always valid
+					 * so we do not say DIFF_FILE_VALID()
+					 * on pp->one and pp->two.
+					 */
 					p->status = 'X';
 					break;
 				}
 			}
+			if (!p->status)
+				p->status = 'D';
 		}
 		else if (DIFF_PAIR_TYPE_CHANGED(p))
 			p->status = 'T';
@@ -732,33 +736,24 @@ static void diff_resolve_rename_copy(voi
 		 * whose both sides are valid and of the same type, i.e.
 		 * either in-place edit or rename/copy edit.
 		 */
-		else if (strcmp(p->one->path, p->two->path)) {
-			/* See if there is somebody else anywhere that
-			 * will keep the path (either modified or
-			 * unmodified).  If so, we have to be a copy,
-			 * not a rename.  In addition, if there is
-			 * some other rename or copy that comes later
-			 * than us that uses the same source, we
-			 * have to be a copy, not a rename.
+		else if (p->score) {
+			if (p->source_stays) {
+				p->status = 'C';
+				continue;
+			}
+			/* See if there is some other filepair that
+			 * copies from the same source as us.  If so
+			 * we are a copy.  Otherwise we are a rename.
 			 */
-			for (j = 0; j < q->nr; j++) {
+			for (j = i + 1; j < q->nr; j++) {
 				pp = q->queue[j];
 				if (strcmp(pp->one->path, p->one->path))
-					continue;
-				if (!strcmp(pp->one->path, pp->two->path)) {
-					if (DIFF_FILE_VALID(pp->two)) {
-						/* non-delete */
-						p->status = 'C';
-						break;
-					}
-					continue;
-				}
-				/* pp is a rename/copy ... */
-				if (i < j) {
-					/* ... and comes later than us */
-					p->status = 'C';
-					break;
-				}
+					continue; /* not us */
+				if (!pp->score)
+					continue; /* not a rename/copy */
+				/* pp is a rename/copy from the same source */
+				p->status = 'C';
+				break;
 			}
 			if (!p->status)
 				p->status = 'R';
@@ -767,8 +762,11 @@ static void diff_resolve_rename_copy(voi
 			 p->one->mode != p->two->mode)
 			p->status = 'M';
 		else
-			/* this is a "no-change" entry */
-			p->status = 'X';
+			/* this is a "no-change" entry.
+			 * should not happen anymore.
+			 * p->status = 'X';
+			 */
+			die("internal error in diffcore: unmodified entry remains");
 	}
 	diff_debug_queue("resolve-rename-copy done", q);
 }
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -52,14 +52,15 @@ static struct diff_rename_dst *locate_re
 	return &(rename_dst[first]);
 }
 
+/* Table of rename/copy src files */
 static struct diff_rename_src {
 	struct diff_filespec *one;
-	unsigned src_used : 1;
+	unsigned src_stays : 1;
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *locate_rename_src(struct diff_filespec *one,
-						 int insert_ok)
+static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
+						   int src_stays)
 {
 	int first, last;
 
@@ -77,9 +78,7 @@ static struct diff_rename_src *locate_re
 		}
 		first = next+1;
 	}
-	/* not found */
-	if (!insert_ok)
-		return NULL;
+
 	/* insert to make it at "first" */
 	if (rename_src_alloc <= rename_src_nr) {
 		rename_src_alloc = alloc_nr(rename_src_alloc);
@@ -91,7 +90,7 @@ static struct diff_rename_src *locate_re
 		memmove(rename_src + first + 1, rename_src + first,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
 	rename_src[first].one = one;
-	rename_src[first].src_used = 0;
+	rename_src[first].src_stays = src_stays;
 	return &(rename_src[first]);
 }
 
@@ -199,15 +198,14 @@ static void record_rename_pair(struct di
 	fill_filespec(two, dst->sha1, dst->mode);
 
 	dp = diff_queue(renq, one, two);
-	dp->score = score;
-
-	rename_src[src_index].src_used = 1;
+	dp->score = score ? : 1; /* make sure it is at least 1 */
+	dp->source_stays = rename_src[src_index].src_stays;
 	rename_dst[dst_index].pair = dp;
 }
 
 /*
  * We sort the rename similarity matrix with the score, in descending
- * order (more similar first).
+ * order (the most similar first).
  */
 static int score_compare(const void *a_, const void *b_)
 {
@@ -254,9 +252,9 @@ void diffcore_rename(int detect_rename, 
 			else
 				locate_rename_dst(p->two, 1);
 		else if (!DIFF_FILE_VALID(p->two))
-			locate_rename_src(p->one, 1);
-		else if (1 < detect_rename) /* find copy, too */
-			locate_rename_src(p->one, 1);
+			register_rename_src(p->one, 0);
+		else if (detect_rename == DIFF_DETECT_COPY)
+			register_rename_src(p->one, 1);
 	}
 	if (rename_dst_nr == 0)
 		goto cleanup; /* nothing to do */
@@ -280,7 +278,7 @@ void diffcore_rename(int detect_rename, 
 	 * doing the delta matrix altogether.
 	 */
 	if (renq.nr == rename_dst_nr)
-		goto flush_rest;
+		goto cleanup;
 
 	num_create = (rename_dst_nr - renq.nr);
 	num_src = rename_src_nr;
@@ -307,37 +305,30 @@ void diffcore_rename(int detect_rename, 
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
 		if (mx[i].score < minimum_score)
-			break; /* there is not any more diffs applicable. */
+			break; /* there is no more usable pair. */
 		record_rename_pair(&renq, mx[i].dst, mx[i].src, mx[i].score);
 	}
 	free(mx);
 	diff_debug_queue("done detecting fuzzy", &renq);
 
- flush_rest:
+ cleanup:
 	/* At this point, we have found some renames and copies and they
 	 * are kept in renq.  The original list is still in *q.
-	 *
-	 * Scan the original list and move them into the outq; we will sort
-	 * outq and swap it into the queue supplied to pass that to
-	 * downstream, so we assign the sort keys in this loop.
-	 *
-	 * See comments at the top of record_rename_pair for numbers used
-	 * to assign rename_rank.
 	 */
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct diff_rename_src *src = locate_rename_src(p->one, 0);
 		struct diff_rename_dst *dst = locate_rename_dst(p->two, 0);
 		struct diff_filepair *pair_to_free = NULL;
 
 		if (dst) {
 			/* creation */
 			if (dst->pair) {
-				/* renq has rename/copy already to produce
-				 * this file, so we do not emit the creation
-				 * record in the output.
+				/* renq has rename/copy to produce
+				 * this file already, so we do not
+				 * emit the creation record in the
+				 * output.
 				 */
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
@@ -349,17 +340,12 @@ void diffcore_rename(int detect_rename, 
 				diff_q(&outq, p);
 		}
 		else if (!diff_unmodified_pair(p))
-			/* all the other cases need to be recorded as is */
+			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
-		else {
-			/* unmodified pair needs to be recorded only if
-			 * it is used as the source of rename/copy
-			 */
-			if (src && src->src_used)
-				diff_q(&outq, p);
-			else
-				pair_to_free = p;
-		}
+		else
+			/* no need to keep unmodified pairs */
+			pair_to_free = p;
+
 		if (pair_to_free)
 			diff_free_filepair(pair_to_free);
 	}
@@ -370,7 +356,6 @@ void diffcore_rename(int detect_rename, 
 	*q = outq;
 	diff_debug_queue("done collapsing", q);
 
- cleanup:
 	free(rename_dst);
 	rename_dst = NULL;
 	rename_dst_nr = rename_dst_alloc = 0;
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -39,8 +39,11 @@ extern void diff_free_filespec_data(stru
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
-	int score; /* only valid when one and two are different paths */
-	int status; /* M C R N D U (see Documentation/diff-format.txt) */
+	unsigned short int score; /* only valid when one and two are
+				   * different paths
+				   */
+	char source_stays; /* all of R/C are copies */
+	char status; /* M C R N D U (see Documentation/diff-format.txt) */
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
new file mode 100644
--- /dev/null
+++ b/t/t4007-rename-3.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Rename interaction with pathspec.
+
+'
+. ./test-lib.sh
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='s/ \('"$_x40"'\) \1 \([CR]\)[0-9]*	/ \1 \1 \2#	/'
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
+    'prepare reference tree' \
+    'mkdir path0 path1 &&
+     cp ../../COPYING path0/COPYING &&
+     git-update-cache --add path0/COPYING &&
+    tree=$(git-write-tree) &&
+    echo $tree'
+
+test_expect_success \
+    'prepare work tree' \
+    'cp path0/COPYING path1/COPYING &&
+     git-update-cache --add --remove path0/COPYING path1/COPYING'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 and
+# path1 both have COPYING and the latter is a copy of path0/COPYING.
+# Comparing the full tree with cache should tell us so.
+
+git-diff-cache -C $tree >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 and
+# path1 both have COPYING and the latter is a copy of path0/COPYING.
+# When we omit output from path0 it should still be able to tell us
+# that path1/COPYING is result from a copy from path0/COPYING, not
+# rename, which would imply path0/COPYING is now gone.
+
+git-diff-cache -C $tree path1 >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'tweak work tree' \
+    'rm -f path0/COPYING &&
+     git-update-cache --remove path0/COPYING'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 does
+# not have COPYING anymore and path1 has COPYING which is a copy of
+# path0/COPYING.  Showing the full tree with cache should tell us about
+# the rename.
+
+git-diff-cache -C $tree >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 does
+# not have COPYING anymore and path1 has COPYING which is a copy of
+# path0/COPYING.  Even if we restrict the output to path1, it still
+# should show us the rename.
+
+git-diff-cache -C $tree path1 >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+test_done
------------------------------------------------

