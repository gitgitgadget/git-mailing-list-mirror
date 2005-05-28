From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH-RFC] Rewrite ls-tree to behave more like "/bin/ls -a"
Date: Sat, 28 May 2005 00:05:38 -0700
Message-ID: <7vll5zygn1.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050527120851.GA11823@port.evillabs.net>
	<7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
	<1117221986.11542.29.camel@jmcmullan.timesys>
	<7v1x7syqkm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason McMullan <jason.mcmullan@timesys.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 09:04:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbvMv-0001b0-6m
	for gcvg-git@gmane.org; Sat, 28 May 2005 09:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVE1HGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 03:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVE1HGa
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 03:06:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24022 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261852AbVE1HFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 03:05:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528070540.WWLS19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 03:05:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v1x7syqkm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 20:31:05 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a complete rewrite of ls-tree to make it behave more
like what "/bin/ls -a" does in the current working directory.

Namely, the changes are:

 - Unlike the old ls-tree behaviour that used paths arguments to
   restrict output (not that it worked as intended---as pointed
   out in the mailing list discussion, it was quite incoherent),
   this rewrite uses paths arguments to specify what to show.

 - Without arguments, it implicitly uses the root level as its
   sole argument ("/bin/ls -a" behaves as if "." is given
   without argument).

 - Without -r (recursive) flag, it shows the named blob (either
   file or symlink), or the named tree and its immediate
   children.

 - With -r flag, it shows the named path, and recursively
   descends into it if it is a tree.

 - With -d flag, it shows the named path and does not show its
   children even if the path is a tree, nor descends into it
   recursively.

This is still request-for-comments patch.  There is no mailing
list consensus that this proposed new behaviour is a good one.

The patch to t/t3100-ls-tree-restrict.sh illustrates
user-visible behaviour changes.  Namely:

 * "git-ls-tree $tree path1 path0" lists path1 first and then
   path0.  It used to use paths as an output restrictor and
   showed output in cache entry order (i.e. path0 first and then
   path1) regardless of the order of paths arguments.

 * "git-ls-tree $tree path2" lists path2 and its immediate
   children but having explicit paths argument does not imply
   recursive behaviour anymore, hence paths/baz is shown but not
   paths/baz/b.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-ls-tree.txt |   20 +-
ls-tree.c                     |  333 +++++++++++++++++++++++-------------------
t/t3100-ls-tree-restrict.sh   |    3 
tree.c                        |    2 
tree.h                        |    1 
5 files changed, 199 insertions(+), 160 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -4,23 +4,26 @@ v0.1, May 2005
 
 NAME
 ----
-git-ls-tree - Displays a tree object in human readable form
+git-ls-tree - Lists the contents of a tree object.
 
 
 SYNOPSIS
 --------
-'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
+'git-ls-tree' [-d] [-r] [-z] <tree-ish> [paths...]
 
 DESCRIPTION
 -----------
-Converts the tree object to a human readable (and script processable)
-form.
+Lists the contents of a tree object, like what "/bin/ls -a" does
+in the current working directory.
 
 OPTIONS
 -------
 <tree-ish>::
 	Id of a tree.
 
+-d::
+	show only the named tree entry itself, not its children
+
 -r::
 	recurse into sub-trees
 
@@ -28,18 +31,19 @@ OPTIONS
 	\0 line termination on output
 
 paths::
-	Optionally, restrict the output of git-ls-tree to specific
-	paths. Directories will only list their tree blob ids.
-	Implies -r.
+	When paths are given, shows them.  Otherwise implicitly
+	uses the root level of the tree as the sole path argument.
+
 
 Output Format
 -------------
-        <mode>\t	<type>\t	<object>\t	<file>
+        <mode> SP <type> SP <object> TAB <file>
 
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
+Completely rewritten from scratch by Junio C Hamano <junkio@cox.net>
 
 Documentation
 --------------
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -4,188 +4,217 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "blob.h"
+#include "tree.h"
 
 static int line_termination = '\n';
-static int recursive = 0;
+#define LS_RECURSIVE 1
+#define LS_TREE_ONLY 2
+static int ls_options = 0;
 
-struct path_prefix {
-	struct path_prefix *prev;
-	const char *name;
-};
-
-#define DEBUG(fmt, ...)	
-
-static int string_path_prefix(char *buff, size_t blen, struct path_prefix *prefix)
-{
-	int len = 0;
-	if (prefix) {
-		if (prefix->prev) {
-			len = string_path_prefix(buff,blen,prefix->prev);
-			buff += len;
-			blen -= len;
-			if (blen > 0) {
-				*buff = '/';
-				len++;
-				buff++;
-				blen--;
-			}
-		}
-		strncpy(buff,prefix->name,blen);
-		return len + strlen(prefix->name);
-	}
+static struct tree_entry_list root_entry;
 
-	return 0;
+static void prepare_root(unsigned char *sha1)
+{
+	unsigned char rsha[20];
+	unsigned long size;
+	void *buf;
+	struct tree *root_tree;
+
+	buf = read_object_with_reference(sha1, "tree", &size, rsha);
+	free(buf);
+	if (!buf)
+		die("Could not read %s", sha1_to_hex(sha1));
+
+	root_tree = lookup_tree(rsha);
+	if (!root_tree)
+		die("Could not read %s", sha1_to_hex(sha1));
+
+	/* Prepare a fake entry */
+	root_entry.directory = 1;
+	root_entry.executable = root_entry.symlink = 0;
+	root_entry.mode = S_IFDIR;
+	root_entry.name = "";
+	root_entry.item.tree = root_tree;
+	root_entry.parent = NULL;
 }
 
-static void print_path_prefix(struct path_prefix *prefix)
+static int prepare_children(struct tree_entry_list *elem)
 {
-	if (prefix) {
-		if (prefix->prev) {
-			print_path_prefix(prefix->prev);
-			putchar('/');
-		}
-		fputs(prefix->name, stdout);
+	if (!elem->directory)
+		return -1;
+	if (!elem->item.tree->object.parsed) {
+		struct tree_entry_list *e;
+		if (parse_tree(elem->item.tree))
+			return -1;
+		/* Set up the parent link */
+		for (e = elem->item.tree->entries; e; e = e->next)
+			e->parent = elem;
 	}
+	return 0;
 }
 
-/*
- * return:
- * 	-1 if prefix is *not* a subset of path
- * 	 0 if prefix == path
- * 	 1 if prefix is a subset of path
- */
-static int pathcmp(const char *path, struct path_prefix *prefix)
-{
-	char buff[PATH_MAX];
-	int len,slen;
+static struct tree_entry_list *find_entry_0(struct tree_entry_list *elem,
+					    const char *path,
+					    const char *path_end)
+{
+	const char *ep;
+	int len;
+
+	while (path < path_end) {
+		if (prepare_children(elem))
+			return NULL;
 
-	if (prefix == NULL)
-		return 1;
+		/* In elem->tree->entries, find the one that has name
+		 * that matches what is between path and ep.
+		 */
+		elem = elem->item.tree->entries;
 
-	len = string_path_prefix(buff, sizeof buff, prefix);
-	slen = strlen(path);
+		ep = strchr(path, '/');
+		if (!ep || path_end <= ep)
+			ep = path_end;
+		len = ep - path;
+
+		while (elem) {
+			if ((strlen(elem->name) == len) &&
+			    !strncmp(elem->name, path, len))
+				break;
+			elem = elem->next;
+		}
+		if (path_end <= ep || !elem)
+			return elem;
+		while (*ep == '/' && ep < path_end)
+			ep++;
+		path = ep;
+	}
+	return NULL;
+}
 
-	if (slen < len)
-		return -1;
+static struct tree_entry_list *find_entry(const char *path,
+					  const char *path_end)
+{
+	/* Find tree element, descending from root, that
+	 * corresponds to the named path, lazily expanding
+	 * the tree if possible.
+	 */
+	if (path == path_end) {
+		/* Special.  This is the root level */
+		return &root_entry;
+	}
+	return find_entry_0(&root_entry, path, path_end);
+}
 
-	if (strncmp(path,buff,len) == 0) {
-		if (slen == len)
-			return 0;
-		else
-			return 1;
+static void show_entry_name(struct tree_entry_list *e)
+{
+	/* This is yucky.  The root level is there for
+	 * our convenience but we really want to do a
+	 * forest.
+	 */
+	if (e->parent && e->parent != &root_entry) {
+		show_entry_name(e->parent);
+		putchar('/');
 	}
+	printf("%s", e->name);
+}
 
-	return -1;
-}	
+static const char *entry_type(struct tree_entry_list *e)
+{
+	return (e->directory ? "tree" : "blob");
+}
 
-/*
- * match may be NULL, or a *sorted* list of paths
- */
-static void list_recursive(void *buffer,
-			   const char *type,
-			   unsigned long size,
-			   struct path_prefix *prefix,
-			   char **match, int matches)
-{
-	struct path_prefix this_prefix;
-	this_prefix.prev = prefix;
-
-	if (strcmp(type, "tree"))
-		die("expected a 'tree' node");
-
-	if (matches)
-		recursive = 1;
-
-	while (size) {
-		int namelen = strlen(buffer)+1;
-		void *eltbuf = NULL;
-		char elttype[20];
-		unsigned long eltsize;
-		unsigned char *sha1 = buffer + namelen;
-		char *path = strchr(buffer, ' ') + 1;
-		unsigned int mode;
-		const char *matched = NULL;
-		int mtype = -1;
-		int mindex;
-
-		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) != 1)
-			die("corrupt 'tree' file");
-		buffer = sha1 + 20;
-		size -= namelen + 20;
-
-		this_prefix.name = path;
-		for ( mindex = 0; mindex < matches; mindex++) {
-			mtype = pathcmp(match[mindex],&this_prefix);
-			if (mtype >= 0) {
-				matched = match[mindex];
-				break;
-			}
-		}
+static const char *entry_hex(struct tree_entry_list *e)
+{
+	return sha1_to_hex(e->directory
+			   ? e->item.tree->object.sha1
+			   : e->item.blob->object.sha1);
+}
 
-		/*
-		 * If we're not matching, or if this is an exact match,
-		 * print out the info
-		 */
-		if (!matches || (matched != NULL && mtype == 0)) {
-			printf("%06o %s %s\t", mode,
-			       S_ISDIR(mode) ? "tree" : "blob",
-			       sha1_to_hex(sha1));
-			print_path_prefix(&this_prefix);
-			putchar(line_termination);
-		}
+/* forward declaration for mutually recursive routines */
+static int show_entry(struct tree_entry_list *, int);
 
-		if (! recursive || ! S_ISDIR(mode))
-			continue;
+static int show_children(struct tree_entry_list *e, int level)
+{
+	if (prepare_children(e))
+		die("internal error: ls-tree show_children called with non tree");
+	e = e->item.tree->entries;
+	while (e) {
+		show_entry(e, level);
+		e = e->next;
+	}
+	return 0;
+}
 
-		if (matches && ! matched)
-			continue;
+static int show_entry(struct tree_entry_list *e, int level)
+{
+	int err = 0; 
 
-		if (! (eltbuf = read_sha1_file(sha1, elttype, &eltsize)) ) {
-			error("cannot read %s", sha1_to_hex(sha1));
-			continue;
-		}
+	if (e != &root_entry) {
+		printf("%06o %s %s	", e->mode, entry_type(e),
+		       entry_hex(e));
+		show_entry_name(e);
+		putchar(line_termination);
+	}
 
-		/* If this is an exact directory match, we may have
-		 * directory files following this path. Match on them.
-		 * Otherwise, we're at a pach subcomponent, and we need
-		 * to try to match again.
+	if (e->directory) {
+		/* If this is a directory, we have the following cases:
+		 * (1) This is the top-level request (explicit path from the
+		 *     command line, or "root" if there is no command line).
+		 *  a. Without any flag.  We show direct children.  We do not 
+		 *     recurse into them.
+		 *  b. With -r.  We do recurse into children.
+		 *  c. With -d.  We do not recurse into children.
+		 * (2) We came here because our caller is either (1-a) or
+		 *     (1-b).
+		 *  a. Without any flag.  We do not show our children (which
+		 *     are grandchildren for the original request).
+		 *  b. With -r.  We continue to recurse into our children.
+		 *  c. With -d.  We should not have come here to begin with.
 		 */
-		if (mtype == 0)
-			mindex++;
-
-		list_recursive(eltbuf, elttype, eltsize, &this_prefix, &match[mindex], matches-mindex);
-		free(eltbuf);
+		if (level == 0 && !(ls_options & LS_TREE_ONLY))
+			/* case (1)-a and (1)-b */
+			err = err | show_children(e, level+1);
+		else if (level && ls_options & LS_RECURSIVE)
+			/* case (2)-b */
+			err = err | show_children(e, level+1);
 	}
+	return err;
 }
 
-static int qcmp(const void *a, const void *b)
+static int list_one(const char *path, const char *path_end)
 {
-	return strcmp(*(char **)a, *(char **)b);
+	int err = 0;
+	struct tree_entry_list *e = find_entry(path, path_end);
+	if (!e) {
+		/* traditionally ls-tree does not complain about
+		 * missing path.  We may change this later to match
+		 * what "/bin/ls -a" does, which is to complain.
+		 */
+		return err;
+	}
+	err = err | show_entry(e, 0);
+	return err;
 }
 
-static int list(unsigned char *sha1,char **path)
+static int list(char **path)
 {
-	void *buffer;
-	unsigned long size;
-	int npaths;
-
-	for (npaths = 0; path[npaths] != NULL; npaths++)
-		;
-
-	qsort(path,npaths,sizeof(char *),qcmp);
-
-	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
-	if (!buffer)
-		die("unable to read sha1 file");
-	list_recursive(buffer, "tree", size, NULL, path, npaths);
-	free(buffer);
-	return 0;
+	int i;
+	int err = 0;
+	for (i = 0; path[i]; i++) {
+		int len = strlen(path[i]);
+		while (0 <= len && path[i][len] == '/')
+			len--;
+		err = err | list_one(path[i], path[i] + len);
+	}
+	return err;
 }
 
-static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key> [paths...]";
+static const char *ls_tree_usage =
+	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
 
 int main(int argc, char **argv)
 {
+	static char *path0[] = { "", NULL };
+	char **path;
 	unsigned char sha1[20];
 
 	while (1 < argc && argv[1][0] == '-') {
@@ -194,7 +223,10 @@ int main(int argc, char **argv)
 			line_termination = 0;
 			break;
 		case 'r':
-			recursive = 1;
+			ls_options |= LS_RECURSIVE;
+			break;
+		case 'd':
+			ls_options |= LS_TREE_ONLY;
 			break;
 		default:
 			usage(ls_tree_usage);
@@ -206,7 +238,10 @@ int main(int argc, char **argv)
 		usage(ls_tree_usage);
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	if (list(sha1, &argv[2]) < 0)
+
+	path = (argc == 2) ? path0 : (argv + 2);
+	prepare_root(sha1);
+	if (list(path) < 0)
 		die("list failed");
 	return 0;
 }
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -74,8 +74,8 @@ test_expect_success \
     'ls-tree filtered' \
     'git-ls-tree $tree path1 path0 >current &&
      cat >expected <<\EOF &&
-100644 blob X	path0
 120000 blob X	path1
+100644 blob X	path0
 EOF
      test_output'
 
@@ -85,7 +85,6 @@ test_expect_success \
      cat >expected <<\EOF &&
 040000 tree X	path2
 040000 tree X	path2/baz
-100644 blob X	path2/baz/b
 120000 blob X	path2/bazbo
 100644 blob X	path2/foo
 EOF
diff --git a/tree.c b/tree.c
--- a/tree.c
+++ b/tree.c
@@ -133,7 +133,7 @@ int parse_tree_buffer(struct tree *item,
 		}
 		if (obj)
 			add_ref(&item->object, obj);
-
+		entry->parent = NULL; /* needs to be filled by the user */
 		*list_p = entry;
 		list_p = &entry->next;
 	}
diff --git a/tree.h b/tree.h
--- a/tree.h
+++ b/tree.h
@@ -16,6 +16,7 @@ struct tree_entry_list {
 		struct tree *tree;
 		struct blob *blob;
 	} item;
+	struct tree_entry_list *parent;
 };
 
 struct tree {
------------------------------------------------

