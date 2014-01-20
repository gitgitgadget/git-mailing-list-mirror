From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 3/4] combine-diff: Optimize combine_diff_path sets intersection
Date: Mon, 20 Jan 2014 20:20:40 +0400
Message-ID: <b97e63128093f6c5f5cab854b9b9487c4e6b955a.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 17:34:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5HoB-0003F1-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 17:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbaATQed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 11:34:33 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60905 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbaATQe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 11:34:29 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W5HZB-0007Vq-5D; Mon, 20 Jan 2014 20:19:13 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W5Hb5-0001Q2-Ki; Mon, 20 Jan 2014 20:21:11 +0400
X-Mailer: git-send-email 1.9.rc0.143.g6fd479e
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240717>

Currently, when generating combined diff, for a commit, we intersect
diff paths from diff(parent_0,commit) to diff(parent_i,commit) comparing
all paths pairs, i.e. doing it the quadratic way. That is correct, but
could be optimized:

Paths come from trees in sorted (= tree) order, and so does diff_tree()
emits resulting paths in that order too. Now if we look at diffcore
transformations, all of them, except diffcore_order, preserve resulting
path ordering:

    - skip_stat_unmatch, grep, pickaxe, filter
                            -- just skip elements -> order stays preserved

    - break                 -- just breaks diff for a path, adding path
                               dup after the path -> order stays preserved

    - detect rename/copy    -- resulting paths are emitted sorted
                               (verified empirically)

So only diffcore_order changes diff paths ordering.

But diffcore_order meaning affects only presentation - i.e. only how to
show the diff, so we could do all the internal computations without
paths reordering, and order only resultant paths set. This is faster,
since, if we know two paths sets are all ordered, their intersection
could be done in linear time.

This patch does just that.

Timings for `git log --raw --no-abbrev --no-renames` without `-c` ("git log")
and with `-c` ("git log -c") before and after the patch are as follows:

                linux.git v3.10..v3.11

            log     log -c

    before  1.9s    20.4s
    after   1.9s    16.6s

                navy.git    (private repo)

            log     log -c

    before  0.83s   15.6s
    after   0.83s    2.1s

P.S.

I think linux.git case is sped up not so much as the second one, since
in navy.git, there are more exotic (subtree, etc) merges.

P.P.S.

My tracing showed that the rest of the time (16.6s vs 1.9s) is usually
spent in computing huge diffs from commit to second parent. Will try to
deal with it, if I'll have time.

P.P.P.S.

For combine_diff_path, ->len is not needed anymore - will remove it in
the next noisy cleanup path, to maintain good signal/noise ratio here.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 93 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3b92c448..98c2562 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -15,8 +15,8 @@
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct combine_diff_path *p;
-	int i;
+	struct combine_diff_path *p, *pprev, *ptmp;
+	int i, cmp;
 
 	if (!n) {
 		struct combine_diff_path *list = NULL, **tail = &list;
@@ -47,28 +47,43 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 		return list;
 	}
 
-	for (p = curr; p; p = p->next) {
-		int found = 0;
-		if (!p->len)
+	/*
+	 * NOTE paths are coming sorted here (= in tree order)
+	 */
+
+	pprev = NULL;
+	p = curr;
+	i = 0;
+
+	while (1) {
+		if (!p)
+			break;
+
+		cmp = (i >= q->nr) ? -1
+				   : strcmp(p->path, q->queue[i]->two->path);
+		if (cmp < 0) {
+			if (pprev)
+				pprev->next = p->next;
+			ptmp = p;
+			p = p->next;
+			free(ptmp);
+			if (curr == ptmp)
+				curr = p;
 			continue;
-		for (i = 0; i < q->nr; i++) {
-			const char *path;
-			int len;
+		}
 
-			if (diff_unmodified_pair(q->queue[i]))
-				continue;
-			path = q->queue[i]->two->path;
-			len = strlen(path);
-			if (len == p->len && !memcmp(path, p->path, len)) {
-				found = 1;
-				hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
-				p->parent[n].mode = q->queue[i]->one->mode;
-				p->parent[n].status = q->queue[i]->status;
-				break;
-			}
+		if (cmp > 0) {
+			i++;
+			continue;
 		}
-		if (!found)
-			p->len = 0;
+
+		hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
+		p->parent[n].mode = q->queue[i]->one->mode;
+		p->parent[n].status = q->queue[i]->status;
+
+		pprev = p;
+		p = p->next;
+		i++;
 	}
 	return curr;
 }
@@ -1295,6 +1310,13 @@ static void handle_combined_callback(struct diff_options *opt,
 	free(q.queue);
 }
 
+static const char *path_path(void *obj)
+{
+	struct combine_diff_path *path = (struct combine_diff_path *)obj;
+
+	return path->path;
+}
+
 void diff_tree_combined(const unsigned char *sha1,
 			const struct sha1_array *parents,
 			int dense,
@@ -1310,6 +1332,8 @@ void diff_tree_combined(const unsigned char *sha1,
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	DIFF_OPT_SET(&diffopts, RECURSIVE);
 	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
+	/* tell diff_tree to emit paths in sorted (=tree) order */
+	diffopts.orderfile = NULL;
 
 	show_log_first = !!rev->loginfo && !rev->no_commit_id;
 	needsep = 0;
@@ -1335,6 +1359,13 @@ void diff_tree_combined(const unsigned char *sha1,
 				printf("%s%c", diff_line_prefix(opt),
 				       opt->line_termination);
 		}
+
+		/* if showing diff, show it in requested order */
+		if (diffopts.output_format != DIFF_FORMAT_NO_OUTPUT &&
+		    opt->orderfile) {
+			diffcore_order(opt->orderfile);
+		}
+
 		diff_flush(&diffopts);
 	}
 
@@ -1343,6 +1374,26 @@ void diff_tree_combined(const unsigned char *sha1,
 		if (p->len)
 			num_paths++;
 	}
+
+	/* order paths according to diffcore_order */
+	if (opt->orderfile && num_paths) {
+		struct obj_order *o;
+
+		o = xmalloc(sizeof(*o) * num_paths);
+		for (i = 0, p = paths; p; p = p->next, i++)
+			o[i].obj = p;
+		order_objects(opt->orderfile, path_path, o, num_paths);
+		for (i = 0; i < num_paths - 1; i++) {
+			p = o[i].obj;
+			p->next = o[i+1].obj;
+		}
+
+		p = o[num_paths-1].obj;
+		p->next = NULL;
+		paths = o[0].obj;
+	}
+
+
 	if (num_paths) {
 		if (opt->output_format & (DIFF_FORMAT_RAW |
 					  DIFF_FORMAT_NAME |
-- 
1.9.rc0.143.g6fd479e
