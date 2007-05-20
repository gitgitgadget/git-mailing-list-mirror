From: skimo@liacs.nl
Subject: [PATCH 11/15] git-read-tree: treat null commit as empty tree
Date: Sun, 20 May 2007 20:04:44 +0200
Message-ID: <1179684289777-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmt-0007La-7x
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbXETSFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756963AbXETSFS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:18 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37216 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756935AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4s5Y007823;
	Sun, 20 May 2007 20:04:59 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C8AA37DDAA; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47874>

From: Sven Verdoolaege <skimo@kotnet.org>

---
 builtin-read-tree.c |    9 ++++++---
 unpack-trees.c      |    3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 929dd95..b9fcff7 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -17,9 +17,12 @@ static struct object_list *trees;
 
 static int list_tree(unsigned char *sha1)
 {
-	struct tree *tree = parse_tree_indirect(sha1);
-	if (!tree)
-		return -1;
+	struct tree *tree = NULL;
+	if (!is_null_sha1(sha1)) {
+		tree = parse_tree_indirect(sha1);
+		if (!tree)
+			return -1;
+	}
 	object_list_append(&tree->object, &trees);
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index f3fe2dd..3dadebb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -26,6 +26,9 @@ static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
 	struct tree_entry_list *ret = NULL;
 	struct tree_entry_list **list_p = &ret;
 
+	if (!tree)
+		return ret;
+
 	if (!tree->object.parsed)
 		parse_tree(tree);
 
-- 
1.5.2.rc3.815.g8fc2
