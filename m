From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Redo rename/copy detection logic.
Date: Tue, 24 May 2005 01:10:48 -0700
Message-ID: <7vu0ktvybb.fsf@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
	<7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
	<7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231644560.2307@ppc970.osdl.org>
	<7vll651nth.fsf@assigned-by-dhcp.cox.net>
	<7vk6lpyz5i.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 10:13:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaUWS-00049s-Ns
	for gcvg-git@gmane.org; Tue, 24 May 2005 10:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVEXINg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 04:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVEXINg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 04:13:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54704 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261423AbVEXIKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 04:10:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524081048.ZZDP19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 04:10:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Earlier implementation had a major screw-up in the memory
management area.  Rename/copy logic sometimes borrowed a pointer
to a structure without any provision for downstream to determine
which pointer is shared and which is not.  This resulted in the
later clean-up code to sometimes double free such structure,
resulting in a segfault.  This made -M and -C useless.

Another problem the earlier implementation had was that it
reordered the patches, and forced the logic to differentiate
renames and copies to depend on that particular order.  This
problem was fixed by teaching rename/copy detection logic not to
do any reordering, and rename-copy differentiator not to depend
on the order of the patches.  The diffs will leave rename/copy
detector in the same destination path order as the patch that
was fed into it.  Some test vectors have been reordered to
accommodate this change.

It also adds a sanity check logic to the human-readable diff-raw
output to detect paths with embedded TAB and LF characters,
which cannot be expressed with that format.  This idea came up
during a discussion with Chris Wedgwood.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c                         |  117 ++++++++++--
diffcore-rename.c              |  393 +++++++++++++++++++----------------------
diffcore.h                     |   16 +
t/t4003-diff-rename-1.sh       |   16 -
t/t4004-diff-rename-symlink.sh |   14 -
t/t4005-diff-rename-2.sh       |   18 -
6 files changed, 318 insertions(+), 256 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -493,8 +493,6 @@ struct diff_filepair *diff_queue(struct 
 	dp->one = one;
 	dp->two = two;
 	dp->score = 0;
-	dp->orig_order = queue->nr;
-	dp->rename_rank = 0;
 	diff_q(queue, dp);
 	return dp;
 }
@@ -505,6 +503,17 @@ static void diff_flush_raw(struct diff_f
 {
 	int two_paths;
 	char status[10];
+
+	if (line_termination) {
+		const char *err = "path %s cannot be expressed without -z";
+		if (strchr(p->one->path, line_termination) ||
+		    strchr(p->one->path, inter_name_termination))
+			die(err, p->one->path);
+		if (strchr(p->two->path, line_termination) ||
+		    strchr(p->two->path, inter_name_termination))
+			die(err, p->two->path);
+	}
+
 	switch (p->status) {
 	case 'C': case 'R':
 		two_paths = 1;
@@ -628,41 +637,110 @@ int diff_needs_to_stay(struct diff_queue
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	return q->nr == 0;
+	int i;
+	for (i = 0; i < q->nr; i++)
+		if (!diff_unmodified_pair(q->queue[i]))
+			return 0;
+	return 1;
 }
 
-static void diff_resolve_rename_copy(void)
+#if DIFF_DEBUG
+void diff_debug_filespec(struct diff_filespec *s, int x, const char *one)
+{
+	fprintf(stderr, "queue[%d] %s (%s) %s %06o %s\n",
+		x, one ? : "",
+		s->path,
+		DIFF_FILE_VALID(s) ? "valid" : "invalid",
+		s->mode,
+		s->sha1_valid ? sha1_to_hex(s->sha1) : "");
+	fprintf(stderr, "queue[%d] %s size %lu flags %d\n",
+		x, one ? : "",
+		s->size, s->xfrm_flags);
+}
+
+void diff_debug_filepair(const struct diff_filepair *p, int i)
+{
+	diff_debug_filespec(p->one, i, "one");
+	diff_debug_filespec(p->two, i, "two");
+	fprintf(stderr, "score %d, status %c\n",
+		p->score, p->status ? : '?');
+}
+
+void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
 {
 	int i;
-	struct diff_queue_struct *q = &diff_queued_diff;
+	if (msg)
+		fprintf(stderr, "%s\n", msg);
+	fprintf(stderr, "q->nr = %d\n", q->nr);
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+		diff_debug_filepair(p, i);
+	}
+}
+#endif
+
+static void diff_resolve_rename_copy(void)
+{
+	int i, j;
+	struct diff_filepair *p, *pp;
+	struct diff_queue_struct *q = &diff_queued_diff;
+
+	/* This should not depend on the ordering of things. */
+
+	diff_debug_queue("resolve-rename-copy", q);
+
+	for (i = 0; i < q->nr; i++) {
+		p = q->queue[i];
 		p->status = 0;
 		if (DIFF_PAIR_UNMERGED(p))
 			p->status = 'U';
 		else if (!DIFF_FILE_VALID((p)->one))
 			p->status = 'N';
 		else if (!DIFF_FILE_VALID((p)->two)) {
-			/* maybe earlier one said 'R', meaning
-			 * it will take it, in which case we do
-			 * not need to keep 'D'.
+			/* Deletion record should be omitted if there
+			 * is another entry that is a rename or a copy
+			 * and it uses this one as the source.  Then we
+			 * can say the other one is a rename.
 			 */
-			int j;
-			for (j = 0; j < i; j++) {
-				struct diff_filepair *pp = q->queue[j];
-				if (pp->status == 'R' &&
-				    !strcmp(pp->one->path, p->one->path))
+			for (j = 0; j < q->nr; j++) {
+				pp = q->queue[j];
+				if (!strcmp(pp->one->path, p->one->path) &&
+				    strcmp(pp->one->path, pp->two->path))
 					break;
 			}
-			if (j < i)
-				continue;
+			if (j < q->nr)
+				continue; /* has rename/copy */
 			p->status = 'D';
 		}
 		else if (strcmp(p->one->path, p->two->path)) {
-			/* This is rename or copy.  Which one is it? */
-			if (diff_needs_to_stay(q, i+1, p->one))
-				p->status = 'C';
-			else
+			/* See if there is somebody else anywhere that
+			 * will keep the path (either modified or
+			 * unmodified).  If so, we have to be a copy,
+			 * not a rename.  In addition, if there is
+			 * some other rename or copy that comes later
+			 * than us that uses the same source, we
+			 * cannot be a rename either.
+			 */
+			for (j = 0; j < q->nr; j++) {
+				pp = q->queue[j];
+				if (strcmp(pp->one->path, p->one->path))
+					continue;
+				if (!strcmp(pp->one->path, pp->two->path)) {
+					if (DIFF_FILE_VALID(pp->two)) {
+						/* non-delete */
+						p->status = 'C';
+						break;
+					}
+					continue;
+				}
+				/* pp is a rename/copy ... */
+				if (i < j) {
+					/* ... and comes later than us */
+					p->status = 'C';
+					break;
+				}
+			}
+			if (!p->status)
 				p->status = 'R';
 		}
 		else if (memcmp(p->one->sha1, p->two->sha1, 20))
@@ -672,6 +750,7 @@ static void diff_resolve_rename_copy(voi
 			p->status = 0;
 		}
 	}
+	diff_debug_queue("resolve-rename-copy done", q);
 }
 
 void diff_flush(int diff_output_style, int resolve_rename_copy)
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,29 +6,92 @@
 #include "diffcore.h"
 #include "delta.h"
 
-struct diff_rename_pool {
-	struct diff_filespec **s;
-	int nr, alloc;
-};
-
-static void diff_rename_pool_clear(struct diff_rename_pool *pool)
-{
-	pool->s = NULL; pool->nr = pool->alloc = 0;
-}
+/* Table of rename/copy destinations */
 
-static void diff_rename_pool_add(struct diff_rename_pool *pool,
-				 struct diff_filespec *s)
-{
-	if (S_ISDIR(s->mode))
-		return;  /* no trees, please */
-
-	if (pool->alloc <= pool->nr) {
-		pool->alloc = alloc_nr(pool->alloc);
-		pool->s = xrealloc(pool->s,
-				   sizeof(*(pool->s)) * pool->alloc);
+static struct diff_rename_dst {
+	struct diff_filespec *two;
+	struct diff_filepair *pair;
+} *rename_dst;
+static int rename_dst_nr, rename_dst_alloc;
+
+static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
+						 int insert_ok)
+{
+	int first, last;
+
+	first = 0;
+	last = rename_dst_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct diff_rename_dst *dst = &(rename_dst[next]);
+		int cmp = strcmp(two->path, dst->two->path);
+		if (!cmp)
+			return dst;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
 	}
-	pool->s[pool->nr] = s;
-	pool->nr++;
+	/* not found */
+	if (!insert_ok)
+		return NULL;
+	/* insert to make it at "first" */
+	if (rename_dst_alloc <= rename_dst_nr) {
+		rename_dst_alloc = alloc_nr(rename_dst_alloc);
+		rename_dst = xrealloc(rename_dst,
+				      rename_dst_alloc * sizeof(*rename_dst));
+	}
+	rename_dst_nr++;
+	if (first < rename_dst_nr)
+		memmove(rename_dst + first + 1, rename_dst + first,
+			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
+	rename_dst[first].two = two;
+	rename_dst[first].pair = NULL;
+	return &(rename_dst[first]);
+}
+
+static struct diff_rename_src {
+	struct diff_filespec *one;
+	unsigned src_used : 1;
+} *rename_src;
+static int rename_src_nr, rename_src_alloc;
+
+static struct diff_rename_src *locate_rename_src(struct diff_filespec *one,
+						 int insert_ok)
+{
+	int first, last;
+
+	first = 0;
+	last = rename_src_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct diff_rename_src *src = &(rename_src[next]);
+		int cmp = strcmp(one->path, src->one->path);
+		if (!cmp)
+			return src;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+	/* not found */
+	if (!insert_ok)
+		return NULL;
+	/* insert to make it at "first" */
+	if (rename_src_alloc <= rename_src_nr) {
+		rename_src_alloc = alloc_nr(rename_src_alloc);
+		rename_src = xrealloc(rename_src,
+				      rename_src_alloc * sizeof(*rename_src));
+	}
+	rename_src_nr++;
+	if (first < rename_src_nr)
+		memmove(rename_src + first + 1, rename_src + first,
+			(rename_src_nr - first - 1) * sizeof(*rename_src));
+	rename_src[first].one = one;
+	rename_src[first].src_used = 0;
+	return &(rename_src[first]);
 }
 
 static int is_exact_match(struct diff_filespec *src, struct diff_filespec *dst)
@@ -46,8 +109,8 @@ static int is_exact_match(struct diff_fi
 }
 
 struct diff_score {
-	struct diff_filespec *src;
-	struct diff_filespec *dst;
+	int src; /* index in rename_src */
+	int dst; /* index in rename_dst */
 	int score;
 	int rank;
 };
@@ -113,92 +176,28 @@ static int estimate_similarity(struct di
 	return score;
 }
 
-static void record_rename_pair(struct diff_queue_struct *outq,
-			       struct diff_filespec *src,
-			       struct diff_filespec *dst,
-			       int rank,
-			       int score)
+static void record_rename_pair(struct diff_queue_struct *renq,
+			       int dst_index, int src_index, int score)
 {
-	/*
-	 * These ranks are used to sort the final output, because there
-	 * are certain dependencies:
-	 *
-	 *  1. rename/copy that depends on deleted ones.
-	 *  2. deletions in the original.
-	 *  3. rename/copy that depends on the pre-edit image of kept files.
-	 *  4. additions, modifications and no-modifications in the original.
-	 *  5. rename/copy that depends on the post-edit image of kept files
-	 *     (note that we currently do not detect such rename/copy).
-	 *
-	 * The downstream diffcore transformers are free to reorder
-	 * the entries as long as they keep file pairs that has the
-	 * same p->one->path in earlier rename_rank to appear before
-	 * later ones.
-	 *
-	 * To the final output routine, and in the diff-raw format
-	 * output, a rename/copy that is based on a path that has a
-	 * later entry that shares the same p->one->path and is not a
-	 * deletion is a copy.  Otherwise it is a rename.
-	 */
+	struct diff_filespec *one, *two, *src, *dst;
+	struct diff_filepair *dp;
 
-	struct diff_filepair *dp = diff_queue(outq, src, dst);
-	dp->rename_rank = rank * 2 + 1;
-	dp->score = score;
-	dst->xfrm_flags |= RENAME_DST_MATCHED;
-}
+	if (rename_dst[dst_index].pair)
+		die("internal error: dst already matched.");
 
-#if 0
-static void debug_filespec(struct diff_filespec *s, int x, const char *one)
-{
-	fprintf(stderr, "queue[%d] %s (%s) %s %06o %s\n",
-		x, one,
-		s->path,
-		DIFF_FILE_VALID(s) ? "valid" : "invalid",
-		s->mode,
-		s->sha1_valid ? sha1_to_hex(s->sha1) : "");
-	fprintf(stderr, "queue[%d] %s size %lu flags %d\n",
-		x, one,
-		s->size, s->xfrm_flags);
-}
+	src = rename_src[src_index].one;
+	one = alloc_filespec(src->path);
+	fill_filespec(one, src->sha1, src->mode);
 
-static void debug_filepair(const struct diff_filepair *p, int i)
-{
-	debug_filespec(p->one, i, "one");
-	debug_filespec(p->two, i, "two");
-	fprintf(stderr, "pair rank %d, orig order %d, score %d\n",
-		p->rename_rank, p->orig_order, p->score);
-}
+	dst = rename_dst[dst_index].two;
+	two = alloc_filespec(dst->path);
+	fill_filespec(two, dst->sha1, dst->mode);
 
-static void debug_queue(const char *msg, struct diff_queue_struct *q)
-{
-	int i;
-	if (msg)
-		fprintf(stderr, "%s\n", msg);
-	fprintf(stderr, "q->nr = %d\n", q->nr);
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		debug_filepair(p, i);
-	}
-}
-#else
-#define debug_queue(a,b) do { ; /*nothing*/ } while(0)
-#endif
+	dp = diff_queue(renq, one, two);
+	dp->score = score;
 
-/*
- * We sort the outstanding diff entries according to the rank (see
- * comment at the beginning of record_rename_pair) and tiebreak with
- * the order in the original input.
- */
-static int rank_compare(const void *a_, const void *b_)
-{
-	const struct diff_filepair *a = *(const struct diff_filepair **)a_;
-	const struct diff_filepair *b = *(const struct diff_filepair **)b_;
-	int a_rank = a->rename_rank;
-	int b_rank = b->rename_rank;
-
-	if (a_rank != b_rank)
-		return a_rank - b_rank;
-	return a->orig_order - b->orig_order;
+	rename_src[src_index].src_used = 1;
+	rename_dst[dst_index].pair = dp;
 }
 
 /*
@@ -232,24 +231,15 @@ int diff_scoreopt_parse(const char *opt)
 void diffcore_rename(int detect_rename, int minimum_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
-	struct diff_rename_pool created, deleted, stay;
-	struct diff_rename_pool *(srcs[2]);
+	struct diff_queue_struct renq, outq;
 	struct diff_score *mx;
-	int h, i, j;
-	int num_create, num_src, dst_cnt, src_cnt;
+	int i, j;
+	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_MINIMUM_SCORE;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
-
-	diff_rename_pool_clear(&created);
-	diff_rename_pool_clear(&deleted);
-	diff_rename_pool_clear(&stay);
-
-	srcs[0] = &deleted;
-	srcs[1] = &stay;
+	renq.queue = NULL;
+	renq.nr = renq.alloc = 0;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -257,76 +247,70 @@ void diffcore_rename(int detect_rename, 
 			if (!DIFF_FILE_VALID(p->two))
 				continue; /* unmerged */
 			else
-				diff_rename_pool_add(&created, p->two);
+				locate_rename_dst(p->two, 1);
 		else if (!DIFF_FILE_VALID(p->two))
-			diff_rename_pool_add(&deleted, p->one);
+			locate_rename_src(p->one, 1);
 		else if (1 < detect_rename) /* find copy, too */
-			diff_rename_pool_add(&stay, p->one);
+			locate_rename_src(p->one, 1);
 	}
-	if (created.nr == 0)
+	if (rename_dst_nr == 0)
 		goto cleanup; /* nothing to do */
 
 	/* We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 */
-	for (i = 0; i < created.nr; i++) {
-		for (h = 0; h < sizeof(srcs)/sizeof(srcs[0]); h++) {
-			struct diff_rename_pool *p = srcs[h];
-			for (j = 0; j < p->nr; j++) {
-				if (!is_exact_match(p->s[j], created.s[i]))
-					continue;
-				record_rename_pair(&outq,
-						   p->s[j], created.s[i], h,
-						   MAX_SCORE);
-				break; /* we are done with this entry */
-			}
+	for (i = 0; i < rename_dst_nr; i++) {
+		struct diff_filespec *two = rename_dst[i].two;
+		for (j = 0; j < rename_src_nr; j++) {
+			struct diff_filespec *one = rename_src[j].one;
+			if (!is_exact_match(one, two))
+				continue;
+			record_rename_pair(&renq, i, j, MAX_SCORE);
+			break; /* we are done with this entry */
 		}
 	}
-	debug_queue("done detecting exact", &outq);
+	diff_debug_queue("done detecting exact", &renq);
 
 	/* Have we run out the created file pool?  If so we can avoid
 	 * doing the delta matrix altogether.
 	 */
-	if (outq.nr == created.nr)
+	if (renq.nr == rename_dst_nr)
 		goto flush_rest;
 
-	num_create = (created.nr - outq.nr);
-	num_src = deleted.nr + stay.nr;
+	num_create = (rename_dst_nr - renq.nr);
+	num_src = rename_src_nr;
 	mx = xmalloc(sizeof(*mx) * num_create * num_src);
-	for (dst_cnt = i = 0; i < created.nr; i++) {
+	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		int base = dst_cnt * num_src;
-		if (created.s[i]->xfrm_flags & RENAME_DST_MATCHED)
+		struct diff_filespec *two = rename_dst[i].two;
+		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
-		for (src_cnt = h = 0; h < sizeof(srcs)/sizeof(srcs[0]); h++) {
-			struct diff_rename_pool *p = srcs[h];
-			for (j = 0; j < p->nr; j++, src_cnt++) {
-				struct diff_score *m = &mx[base + src_cnt];
-				m->src = p->s[j];
-				m->dst = created.s[i];
-				m->score = estimate_similarity(m->src, m->dst,
-							       minimum_score);
-				m->rank = h;
-			}
+		for (j = 0; j < rename_src_nr; j++) {
+			struct diff_filespec *one = rename_src[j].one;
+			struct diff_score *m = &mx[base+j];
+			m->src = j;
+			m->dst = i;
+			m->score = estimate_similarity(one, two,
+						       minimum_score);
 		}
 		dst_cnt++;
 	}
 	/* cost matrix sorted by most to least similar pair */
 	qsort(mx, num_create * num_src, sizeof(*mx), score_compare);
 	for (i = 0; i < num_create * num_src; i++) {
-		if (mx[i].dst->xfrm_flags & RENAME_DST_MATCHED)
-			continue; /* alreayd done, either exact or fuzzy. */
+		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
+		if (dst->pair)
+			continue; /* already done, either exact or fuzzy. */
 		if (mx[i].score < minimum_score)
 			break; /* there is not any more diffs applicable. */
-		record_rename_pair(&outq,
-				  mx[i].src, mx[i].dst, mx[i].rank,
-				  mx[i].score);
+		record_rename_pair(&renq, mx[i].dst, mx[i].src, mx[i].score);
 	}
 	free(mx);
-	debug_queue("done detecting fuzzy", &outq);
+	diff_debug_queue("done detecting fuzzy", &renq);
 
  flush_rest:
 	/* At this point, we have found some renames and copies and they
-	 * are kept in outq.  The original list is still in *q.
+	 * are kept in renq.  The original list is still in *q.
 	 *
 	 * Scan the original list and move them into the outq; we will sort
 	 * outq and swap it into the queue supplied to pass that to
@@ -335,68 +319,61 @@ void diffcore_rename(int detect_rename, 
 	 * See comments at the top of record_rename_pair for numbers used
 	 * to assign rename_rank.
 	 */
+	outq.queue = NULL;
+	outq.nr = outq.alloc = 0;
 	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *dp, *p = q->queue[i];
-		if (!DIFF_FILE_VALID(p->one)) {
-			/* creation or unmerged entries */
-			dp = diff_queue(&outq, p->one, p->two);
-			dp->rename_rank = 4;
-		}
-		else if (!DIFF_FILE_VALID(p->two)) {
-			/* deletion */
-			dp = diff_queue(&outq, p->one, p->two);
-			dp->rename_rank = 2;
+		struct diff_filepair *p = q->queue[i];
+		struct diff_rename_src *src = locate_rename_src(p->one, 0);
+		struct diff_rename_dst *dst = locate_rename_dst(p->two, 0);
+		struct diff_filepair *pair_to_free = NULL;
+
+		if (dst) {
+			/* creation */
+			if (dst->pair) {
+				/* renq has rename/copy already to produce
+				 * this file, so we do not emit the creation
+				 * record in the output.
+				 */
+				diff_q(&outq, dst->pair);
+				pair_to_free = p;
+			}
+			else
+				/* no matching rename/copy source, so record
+				 * this as a creation.
+				 */
+				diff_q(&outq, p);
 		}
+		else if (!diff_unmodified_pair(p))
+			/* all the other cases need to be recorded as is */
+			diff_q(&outq, p);
 		else {
-			/* modification, or stay as is */
-			dp = diff_queue(&outq, p->one, p->two);
-			dp->rename_rank = 4;
-		}
-		free(p);
-	}
-	debug_queue("done copying original", &outq);
-
-	/* Sort outq */
-	qsort(outq.queue, outq.nr, sizeof(outq.queue[0]), rank_compare);
-
-	debug_queue("done sorting", &outq);
-
-	free(q->queue);
-	q->nr = q->alloc = 0;
-	q->queue = NULL;
-
-	/* Copy it out to q, removing duplicates. */
-	for (i = 0; i < outq.nr; i++) {
-		struct diff_filepair *p = outq.queue[i];
-		if (!DIFF_FILE_VALID(p->one)) {
-			/* created or unmerged */
-			if (p->two->xfrm_flags & RENAME_DST_MATCHED)
-				; /* rename/copy created it already */
+			/* unmodified pair needs to be recorded only if
+			 * it is used as the source of rename/copy
+			 */
+			if (src && src->src_used)
+				diff_q(&outq, p);
 			else
-				diff_queue(q, p->one, p->two);
-		}
-		else if (!DIFF_FILE_VALID(p->two)) {
-			/* deleted */
-			diff_queue(q, p->one, p->two);
+				pair_to_free = p;
 		}
-		else if (strcmp(p->one->path, p->two->path)) {
-			/* rename or copy */
-			struct diff_filepair *dp =
-				diff_queue(q, p->one, p->two);
-			dp->score = p->score;
+		if (pair_to_free) {
+			diff_free_filespec_data(pair_to_free->one);
+			diff_free_filespec_data(pair_to_free->two);
+			free(pair_to_free);
 		}
-		else
-			/* otherwise it is a modified (or "stay") entry */
-			diff_queue(q, p->one, p->two);
-		free(p);
 	}
+	diff_debug_queue("done copying original", &outq);
 
-	free(outq.queue);
-	debug_queue("done collapsing", q);
+	free(renq.queue);
+	free(q->queue);
+	*q = outq;
+	diff_debug_queue("done collapsing", q);
 
  cleanup:
-	free(created.s);
-	free(deleted.s);
-	free(stay.s);
+	free(rename_dst);
+	rename_dst = NULL;
+	rename_dst_nr = rename_dst_alloc = 0;
+	free(rename_src);
+	rename_src = NULL;
+	rename_src_nr = rename_src_alloc = 0;
 	return;
 }
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -40,11 +40,6 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	int score; /* only valid when one and two are different paths */
-	int orig_order; /* the original order of insertion into the queue */
-	int rename_rank; /* rename/copy dependency needs to enforce
-			  * certain ordering of patches that later
-			  * diffcore transformations should not break.
-			  */
 	int status; /* M C R N D U (see Documentation/diff-format.txt) */
 };
 #define DIFF_PAIR_UNMERGED(p) \
@@ -67,4 +62,15 @@ extern void diff_q(struct diff_queue_str
 extern int diff_needs_to_stay(struct diff_queue_struct *, int,
 			      struct diff_filespec *);
 
+#define DIFF_DEBUG 0
+#if DIFF_DEBUG
+void diff_debug_filespec(struct diff_filespec *, int, const char *);
+void diff_debug_filepair(const struct diff_filepair *, int);
+void diff_debug_queue(const char *, struct diff_queue_struct *);
+#else
+#define diff_debug_filespec(a,b,c) do {} while(0)
+#define diff_debug_filepair(a,b) do {} while(0)
+#define diff_debug_queue(a,b) do {} while(0)
+#endif
+
 #endif
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -78,14 +78,6 @@ test_expect_success \
 
 GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree >current
 cat >expected <<\EOF
-diff --git a/COPYING b/COPYING.1
-copy from COPYING
-copy to COPYING.1
---- a/COPYING
-+++ b/COPYING.1
-@@ -6 +6 @@
-- HOWEVER, in order to allow a migration to GPLv3 if that seems like
-+ However, in order to allow a migration to GPLv3 if that seems like
 diff --git a/COPYING b/COPYING
 --- a/COPYING
 +++ b/COPYING
@@ -98,6 +90,14 @@ diff --git a/COPYING b/COPYING
 @@ -12 +12 @@
 -	This file is licensed under the GPL v2, or a later version
 +	This file is licensed under the G.P.L v2, or a later version
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
 EOF
 
 test_expect_success \
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -35,6 +35,13 @@ test_expect_success \
 
 GIT_DIFF_OPTS=--unified=0 git-diff-cache -M -p $tree >current
 cat >expected <<\EOF
+diff --git a/bozbar b/bozbar
+new file mode 120000
+--- /dev/null
++++ b/bozbar
+@@ -0,0 +1 @@
++xzzzy
+\ No newline at end of file
 diff --git a/frotz b/nitfol
 similarity index 100%
 copy from frotz
@@ -50,13 +57,6 @@ deleted file mode 100644
 @@ -1 +0,0 @@
 -xyzzy
 \ No newline at end of file
-diff --git a/bozbar b/bozbar
-new file mode 120000
---- /dev/null
-+++ b/bozbar
-@@ -0,0 +1 @@
-+xzzzy
-\ No newline at end of file
 EOF
 
 test_expect_success \
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -101,8 +101,8 @@ test_expect_success \
 
 git-diff-cache -C $tree >current
 cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 M	COPYING
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
 EOF
 
 test_expect_success \
@@ -118,14 +118,6 @@ test_expect_success \
 mv expected diff-raw
 GIT_DIFF_OPTS=--unified=0 git-diff-helper <diff-raw >current
 cat >expected <<\EOF
-diff --git a/COPYING b/COPYING.1
-copy from COPYING
-copy to COPYING.1
---- a/COPYING
-+++ b/COPYING.1
-@@ -6 +6 @@
-- HOWEVER, in order to allow a migration to GPLv3 if that seems like
-+ However, in order to allow a migration to GPLv3 if that seems like
 diff --git a/COPYING b/COPYING
 --- a/COPYING
 +++ b/COPYING
@@ -138,6 +130,14 @@ diff --git a/COPYING b/COPYING
 @@ -12 +12 @@
 -	This file is licensed under the GPL v2, or a later version
 +	This file is licensed under the G.P.L v2, or a later version
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
 EOF
 
 test_expect_success \
------------------------------------------------

