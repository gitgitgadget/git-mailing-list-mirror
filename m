From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recur: if there is no common ancestor, fake empty one
Date: Wed, 9 Aug 2006 18:43:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091842210.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 18:43:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAr9C-0000p5-Rh
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 18:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWHIQnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 12:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWHIQnG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 12:43:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:54234 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750854AbWHIQnF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 12:43:05 -0400
Received: (qmail invoked by alias); 09 Aug 2006 16:43:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 09 Aug 2006 18:43:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25125>


This fixes the coolest merge ever.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

	This was a forgotten part from the python version.

 merge-recursive.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7a93dd9..f5b547b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1223,6 +1223,18 @@ int merge(struct commit *h1,
 		output_commit_title(iter->item);
 
 	merged_common_ancestors = pop_commit(&ca);
+	if (merged_common_ancestors == NULL) {
+		/* if there is no common ancestor, make an empty tree */
+		struct tree *tree = xcalloc(1, sizeof(struct tree));
+		char buffer[40];
+		int hdrlen;
+
+		tree->object.parsed = 1;
+		tree->object.type = OBJ_TREE;
+		*write_sha1_file_prepare(NULL, 0, tree_type, &tree->object.sha1,
+				buffer, &hdrlen);
+		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
+	}
 
 	for (iter = ca; iter; iter = iter->next) {
 		output_indent = call_depth + 1;
-- 
1.4.2.rc3.g29d0-dirty
