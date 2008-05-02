From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 02:09:30 -0400
Message-ID: <20080502060930.GA1079@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 02 08:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JroTM-00081g-6V
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 08:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbYEBGJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 02:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYEBGJd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 02:09:33 -0400
Received: from peff.net ([208.65.91.99]:4467 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbYEBGJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 02:09:31 -0400
Received: (qmail 5156 invoked by uid 111); 2 May 2008 06:09:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 02:09:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 02:09:30 -0400
Content-Disposition: inline
In-Reply-To: <20080502054508.GA28506@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80962>

On Fri, May 02, 2008 at 01:45:08AM -0400, Jeff King wrote:

> I agree with you; I don't like it at all. Probably whether or not to use
> a pager for a given command should be controlled by a "pager.<cmd>"
> config variable.

Here is a quick and dirty patch to do that. It should probably be split
into two (there is a big code movement of the commands array), and it
needs documentation and tests. But I'm going to sleep for now.

diff --git a/git.c b/git.c
index 89b431f..ffb2650 100644
--- a/git.c
+++ b/git.c
@@ -6,6 +6,8 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
+int git_wrapper_config(const char *, const char *);
+
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
@@ -239,6 +241,7 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	if (p->option & RUN_SETUP)
 		prefix = setup_git_directory();
+	git_config(git_wrapper_config);
 	if (p->option & USE_PAGER)
 		setup_pager();
 	if (p->option & NEED_WORK_TREE)
@@ -267,103 +270,103 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
+static struct cmd_struct commands[] = {
+	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "annotate", cmd_annotate, RUN_SETUP },
+	{ "apply", cmd_apply },
+	{ "archive", cmd_archive },
+	{ "blame", cmd_blame, RUN_SETUP },
+	{ "branch", cmd_branch, RUN_SETUP },
+	{ "bundle", cmd_bundle },
+	{ "cat-file", cmd_cat_file, RUN_SETUP },
+	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE },
+	{ "check-ref-format", cmd_check_ref_format },
+	{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
+	{ "cherry", cmd_cherry, RUN_SETUP },
+	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
+	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
+	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+	{ "config", cmd_config },
+	{ "count-objects", cmd_count_objects, RUN_SETUP },
+	{ "describe", cmd_describe, RUN_SETUP },
+	{ "diff", cmd_diff },
+	{ "diff-files", cmd_diff_files },
+	{ "diff-index", cmd_diff_index, RUN_SETUP },
+	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	{ "fast-export", cmd_fast_export, RUN_SETUP },
+	{ "fetch", cmd_fetch, RUN_SETUP },
+	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+	{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
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
+	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
+	{ "ls-remote", cmd_ls_remote },
+	{ "mailinfo", cmd_mailinfo },
+	{ "mailsplit", cmd_mailsplit },
+	{ "merge-base", cmd_merge_base, RUN_SETUP },
+	{ "merge-file", cmd_merge_file },
+	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
+	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
+	{ "name-rev", cmd_name_rev, RUN_SETUP },
+	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+	{ "peek-remote", cmd_ls_remote },
+	{ "pickaxe", cmd_blame, RUN_SETUP },
+	{ "prune", cmd_prune, RUN_SETUP },
+	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "push", cmd_push, RUN_SETUP },
+	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "reflog", cmd_reflog, RUN_SETUP },
+	{ "remote", cmd_remote, RUN_SETUP },
+	{ "repo-config", cmd_config },
+	{ "rerere", cmd_rerere, RUN_SETUP },
+	{ "reset", cmd_reset, RUN_SETUP },
+	{ "rev-list", cmd_rev_list, RUN_SETUP },
+	{ "rev-parse", cmd_rev_parse },
+	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+	{ "rm", cmd_rm, RUN_SETUP },
+	{ "send-pack", cmd_send_pack, RUN_SETUP },
+	{ "shortlog", cmd_shortlog, USE_PAGER },
+	{ "show-branch", cmd_show_branch, RUN_SETUP },
+	{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE | USE_PAGER },
+	{ "stripspace", cmd_stripspace },
+	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
+	{ "tag", cmd_tag, RUN_SETUP },
+	{ "tar-tree", cmd_tar_tree },
+	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
+	{ "update-index", cmd_update_index, RUN_SETUP },
+	{ "update-ref", cmd_update_ref, RUN_SETUP },
+	{ "upload-archive", cmd_upload_archive },
+	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
+	{ "version", cmd_version },
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
+	{ "write-tree", cmd_write_tree, RUN_SETUP },
+	{ "verify-pack", cmd_verify_pack },
+	{ "show-ref", cmd_show_ref, RUN_SETUP },
+	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+};
+
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
-		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
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
-		{ "fast-export", cmd_fast_export, RUN_SETUP },
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
-		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
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
-		{ "remote", cmd_remote, RUN_SETUP },
-		{ "repo-config", cmd_config },
-		{ "rerere", cmd_rerere, RUN_SETUP },
-		{ "reset", cmd_reset, RUN_SETUP },
-		{ "rev-list", cmd_rev_list, RUN_SETUP },
-		{ "rev-parse", cmd_rev_parse },
-		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-		{ "rm", cmd_rm, RUN_SETUP },
-		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, USE_PAGER },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
-		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE | USE_PAGER },
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
 	int i;
 
 	/* Turn "git cmd --help" into "git help cmd" */
@@ -380,6 +383,31 @@ static void handle_internal_command(int argc, const char **argv)
 	}
 }
 
+void set_command_pager(const char *cmd, int use_pager)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		struct cmd_struct *p = commands+i;
+		if (!strcmp(p->cmd, cmd)) {
+			if (use_pager)
+				p->option |= USE_PAGER;
+			else
+				p->option &= ~USE_PAGER;
+			return;
+		}
+	}
+}
+
+int git_wrapper_config(const char *var, const char *value)
+{
+	if (!prefixcmp(var, "pager.")) {
+		set_command_pager(var + 6, git_config_bool(var, value));
+		return 0;
+	}
+
+	return 0;
+}
+
 int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
