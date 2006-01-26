From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Only use a single parser for tree objects
Date: Thu, 26 Jan 2006 01:13:36 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601260103360.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 07:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F20MJ-0007mu-GQ
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 07:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWAZGLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 01:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAZGLa
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 01:11:30 -0500
Received: from iabervon.org ([66.92.72.58]:26381 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750752AbWAZGLa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2006 01:11:30 -0500
Received: (qmail 17796 invoked by uid 1000); 26 Jan 2006 01:13:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2006 01:13:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15149>

This makes read_tree_recursive and read_tree take a struct tree
instead of a buffer. It also move the declaration of read_tree into
tree.h (where struct tree is defined), and updates ls-tree and
diff-index (the only places that presently use read_tree*()) to use
the new versions.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 cache.h      |    3 ---
 diff-index.c |    8 ++++----
 ls-tree.c    |    9 ++++-----
 tree.c       |   50 +++++++++++++++++++-------------------------------
 tree.h       |    9 +++++----
 5 files changed, 32 insertions(+), 47 deletions(-)

973280cda82b9ead56881d453c6101e4bf298c94
diff --git a/cache.h b/cache.h
index 6f13434..24a679b 100644
--- a/cache.h
+++ b/cache.h
@@ -210,9 +210,6 @@ extern char *write_sha1_file_prepare(voi
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
-/* Read a tree into the cache */
-extern int read_tree(void *buffer, unsigned long size, int stage, const char **paths);
-
 extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 			      size_t bufsize, size_t *bufposn);
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
diff --git a/diff-index.c b/diff-index.c
index 87e1061..bbd873b 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tree.h"
 #include "diff.h"
 
 static int cached_only = 0;
@@ -174,8 +175,7 @@ int main(int argc, const char **argv)
 	unsigned char sha1[20];
 	const char *prefix = setup_git_directory();
 	const char **pathspec = NULL;
-	void *tree;
-	unsigned long size;
+	struct tree *tree;
 	int ret;
 	int allow_options = 1;
 	int i;
@@ -233,10 +233,10 @@ int main(int argc, const char **argv)
 
 	mark_merge_entries();
 
-	tree = read_object_with_reference(sha1, "tree", &size, NULL);
+	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("bad tree object %s", tree_name);
-	if (read_tree(tree, size, 1, pathspec))
+	if (read_tree(tree, 1, pathspec))
 		die("unable to read tree object %s", tree_name);
 
 	ret = diff_cache(active_cache, active_nr, pathspec);
diff --git a/ls-tree.c b/ls-tree.c
index d585b6f..d005643 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -84,8 +84,7 @@ static int show_tree(unsigned char *sha1
 int main(int argc, const char **argv)
 {
 	unsigned char sha1[20];
-	char *buf;
-	unsigned long size;
+	struct tree *tree;
 
 	prefix = setup_git_directory();
 	if (prefix && *prefix)
@@ -131,10 +130,10 @@ int main(int argc, const char **argv)
 		usage(ls_tree_usage);
 
 	pathspec = get_pathspec(prefix, argv + 2);
-	buf = read_object_with_reference(sha1, "tree", &size, NULL);
-	if (!buf)
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(buf, size, "", 0, 0, pathspec, show_tree);
+	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree);
 
 	return 0;
 }
diff --git a/tree.c b/tree.c
index dc1c41e..962ee89 100644
--- a/tree.c
+++ b/tree.c
@@ -74,27 +74,24 @@ static int match_tree_entry(const char *
 	return 0;
 }
 
-int read_tree_recursive(void *buffer, unsigned long size,
+int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
 			int stage, const char **match,
 			read_tree_fn_t fn)
 {
-	while (size) {
-		int len = strlen(buffer)+1;
-		unsigned char *sha1 = buffer + len;
-		char *path = strchr(buffer, ' ')+1;
-		unsigned int mode;
-
-		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1)
-			return -1;
-
-		buffer = sha1 + 20;
-		size -= len + 20;
-
-		if (!match_tree_entry(base, baselen, path, mode, match))
+	struct tree_entry_list *list;
+	if (parse_tree(tree))
+		return -1;
+	list = tree->entries;
+	while (list) {
+		struct tree_entry_list *current = list;
+		list = list->next;
+		if (!match_tree_entry(base, baselen, current->name, 
+				      current->mode, match))
 			continue;
 
-		switch (fn(sha1, base, baselen, path, mode, stage)) {
+		switch (fn(current->item.any->sha1, base, baselen, 
+			   current->name, current->mode, stage)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -102,28 +99,19 @@ int read_tree_recursive(void *buffer, un
 		default:
 			return -1;
 		}
-		if (S_ISDIR(mode)) {
+		if (current->directory) {
 			int retval;
-			int pathlen = strlen(path);
+			int pathlen = strlen(current->name);
 			char *newbase;
-			void *eltbuf;
-			char elttype[20];
-			unsigned long eltsize;
-
-			eltbuf = read_sha1_file(sha1, elttype, &eltsize);
-			if (!eltbuf || strcmp(elttype, "tree")) {
-				if (eltbuf) free(eltbuf);
-				return -1;
-			}
+
 			newbase = xmalloc(baselen + 1 + pathlen);
 			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, path, pathlen);
+			memcpy(newbase + baselen, current->name, pathlen);
 			newbase[baselen + pathlen] = '/';
-			retval = read_tree_recursive(eltbuf, eltsize,
+			retval = read_tree_recursive(current->item.tree,
 						     newbase,
 						     baselen + pathlen + 1,
 						     stage, match, fn);
-			free(eltbuf);
 			free(newbase);
 			if (retval)
 				return -1;
@@ -133,9 +121,9 @@ int read_tree_recursive(void *buffer, un
 	return 0;
 }
 
-int read_tree(void *buffer, unsigned long size, int stage, const char **match)
+int read_tree(struct tree *tree, int stage, const char **match)
 {
-	return read_tree_recursive(buffer, size, "", 0, stage, match, read_one_entry);
+	return read_tree_recursive(tree, "", 0, stage, match, read_one_entry);
 }
 
 struct tree *lookup_tree(const unsigned char *sha1)
diff --git a/tree.h b/tree.h
index 57a5bf7..330ab64 100644
--- a/tree.h
+++ b/tree.h
@@ -37,10 +37,11 @@ struct tree *parse_tree_indirect(const u
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(unsigned char *, const char *, int, const char *, unsigned int, int);
 
-extern int read_tree_recursive(void *buffer, unsigned long size,
-			const char *base, int baselen,
-			int stage, const char **match,
-			read_tree_fn_t fn);
+extern int read_tree_recursive(struct tree *tree,
+			       const char *base, int baselen,
+			       int stage, const char **match,
+			       read_tree_fn_t fn);
 
+extern int read_tree(struct tree *tree, int stage, const char **paths);
 
 #endif /* TREE_H */
-- 
1.0.GIT
