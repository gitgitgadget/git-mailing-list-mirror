From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 3/3] "git diff": do not ignore index without --no-index
Date: Sat, 24 May 2008 00:26:33 -0700
Message-ID: <7vbq2wmac6.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
 <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
 <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
 <alpine.DEB.1.00.0805232349410.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 24 09:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzoAS-0007RO-VD
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 09:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYEXH1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 03:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYEXH1A
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 03:27:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYEXH06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 03:26:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 949B23F14;
	Sat, 24 May 2008 03:26:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9E5A73F11; Sat, 24 May 2008 03:26:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8F42EC2-2962-11DD-80CD-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82801>

Even if "foo" and/or "bar" does not exist in index, "git diff foo bar"
should not change behaviour drastically from "git diff foo bar baz" or
"git diff foo".  A feature that "sometimes works and is handy" is an
unreliable cute hack.

"git diff foo bar" outside a git repository continues to work as a more
colourful alternative to "diff -u" as before.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * option parsing loop can be trivially factored out between
   builtin_diff_files() and cmd_diff_files(), but I am too tired
   so I'll call it a night.

 Makefile                                           |    1 +
 builtin-diff.c                                     |   55 +++-
 diff-lib.c                                         |  323 --------------------
 diff-no-index.c                                    |  231 ++++++++++++++
 diff.h                                             |    6 +-
 t/t4013-diff-various.sh                            |    1 +
 t/t4013/diff.diff_--name-status_dir2_dir           |    1 -
 .../diff.diff_--no-index_--name-status_dir2_dir    |    3 +
 8 files changed, 283 insertions(+), 338 deletions(-)
 create mode 100644 diff-no-index.c
 create mode 100644 t/t4013/diff.diff_--no-index_--name-status_dir2_dir

diff --git a/Makefile b/Makefile
index 865e2bf..ad09e6c 100644
--- a/Makefile
+++ b/Makefile
@@ -405,6 +405,7 @@ LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
 LIB_OBJS += diff-delta.o
+LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff.o
 LIB_OBJS += dir.o
diff --git a/builtin-diff.c b/builtin-diff.c
index 7c2a841..8b3b51e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -202,6 +202,37 @@ static void refresh_index_quietly(void)
 	rollback_lock_file(lock_file);
 }
 
+static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
+{
+	int result;
+	unsigned int options = 0;
+
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "--base"))
+			revs->max_count = 1;
+		else if (!strcmp(argv[1], "--ours"))
+			revs->max_count = 2;
+		else if (!strcmp(argv[1], "--theirs"))
+			revs->max_count = 3;
+		else if (!strcmp(argv[1], "-q"))
+			options |= DIFF_SILENT_ON_REMOVED;
+		else
+			return error("invalid option: %s", argv[1]);
+		argv++; argc--;
+	}
+
+	if (revs->max_count == -1 &&
+	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
+		revs->combine_merges = revs->dense_combined_merges = 1;
+
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
+	result = run_diff_files(revs, options);
+	return diff_result_code(&revs->diffopt, result);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -230,6 +261,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * N=2, M=0:
 	 *      tree vs tree (diff-tree)
 	 *
+	 * N=0, M=0, P=2:
+	 *      compare two filesystem entities (aka --no-index).
+	 *
 	 * Other cases are errors.
 	 */
 
@@ -240,21 +274,21 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		diff_use_color_default = git_use_color_default;
 
 	init_revisions(&rev, prefix);
+
+	/* If this is a no-index diff, just run it and exit there. */
+	diff_no_index(&rev, argc, argv, nongit, prefix);
+
+	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
-	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
-		argc = 0;
-	else
-		argc = setup_revisions(argc, argv, &rev, NULL);
+	if (nongit)
+		die("Not a git repository");
+	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
 			die("diff_setup_done failed");
 	}
-	if (rev.diffopt.prefix && nongit) {
-		rev.diffopt.prefix = NULL;
-		rev.diffopt.prefix_length = 0;
-	}
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
@@ -265,7 +299,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
 		setup_pager();
 
-	/* Do we have --cached and not have a pending object, then
+	/*
+	 * Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
 	if (!rev.pending.nr) {
@@ -333,7 +368,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (!ents) {
 		switch (blobs) {
 		case 0:
-			result = run_diff_files_cmd(&rev, argc, argv);
+			result = builtin_diff_files(&rev, argc, argv);
 			break;
 		case 1:
 			if (paths != 1)
diff --git a/diff-lib.c b/diff-lib.c
index fe2ccec..b17722d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -8,7 +8,6 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "cache-tree.h"
-#include "path-list.h"
 #include "unpack-trees.h"
 #include "refs.h"
 
@@ -16,328 +15,6 @@
  * diff-files
  */
 
-static int read_directory(const char *path, struct path_list *list)
-{
-	DIR *dir;
-	struct dirent *e;
-
-	if (!(dir = opendir(path)))
-		return error("Could not open directory %s", path);
-
-	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			path_list_insert(e->d_name, list);
-
-	closedir(dir);
-	return 0;
-}
-
-static int get_mode(const char *path, int *mode)
-{
-	struct stat st;
-
-	if (!path || !strcmp(path, "/dev/null"))
-		*mode = 0;
-	else if (!strcmp(path, "-"))
-		*mode = create_ce_mode(0666);
-	else if (stat(path, &st))
-		return error("Could not access '%s'", path);
-	else
-		*mode = st.st_mode;
-	return 0;
-}
-
-static int queue_diff(struct diff_options *o,
-		const char *name1, const char *name2)
-{
-	int mode1 = 0, mode2 = 0;
-
-	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
-		return -1;
-
-	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
-		return error("file/directory conflict: %s, %s", name1, name2);
-
-	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
-		char buffer1[PATH_MAX], buffer2[PATH_MAX];
-		struct path_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
-		int len1 = 0, len2 = 0, i1, i2, ret = 0;
-
-		if (name1 && read_directory(name1, &p1))
-			return -1;
-		if (name2 && read_directory(name2, &p2)) {
-			path_list_clear(&p1, 0);
-			return -1;
-		}
-
-		if (name1) {
-			len1 = strlen(name1);
-			if (len1 > 0 && name1[len1 - 1] == '/')
-				len1--;
-			memcpy(buffer1, name1, len1);
-			buffer1[len1++] = '/';
-		}
-
-		if (name2) {
-			len2 = strlen(name2);
-			if (len2 > 0 && name2[len2 - 1] == '/')
-				len2--;
-			memcpy(buffer2, name2, len2);
-			buffer2[len2++] = '/';
-		}
-
-		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
-			const char *n1, *n2;
-			int comp;
-
-			if (i1 == p1.nr)
-				comp = 1;
-			else if (i2 == p2.nr)
-				comp = -1;
-			else
-				comp = strcmp(p1.items[i1].path,
-					p2.items[i2].path);
-
-			if (comp > 0)
-				n1 = NULL;
-			else {
-				n1 = buffer1;
-				strncpy(buffer1 + len1, p1.items[i1++].path,
-						PATH_MAX - len1);
-			}
-
-			if (comp < 0)
-				n2 = NULL;
-			else {
-				n2 = buffer2;
-				strncpy(buffer2 + len2, p2.items[i2++].path,
-						PATH_MAX - len2);
-			}
-
-			ret = queue_diff(o, n1, n2);
-		}
-		path_list_clear(&p1, 0);
-		path_list_clear(&p2, 0);
-
-		return ret;
-	} else {
-		struct diff_filespec *d1, *d2;
-
-		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
-			unsigned tmp;
-			const char *tmp_c;
-			tmp = mode1; mode1 = mode2; mode2 = tmp;
-			tmp_c = name1; name1 = name2; name2 = tmp_c;
-		}
-
-		if (!name1)
-			name1 = "/dev/null";
-		if (!name2)
-			name2 = "/dev/null";
-		d1 = alloc_filespec(name1);
-		d2 = alloc_filespec(name2);
-		fill_filespec(d1, null_sha1, mode1);
-		fill_filespec(d2, null_sha1, mode2);
-
-		diff_queue(&diff_queued_diff, d1, d2);
-		return 0;
-	}
-}
-
-/*
- * Does the path name a blob in the working tree, or a directory
- * in the working tree?
- */
-static int is_in_index(const char *path)
-{
-	int len, pos;
-	struct cache_entry *ce;
-
-	len = strlen(path);
-	while (path[len-1] == '/')
-		len--;
-	if (!len)
-		return 1; /* "." */
-	pos = cache_name_pos(path, len);
-	if (0 <= pos)
-		return 1;
-	pos = -1 - pos;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
-		if (ce_namelen(ce) <= len ||
-		    strncmp(ce->name, path, len) ||
-		    (ce->name[len] > '/'))
-			break; /* path cannot be a prefix */
-		if (ce->name[len] == '/')
-			return 1;
-	}
-	return 0;
-}
-
-static int handle_diff_files_args(struct rev_info *revs,
-				  int argc, const char **argv,
-				  unsigned int *options)
-{
-	*options = 0;
-
-	/* revs->max_count == -2 means --no-index */
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "--base"))
-			revs->max_count = 1;
-		else if (!strcmp(argv[1], "--ours"))
-			revs->max_count = 2;
-		else if (!strcmp(argv[1], "--theirs"))
-			revs->max_count = 3;
-		else if (!strcmp(argv[1], "-n") ||
-				!strcmp(argv[1], "--no-index")) {
-			revs->max_count = -2;
-			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
-			DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
-		}
-		else if (!strcmp(argv[1], "-q"))
-			*options |= DIFF_SILENT_ON_REMOVED;
-		else
-			return error("invalid option: %s", argv[1]);
-		argv++; argc--;
-	}
-
-	if (revs->max_count == -1 && revs->diffopt.nr_paths == 2) {
-		/*
-		 * If two files are specified, and at least one is untracked,
-		 * default to no-index.
-		 */
-		read_cache();
-		if (!is_in_index(revs->diffopt.paths[0]) ||
-					!is_in_index(revs->diffopt.paths[1])) {
-			revs->max_count = -2;
-			DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
-		}
-	}
-
-	/*
-	 * Make sure there are NO revision (i.e. pending object) parameter,
-	 * rev.max_count is reasonable (0 <= n <= 3),
-	 * there is no other revision filtering parameters.
-	 */
-	if (revs->pending.nr || revs->max_count > 3 ||
-	    revs->min_age != -1 || revs->max_age != -1)
-		return error("no revision allowed with diff-files");
-
-	if (revs->max_count == -1 &&
-	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
-		revs->combine_merges = revs->dense_combined_merges = 1;
-
-	return 0;
-}
-
-static int is_outside_repo(const char *path, int nongit, const char *prefix)
-{
-	int i;
-	if (nongit || !strcmp(path, "-") || is_absolute_path(path))
-		return 1;
-	if (prefixcmp(path, "../"))
-		return 0;
-	if (!prefix)
-		return 1;
-	for (i = strlen(prefix); !prefixcmp(path, "../"); ) {
-		while (i > 0 && prefix[i - 1] != '/')
-			i--;
-		if (--i < 0)
-			return 1;
-		path += 3;
-	}
-	return 0;
-}
-
-int setup_diff_no_index(struct rev_info *revs,
-		int argc, const char ** argv, int nongit, const char *prefix)
-{
-	int i;
-	for (i = 1; i < argc; i++)
-		if (argv[i][0] != '-' || argv[i][1] == '\0')
-			break;
-		else if (!strcmp(argv[i], "--")) {
-			i++;
-			break;
-		} else if (i < argc - 3 && !strcmp(argv[i], "--no-index")) {
-			i = argc - 3;
-			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
-			break;
-		}
-	if (nongit && argc != i + 2)
-		die("git diff [--no-index] takes two paths");
-
-	if (argc != i + 2 || (!is_outside_repo(argv[i + 1], nongit, prefix) &&
-				!is_outside_repo(argv[i], nongit, prefix)))
-		return -1;
-
-	diff_setup(&revs->diffopt);
-	for (i = 1; i < argc - 2; )
-		if (!strcmp(argv[i], "--no-index"))
-			i++;
-		else {
-			int j = diff_opt_parse(&revs->diffopt,
-					argv + i, argc - i);
-			if (!j)
-				die("invalid diff option/value: %s", argv[i]);
-			i += j;
-		}
-
-	if (prefix) {
-		int len = strlen(prefix);
-
-		revs->diffopt.paths = xcalloc(2, sizeof(char*));
-		for (i = 0; i < 2; i++) {
-			const char *p = argv[argc - 2 + i];
-			/*
-			 * stdin should be spelled as '-'; if you have
-			 * path that is '-', spell it as ./-.
-			 */
-			p = (strcmp(p, "-")
-			     ? xstrdup(prefix_filename(prefix, len, p))
-			     : p);
-			revs->diffopt.paths[i] = p;
-		}
-	}
-	else
-		revs->diffopt.paths = argv + argc - 2;
-	revs->diffopt.nr_paths = 2;
-	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
-	revs->max_count = -2;
-	if (diff_setup_done(&revs->diffopt) < 0)
-		die("diff_setup_done failed");
-	return 0;
-}
-
-int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
-{
-	unsigned int options;
-
-	if (handle_diff_files_args(revs, argc, argv, &options))
-		return -1;
-
-	if (DIFF_OPT_TST(&revs->diffopt, NO_INDEX)) {
-		if (revs->diffopt.nr_paths != 2)
-			return error("need two files/directories with --no-index");
-		if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
-				revs->diffopt.paths[1]))
-			return -1;
-		diffcore_std(&revs->diffopt);
-		diff_flush(&revs->diffopt);
-		/*
-		 * The return code for --no-index imitates diff(1):
-		 * 0 = no changes, 1 = changes, else error
-		 */
-		return revs->diffopt.found_changes;
-	}
-
-	if (read_cache() < 0) {
-		perror("read_cache");
-		return -1;
-	}
-	return run_diff_files(revs, options);
-}
-
 /*
  * Has the work tree entity been removed?
  *
diff --git a/diff-no-index.c b/diff-no-index.c
new file mode 100644
index 0000000..1b57fee
--- /dev/null
+++ b/diff-no-index.c
@@ -0,0 +1,231 @@
+/*
+ * "diff --no-index" support
+ * Copyright (c) 2007 by Johannes Schindelin
+ * Copyright (c) 2008 by Junio C Hamano
+ */
+
+#include "cache.h"
+#include "color.h"
+#include "commit.h"
+#include "blob.h"
+#include "tag.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "log-tree.h"
+#include "builtin.h"
+#include "path-list.h"
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
+			path_list_insert(e->d_name, list);
+
+	closedir(dir);
+	return 0;
+}
+
+static int get_mode(const char *path, int *mode)
+{
+	struct stat st;
+
+	if (!path || !strcmp(path, "/dev/null"))
+		*mode = 0;
+	else if (!strcmp(path, "-"))
+		*mode = create_ce_mode(0666);
+	else if (stat(path, &st))
+		return error("Could not access '%s'", path);
+	else
+		*mode = st.st_mode;
+	return 0;
+}
+
+static int queue_diff(struct diff_options *o,
+		const char *name1, const char *name2)
+{
+	int mode1 = 0, mode2 = 0;
+
+	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
+		return -1;
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
+		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
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
+void diff_no_index(struct rev_info *revs,
+		   int argc, const char **argv,
+		   int nongit, const char *prefix)
+{
+	int i;
+	int no_index = 0;
+	unsigned options = 0;
+
+	/* Were we asked to do --no-index explicitly? */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--"))
+			return;
+		if (!strcmp(argv[i], "--no-index"))
+			no_index = 1;
+		if (argv[i][0] != '-')
+			break;
+	}
+
+	/*
+	 * No explicit --no-index, but "git diff --opts A B" outside
+	 * a git repository is a cute hack to support.
+	 */
+	if (!no_index && !nongit)
+		return;
+
+	if (argc != i + 2)
+		die("git diff %s takes two paths",
+		    no_index ? "--no-index" : "[--no-index]");
+
+	diff_setup(&revs->diffopt);
+	if (!revs->diffopt.output_format)
+		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	for (i = 1; i < argc - 2; ) {
+		int j;
+		if (!strcmp(argv[i], "--no-index"))
+			i++;
+		else if (!strcmp(argv[1], "-q"))
+			options |= DIFF_SILENT_ON_REMOVED;
+		else {
+			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i);
+			if (!j)
+				die("invalid diff option/value: %s", argv[i]);
+			i += j;
+		}
+	}
+
+	if (prefix) {
+		int len = strlen(prefix);
+
+		revs->diffopt.paths = xcalloc(2, sizeof(char*));
+		for (i = 0; i < 2; i++) {
+			const char *p = argv[argc - 2 + i];
+			/*
+			 * stdin should be spelled as '-'; if you have
+			 * path that is '-', spell it as ./-.
+			 */
+			p = (strcmp(p, "-")
+			     ? xstrdup(prefix_filename(prefix, len, p))
+			     : p);
+			revs->diffopt.paths[i] = p;
+		}
+	}
+	else
+		revs->diffopt.paths = argv + argc - 2;
+	revs->diffopt.nr_paths = 2;
+
+	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
+	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
+
+	revs->max_count = -2;
+	if (diff_setup_done(&revs->diffopt) < 0)
+		die("diff_setup_done failed");
+
+	if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
+		       revs->diffopt.paths[1]))
+		exit(1);
+	diffcore_std(&revs->diffopt);
+	diff_flush(&revs->diffopt);
+
+	/*
+	 * The return code for --no-index imitates diff(1):
+	 * 0 = no changes, 1 = changes, else error
+	 */
+	exit(revs->diffopt.found_changes);
+}
diff --git a/diff.h b/diff.h
index 3a02d38..e019730 100644
--- a/diff.h
+++ b/diff.h
@@ -250,10 +250,6 @@ extern const char *diff_unique_abbrev(const unsigned char *, int);
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
-extern int setup_diff_no_index(struct rev_info *revs,
-		int argc, const char ** argv, int nongit, const char *prefix);
-extern int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv);
-
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
@@ -261,4 +257,6 @@ extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
 
 extern int diff_result_code(struct diff_options *, int);
 
+extern void diff_no_index(struct rev_info *, int, const char **, int, const char *);
+
 #endif /* DIFF_H */
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 4c038cc..9337b81 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -257,6 +257,7 @@ diff --patch-with-raw initial..side
 diff --patch-with-stat -r initial..side
 diff --patch-with-raw -r initial..side
 diff --name-status dir2 dir
+diff --no-index --name-status dir2 dir
 EOF
 
 test_done
diff --git a/t/t4013/diff.diff_--name-status_dir2_dir b/t/t4013/diff.diff_--name-status_dir2_dir
index ef7fdb7..d0d96aa 100644
--- a/t/t4013/diff.diff_--name-status_dir2_dir
+++ b/t/t4013/diff.diff_--name-status_dir2_dir
@@ -1,3 +1,2 @@
 $ git diff --name-status dir2 dir
-A	dir/sub
 $
diff --git a/t/t4013/diff.diff_--no-index_--name-status_dir2_dir b/t/t4013/diff.diff_--no-index_--name-status_dir2_dir
new file mode 100644
index 0000000..6a47584
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_--name-status_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --name-status dir2 dir
+A	dir/sub
+$
-- 
1.5.5.1.540.g57780
