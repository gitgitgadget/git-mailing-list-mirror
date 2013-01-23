From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 09:12:47 +0100
Message-ID: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 09:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxvSf-0005B7-0e
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 09:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab3AWINL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 03:13:11 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:42850 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab3AWINK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 03:13:10 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so1402418lab.25
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OItOmL+5DJpq3YmLK9JLO9aTLoDho3N1TwU9iJ7a2lE=;
        b=Gfn+fP1m/ray43UDuLCRz6Enzdg9dGdmkQyoDnsSwHEJdvgB0DEtZxfsgaFJqIfOMY
         tw9PGaNY8VWUyadR+HBMJSaEFaes1Ofjl+Kv0vHTEfkwe6Fdg/86Lqdfybk5rZEpKTQz
         3/AtV/M+RWkfzVLaYwHwWddCQLD8cHX9Jz0SkJ6/q9RyvEg1XCUKoZrJhB6HrQ5K9oiV
         OEGjRpyxS/hclEyp1LnFM8DOaPKyi2yP3W5/29BUD+tMEp+fDawtOjxhFq96oNgeAWqF
         5AeB0ZU2edCXVRcCh99HVNiP6Ri5FuEd71FCPiuCk16vVwoDNfbc7SPvK22yi7PbIQgw
         A6zg==
X-Received: by 10.112.84.168 with SMTP id a8mr329390lbz.75.1358928788397;
        Wed, 23 Jan 2013 00:13:08 -0800 (PST)
Received: from slacko.prediktor.no (pat.prediktor.no. [81.166.54.42])
        by mx.google.com with ESMTPS id ox6sm7860099lab.16.2013.01.23.00.13.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 00:13:07 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.296.g725455c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214297>

When working with multiple, unrelated (or loosly related) git repos,
there is often a need to locate all repos with uncommitted work and
perform some action on them (say, commit and push). Before this patch,
such tasks would require manually visiting all repositories, running
`git status` within each one and then decide what to do next.

This mundane task can now be automated by e.g. `git all --dirty status`,
which will find all git repositories below the current directory (even
nested ones), check if they are dirty (as defined by `git diff --quiet &&
git diff --cached --quiet`), and for each dirty repo print the path to the
repo and then execute `git status` within the repo.

The command also honours the option '--clean' which restricts the set of
repos to those which '--dirty' would skip.

Finally, the command to execute within each repo is optional. If none is
given, git-all will just print the path to each repo found.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Changes since v1:
* uses setenv() instead of chdir(), which fixes .gitfile handling
* uses DTYPE() and stat(), which fixes NO_D_TYPE_IN_DIRENT platforms
* uses OPT_SET_INT() instead of OPT_BOOLEAN
* support for --all (complements --clean/--dirty)
* removed from command-list.txt
* added to .gitignore

I've not yet renamed the command. If it should be changed to 'git
for-each-repo', I'm tempted to make a patch which transforms
`git -ad status` into `git for-each-repo -d status`.

 .gitignore                |   1 +
 Documentation/git-all.txt |  42 ++++++++++++++++++
 Makefile                  |   1 +
 builtin.h                 |   1 +
 builtin/all.c             | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 git.c                     |   1 +
 t/t0064-all.sh            |  46 +++++++++++++++++++
 7 files changed, 202 insertions(+)
 create mode 100644 Documentation/git-all.txt
 create mode 100644 builtin/all.c
 create mode 100755 t/t0064-all.sh

diff --git a/.gitignore b/.gitignore
index aa258a6..27118d7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 /git
 /git-add
 /git-add--interactive
+/git-all
 /git-am
 /git-annotate
 /git-apply
diff --git a/Documentation/git-all.txt b/Documentation/git-all.txt
new file mode 100644
index 0000000..baaa57e
--- /dev/null
+++ b/Documentation/git-all.txt
@@ -0,0 +1,42 @@
+git-all(1)
+==========
+
+NAME
+----
+git-all - Execute a git command in multiple repositories
+
+SYNOPSIS
+--------
+[verse]
+'git all' [--all|--clean|--dirty] [command]
+
+DESCRIPTION
+-----------
+The git-all command is used to locate all git repositoris within the
+current directory tree, and optionally execute a git command in each
+of the found repos.
+
+OPTIONS
+-------
+-a::
+--all::
+	Include both clean and dirty repositories (this is the default
+	behaviour of `git-all`).
+
+-c::
+--clean::
+	Only include repositories with a clean worktree.
+
+-d::
+--dirty::
+	Only include repositories with a dirty worktree.
+
+NOTES
+-----
+
+For the purpose of `git-all`, a dirty worktree is defined as a worktree
+with uncommitted changes.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1b30d7b..8bf0583 100644
--- a/Makefile
+++ b/Makefile
@@ -840,6 +840,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/all.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
diff --git a/builtin.h b/builtin.h
index 7e7bbd6..438c265 100644
--- a/builtin.h
+++ b/builtin.h
@@ -41,6 +41,7 @@ void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_all(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
diff --git a/builtin/all.c b/builtin/all.c
new file mode 100644
index 0000000..b170b26
--- /dev/null
+++ b/builtin/all.c
@@ -0,0 +1,110 @@
+/*
+ * "git all" builtin command.
+ *
+ * Copyright (c) 2013 Lars Hjemli <hjemli@gmail.com>
+ */
+#include "cache.h"
+#include "color.h"
+#include "builtin.h"
+#include "run-command.h"
+#include "parse-options.h"
+
+#define ALL 0
+#define DIRTY 1
+#define CLEAN 2
+
+static int match;
+
+static const char * const builtin_all_usage[] = {
+	N_("git all [--all|--clean|--dirty] [cmd]"),
+	NULL
+};
+
+static struct option builtin_all_options[] = {
+	OPT_SET_INT('a', "all", &match, N_("match both clean and dirty repositories"), ALL),
+	OPT_SET_INT('c', "clean", &match, N_("only show clean repositories"), CLEAN),
+	OPT_SET_INT('d', "dirty", &match, N_("only show dirty repositories"), DIRTY),
+	OPT_END(),
+};
+
+static int get_repo_state()
+{
+	const char *diffidx[] = {"diff", "--quiet", "--cached", NULL};
+	const char *diffwd[] = {"diff", "--quiet", NULL};
+
+	if (run_command_v_opt(diffidx, RUN_GIT_CMD) != 0)
+		return DIRTY;
+	if (run_command_v_opt(diffwd, RUN_GIT_CMD) != 0)
+		return DIRTY;
+	return CLEAN;
+}
+
+static void handle_repo(char *path, const char **argv)
+{
+	if (path[0] == '.' && path[1] == '/')
+		path += 2;
+	if (match != ALL && match != get_repo_state())
+		return;
+	if (*argv) {
+		color_fprintf_ln(stdout, GIT_COLOR_YELLOW, "[%s]", path);
+		run_command_v_opt(argv, RUN_GIT_CMD);
+	} else
+		printf("%s\n", path);
+}
+
+static int walk(struct strbuf *path, int argc, const char **argv)
+{
+	DIR *dir;
+	struct dirent *ent;
+	struct stat st;
+	size_t len;
+
+	dir = opendir(path->buf);
+	if (!dir)
+		return errno;
+	strbuf_addstr(path, "/");
+	len = path->len;
+	while ((ent = readdir(dir))) {
+		if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
+			continue;
+		if (!strcmp(ent->d_name, ".git")) {
+			strbuf_addstr(path, ent->d_name);
+			setenv(GIT_DIR_ENVIRONMENT, path->buf, 1);
+			strbuf_setlen(path, len - 1);
+			setenv(GIT_WORK_TREE_ENVIRONMENT, path->buf, 1);
+			handle_repo(path->buf, argv);
+			strbuf_addstr(path, "/");
+			continue;
+		}
+		strbuf_setlen(path, len);
+		strbuf_addstr(path, ent->d_name);
+		switch (DTYPE(ent)) {
+		case DT_UNKNOWN:
+			/* Use stat() instead of lstat(), since we want to
+			 * know if we can follow this path into another
+			 * directory - it's  not important if it's actually
+			 * a symlink which gets us there.
+			 */
+			if (stat(path->buf, &st) || !S_ISDIR(st.st_mode))
+				break;
+			/* fallthrough */
+		case DT_DIR:
+			walk(path, argc, argv);
+			break;
+		}
+		strbuf_setlen(path, len);
+	}
+	closedir(dir);
+	return 0;
+}
+
+int cmd_all(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	argc = parse_options(argc, argv, prefix, builtin_all_options,
+			     builtin_all_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	strbuf_addstr(&path, ".");
+	return walk(&path, argc, argv);
+}
diff --git a/git.c b/git.c
index ed66c66..53fd963 100644
--- a/git.c
+++ b/git.c
@@ -304,6 +304,7 @@ static void handle_internal_command(int argc, const char **argv)
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+		{ "all", cmd_all },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive },
diff --git a/t/t0064-all.sh b/t/t0064-all.sh
new file mode 100755
index 0000000..3738ab2
--- /dev/null
+++ b/t/t0064-all.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Lars Hjemli
+#
+
+test_description='Test the git-all command'
+
+. ./test-lib.sh
+
+test_expect_success "setup" '
+	test_create_repo clean &&
+	(cd clean && test_commit foo) &&
+	git init --separate-git-dir=.cleansub clean/gitfile &&
+	(cd clean/gitfile && test_commit foo && echo bar >>foo.t) &&
+	test_create_repo dirty-wt &&
+	(cd dirty-wt && test_commit foo && rm foo.t) &&
+	test_create_repo dirty-idx &&
+	(cd dirty-idx && test_commit foo && git rm foo.t)
+'
+
+test_expect_success "without flags, all repos are included" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	echo "clean/gitfile" >>expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	git all | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--dirty only includes dirty repos" '
+	echo "clean/gitfile" >expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	git all --dirty | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--clean only includes clean repos" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	git all --clean | sort >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.1.296.g725455c
