From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix diff-pruning logic which was running prune too early.
Date: Mon, 23 May 2005 18:14:03 -0700
Message-ID: <7vzmulzaqs.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
	<7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
	<7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231644560.2307@ppc970.osdl.org>
	<7vll651nth.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 03:19:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaO4T-0004fN-Jc
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVEXBUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEXBUW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:20:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58049 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261228AbVEXBOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:14:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524011403.NKIQ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 21:14:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll651nth.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 23 May 2005 17:15:38 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

For later stages to reorder patches, pruning logic and rename
detection logic should not decide which delete to discard
(because another entry said it will take over the file as a
rename) until the very end.  Also fix some tests that were
assuming the earlier "last one is rename or keep everything else
is copy" semantics of diff-raw format, which no longer is true.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c             |    1 
diff-files.c             |    1 
diff-tree.c              |    2 
diff.c                   |  156 +++++++++++++++++++----------------------------
diff.h                   |    2 
diffcore-rename.c        |   25 -------
diffcore.h               |    2 
t/t4005-diff-rename-2.sh |    7 --
8 files changed, 69 insertions(+), 127 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -229,7 +229,6 @@ int main(int argc, const char **argv)
 	ret = diff_cache(active_cache, active_nr);
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
-	diffcore_prune();
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe);
 	if (2 <= argc)
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -115,7 +115,6 @@ int main(int argc, const char **argv)
 	}
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
-	diffcore_prune();
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe);
 	if (1 < argc)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -266,10 +266,8 @@ static int call_diff_flush(void)
 {
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
-	diffcore_prune();
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe);
-
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -12,9 +12,6 @@ static const char *diff_opts = "-pu";
 static unsigned char null_sha1[20] = { 0, };
 
 static int reverse_diff;
-static int generate_patch;
-static int line_termination = '\n';
-static int inter_name_termination = '\t';
 
 static const char *external_diff(void)
 {
@@ -502,7 +499,9 @@ struct diff_filepair *diff_queue(struct 
 	return dp;
 }
 
-static void diff_flush_raw(struct diff_filepair *p)
+static void diff_flush_raw(struct diff_filepair *p,
+			   int line_termination,
+			   int inter_name_termination)
 {
 	int two_paths;
 	char status[10];
@@ -566,10 +565,6 @@ static void diff_flush_patch(struct diff
 	const char *name, *other;
 	char msg_[PATH_MAX*2+200], *msg;
 
-	/* diffcore_prune() keeps "stay" entries for diff-raw
-	 * copy/rename detection, but when we are generating
-	 * patches we do not need them.
-	 */
 	if (diff_unmodified_pair(p))
 		return;
 
@@ -585,7 +580,7 @@ static void diff_flush_patch(struct diff
 			"similarity index %d%%\n"
 			"copy from %s\n"
 			"copy to %s\n",
-			(int)(0.5 + p->score * 100/MAX_SCORE),
+			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;
 		break;
@@ -594,7 +589,7 @@ static void diff_flush_patch(struct diff
 			"similarity index %d%%\n"
 			"rename old %s\n"
 			"rename new %s\n",
-			(int)(0.5 + p->score * 100/MAX_SCORE),
+			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;
 		break;
@@ -630,105 +625,82 @@ int diff_needs_to_stay(struct diff_queue
 	return 0;
 }
 
-static int diff_used_as_source(struct diff_queue_struct *q, int lim,
-			       struct diff_filespec *it)
+int diff_queue_is_empty(void)
 {
-	int i;
-	for (i = 0; i < lim; i++) {
-		struct diff_filepair *p = q->queue[i++];
-		if (!strcmp(p->one->path, it->path))
-			return 1;
-	}
-	return 0;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	return q->nr == 0;
 }
 
-void diffcore_prune(void)
+static void diff_resolve_rename_copy(void)
 {
-	/*
-	 * Although rename/copy detection wants to have "no-change"
-	 * entries fed into them, the downstream do not need to see
-	 * them, unless we had rename/copy for the same path earlier.
-	 * This function removes such entries.
-	 *
-	 * The applications that use rename/copy should:
-	 *
-	 * (1) feed change and "no-change" entries via diff_queue().
-	 * (2) call diffcore_rename, and any other future diffcore_xxx
-	 *     that would benefit by still having "no-change" entries.
-	 * (3) call diffcore_prune
-	 * (4) call other diffcore_xxx that do not need to see
-	 *     "no-change" entries.
-	 * (5) call diff_flush().
-	 */
-	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
 	int i;
-
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
-
+	struct diff_queue_struct *q = &diff_queued_diff;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (!diff_unmodified_pair(p) ||
-		    diff_used_as_source(q, i, p->one))
-			diff_q(&outq, p);
-		else
-			free(p);
+		p->status = 0;
+		if (DIFF_PAIR_UNMERGED(p))
+			p->status = 'U';
+		else if (!DIFF_FILE_VALID((p)->one))
+			p->status = 'N';
+		else if (!DIFF_FILE_VALID((p)->two)) {
+			/* maybe earlier one said 'R', meaning
+			 * it will take it, in which case we do
+			 * not need to keep 'D'.
+			 */
+			int j;
+			for (j = 0; j < i; j++) {
+				struct diff_filepair *pp = q->queue[j];
+				if (pp->status == 'R' &&
+				    !strcmp(pp->one->path, p->one->path))
+					break;
+			}
+			if (j < i)
+				continue;
+			p->status = 'D';
+		}
+		else if (strcmp(p->one->path, p->two->path)) {
+			/* This is rename or copy.  Which one is it? */
+			if (diff_needs_to_stay(q, i+1, p->one))
+				p->status = 'C';
+			else
+				p->status = 'R';
+		}
+		else if (memcmp(p->one->sha1, p->two->sha1, 20))
+			p->status = 'M';
+		else {
+			/* we do not need this one */
+			p->status = 0;
+		}
 	}
-	free(q->queue);
-	*q = outq;
-	return;
-}
-
-int diff_queue_is_empty(void)
-{
-	struct diff_queue_struct *q = &diff_queued_diff;
-	return q->nr == 0;
 }
 
 void diff_flush(int diff_output_style, int resolve_rename_copy)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
+	int line_termination = '\n';
+	int inter_name_termination = '\t';
 
-	generate_patch = 0;
-	switch (diff_output_style) {
-	case DIFF_FORMAT_HUMAN:
-		line_termination = '\n';
-		inter_name_termination = '\t';
-		break;
-	case DIFF_FORMAT_MACHINE:
+	if (diff_output_style == DIFF_FORMAT_MACHINE)
 		line_termination = inter_name_termination = 0;
-		break;
-	case DIFF_FORMAT_PATCH:
-		generate_patch = 1;
-		break;
-	}
+	if (resolve_rename_copy)
+		diff_resolve_rename_copy();
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (resolve_rename_copy) {
-			if (DIFF_PAIR_UNMERGED(p))
-				p->status = 'U';
-			else if (!DIFF_FILE_VALID((p)->one))
-				p->status = 'N';
-			else if (!DIFF_FILE_VALID((p)->two))
-				p->status = 'D';
-			else if (strcmp(p->one->path, p->two->path)) {
-				/* This is rename or copy.  Which one is it? */
-				if (diff_needs_to_stay(q, i+1, p->one))
-					p->status = 'C';
-				else
-					p->status = 'R';
-			}
-			else
-				p->status = 'M';
-		}
-		if (generate_patch)
+		if (p->status == 0)
+			continue;
+		switch (diff_output_style) {
+		case DIFF_FORMAT_PATCH:
 			diff_flush_patch(p);
-		else
-			diff_flush_raw(p);
+			break;
+		case DIFF_FORMAT_HUMAN:
+		case DIFF_FORMAT_MACHINE:
+			diff_flush_raw(p, line_termination,
+				       inter_name_termination);
+			break;
+		}
 	}
-
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		diff_free_filespec_data(p->one);
@@ -755,9 +727,9 @@ void diff_addremove(int addremove, unsig
 	 * with something like '=' or '*' (I haven't decided
 	 * which but should not make any difference).
 	 * Feeding the same new and old to diff_change() 
-	 * also has the same effect.  diffcore_prune() should
-	 * be used to filter uninteresting ones out before the
-	 * final output happens.
+	 * also has the same effect.
+	 * Before the final output happens, they are pruned after
+	 * merged into rename/copy pairs as appropriate.
 	 */
 	if (reverse_diff)
 		addremove = (addremove == '+' ? '-' :
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -39,8 +39,6 @@ extern void diff_setup(int reverse);
 
 extern void diffcore_rename(int rename_copy, int minimum_score);
 
-extern void diffcore_prune(void);
-
 extern void diffcore_pickaxe(const char *needle);
 extern void diffcore_pathspec(const char **pathspec);
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -133,10 +133,7 @@ static void record_rename_pair(struct di
 	 * The downstream diffcore transformers are free to reorder
 	 * the entries as long as they keep file pairs that has the
 	 * same p->one->path in earlier rename_rank to appear before
-	 * later ones.  This ordering is used by the diff_flush()
-	 * logic to tell renames from copies, and also used by the
-	 * diffcore_prune() logic to omit unnecessary
-	 * "no-modification" entries.
+	 * later ones.
 	 *
 	 * To the final output routine, and in the diff-raw format
 	 * output, a rename/copy that is based on a path that has a
@@ -271,14 +268,8 @@ void diffcore_rename(int detect_rename, 
 
 	/* We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
-	 *
-	 * With the current callers, we should not have already
-	 * matched entries at this point, but it is nonetheless
-	 * checked for sanity.
 	 */
 	for (i = 0; i < created.nr; i++) {
-		if (created.s[i]->xfrm_flags & RENAME_DST_MATCHED)
-			continue; /* we have matched exactly already */
 		for (h = 0; h < sizeof(srcs)/sizeof(srcs[0]); h++) {
 			struct diff_rename_pool *p = srcs[h];
 			for (j = 0; j < p->nr; j++) {
@@ -386,25 +377,13 @@ void diffcore_rename(int detect_rename, 
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			/* deleted */
-			if (p->one->xfrm_flags & RENAME_SRC_GONE)
-				; /* rename/copy deleted it already */
-			else
-				diff_queue(q, p->one, p->two);
+			diff_queue(q, p->one, p->two);
 		}
 		else if (strcmp(p->one->path, p->two->path)) {
 			/* rename or copy */
 			struct diff_filepair *dp =
 				diff_queue(q, p->one, p->two);
 			dp->score = p->score;
-
-			/* if we have a later entry that is a rename/copy
-			 * that depends on p->one, then we copy here.
-			 * otherwise we rename it.
-			 */
-			if (!diff_needs_to_stay(&outq, i+1, p->one))
-				/* this is the last one, so mark it as gone.
-				 */
-				p->one->xfrm_flags |= RENAME_SRC_GONE;
 		}
 		else
 			/* otherwise it is a modified (or "stay") entry */
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -12,8 +12,6 @@
 #define DEFAULT_MINIMUM_SCORE 5000
 
 #define RENAME_DST_MATCHED 01
-#define RENAME_SRC_GONE    02
-#define RENAME_SCORE_SHIFT 8
 
 struct diff_filespec {
 	unsigned char sha1[20];
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -147,14 +147,13 @@ test_expect_success \
 ################################################################
 
 # tree has COPYING and rezrov.  work tree has the same COPYING and
-# copy-edited COPYING.1, and unchanged rezrov.  We should see
-# unmodified COPYING in the output, so that downstream diff-helper can
-# notice.  We should not say anything about rezrov.
+# copy-edited COPYING.1, and unchanged rezrov.  We should not say
+# anything about rezrov nor COPYING, since the revised again diff-raw
+# nows how to say Copy.
 
 git-diff-cache -C $tree >current
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M	COPYING
 EOF
 
 test_expect_success \
------------------------------------------------

