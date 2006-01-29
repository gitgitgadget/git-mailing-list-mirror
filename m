From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/3] Use struct tree in tar-tree
Date: Sun, 29 Jan 2006 14:04:59 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601291404320.25300@iabervon.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 29 20:03:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3HpO-0004EX-I4
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 20:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWA2TCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 14:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWA2TCr
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 14:02:47 -0500
Received: from iabervon.org ([66.92.72.58]:47117 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751111AbWA2TCq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 14:02:46 -0500
Received: (qmail 19682 invoked by uid 1000); 29 Jan 2006 14:04:59 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2006 14:04:59 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15232>

It was using an open-coded tree parser; use a struct tree instead.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 tar-tree.c |   48 +++++++++++++++++++++++-------------------------
 1 files changed, 23 insertions(+), 25 deletions(-)

d2a4152dfd1b79f32a28ca4b2deb202a4e928441
diff --git a/tar-tree.c b/tar-tree.c
index f749d4b..6219754 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -3,6 +3,7 @@
  */
 #include <time.h>
 #include "cache.h"
+#include "tree.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -334,40 +335,37 @@ static void write_header(const unsigned 
 	write_if_needed();
 }
 
-static void traverse_tree(void *buffer, unsigned long size,
+static void traverse_tree(struct tree *tree,
 			  struct path_prefix *prefix)
 {
 	struct path_prefix this_prefix;
+	struct tree_entry_list *item;
 	this_prefix.prev = prefix;
 
-	while (size) {
-		int namelen = strlen(buffer)+1;
+	parse_tree(tree);
+	item = tree->entries;
+
+	while (item) {
 		void *eltbuf;
 		char elttype[20];
 		unsigned long eltsize;
-		unsigned char *sha1 = buffer + namelen;
-		char *path = strchr(buffer, ' ') + 1;
-		unsigned int mode;
-
-		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) != 1)
-			die("corrupt 'tree' file");
-		if (S_ISDIR(mode) || S_ISREG(mode))
-			mode |= (mode & 0100) ? 0777 : 0666;
-		buffer = sha1 + 20;
-		size -= namelen + 20;
 
-		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
+		eltbuf = read_sha1_file(item->item.any->sha1, 
+					elttype, &eltsize);
 		if (!eltbuf)
-			die("cannot read %s", sha1_to_hex(sha1));
-		write_header(sha1, TYPEFLAG_AUTO, basedir, prefix, path,
-		             mode, eltbuf, eltsize);
-		if (!strcmp(elttype, "tree")) {
-			this_prefix.name = path;
-			traverse_tree(eltbuf, eltsize, &this_prefix);
-		} else if (!strcmp(elttype, "blob") && !S_ISLNK(mode)) {
+			die("cannot read %s", 
+			    sha1_to_hex(item->item.any->sha1));
+		write_header(item->item.any->sha1, TYPEFLAG_AUTO, basedir, 
+			     prefix, item->name,
+		             item->mode, eltbuf, eltsize);
+		if (item->directory) {
+			this_prefix.name = item->name;
+			traverse_tree(item->item.tree, &this_prefix);
+		} else if (!item->symlink) {
 			write_blocked(eltbuf, eltsize);
 		}
 		free(eltbuf);
+		item = item->next;
 	}
 }
 
@@ -404,6 +402,7 @@ int main(int argc, char **argv)
 	unsigned char commit_sha1[20];
 	void *buffer;
 	unsigned long size;
+	struct tree *tree;
 
 	setup_git_directory();
 
@@ -425,8 +424,8 @@ int main(int argc, char **argv)
 		archive_time = commit_time(buffer, size);
 		free(buffer);
 	}
-	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
-	if (!buffer)
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
 		die("not a reference to a tag, commit or tree object: %s",
 		    sha1_to_hex(sha1));
 	if (!archive_time)
@@ -434,8 +433,7 @@ int main(int argc, char **argv)
 	if (basedir)
 		write_header((unsigned char *)"0", TYPEFLAG_DIR, NULL, NULL,
 			basedir, 040777, NULL, 0);
-	traverse_tree(buffer, size, NULL);
-	free(buffer);
+	traverse_tree(tree, NULL);
 	write_trailer();
 	return 0;
 }
-- 
1.0.GIT
