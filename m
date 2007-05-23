From: skimo@liacs.nl
Subject: [PATCH 13/22] git-read-tree: treat null commit as empty tree
Date: Thu, 24 May 2007 00:23:02 +0200
Message-ID: <11799589921991-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFo-0003VS-Du
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbXEWWXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757791AbXEWWXv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:51 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33794 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757528AbXEWWXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:47 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNHgw011572;
	Thu, 24 May 2007 00:23:22 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id AE2C07DDAB; Thu, 24 May 2007 00:23:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48201>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
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
index 2f2d9b9..d5e458d 100644
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
1.5.2.784.g5532e
