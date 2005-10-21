From: Linus Torvalds <torvalds@osdl.org>
Subject: Split up tree diff functions into tree-diff.c library
Date: Thu, 20 Oct 2005 21:05:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510202058030.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 21 06:05:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESo9j-0004NG-NR
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 06:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVJUEFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 00:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVJUEFP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 00:05:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbVJUEFN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 00:05:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L457FC010826
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 21:05:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L455Kg022600;
	Thu, 20 Oct 2005 21:05:06 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.5 required=5 tests=REMOVE_REMOVAL_2WORD
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10414>


This makes the tree diff functionality independent of the "git-diff-tree" 
program, by splitting the core functionality up into a library file.

This will be needed for when we teach git-rev-list to only follow a 
specified set of pathnames, rather than the global revision history.

Most of it is a fairly straightforward code move, but it also involves 
some calling convention cleanup, and moving some of the static variables 
from diff-tree.c into the options structure.

The actual tree change callback routines also become paramterized by the 
diff_options structure, allowing the library functionality to do something 
else than just show the diff on stdout.

Right now the only user of this functionality remains git-diff-tree 
itself.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

NOTE! I think I did everything right, and things still seem to work, but 
this is worth having a few people look at more closely. git-diff-tree is 
some pretty damn core functionality.

The next email will contain a first cut at changing git-rev-list to take 
advantage of the new library interface.


diff --git a/Makefile b/Makefile
index 5ee72bc..95f8c57 100644
--- a/Makefile
+++ b/Makefile
@@ -151,7 +151,7 @@ LIB_H = \
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
-	diffcore-pickaxe.o diffcore-rename.o
+	diffcore-pickaxe.o diffcore-rename.o tree-diff.o
 
 LIB_OBJS = \
 	blob.o commit.o connect.o count-delta.o csum-file.o \
diff --git a/diff-tree.c b/diff-tree.c
index 8517220..382011a 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -5,256 +5,13 @@
 static int show_root_diff = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
-static int recursive = 0;
-static int show_tree_entry_in_recursive = 0;
 static int read_stdin = 0;
 
-static struct diff_options diff_options;
-
 static const char *header = NULL;
 static const char *header_prefix = "";
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 
-// What paths are we interested in?
-static int nr_paths = 0;
-static const char **paths = NULL;
-static int *pathlens = NULL;
-
-static int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base);
-
-static void update_tree_entry(void **bufp, unsigned long *sizep)
-{
-	void *buf = *bufp;
-	unsigned long size = *sizep;
-	int len = strlen(buf) + 1 + 20;
-
-	if (size < len)
-		die("corrupt tree file");
-	*bufp = buf + len;
-	*sizep = size - len;
-}
-
-static const unsigned char *extract(void *tree, unsigned long size, const char **pathp, unsigned int *modep)
-{
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
-}
-
-static char *malloc_base(const char *base, const char *path, int pathlen)
-{
-	int baselen = strlen(base);
-	char *newbase = xmalloc(baselen + pathlen + 2);
-	memcpy(newbase, base, baselen);
-	memcpy(newbase + baselen, path, pathlen);
-	memcpy(newbase + baselen + pathlen, "/", 2);
-	return newbase;
-}
-
-static void show_file(const char *prefix, void *tree, unsigned long size, const char *base);
-static void show_tree(const char *prefix, void *tree, unsigned long size, const char *base);
-
-/* A file entry went away or appeared */
-static void show_file(const char *prefix, void *tree, unsigned long size, const char *base)
-{
-	unsigned mode;
-	const char *path;
-	const unsigned char *sha1 = extract(tree, size, &path, &mode);
-
-	if (recursive && S_ISDIR(mode)) {
-		char type[20];
-		unsigned long size;
-		char *newbase = malloc_base(base, path, strlen(path));
-		void *tree;
-
-		tree = read_sha1_file(sha1, type, &size);
-		if (!tree || strcmp(type, "tree"))
-			die("corrupt tree sha %s", sha1_to_hex(sha1));
-
-		show_tree(prefix, tree, size, newbase);
-
-		free(tree);
-		free(newbase);
-		return;
-	}
-
-	diff_addremove(&diff_options, prefix[0], mode, sha1, base, path);
-}
-
-static int compare_tree_entry(void *tree1, unsigned long size1, void *tree2, unsigned long size2, const char *base)
-{
-	unsigned mode1, mode2;
-	const char *path1, *path2;
-	const unsigned char *sha1, *sha2;
-	int cmp, pathlen1, pathlen2;
-
-	sha1 = extract(tree1, size1, &path1, &mode1);
-	sha2 = extract(tree2, size2, &path2, &mode2);
-
-	pathlen1 = strlen(path1);
-	pathlen2 = strlen(path2);
-	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
-	if (cmp < 0) {
-		show_file("-", tree1, size1, base);
-		return -1;
-	}
-	if (cmp > 0) {
-		show_file("+", tree2, size2, base);
-		return 1;
-	}
-	if (!diff_options.find_copies_harder &&
-	    !memcmp(sha1, sha2, 20) && mode1 == mode2)
-		return 0;
-
-	/*
-	 * If the filemode has changed to/from a directory from/to a regular
-	 * file, we need to consider it a remove and an add.
-	 */
-	if (S_ISDIR(mode1) != S_ISDIR(mode2)) {
-		show_file("-", tree1, size1, base);
-		show_file("+", tree2, size2, base);
-		return 0;
-	}
-
-	if (recursive && S_ISDIR(mode1)) {
-		int retval;
-		char *newbase = malloc_base(base, path1, pathlen1);
-		if (show_tree_entry_in_recursive)
-			diff_change(&diff_options, mode1, mode2,
-				    sha1, sha2, base, path1);
-		retval = diff_tree_sha1(sha1, sha2, newbase);
-		free(newbase);
-		return retval;
-	}
-
-	diff_change(&diff_options, mode1, mode2, sha1, sha2, base, path1);
-	return 0;
-}
-
-static int interesting(void *tree, unsigned long size, const char *base)
-{
-	const char *path;
-	unsigned mode;
-	int i;
-	int baselen, pathlen;
-
-	if (!nr_paths)
-		return 1;
-
-	(void)extract(tree, size, &path, &mode);
-
-	pathlen = strlen(path);
-	baselen = strlen(base);
-
-	for (i=0; i < nr_paths; i++) {
-		const char *match = paths[i];
-		int matchlen = pathlens[i];
-
-		if (baselen >= matchlen) {
-			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
-				continue;
-
-			/* The base is a subdirectory of a path which was specified. */
-			return 1;
-		}
-
-		/* Does the base match? */
-		if (strncmp(base, match, baselen))
-			continue;
-
-		match += baselen;
-		matchlen -= baselen;
-
-		if (pathlen > matchlen)
-			continue;
-
-		if (matchlen > pathlen) {
-			if (match[pathlen] != '/')
-				continue;
-			if (!S_ISDIR(mode))
-				continue;
-		}
-
-		if (strncmp(path, match, pathlen))
-			continue;
-
-		return 1;
-	}
-	return 0; /* No matches */
-}
-
-/* A whole sub-tree went away or appeared */
-static void show_tree(const char *prefix, void *tree, unsigned long size, const char *base)
-{
-	while (size) {
-		if (interesting(tree, size, base))
-			show_file(prefix, tree, size, base);
-		update_tree_entry(&tree, &size);
-	}
-}
-
-static int diff_tree(void *tree1, unsigned long size1, void *tree2, unsigned long size2, const char *base)
-{
-	while (size1 | size2) {
-		if (nr_paths && size1 && !interesting(tree1, size1, base)) {
-			update_tree_entry(&tree1, &size1);
-			continue;
-		}
-		if (nr_paths && size2 && !interesting(tree2, size2, base)) {
-			update_tree_entry(&tree2, &size2);
-			continue;
-		}
-		if (!size1) {
-			show_file("+", tree2, size2, base);
-			update_tree_entry(&tree2, &size2);
-			continue;
-		}
-		if (!size2) {
-			show_file("-", tree1, size1, base);
-			update_tree_entry(&tree1, &size1);
-			continue;
-		}
-		switch (compare_tree_entry(tree1, size1, tree2, size2, base)) {
-		case -1:
-			update_tree_entry(&tree1, &size1);
-			continue;
-		case 0:
-			update_tree_entry(&tree1, &size1);
-			/* Fallthrough */
-		case 1:
-			update_tree_entry(&tree2, &size2);
-			continue;
-		}
-		die("git-diff-tree: internal error");
-	}
-	return 0;
-}
-
-static int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base)
-{
-	void *tree1, *tree2;
-	unsigned long size1, size2;
-	int retval;
-
-	tree1 = read_object_with_reference(old, "tree", &size1, NULL);
-	if (!tree1)
-		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, "tree", &size2, NULL);
-	if (!tree2)
-		die("unable to read destination tree (%s)", sha1_to_hex(new));
-	retval = diff_tree(tree1, size1, tree2, size2, base);
-	free(tree1);
-	free(tree2);
-	return retval;
-}
+static struct diff_options diff_options;
 
 static void call_diff_setup_done(void)
 {
@@ -285,7 +42,7 @@ static int diff_tree_sha1_top(const unsi
 	int ret;
 
 	call_diff_setup_done();
-	ret = diff_tree_sha1(old, new, base);
+	ret = diff_tree_sha1(old, new, base, &diff_options);
 	call_diff_flush();
 	return ret;
 }
@@ -294,13 +51,17 @@ static int diff_root_tree(const unsigned
 {
 	int retval;
 	void *tree;
-	unsigned long size;
+	struct tree_desc empty, real;
 
 	call_diff_setup_done();
-	tree = read_object_with_reference(new, "tree", &size, NULL);
+	tree = read_object_with_reference(new, "tree", &real.size, NULL);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
-	retval = diff_tree("", 0, tree, size, base);
+	real.buf = tree;
+
+	empty.buf = "";
+	empty.size = 0;
+	retval = diff_tree(&empty, &real, base, &diff_options);
 	free(tree);
 	call_diff_flush();
 	return retval;
@@ -387,14 +148,6 @@ static int diff_tree_stdin(char *line)
 	return diff_tree_commit(commit, line);
 }
 
-static int count_paths(const char **paths)
-{
-	int i = 0;
-	while (*paths++)
-		i++;
-	return i;
-}
-
 static const char diff_tree_usage[] =
 "git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] "
 "[<common diff options>] <tree-ish> <tree-ish>"
@@ -445,11 +198,12 @@ int main(int argc, const char **argv)
 			break;
 		}
 		if (!strcmp(arg, "-r")) {
-			recursive = 1;
+			diff_options.recursive = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-t")) {
-			recursive = show_tree_entry_in_recursive = 1;
+			diff_options.recursive = 1;
+			diff_options.tree_in_recursive = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-m")) {
@@ -478,17 +232,9 @@ int main(int argc, const char **argv)
 		usage(diff_tree_usage);
 	}
 	if (diff_options.output_format == DIFF_FORMAT_PATCH)
-		recursive = 1;
+		diff_options.recursive = 1;
 
-	paths = get_pathspec(prefix, argv);
-	if (paths) {
-		int i;
-
-		nr_paths = count_paths(paths);
-		pathlens = xmalloc(nr_paths * sizeof(int));
-		for (i=0; i<nr_paths; i++)
-			pathlens[i] = strlen(paths[i]);
-	}
+	diff_tree_setup_paths(get_pathspec(prefix, argv));
 
 	switch (nr_sha1) {
 	case 0:
diff --git a/diff.c b/diff.c
index 306bcd9..ec94a96 100644
--- a/diff.c
+++ b/diff.c
@@ -754,6 +754,9 @@ void diff_setup(struct diff_options *opt
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
+
+	options->change = diff_change;
+	options->add_remove = diff_addremove;
 }
 
 int diff_setup_done(struct diff_options *options)
diff --git a/diff.h b/diff.h
index 2f4a7b4..5115547 100644
--- a/diff.h
+++ b/diff.h
@@ -8,11 +8,31 @@
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
 
+struct tree_desc {
+	void *buf;
+	unsigned long size;
+};
+
+struct diff_options;
+
+typedef void (*change_fn_t)(struct diff_options *options,
+		 unsigned old_mode, unsigned new_mode,
+		 const unsigned char *old_sha1,
+		 const unsigned char *new_sha1,
+		 const char *base, const char *path);
+
+typedef void (*add_remove_fn_t)(struct diff_options *options,
+		    int addremove, unsigned mode,
+		    const unsigned char *sha1,
+		    const char *base, const char *path);
+
 struct diff_options {
 	const char **paths;
 	const char *filter;
 	const char *orderfile;
 	const char *pickaxe;
+	unsigned recursive:1,
+		 tree_in_recursive:1;
 	int break_opt;
 	int detect_rename;
 	int find_copies_harder;
@@ -23,8 +43,17 @@ struct diff_options {
 	int reverse_diff;
 	int rename_limit;
 	int setup;
+
+	change_fn_t change;
+	add_remove_fn_t add_remove;
 };
 
+extern void diff_tree_setup_paths(const char **paths);
+extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+		     const char *base, struct diff_options *opt);
+extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
+			  const char *base, struct diff_options *opt);
+
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
diff --git a/tree-diff.c b/tree-diff.c
new file mode 100644
index 0000000..0ef06a9
--- /dev/null
+++ b/tree-diff.c
@@ -0,0 +1,270 @@
+/*
+ * Helper functions for tree diff generation
+ */
+#include "cache.h"
+#include "diff.h"
+
+// What paths are we interested in?
+static int nr_paths = 0;
+static const char **paths = NULL;
+static int *pathlens = NULL;
+
+static void update_tree_entry(struct tree_desc *desc)
+{
+	void *buf = desc->buf;
+	unsigned long size = desc->size;
+	int len = strlen(buf) + 1 + 20;
+
+	if (size < len)
+		die("corrupt tree file");
+	desc->buf = buf + len;
+	desc->size = size - len;
+}
+
+static const unsigned char *extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
+{
+	void *tree = desc->buf;
+	unsigned long size = desc->size;
+	int len = strlen(tree)+1;
+	const unsigned char *sha1 = tree + len;
+	const char *path = strchr(tree, ' ');
+	unsigned int mode;
+
+	if (!path || size < len + 20 || sscanf(tree, "%o", &mode) != 1)
+		die("corrupt tree file");
+	*pathp = path+1;
+	*modep = DIFF_FILE_CANON_MODE(mode);
+	return sha1;
+}
+
+static char *malloc_base(const char *base, const char *path, int pathlen)
+{
+	int baselen = strlen(base);
+	char *newbase = xmalloc(baselen + pathlen + 2);
+	memcpy(newbase, base, baselen);
+	memcpy(newbase + baselen, path, pathlen);
+	memcpy(newbase + baselen + pathlen, "/", 2);
+	return newbase;
+}
+
+static int show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base);
+
+static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+{
+	unsigned mode1, mode2;
+	const char *path1, *path2;
+	const unsigned char *sha1, *sha2;
+	int cmp, pathlen1, pathlen2;
+
+	sha1 = extract(t1, &path1, &mode1);
+	sha2 = extract(t2, &path2, &mode2);
+
+	pathlen1 = strlen(path1);
+	pathlen2 = strlen(path2);
+	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
+	if (cmp < 0) {
+		show_entry(opt, "-", t1, base);
+		return -1;
+	}
+	if (cmp > 0) {
+		show_entry(opt, "+", t2, base);
+		return 1;
+	}
+	if (!opt->find_copies_harder &&
+	    !memcmp(sha1, sha2, 20) && mode1 == mode2)
+		return 0;
+
+	/*
+	 * If the filemode has changed to/from a directory from/to a regular
+	 * file, we need to consider it a remove and an add.
+	 */
+	if (S_ISDIR(mode1) != S_ISDIR(mode2)) {
+		show_entry(opt, "-", t1, base);
+		show_entry(opt, "+", t2, base);
+		return 0;
+	}
+
+	if (opt->recursive && S_ISDIR(mode1)) {
+		int retval;
+		char *newbase = malloc_base(base, path1, pathlen1);
+		if (opt->tree_in_recursive)
+			opt->change(opt, mode1, mode2,
+				    sha1, sha2, base, path1);
+		retval = diff_tree_sha1(sha1, sha2, newbase, opt);
+		free(newbase);
+		return retval;
+	}
+
+	opt->change(opt, mode1, mode2, sha1, sha2, base, path1);
+	return 0;
+}
+
+static int interesting(struct tree_desc *desc, const char *base)
+{
+	const char *path;
+	unsigned mode;
+	int i;
+	int baselen, pathlen;
+
+	if (!nr_paths)
+		return 1;
+
+	(void)extract(desc, &path, &mode);
+
+	pathlen = strlen(path);
+	baselen = strlen(base);
+
+	for (i=0; i < nr_paths; i++) {
+		const char *match = paths[i];
+		int matchlen = pathlens[i];
+
+		if (baselen >= matchlen) {
+			/* If it doesn't match, move along... */
+			if (strncmp(base, match, matchlen))
+				continue;
+
+			/* The base is a subdirectory of a path which was specified. */
+			return 1;
+		}
+
+		/* Does the base match? */
+		if (strncmp(base, match, baselen))
+			continue;
+
+		match += baselen;
+		matchlen -= baselen;
+
+		if (pathlen > matchlen)
+			continue;
+
+		if (matchlen > pathlen) {
+			if (match[pathlen] != '/')
+				continue;
+			if (!S_ISDIR(mode))
+				continue;
+		}
+
+		if (strncmp(path, match, pathlen))
+			continue;
+
+		return 1;
+	}
+	return 0; /* No matches */
+}
+
+/* A whole sub-tree went away or appeared */
+static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
+{
+	while (desc->size) {
+		if (interesting(desc, base))
+			show_entry(opt, prefix, desc, base);
+		update_tree_entry(desc);
+	}
+}
+
+/* A file entry went away or appeared */
+static int show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
+{
+	unsigned mode;
+	const char *path;
+	const unsigned char *sha1 = extract(desc, &path, &mode);
+
+	if (opt->recursive && S_ISDIR(mode)) {
+		char type[20];
+		char *newbase = malloc_base(base, path, strlen(path));
+		struct tree_desc inner;
+		void *tree;
+
+		tree = read_sha1_file(sha1, type, &inner.size);
+		if (!tree || strcmp(type, "tree"))
+			die("corrupt tree sha %s", sha1_to_hex(sha1));
+
+		inner.buf = tree;
+		show_tree(opt, prefix, &inner, newbase);
+
+		free(tree);
+		free(newbase);
+		return 0;
+	}
+
+	opt->add_remove(opt, prefix[0], mode, sha1, base, path);
+	return 0;
+}
+
+int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+{
+	while (t1->size | t2->size) {
+		if (nr_paths && t1->size && !interesting(t1, base)) {
+			update_tree_entry(t1);
+			continue;
+		}
+		if (nr_paths && t2->size && !interesting(t2, base)) {
+			update_tree_entry(t2);
+			continue;
+		}
+		if (!t1->size) {
+			show_entry(opt, "+", t2, base);
+			update_tree_entry(t2);
+			continue;
+		}
+		if (!t2->size) {
+			show_entry(opt, "-", t1, base);
+			update_tree_entry(t1);
+			continue;
+		}
+		switch (compare_tree_entry(t1, t2, base, opt)) {
+		case -1:
+			update_tree_entry(t1);
+			continue;
+		case 0:
+			update_tree_entry(t1);
+			/* Fallthrough */
+		case 1:
+			update_tree_entry(t2);
+			continue;
+		}
+		die("git-diff-tree: internal error");
+	}
+	return 0;
+}
+
+int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+{
+	void *tree1, *tree2;
+	struct tree_desc t1, t2;
+	int retval;
+
+	tree1 = read_object_with_reference(old, "tree", &t1.size, NULL);
+	if (!tree1)
+		die("unable to read source tree (%s)", sha1_to_hex(old));
+	tree2 = read_object_with_reference(new, "tree", &t2.size, NULL);
+	if (!tree2)
+		die("unable to read destination tree (%s)", sha1_to_hex(new));
+	t1.buf = tree1;
+	t2.buf = tree2;
+	retval = diff_tree(&t1, &t2, base, opt);
+	free(tree1);
+	free(tree2);
+	return retval;
+}
+
+static int count_paths(const char **paths)
+{
+	int i = 0;
+	while (*paths++)
+		i++;
+	return i;
+}
+
+void diff_tree_setup_paths(const char **p)
+{
+	if (p) {
+		int i;
+
+		paths = p;
+		nr_paths = count_paths(paths);
+		pathlens = xmalloc(nr_paths * sizeof(int));
+		for (i=0; i<nr_paths; i++)
+			pathlens[i] = strlen(paths[i]);
+	}
+}
