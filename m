From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 7/8] log -L: add --full-line-diff option
Date: Tue, 14 Dec 2010 03:03:30 +0100
Message-ID: <85560a0a59acfea783a47b9450a3b4b095766a3c.1292291624.git.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKFY-0008W1-3T
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056Ab0LNCDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:43 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:52107 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759043Ab0LNCDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:39 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:30 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:33 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
In-Reply-To: <cover.1292291624.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163617>

From: Bo Yang <struggleyb.nku@gmail.com>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-log.txt |    4 ++++
 builtin/log.c             |    8 +++++++-
 line.c                    |   22 ++++++++++++++++------
 revision.c                |    2 ++
 revision.h                |    3 ++-
 5 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 7fcf6e7..f5769bf 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -79,6 +79,10 @@ include::line-range-format.txt[]
 You can specify this option more than once.
 
 
+--full-line-diff::
+	Always print the interesting range even if the current commit
+	does not change any line of the range.
+
 [\--] <path>...::
 	Show only commits that affect any of the specified paths. To
 	prevent confusion with options and branch names, paths may need
diff --git a/builtin/log.c b/builtin/log.c
index 342d4de..fa57306 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -99,6 +99,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 	int decoration_given = 0;
+	static int full_line_diff;
 	struct userformat_want w;
 	static struct line_opt_callback_data line_cb = {0};
 
@@ -106,6 +107,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
 			     "Process line range n,m in file, counting from 1",
 			     log_line_range_callback),
+		OPT_BOOLEAN(0, "full-line-diff", &full_line_diff,
+			    "Always print the interesting range even if the \
+			    current commit does not change any line of it"),
 		OPT_END()
 	};
 
@@ -188,8 +192,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	}
 
 	/* Test whether line level history is asked for */
-	if (rev->line_level_traverse)
+	if (rev->line_level_traverse) {
 		line_log_init(rev, line_cb.ranges);
+		rev->full_line_diff = full_line_diff;
+	}
 
 	setup_pager();
 }
diff --git a/line.c b/line.c
index 0b297e4..3feca02 100644
--- a/line.c
+++ b/line.c
@@ -1370,10 +1370,18 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	/*
 	 * the ranges that touch no different file, in this case
 	 * the line number will not change, and of course we have
-	 * no sensible rang->pair since there is no diff run.
+	 * no sensible range->pair since there is no diff run.
 	 */
-	if (!one)
+	if (!one) {
+		if (rev->full_line_diff) {
+			chunk.two = two->data;
+			chunk.two_end = (const char *)two->data + two->size;
+			chunk.ltwo = 1;
+			chunk.range = range;
+			diff_flush_chunks(&rev->diffopt, &chunk);
+		}
 		return;
+	}
 
 	if (range->status == DIFF_STATUS_DELETED)
 		die("We are following an nonexistent file, interesting!");
@@ -1495,7 +1503,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	struct strbuf *msgbuf;
 
 	if (!range || !(c->object.flags & NONTRIVIAL_MERGE ||
-			c->object.flags & NEED_PRINT))
+			c->object.flags & NEED_PRINT ||
+			rev->full_line_diff))
 		return;
 
 	if (rev->graph)
@@ -1516,7 +1525,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		flush_nontrivial_merge(rev, nontrivial);
 	else {
 		while (range) {
-			if (range->diff)
+			if (range->diff || (range->nr && rev->full_line_diff))
 				diff_flush_filepair(rev, range);
 			range = range->next;
 		}
@@ -1573,7 +1582,7 @@ int line_log_walk(struct rev_info *rev)
 	/* Clear the flags */
 	while (list) {
 		list->item->object.flags &= ~(RANGE_UPDATE | NONTRIVIAL_MERGE |
-						NEED_PRINT | EVIL_MERGE);
+				NEED_PRINT | EVIL_MERGE);
 		list = list->next;
 	}
 
@@ -1593,7 +1602,8 @@ int line_log_walk(struct rev_info *rev)
 		}
 
 		if (commit->object.flags & NEED_PRINT ||
-		    commit->object.flags & NONTRIVIAL_MERGE)
+		    commit->object.flags & NONTRIVIAL_MERGE ||
+		    rev->full_line_diff)
 			line_log_flush(rev, commit);
 
 		clear_commit_line_range(rev, commit);
diff --git a/revision.c b/revision.c
index fbebf2f..85a60d0 100644
--- a/revision.c
+++ b/revision.c
@@ -1912,6 +1912,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->full_line_diff)
+		revs->dense = 0;
 	if (revs->simplify_merges)
 		simplify_merges(revs);
 	if (revs->children.name)
diff --git a/revision.h b/revision.h
index 6100904..29babf3 100644
--- a/revision.h
+++ b/revision.h
@@ -73,7 +73,8 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+			full_line_diff:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
1.7.3.3.811.g76615
