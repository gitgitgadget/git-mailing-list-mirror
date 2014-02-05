From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 4/4] revision: convert to using diff_tree_sha1()
Date: Wed,  5 Feb 2014 20:57:12 +0400
Message-ID: <975fbde9bdd2c5aad7376e398ca8001b9a41d2d6.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:56:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB5lU-0000Zb-VB
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbaBEQzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 11:55:47 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60083 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbaBEQzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:55:46 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WB5lI-0004Cw-L0; Wed, 05 Feb 2014 20:55:44 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WB5n5-0004zR-C1; Wed, 05 Feb 2014 20:57:35 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241610>

Since diff_tree_sha1() can now accept empty trees via NULL sha1, we
could just call it without manually reading trees into tree_desc and
duplicating code.

Besides, that

	if (!tree)
		return 0;

looked suspect - we were saying an invalid tree != empty tree, but maybe it is
better to just say the tree is invalid here, which is what diff_tree_sha1()
does for such case.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 revision.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index 082dae6..bd027bc 100644
--- a/revision.c
+++ b/revision.c
@@ -497,24 +497,14 @@ static int rev_compare_tree(struct rev_info *revs,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
 	int retval;
-	void *tree;
-	unsigned long size;
-	struct tree_desc empty, real;
 	struct tree *t1 = commit->tree;
 
 	if (!t1)
 		return 0;
 
-	tree = read_object_with_reference(t1->object.sha1, tree_type, &size, NULL);
-	if (!tree)
-		return 0;
-	init_tree_desc(&real, tree, size);
-	init_tree_desc(&empty, "", 0);
-
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	retval = diff_tree(&empty, &real, "", &revs->pruning);
-	free(tree);
+	retval = diff_tree_sha1(NULL, t1->object.sha1, "", &revs->pruning);
 
 	return retval >= 0 && (tree_difference == REV_TREE_SAME);
 }
-- 
1.9.rc1.181.g641f458
