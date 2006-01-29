From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/3] Use struct tree in diff-tree
Date: Sun, 29 Jan 2006 14:05:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601291405250.25300@iabervon.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 29 20:03:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Hpp-0004L6-Cm
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 20:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWA2TDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 14:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWA2TDe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 14:03:34 -0500
Received: from iabervon.org ([66.92.72.58]:48141 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751110AbWA2TDe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 14:03:34 -0500
Received: (qmail 19704 invoked by uid 1000); 29 Jan 2006 14:05:46 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2006 14:05:46 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15233>

It had been open-coding a tree parser. This updates the programs that
call diff_tree() to send it the struct tree instead of a buffer and
size.

Signed-off-by: Daniel Barkalow

---

 diff-tree.c |   13 ++----
 diff.h      |    9 +---
 rev-list.c  |   13 ------
 tree-diff.c |  123 ++++++++++++++++++++++++++---------------------------------
 4 files changed, 63 insertions(+), 95 deletions(-)

1530551cfd7dbecfe3258cab09b01f10a9b8549d
diff --git a/diff-tree.c b/diff-tree.c
index 6593a69..d64cba0 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -49,18 +49,13 @@ static int diff_tree_sha1_top(const unsi
 static int diff_root_tree(const unsigned char *new, const char *base)
 {
 	int retval;
-	void *tree;
-	struct tree_desc empty, real;
+	struct tree *real;
 
-	tree = read_object_with_reference(new, "tree", &real.size, NULL);
-	if (!tree)
+	real = parse_tree_indirect(new);
+	if (!real)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
-	real.buf = tree;
 
-	empty.buf = "";
-	empty.size = 0;
-	retval = diff_tree(&empty, &real, base, &diff_options);
-	free(tree);
+	retval = diff_tree(NULL, real, base, &diff_options);
 	call_diff_flush();
 	return retval;
 }
diff --git a/diff.h b/diff.h
index 9a0169c..9142c04 100644
--- a/diff.h
+++ b/diff.h
@@ -4,15 +4,12 @@
 #ifndef DIFF_H
 #define DIFF_H
 
+#include "tree.h"
+
 #define DIFF_FILE_CANON_MODE(mode) \
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
 
-struct tree_desc {
-	void *buf;
-	unsigned long size;
-};
-
 struct diff_options;
 
 typedef void (*change_fn_t)(struct diff_options *options,
@@ -51,7 +48,7 @@ struct diff_options {
 };
 
 extern void diff_tree_setup_paths(const char **paths);
-extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+extern int diff_tree(struct tree *t1, struct tree *t2,
 		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
diff --git a/rev-list.c b/rev-list.c
index 0b142c1..86da74a 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -485,23 +485,12 @@ static int compare_tree(struct tree *t1,
 static int same_tree_as_empty(struct tree *t1)
 {
 	int retval;
-	void *tree;
-	struct tree_desc empty, real;
 
 	if (!t1)
 		return 0;
 
-	tree = read_object_with_reference(t1->object.sha1, "tree", &real.size, NULL);
-	if (!tree)
-		return 0;
-	real.buf = tree;
-
-	empty.buf = "";
-	empty.size = 0;
-
 	tree_difference = 0;
-	retval = diff_tree(&empty, &real, "", &diff_opt);
-	free(tree);
+	retval = diff_tree(NULL, t1, "", &diff_opt);
 
 	return retval >= 0 && !tree_difference;
 }
diff --git a/tree-diff.c b/tree-diff.c
index 382092b..c3526d1 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -3,38 +3,18 @@
  */
 #include "cache.h"
 #include "diff.h"
+#include "tree.h"
 
 // What paths are we interested in?
 static int nr_paths = 0;
 static const char **paths = NULL;
 static int *pathlens = NULL;
 
-static void update_tree_entry(struct tree_desc *desc)
+static const unsigned char *extract(struct tree_entry_list *desc, const char **pathp, unsigned int *modep)
 {
-	void *buf = desc->buf;
-	unsigned long size = desc->size;
-	int len = strlen(buf) + 1 + 20;
-
-	if (size < len)
-		die("corrupt tree file");
-	desc->buf = buf + len;
-	desc->size = size - len;
-}
-
-static const unsigned char *extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
-{
-	void *tree = desc->buf;
-	unsigned long size = desc->size;
-	int len = strlen(tree)+1;
-	const unsigned char *sha1 = tree + len;
-	const char *path = strchr(tree, ' ');
-	unsigned int mode;
-
-	if (!path || size < len + 20 || sscanf(tree, "%o", &mode) != 1)
-		die("corrupt tree file");
-	*pathp = path+1;
-	*modep = DIFF_FILE_CANON_MODE(mode);
-	return sha1;
+	*pathp = desc->name;
+	*modep = DIFF_FILE_CANON_MODE(desc->mode);
+	return desc->item.any->sha1;
 }
 
 static char *malloc_base(const char *base, const char *path, int pathlen)
@@ -47,9 +27,11 @@ static char *malloc_base(const char *bas
 	return newbase;
 }
 
-static int show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base);
+static int show_entry(struct diff_options *opt, const char *prefix, struct tree_entry_list *desc, const char *base);
 
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+static int compare_tree_entry(struct tree_entry_list *t1, 
+			      struct tree_entry_list *t2, 
+			      const char *base, struct diff_options *opt)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
@@ -99,7 +81,7 @@ static int compare_tree_entry(struct tre
 	return 0;
 }
 
-static int interesting(struct tree_desc *desc, const char *base)
+static int interesting(struct tree_entry_list *desc, const char *base)
 {
 	const char *path;
 	unsigned mode;
@@ -153,36 +135,36 @@ static int interesting(struct tree_desc 
 }
 
 /* A whole sub-tree went away or appeared */
-static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
+static void show_tree(struct diff_options *opt, const char *prefix, 
+		      struct tree *desc, const char *base)
 {
-	while (desc->size) {
-		if (interesting(desc, base))
-			show_entry(opt, prefix, desc, base);
-		update_tree_entry(desc);
+	struct tree_entry_list *list;
+	parse_tree(desc);
+	list = desc->entries;
+	while (list) {
+		if (interesting(list, base))
+			show_entry(opt, prefix, list, base);
+		list = list->next;
 	}
 }
 
 /* A file entry went away or appeared */
-static int show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
+static int show_entry(struct diff_options *opt, const char *prefix,
+		      struct tree_entry_list *desc, const char *base)
 {
 	unsigned mode;
 	const char *path;
 	const unsigned char *sha1 = extract(desc, &path, &mode);
 
-	if (opt->recursive && S_ISDIR(mode)) {
-		char type[20];
+	if (opt->recursive && desc->directory) {
 		char *newbase = malloc_base(base, path, strlen(path));
-		struct tree_desc inner;
-		void *tree;
+		struct tree *tree;
 
-		tree = read_sha1_file(sha1, type, &inner.size);
-		if (!tree || strcmp(type, "tree"))
-			die("corrupt tree sha %s", sha1_to_hex(sha1));
+		tree = desc->item.tree;
 
-		inner.buf = tree;
-		show_tree(opt, prefix, &inner, newbase);
+		parse_tree(tree);
+		show_tree(opt, prefix, tree, newbase);
 
-		free(tree);
 		free(newbase);
 		return 0;
 	}
@@ -191,36 +173,46 @@ static int show_entry(struct diff_option
 	return 0;
 }
 
-int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+int diff_tree(struct tree *tree1, struct tree *tree2, const char *base,
+	      struct diff_options *opt)
 {
-	while (t1->size | t2->size) {
-		if (nr_paths && t1->size && !interesting(t1, base)) {
-			update_tree_entry(t1);
+	struct tree_entry_list *t1 = NULL, *t2 = NULL;
+	if (tree1) {
+		parse_tree(tree1);
+		t1 = tree1->entries;
+	}
+	if (tree2) {
+		parse_tree(tree2);
+		t2 = tree2->entries;
+	}
+	while (t1 || t2) {
+		if (nr_paths && t1 && !interesting(t1, base)) {
+			t1 = t1->next;
 			continue;
 		}
-		if (nr_paths && t2->size && !interesting(t2, base)) {
-			update_tree_entry(t2);
+		if (nr_paths && t2 && !interesting(t2, base)) {
+			t2 = t2->next;
 			continue;
 		}
-		if (!t1->size) {
+		if (!t1) {
 			show_entry(opt, "+", t2, base);
-			update_tree_entry(t2);
+			t2 = t2->next;
 			continue;
 		}
-		if (!t2->size) {
+		if (!t2) {
 			show_entry(opt, "-", t1, base);
-			update_tree_entry(t1);
+			t1 = t1->next;
 			continue;
 		}
 		switch (compare_tree_entry(t1, t2, base, opt)) {
 		case -1:
-			update_tree_entry(t1);
+			t1 = t1->next;
 			continue;
 		case 0:
-			update_tree_entry(t1);
+			t1 = t1->next;
 			/* Fallthrough */
 		case 1:
-			update_tree_entry(t2);
+			t2 = t2->next;
 			continue;
 		}
 		die("git-diff-tree: internal error");
@@ -230,21 +222,16 @@ int diff_tree(struct tree_desc *t1, stru
 
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	void *tree1, *tree2;
-	struct tree_desc t1, t2;
+	struct tree *t1, *t2;
 	int retval;
 
-	tree1 = read_object_with_reference(old, "tree", &t1.size, NULL);
-	if (!tree1)
+	t1 = parse_tree_indirect(old);
+	if (!t1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, "tree", &t2.size, NULL);
-	if (!tree2)
+	t2 = parse_tree_indirect(new);
+	if (!t2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
-	t1.buf = tree1;
-	t2.buf = tree2;
-	retval = diff_tree(&t1, &t2, base, opt);
-	free(tree1);
-	free(tree2);
+	retval = diff_tree(t1, t2, base, opt);
 	return retval;
 }
 
-- 
1.0.GIT
