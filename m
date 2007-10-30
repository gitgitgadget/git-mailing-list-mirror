From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 3/3] handle renames using similarity engine
Date: Tue, 30 Oct 2007 00:24:42 -0400
Message-ID: <20071030042442.GC14954@sigill.intra.peff.net>
References: <20071030042118.GA14729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy C <andychup@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:25:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imiex-0007Fw-7p
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbXJ3EYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbXJ3EYq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:24:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1288 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbXJ3EYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:24:45 -0400
Received: (qmail 29761 invoked by uid 111); 30 Oct 2007 04:24:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Oct 2007 00:24:43 -0400
Received: (qmail 15004 invoked by uid 1000); 30 Oct 2007 04:24:42 -0000
Content-Disposition: inline
In-Reply-To: <20071030042118.GA14729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62658>

This changes diffcore-rename to use the engine in
similarity.c rather than doing an O(m*n) loop around
diffcore_count_changes.

Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore-rename.c |  215 +++++++++++++++++++----------------------------------
 1 files changed, 76 insertions(+), 139 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index ba038af..6c0d2d0 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,12 +5,21 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
+#include "similarity.h"
 
-/* Table of rename/copy destinations */
+/* Table of rename/copy src files */
+static struct diff_rename_src {
+	struct diff_filespec *one;
+	unsigned short score; /* to remember the break score */
+} *rename_src;
+static int rename_src_nr, rename_src_alloc;
 
+/* Table of rename/copy destinations */
 static struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
+	struct diff_rename_src *best_match;
+	unsigned score;
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
 
@@ -49,16 +58,11 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	rename_dst[first].two = alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
 	rename_dst[first].pair = NULL;
+	rename_dst[first].best_match = NULL;
+	rename_dst[first].score = 0;
 	return &(rename_dst[first]);
 }
 
-/* Table of rename/copy src files */
-static struct diff_rename_src {
-	struct diff_filespec *one;
-	unsigned short score; /* to remember the break score */
-} *rename_src;
-static int rename_src_nr, rename_src_alloc;
-
 static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 						   unsigned short score)
 {
@@ -109,88 +113,6 @@ static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
 		(!dst_len || dst->path[dst_len - 1] == '/');
 }
 
-struct diff_score {
-	int src; /* index in rename_src */
-	int dst; /* index in rename_dst */
-	int score;
-	int name_score;
-};
-
-static int estimate_similarity(struct diff_filespec *src,
-			       struct diff_filespec *dst,
-			       int minimum_score)
-{
-	/* src points at a file that existed in the original tree (or
-	 * optionally a file in the destination tree) and dst points
-	 * at a newly created file.  They may be quite similar, in which
-	 * case we want to say src is renamed to dst or src is copied into
-	 * dst, and then some edit has been applied to dst.
-	 *
-	 * Compare them and return how similar they are, representing
-	 * the score as an integer between 0 and MAX_SCORE.
-	 *
-	 * When there is an exact match, it is considered a better
-	 * match than anything else; the destination does not even
-	 * call into this function in that case.
-	 */
-	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
-	unsigned long delta_limit;
-	int score;
-
-	/* We deal only with regular files.  Symlink renames are handled
-	 * only when they are exact matches --- in other words, no edits
-	 * after renaming.
-	 */
-	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
-		return 0;
-
-	/*
-	 * Need to check that source and destination sizes are
-	 * filled in before comparing them.
-	 *
-	 * If we already have "cnt_data" filled in, we know it's
-	 * all good (avoid checking the size for zero, as that
-	 * is a possible size - we really should have a flag to
-	 * say whether the size is valid or not!)
-	 */
-	if (!src->cnt_data && diff_populate_filespec(src, 0))
-		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
-		return 0;
-
-	max_size = ((src->size > dst->size) ? src->size : dst->size);
-	base_size = ((src->size < dst->size) ? src->size : dst->size);
-	delta_size = max_size - base_size;
-
-	/* We would not consider edits that change the file size so
-	 * drastically.  delta_size must be smaller than
-	 * (MAX_SCORE-minimum_score)/MAX_SCORE * min(src->size, dst->size).
-	 *
-	 * Note that base_size == 0 case is handled here already
-	 * and the final score computation below would not have a
-	 * divide-by-zero issue.
-	 */
-	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
-		return 0;
-
-	delta_limit = (unsigned long)
-		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
-	if (diffcore_count_changes(src, dst,
-				   &src->cnt_data, &dst->cnt_data,
-				   delta_limit,
-				   &src_copied, &literal_added))
-		return 0;
-
-	/* How similar are they?
-	 * what percentage of material in dst are from source?
-	 */
-	if (!dst->size)
-		score = 0; /* should not happen */
-	else
-		score = (int)(src_copied * MAX_SCORE / max_size);
-	return score;
-}
-
 static void record_rename_pair(int dst_index, int src_index, int score)
 {
 	struct diff_filespec *src, *dst;
@@ -215,20 +137,6 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 	rename_dst[dst_index].pair = dp;
 }
 
-/*
- * We sort the rename similarity matrix with the score, in descending
- * order (the most similar first).
- */
-static int score_compare(const void *a_, const void *b_)
-{
-	const struct diff_score *a = a_, *b = b_;
-
-	if (a->score == b->score)
-		return b->name_score - a->name_score;
-
-	return b->score - a->score;
-}
-
 struct file_similarity {
 	int src_dst, index;
 	struct diff_filespec *filespec;
@@ -376,6 +284,67 @@ static int find_exact_renames(void)
 	return i;
 }
 
+static void record_similarity(void *vsrc, void *vdst, unsigned score)
+{
+	struct diff_rename_src *src = vsrc;
+	struct diff_rename_dst *dst = vdst;
+	unsigned max_size = (src->one->size > dst->two->size) ?
+				src->one->size : dst->two->size;
+
+	score = (dst->two->size != 0) ? (score * MAX_SCORE / max_size) : 0;
+
+	/* Is there a match already that is better than we are? */
+	if (dst->best_match) {
+		if (score < dst->score)
+			return;
+		if (score == dst->score && !basename_same(src->one, dst->two))
+			return;
+	}
+
+	dst->best_match = src;
+	dst->score = score;
+}
+
+static void find_approximate_renames(int minimum_score)
+{
+	struct similarity sim;
+	int i;
+
+	similarity_init(&sim);
+
+	for (i = 0; i < rename_src_nr; i++) {
+		struct diff_rename_src *s = &rename_src[i];
+		diff_populate_filespec(s->one, 0);
+		similarity_add(&sim, SIMILARITY_SOURCE, s,
+				s->one->data, s->one->size,
+				diff_filespec_is_binary(s->one));
+		diff_free_filespec_data(s->one);
+	}
+
+	for (i = 0; i < rename_dst_nr; i++) {
+		struct diff_rename_dst *d = &rename_dst[i];
+		if (d->pair)
+			continue;
+		diff_populate_filespec(d->two, 0);
+		similarity_add(&sim, SIMILARITY_DEST, d,
+				d->two->data, d->two->size,
+				diff_filespec_is_binary(d->two));
+		diff_free_filespec_data(d->two);
+	}
+
+	similarity_score(&sim);
+	similarity_report(&sim, record_similarity);
+
+	for (i = 0 ; i < rename_dst_nr; i++) {
+		struct diff_rename_dst *d = &rename_dst[i];
+		if (d->pair)
+			continue;
+		if (d->score < minimum_score)
+			continue;
+		record_rename_pair(i, d->best_match - rename_src, d->score);
+	}
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -383,9 +352,8 @@ void diffcore_rename(struct diff_options *options)
 	int rename_limit = options->rename_limit;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	struct diff_score *mx;
-	int i, j, rename_count;
-	int num_create, num_src, dst_cnt;
+	int num_create, num_src;
+	int i, rename_count;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -462,38 +430,7 @@ void diffcore_rename(struct diff_options *options)
 	if (num_create * num_src > rename_limit * rename_limit)
 		goto cleanup;
 
-	mx = xmalloc(sizeof(*mx) * num_create * num_src);
-	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
-		int base = dst_cnt * num_src;
-		struct diff_filespec *two = rename_dst[i].two;
-		if (rename_dst[i].pair)
-			continue; /* dealt with exact match already. */
-		for (j = 0; j < rename_src_nr; j++) {
-			struct diff_filespec *one = rename_src[j].one;
-			struct diff_score *m = &mx[base+j];
-			m->src = j;
-			m->dst = i;
-			m->score = estimate_similarity(one, two,
-						       minimum_score);
-			m->name_score = basename_same(one, two);
-			diff_free_filespec_blob(one);
-		}
-		/* We do not need the text anymore */
-		diff_free_filespec_blob(two);
-		dst_cnt++;
-	}
-	/* cost matrix sorted by most to least similar pair */
-	qsort(mx, num_create * num_src, sizeof(*mx), score_compare);
-	for (i = 0; i < num_create * num_src; i++) {
-		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
-		if (dst->pair)
-			continue; /* already done, either exact or fuzzy. */
-		if (mx[i].score < minimum_score)
-			break; /* there is no more usable pair. */
-		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
-		rename_count++;
-	}
-	free(mx);
+	find_approximate_renames(minimum_score);
 
  cleanup:
 	/* At this point, we have found some renames and copies and they
-- 
1.5.3.4
