From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 9/10] Convert fetch.c: process_tree() to raw tree walker
Date: Mon, 29 May 2006 12:20:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291220240.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:21:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknIc-0000x4-O1
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWE2TVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWE2TVH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:21:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWE2TVF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:21:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJKo2g015258
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:20:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJKmpp015659;
	Mon, 29 May 2006 12:20:49 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20964>


This leaves only the horrid code in builtin-read-tree.c using the old
interface. Some day I will gather the strength to tackle that one too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 fetch.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fetch.c b/fetch.c
index d9fe41f..976a5a4 100644
--- a/fetch.c
+++ b/fetch.c
@@ -3,6 +3,7 @@ #include "fetch.h"
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
@@ -36,27 +37,32 @@ static int process(struct object *obj);
 
 static int process_tree(struct tree *tree)
 {
-	struct tree_entry_list *entry;
+	struct tree_desc desc;
 
 	if (parse_tree(tree))
 		return -1;
 
-	entry = create_tree_entry_list(tree);
-	while (entry) {
-		struct tree_entry_list *next = entry->next;
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
 
-		if (entry->directory) {
-			struct tree *tree = lookup_tree(entry->sha1);
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+
+		if (S_ISDIR(mode)) {
+			struct tree *tree = lookup_tree(sha1);
 			process_tree(tree);
 		} else {
-			struct blob *blob = lookup_blob(entry->sha1);
+			struct blob *blob = lookup_blob(sha1);
 			process(&blob->object);
 		}
-		free(entry);
-		entry = next;
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
+	tree->size = 0;
 	return 0;
 }
 
-- 
1.3.3.gcd01d
