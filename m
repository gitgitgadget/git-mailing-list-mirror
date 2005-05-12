From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-ls-files -k option.
Date: Thu, 12 May 2005 02:23:57 -0700
Message-ID: <7vk6m4iyqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 11:18:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW9pX-0000ym-LH
	for gcvg-git@gmane.org; Thu, 12 May 2005 11:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVELJZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVELJZl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 05:25:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25757 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261364AbVELJYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 05:24:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512092358.QNUQ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 05:23:58 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pasky, you may remember the discussion on how "chilly" the
proposed behaviour of checkout-cache -f obliterating conflicting
paths was, and what I think is needed for the Porcelain layer if
it chooses to save such files before checking things out.

Here is a patch to add -k (killed) option to git-ls-files to
find out what files are need to be killed to make checkout-cache
to succeed.  The Porcelain can run it immediately before
checkout-cache, save the files reported, and the run
checkout-cache -f.  If your checkout-cache does not have that
"chilly" enhancement, in addition to saving the files above, it
also has to move them out of the way.

Note: To be applied after ls-files --other symlink fix.

------------

When checkout-cache attempts to check out a non-directory where
a directory exists on the work tree, or to check out a file
under directory D when path D is a non-directory on the work
tree, the attempt fails.  Before running checkout-cache, the
user can run git-ls-files with the -k (killed) option to get a
list of such paths.

This also includes the test for this functionality and
documentation of the new option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-ls-files.txt |   10 +++-
ls-files.c                     |   95 +++++++++++++++++++++++++++++++++--------
t/t0500-ls-files.sh            |   55 +++++++++++++++++++++++
3 files changed, 140 insertions(+), 20 deletions(-)

--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,8 +10,8 @@ git-ls-files - Information about files i
 SYNOPSIS
 --------
 'git-ls-files' [-z] [-t]
-		(--[cached|deleted|others|ignored|stage|unmerged])\*
-		(-[c|d|o|i|s|u])\*
+		(--[cached|deleted|others|ignored|stage|unmerged|killed])\*
+		(-[c|d|o|i|s|u|k])\*
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 
@@ -45,6 +45,11 @@ OPTIONS
 -u|--unmerged::
 	Show unmerged files in the output (forces --stage)
 
+-k|--killed::
+	Show files on the filesystem that need to be removed due
+	to file/directory conflicts for checkout-cache to
+	succeed.
+
 -z::
 	\0 line termination on output
 
@@ -65,6 +70,7 @@ OPTIONS
 	H	cached
 	M	unmerged
 	R	removed/deleted
+	K	to be killed
 	?	other
 
 Output
--- a/ls-files.c
+++ b/ls-files.c
@@ -16,12 +16,14 @@ static int show_others = 0;
 static int show_ignored = 0;
 static int show_stage = 0;
 static int show_unmerged = 0;
+static int show_killed = 0;
 static int line_terminator = '\n';
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
 static const char *tag_removed = "";
 static const char *tag_other = "";
+static const char *tag_killed = "";
 
 static int nr_excludes;
 static const char **excludes;
@@ -87,24 +89,36 @@ static int excluded(const char *pathname
 	return 0;
 }
 
-static const char **dir;
+struct nond_on_fs {
+	int len;
+#define IN_CACHE 1
+#define REPORTED_KILL 2
+	char flag;
+	char name[0];
+};
+
+static struct nond_on_fs **dir;
 static int nr_dir;
 static int dir_alloc;
 
 static void add_name(const char *pathname, int len)
 {
-	char *name;
+	struct nond_on_fs *ent;
+	int pos;
 
-	if (cache_name_pos(pathname, len) >= 0)
+	pos = cache_name_pos(pathname, len);
+	if (!show_killed && pos >= 0)
 		return;
 
 	if (nr_dir == dir_alloc) {
 		dir_alloc = alloc_nr(dir_alloc);
-		dir = xrealloc(dir, dir_alloc*sizeof(char *));
+		dir = xrealloc(dir, dir_alloc*sizeof(ent));
 	}
-	name = xmalloc(len + 1);
-	memcpy(name, pathname, len + 1);
-	dir[nr_dir++] = name;
+	ent = xmalloc(sizeof(*ent) + len + 1);
+	ent->flag = (0 <= pos) ? IN_CACHE : 0;
+	ent->len = len;
+	memcpy(ent->name, pathname, len);
+	dir[nr_dir++] = ent;
 }
 
 /*
@@ -164,11 +178,46 @@ static void read_directory(const char *p
 
 static int cmp_name(const void *p1, const void *p2)
 {
-	const char *n1 = *(const char **)p1;
-	const char *n2 = *(const char **)p2;
-	int l1 = strlen(n1), l2 = strlen(n2);
+	const struct nond_on_fs *e1 = *(const struct nond_on_fs **)p1;
+	const struct nond_on_fs *e2 = *(const struct nond_on_fs **)p2;
+
+	return cache_name_compare(e1->name, e1->len,
+				  e2->name, e2->len);
+}
+
+static void show_killed_files()
+{
+	int i, j;
 
-	return cache_name_compare(n1, l1, n2, l2);
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce))
+			continue; /* these won't be checked out */
+		/* Find things that are being killed; that is,
+		 * the ones are prefix of ce->name, or suffix of it.
+		 * The ones that are exactly the same as ce->name
+		 * are fine, because they are what are going to be
+		 * checked out.
+		 */
+		for (j = 0; j < nr_dir; j++) {
+			int len;
+			int l;
+			if (dir[j]->flag & REPORTED_KILL)
+				continue;
+			len = ce_namelen(ce);
+			l = (len < dir[j]->len) ? len : dir[j]->len;
+			if (!strncmp(ce->name, dir[j]->name, l) &&
+			    ( ((len < dir[j]->len) &&
+			       (dir[j]->name[l] == '/')) ||
+			      ((dir[j]->len < len) &&
+			       (ce->name[l] == '/')) ) ) {
+				printf("%s%.*s%c", tag_killed,
+				       dir[i]->len, dir[i]->name,
+				       line_terminator);
+				dir[j]->flag |= REPORTED_KILL;
+			}
+		}
+	}
 }
 
 static void show_files(void)
@@ -176,11 +225,18 @@ static void show_files(void)
 	int i;
 
 	/* For cached/deleted files we don't need to even do the readdir */
-	if (show_others) {
+	if (show_others || show_killed) {
 		read_directory(".", "", 0);
-		qsort(dir, nr_dir, sizeof(char *), cmp_name);
-		for (i = 0; i < nr_dir; i++)
-			printf("%s%s%c", tag_other, dir[i], line_terminator);
+		qsort(dir, nr_dir, sizeof(struct nond_on_fs *), cmp_name);
+		if (show_others)
+			for (i = 0; i < nr_dir; i++)
+				if (!(dir[i]->flag & IN_CACHE))
+					printf("%s%.*s%c", tag_other,
+					       dir[i]->len,
+					       dir[i]->name,
+					       line_terminator);
+		if (show_killed)
+			show_killed_files();
 	}
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
@@ -219,8 +275,8 @@ static void show_files(void)
 }
 
 static const char *ls_files_usage =
-	"ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged])* "
-	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
+"ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed])* "
+"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
 
 int main(int argc, char **argv)
 {
@@ -236,6 +292,7 @@ int main(int argc, char **argv)
 			tag_unmerged = "M ";
 			tag_removed = "R ";
 			tag_other = "? ";
+			tag_killed = "K ";
 		} else if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
 			show_cached = 1;
 		} else if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
@@ -246,6 +303,8 @@ int main(int argc, char **argv)
 			show_ignored = 1;
 		} else if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
 			show_stage = 1;
+		} else if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
+			show_killed = 1;
 		} else if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.
@@ -271,7 +330,7 @@ int main(int argc, char **argv)
 	}
 
 	/* With no flags, we default to showing the cached files */
-	if (!(show_stage | show_deleted | show_others | show_unmerged))
+	if (!(show_stage | show_deleted | show_others | show_unmerged | show_killed))
 		show_cached = 1;
 
 	read_cache();
Created: t/t0500-ls-files.sh (mode:100755)
--- /dev/null
+++ b/t/t0500-ls-files.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./test-lib.sh
+test_description "$@" 'git-ls-files -k flag test.
+
+This test prepares the following in the cache:
+
+    path0       - a file
+    path1       - a symlink
+    path2/file2 - a file in a directory
+    path3/file3 - a file in a directory
+
+and the following on the filesystem:
+
+    path0/file0 - a file in a directory
+    path1/file1 - a file in a directory
+    path2       - a file
+    path3       - a symlink
+    path4	- a file
+    path5	- a symlink
+    path6/file6 - a file in a directory
+
+git-ls-files -k should report that existing filesystem
+objects except path4, path5 and path6/file6 to be killed.
+'
+
+date >path0
+ln -s xyzzy path1
+mkdir path2 path3
+date >path2/file2
+date >path3/file3
+git-update-cache --add -- path0 path1 path?/file?
+
+rm -fr path?
+date >path2
+ln -s frotz path3
+ln -s nitfol path5
+mkdir path0 path1 path6
+date >path0/file0
+date >path1/file1
+date >path6/file6
+
+git-ls-files -k >.output
+cat >.expected <<EOF
+path0/file0
+path1/file1
+path2
+path3
+EOF
+
+test_expect_success 'diff .output .expected'
+test_done

