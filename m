From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 3/4] Speed up is_git_command() by checking early for internal
 commands
Date: Thu, 02 Jan 2014 17:17:11 +0100
Message-ID: <52C59107.6080005@gmail.com>
References: <52C58FD7.6010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 17:17:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VykxY-00082o-Rf
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 17:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbaABQRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 11:17:21 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:34088 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaABQRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 11:17:20 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so4547847bkz.25
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=14CV6bxNgpe5YCYaq47rCEBUB6DDkqxkl9CCQDOs4R4=;
        b=E0Er2AkiD1tQsHk0W1K9v/nMqiLPVa8mwpZuls0DvLQEl+by1YCAcQXv2+B+4UagH3
         6FEXK+CKnS02px9AQJjX9wexykgXBNTxOnSNwrjKs1APhLjLz1Xbos4LfCLLEXX3sail
         zcH7ZKxP1GglVsK22jcF12cX6yKjStLQDT96RBl7t12gflO0AwUKf+/NOyN4N8C0mTEG
         pb2yirPmrsaeBePsBqxQ+1LL2k/RRYf7x2WN7beVosmdnmkIlj6OEZxp0pyUV3Vo+J2u
         /3noqeqkBcB7DyR6gfyM6X2A6RNw+m5voANbTWmXVV/1rA9JnbZrJUY7m5/DCtQTJ75G
         j5iQ==
X-Received: by 10.205.20.132 with SMTP id qo4mr66051bkb.110.1388679438593;
        Thu, 02 Jan 2014 08:17:18 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id bf8sm43511732bkb.14.2014.01.02.08.17.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 08:17:17 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <52C58FD7.6010608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239856>

Since 2dce956 is_git_command() is a bit slow as it does file I/O in the
call to list_commands_in_dir(). Avoid the file I/O by adding an early
check for internal commands.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/technical/api-builtin.txt |   4 +-
 builtin.h                               |   2 +
 builtin/help.c                          |   3 +
 git.c                                   | 242 +++++++++++++++++---------------
 4 files changed, 134 insertions(+), 117 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 150a02a..e3d6e7a 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -14,8 +14,8 @@ Git:
 
 . Add the external declaration for the function to `builtin.h`.
 
-. Add the command to `commands[]` table in `handle_builtin()`,
-  defined in `git.c`.  The entry should look like:
+. Add the command to the `commands[]` table defined in `git.c`.
+  The entry should look like:
 
 	{ "foo", cmd_foo, <options> },
 +
diff --git a/builtin.h b/builtin.h
index d4afbfe..c47c110 100644
--- a/builtin.h
+++ b/builtin.h
@@ -27,6 +27,8 @@ extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
+extern int is_builtin(const char *s);
+
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/builtin/help.c b/builtin/help.c
index b6fc15e..1fdefeb 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -288,6 +288,9 @@ static struct cmdnames main_cmds, other_cmds;
 
 static int is_git_command(const char *s)
 {
+	if (is_builtin(s))
+		return 1;
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 	return is_in_cmdlist(&main_cmds, s) ||
 		is_in_cmdlist(&other_cmds, s);
diff --git a/git.c b/git.c
index 89ab5d7..bba4378 100644
--- a/git.c
+++ b/git.c
@@ -332,124 +332,136 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
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
 static void handle_builtin(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
-	static struct cmd_struct commands[] = {
-		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-		{ "archive", cmd_archive },
-		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
-		{ "blame", cmd_blame, RUN_SETUP },
-		{ "branch", cmd_branch, RUN_SETUP },
-		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
-		{ "cat-file", cmd_cat_file, RUN_SETUP },
-		{ "check-attr", cmd_check_attr, RUN_SETUP },
-		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
-		{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-		{ "check-ref-format", cmd_check_ref_format },
-		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
-		{ "checkout-index", cmd_checkout_index,
-			RUN_SETUP | NEED_WORK_TREE},
-		{ "cherry", cmd_cherry, RUN_SETUP },
-		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
-		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-		{ "clone", cmd_clone },
-		{ "column", cmd_column, RUN_SETUP_GENTLY },
-		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
-		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config, RUN_SETUP_GENTLY },
-		{ "count-objects", cmd_count_objects, RUN_SETUP },
-		{ "credential", cmd_credential, RUN_SETUP_GENTLY },
-		{ "describe", cmd_describe, RUN_SETUP },
-		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-		{ "diff-index", cmd_diff_index, RUN_SETUP },
-		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
-		{ "fast-export", cmd_fast_export, RUN_SETUP },
-		{ "fetch", cmd_fetch, RUN_SETUP },
-		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
-		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
-		{ "format-patch", cmd_format_patch, RUN_SETUP },
-		{ "fsck", cmd_fsck, RUN_SETUP },
-		{ "fsck-objects", cmd_fsck, RUN_SETUP },
-		{ "gc", cmd_gc, RUN_SETUP },
-		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-		{ "hash-object", cmd_hash_object },
-		{ "help", cmd_help },
-		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
-		{ "init", cmd_init_db },
-		{ "init-db", cmd_init_db },
-		{ "log", cmd_log, RUN_SETUP },
-		{ "ls-files", cmd_ls_files, RUN_SETUP },
-		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
-		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-		{ "mailinfo", cmd_mailinfo },
-		{ "mailsplit", cmd_mailsplit },
-		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-base", cmd_merge_base, RUN_SETUP },
-		{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
-		{ "merge-index", cmd_merge_index, RUN_SETUP },
-		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-tree", cmd_merge_tree, RUN_SETUP },
-		{ "mktag", cmd_mktag, RUN_SETUP },
-		{ "mktree", cmd_mktree, RUN_SETUP },
-		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-		{ "name-rev", cmd_name_rev, RUN_SETUP },
-		{ "notes", cmd_notes, RUN_SETUP },
-		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
-		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-		{ "patch-id", cmd_patch_id },
-		{ "pickaxe", cmd_blame, RUN_SETUP },
-		{ "prune", cmd_prune, RUN_SETUP },
-		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-		{ "push", cmd_push, RUN_SETUP },
-		{ "read-tree", cmd_read_tree, RUN_SETUP },
-		{ "receive-pack", cmd_receive_pack },
-		{ "reflog", cmd_reflog, RUN_SETUP },
-		{ "remote", cmd_remote, RUN_SETUP },
-		{ "remote-ext", cmd_remote_ext },
-		{ "remote-fd", cmd_remote_fd },
-		{ "repack", cmd_repack, RUN_SETUP },
-		{ "replace", cmd_replace, RUN_SETUP },
-		{ "rerere", cmd_rerere, RUN_SETUP },
-		{ "reset", cmd_reset, RUN_SETUP },
-		{ "rev-list", cmd_rev_list, RUN_SETUP },
-		{ "rev-parse", cmd_rev_parse },
-		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-		{ "rm", cmd_rm, RUN_SETUP },
-		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
-		{ "show", cmd_show, RUN_SETUP },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
-		{ "show-ref", cmd_show_ref, RUN_SETUP },
-		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
-		{ "stripspace", cmd_stripspace },
-		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-		{ "tag", cmd_tag, RUN_SETUP },
-		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
-		{ "update-index", cmd_update_index, RUN_SETUP },
-		{ "update-ref", cmd_update_ref, RUN_SETUP },
-		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
-		{ "upload-archive", cmd_upload_archive },
-		{ "upload-archive--writer", cmd_upload_archive_writer },
-		{ "var", cmd_var, RUN_SETUP_GENTLY },
-		{ "verify-pack", cmd_verify_pack },
-		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
-		{ "version", cmd_version },
-		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
-		{ "write-tree", cmd_write_tree, RUN_SETUP },
-	};
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
 
-- 
1.8.3-mingw-1
