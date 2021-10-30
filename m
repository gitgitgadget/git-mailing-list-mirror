Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E8C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA5C60F0F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 14:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJ3ODw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhJ3ODu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 10:03:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF15C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 07:01:20 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1635602477; bh=kHDnxsQO3kiqHY7Tc5YATfzgXg9bscF1vT22csIATyE=;
        h=From:To:Cc:Subject:Date:From;
        b=hFjmWzPhPkRw1Hfl49LZkP284ykRZ20DtsCqgnKk39QBNBxS8la77VhMHmBnrdEAi
         q4eXyZQK/Lisirvyk0Jb7YozIAkkH5kAKKnfEoVwR0X11CPGgtgVhzKMC5mbpwELUz
         XpzA4os7QoPflUeVJrY7NvpTzAWmVD7lBkfBuOcY=
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH] builtin: add git-default-branch command
Date:   Sat, 30 Oct 2021 16:01:12 +0200
Message-Id: <20211030140112.834650-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce command `default-branch` which allows to retrieve the branch
that will be used by git-init.

Currently this command is equivalent to
	git config init.defaultbranch || 'master'

This however will break if at one point the default branch is changed as
indicated by `default_branch_name_advice` in `refs.c`.

By providing this command ahead of time users of git can make their
code forward-compatible.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 .gitignore                           |  1 +
 Documentation/git-default-branch.txt | 15 +++++++++++++
 Makefile                             |  1 +
 builtin.h                            |  1 +
 builtin/default-branch.c             | 33 ++++++++++++++++++++++++++++
 command-list.txt                     |  1 +
 git.c                                |  1 +
 t/t1417-default-branch.sh            | 21 ++++++++++++++++++
 8 files changed, 74 insertions(+)
 create mode 100644 Documentation/git-default-branch.txt
 create mode 100644 builtin/default-branch.c
 create mode 100755 t/t1417-default-branch.sh

diff --git a/.gitignore b/.gitignore
index 311841f9be..d9b969dc7e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -53,6 +53,7 @@
 /git-cvsimport
 /git-cvsserver
 /git-daemon
+/git-default-branch
 /git-diff
 /git-diff-files
 /git-diff-index
diff --git a/Documentation/git-default-branch.txt b/Documentation/git-default-branch.txt
new file mode 100644
index 0000000000..d5b891e5b4
--- /dev/null
+++ b/Documentation/git-default-branch.txt
@@ -0,0 +1,15 @@
+git-default-branch(1)
+===================
+
+NAME
+----
+git-default-branch - Read the default branch ref used by git
+
+SYNOPSIS
+--------
+[verse]
+'git default-branch'
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index d1feab008f..49276359ab 100644
--- a/Makefile
+++ b/Makefile
@@ -1091,6 +1091,7 @@ BUILTIN_OBJS += builtin/credential-cache.o
 BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
+BUILTIN_OBJS += builtin/default-branch.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..65b41e4c1f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -143,6 +143,7 @@ int cmd_credential(int argc, const char **argv, const char *prefix);
 int cmd_credential_cache(int argc, const char **argv, const char *prefix);
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
 int cmd_credential_store(int argc, const char **argv, const char *prefix);
+int cmd_default_branch(int argc, const char **argv, const char *prefix);
 int cmd_describe(int argc, const char **argv, const char *prefix);
 int cmd_diff_files(int argc, const char **argv, const char *prefix);
 int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/default-branch.c b/builtin/default-branch.c
new file mode 100644
index 0000000000..e74c078926
--- /dev/null
+++ b/builtin/default-branch.c
@@ -0,0 +1,33 @@
+#include "builtin.h"
+#include "config.h"
+#include "refs.h"
+#include "parse-options.h"
+
+static const char * const git_default_branch_usage[] = {
+	N_("git default-branch"),
+	NULL
+};
+
+
+int cmd_default_branch(int argc, const char **argv, const char *prefix)
+{
+	char *name;
+
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_default_branch_usage, 0);
+
+	if (argc != 0)
+		usage_with_options(git_default_branch_usage, options);
+
+	name = repo_default_branch_name(the_repository, 1);
+
+	if (!name)
+		die("Could not fetch default branch name");
+
+	puts(name);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6..950fa9a993 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -81,6 +81,7 @@ git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
+git-default-branch                      plumbinginterrogators
 git-describe                            mainporcelain
 git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
diff --git a/git.c b/git.c
index 18bed9a996..112f37a7f3 100644
--- a/git.c
+++ b/git.c
@@ -516,6 +516,7 @@ static struct cmd_struct commands[] = {
 	{ "credential-cache", cmd_credential_cache },
 	{ "credential-cache--daemon", cmd_credential_cache_daemon },
 	{ "credential-store", cmd_credential_store },
+	{ "default-branch", cmd_default_branch, RUN_SETUP_GENTLY },
 	{ "describe", cmd_describe, RUN_SETUP },
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
diff --git a/t/t1417-default-branch.sh b/t/t1417-default-branch.sh
new file mode 100755
index 0000000000..d81f1ee214
--- /dev/null
+++ b/t/t1417-default-branch.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='Test git default-branch'
+
+. ./test-lib.sh
+
+unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+test_expect_success 'without configuration' '
+	b=$(git default-branch) &&
+	verbose test "$b" = master
+'
+
+test_expect_success 'with configuration' '
+	git config init.defaultbranch foo &&
+	b=$(git default-branch) &&
+	echo $b &&
+	verbose test "$b" = foo
+'
+
+test_done

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.33.1

