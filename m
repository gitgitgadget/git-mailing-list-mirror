From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH 2/2] Make gc a builtin.
Date: Sun, 11 Mar 2007 18:06:58 -0400
Message-ID: <1173650820969-git-send-email-jbowes@dangerouslyinc.com>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 23:07:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQWCO-0007aP-HR
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbXCKWHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXCKWHS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:07:18 -0400
Received: from ms-smtp-04.southeast.rr.com ([24.25.9.103]:34999 "EHLO
	ms-smtp-04.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932879AbXCKWHO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2007 18:07:14 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-04.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2BM7DGv003353
	for <git@vger.kernel.org>; Sun, 11 Mar 2007 18:07:13 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.2
In-Reply-To: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41997>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 Makefile     |    3 +-
 builtin-gc.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h    |    1 +
 git-gc.sh    |   37 --------------------------
 git.c        |    1 +
 5 files changed, 85 insertions(+), 38 deletions(-)
 create mode 100644 builtin-gc.c
 delete mode 100755 git-gc.sh

diff --git a/Makefile b/Makefile
index f0fc2f8..fb17cfb 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,7 @@ BASIC_LDFLAGS =
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
 	git-clean.sh git-clone.sh git-commit.sh \
-	git-fetch.sh git-gc.sh \
+	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
@@ -297,6 +297,7 @@ BUILTIN_OBJS = \
 	builtin-fmt-merge-msg.o \
 	builtin-for-each-ref.o \
 	builtin-fsck.o \
+	builtin-gc.o \
 	builtin-grep.o \
 	builtin-init-db.o \
 	builtin-log.o \
diff --git a/builtin-gc.c b/builtin-gc.c
new file mode 100644
index 0000000..7a9332b
--- /dev/null
+++ b/builtin-gc.c
@@ -0,0 +1,81 @@
+/*
+ * git gc builtin command
+ *
+ * Cleanup unreachable files and optimize the repository.
+ *
+ * Copyright (c) 2007 James Bowes
+ *
+ * Based on git-gc.sh, which is
+ *
+ * Copyright (c) 2006 Shawn O. Pearce
+ */
+
+#include "cache.h"
+#include "run-command.h"
+
+static const char builtin_gc_usage[] = "git-gc [--prune]";
+
+static int pack_refs;
+
+static int gc_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "gc.packrefs"))
+		if (strlen(value) == 0 || !strcmp(value, "notbare"))
+			pack_refs = !is_bare_repository();
+		else
+			pack_refs = git_config_bool(var, value);
+	else
+		return git_default_config(var, value);
+	return 0;
+}
+
+static void run_command_or_die(const char *cmd, ...)
+{
+	int err;
+	va_list params;
+
+	va_start(params, cmd);
+	err = run_command_va(cmd, params);
+	va_end(params);
+
+	switch (err) {
+	case 0:
+		return;
+	case -ERR_RUN_COMMAND_FORK:
+		die("unable to fork for %s", cmd);
+	case -ERR_RUN_COMMAND_EXEC:
+		die("unable to exec %s", cmd);
+	default:
+		die("%s died with strange error", cmd);
+	}
+}
+
+int cmd_gc(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int prune = 0;
+
+	git_config(gc_config);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--prune")) {
+			prune = 1;
+			continue;
+		}
+		/* perhaps other parameters later... */
+		break;
+	}
+	if (i != argc)
+		usage(builtin_gc_usage);
+
+	if (pack_refs)
+		run_command_or_die("git-pack-refs", "--prune", NULL);
+	run_command_or_die("git-reflog", "expire", "--all", NULL);
+	run_command_or_die("git-repack", "-a", "-d", "-l", NULL);
+	if (prune)
+		run_command_or_die("git-prune", NULL);
+	run_command_or_die("git-rerere", "gc", NULL);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 1cb64b7..af203e9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -37,6 +37,7 @@ extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
+extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
diff --git a/git-gc.sh b/git-gc.sh
deleted file mode 100755
index 436d7ca..0000000
--- a/git-gc.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2006, Shawn O. Pearce
-#
-# Cleanup unreachable files and optimize the repository.
-
-USAGE='[--prune]'
-SUBDIRECTORY_OK=Yes
-. git-sh-setup
-
-no_prune=:
-while case $# in 0) break ;; esac
-do
-	case "$1" in
-	--prune)
-		no_prune=
-		;;
-	--)
-		usage
-		;;
-	esac
-	shift
-done
-
-case "$(git config --get gc.packrefs)" in
-notbare|"")
-	test $(is_bare_repository) = true || pack_refs=true;;
-*)
-	pack_refs=$(git config --bool --get gc.packrefs)
-esac
-
-test "true" != "$pack_refs" ||
-git-pack-refs --prune &&
-git-reflog expire --all &&
-git-repack -a -d -l &&
-$no_prune git-prune &&
-git-rerere gc || exit
diff --git a/git.c b/git.c
index dde4d07..ed1c65e 100644
--- a/git.c
+++ b/git.c
@@ -249,6 +249,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
 		{ "fsck", cmd_fsck, RUN_SETUP },
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
+		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "help", cmd_help },
-- 
1.5.0.2
