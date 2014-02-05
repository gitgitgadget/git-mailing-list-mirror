From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 3/4] line-log: convert to using diff_tree_sha1()
Date: Wed,  5 Feb 2014 20:57:11 +0400
Message-ID: <0df5c2e1e93e4873bf276f3f500109249fe1afee.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB5lU-0000Zb-D4
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbaBEQzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 11:55:45 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60080 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbaBEQzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:55:44 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WB5lG-0004Cr-JV; Wed, 05 Feb 2014 20:55:42 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WB5n3-0004zN-9x; Wed, 05 Feb 2014 20:57:33 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241609>

Since diff_tree_sha1() can now accept empty trees via NULL sha1, we
could just call it without manually reading trees into tree_desc and
duplicating code.

Cc: Thomas Rast <tr@thomasrast.ch>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 line-log.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/line-log.c b/line-log.c
index 717638b..1500101 100644
--- a/line-log.c
+++ b/line-log.c
@@ -766,16 +766,6 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	}
 }
 
-static void load_tree_desc(struct tree_desc *desc, void **tree,
-			   const unsigned char *sha1)
-{
-	unsigned long size;
-	*tree = read_object_with_reference(sha1, tree_type, &size, NULL);
-	if (!*tree)
-		die("Unable to read tree (%s)", sha1_to_hex(sha1));
-	init_tree_desc(desc, *tree, size);
-}
-
 static int count_parents(struct commit *commit)
 {
 	struct commit_list *parents = commit->parents;
@@ -842,18 +832,11 @@ static void queue_diffs(struct line_log_data *range,
 			struct diff_queue_struct *queue,
 			struct commit *commit, struct commit *parent)
 {
-	void *tree1 = NULL, *tree2 = NULL;
-	struct tree_desc desc1, desc2;
-
 	assert(commit);
-	load_tree_desc(&desc2, &tree2, commit->tree->object.sha1);
-	if (parent)
-		load_tree_desc(&desc1, &tree1, parent->tree->object.sha1);
-	else
-		init_tree_desc(&desc1, "", 0);
 
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree(&desc1, &desc2, "", opt);
+	diff_tree_sha1(parent ? parent->tree->object.sha1 : NULL,
+			commit->tree->object.sha1, "", opt);
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
@@ -861,11 +844,6 @@ static void queue_diffs(struct line_log_data *range,
 		filter_diffs_for_paths(range, 0);
 	}
 	move_diff_queue(queue, &diff_queued_diff);
-
-	if (tree1)
-		free(tree1);
-	if (tree2)
-		free(tree2);
 }
 
 static char *get_nth_line(long line, unsigned long *ends, void *data)
-- 
1.9.rc1.181.g641f458
