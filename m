From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 4/4] Move builtin-related implementations to a new builtin.c
 file
Date: Thu, 02 Jan 2014 17:17:52 +0100
Message-ID: <52C59130.4050003@gmail.com>
References: <52C58FD7.6010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 17:18:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VykyE-0000qO-4X
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 17:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbaABQSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 11:18:02 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:55940 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaABQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 11:18:00 -0500
Received: by mail-bk0-f51.google.com with SMTP id 6so4700175bkj.10
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5kBd7FISNGZm/KJ9fesJL0W/u7XvBB7LsOA1ct+eJDU=;
        b=nPWTYVD0Yiqa7ypvwxzmq8fBhbweW5agGvDCjnSCKKJxDlos33nTauvN03IkQ09sxr
         1PO/SuTsA5FmCgJUlAz3cCd/oypHzDhUElcDc2YTQkJ5ytx3pidemFSp0uRNGOKHjUkh
         gCrbjZuUtGQnkQj6VPvpmjXlPCKlMd2YD/K82x8JHgMjjYZvb0t1+mDRlJSwZLGBhqPe
         Q8oJhOOlF2WxzJOq6qTh74lWW7+/N1N3x4GIM5NZnClkpMJqFcuIULV/fypcMTnM4+eH
         qfHwy62zH3+GLCjqhQKWcoXIEIv25g8UIFBjEbIUDZ5dXucNc6baE/O3NkehrBs29qG+
         yDVQ==
X-Received: by 10.205.12.133 with SMTP id pi5mr1617343bkb.54.1388679479251;
        Thu, 02 Jan 2014 08:17:59 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id dg4sm43522459bkc.10.2014.01.02.08.17.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 08:17:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <52C58FD7.6010608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239857>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/technical/api-builtin.txt |   2 +-
 Makefile                                |   1 +
 builtin.c                               | 225 ++++++++++++++++++++++++++++++
 builtin.h                               |  21 +++
 git.c                                   | 238 --------------------------------
 5 files changed, 248 insertions(+), 239 deletions(-)
 create mode 100644 builtin.c

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index e3d6e7a..d1d946c 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -14,7 +14,7 @@ Git:
 
 . Add the external declaration for the function to `builtin.h`.
 
-. Add the command to the `commands[]` table defined in `git.c`.
+. Add the command to the `commands[]` table defined in `builtin.c`.
   The entry should look like:
 
 	{ "foo", cmd_foo, <options> },
diff --git a/Makefile b/Makefile
index b4af1e2..2d947e8 100644
--- a/Makefile
+++ b/Makefile
@@ -763,6 +763,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
+LIB_OBJS += builtin.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
diff --git a/builtin.c b/builtin.c
new file mode 100644
index 0000000..6bdeb7c
--- /dev/null
+++ b/builtin.c
@@ -0,0 +1,225 @@
+#include "builtin.h"
+
+static struct cmd_struct commands[] = {
+	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "annotate", cmd_annotate, RUN_SETUP },
+	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
+	{ "archive", cmd_archive },
+	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "blame", cmd_blame, RUN_SETUP },
+	{ "branch", cmd_branch, RUN_SETUP },
+	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
+	{ "cat-file", cmd_cat_file, RUN_SETUP },
+	{ "check-attr", cmd_check_attr, RUN_SETUP },
+	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
+	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
+	{ "check-ref-format", cmd_check_ref_format },
+	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout-index", cmd_checkout_index,
+		RUN_SETUP | NEED_WORK_TREE},
+	{ "cherry", cmd_cherry, RUN_SETUP },
+	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
+	{ "clone", cmd_clone },
+	{ "column", cmd_column, RUN_SETUP_GENTLY },
+	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
+	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+	{ "config", cmd_config, RUN_SETUP_GENTLY },
+	{ "count-objects", cmd_count_objects, RUN_SETUP },
+	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
+	{ "describe", cmd_describe, RUN_SETUP },
+	{ "diff", cmd_diff },
+	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
+	{ "diff-index", cmd_diff_index, RUN_SETUP },
+	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	{ "fast-export", cmd_fast_export, RUN_SETUP },
+	{ "fetch", cmd_fetch, RUN_SETUP },
+	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
+	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
+	{ "format-patch", cmd_format_patch, RUN_SETUP },
+	{ "fsck", cmd_fsck, RUN_SETUP },
+	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "gc", cmd_gc, RUN_SETUP },
+	{ "get-tar-commit-id", cmd_get_tar_commit_id },
+	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
+	{ "hash-object", cmd_hash_object },
+	{ "help", cmd_help },
+	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
+	{ "init", cmd_init_db },
+	{ "init-db", cmd_init_db },
+	{ "log", cmd_log, RUN_SETUP },
+	{ "ls-files", cmd_ls_files, RUN_SETUP },
+	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
+	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
+	{ "mailinfo", cmd_mailinfo },
+	{ "mailsplit", cmd_mailsplit },
+	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge-base", cmd_merge_base, RUN_SETUP },
+	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
+	{ "merge-index", cmd_merge_index, RUN_SETUP },
+	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
+	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
+	{ "mktag", cmd_mktag, RUN_SETUP },
+	{ "mktree", cmd_mktree, RUN_SETUP },
+	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
+	{ "name-rev", cmd_name_rev, RUN_SETUP },
+	{ "notes", cmd_notes, RUN_SETUP },
+	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
+	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+	{ "patch-id", cmd_patch_id },
+	{ "pickaxe", cmd_blame, RUN_SETUP },
+	{ "prune", cmd_prune, RUN_SETUP },
+	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "push", cmd_push, RUN_SETUP },
+	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "receive-pack", cmd_receive_pack },
+	{ "reflog", cmd_reflog, RUN_SETUP },
+	{ "remote", cmd_remote, RUN_SETUP },
+	{ "remote-ext", cmd_remote_ext },
+	{ "remote-fd", cmd_remote_fd },
+	{ "repack", cmd_repack, RUN_SETUP },
+	{ "replace", cmd_replace, RUN_SETUP },
+	{ "rerere", cmd_rerere, RUN_SETUP },
+	{ "reset", cmd_reset, RUN_SETUP },
+	{ "rev-list", cmd_rev_list, RUN_SETUP },
+	{ "rev-parse", cmd_rev_parse },
+	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+	{ "rm", cmd_rm, RUN_SETUP },
+	{ "send-pack", cmd_send_pack, RUN_SETUP },
+	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
+	{ "show", cmd_show, RUN_SETUP },
+	{ "show-branch", cmd_show_branch, RUN_SETUP },
+	{ "show-ref", cmd_show_ref, RUN_SETUP },
+	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
+	{ "stripspace", cmd_stripspace },
+	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
+	{ "tag", cmd_tag, RUN_SETUP },
+	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
+	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
+	{ "update-index", cmd_update_index, RUN_SETUP },
+	{ "update-ref", cmd_update_ref, RUN_SETUP },
+	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
+	{ "upload-archive", cmd_upload_archive },
+	{ "upload-archive--writer", cmd_upload_archive_writer },
+	{ "var", cmd_var, RUN_SETUP_GENTLY },
+	{ "verify-pack", cmd_verify_pack },
+	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
+	{ "version", cmd_version },
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+	{ "write-tree", cmd_write_tree, RUN_SETUP },
+};
+
+int use_pager = -1;
+
+void commit_pager_choice(void) {
+	switch (use_pager) {
+	case 0:
+		setenv("GIT_PAGER", "cat", 1);
+		break;
+	case 1:
+		setup_pager();
+		break;
+	default:
+		break;
+	}
+}
+
+int is_builtin(const char *s)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		struct cmd_struct *p = commands+i;
+		if (!strcmp(s, p->cmd))
+			return 1;
+	}
+	return 0;
+}
+
+void handle_builtin(int argc, const char **argv)
+{
+	const char *cmd = argv[0];
+	int i;
+	static const char ext[] = STRIP_EXTENSION;
+
+	if (sizeof(ext) > 1) {
+		i = strlen(argv[0]) - strlen(ext);
+		if (i > 0 && !strcmp(argv[0] + i, ext)) {
+			char *argv0 = xstrdup(argv[0]);
+			argv[0] = cmd = argv0;
+			argv0[i] = '\0';
+		}
+	}
+
+	/* Turn "git cmd --help" into "git help cmd" */
+	if (argc > 1 && !strcmp(argv[1], "--help")) {
+		argv[1] = argv[0];
+		argv[0] = cmd = "help";
+	}
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		struct cmd_struct *p = commands+i;
+		if (strcmp(p->cmd, cmd))
+			continue;
+		exit(run_builtin(p, argc, argv));
+	}
+}
+
+int run_builtin(struct cmd_struct *p, int argc, const char **argv)
+{
+	int status, help;
+	struct stat st;
+	const char *prefix;
+
+	prefix = NULL;
+	help = argc == 2 && !strcmp(argv[1], "-h");
+	if (!help) {
+		if (p->option & RUN_SETUP)
+			prefix = setup_git_directory();
+		if (p->option & RUN_SETUP_GENTLY) {
+			int nongit_ok;
+			prefix = setup_git_directory_gently(&nongit_ok);
+		}
+
+		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
+			use_pager = check_pager_config(p->cmd);
+		if (use_pager == -1 && p->option & USE_PAGER)
+			use_pager = 1;
+
+		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
+		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
+			trace_repo_setup(prefix);
+	}
+	commit_pager_choice();
+
+	if (!help && p->option & NEED_WORK_TREE)
+		setup_work_tree();
+
+	trace_argv_printf(argv, "trace: built-in: git");
+
+	status = p->fn(argc, argv, prefix);
+	if (status)
+		return status;
+
+	/* Somebody closed stdout? */
+	if (fstat(fileno(stdout), &st))
+		return 0;
+	/* Ignore write errors for pipes and sockets.. */
+	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
+		return 0;
+
+	/* Check for ENOSPC and EIO errors.. */
+	if (fflush(stdout))
+		die_errno("write failure on standard output");
+	if (ferror(stdout))
+		die("unknown write failure on standard output");
+	if (fclose(stdout))
+		die_errno("close failed on standard output");
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index c47c110..9388505 100644
--- a/builtin.h
+++ b/builtin.h
@@ -27,7 +27,28 @@ extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
+#define RUN_SETUP		(1<<0)
+#define RUN_SETUP_GENTLY	(1<<1)
+#define USE_PAGER		(1<<2)
+/*
+ * require working tree to be present -- anything uses this needs
+ * RUN_SETUP for reading from the configuration file.
+ */
+#define NEED_WORK_TREE		(1<<3)
+
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+	int option;
+};
+
+extern int use_pager;
+
+extern void commit_pager_choice(void);
+
 extern int is_builtin(const char *s);
+extern void handle_builtin(int argc, const char **argv);
+extern int run_builtin(struct cmd_struct *p, int argc, const char **argv);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index bba4378..c93e545 100644
--- a/git.c
+++ b/git.c
@@ -19,20 +19,6 @@ const char git_more_info_string[] =
 	   "to read about a specific subcommand or concept.");
 
 static struct startup_info git_startup_info;
-static int use_pager = -1;
-
-static void commit_pager_choice(void) {
-	switch (use_pager) {
-	case 0:
-		setenv("GIT_PAGER", "cat", 1);
-		break;
-	case 1:
-		setup_pager();
-		break;
-	default:
-		break;
-	}
-}
 
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
@@ -264,230 +250,6 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-#define RUN_SETUP		(1<<0)
-#define RUN_SETUP_GENTLY	(1<<1)
-#define USE_PAGER		(1<<2)
-/*
- * require working tree to be present -- anything uses this needs
- * RUN_SETUP for reading from the configuration file.
- */
-#define NEED_WORK_TREE		(1<<3)
-
-struct cmd_struct {
-	const char *cmd;
-	int (*fn)(int, const char **, const char *);
-	int option;
-};
-
-static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
-{
-	int status, help;
-	struct stat st;
-	const char *prefix;
-
-	prefix = NULL;
-	help = argc == 2 && !strcmp(argv[1], "-h");
-	if (!help) {
-		if (p->option & RUN_SETUP)
-			prefix = setup_git_directory();
-		if (p->option & RUN_SETUP_GENTLY) {
-			int nongit_ok;
-			prefix = setup_git_directory_gently(&nongit_ok);
-		}
-
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
-			use_pager = check_pager_config(p->cmd);
-		if (use_pager == -1 && p->option & USE_PAGER)
-			use_pager = 1;
-
-		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
-		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
-	}
-	commit_pager_choice();
-
-	if (!help && p->option & NEED_WORK_TREE)
-		setup_work_tree();
-
-	trace_argv_printf(argv, "trace: built-in: git");
-
-	status = p->fn(argc, argv, prefix);
-	if (status)
-		return status;
-
-	/* Somebody closed stdout? */
-	if (fstat(fileno(stdout), &st))
-		return 0;
-	/* Ignore write errors for pipes and sockets.. */
-	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
-		return 0;
-
-	/* Check for ENOSPC and EIO errors.. */
-	if (fflush(stdout))
-		die_errno("write failure on standard output");
-	if (ferror(stdout))
-		die("unknown write failure on standard output");
-	if (fclose(stdout))
-		die_errno("close failed on standard output");
-	return 0;
-}
-
-static struct cmd_struct commands[] = {
-	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "annotate", cmd_annotate, RUN_SETUP },
-	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-	{ "archive", cmd_archive },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
-	{ "blame", cmd_blame, RUN_SETUP },
-	{ "branch", cmd_branch, RUN_SETUP },
-	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
-	{ "cat-file", cmd_cat_file, RUN_SETUP },
-	{ "check-attr", cmd_check_attr, RUN_SETUP },
-	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
-	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-	{ "check-ref-format", cmd_check_ref_format },
-	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
-	{ "checkout-index", cmd_checkout_index,
-		RUN_SETUP | NEED_WORK_TREE},
-	{ "cherry", cmd_cherry, RUN_SETUP },
-	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
-	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-	{ "clone", cmd_clone },
-	{ "column", cmd_column, RUN_SETUP_GENTLY },
-	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
-	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-	{ "config", cmd_config, RUN_SETUP_GENTLY },
-	{ "count-objects", cmd_count_objects, RUN_SETUP },
-	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
-	{ "describe", cmd_describe, RUN_SETUP },
-	{ "diff", cmd_diff },
-	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-	{ "diff-index", cmd_diff_index, RUN_SETUP },
-	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
-	{ "fast-export", cmd_fast_export, RUN_SETUP },
-	{ "fetch", cmd_fetch, RUN_SETUP },
-	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
-	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
-	{ "format-patch", cmd_format_patch, RUN_SETUP },
-	{ "fsck", cmd_fsck, RUN_SETUP },
-	{ "fsck-objects", cmd_fsck, RUN_SETUP },
-	{ "gc", cmd_gc, RUN_SETUP },
-	{ "get-tar-commit-id", cmd_get_tar_commit_id },
-	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-	{ "hash-object", cmd_hash_object },
-	{ "help", cmd_help },
-	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
-	{ "init", cmd_init_db },
-	{ "init-db", cmd_init_db },
-	{ "log", cmd_log, RUN_SETUP },
-	{ "ls-files", cmd_ls_files, RUN_SETUP },
-	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
-	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-	{ "mailinfo", cmd_mailinfo },
-	{ "mailsplit", cmd_mailsplit },
-	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-base", cmd_merge_base, RUN_SETUP },
-	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
-	{ "merge-index", cmd_merge_index, RUN_SETUP },
-	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
-	{ "mktag", cmd_mktag, RUN_SETUP },
-	{ "mktree", cmd_mktree, RUN_SETUP },
-	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-	{ "name-rev", cmd_name_rev, RUN_SETUP },
-	{ "notes", cmd_notes, RUN_SETUP },
-	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
-	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-	{ "patch-id", cmd_patch_id },
-	{ "pickaxe", cmd_blame, RUN_SETUP },
-	{ "prune", cmd_prune, RUN_SETUP },
-	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-	{ "push", cmd_push, RUN_SETUP },
-	{ "read-tree", cmd_read_tree, RUN_SETUP },
-	{ "receive-pack", cmd_receive_pack },
-	{ "reflog", cmd_reflog, RUN_SETUP },
-	{ "remote", cmd_remote, RUN_SETUP },
-	{ "remote-ext", cmd_remote_ext },
-	{ "remote-fd", cmd_remote_fd },
-	{ "repack", cmd_repack, RUN_SETUP },
-	{ "replace", cmd_replace, RUN_SETUP },
-	{ "rerere", cmd_rerere, RUN_SETUP },
-	{ "reset", cmd_reset, RUN_SETUP },
-	{ "rev-list", cmd_rev_list, RUN_SETUP },
-	{ "rev-parse", cmd_rev_parse },
-	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-	{ "rm", cmd_rm, RUN_SETUP },
-	{ "send-pack", cmd_send_pack, RUN_SETUP },
-	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
-	{ "show", cmd_show, RUN_SETUP },
-	{ "show-branch", cmd_show_branch, RUN_SETUP },
-	{ "show-ref", cmd_show_ref, RUN_SETUP },
-	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
-	{ "stripspace", cmd_stripspace },
-	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-	{ "tag", cmd_tag, RUN_SETUP },
-	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
-	{ "update-index", cmd_update_index, RUN_SETUP },
-	{ "update-ref", cmd_update_ref, RUN_SETUP },
-	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
-	{ "upload-archive", cmd_upload_archive },
-	{ "upload-archive--writer", cmd_upload_archive_writer },
-	{ "var", cmd_var, RUN_SETUP_GENTLY },
-	{ "verify-pack", cmd_verify_pack },
-	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
-	{ "version", cmd_version },
-	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
-	{ "write-tree", cmd_write_tree, RUN_SETUP },
-};
-
-int is_builtin(const char *s)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
-		if (!strcmp(s, p->cmd))
-			return 1;
-	}
-	return 0;
-}
-
-static void handle_builtin(int argc, const char **argv)
-{
-	const char *cmd = argv[0];
-	int i;
-	static const char ext[] = STRIP_EXTENSION;
-
-	if (sizeof(ext) > 1) {
-		i = strlen(argv[0]) - strlen(ext);
-		if (i > 0 && !strcmp(argv[0] + i, ext)) {
-			char *argv0 = xstrdup(argv[0]);
-			argv[0] = cmd = argv0;
-			argv0[i] = '\0';
-		}
-	}
-
-	/* Turn "git cmd --help" into "git help cmd" */
-	if (argc > 1 && !strcmp(argv[1], "--help")) {
-		argv[1] = argv[0];
-		argv[0] = cmd = "help";
-	}
-
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
-		if (strcmp(p->cmd, cmd))
-			continue;
-		exit(run_builtin(p, argc, argv));
-	}
-}
-
 static void execv_dashed_external(const char **argv)
 {
 	struct strbuf cmd = STRBUF_INIT;
-- 
1.8.3-mingw-1
