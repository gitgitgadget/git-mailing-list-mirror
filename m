From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v3 1/2] for-each-repo: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 20:59:39 +0100
Message-ID: <1358971180-10652-2-git-send-email-hjemli@gmail.com>
References: <1358971180-10652-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 21:00:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6Uf-0005fn-4f
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab3AWUAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:00:00 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:39941 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3AWT76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 14:59:58 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so1152687lab.16
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=S6SW7ncfZMNbXXTEOYYRL3496B4Klbyj0hinRYWQTzU=;
        b=biEbP3cNVa3hwLwKow2but2cYOonMZAUXdnA50V/q3EAzPhwQ+c7AbgPMg3OzCFWvu
         tZuRcR6ZZu4jESPbu37YXZF4XkpdfifrZbw2aXEzXzChFNR41R+JNhwZZzGecTvJBqMj
         3bITNxnT9r78szgF9+5m93tJj83wMEo1tCaqJJNjJ35H2jmdIGWna3IsR+3NtKyIKV6F
         /VnCad+HCcQyRhMd/nRVorRb6XxZp8SZ8fkfHnesjZAl0KnZV2wyZQiODEy/ncPxp7XD
         Rd9oxEDwDOSEF6bmyZ26P+PjGw5S3ptbpIJW/g7w6xpttI3zXw0LMh+/NS+DBSNio20o
         jaYw==
X-Received: by 10.112.32.33 with SMTP id f1mr1216354lbi.71.1358971196397;
        Wed, 23 Jan 2013 11:59:56 -0800 (PST)
Received: from slacko.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id hc20sm8804885lab.11.2013.01.23.11.59.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 11:59:55 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.350.g3346805
In-Reply-To: <1358971180-10652-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214352>

When working with multiple, unrelated (or loosly related) git repos,
there is often a need to locate all repos with uncommitted work and
perform some action on them (say, commit and push). Before this patch,
such tasks would require manually visiting all repositories, running
`git status` within each one and then decide what to do next.

This mundane task can now be automated by e.g. `git for-each-repo --dirty
status`, which will find all git repositories below the current directory
(even nested ones), check if they are dirty (as defined by `git diff --quiet
&& git diff --cached --quiet`), and for each dirty repo print the path to
the repo and then execute `git status` within the repo.

The command also honours the option '--clean' which restricts the set of
repos to those which '--dirty' would skip.

Finally, the command to execute within each repo is optional. If none is
given, git-for-each-repo will just print the path to each repo found.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 .gitignore                          |   1 +
 Documentation/git-for-each-repo.txt |  62 +++++++++++++++++++
 Makefile                            |   1 +
 builtin.h                           |   1 +
 builtin/for-each-repo.c             | 119 ++++++++++++++++++++++++++++++++++++
 git.c                               |   1 +
 t/t6400-for-each-repo.sh            |  48 +++++++++++++++
 7 files changed, 233 insertions(+)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100755 t/t6400-for-each-repo.sh

diff --git a/.gitignore b/.gitignore
index 63d4904..5036b84 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@
 /git-filter-branch
 /git-fmt-merge-msg
 /git-for-each-ref
+/git-for-each-repo
 /git-format-patch
 /git-fsck
 /git-fsck-objects
diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
new file mode 100644
index 0000000..be49e96
--- /dev/null
+++ b/Documentation/git-for-each-repo.txt
@@ -0,0 +1,62 @@
+git-for-each-repo(1)
+====================
+
+NAME
+----
+git-for-each-repo - Execute a git command in multiple repositories
+
+SYNOPSIS
+--------
+[verse]
+'git for-each-repo' [--all|--clean|--dirty] [command]
+
+DESCRIPTION
+-----------
+The git-for-each-repo command is used to locate all git repositoris
+within the current directory tree, and optionally execute a git command
+in each of the found repos.
+
+OPTIONS
+-------
+-a::
+--all::
+	Include both clean and dirty repositories (this is the default
+	behaviour of `git-for-each-repo`).
+
+-c::
+--clean::
+	Only include repositories with a clean worktree.
+
+-d::
+--dirty::
+	Only include repositories with a dirty worktree.
+
+EXAMPLES
+--------
+
+Various ways to exploit this command::
++
+------------
+$ git for-each-repo            <1>
+$ git for-each-repo fetch      <2>
+$ git for-each-repo -d gui     <3>
+$ git for-each-repo -c push    <4>
+------------
++
+<1> Print the path to all repos found below the current directory.
+
+<2> Fetch updates from default remote in all repos.
+
+<3> Start linkgit:git-gui[1] in each repo containing uncommitted changes.
+
+<4> Push the current branch in each repo with no uncommited changes.
+
+NOTES
+-----
+
+For the purpose of `git-for-each-repo`, a dirty worktree is defined as a
+worktree with uncommitted changes.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index a786d4c..8c42c17 100644
--- a/Makefile
+++ b/Makefile
@@ -870,6 +870,7 @@ BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
 BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
+BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index 7e7bbd6..02fc712 100644
--- a/builtin.h
+++ b/builtin.h
@@ -73,6 +73,7 @@ extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
+extern int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
new file mode 100644
index 0000000..9bdeb4a
--- /dev/null
+++ b/builtin/for-each-repo.c
@@ -0,0 +1,119 @@
+/*
+ * "git for-each-repo" builtin command.
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
+static const char * const builtin_foreachrepo_usage[] = {
+	N_("git for-each-repo [--all|--clean|--dirty] [cmd]"),
+	NULL
+};
+
+static struct option builtin_foreachrepo_options[] = {
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
+	const char *gitdir;
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
+			gitdir = resolve_gitdir(path->buf);
+			if (!gitdir) {
+				strbuf_setlen(path, len - 1);
+				strbuf_addstr(path, "/");
+				continue;
+			}
+			setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
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
+		case DT_LNK:
+			/* Use stat() to figure out if this path leads
+			 * to a directory - it's  not important if it's
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
+int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_foreachrepo_options,
+			     builtin_foreachrepo_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	strbuf_addstr(&path, ".");
+	return walk(&path, argc, argv);
+}
diff --git a/git.c b/git.c
index ed66c66..6b53169 100644
--- a/git.c
+++ b/git.c
@@ -337,6 +337,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
+		{ "for-each-repo", cmd_for_each_repo },
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
 		{ "fsck", cmd_fsck, RUN_SETUP },
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
diff --git a/t/t6400-for-each-repo.sh b/t/t6400-for-each-repo.sh
new file mode 100755
index 0000000..4797629
--- /dev/null
+++ b/t/t6400-for-each-repo.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Lars Hjemli
+#
+
+test_description='Test the git-for-each-repo command'
+
+. ./test-lib.sh
+
+test_expect_success "setup" '
+	test_create_repo clean &&
+	(cd clean && test_commit foo) &&
+	git init --separate-git-dir=.cleansub clean/gitfile &&
+	(cd clean/gitfile && test_commit foo && echo bar >>foo.t) &&
+	test_create_repo dirty-wt &&
+	(cd dirty-wt && mv .git .linkedgit && ln -s .linkedgit .git &&
+	  test_commit foo && rm foo.t) &&
+	test_create_repo dirty-idx &&
+	(cd dirty-idx && test_commit foo && git rm foo.t) &&
+	mkdir fakedir && mkdir fakedir/.git
+'
+
+test_expect_success "without flags, all repos are included" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	echo "clean/gitfile" >>expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	git for-each-repo | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--dirty only includes dirty repos" '
+	echo "clean/gitfile" >expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	git for-each-repo --dirty | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--clean only includes clean repos" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	git for-each-repo --clean | sort >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.1.350.g3346805
