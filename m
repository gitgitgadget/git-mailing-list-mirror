From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3, v2] http-push: do not get confused by submodules
Date: Thu, 14 Feb 2008 23:32:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142331100.30505@racer.site>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site> <alpine.LSU.1.00.0802142325400.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, mh@glandium.org
X-From: git-owner@vger.kernel.org Fri Feb 15 00:33:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnaI-0003HU-7G
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933248AbYBNXch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933194AbYBNXcg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:32:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:34309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933103AbYBNXcf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:32:35 -0500
Received: (qmail invoked by alias); 14 Feb 2008 23:32:33 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp032) with SMTP; 15 Feb 2008 00:32:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WkAYmZGUW/PSnEHNpYyItneCvlYyQnaJBwLBhuX
	xtdLmc91e4noSk
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802142325400.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73927>


When encountering submodules in a tree, http-push should not try sending
the respective object.  Instead, it should ignore it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I just remembered that Linus did something similar, but more 
	elegant, in 481f0ee60eef2c34b891e5d04b7e6e5a955eedf4.  This
	patch imitates that commit.

 http-push.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7a6c669..4d200bc 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1634,12 +1634,19 @@ static struct object_list **process_tree(struct tree *tree,
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
-	while (tree_entry(&desc, &entry)) {
-		if (S_ISDIR(entry.mode))
+	while (tree_entry(&desc, &entry))
+		switch (object_type(entry.mode)) {
+		case OBJ_TREE:
 			p = process_tree(lookup_tree(entry.sha1), p, &me, name);
-		else
+			break;
+		case OBJ_BLOB:
 			p = process_blob(lookup_blob(entry.sha1), p, &me, name);
-	}
+			break;
+		default:
+			/* Subproject commit - not in this repository */
+			break;
+		}
+
 	free(tree->buffer);
 	tree->buffer = NULL;
 	return p;
-- 
1.5.4.1.1353.g0d5dd
