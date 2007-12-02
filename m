From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REPLACEMENT PATCH 3/3] Introduce execv_git_builtin() and use it
Date: Sun, 2 Dec 2007 03:16:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712020310470.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712010959180.27959@racer.site> <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712012300440.27959@racer.site> <Pine.LNX.4.64.0712012314190.27959@racer.site>
 <Pine.LNX.4.64.0712020146240.27959@racer.site> <Pine.LNX.4.64.0712020254540.27959@racer.site>
 <Pine.LNX.4.64.0712020303190.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 04:17:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyfKG-0002ls-L4
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 04:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbXLBDQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 22:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbXLBDQh
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 22:16:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:58803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753683AbXLBDQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 22:16:36 -0500
Received: (qmail invoked by alias); 02 Dec 2007 03:16:34 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp030) with SMTP; 02 Dec 2007 04:16:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AWLEbGYaAxFKPBmPh7T6G+f2kuT2ClhXpL9Cood
	zqh6z5G8/PFrKR
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712020303190.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66753>


You can call execv_git_builtin() to execute a builtin command.  This 
function is a reborn handle_internal_command() from git.c, and has the 
semantics of execv_git_cmd(), i.e. it exits with the exit code of the 
builtin if there is a matching builtin, but it avoids the real execvp() 
call.

This function calls release_all_objects() and discard_cache() to start 
from a clean slate (this, along with the calculation of argc, is the only 
difference from a straight code move).

The test suite passes, which at least does not contradict the hypothesis 
that this is good enough.  However, it might be necessary to de-initialize 
more global variables.

The function execv_git_cmd() and git.c's main() function were changed to 
take advantage of execv_git_builtin().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 2 Dec 2007, Johannes Schindelin wrote:

	> Hi,
	> 
	> On Sun, 2 Dec 2007, Johannes Schindelin wrote:
	> 
	> > +		{ "fmt", cmd_fmt },
	> 
	> Ah, well.  This slipped in by mistake.  Will resend in a few 
	> minutes.

	Here we go.

 exec_cmd.c |  176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 exec_cmd.h |    1 +
 git.c      |  170 +---------------------------------------------------------
 3 files changed, 178 insertions(+), 169 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..745b951 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "quote.h"
+#include "builtin.h"
+#include "object.h"
 #define MAX_ARGS	32
 
 extern char **environ;
@@ -63,11 +65,185 @@ void setup_path(const char *cmd_path)
 	strbuf_release(&new_path);
 }
 
+const char git_usage_string[] =
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+
+const char git_version_string[] = GIT_VERSION;
+
+#define RUN_SETUP	(1<<0)
+#define USE_PAGER	(1<<1)
+/*
+ * require working tree to be present -- anything uses this needs
+ * RUN_SETUP for reading from the configuration file.
+ */
+#define NEED_WORK_TREE	(1<<2)
+
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+	int option;
+};
+
+static int run_command(struct cmd_struct *p, int argc, const char **argv)
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
+int execv_git_builtin(const char **argv)
+{
+	const char *cmd = argv[0];
+	static struct cmd_struct commands[] = {
+		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+		{ "annotate", cmd_annotate, RUN_SETUP },
+		{ "apply", cmd_apply },
+		{ "archive", cmd_archive },
+		{ "blame", cmd_blame, RUN_SETUP },
+		{ "branch", cmd_branch, RUN_SETUP },
+		{ "bundle", cmd_bundle },
+		{ "cat-file", cmd_cat_file, RUN_SETUP },
+		{ "checkout-index", cmd_checkout_index,
+			RUN_SETUP | NEED_WORK_TREE},
+		{ "check-ref-format", cmd_check_ref_format },
+		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
+		{ "cherry", cmd_cherry, RUN_SETUP },
+		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
+		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
+		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+		{ "config", cmd_config },
+		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "describe", cmd_describe, RUN_SETUP },
+		{ "diff", cmd_diff },
+		{ "diff-files", cmd_diff_files },
+		{ "diff-index", cmd_diff_index, RUN_SETUP },
+		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+		{ "fetch", cmd_fetch, RUN_SETUP },
+		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
+		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
+		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
+		{ "format-patch", cmd_format_patch, RUN_SETUP },
+		{ "fsck", cmd_fsck, RUN_SETUP },
+		{ "fsck-objects", cmd_fsck, RUN_SETUP },
+		{ "gc", cmd_gc, RUN_SETUP },
+		{ "get-tar-commit-id", cmd_get_tar_commit_id },
+		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
+		{ "help", cmd_help },
+#ifndef NO_CURL
+		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
+#endif
+		{ "init", cmd_init_db },
+		{ "init-db", cmd_init_db },
+		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
+		{ "ls-files", cmd_ls_files, RUN_SETUP },
+		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
+		{ "ls-remote", cmd_ls_remote },
+		{ "mailinfo", cmd_mailinfo },
+		{ "mailsplit", cmd_mailsplit },
+		{ "merge-base", cmd_merge_base, RUN_SETUP },
+		{ "merge-file", cmd_merge_file },
+		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
+		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
+		{ "name-rev", cmd_name_rev, RUN_SETUP },
+		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+		{ "peek-remote", cmd_ls_remote },
+		{ "pickaxe", cmd_blame, RUN_SETUP },
+		{ "prune", cmd_prune, RUN_SETUP },
+		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+		{ "push", cmd_push, RUN_SETUP },
+		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "reflog", cmd_reflog, RUN_SETUP },
+		{ "repo-config", cmd_config },
+		{ "rerere", cmd_rerere, RUN_SETUP },
+		{ "reset", cmd_reset, RUN_SETUP },
+		{ "rev-list", cmd_rev_list, RUN_SETUP },
+		{ "rev-parse", cmd_rev_parse },
+		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+		{ "rm", cmd_rm, RUN_SETUP },
+		{ "send-pack", cmd_send_pack, RUN_SETUP },
+		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
+		{ "show-branch", cmd_show_branch, RUN_SETUP },
+		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
+		{ "stripspace", cmd_stripspace },
+		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
+		{ "tag", cmd_tag, RUN_SETUP },
+		{ "tar-tree", cmd_tar_tree },
+		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
+		{ "update-index", cmd_update_index, RUN_SETUP },
+		{ "update-ref", cmd_update_ref, RUN_SETUP },
+		{ "upload-archive", cmd_upload_archive },
+		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
+		{ "version", cmd_version },
+		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
+		{ "write-tree", cmd_write_tree, RUN_SETUP },
+		{ "verify-pack", cmd_verify_pack },
+		{ "show-ref", cmd_show_ref, RUN_SETUP },
+		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+	};
+	int i;
+
+	/* Turn "git cmd --help" into "git help cmd" */
+	if (argv[0] && argv[1] && !strcmp(argv[1], "--help")) {
+		argv[1] = argv[0];
+		argv[0] = cmd = "help";
+	}
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		int argc;
+		struct cmd_struct *p = commands+i;
+		if (strcmp(p->cmd, cmd))
+			continue;
+		release_all_objects();
+		discard_cache();
+		for (argc = 0; argv[argc]; argc++)
+			; /* do nothing */
+		exit(run_command(p, argc, argv));
+	}
+	return -1;
+}
+
 int execv_git_cmd(const char **argv)
 {
 	struct strbuf cmd;
 	const char *tmp;
 
+	/* Try builtin first... */
+	execv_git_builtin(argv);
+
+	/* ... and then external commands */
 	strbuf_init(&cmd, 0);
 	strbuf_addf(&cmd, "git-%s", argv[0]);
 
diff --git a/exec_cmd.h b/exec_cmd.h
index a892355..bb15425 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -4,6 +4,7 @@
 extern void git_set_argv_exec_path(const char *exec_path);
 extern const char* git_exec_path(void);
 extern void setup_path(const char *);
+extern int execv_git_builtin(const char **argv); /* NULL terminated */
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 
diff --git a/git.c b/git.c
index 95296aa..1523c4a 100644
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
@@ -231,167 +228,6 @@ static int handle_alias(int *argcp, const char ***argv)
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
-static void handle_internal_command(int argc, const char **argv)
-{
-	const char *cmd = argv[0];
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
-		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
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
-		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
-		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
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
-		exit(run_command(p, argc, argv));
-	}
-}
-
 int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
@@ -423,7 +259,7 @@ int main(int argc, const char **argv)
 	if (!prefixcmp(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_internal_command(argc, argv);
+		execv_git_builtin(argv);
 		die("cannot handle %s internally", cmd);
 	}
 
@@ -451,10 +287,6 @@ int main(int argc, const char **argv)
 	setup_path(cmd_path);
 
 	while (1) {
-		/* See if it's an internal command */
-		handle_internal_command(argc, argv);
-
-		/* .. then try the external ones */
 		execv_git_cmd(argv);
 
 		/* It could be an alias -- this works around the insanity
-- 
1.5.3.6.2112.ge2263
