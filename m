From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 4/10] builtin-read-tree.c: avoid tree_entry_list in
 prime_cache_tree_rec()
Date: Mon, 29 May 2006 12:18:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291217360.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:18:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknFn-0000K7-Gq
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWE2TSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWE2TSI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:18:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751223AbWE2TSH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:18:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJI12g015062
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:18:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJI0Lt015496;
	Mon, 29 May 2006 12:18:01 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20959>


Use the raw tree walker instead.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 builtin-read-tree.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 5e513c8..67492bf 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -9,6 +9,7 @@ #include "cache.h"
 
 #include "object.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "cache-tree.h"
 #include <sys/time.h>
 #include <signal.h>
@@ -775,19 +776,28 @@ static int read_cache_unmerged(void)
 
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 {
-	struct tree_entry_list *ent;
+	struct tree_desc desc;
 	int cnt;
 
 	memcpy(it->sha1, tree->object.sha1, 20);
-	for (cnt = 0, ent = tree->entries; ent; ent = ent->next) {
-		if (!ent->directory)
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+	cnt = 0;
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+		if (!S_ISDIR(mode))
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(ent->sha1);
+			struct tree *subtree = lookup_tree(sha1);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
-			sub = cache_tree_sub(it, ent->name);
+			sub = cache_tree_sub(it, name);
 			sub->cache_tree = cache_tree();
 			prime_cache_tree_rec(sub->cache_tree, subtree);
 			cnt += sub->cache_tree->entry_count;
-- 
1.3.3.gcd01d
