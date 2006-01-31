From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] Make git-tar-tree use the tree_desc abstractions
Date: Tue, 31 Jan 2006 14:13:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311411080.7301@g5.osdl.org>
References: <Pine.LNX.4.64.0601311407460.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jan 31 23:14:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43ky-000699-DO
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 23:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWAaWNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWAaWNp
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 17:13:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751678AbWAaWNo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 17:13:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VMDfDZ010021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 14:13:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VMDec8002733;
	Tue, 31 Jan 2006 14:13:40 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601311407460.7301@g5.osdl.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15357>


Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is a first try at making git-tar-tree use the "struct tree_desc" 
infrastructure. I actually did test it by creating a tar-file of Linux 
v2.6.15, and it _seemed_ to work, and it passes all the git testsuite, but 
hey, that was all very superficial.

It was a pretty straightforward change from "struct tree" to "struct 
tree_desc", though, so it should all be fine. Daniel had already cleaned 
up the code by his original conversion.

diff --git a/tar-tree.c b/tar-tree.c
index d36baed..e85a1ed 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -3,7 +3,7 @@
  */
 #include <time.h>
 #include "cache.h"
-#include "tree.h"
+#include "diff.h"
 #include "commit.h"
 
 #define RECORDSIZE	(512)
@@ -336,37 +336,38 @@ static void write_header(const unsigned 
 	write_if_needed();
 }
 
-static void traverse_tree(struct tree *tree,
+static void traverse_tree(struct tree_desc *tree,
 			  struct path_prefix *prefix)
 {
 	struct path_prefix this_prefix;
-	struct tree_entry_list *item;
 	this_prefix.prev = prefix;
 
-	parse_tree(tree);
-	item = tree->entries;
-
-	while (item) {
+	while (tree->size) {
+		const char *name;
+		const unsigned char *sha1;
+		unsigned mode;
 		void *eltbuf;
 		char elttype[20];
 		unsigned long eltsize;
 
-		eltbuf = read_sha1_file(item->item.any->sha1, 
-					elttype, &eltsize);
+		sha1 = tree_entry_extract(tree, &name, &mode);
+		update_tree_entry(tree);
+
+		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
 		if (!eltbuf)
-			die("cannot read %s", 
-			    sha1_to_hex(item->item.any->sha1));
-		write_header(item->item.any->sha1, TYPEFLAG_AUTO, basedir, 
-			     prefix, item->name,
-		             item->mode, eltbuf, eltsize);
-		if (item->directory) {
-			this_prefix.name = item->name;
-			traverse_tree(item->item.tree, &this_prefix);
-		} else if (!item->symlink) {
+			die("cannot read %s", sha1_to_hex(sha1));
+		write_header(sha1, TYPEFLAG_AUTO, basedir, 
+			     prefix, name, mode, eltbuf, eltsize);
+		if (S_ISDIR(mode)) {
+			struct tree_desc subtree;
+			subtree.buf = eltbuf;
+			subtree.size = eltsize;
+			this_prefix.name = name;
+			traverse_tree(&subtree, &this_prefix);
+		} else if (!S_ISLNK(mode)) {
 			write_blocked(eltbuf, eltsize);
 		}
 		free(eltbuf);
-		item = item->next;
 	}
 }
 
@@ -374,7 +375,7 @@ int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 	struct commit *commit;
-	struct tree *tree;
+	struct tree_desc tree;
 
 	setup_git_directory();
 
@@ -395,8 +396,8 @@ int main(int argc, char **argv)
 		write_global_extended_header(commit->object.sha1);
 		archive_time = commit->date;
 	}
-	tree = parse_tree_indirect(sha1);
-	if (!tree)
+	tree.buf = read_object_with_reference(sha1, "tree", &tree.size, NULL);
+	if (!tree.buf)
 		die("not a reference to a tag, commit or tree object: %s",
 		    sha1_to_hex(sha1));
 	if (!archive_time)
@@ -404,7 +405,7 @@ int main(int argc, char **argv)
 	if (basedir)
 		write_header((unsigned char *)"0", TYPEFLAG_DIR, NULL, NULL,
 			basedir, 040777, NULL, 0);
-	traverse_tree(tree, NULL);
+	traverse_tree(&tree, NULL);
 	write_trailer();
 	return 0;
 }
