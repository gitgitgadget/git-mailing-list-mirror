From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-ls-files: --exclude mechanism updates.
Date: Sun, 24 Jul 2005 15:50:57 -0700
Message-ID: <7v64uz3jji.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 00:53:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwpLd-0006OQ-Am
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 00:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVGXWxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 18:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVGXWxH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 18:53:07 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23484 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261526AbVGXWvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 18:51:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724225053.OYWK16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Jul 2005 18:50:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun, 24 Jul 2005 15:49:33 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add --exclude-per-directory=<name> option that specifies a file
to contain exclude patterns local to that directory and its
subdirectories.  Update the exclusion logic to be able to say
"include files that match this more specific pattern, even
though later exclude patterns may match them".  Also enhances
that a pattern can contain '/' in which case fnmatch is called
with FNM_PATHNAME flag to match the entire path.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-files.c                         |  123 ++++++++++++++++++++++++++++++------
 t/t3001-ls-files-others-exclude.sh |   55 ++++++++++++++++
 2 files changed, 157 insertions(+), 21 deletions(-)
 create mode 100755 t/t3001-ls-files-others-exclude.sh

d1466fd8701ca79a91b41c6225c115a0a9866d6e
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -25,20 +25,31 @@ static const char *tag_removed = "";
 static const char *tag_other = "";
 static const char *tag_killed = "";
 
+static char *exclude_per_dir = NULL;
 static int nr_excludes;
-static const char **excludes;
 static int excludes_alloc;
+static struct exclude {
+	const char *pattern;
+	const char *base;
+	int baselen;
+} **excludes;
 
-static void add_exclude(const char *string)
+static void add_exclude(const char *string, const char *base, int baselen)
 {
+	struct exclude *x = xmalloc(sizeof (*x));
+
+	x->pattern = string;
+	x->base = base;
+	x->baselen = baselen;
 	if (nr_excludes == excludes_alloc) {
 		excludes_alloc = alloc_nr(excludes_alloc);
 		excludes = realloc(excludes, excludes_alloc*sizeof(char *));
 	}
-	excludes[nr_excludes++] = string;
+	excludes[nr_excludes++] = x;
 }
 
-static void add_excludes_from_file(const char *fname)
+static int add_excludes_from_file_1(const char *fname,
+				    const char *base, int baselen)
 {
 	int fd, i;
 	long size;
@@ -53,7 +64,7 @@ static void add_excludes_from_file(const
 	lseek(fd, 0, SEEK_SET);
 	if (size == 0) {
 		close(fd);
-		return;
+		return 0;
 	}
 	buf = xmalloc(size);
 	if (read(fd, buf, size) != size)
@@ -63,28 +74,89 @@ static void add_excludes_from_file(const
 	entry = buf;
 	for (i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
-			if (entry != buf + i) {
+			if (entry != buf + i && entry[0] != '#') {
 				buf[i] = 0;
-				add_exclude(entry);
+				add_exclude(entry, base, baselen);
 			}
 			entry = buf + i + 1;
 		}
 	}
-	return;
+	return 0;
 
-err:	perror(fname);
-	exit(1);
+ err:
+	if (0 <= fd)
+		close(fd);
+	return -1;
+}
+
+static void add_excludes_from_file(const char *fname)
+{
+	if (add_excludes_from_file_1(fname, "", 0) < 0)
+		die("cannot use %s as an exclude file", fname);
+}
+
+static int push_exclude_per_directory(const char *base, int baselen)
+{
+	char exclude_file[PATH_MAX];
+	int current_nr = nr_excludes;
+
+	if (exclude_per_dir) {
+		memcpy(exclude_file, base, baselen);
+		strcpy(exclude_file + baselen, exclude_per_dir);
+		add_excludes_from_file_1(exclude_file, base, baselen);
+	}
+	return current_nr;
+}
+
+static void pop_exclude_per_directory(int stk)
+{
+	while (stk < nr_excludes)
+		free(excludes[--nr_excludes]);
 }
 
 static int excluded(const char *pathname)
 {
 	int i;
+
 	if (nr_excludes) {
-		const char *basename = strrchr(pathname, '/');
-		basename = (basename) ? basename+1 : pathname;
-		for (i = 0; i < nr_excludes; i++)
-			if (fnmatch(excludes[i], basename, 0) == 0)
-				return 1;
+		int pathlen = strlen(pathname);
+
+		for (i = 0; i < nr_excludes; i++) {
+			struct exclude *x = excludes[i];
+			const char *exclude = x->pattern;
+			int to_exclude = 1;
+
+			if (*exclude == '!') {
+				to_exclude = 0;
+				exclude++;
+			}
+
+			if (!strchr(exclude, '/')) {
+				/* match basename */
+				const char *basename = strrchr(pathname, '/');
+				basename = (basename) ? basename+1 : pathname;
+				if (fnmatch(exclude, basename, 0) == 0)
+					return to_exclude;
+			}
+			else {
+				/* match with FNM_PATHNAME:
+				 * exclude has base (baselen long) inplicitly
+				 * in front of it.
+				 */
+				int baselen = x->baselen;
+				if (*exclude == '/')
+					exclude++;
+
+				if (pathlen < baselen ||
+				    (baselen && pathname[baselen-1] != '/') ||
+				    strncmp(pathname, x->base, baselen))
+				    continue;
+
+				if (fnmatch(exclude, pathname+baselen,
+					    FNM_PATHNAME) == 0)
+					return to_exclude;
+			}
+		}
 	}
 	return 0;
 }
@@ -121,7 +193,7 @@ static void add_name(const char *pathnam
  * doesn't handle them at all yet. Maybe that will change some
  * day.
  *
- * Also, we currently ignore all names starting with a dot.
+ * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
 static void read_directory(const char *path, const char *base, int baselen)
@@ -129,10 +201,13 @@ static void read_directory(const char *p
 	DIR *dir = opendir(path);
 
 	if (dir) {
+		int exclude_stk;
 		struct dirent *de;
 		char fullname[MAXPATHLEN + 1];
 		memcpy(fullname, base, baselen);
 
+		exclude_stk = push_exclude_per_directory(base, baselen);
+
 		while ((de = readdir(dir)) != NULL) {
 			int len;
 
@@ -141,10 +216,10 @@ static void read_directory(const char *p
 			     !strcmp(de->d_name + 1, ".") ||
 			     !strcmp(de->d_name + 1, "git")))
 				continue;
-			if (excluded(de->d_name) != show_ignored)
-				continue;
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
+			if (excluded(fullname) != show_ignored)
+				continue;
 
 			switch (DTYPE(de)) {
 			struct stat st;
@@ -170,6 +245,8 @@ static void read_directory(const char *p
 			add_name(fullname, baselen + len);
 		}
 		closedir(dir);
+
+		pop_exclude_per_directory(exclude_stk);
 	}
 }
 
@@ -287,7 +364,9 @@ static void show_files(void)
 
 static const char *ls_files_usage =
 	"git-ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed])* "
-	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
+	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
+	"[ --exclude-per-directory=<filename> ]";
+;
 
 int main(int argc, char **argv)
 {
@@ -323,13 +402,15 @@ int main(int argc, char **argv)
 			show_stage = 1;
 			show_unmerged = 1;
 		} else if (!strcmp(arg, "-x") && i+1 < argc) {
-			add_exclude(argv[++i]);
+			add_exclude(argv[++i], "", 0);
 		} else if (!strncmp(arg, "--exclude=", 10)) {
-			add_exclude(arg+10);
+			add_exclude(arg+10, "", 0);
 		} else if (!strcmp(arg, "-X") && i+1 < argc) {
 			add_excludes_from_file(argv[++i]);
 		} else if (!strncmp(arg, "--exclude-from=", 15)) {
 			add_excludes_from_file(arg+15);
+		} else if (!strncmp(arg, "--exclude-per-directory=", 24)) {
+			exclude_per_dir = arg + 24;
 		} else
 			usage(ls_files_usage);
 	}
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
new file mode 100755
--- /dev/null
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-ls-files --others --exclude
+
+This test runs git-ls-files --others and tests --exclude patterns.
+'
+
+. ./test-lib.sh
+
+rm -fr one three
+for dir in . one one/two three
+do
+  mkdir -p $dir &&
+  for i in 1 2 3 4 5
+  do
+    >$dir/a.$i
+  done
+done
+
+cat >expect <<EOF
+a.2
+a.4
+a.5
+one/a.3
+one/a.4
+one/a.5
+one/two/a.3
+one/two/a.5
+three/a.2
+three/a.3
+three/a.4
+three/a.5
+EOF
+
+echo '.gitignore
+output
+expect
+.gitignore
+' >.git/ignore
+
+echo '*.1
+/*.3' >.gitignore
+echo '*.2
+two/*.4' >one/.gitignore
+
+test_expect_success \
+    'git-ls-files --others --exclude.' \
+    'git-ls-files --others \
+       --exclude-per-directory=.gitignore \
+       --exclude-from=.git/ignore \
+       >output &&
+     diff -u expect output'
