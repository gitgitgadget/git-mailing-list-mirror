From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Trivial cleanup of track_tree_refs()
Date: Sun, 18 Mar 2007 13:38:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703181333190.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 21:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT294-0000cq-TF
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 21:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbXCRUiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933232AbXCRUiY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 16:38:24 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53330 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231AbXCRUiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 16:38:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2IKcKcD028342
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 13:38:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2IKcJrP030207;
	Sun, 18 Mar 2007 12:38:19 -0800
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42520>


This makes "track_tree_refs()" use the same "tree_entry()" function for 
counting the entries as it does for actually traversing them a few lines 
later. 

Not a biggie, but the reason I care was that this was the only user of 
"update_tree_entry()" that didn't actually *extract* the tree entry first. 
It doesn't matter as things stand now, but it meant that a separate 
test-patch I had that avoided a few more "strlen()" calls by just saving 
the entry length in the entry descriptor and using it directly when 
updating wouldn't work without this patch.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 tree.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 46923ee..24f8fb6 100644
--- a/tree.c
+++ b/tree.c
@@ -153,10 +153,8 @@ static void track_tree_refs(struct tree *item)
 	/* Count how many entries there are.. */
 	desc.buf = item->buffer;
 	desc.size = item->size;
-	while (desc.size) {
+	while (tree_entry(&desc, &entry))
 		n_refs++;
-		update_tree_entry(&desc);
-	}
 
 	/* Allocate object refs and walk it again.. */
 	i = 0;
