From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 15/17] Add --full-line-diff option
Date: Wed, 11 Aug 2010 23:03:40 +0800
Message-ID: <1281539022-31616-16-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:06:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCsV-0005Yv-Mw
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0HKPFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:05:54 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50547 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0HKPFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:05:53 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so75651pxi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/vibvGhP2mC0C/PwCfssiPW5O+Hx/GRw6p8RO8nh500=;
        b=WFqHaEVMTzrSKubspfcOHcs/2IgRUjO4joZkQBe/8jh22ATHIuYe4PBFLrhdQNFPpd
         htaZl6GTiUhBTwEgknzQH8P+Y7PpzYyf7UGGaXk3oh2BSKyd/GFPEDUhzSU3+WgyCZX2
         +7cEYEgnHODz32NaJM48ju+JaaTT7PigshSB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ouxvjpbMSDMLV7f63YGv1qrOwzxTdWUJ5bskohftOekV1nK5+sYj/SUDCOXHlE0Umi
         6BMZotf2wDyr+9NOSRfce+E0He1mKm3ePzxi8cW4Fdj7+9SR0jLddALIGsDBREC2gdfj
         AgftqesjneUHxeVas3rFL1tLEF2GHGapKJUJI=
Received: by 10.114.133.18 with SMTP id g18mr22168228wad.48.1281539153022;
        Wed, 11 Aug 2010 08:05:53 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:05:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153252>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    8 +++++++-
 line.c        |   22 ++++++++++++++++------
 revision.c    |    5 ++++-
 revision.h    |    3 ++-
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 637bcea..0151d2f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -85,6 +85,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 	int decoration_given = 0;
+	static int full_line_diff;
 	struct userformat_want w;
 	const char *path = NULL, *fullpath = NULL;
 	static struct diff_line_range *range;
@@ -95,6 +96,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m",
 			     "Process only line range n,m, counting from 1",
 			     log_line_range_callback),
+		OPT_BOOLEAN(0, "full-line-diff", &full_line_diff,
+			    "Always print the interesting range even if the \
+			    current commit does not change any line of it"),
 		OPT_END()
 	};
 
@@ -223,8 +227,10 @@ parse_done:
 	}
 
 	/* Test whether line level history is asked for */
-	if (range && range->nr > 0)
+	if (range && range->nr > 0) {
 		setup_line(rev, range);
+		rev->full_line_diff = full_line_diff;
+	}
 }
 
 /*
diff --git a/line.c b/line.c
index 5580768..7de6427 100644
--- a/line.c
+++ b/line.c
@@ -1244,10 +1244,18 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	/*
 	 * the ranges that touch no different file, in this case
 	 * the line number will not change, and of course we have
-	 * no sensible rang->pair since there is no diff run.
+	 * no sensible range->pair since there is no diff run.
 	 */
-	if (one == NULL)
+	if (one == NULL) {
+		if (rev->full_line_diff) {
+			chunk.two = two->data;
+			chunk.two_end = two->data + two->size;
+			chunk.ltwo = 1;
+			chunk.range = range;
+			diff_flush_chunks(&rev->diffopt, &chunk);
+		}
 		return;
+	}
 
 	if (range->status == DIFF_STATUS_DELETED)
 		die("We are following an nonexistent file, interesting!");
@@ -1369,7 +1377,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	struct strbuf *msgbuf;
 
 	if (range == NULL || !(c->object.flags & NONTRIVIAL_MERGE ||
-							c->object.flags & NEED_PRINT))
+			c->object.flags & NEED_PRINT ||
+			rev->full_line_diff))
 		return;
 
 	if (rev->graph)
@@ -1390,7 +1399,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		flush_nontrivial_merge(rev, nontrivial);
 	else {
 		while (range) {
-			if (range->diff)
+			if (range->diff || (range->nr && rev->full_line_diff))
 				diff_flush_filepair(rev, range);
 			range = range->next;
 		}
@@ -1421,7 +1430,7 @@ int cmd_line_log_walk(struct rev_info *rev)
 	/* Clear the flags */
 	while (list && !limited) {
 		list->item->object.flags &= ~(RANGE_UPDATE | NONTRIVIAL_MERGE |
-						NEED_PRINT | EVIL_MERGE);
+				NEED_PRINT | EVIL_MERGE);
 		list = list->next;
 	}
 
@@ -1434,7 +1443,8 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 
 		if (commit->object.flags & NEED_PRINT ||
-			commit->object.flags & NONTRIVIAL_MERGE || rev->graph)
+			commit->object.flags & NONTRIVIAL_MERGE ||
+			rev->full_line_diff)
 			line_log_flush(rev, commit);
 
 		r = lookup_line_range(rev, commit);
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
1.7.2.19.g79e5d
