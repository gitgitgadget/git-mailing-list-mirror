From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Make git-clean a builtin
Date: Sat,  6 Oct 2007 15:54:06 -0500
Message-ID: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 22:53:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeGeA-0005dk-VR
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 22:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764467AbXJFUxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 16:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765444AbXJFUxG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 16:53:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:56538 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764245AbXJFUxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 16:53:05 -0400
Received: by wx-out-0506.google.com with SMTP id h31so842210wxd
        for <git@vger.kernel.org>; Sat, 06 Oct 2007 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=VWZhmPeidyXVdXErUgj1u4ycYvtMTdlnJGn8JJNzUe0=;
        b=cVinQX9f6jmJbXyxpftzbJr6xeTwmgp7TOCu/QoyqPN9GWGVeP7CNI2Y/TvrR5iNEnUHVrhpZgOvfXqQREc9ERKNSn8btTQ2aer0su9KHsxpRVSel293yHtyipBayuMY/ReMpAhpOO3hvIz71r+iTxIg6lm/TxA07HNoXT9wQtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=k1SwA9ViKrRfjT9X706WfOFXNWYt380era2tlt3fR9uxT1xhT+mtiSPZXN6NS19fn16AEtsnRVafM9cTpfnwlK4W+CZ+3p7OR/SVzZEaKEKnaGPYrgIM1dox2iqdW1LNbaO4QZ/A/aGchNJ9uwlSFNpaNT/mwK/X0tWsIO/9yT0=
Received: by 10.90.118.12 with SMTP id q12mr1643167agc.1191703982586;
        Sat, 06 Oct 2007 13:53:02 -0700 (PDT)
Received: from mediacenter ( [70.112.123.114])
        by mx.google.com with ESMTPS id g5sm5545057wra.2007.10.06.13.53.00
        (version=SSLv3 cipher=OTHER);
        Sat, 06 Oct 2007 13:53:01 -0700 (PDT)
Received: by mediacenter (sSMTP sendmail emulation); Sat,  6 Oct 2007 15:54:06 -0500
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60157>

This replaces git-clean.sh with builtin-clean.c, and moves git-clean.sh to the
examples.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 Makefile                                      |    3 +-
 builtin-clean.c                               |  177 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-clean.sh => contrib/examples/git-clean.sh |    0 
 git.c                                         |    1 +
 5 files changed, 181 insertions(+), 1 deletions(-)
 create mode 100644 builtin-clean.c
 rename git-clean.sh => contrib/examples/git-clean.sh (100%)

diff --git a/Makefile b/Makefile
index 8db4dbe..2b3b8fb 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clone.sh git-commit.sh \
 	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
@@ -327,6 +327,7 @@ BUILTIN_OBJS = \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-clean.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
diff --git a/builtin-clean.c b/builtin-clean.c
new file mode 100644
index 0000000..534707f
--- /dev/null
+++ b/builtin-clean.c
@@ -0,0 +1,177 @@
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
+#include "run-command.h"
+
+static int disabled = 0;
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
+static int remove_directory(const char *path)
+{
+	DIR *d;
+	struct dirent *dir;
+	d = opendir(path);
+	if (d) {
+		chdir(path);
+		while ((dir = readdir(d)) != NULL) {
+			if(strcmp( dir->d_name, ".") == 0 ||
+			   strcmp( dir->d_name, ".." ) == 0 )
+				continue;
+			if (dir->d_type == DT_DIR)
+				remove_directory(dir->d_name);
+			else
+				unlink(dir->d_name);
+		}
+	}
+	closedir(d);
+	chdir("..");
+	return rmdir(path);
+}
+
+int cmd_clean(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int j;
+	struct child_process cmd;
+	const char **argv_ls_files;
+	char *buf;
+	char path[1024];
+	FILE *cmd_fout;
+
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
+			continue;
+		}
+		usage(builtin_clean_usage);
+	}
+
+	if (ignored && ignored_only)
+		usage(builtin_clean_usage);
+
+	if (disabled) {
+		die("clean.requireForce set and -n or -f not given; refusing to clean");
+	}
+
+	/* Paths (argc - i) + 8 (Possible arguments)*/
+	argv_ls_files = xmalloc((argc - i + 8) * sizeof(const char *));
+	argv_ls_files[0] = "ls-files";
+	argv_ls_files[1] = "--others";
+	argv_ls_files[2] = "--directory";
+	j = 3;
+	if (!ignored) {
+		argv_ls_files[j++] = "--exclude-per-directory=.gitignore";
+		if (ignored_only)
+			argv_ls_files[j++] = "--ignored";
+		if (!access(git_path("info/exclude"), F_OK)) {
+			char *exclude_path = git_path("info/exclude");
+			int len = strlen(exclude_path);
+			buf = (char*)malloc(len+16);
+			sprintf(buf, "--exclude-from=%s", exclude_path);
+			argv_ls_files[j++] = buf;
+		}
+	}
+	argv_ls_files[j++] = "--";
+	/* Add remaining paths passed in as arguments */
+	if (argc - i)
+		memcpy(argv_ls_files + j++, argv + i, (argc - i) * sizeof(const char *));
+	argv_ls_files[j + argc - i] = NULL;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv_ls_files;
+	cmd.git_cmd = 1;
+	cmd.out = -1;
+	if (start_command(&cmd))
+		die("Could not run sub-command: git ls-files");
+
+	cmd_fout = fdopen(cmd.out, "r");
+	while (fgets(path, sizeof(path), cmd_fout) != NULL) {
+		struct stat st;
+		char *p;
+		p = strrchr(path, '\n');
+		if ( p != NULL )
+			*p = '\0';
+		if (!lstat(path, &st) && (S_ISDIR(st.st_mode))) {
+			if (show_only && remove_directories) {
+				printf("Would remove %s\n", path);
+			} else if (quiet && remove_directories) {
+				remove_directory(path);
+			} else if (remove_directories) {
+				printf("Removing %s\n", path);
+				remove_directory(path);
+			} else if (show_only) {
+				printf("Would not remove %s\n", path);
+			} else {
+				printf("Not removing %s\n", path);
+			}
+		} else {
+			if (show_only) {
+				printf("Would remove %s\n", path);
+				continue;
+			} else if (!quiet) {
+				printf("Removing %s\n", path);
+			}
+			unlink(path);
+		}
+	}
+
+	fclose(cmd_fout);
+	finish_command(&cmd);
+	if (!ignored && !access(git_path("info/exclude"), F_OK))
+		free(buf);
+	free(argv_ls_files);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index d6f2c76..8c112f3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -23,6 +23,7 @@ extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
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
index 9eaca1d..cda6344 100644
--- a/git.c
+++ b/git.c
@@ -320,6 +320,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clean", cmd_clean, RUN_SETUP },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
-- 
1.5.3.GIT
