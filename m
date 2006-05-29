From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 8/10] Convert "mark_tree_uninteresting()" to raw tree walker
Date: Mon, 29 May 2006 12:20:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291219490.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:20:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknHu-0000mb-FQ
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWE2TUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWE2TUW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:20:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751244AbWE2TUU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:20:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJKH2g015230
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:20:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJKEhO015630;
	Mon, 29 May 2006 12:20:15 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20963>


Not very many users to go..

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 revision.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index c51ea83..8e93e40 100644
--- a/revision.c
+++ b/revision.c
@@ -53,8 +53,8 @@ static void mark_blob_uninteresting(stru
 
 void mark_tree_uninteresting(struct tree *tree)
 {
+	struct tree_desc desc;
 	struct object *obj = &tree->object;
-	struct tree_entry_list *entry;
 
 	if (obj->flags & UNINTERESTING)
 		return;
@@ -63,16 +63,29 @@ void mark_tree_uninteresting(struct tree
 		return;
 	if (parse_tree(tree) < 0)
 		die("bad tree %s", sha1_to_hex(obj->sha1));
-	entry = create_tree_entry_list(tree);
-	while (entry) {
-		struct tree_entry_list *next = entry->next;
-		if (entry->directory)
-			mark_tree_uninteresting(lookup_tree(entry->sha1));
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+
+		if (S_ISDIR(mode))
+			mark_tree_uninteresting(lookup_tree(sha1));
 		else
-			mark_blob_uninteresting(lookup_blob(entry->sha1));
-		free(entry);
-		entry = next;
+			mark_blob_uninteresting(lookup_blob(sha1));
 	}
+
+	/*
+	 * We don't care about the tree any more
+	 * after it has been marked uninteresting.
+	 */
+	free(tree->buffer);
+	tree->buffer = NULL;
 }
 
 void mark_parents_uninteresting(struct commit *commit)
-- 
1.3.3.gcd01d
