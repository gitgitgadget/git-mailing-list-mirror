From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 11/22] Add --full-line-diff option
Date: Sat, 24 Jul 2010 23:13:43 +0800
Message-ID: <1279984434-28933-12-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRr-00020D-0O
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab0GXPPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40733 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab0GXPPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:05 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so499993pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UAo3gnS9oaI+YMYWMa6QjZciB0JNo0Tr3XGMPYKIoyE=;
        b=RBUWFfSBeELcA8QgJHFWocdgPbwsqas71w6SX60MVfpwKVDPjwW1yMt94wGLTWN+Um
         0sdbDHtjnMkK4CQdALqm+4xGsMNYdPQdmJqqsqZGjG7e2hvygeP9P7LJxQCyn+/wW18n
         MY6PwnXtyOZ1vjJ5JK1xMuUQIKBQku/yEbl/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OUbW3LcjkVhnjRBP1Usiha9/1R9mxBAhpjz6dxD9LJAEI4szidQDkTv5+8VajtqgvB
         QD+SF4xZknT4Q003TThAvXA5I3yK8yo3OEQBTFZzhQfcoNI9QVH7lLvBiL6kZbvPTiAx
         4uQGPc6HGt/w65a+hZDQZfW0bB3y9Hhyas67s=
Received: by 10.142.216.21 with SMTP id o21mr5935910wfg.282.1279984504762;
        Sat, 24 Jul 2010 08:15:04 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151646>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    3 +++
 line.c        |   11 +++++++++--
 revision.h    |    3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

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
index c17659a..5317fe5 100644
--- a/line.c
+++ b/line.c
@@ -1116,6 +1116,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	 * no sensible rang->pair since there is no diff run.
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
 
@@ -1226,7 +1233,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		return flush_nontrivial_merge(rev, nontrivial);
 
 	while (range) {
-		if (range->diff)
+		if (range->diff || (range->nr && rev->full_line_diff))
 			diff_flush_filepair(rev, range);
 		range = range->next;
 	}
@@ -1261,7 +1268,7 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT) {
+		if (commit->object.flags & NEED_PRINT || rev->full_line_diff) {
 			line_log_flush(rev, commit);
 		}
 
diff --git a/revision.h b/revision.h
index 2627ec4..e4b6adf 100644
--- a/revision.h
+++ b/revision.h
@@ -72,7 +72,8 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+			full_line_diff:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
1.7.0.2.273.gc2413.dirty
