From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 16/18] Add --full-line-diff option
Date: Fri,  6 Aug 2010 00:11:55 +0800
Message-ID: <1281024717-7855-17-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35K-0001XF-Ke
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760046Ab0HEQNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759858Ab0HEQNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:35 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U5Y0I0dEu4fNlwvSVh1E7t95OuGfAbIGrB7bMNysAs0=;
        b=W5fZt9g+k15lbp7To+j04uevcHPCb5r0nDaj1ib0C41c2I4YSCqo+fgv91Ho7MmZPS
         8y2GWTKpPLG3YSFISYr+HbI2AUlRARR5ep+mUz5We32h2HJlK+AFJ0armmM8hEofjMPa
         fjwWKqStIVBwzYuAYpfFIrvlnS/cfra+Mu6rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wtB/g5X+8meGBoNP54F1oW2T5UTRiAzCmc5kxDcwGqsQmt28ytXJ2NKmYGJ8oBn8G+
         qb7GIVDr1Tq0TMmyDFXiOVvjcKRqNtpbooh2olOc1zp9AAHauykW+kkwbmV3Ml1yBIvK
         XuXbI+HhQrGCT2PuQvQyHJe5mkkoZFs6EYvj8=
Received: by 10.142.12.16 with SMTP id 16mr1228159wfl.187.1281024815510;
        Thu, 05 Aug 2010 09:13:35 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152677>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    3 +++
 line.c        |   21 +++++++++++++++------
 revision.c    |    5 ++++-
 revision.h    |    3 ++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0aa982b..9799c1c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -86,6 +86,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 	int decoration_given = 0;
+	static int full_line_diff = 0;
 	struct userformat_want w;
 	const char *path = NULL, *pathspec = NULL;
 	static struct diff_line_range *range = NULL, *r = NULL;
@@ -93,6 +94,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	static struct line_opt_callback_data line_cb = {&range, &ctx, NULL};
 	static const struct option options[] = {
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m", "Process only line range n,m, counting from 1", log_line_range_callback),
+		OPT_BOOLEAN(0, "full-line-diff", &full_line_diff, "Always print the interesting range even if the current commit does not change any line of it"),
 		OPT_END()
 	};
 
@@ -225,6 +227,7 @@ parse_done:
 	/* Test whether line level history is asked for */
 	if (range && range->nr > 0) {
 		setup_line(rev, range);
+		rev->full_line_diff = full_line_diff;
 	}
 }
 
diff --git a/line.c b/line.c
index 7d80da8..7ab0341 100644
--- a/line.c
+++ b/line.c
@@ -1255,9 +1255,16 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	/*
 	 * the ranges that touch no different file, in this case
 	 * the line number will not change, and of course we have
-	 * no sensible rang->pair since there is no diff run.
+	 * no sensible range->pair since there is no diff run.
 	 */
 	if (one == NULL) {
+		if (rev->full_line_diff) {
+			chunk.two = two->data;
+			chunk.two_end = two->data + two->size;
+			chunk.ltwo = 1;
+			chunk.range = range;
+			diff_flush_chunks(&rev->diffopt, &chunk);
+		}
 		return;
 	}
 
@@ -1378,8 +1385,9 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	char *line_prefix = "";
 	struct strbuf *msgbuf;
 
-	if (range == NULL || ! (c->object.flags & NONTRIVIAL_MERGE ||
-							c->object.flags & NEED_PRINT))
+	if (range == NULL || !(c->object.flags & NONTRIVIAL_MERGE ||
+			c->object.flags & NEED_PRINT ||
+			rev->full_line_diff))
 		return;
 
 	if (rev->graph)
@@ -1400,7 +1408,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		flush_nontrivial_merge(rev, nontrivial);
 	else {
 		while (range) {
-			if (range->diff)
+			if (range->diff || (range->nr && rev->full_line_diff))
 				diff_flush_filepair(rev, range);
 			range = range->next;
 		}
@@ -1432,7 +1440,7 @@ int cmd_line_log_walk(struct rev_info *rev)
 	/* Clear the flags */
 	while (list && !limited) {
 		list->item->object.flags &= ~(RANGE_UPDATE | NONTRIVIAL_MERGE |
-						NEED_PRINT | EVIL_MERGE);
+				NEED_PRINT | EVIL_MERGE);
 		list = list->next;
 	}
 
@@ -1446,7 +1454,8 @@ int cmd_line_log_walk(struct rev_info *rev)
 		}
 
 		if (commit->object.flags & NEED_PRINT ||
-			commit->object.flags & NONTRIVIAL_MERGE || rev->graph) {
+			commit->object.flags & NONTRIVIAL_MERGE ||
+			rev->full_line_diff) {
 			line_log_flush(rev, commit);
 		}
 
diff --git a/revision.c b/revision.c
index a6527ca..62fe002 100644
--- a/revision.c
+++ b/revision.c
@@ -1887,7 +1887,10 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
-	if (revs->rewrite_parents && revs->line_level_traverse)
+	if (revs->full_line_diff)
+		revs->dense = 0;
+	if (revs->rewrite_parents && revs->line_level_traverse
+		&& !revs->full_line_diff)
 		limit_list_line(revs);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
diff --git a/revision.h b/revision.h
index 7f7d178..db901e5 100644
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
1.7.2.20.g388bbb
