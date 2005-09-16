From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Plug diff leaks.
Date: Fri, 16 Sep 2005 00:38:43 -0700
Message-ID: <7v3bo5sbr0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 16 09:40:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGAoM-00035K-Lv
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 09:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbVIPHiq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbVIPHiq
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 03:38:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12989 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161108AbVIPHip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 03:38:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916073843.DLQC24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 03:38:43 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8668>

It is a bit embarrassing that it took this long for a fix since the
problem was first reported on Aug 13th.

    Message-ID: <87y876gl1r.wl@mail2.atmark-techno.com>
    From: Yasushi SHOJI <yashi@atmark-techno.com>
    Newsgroups: gmane.comp.version-control.git
    Subject: [patch] possible memory leak in diff.c::diff_free_filepair()
    Date: Sat, 13 Aug 2005 19:58:56 +0900

This time I used valgrind to make sure that it does not overeagerly
discard memory that is still being used.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * this will hopefully be in 0.99.7

 diff-tree.c       |    1 +
 diff.c            |    5 ++++-
 diffcore-rename.c |   56 ++++++++++++++++++++++++++++++-----------------------
 3 files changed, 37 insertions(+), 25 deletions(-)

5098bafb756de69d03882707a3382899c0cb7dd1
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -370,6 +370,7 @@ static int diff_tree_commit(const unsign
 		}
 		offset += 48;
 	}
+	free(buf);
 	return 0;
 }
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -762,7 +762,8 @@ struct diff_filepair *diff_queue(struct 
 	dp->status = 0;
 	dp->source_stays = 0;
 	dp->broken_pair = 0;
-	diff_q(queue, dp);
+	if (queue)
+		diff_q(queue, dp);
 	return dp;
 }
 
@@ -770,6 +771,8 @@ void diff_free_filepair(struct diff_file
 {
 	diff_free_filespec_data(p->one);
 	diff_free_filespec_data(p->two);
+	free(p->one);
+	free(p->two);
 	free(p);
 }
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -47,7 +47,8 @@ static struct diff_rename_dst *locate_re
 	if (first < rename_dst_nr)
 		memmove(rename_dst + first + 1, rename_dst + first,
 			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
-	rename_dst[first].two = two;
+	rename_dst[first].two = alloc_filespec(two->path);
+	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
 	rename_dst[first].pair = NULL;
 	return &(rename_dst[first]);
 }
@@ -201,8 +202,7 @@ static int estimate_similarity(struct di
 	return score;
 }
 
-static void record_rename_pair(struct diff_queue_struct *renq,
-			       int dst_index, int src_index, int score)
+static void record_rename_pair(int dst_index, int src_index, int score)
 {
 	struct diff_filespec *one, *two, *src, *dst;
 	struct diff_filepair *dp;
@@ -218,7 +218,7 @@ static void record_rename_pair(struct di
 	two = alloc_filespec(dst->path);
 	fill_filespec(two, dst->sha1, dst->mode);
 
-	dp = diff_queue(renq, one, two);
+	dp = diff_queue(NULL, one, two);
 	dp->score = score;
 	dp->source_stays = rename_src[src_index].src_path_left;
 	rename_dst[dst_index].pair = dp;
@@ -252,15 +252,14 @@ static int compute_stays(struct diff_que
 void diffcore_rename(int detect_rename, int minimum_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct renq, outq;
+	struct diff_queue_struct outq;
 	struct diff_score *mx;
-	int i, j;
+	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
-	renq.queue = NULL;
-	renq.nr = renq.alloc = 0;
+	rename_count = 0;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -292,19 +291,19 @@ void diffcore_rename(int detect_rename, 
 			struct diff_filespec *one = rename_src[j].one;
 			if (!is_exact_match(one, two))
 				continue;
-			record_rename_pair(&renq, i, j, MAX_SCORE);
+			record_rename_pair(i, j, MAX_SCORE);
+			rename_count++;
 			break; /* we are done with this entry */
 		}
 	}
-	diff_debug_queue("done detecting exact", &renq);
 
 	/* Have we run out the created file pool?  If so we can avoid
 	 * doing the delta matrix altogether.
 	 */
-	if (renq.nr == rename_dst_nr)
+	if (rename_count == rename_dst_nr)
 		goto cleanup;
 
-	num_create = (rename_dst_nr - renq.nr);
+	num_create = (rename_dst_nr - rename_count);
 	num_src = rename_src_nr;
 	mx = xmalloc(sizeof(*mx) * num_create * num_src);
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
@@ -330,14 +329,14 @@ void diffcore_rename(int detect_rename, 
 			continue; /* already done, either exact or fuzzy. */
 		if (mx[i].score < minimum_score)
 			break; /* there is no more usable pair. */
-		record_rename_pair(&renq, mx[i].dst, mx[i].src, mx[i].score);
+		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
+		rename_count++;
 	}
 	free(mx);
-	diff_debug_queue("done detecting fuzzy", &renq);
 
  cleanup:
 	/* At this point, we have found some renames and copies and they
-	 * are kept in renq.  The original list is still in *q.
+	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
@@ -372,9 +371,9 @@ void diffcore_rename(int detect_rename, 
 			 *
 			 * (1) this is a broken delete and the counterpart
 			 *     broken create remains in the output; or
-			 * (2) this is not a broken delete, and renq does
-			 *     not have a rename/copy to move p->one->path
-			 *     out.
+			 * (2) this is not a broken delete, and rename_dst
+			 *     does not have a rename/copy to move p->one->path
+			 *     out of existence.
 			 *
 			 * Otherwise, the counterpart broken create
 			 * has been turned into a rename-edit; or
@@ -390,11 +389,16 @@ void diffcore_rename(int detect_rename, 
 					pair_to_free = p;
 			}
 			else {
-				for (j = 0; j < renq.nr; j++)
-					if (!strcmp(renq.queue[j]->one->path,
-						    p->one->path))
-						break;
-				if (j < renq.nr)
+				for (j = 0; j < rename_dst_nr; j++) {
+					if (!rename_dst[j].pair)
+						continue;
+					if (strcmp(rename_dst[j].pair->
+						   one->path,
+						   p->one->path))
+						continue;
+					break;
+				}
+				if (j < rename_dst_nr)
 					/* this path remains */
 					pair_to_free = p;
 			}
@@ -416,7 +420,6 @@ void diffcore_rename(int detect_rename, 
 	}
 	diff_debug_queue("done copying original", &outq);
 
-	free(renq.queue);
 	free(q->queue);
 	*q = outq;
 	diff_debug_queue("done collapsing", q);
@@ -438,6 +441,11 @@ void diffcore_rename(int detect_rename, 
 		}
 	}
 
+	for (i = 0; i < rename_dst_nr; i++) {
+		diff_free_filespec_data(rename_dst[i].two);
+		free(rename_dst[i].two);
+	}
+
 	free(rename_dst);
 	rename_dst = NULL;
 	rename_dst_nr = rename_dst_alloc = 0;
