From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree matching multiple paths
Date: Thu, 26 May 2005 10:52:50 -0700
Message-ID: <7vacmhdgct.fsf@assigned-by-dhcp.cox.net>
References: <20050526034756.GA1488@port.evillabs.net>
	<7vsm0aeguo.fsf@assigned-by-dhcp.cox.net>
	<1117111843.11542.11.camel@jmcmullan.timesys>
	<1117120411.11542.16.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 19:56:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbMZK-0006j6-PS
	for gcvg-git@gmane.org; Thu, 26 May 2005 19:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVEZR4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVEZR4h
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 13:56:37 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42963 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261664AbVEZRww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 13:52:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526175251.NWKD550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 13:52:51 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1117120411.11542.16.camel@jmcmullan.timesys> (Jason McMullan's
 message of "Thu, 26 May 2005 11:13:29 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jason, could you double check your MUA setup?  The copy I got, and
the mailing list archive MARC has, both seems to have got line
wrapped.  Here is the beginning of your message cut & pasted from
http://marc.theaimsgroup.com/?l=git&m=111712054707691&w=2

    ...
    Signed-Off-By: Jason McMullan <jason.mcmullan@timesys.com>

    diff --git a/Documentation/git-ls-tree.txt
    b/Documentation/git-ls-tree.txt
    --- a/Documentation/git-ls-tree.txt
    ...

I fixed it up by hand and added a test case, which your test passes
fine.  Again, thanks for doing this.

------------
From: Jason McMullan <jason.mcmullan@timesys.com>

Enhance git-ls-tree to allow optional 'match paths' that
restricts the output of git-ls-tree.  This is useful to retrieve
a single file's SHA1 out of a tree without creating an index.

[JC: I added the test case]

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-ls-tree.txt |    7 +-
ls-tree.c                     |  135 ++++++++++++++++++++++++++++++++++++------
t/t3100-ls-tree-restrict.sh   |  103 ++++++++++++++++++++++++++++++++
3 files changed, 227 insertions(+), 18 deletions(-)
new file (100755): t/t3100-ls-tree-restrict.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -9,7 +9,7 @@ git-ls-tree - Displays a tree object in 
 
 SYNOPSIS
 --------
-'git-ls-tree' [-r] [-z] <tree-ish>
+'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
 
 DESCRIPTION
 -----------
@@ -27,6 +27,11 @@ OPTIONS
 -z::
 	\0 line termination on output
 
+paths::
+	Optionally, restrict the output of git-ls-tree to specific
+	paths. Directories will only list their tree blob ids.
+	Implies -r.
+
 Output Format
 -------------
         <mode>\t	<type>\t	<object>\t	<file>
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -13,20 +13,79 @@ struct path_prefix {
 	const char *name;
 };
 
+#define DEBUG(fmt, ...)	
+
+static int string_path_prefix(char *buff, size_t blen, struct path_prefix *prefix)
+{
+	int len = 0;
+	if (prefix) {
+		if (prefix->prev) {
+			len = string_path_prefix(buff,blen,prefix->prev);
+			buff += len;
+			blen -= len;
+			if (blen > 0) {
+				*buff = '/';
+				len++;
+				buff++;
+				blen--;
+			}
+		}
+		strncpy(buff,prefix->name,blen);
+		return len + strlen(prefix->name);
+	}
+
+	return 0;
+}
+
 static void print_path_prefix(struct path_prefix *prefix)
 {
 	if (prefix) {
-		if (prefix->prev)
+		if (prefix->prev) {
 			print_path_prefix(prefix->prev);
+			putchar('/');
+		}
 		fputs(prefix->name, stdout);
-		putchar('/');
 	}
 }
 
+/*
+ * return:
+ * 	-1 if prefix is *not* a subset of path
+ * 	 0 if prefix == path
+ * 	 1 if prefix is a subset of path
+ */
+static int pathcmp(const char *path, struct path_prefix *prefix)
+{
+	char buff[PATH_MAX];
+	int len,slen;
+
+	if (prefix == NULL)
+		return 1;
+
+	len = string_path_prefix(buff, sizeof buff, prefix);
+	slen = strlen(path);
+
+	if (slen < len)
+		return -1;
+
+	if (strncmp(path,buff,len) == 0) {
+		if (slen == len)
+			return 0;
+		else
+			return 1;
+	}
+
+	return -1;
+}	
+
+/*
+ * match may be NULL, or a *sorted* list of paths
+ */
 static void list_recursive(void *buffer,
 			   const char *type,
 			   unsigned long size,
-			   struct path_prefix *prefix)
+			   struct path_prefix *prefix,
+			   char **match, int matches)
 {
 	struct path_prefix this_prefix;
 	this_prefix.prev = prefix;
@@ -34,54 +93,96 @@ static void list_recursive(void *buffer,
 	if (strcmp(type, "tree"))
 		die("expected a 'tree' node");
 
+	if (matches)
+		recursive = 1;
+
 	while (size) {
 		int namelen = strlen(buffer)+1;
-		void *eltbuf;
+		void *eltbuf = NULL;
 		char elttype[20];
 		unsigned long eltsize;
 		unsigned char *sha1 = buffer + namelen;
 		char *path = strchr(buffer, ' ') + 1;
 		unsigned int mode;
+		const char *matched = NULL;
+		int mtype = -1;
+		int mindex;
 
 		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) != 1)
 			die("corrupt 'tree' file");
 		buffer = sha1 + 20;
 		size -= namelen + 20;
 
-		printf("%06o\t%s\t%s\t", mode,
-		       S_ISDIR(mode) ? "tree" : "blob",
-		       sha1_to_hex(sha1));
-		print_path_prefix(prefix);
-		fputs(path, stdout);
-		putchar(line_termination);
+		this_prefix.name = path;
+		for ( mindex = 0; mindex < matches; mindex++) {
+			mtype = pathcmp(match[mindex],&this_prefix);
+			if (mtype >= 0) {
+				matched = match[mindex];
+				break;
+			}
+		}
+
+		/*
+		 * If we're not matching, or if this is an exact match,
+		 * print out the info
+		 */
+		if (!matches || (matched != NULL && mtype == 0)) {
+			printf("%06o\t%s\t%s\t", mode,
+			       S_ISDIR(mode) ? "tree" : "blob",
+			       sha1_to_hex(sha1));
+			print_path_prefix(&this_prefix);
+			putchar(line_termination);
+		}
 
 		if (! recursive || ! S_ISDIR(mode))
 			continue;
 
+		if (matches && ! matched)
+			continue;
+
 		if (! (eltbuf = read_sha1_file(sha1, elttype, &eltsize)) ) {
 			error("cannot read %s", sha1_to_hex(sha1));
 			continue;
 		}
-		this_prefix.name = path;
-		list_recursive(eltbuf, elttype, eltsize, &this_prefix);
+
+		/* If this is an exact directory match, we may have
+		 * directory files following this path. Match on them.
+		 * Otherwise, we're at a pach subcomponent, and we need
+		 * to try to match again.
+		 */
+		if (mtype == 0)
+			mindex++;
+
+		list_recursive(eltbuf, elttype, eltsize, &this_prefix, &match[mindex], matches-mindex);
 		free(eltbuf);
 	}
 }
 
-static int list(unsigned char *sha1)
+static int qcmp(const void *a, const void *b)
+{
+	return strcmp(*(char **)a, *(char **)b);
+}
+
+static int list(unsigned char *sha1,char **path)
 {
 	void *buffer;
 	unsigned long size;
+	int npaths;
+
+	for (npaths = 0; path[npaths] != NULL; npaths++)
+		;
+
+	qsort(path,npaths,sizeof(char *),qcmp);
 
 	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!buffer)
 		die("unable to read sha1 file");
-	list_recursive(buffer, "tree", size, NULL);
+	list_recursive(buffer, "tree", size, NULL, path, npaths);
 	free(buffer);
 	return 0;
 }
 
-static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key>";
+static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key> [paths...]";
 
 int main(int argc, char **argv)
 {
@@ -101,11 +202,11 @@ int main(int argc, char **argv)
 		argc--; argv++;
 	}
 
-	if (argc != 2)
+	if (argc < 2)
 		usage(ls_tree_usage);
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	if (list(sha1) < 0)
+	if (list(sha1, &argv[2]) < 0)
 		die("list failed");
 	return 0;
 }
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
new file mode 100755
--- /dev/null
+++ b/t/t3100-ls-tree-restrict.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-ls-tree test.
+
+This test runs git-ls-tree with the following in a tree.
+
+    path0       - a file
+    path1	- a symlink
+    path2/foo   - a file in a directory
+    path2/bazbo - a symlink in a directory
+    path2/baz/b - a file in a directory in a directory
+
+The new path restriction code should do the right thing for path2 and
+path2/baz
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'mkdir path2 path2/baz &&
+     echo Hi >path0 &&
+     ln -s path0 path1 &&
+     echo Lo >path2/foo &&
+     ln -s ../path1 path2/bazbo &&
+     echo Mi >path2/baz/b &&
+     find path? \( -type f -o -type l \) -print |
+     xargs git-update-cache --add &&
+     tree=`git-write-tree` &&
+     echo $tree'
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+test_output () {
+    sed -e "s/	$_x40	/	X	/" <current >check
+    diff -u expected check
+}
+
+test_expect_success \
+    'ls-tree plain' \
+    'git-ls-tree $tree >current &&
+     cat >expected <<\EOF &&
+100644	blob	X	path0
+120000	blob	X	path1
+040000	tree	X	path2
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree recursive' \
+    'git-ls-tree -r $tree >current &&
+     cat >expected <<\EOF &&
+100644	blob	X	path0
+120000	blob	X	path1
+040000	tree	X	path2
+040000	tree	X	path2/baz
+100644	blob	X	path2/baz/b
+120000	blob	X	path2/bazbo
+100644	blob	X	path2/foo
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path >current &&
+     cat >expected <<\EOF &&
+EOF
+     test_output'
+
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path1 path0 >current &&
+     cat >expected <<\EOF &&
+100644	blob	X	path0
+120000	blob	X	path1
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path2 >current &&
+     cat >expected <<\EOF &&
+040000	tree	X	path2
+040000	tree	X	path2/baz
+100644	blob	X	path2/baz/b
+120000	blob	X	path2/bazbo
+100644	blob	X	path2/foo
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path2/baz >current &&
+     cat >expected <<\EOF &&
+040000	tree	X	path2/baz
+100644	blob	X	path2/baz/b
+EOF
+     test_output'
+
+test_done

