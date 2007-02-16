From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add `git diff2`, a GNU diff workalike
Date: Fri, 16 Feb 2007 05:01:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702160500280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 16 05:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHuI8-0000Lh-LA
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 05:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423123AbXBPEBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 23:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423124AbXBPEBW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 23:01:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:53936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423123AbXBPEBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 23:01:21 -0500
Received: (qmail invoked by alias); 16 Feb 2007 04:01:19 -0000
X-Provags-ID: V01U2FsdGVkX19IXRZP+qxI1cwgf9NIPbnXntlleyqdB+QyhlI6eO
	aKYw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39882>


Git does have a wonderful diff engine. For example, colored diffs
really shine, and there are other useful options like --check,
--patch-with-stat, etc. I always dreamt of using this diff engine
also outside of a git repository.

With this commit, you can say

	git diff2 file1 file2

to compare the (possibly untracked) files "file1" and "file2", and

	git diff2 dir1 dir2

to compare the directories "dir1" and "dir2".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore      |    1 +
 Makefile        |    1 +
 builtin-diff2.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h       |    1 +
 diff.c          |    3 +-
 git.c           |    1 +
 6 files changed, 169 insertions(+), 1 deletions(-)
 create mode 100644 builtin-diff2.c

diff --git a/.gitignore b/.gitignore
index 9b5502b..9809a7d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@ git-cvsserver
 git-daemon
 git-describe
 git-diff
+git-diff2
 git-diff-files
 git-diff-index
 git-diff-tree
diff --git a/Makefile b/Makefile
index ea2b4f5..94b1c75 100644
--- a/Makefile
+++ b/Makefile
@@ -284,6 +284,7 @@ BUILTIN_OBJS = \
 	builtin-count-objects.o \
 	builtin-describe.o \
 	builtin-diff.o \
+	builtin-diff2.o \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
 	builtin-diff-tree.o \
diff --git a/builtin-diff2.c b/builtin-diff2.c
new file mode 100644
index 0000000..1de82c1
--- /dev/null
+++ b/builtin-diff2.c
@@ -0,0 +1,163 @@
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "path-list.h"
+
+static const char diff2_usage[] = "git diff2 [diff-opts] file1 file2";
+
+static int read_directory(const char *path, struct path_list *list)
+{
+	DIR *dir;
+	struct dirent *e;
+
+	if (!(dir = opendir(path)))
+		return error("Could not open directory %s", path);
+
+	while ((e = readdir(dir)))
+		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+			path_list_insert(xstrdup(e->d_name), list);
+
+	closedir(dir);
+	return 0;
+}
+
+static int queue_diff(struct diff_options *o,
+		const char *name1, const char *name2)
+{
+	struct stat st;
+	int mode1 = 0, mode2 = 0;
+
+	if (name1) {
+		if (stat(name1, &st))
+			return error("Could not access '%s'", name1);
+		mode1 = st.st_mode;
+	}
+	if (name2) {
+		if (stat(name2, &st))
+			return error("Could not access '%s'", name1);
+		mode2 = st.st_mode;
+	}
+
+	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
+		return error("file/directory conflict: %s, %s", name1, name2);
+
+	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
+		char buffer1[PATH_MAX], buffer2[PATH_MAX];
+		struct path_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
+		int len1 = 0, len2 = 0, i1, i2, ret = 0;
+
+		if (name1 && read_directory(name1, &p1))
+			return -1;
+		if (name2 && read_directory(name2, &p2)) {
+			path_list_clear(&p1, 0);
+			return -1;
+		}
+
+		if (name1) {
+			len1 = strlen(name1);
+			if (len1 > 0 && name1[len1 - 1] == '/')
+				len1--;
+			memcpy(buffer1, name1, len1);
+			buffer1[len1++] = '/';
+		}
+
+		if (name2) {
+			len2 = strlen(name2);
+			if (len2 > 0 && name2[len2 - 1] == '/')
+				len2--;
+			memcpy(buffer2, name2, len2);
+			buffer2[len2++] = '/';
+		}
+
+		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
+			const char *n1, *n2;
+			int comp;
+
+			if (i1 == p1.nr)
+				comp = 1;
+			else if (i2 == p2.nr)
+				comp = -1;
+			else
+				comp = strcmp(p1.items[i1].path,
+					p2.items[i2].path);
+
+			if (comp > 0)
+				n1 = NULL;
+			else {
+				n1 = buffer1;
+				strncpy(buffer1 + len1, p1.items[i1++].path,
+						PATH_MAX - len1);
+			}
+
+			if (comp < 0)
+				n2 = NULL;
+			else {
+				n2 = buffer2;
+				strncpy(buffer2 + len2, p2.items[i2++].path,
+						PATH_MAX - len2);
+			}
+
+			ret = queue_diff(o, n1, n2);
+		}
+		path_list_clear(&p1, 0);
+		path_list_clear(&p2, 0);
+
+		return ret;
+	} else {
+		struct diff_filespec *d1, *d2;
+
+		if (o->reverse_diff) {
+			unsigned tmp;
+			const char *tmp_c;
+			tmp = mode1; mode1 = mode2; mode2 = tmp;
+			tmp_c = name1; name1 = name2; name2 = tmp_c;
+		}
+
+		if (!name1)
+			name1 = "/dev/null";
+		if (!name2)
+			name2 = "/dev/null";
+		d1 = alloc_filespec(name1);
+		d2 = alloc_filespec(name2);
+		fill_filespec(d1, null_sha1, mode1);
+		fill_filespec(d2, null_sha1, mode2);
+
+		diff_queue(&diff_queued_diff, d1, d2);
+		return 0;
+	}
+}
+
+int cmd_diff2(int argc, char **argv, char **envp)
+{
+	struct diff_options options;
+	int i, i2;
+        int nongit = 0;
+
+        setup_git_directory_gently(&nongit);
+	git_config(git_diff_ui_config);
+
+	diff_setup(&options);
+	for (i = 1; i < argc; ) {
+		if (!strcmp("--", argv[i])) {
+			i++;
+			break;
+		}
+		i2 = diff_opt_parse(&options,
+				(const char **)argv + i, argc - i);
+		if (!i2)
+			break;
+		i += i2;
+	}
+	if (diff_setup_done(&options) < 0)
+		die("diff_setup_done failed");
+	if (!options.output_format)
+		options.output_format = DIFF_FORMAT_PATCH;
+
+	if (argc - i != 2)
+		usage(diff2_usage);
+
+	queue_diff(&options, argv[i], argv[i + 1]);
+	diffcore_std(&options);
+	diff_flush(&options);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index f8e1425..72f94ec 100644
--- a/builtin.h
+++ b/builtin.h
@@ -29,6 +29,7 @@ extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
+extern int cmd_diff2(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch__tool(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
diff --git a/diff.c b/diff.c
index c2d9abe..be73621 100644
--- a/diff.c
+++ b/diff.c
@@ -2443,7 +2443,8 @@ static void diff_resolve_rename_copy(void)
 				p->status = DIFF_STATUS_RENAMED;
 		}
 		else if (hashcmp(p->one->sha1, p->two->sha1) ||
-			 p->one->mode != p->two->mode)
+			 p->one->mode != p->two->mode ||
+			 is_null_sha1(p->one->sha1))
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
 			/* This is a "no-change" entry and should not
diff --git a/git.c b/git.c
index be04fb5..5e6b355 100644
--- a/git.c
+++ b/git.c
@@ -249,6 +249,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
+		{ "diff2", cmd_diff2, USE_PAGER },
 		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
-- 
1.5.0.2137.g20bab
