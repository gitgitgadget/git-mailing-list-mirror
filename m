From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] Avoid double exec() in execv_git_cmd()
Date: Sat,  1 Dec 2007 23:03:24 -0800
Message-ID: <1196579005-5662-2-git-send-email-gitster@pobox.com>
References: <1196579005-5662-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 08:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyirn-0005zf-6M
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 08:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXLBHDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 02:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbXLBHDe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 02:03:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56661 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbXLBHDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 02:03:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id ACB092F0
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:03:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E9B89A0F0
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:03:51 -0500 (EST)
X-Mailer: git-send-email 1.5.3.6.2090.g4ece0
In-Reply-To: <1196579005-5662-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66764>

This avoids double exec() when execv_git_cmd() is used to spawn an
external git command.

For this, execv_git_cmd() needs to be able to tell what's built-in.
This is done by introducing a new function git_builtin_command() that
checks the list of built-in commands and returns a pointer to the
cmd_struct if found.  The same function is used from the git potty.

This unfortunately pulls all built-in functions to libgit.a, so any
external command that happens to link with exec_cmd.o will need to pull
them in.  I am not sure if that is worth it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile   |    7 +-
 exec_cmd.c |  208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 exec_cmd.h |    8 ++
 git.c      |  155 +-------------------------------------------
 4 files changed, 210 insertions(+), 168 deletions(-)

diff --git a/Makefile b/Makefile
index a7e44a3..6907954 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,8 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
+		-DGIT_VERSION='"$(GIT_VERSION)"' '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
@@ -923,8 +924,8 @@ $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o builtin-runstatus.o wt-status.o: wt-status.h
 
-$(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
+$(LIB_FILE): $(LIB_OBJS) $(BUILTIN_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS) $(BUILTIN_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o
diff --git a/exec_cmd.c b/exec_cmd.c
index 10b2908..db61540 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "exec_cmd.h"
 #include "quote.h"
@@ -63,27 +64,206 @@ void setup_path(const char *cmd_path)
 	strbuf_release(&new_path);
 }
 
+#define RUN_SETUP	(1<<0)
+#define USE_PAGER	(1<<1)
+/*
+ * require working tree to be present -- anything uses this needs
+ * RUN_SETUP for reading from the configuration file.
+ */
+#define NEED_WORK_TREE	(1<<2)
+
+const char git_version_string[] = GIT_VERSION;
+const char git_usage_string[] =
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+
+int run_builtin_command(struct cmd_struct *p, int argc, const char **argv)
+{
+	int status;
+	struct stat st;
+	const char *prefix;
+
+	prefix = NULL;
+	if (p->option & RUN_SETUP)
+		prefix = setup_git_directory();
+	if (p->option & USE_PAGER)
+		setup_pager();
+	if (p->option & NEED_WORK_TREE)
+		setup_work_tree();
+
+	trace_argv_printf(argv, argc, "trace: built-in: git");
+
+	status = p->fn(argc, argv, prefix);
+	if (status)
+		return status & 0xff;
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
+		die("write failure on standard output: %s", strerror(errno));
+	if (ferror(stdout))
+		die("unknown write failure on standard output");
+	if (fclose(stdout))
+		die("close failed on standard output: %s", strerror(errno));
+	return 0;
+}
+
+static struct cmd_struct builtin_command[] = {
+	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "annotate", cmd_annotate, RUN_SETUP },
+	{ "apply", cmd_apply },
+	{ "archive", cmd_archive },
+	{ "blame", cmd_blame, RUN_SETUP },
+	{ "branch", cmd_branch, RUN_SETUP },
+	{ "bundle", cmd_bundle },
+	{ "cat-file", cmd_cat_file, RUN_SETUP },
+	{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
+	{ "check-ref-format", cmd_check_ref_format },
+	{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE},
+	{ "cherry", cmd_cherry, RUN_SETUP },
+	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
+	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+	{ "config", cmd_config },
+	{ "count-objects", cmd_count_objects, RUN_SETUP },
+	{ "describe", cmd_describe, RUN_SETUP },
+	{ "diff", cmd_diff },
+	{ "diff-files", cmd_diff_files },
+	{ "diff-index", cmd_diff_index, RUN_SETUP },
+	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	{ "fetch", cmd_fetch, RUN_SETUP },
+	{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
+	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
+	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
+	{ "format-patch", cmd_format_patch, RUN_SETUP },
+	{ "fsck", cmd_fsck, RUN_SETUP },
+	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "gc", cmd_gc, RUN_SETUP },
+	{ "get-tar-commit-id", cmd_get_tar_commit_id },
+	{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
+	{ "help", cmd_help },
+#ifndef NO_CURL
+	{ "http-fetch", cmd_http_fetch, RUN_SETUP },
+#endif
+	{ "init", cmd_init_db },
+	{ "init-db", cmd_init_db },
+	{ "log", cmd_log, RUN_SETUP | USE_PAGER },
+	{ "ls-files", cmd_ls_files, RUN_SETUP },
+	{ "ls-remote", cmd_ls_remote },
+	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
+	{ "mailinfo", cmd_mailinfo },
+	{ "mailsplit", cmd_mailsplit },
+	{ "merge-base", cmd_merge_base, RUN_SETUP },
+	{ "merge-file", cmd_merge_file },
+	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
+	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
+	{ "name-rev", cmd_name_rev, RUN_SETUP },
+	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+	{ "peek-remote", cmd_ls_remote },
+	{ "pickaxe", cmd_blame, RUN_SETUP },
+	{ "prune", cmd_prune, RUN_SETUP },
+	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "push", cmd_push, RUN_SETUP },
+	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "reflog", cmd_reflog, RUN_SETUP },
+	{ "repo-config", cmd_config },
+	{ "rerere", cmd_rerere, RUN_SETUP },
+	{ "reset", cmd_reset, RUN_SETUP },
+	{ "rev-list", cmd_rev_list, RUN_SETUP },
+	{ "rev-parse", cmd_rev_parse },
+	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+	{ "rm", cmd_rm, RUN_SETUP },
+	{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
+	{ "send-pack", cmd_send_pack, RUN_SETUP },
+	{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
+	{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+	{ "show-branch", cmd_show_branch, RUN_SETUP },
+	{ "show-ref", cmd_show_ref, RUN_SETUP },
+	{ "stripspace", cmd_stripspace },
+	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
+	{ "tag", cmd_tag, RUN_SETUP },
+	{ "tar-tree", cmd_tar_tree },
+	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
+	{ "update-index", cmd_update_index, RUN_SETUP },
+	{ "update-ref", cmd_update_ref, RUN_SETUP },
+	{ "upload-archive", cmd_upload_archive },
+	{ "verify-pack", cmd_verify_pack },
+	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
+	{ "version", cmd_version },
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
+	{ "write-tree", cmd_write_tree, RUN_SETUP },
+};
+
+struct cmd_struct *git_builtin_command(const char *name)
+{
+	unsigned int hi, lo;
+	lo = 0;
+	hi = ARRAY_SIZE(builtin_command);
+	do {
+		unsigned mi = (lo + hi) / 2;
+		int cmp = strcmp(builtin_command[mi].cmd, name);
+		if (!cmp)
+			return &builtin_command[mi];
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	} while (lo < hi);
+	return NULL;
+}
+
 int execv_git_cmd(const char **argv)
 {
-	int argc;
-	const char **nargv;
+	/*
+	 * We exec "git foo" for builtin commands, but exec "git-foo"
+	 * if "foo" is not a built-in, to avoid double exec overhead.
+	 */
+	if (!git_builtin_command(argv[0])) {
+		struct strbuf cmd;
+		const char *save;
+
+		strbuf_init(&cmd, 0);
+		strbuf_addf(&cmd, "git-%s", argv[0]);
 
-	for (argc = 0; argv[argc]; argc++)
-		; /* just counting */
-	nargv = xmalloc(sizeof(*nargv) * (argc + 2));
+		save = argv[0];
+		argv[0] = cmd.buf;
+		trace_argv_printf(argv, -1, "trace: exec:");
 
-	nargv[0] = "git";
-	for (argc = 0; argv[argc]; argc++)
-		nargv[argc + 1] = argv[argc];
-	nargv[argc + 1] = NULL;
-	trace_argv_printf(nargv, -1, "trace: exec:");
+		execvp(argv[0], (char **)argv);
 
-	/* execvp() can only ever return if it fails */
-	execvp("git", (char **)nargv);
+		trace_printf("trace: exec failed: %s\n", strerror(errno));
+		strbuf_release(&cmd);
+		argv[0] = save;
+	}
+	else {
+		int argc;
+		const char **nargv;
 
-	trace_printf("trace: exec failed: %s\n", strerror(errno));
+		for (argc = 0; argv[argc]; argc++)
+			; /* just counting */
+		nargv = xmalloc(sizeof(*nargv) * (argc + 2));
 
-	free(nargv);
+		nargv[0] = "git";
+		for (argc = 0; argv[argc]; argc++)
+			nargv[argc + 1] = argv[argc];
+		nargv[argc + 1] = NULL;
+
+		trace_argv_printf(nargv, -1, "trace: exec:");
+
+		/* execvp() can only ever return if it fails */
+		execvp("git", (char **)nargv);
+
+		trace_printf("trace: exec failed: %s\n", strerror(errno));
+
+		free(nargv);
+	}
 	return -1;
 }
 
diff --git a/exec_cmd.h b/exec_cmd.h
index a892355..184bc1d 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -7,5 +7,13 @@ extern void setup_path(const char *);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+	int option;
+};
+
+extern struct cmd_struct *git_builtin_command(const char *);
+extern int run_builtin_command(struct cmd_struct *p, int argc, const char **argv);
 
 #endif /* GIT_EXEC_CMD_H */
diff --git a/git.c b/git.c
index d690426..9d86f5c 100644
--- a/git.c
+++ b/git.c
@@ -3,9 +3,6 @@
 #include "cache.h"
 #include "quote.h"
 
-const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
-
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
@@ -222,151 +219,10 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-const char git_version_string[] = GIT_VERSION;
-
-#define RUN_SETUP	(1<<0)
-#define USE_PAGER	(1<<1)
-/*
- * require working tree to be present -- anything uses this needs
- * RUN_SETUP for reading from the configuration file.
- */
-#define NEED_WORK_TREE	(1<<2)
-
-struct cmd_struct {
-	const char *cmd;
-	int (*fn)(int, const char **, const char *);
-	int option;
-};
-
-static int run_command(struct cmd_struct *p, int argc, const char **argv)
-{
-	int status;
-	struct stat st;
-	const char *prefix;
-
-	prefix = NULL;
-	if (p->option & RUN_SETUP)
-		prefix = setup_git_directory();
-	if (p->option & USE_PAGER)
-		setup_pager();
-	if (p->option & NEED_WORK_TREE)
-		setup_work_tree();
-
-	trace_argv_printf(argv, argc, "trace: built-in: git");
-
-	status = p->fn(argc, argv, prefix);
-	if (status)
-		return status & 0xff;
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
-		die("write failure on standard output: %s", strerror(errno));
-	if (ferror(stdout))
-		die("unknown write failure on standard output");
-	if (fclose(stdout))
-		die("close failed on standard output: %s", strerror(errno));
-	return 0;
-}
-
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
-	static struct cmd_struct commands[] = {
-		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply },
-		{ "archive", cmd_archive },
-		{ "blame", cmd_blame, RUN_SETUP },
-		{ "branch", cmd_branch, RUN_SETUP },
-		{ "bundle", cmd_bundle },
-		{ "cat-file", cmd_cat_file, RUN_SETUP },
-		{ "checkout-index", cmd_checkout_index,
-			RUN_SETUP | NEED_WORK_TREE},
-		{ "check-ref-format", cmd_check_ref_format },
-		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
-		{ "cherry", cmd_cherry, RUN_SETUP },
-		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
-		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config },
-		{ "count-objects", cmd_count_objects, RUN_SETUP },
-		{ "describe", cmd_describe, RUN_SETUP },
-		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files },
-		{ "diff-index", cmd_diff_index, RUN_SETUP },
-		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
-		{ "fetch", cmd_fetch, RUN_SETUP },
-		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
-		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
-		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
-		{ "format-patch", cmd_format_patch, RUN_SETUP },
-		{ "fsck", cmd_fsck, RUN_SETUP },
-		{ "fsck-objects", cmd_fsck, RUN_SETUP },
-		{ "gc", cmd_gc, RUN_SETUP },
-		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
-		{ "help", cmd_help },
-#ifndef NO_CURL
-		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
-#endif
-		{ "init", cmd_init_db },
-		{ "init-db", cmd_init_db },
-		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
-		{ "ls-files", cmd_ls_files, RUN_SETUP },
-		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-		{ "ls-remote", cmd_ls_remote },
-		{ "mailinfo", cmd_mailinfo },
-		{ "mailsplit", cmd_mailsplit },
-		{ "merge-base", cmd_merge_base, RUN_SETUP },
-		{ "merge-file", cmd_merge_file },
-		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-		{ "name-rev", cmd_name_rev, RUN_SETUP },
-		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-		{ "peek-remote", cmd_ls_remote },
-		{ "pickaxe", cmd_blame, RUN_SETUP },
-		{ "prune", cmd_prune, RUN_SETUP },
-		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-		{ "push", cmd_push, RUN_SETUP },
-		{ "read-tree", cmd_read_tree, RUN_SETUP },
-		{ "reflog", cmd_reflog, RUN_SETUP },
-		{ "repo-config", cmd_config },
-		{ "rerere", cmd_rerere, RUN_SETUP },
-		{ "reset", cmd_reset, RUN_SETUP },
-		{ "rev-list", cmd_rev_list, RUN_SETUP },
-		{ "rev-parse", cmd_rev_parse },
-		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-		{ "rm", cmd_rm, RUN_SETUP },
-		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
-		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
-		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-		{ "stripspace", cmd_stripspace },
-		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-		{ "tag", cmd_tag, RUN_SETUP },
-		{ "tar-tree", cmd_tar_tree },
-		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
-		{ "update-index", cmd_update_index, RUN_SETUP },
-		{ "update-ref", cmd_update_ref, RUN_SETUP },
-		{ "upload-archive", cmd_upload_archive },
-		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
-		{ "version", cmd_version },
-		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
-		{ "write-tree", cmd_write_tree, RUN_SETUP },
-		{ "verify-pack", cmd_verify_pack },
-		{ "show-ref", cmd_show_ref, RUN_SETUP },
-		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-	};
-	int i;
+	struct cmd_struct *builtin;
 
 	/* Turn "git cmd --help" into "git help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
@@ -374,12 +230,9 @@ static void handle_internal_command(int argc, const char **argv)
 		argv[0] = cmd = "help";
 	}
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
-		if (strcmp(p->cmd, cmd))
-			continue;
-		exit(run_command(p, argc, argv));
-	}
+	builtin = git_builtin_command(cmd);
+	if (builtin)
+		exit(run_builtin_command(builtin, argc, argv));
 }
 
 static void execv_dashed_external(const char **argv)
-- 
1.5.3.6.2090.g4ece0
