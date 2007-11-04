From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Make git-clean a builtin
Date: Sun,  4 Nov 2007 13:02:21 -0600
Message-ID: <11942029474058-git-send-email-shawn.bohrer@gmail.com>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
 <11942029442710-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 20:02:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iokk1-0002N9-Tx
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbXKDTCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbXKDTCN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:02:13 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:62610 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXKDTCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:02:09 -0500
Received: by an-out-0708.google.com with SMTP id b36so163247ana
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OL4HONk+ZSSpvdsnbRcUHaOyEt4eVhvkZI+LSE0nEk8=;
        b=Z2CVqBsA5c0yiNT+Xq7XWI6dFDij1PBd3dKewRWx2PPhGzg5kAzASPB+NyHIfPmDazUzm+CDwyTB+gwT32vE9OdYtKiR0+BovBi6xga5xWuY3APadmtdza9qoq64xu57UJvXCZfCtH12JOaelhNcB8R6RjEoUyTnQ3I28D68gD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P92bY4SelcyatYe0X5YetwqNPdedZwBEzIo8ggc2KSUNRchPvS8DB1WcTjQEvpp0In5sXT54007wd3D6w8+yFrf7nFg895CuuND3r2Ae0YHa+4tncaSpit3l4r5BDxvMlFE33bc3OPYYsCmPX2GmM0oAMVl4ERtwAW0+J/kHdtY=
Received: by 10.100.229.10 with SMTP id b10mr5374602anh.1194202928841;
        Sun, 04 Nov 2007 11:02:08 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id q30sm3812813wrq.2007.11.04.11.02.06
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 11:02:07 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Sun,  4 Nov 2007 13:02:27 -0600
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: <11942029442710-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63429>

This replaces git-clean.sh with builtin-clean.c, and moves git-clean.sh to
the examples.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 Makefile                                      |    3 +-
 builtin-clean.c                               |  157 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-clean.sh => contrib/examples/git-clean.sh |    0 
 git.c                                         |    1 +
 5 files changed, 161 insertions(+), 1 deletions(-)
 create mode 100644 builtin-clean.c
 rename git-clean.sh => contrib/examples/git-clean.sh (100%)

diff --git a/Makefile b/Makefile
index 3ec1876..fad49b2 100644
--- a/Makefile
+++ b/Makefile
@@ -209,7 +209,7 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clone.sh git-commit.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
@@ -326,6 +326,7 @@ BUILTIN_OBJS = \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-clean.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
diff --git a/builtin-clean.c b/builtin-clean.c
new file mode 100644
index 0000000..4141eb4
--- /dev/null
+++ b/builtin-clean.c
@@ -0,0 +1,157 @@
+/*
+ * "git clean" builtin command
+ *
+ * Copyright (C) 2007 Shawn Bohrer
+ *
+ * Based on git-clean.sh by Pavel Roskin
+ */
+
+#include "builtin.h"
+#include "cache.h"
+#include "dir.h"
+
+static int disabled = 1;
+static int show_only = 0;
+static int remove_directories = 0;
+static int quiet = 0;
+static int ignored = 0;
+static int ignored_only = 0;
+
+static const char builtin_clean_usage[] =
+"git-clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...";
+
+static int git_clean_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "clean.requireforce")) {
+		disabled = git_config_bool(var, value);
+	}
+	return 0;
+}
+
+int cmd_clean(int argc, const char **argv, const char *prefix)
+{
+	int i, j;
+	struct strbuf directory;
+	struct dir_struct dir;
+	const char *path = ".";
+	const char *base = "";
+	int baselen = 0;
+	static const char **pathspec;
+
+	memset(&dir, 0, sizeof(dir));
+	git_config(git_clean_config);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-n")) {
+			show_only = 1;
+			disabled = 0;
+			continue;
+		}
+		if (!strcmp(arg, "-f")) {
+			disabled = 0;
+			continue;
+		}
+		if (!strcmp(arg, "-d")) {
+			remove_directories = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-q")) {
+			quiet = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-x")) {
+			ignored = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-X")) {
+			ignored_only = 1;
+			dir.show_ignored =1;
+			dir.exclude_per_dir = ".gitignore";
+			continue;
+		}
+		usage(builtin_clean_usage);
+	}
+
+	if (ignored && ignored_only)
+		die("-x and -X cannot be used together");
+
+	if (disabled)
+		die("clean.requireForce set and -n or -f not given; refusing to clean");
+
+	dir.show_other_directories = 1;
+
+	if (!ignored) {
+		dir.exclude_per_dir = ".gitignore";
+		if (!access(git_path("info/exclude"), F_OK)) {
+			char *exclude_path = git_path("info/exclude");
+			add_excludes_from_file(&dir, exclude_path);
+		}
+	}
+
+	pathspec = get_pathspec(prefix, argv + i);
+	read_cache();
+	read_directory(&dir, path, base, baselen, pathspec);
+	strbuf_init(&directory, 0);
+
+	for (j = 0; j < dir.nr; ++j) {
+		struct dir_entry *ent = dir.entries[j];
+		int len, pos;
+		struct cache_entry *ce;
+		struct stat st;
+
+		/*
+		 * Remove the '/' at the end that directory
+		 * walking adds for directory entries.
+		 */
+		len = ent->len;
+		if (len && ent->name[len-1] == '/')
+			len--;
+		pos = cache_name_pos(ent->name, len);
+		if (0 <= pos)
+			continue;	/* exact match */
+		pos = -pos - 1;
+		if (pos < active_nr) {
+			ce = active_cache[pos];
+			if (ce_namelen(ce) == len &&
+			    !memcmp(ce->name, ent->name, len))
+				continue; /* Yup, this one exists unmerged */
+		}
+
+		/* remove the files */
+		if (!lstat(ent->name, &st) && (S_ISDIR(st.st_mode))) {
+			strbuf_addstr(&directory, ent->name);
+			if (show_only && remove_directories) {
+				printf("Would remove %s\n", directory.buf);
+			} else if (quiet && remove_directories) {
+				remove_dir_recursively(&directory, 0);
+			} else if (remove_directories) {
+				printf("Removing %s\n", ent->name);
+				remove_dir_recursively(&directory, 0);
+			} else if (show_only) {
+				printf("Would not remove %s\n", directory.buf);
+			} else {
+				printf("Not removing %s\n", directory.buf);
+			}
+			strbuf_reset(&directory);
+		} else {
+			if (show_only) {
+				printf("Would remove %s\n", ent->name);
+				continue;
+			} else if (!quiet) {
+				printf("Removing %s\n", ent->name);
+			}
+			unlink(ent->name);
+		}
+	}
+
+	strbuf_release(&directory);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 2335c01..0cbd685 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
+extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
diff --git a/git-clean.sh b/contrib/examples/git-clean.sh
similarity index 100%
rename from git-clean.sh
rename to contrib/examples/git-clean.sh
diff --git a/git.c b/git.c
index 19a2172..30b7c22 100644
--- a/git.c
+++ b/git.c
@@ -298,6 +298,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
-- 
1.5.3.GIT
