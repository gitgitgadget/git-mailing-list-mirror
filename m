From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: [PATCH] Make gc a builtin.
Date: Sun, 11 Mar 2007 22:51:18 -0400
Message-ID: <3f80363f0703111951x9d88e74x8d7723af97c18c7@mail.gmail.com>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
	 <1173650820969-git-send-email-jbowes@dangerouslyinc.com>
	 <Pine.LNX.4.63.0703112332550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vtzwrtdmx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 03:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQadG-000746-Ke
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 03:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbXCLCvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 22:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbXCLCvV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 22:51:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:2355 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbXCLCvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 22:51:20 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1841772nfa
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 19:51:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oMER6twTdAPSJ5xf35zSZ1Rj0lifiO+VM95W+i3bmF70d5yAD/cHsEdP2D5GANkNQhmOf7/CiEG9Cy5ewoUa5yc4v/Xma7z9TZfGx3Ze/PAZgX/uwQ/m/SVHOHPU/y0TOH8BCCrty88//gYd7FS3Ww2bwln7rvTOKJrjns8GSAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EZy4pqbtnB62plntxnYrHmg8mUq41o2keu1Abyxsm3Gh0d+7HHwd4ul1hfL8CmzVKP/UQghU6efaw9wf9uOOknHEl2PtuxSatnRUy6YzJtF1ct7MubNwA5CWYKFLDHUYBm90paHyGelXijJjqbAOZgCosEXfrXrDfJYnBIboEtg=
Received: by 10.115.93.16 with SMTP id v16mr1080854wal.1173667878253;
        Sun, 11 Mar 2007 19:51:18 -0700 (PDT)
Received: by 10.114.194.4 with HTTP; Sun, 11 Mar 2007 19:51:18 -0700 (PDT)
In-Reply-To: <7vtzwrtdmx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 48d3cde4573e6738
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42005>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

This patch replaces replaces my previous two. It uses
run_command_v_opt rather than changing run-command.*, and

if (command_fails)
    goto failure

for running the commands.

-James

 Makefile     |    3 +-
 builtin-gc.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h    |    1 +
 git-gc.sh    |   37 ---------------------------
 git.c        |    1 +
 5 files changed, 82 insertions(+), 38 deletions(-)
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
index 0000000..c507bdf
--- /dev/null
+++ b/builtin-gc.c
@@ -0,0 +1,78 @@
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
+static const char *argv_pack_refs[] = {"pack-refs", "--prune", NULL};
+static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
+static const char *argv_repack[] = {"repack", "-a", "-d", "-l", NULL};
+static const char *argv_prune[] = {"prune", NULL};
+static const char *argv_rerere[] = {"rerere", "gc", NULL};
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
+    if (pack_refs)
+	    if (run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
+            goto failure;
+
+    if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
+        goto failure;
+
+    if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
+        goto failure;
+
+    if (prune)
+        if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
+            goto failure;
+
+    if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
+        goto failure;
+
+    return 0;
+
+failure:
+    return -1;
+}
diff --git a/builtin.h b/builtin.h
index 1cb64b7..af203e9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -37,6 +37,7 @@ extern int cmd_fmt_merge_msg(int argc, const char
**argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
+extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const
char *prefix);
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
@@ -249,6 +249,7 @@ static void handle_internal_command(int argc,
const char **argv, char **envp)
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
 		{ "fsck", cmd_fsck, RUN_SETUP },
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
+		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "help", cmd_help },
-- 
1.5.0.2
