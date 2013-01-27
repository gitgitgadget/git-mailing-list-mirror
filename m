From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v4 1/2] for-each-repo: new command used for multi-repo operations
Date: Sun, 27 Jan 2013 13:46:16 +0100
Message-ID: <1359290777-5483-2-git-send-email-hjemli@gmail.com>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 13:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzRdW-0004In-TG
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 13:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab3A0Mqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 07:46:36 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:46729 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab3A0Mqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 07:46:35 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so2806911lbj.31
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 04:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DnyDjddWvKqPwXjZrgcxh0Plb/SAMAjPqt51otV8kwk=;
        b=bjhG4KNjG7Xf7VYvGMdATnNjrfPuGPonlucH1vnMLCKXGJkFwF1jsAVnyKbiii79Aw
         Mb+L7gRRGwV5MsnimEfVBo8CqK1Yq8Qy+dpMpFZWqCtE7X5BK2R0HhXWgo5iwqqcs7cP
         xmZJE6iGBYaVHrM5E6pnhDk3ZPj37xmmKgAl7m4sK/ekxtpJ+cv0gChW2ZaWK8tYzv46
         tdLmQ1iNZc5vrbPxJIQarl0OoCXmyZnU2BbIY9tf4hzTQyZD/Q1iaeaS2GbIwZd5JllE
         5DAqa37CkfSgelvVVFVIt5er3HinUA0GWN1he/JmfMeuJ5B+xE9z372Cozj/ijiEaSg+
         c/xA==
X-Received: by 10.152.113.6 with SMTP id iu6mr10280361lab.43.1359290793469;
        Sun, 27 Jan 2013 04:46:33 -0800 (PST)
Received: from slacktop.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id tm10sm2326630lab.10.2013.01.27.04.46.32
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 04:46:32 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.349.g4cdd23e
In-Reply-To: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214697>

When working with multiple, unrelated (or loosly related) git repos,
there is often a need to locate all repos with uncommitted work and
perform some action on them (say, commit and push). Before this patch,
such tasks would require manually visiting all repositories, running
`git status` within each one and then decide what to do next.

This mundane task can now be automated by e.g. `git for-each-repo --dirty
status`, which will find all non-bare git repositories below the current
directory (even nested ones), check if they are dirty (as defined by
`git diff --quiet && git diff --cached --quiet`), and for each dirty repo
print the path to the repo and then execute `git status` within the repo.

The command also honours the option '--clean' which restricts the set of
repos to those which '--dirty' would skip, and '-x' which is used to
execute non-git commands.

Finally, the command to execute within each repo is optional. If none is
given, git-for-each-repo will just print the path to each repo found. And
since the command supports -z, this can be used for more advanced scripting
needs.

Note: since git-for-each-repo can execute both git- and nongit commands, it
must cd into the worktree of each repository before executing the command.
It is then no need for the environment variables $GIT_WORK_TREE and $GIT_DIR
to be specified, so git-for-each-repo will instead unset these variables to
stop them from interfering with the executed commands.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 .gitignore                          |   1 +
 Documentation/git-for-each-repo.txt |  71 +++++++++++++++++
 Makefile                            |   1 +
 builtin.h                           |   1 +
 builtin/for-each-repo.c             | 145 ++++++++++++++++++++++++++++++++++
 git.c                               |   1 +
 t/t6400-for-each-repo.sh            | 150 ++++++++++++++++++++++++++++++++++++
 7 files changed, 370 insertions(+)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100755 t/t6400-for-each-repo.sh

diff --git a/.gitignore b/.gitignore
index aa258a6..0c27981 100644
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
index 0000000..fb12b3f
--- /dev/null
+++ b/Documentation/git-for-each-repo.txt
@@ -0,0 +1,71 @@
+git-for-each-repo(1)
+====================
+
+NAME
+----
+git-for-each-repo - Execute a git command in multiple non-bare repositories
+
+SYNOPSIS
+--------
+[verse]
+'git for-each-repo' [-acdxz] [command]
+
+DESCRIPTION
+-----------
+The git-for-each-repo command is used to locate all non-bare git
+repositories within the current directory tree, and optionally
+execute a git command in each of the found repos.
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
+-x::
+	Execute a genric (non-git) command in each repo.
+
+-z::
+	Terminate each path name with the NUL character.
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
+$ git for-each-repo -x du -sh  <5>
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
+<5> Print disk-usage for each repository.
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
index 0000000..9333ae0
--- /dev/null
+++ b/builtin/for-each-repo.c
@@ -0,0 +1,145 @@
+/*
+ * "git for-each-repo" builtin command.
+ *
+ * Copyright (c) 2013 Lars Hjemli <hjemli@gmail.com>
+ */
+#include "cache.h"
+#include "color.h"
+#include "quote.h"
+#include "builtin.h"
+#include "run-command.h"
+#include "parse-options.h"
+
+#define ALL 0
+#define DIRTY 1
+#define CLEAN 2
+
+static char *color = GIT_COLOR_NORMAL;
+static int eol = '\n';
+static int match;
+static int runopt = RUN_GIT_CMD;
+
+static const char * const builtin_foreachrepo_usage[] = {
+	N_("git for-each-repo [-acdxz] [cmd]"),
+	NULL
+};
+
+static struct option builtin_foreachrepo_options[] = {
+	OPT_SET_INT('a', "all", &match, N_("match both clean and dirty repositories"), ALL),
+	OPT_SET_INT('c', "clean", &match, N_("only show clean repositories"), CLEAN),
+	OPT_SET_INT('d', "dirty", &match, N_("only show dirty repositories"), DIRTY),
+	OPT_SET_INT('x', NULL, &runopt, N_("execute generic (non-git) command"), 0),
+	OPT_SET_INT('z', NULL, &eol, N_("terminate each repo path with NUL character"), 0),
+	OPT_END(),
+};
+
+static int get_repo_state(const char *dir)
+{
+	const char *diffidx[] = {"diff", "--quiet", "--cached", NULL};
+	const char *diffwd[] = {"diff", "--quiet", NULL};
+
+	if (run_command_v_opt_cd_env(diffidx, RUN_GIT_CMD, dir, NULL) != 0)
+		return DIRTY;
+	if (run_command_v_opt_cd_env(diffwd, RUN_GIT_CMD, dir, NULL) != 0)
+		return DIRTY;
+	return CLEAN;
+}
+
+static void print_repo_path(const char *path, unsigned pretty)
+{
+	if (path[0] == '.' && path[1] == '/')
+		path += 2;
+	if (pretty)
+		color_fprintf_ln(stdout, color, "[%s]", path);
+	else
+		write_name_quoted(path, stdout, eol);
+}
+
+static void handle_repo(struct strbuf *path, const char **argv)
+{
+	const char *gitdir;
+	int len;
+
+	len = path->len;
+	strbuf_addstr(path, ".git");
+	gitdir = resolve_gitdir(path->buf);
+	strbuf_setlen(path, len - 1);
+	if (!gitdir)
+		goto done;
+	if (match != ALL && match != get_repo_state(path->buf))
+		goto done;
+	print_repo_path(path->buf, *argv != NULL);
+	if (*argv)
+		run_command_v_opt_cd_env(argv, runopt, path->buf, NULL);
+done:
+	strbuf_addstr(path, "/");
+}
+
+static int walk(struct strbuf *path, int argc, const char **argv)
+{
+	DIR *dir;
+	struct dirent *ent;
+	struct stat st;
+	size_t len;
+	int has_dotgit = 0;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
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
+			has_dotgit = 1;
+			continue;
+		}
+		switch (DTYPE(ent)) {
+		case DT_UNKNOWN:
+		case DT_LNK:
+			/* Use stat() to figure out if this path leads
+			 * to a directory - it's  not important if it's
+			 * a symlink which gets us there.
+			 */
+			strbuf_setlen(path, len);
+			strbuf_addstr(path, ent->d_name);
+			if (stat(path->buf, &st) || !S_ISDIR(st.st_mode))
+				break;
+			/* fallthrough */
+		case DT_DIR:
+			string_list_append(&list, ent->d_name);
+			break;
+		}
+	}
+	closedir(dir);
+	strbuf_setlen(path, len);
+	if (has_dotgit)
+		handle_repo(path, argv);
+	sort_string_list(&list);
+	for_each_string_list_item(item, &list) {
+		strbuf_setlen(path, len);
+		strbuf_addstr(path, item->string);
+		walk(path, argc, argv);
+	}
+	string_list_clear(&list, 0);
+	return 0;
+}
+
+int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	unsetenv(GIT_DIR_ENVIRONMENT);
+	unsetenv(GIT_WORK_TREE_ENVIRONMENT);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_foreachrepo_options,
+			     builtin_foreachrepo_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (want_color(GIT_COLOR_AUTO))
+		color = GIT_COLOR_YELLOW;
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
index 0000000..af02c0c
--- /dev/null
+++ b/t/t6400-for-each-repo.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Lars Hjemli
+#
+
+test_description='Test the git-for-each-repo command'
+
+. ./test-lib.sh
+
+qname="with\"quote"
+qqname="\"with\\\"quote\""
+
+test_expect_success "setup" '
+	test_create_repo clean &&
+	(cd clean && test_commit foo1) &&
+	git init --separate-git-dir=.cleansub clean/gitfile &&
+	(cd clean/gitfile && test_commit foo2 && echo bar >>foo2.t) &&
+	test_create_repo dirty-idx &&
+	(cd dirty-idx && test_commit foo3 && git rm foo3.t) &&
+	test_create_repo dirty-wt &&
+	(cd dirty-wt && mv .git .linkedgit && ln -s .linkedgit .git &&
+	  test_commit foo4 && rm foo4.t) &&
+	test_create_repo "$qname" &&
+	(cd "$qname" && test_commit foo5) &&
+	mkdir fakedir && mkdir fakedir/.git
+'
+
+test_expect_success "without filtering, all repos are included" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	echo "clean/gitfile" >>expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	echo "$qqname" >>expect &&
+	git for-each-repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "-z NUL-terminates each path" '
+	echo "(.)" >expect &&
+	echo "(clean)" >>expect &&
+	echo "(clean/gitfile)" >>expect &&
+	echo "(dirty-idx)" >>expect &&
+	echo "(dirty-wt)" >>expect &&
+	echo "($qname)" >>expect &&
+	git for-each-repo -z | xargs -0 printf "(%s)\n"  >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--dirty only includes dirty repos" '
+	echo "clean/gitfile" >expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	git for-each-repo --dirty >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--clean only includes clean repos" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	echo "$qqname" >>expect &&
+	git for-each-repo --clean >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "run a git-command in all repos" '
+	echo "[.]" >expect &&
+	echo "[clean]" >>expect &&
+	echo "[clean/gitfile]" >>expect &&
+	echo " M foo2.t" >>expect &&
+	echo "[dirty-idx]" >>expect &&
+	echo "D  foo3.t" >>expect &&
+	echo "[dirty-wt]" >>expect &&
+	echo " D foo4.t" >> expect
+	echo "[$qname]" >>expect &&
+	git for-each-repo status -suno >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "run a git-command in dirty repos only" '
+	echo "[clean/gitfile]" >expect &&
+	echo " M foo2.t" >>expect &&
+	echo "[dirty-idx]" >>expect &&
+	echo "D  foo3.t" >>expect &&
+	echo "[dirty-wt]" >>expect &&
+	echo " D foo4.t" >> expect
+	git for-each-repo -d status -suno >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "run a git-command in clean repos only" '
+	echo "[.]" >expect &&
+	echo "[clean]" >>expect &&
+	echo "foo1.t" >>expect &&
+	echo "[$qname]" >>expect &&
+	echo "foo5.t" >>expect &&
+	git for-each-repo -c ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "-z is disabled when a command is run" '
+	echo "[.]" >expect &&
+	echo "[clean]" >>expect &&
+	echo "foo1.t" >>expect &&
+	echo "[$qname]" >>expect &&
+	echo "foo5.t" >>expect &&
+	git for-each-repo -cz ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "-x executes any command in each repo" '
+	echo "[.]" >expect &&
+	echo "$HOME" >>expect &&
+	echo "[clean]" >>expect &&
+	echo "$HOME/clean" >>expect &&
+	echo "[clean/gitfile]" >>expect &&
+	echo "$HOME/clean/gitfile" >>expect &&
+	echo "[dirty-idx]" >>expect &&
+	echo "$HOME/dirty-idx" >>expect &&
+	echo "[dirty-wt]" >>expect &&
+	echo "$HOME/dirty-wt" >> expect
+	echo "[$qname]" >>expect &&
+	echo "$HOME/$qname" >>expect &&
+	git for-each-repo -x pwd >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "-cx executes any command in clean repos" '
+	echo "[.]" >expect &&
+	echo "$HOME" >>expect &&
+	echo "[clean]" >>expect &&
+	echo "$HOME/clean" >>expect &&
+	echo "[$qname]" >>expect &&
+	echo "$HOME/$qname" >>expect &&
+	git for-each-repo -cx pwd >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "-dx executes any command in dirty repos" '
+	echo "[clean/gitfile]" >expect &&
+	echo "$HOME/clean/gitfile" >>expect &&
+	echo "[dirty-idx]" >>expect &&
+	echo "$HOME/dirty-idx" >>expect &&
+	echo "[dirty-wt]" >>expect &&
+	echo "$HOME/dirty-wt" >> expect
+	git for-each-repo -dx pwd >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.1.349.g4cdd23e
