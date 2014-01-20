From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 4/4] combine-diff: combine_diff_path.len is not needed anymore
Date: Mon, 20 Jan 2014 20:20:41 +0400
Message-ID: <81fdea65268f1d5cfe120ec37ee577f4639f9d74.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 17:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Ho7-0003CR-OH
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 17:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbaATQef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 11:34:35 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60904 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbaATQe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 11:34:27 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W5HZF-0007Vv-TV; Mon, 20 Jan 2014 20:19:18 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W5HbA-0001Q5-6m; Mon, 20 Jan 2014 20:21:16 +0400
X-Mailer: git-send-email 1.9.rc0.143.g6fd479e
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240716>

Brefore previous patch, ->len was used to speedup name compares and also
to mark removed paths via len=0. Now we do significantly less strcmp and
also just remove paths from list and free right after we know a path
will not be needed, so ->len is not needed anymore.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 30 +++++++++---------------------
 diff-lib.c     |  2 --
 diff.h         |  1 -
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 98c2562..07faa96 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -31,7 +31,6 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			p->path = (char *) &(p->parent[num_parent]);
 			memcpy(p->path, path, len);
 			p->path[len] = 0;
-			p->len = len;
 			p->next = NULL;
 			memset(p->parent, 0,
 			       sizeof(p->parent[0]) * num_parent);
@@ -1234,8 +1233,6 @@ void show_combined_diff(struct combine_diff_path *p,
 {
 	struct diff_options *opt = &rev->diffopt;
 
-	if (!p->len)
-		return;
 	if (opt->output_format & (DIFF_FORMAT_RAW |
 				  DIFF_FORMAT_NAME |
 				  DIFF_FORMAT_NAME_STATUS))
@@ -1299,11 +1296,8 @@ static void handle_combined_callback(struct diff_options *opt,
 	q.queue = xcalloc(num_paths, sizeof(struct diff_filepair *));
 	q.alloc = num_paths;
 	q.nr = num_paths;
-	for (i = 0, p = paths; p; p = p->next) {
-		if (!p->len)
-			continue;
+	for (i = 0, p = paths; p; p = p->next)
 		q.queue[i++] = combined_pair(p, num_parent);
-	}
 	opt->format_callback(&q, opt, opt->format_callback_data);
 	for (i = 0; i < num_paths; i++)
 		free_combined_pair(q.queue[i]);
@@ -1369,11 +1363,9 @@ void diff_tree_combined(const unsigned char *sha1,
 		diff_flush(&diffopts);
 	}
 
-	/* find out surviving paths */
-	for (num_paths = 0, p = paths; p; p = p->next) {
-		if (p->len)
-			num_paths++;
-	}
+	/* find out number of surviving paths */
+	for (num_paths = 0, p = paths; p; p = p->next)
+		num_paths++;
 
 	/* order paths according to diffcore_order */
 	if (opt->orderfile && num_paths) {
@@ -1398,10 +1390,8 @@ void diff_tree_combined(const unsigned char *sha1,
 		if (opt->output_format & (DIFF_FORMAT_RAW |
 					  DIFF_FORMAT_NAME |
 					  DIFF_FORMAT_NAME_STATUS)) {
-			for (p = paths; p; p = p->next) {
-				if (p->len)
-					show_raw_diff(p, num_parent, rev);
-			}
+			for (p = paths; p; p = p->next)
+				show_raw_diff(p, num_parent, rev);
 			needsep = 1;
 		}
 		else if (opt->output_format &
@@ -1414,11 +1404,9 @@ void diff_tree_combined(const unsigned char *sha1,
 			if (needsep)
 				printf("%s%c", diff_line_prefix(opt),
 				       opt->line_termination);
-			for (p = paths; p; p = p->next) {
-				if (p->len)
-					show_patch_diff(p, num_parent, dense,
-							0, rev);
-			}
+			for (p = paths; p; p = p->next)
+				show_patch_diff(p, num_parent, dense,
+						0, rev);
 		}
 	}
 
diff --git a/diff-lib.c b/diff-lib.c
index e6d33b3..938869d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -121,7 +121,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->path = (char *) &(dpath->parent[5]);
 
 			dpath->next = NULL;
-			dpath->len = path_len;
 			memcpy(dpath->path, ce->name, path_len);
 			dpath->path[path_len] = '\0';
 			hashclr(dpath->sha1);
@@ -323,7 +322,6 @@ static int show_modified(struct rev_info *revs,
 		p = xmalloc(combine_diff_path_size(2, pathlen));
 		p->path = (char *) &p->parent[2];
 		p->next = NULL;
-		p->len = pathlen;
 		memcpy(p->path, new->name, pathlen);
 		p->path[pathlen] = 0;
 		p->mode = mode;
diff --git a/diff.h b/diff.h
index 0e6898f..a24a767 100644
--- a/diff.h
+++ b/diff.h
@@ -198,7 +198,6 @@ extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
-	int len;
 	char *path;
 	unsigned int mode;
 	unsigned char sha1[20];
-- 
1.9.rc0.143.g6fd479e
