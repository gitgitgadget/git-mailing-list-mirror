From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2/6] commit --amend: invoke post-rewrite hook
Date: Sun, 14 Feb 2010 17:17:07 +0100
Message-ID: <f2a61f3f01c39bb20de020d2e7454417624e4d23.1266164150.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngh9t-0003AW-P7
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab0BNQRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:17 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:37742 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab0BNQRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:15 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:14 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:12 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139918>

The rough structure of run_rewrite_hook() comes from
run_receive_hook() in receive-pack.

We introduce a --no-post-rewrite option and use it to avoid the hook
when called from git-rebase -i 'edit'.  The next patch will add full
support in git-rebase, and we only want to invoke the hook once.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-commit.c             |   43 ++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh   |    2 +-
 t/t5407-post-rewrite-hook.sh |   52 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh

diff --git a/builtin-commit.c b/builtin-commit.c
index 55676fd..9b67649 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -66,6 +66,7 @@
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int no_post_rewrite;
 static char *untracked_files_arg, *force_date;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -137,6 +138,7 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('z', "null", &null_termination,
 		    "terminate entries with NUL"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
+	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	/* end commit contents options */
@@ -1160,6 +1162,40 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
+static const char post_rewrite_hook[] = "hooks/post-rewrite";
+
+static int run_rewrite_hook(const unsigned char *oldsha1,
+			    const unsigned char *newsha1)
+{
+	/* oldsha1 SP newsha1 LF NUL */
+	static char buf[2*40 + 3];
+	struct child_process proc;
+	const char *argv[3];
+	int code;
+	size_t n;
+
+	if (access(git_path(post_rewrite_hook), X_OK) < 0)
+		return 0;
+
+	argv[0] = git_path(post_rewrite_hook);
+	argv[1] = "amend";
+	argv[2] = NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+
+	code = start_command(&proc);
+	if (code)
+		return code;
+	n = snprintf(buf, sizeof(buf), "%s %s\n",
+		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	write_in_full(proc.in, buf, n);
+	close(proc.in);
+	return finish_command(&proc);
+}
+
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -1303,6 +1339,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
+	if (amend && !no_post_rewrite) {
+		struct commit *commit;
+		commit = lookup_commit(head_sha1);
+		if (!commit || parse_commit(commit))
+			die("HEAD commit disappeared right under my eyes?");
+		run_rewrite_hook(commit->object.sha1, commit_sha1);
+	}
 	if (!quiet)
 		print_summary(prefix, commit_sha1);
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..5735859 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -445,7 +445,7 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		git commit --amend
+		git commit --amend --no-post-rewrite
 		;;
 	edit|e)
 		comment_for_reflog edit
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
new file mode 100755
index 0000000..1020af9
--- /dev/null
+++ b/t/t5407-post-rewrite-hook.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Thomas Rast
+#
+
+test_description='Test the post-rewrite hook.'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A foo A &&
+	test_commit B foo B &&
+	test_commit C foo C &&
+	test_commit D foo D
+'
+
+mkdir .git/hooks
+
+cat >.git/hooks/post-rewrite <<EOF
+#!/bin/sh
+echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
+cat > "$TRASH_DIRECTORY"/post-rewrite.data
+EOF
+chmod u+x .git/hooks/post-rewrite
+
+clear_hook_input () {
+	rm -f post-rewrite.args post-rewrite.data
+}
+
+verify_hook_input () {
+	test_cmp "$TRASH_DIRECTORY"/post-rewrite.args expected.args &&
+	test_cmp "$TRASH_DIRECTORY"/post-rewrite.data expected.data
+}
+
+test_expect_success 'git commit --amend' '
+	clear_hook_input &&
+	echo "D new message" > newmsg &&
+	oldsha=$(git rev-parse HEAD^0) &&
+	git commit -Fnewmsg --amend &&
+	echo amend > expected.args &&
+	echo $oldsha $(git rev-parse HEAD^0) > expected.data &&
+	verify_hook_input
+'
+
+test_expect_success 'git commit --amend --no-post-rewrite' '
+	clear_hook_input &&
+	echo "D new message again" > newmsg &&
+	git commit --no-post-rewrite -Fnewmsg --amend &&
+	test ! -f post-rewrite.args &&
+	test ! -f post-rewrite.data
+'
+
+test_done
-- 
1.7.0.216.g74d8e
