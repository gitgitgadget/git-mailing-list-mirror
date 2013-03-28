From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v10 5/5] Speed up log -L... -M
Date: Thu, 28 Mar 2013 17:47:34 +0100
Message-ID: <03ec60dc6569672539a6e857c946287d85140c3b.1364488205.git.trast@inf.ethz.ch>
References: <cover.1364488205.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULG07-0004bT-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab3C1Qrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:47:53 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35631 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776Ab3C1Qrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:47:39 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:36 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:37 +0100
X-Mailer: git-send-email 1.8.2.446.g2b4de83
In-Reply-To: <cover.1364488205.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219434>

So far log -L only used the implicit diff filtering by pathspec.  If
the user specifies -M, we cannot do that, and so we simply handed the
whole diff queue (which is approximately 'git show --raw') to
diffcore_std().

Unfortunately this is very slow.  We can optimize a lot if we throw
out files that we know cannot possibly be interesting, in the same
spirit that the pathspec filtering reduces the number of files.

However, in this case, we have to be more careful.  Because we want to
look out for renames, we need to keep all filepairs where something
was deleted.

This is a bit hacky and should really be replaced by equivalent
support in --follow, and just using that.  However, in the meantime it
speeds up 'log -M -L' by an order of magnitude.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 line-log.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index 68972e2..30edef4 100644
--- a/line-log.c
+++ b/line-log.c
@@ -750,7 +750,50 @@ static void move_diff_queue(struct diff_queue_struct *dst,
 	DIFF_QUEUE_CLEAR(src);
 }
 
-static void queue_diffs(struct diff_options *opt,
+static void filter_diffs_for_paths(struct line_log_data *range, int keep_deletions)
+{
+	int i;
+	struct diff_queue_struct outq;
+	DIFF_QUEUE_CLEAR(&outq);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct line_log_data *rg = NULL;
+
+		if (!DIFF_FILE_VALID(p->two)) {
+			if (keep_deletions)
+				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
+			continue;
+		}
+		for (rg = range; rg; rg = rg->next) {
+			if (!strcmp(rg->spec->path, p->two->path))
+				break;
+		}
+		if (rg)
+			diff_q(&outq, p);
+		else
+			diff_free_filepair(p);
+	}
+	free(diff_queued_diff.queue);
+	diff_queued_diff = outq;
+}
+
+static inline int diff_might_be_rename(void)
+{
+	int i;
+	for (i = 0; i < diff_queued_diff.nr; i++)
+		if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one)) {
+			/* fprintf(stderr, "diff_might_be_rename found creation of: %s\n", */
+			/* 	diff_queued_diff.queue[i]->two->path); */
+			return 1;
+		}
+	return 0;
+}
+
+static void queue_diffs(struct line_log_data *range,
+			struct diff_options *opt,
 			struct diff_queue_struct *queue,
 			struct commit *commit, struct commit *parent)
 {
@@ -766,7 +809,12 @@ static void queue_diffs(struct diff_options *opt,
 
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 	diff_tree(&desc1, &desc2, "", opt);
-	diffcore_std(opt);
+	if (opt->detect_rename) {
+		filter_diffs_for_paths(range, 1);
+		if (diff_might_be_rename())
+			diffcore_std(opt);
+		filter_diffs_for_paths(range, 0);
+	}
 	move_diff_queue(queue, &diff_queued_diff);
 
 	if (tree1)
@@ -1050,7 +1098,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	if (commit->parents)
 		parent = commit->parents->item;
 
-	queue_diffs(&rev->diffopt, &queue, commit, parent);
+	queue_diffs(range, &rev->diffopt, &queue, commit, parent);
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
@@ -1075,7 +1123,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	for (i = 0; i < nparents; i++) {
 		parents[i] = p->item;
 		p = p->next;
-		queue_diffs(&rev->diffopt, &diffqueues[i], commit, parents[i]);
+		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
 	}
 
 	for (i = 0; i < nparents; i++) {
-- 
1.8.2.446.g2b4de83
