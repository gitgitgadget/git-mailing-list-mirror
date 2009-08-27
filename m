From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 10/12] notes.c: Implement simple memory pooling of leaf nodes
Date: Thu, 27 Aug 2009 03:43:55 +0200
Message-ID: <1251337437-16947-11-git-send-email-johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 03:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgU2s-0004PF-Rf
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 03:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbZH0Bom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 21:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbZH0Bol
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 21:44:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52466 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932094AbZH0Boi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 21:44:38 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP0002B9I6GTPA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:40 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000MW0I5F4H50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:40 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1251337437-16947-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127136>

Allocate page-sized chunks for holding struct leaf_node objects.

This slightly (but consistently) improves runtime performance of notes
lookup, at a very slight increase (~2K on average) in memory usage.

When allocating a new memory pool, the older pool is leaked, but this is
no worse than the current situation, where (pretty much) all leaf_nodes
are leaked anyway.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/notes.c b/notes.c
index a637056..5d1ee17 100644
--- a/notes.c
+++ b/notes.c
@@ -55,6 +55,23 @@ static int initialized;
 
 static struct int_node root_node;
 
+/* leaf nodes are allocated in simple memory pools */
+#define LEAF_NODE_POOL_SIZE 100
+static struct leaf_node *leaf_node_pool;
+static unsigned int leaf_node_pool_used;
+
+
+static struct leaf_node *new_leaf_node()
+{
+	if (!leaf_node_pool || leaf_node_pool_used >= LEAF_NODE_POOL_SIZE) {
+		/* MEMORY LEAK: */
+		leaf_node_pool = (struct leaf_node *)
+			xcalloc(sizeof(struct leaf_node), LEAF_NODE_POOL_SIZE);
+		leaf_node_pool_used = 0;
+	}
+	return leaf_node_pool + leaf_node_pool_used++;
+}
+
 static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		unsigned int n);
 
@@ -95,7 +112,6 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 			/* unpack tree and resume search */
 			tree->a[i] = NULL;
 			load_subtree(l, tree, n);
-			free(l);
 			return note_tree_find(tree, n, key_sha1);
 		}
 		break;
@@ -118,7 +134,6 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 		/* unpack tree and resume search */
 		tree->a[0] = NULL;
 		load_subtree(l, tree, n);
-		free(l);
 		return note_tree_find(tree, n, key_sha1);
 	}
 	return NULL;
@@ -229,8 +244,7 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		 */
 		if (len <= 20) {
 			unsigned char type = PTR_TYPE_NOTE;
-			struct leaf_node *l = (struct leaf_node *)
-				xcalloc(sizeof(struct leaf_node), 1);
+			struct leaf_node *l = new_leaf_node();
 			hashcpy(l->key_sha1, commit_sha1);
 			hashcpy(l->val_sha1, entry.sha1);
 			if (len < 20) {
-- 
1.6.4.304.g1365c.dirty
