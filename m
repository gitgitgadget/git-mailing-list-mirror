From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sat, 26 Nov 2005 09:38:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511260855560.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
 <7voe477n4i.fsf_-_@assigned-by-dhcp.cox
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 26 18:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg40N-0006Lh-B8
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 18:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVKZRi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 12:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVKZRi2
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 12:38:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750941AbVKZRi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 12:38:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAQHcLnO027376
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Nov 2005 09:38:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAQHcKRU015078;
	Sat, 26 Nov 2005 09:38:20 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12782>



On Sat, 26 Nov 2005, Junio C Hamano wrote:
> 
> --- a/ls-tree.c
> +++ b/ls-tree.c
> @@ -8,6 +8,8 @@
>  #include "tree.h"
>  #include "quote.h"
>  
> +static const char *prefix;
> +

No need to have this visible outside of "main()".

> +	prefix = setup_git_directory_gently(&nongit);
> +	if (prefix)
> +		path0[0] = prefix;
...
> +	if (argc == 2)
> +		path = path0;
> +	else
> +		path = get_pathspec(prefix, argv + 2);
> +

And this is just ugly.

git-ls-tree should be rewritten to use a pathspec the same way everybody 
else does. Right now it's the odd man out: if you do

	git-ls-tree HEAD divers/char drivers/

it will show the same files _twice_, which is not how pathspecs in general 
work.

How about this patch? It breaks some of the git-ls-tree tests, but it 
makes git-ls-tree work a lot more like other git pathspec commands, and it 
removes more than 150 lines by re-using the recursive tree traversal (but 
the "-d" flag is gone for good, so I'm not pushing this too hard).

		Linus

---
diff --git a/ls-tree.c b/ls-tree.c
index d9f15e3..598b729 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -13,215 +13,32 @@ static int line_termination = '\n';
 #define LS_TREE_ONLY 2
 static int ls_options = 0;
 
-static struct tree_entry_list root_entry;
-
-static void prepare_root(unsigned char *sha1)
-{
-	unsigned char rsha[20];
-	unsigned long size;
-	void *buf;
-	struct tree *root_tree;
-
-	buf = read_object_with_reference(sha1, "tree", &size, rsha);
-	free(buf);
-	if (!buf)
-		die("Could not read %s", sha1_to_hex(sha1));
-
-	root_tree = lookup_tree(rsha);
-	if (!root_tree)
-		die("Could not read %s", sha1_to_hex(sha1));
-
-	/* Prepare a fake entry */
-	root_entry.directory = 1;
-	root_entry.executable = root_entry.symlink = 0;
-	root_entry.mode = S_IFDIR;
-	root_entry.name = "";
-	root_entry.item.tree = root_tree;
-	root_entry.parent = NULL;
-}
-
-static int prepare_children(struct tree_entry_list *elem)
-{
-	if (!elem->directory)
-		return -1;
-	if (!elem->item.tree->object.parsed) {
-		struct tree_entry_list *e;
-		if (parse_tree(elem->item.tree))
-			return -1;
-		/* Set up the parent link */
-		for (e = elem->item.tree->entries; e; e = e->next)
-			e->parent = elem;
-	}
-	return 0;
-}
-
-static struct tree_entry_list *find_entry(const char *path, char *pathbuf)
-{
-	const char *next, *slash;
-	int len;
-	struct tree_entry_list *elem = &root_entry, *oldelem = NULL;
-
-	*(pathbuf) = '\0';
-
-	/* Find tree element, descending from root, that
-	 * corresponds to the named path, lazily expanding
-	 * the tree if possible.
-	 */
-
-	while (path) {
-		/* The fact we still have path means that the caller
-		 * wants us to make sure that elem at this point is a
-		 * directory, and possibly descend into it.  Even what
-		 * is left is just trailing slashes, we loop back to
-		 * here, and this call to prepare_children() will
-		 * catch elem not being a tree.  Nice.
-		 */
-		if (prepare_children(elem))
-			return NULL;
-
-		slash = strchr(path, '/');
-		if (!slash) {
-			len = strlen(path);
-			next = NULL;
-		}
-		else {
-			next = slash + 1;
-			len = slash - path;
-		}
-		if (len) {
-			if (oldelem) {
-				pathbuf += sprintf(pathbuf, "%s/", oldelem->name);
-			}
-
-			/* (len == 0) if the original path was "drivers/char/"
-			 * and we have run already two rounds, having elem
-			 * pointing at the drivers/char directory.
-			 */
-			elem = elem->item.tree->entries;
-			while (elem) {
-				if ((strlen(elem->name) == len) &&
-				    !strncmp(elem->name, path, len)) {
-					/* found */
-					break;
-				}
-				elem = elem->next;
-			}
-			if (!elem)
-				return NULL;
-
-			oldelem = elem;
-		}
-		path = next;
-	}
-
-	return elem;
-}
-
-static const char *entry_type(struct tree_entry_list *e)
-{
-	return (e->directory ? "tree" : "blob");
-}
-
-static const char *entry_hex(struct tree_entry_list *e)
-{
-	return sha1_to_hex(e->directory
-			   ? e->item.tree->object.sha1
-			   : e->item.blob->object.sha1);
-}
-
-/* forward declaration for mutually recursive routines */
-static int show_entry(struct tree_entry_list *, int, char *pathbuf);
-
-static int show_children(struct tree_entry_list *e, int level, char *pathbuf)
-{
-	int oldlen = strlen(pathbuf);
-
-	if (e != &root_entry)
-		sprintf(pathbuf + oldlen, "%s/", e->name);
-
-	if (prepare_children(e))
-		die("internal error: ls-tree show_children called with non tree");
-	e = e->item.tree->entries;
-	while (e) {
-		show_entry(e, level, pathbuf);
-		e = e->next;
-	}
-
-	pathbuf[oldlen] = '\0';
-
-	return 0;
-}
+static const char ls_tree_usage[] =
+	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
 
-static int show_entry(struct tree_entry_list *e, int level, char *pathbuf)
+static int show_tree(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
 {
-	int err = 0; 
-
-	if (e != &root_entry) {
-		printf("%06o %s %s	",
-		       e->mode, entry_type(e), entry_hex(e));
-		write_name_quoted(pathbuf, e->name, line_termination, stdout);
-		putchar(line_termination);
-	}
+	const char *type = "blob";
+	int retval = 0;
 
-	if (e->directory) {
-		/* If this is a directory, we have the following cases:
-		 * (1) This is the top-level request (explicit path from the
-		 *     command line, or "root" if there is no command line).
-		 *  a. Without any flag.  We show direct children.  We do not 
-		 *     recurse into them.
-		 *  b. With -r.  We do recurse into children.
-		 *  c. With -d.  We do not recurse into children.
-		 * (2) We came here because our caller is either (1-a) or
-		 *     (1-b).
-		 *  a. Without any flag.  We do not show our children (which
-		 *     are grandchildren for the original request).
-		 *  b. With -r.  We continue to recurse into our children.
-		 *  c. With -d.  We should not have come here to begin with.
-		 */
-		if (level == 0 && !(ls_options & LS_TREE_ONLY))
-			/* case (1)-a and (1)-b */
-			err = err | show_children(e, level+1, pathbuf);
-		else if (level && ls_options & LS_RECURSIVE)
-			/* case (2)-b */
-			err = err | show_children(e, level+1, pathbuf);
+	if (S_ISDIR(mode)) {
+		type = "tree";
+		if (ls_options & LS_RECURSIVE)
+			retval = READ_TREE_RECURSIVE;
 	}
-	return err;
-}
 
-static int list_one(const char *path)
-{
-	int err = 0;
-	char pathbuf[MAXPATHLEN + 1];
-	struct tree_entry_list *e = find_entry(path, pathbuf);
-	if (!e) {
-		/* traditionally ls-tree does not complain about
-		 * missing path.  We may change this later to match
-		 * what "/bin/ls -a" does, which is to complain.
-		 */
-		return err;
-	}
-	err = err | show_entry(e, 0, pathbuf);
-	return err;
+	printf("%06o %s %s\t%.*s%s%c", mode, type, sha1_to_hex(sha1), baselen, base, pathname, line_termination);
+	return retval;
 }
 
-static int list(char **path)
+int main(int argc, const char **argv)
 {
-	int i;
-	int err = 0;
-	for (i = 0; path[i]; i++)
-		err = err | list_one(path[i]);
-	return err;
-}
-
-static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
-
-int main(int argc, char **argv)
-{
-	static char *path0[] = { "", NULL };
-	char **path;
+	const char **path, *prefix;
 	unsigned char sha1[20];
+	char *buf;
+	unsigned long size;
 
+	prefix = setup_git_directory();
 	while (1 < argc && argv[1][0] == '-') {
 		switch (argv[1][1]) {
 		case 'z':
@@ -244,9 +61,11 @@ int main(int argc, char **argv)
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
 
-	path = (argc == 2) ? path0 : (argv + 2);
-	prepare_root(sha1);
-	if (list(path) < 0)
-		die("list failed");
+	path = get_pathspec(prefix, argv + 2);
+	buf = read_object_with_reference(sha1, "tree", &size, NULL);
+	if (!buf)
+		die("not a tree object");
+	read_tree_recursive(buf, size, "", 0, 0, path, show_tree);
+
 	return 0;
 }
diff --git a/tree.c b/tree.c
index 8b42a07..043f032 100644
--- a/tree.c
+++ b/tree.c
@@ -9,9 +9,16 @@ const char *tree_type = "tree";
 
 static int read_one_entry(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
 {
-	int len = strlen(pathname);
-	unsigned int size = cache_entry_size(baselen + len);
-	struct cache_entry *ce = xmalloc(size);
+	int len;
+	unsigned int size;
+	struct cache_entry *ce;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	len = strlen(pathname);
+	size = cache_entry_size(baselen + len);
+	ce = xmalloc(size);
 
 	memset(ce, 0, size);
 
@@ -67,9 +74,10 @@ static int match_tree_entry(const char *
 	return 0;
 }
 
-static int read_tree_recursive(void *buffer, unsigned long size,
-			       const char *base, int baselen,
-			       int stage, const char **match)
+int read_tree_recursive(void *buffer, unsigned long size,
+			const char *base, int baselen,
+			int stage, const char **match,
+			read_tree_fn_t fn)
 {
 	while (size) {
 		int len = strlen(buffer)+1;
@@ -86,6 +94,14 @@ static int read_tree_recursive(void *buf
 		if (!match_tree_entry(base, baselen, path, mode, match))
 			continue;
 
+		switch (fn(sha1, base, baselen, path, mode, stage)) {
+		case 0:
+			continue;
+		case READ_TREE_RECURSIVE:
+			break;;
+		default:
+			return -1;
+		}
 		if (S_ISDIR(mode)) {
 			int retval;
 			int pathlen = strlen(path);
@@ -106,22 +122,20 @@ static int read_tree_recursive(void *buf
 			retval = read_tree_recursive(eltbuf, eltsize,
 						     newbase,
 						     baselen + pathlen + 1,
-						     stage, match);
+						     stage, match, fn);
 			free(eltbuf);
 			free(newbase);
 			if (retval)
 				return -1;
 			continue;
 		}
-		if (read_one_entry(sha1, base, baselen, path, mode, stage) < 0)
-			return -1;
 	}
 	return 0;
 }
 
 int read_tree(void *buffer, unsigned long size, int stage, const char **match)
 {
-	return read_tree_recursive(buffer, size, "", 0, stage, match);
+	return read_tree_recursive(buffer, size, "", 0, stage, match, read_one_entry);
 }
 
 struct tree *lookup_tree(const unsigned char *sha1)
diff --git a/tree.h b/tree.h
index 9975e88..768e5e9 100644
--- a/tree.h
+++ b/tree.h
@@ -35,4 +35,13 @@ int parse_tree(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const unsigned char *sha1);
 
+#define READ_TREE_RECURSIVE 1
+typedef int (*read_tree_fn_t)(unsigned char *, const char *, int, const char *, unsigned int, int);
+
+extern int read_tree_recursive(void *buffer, unsigned long size,
+			const char *base, int baselen,
+			int stage, const char **match,
+			read_tree_fn_t fn);
+
+
 #endif /* TREE_H */
