From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH-v2 1/4] git-commit: support variable number of hook arguments
Date: Tue,  5 Feb 2008 11:01:44 +0100
Message-ID: <1202205704-10024-1-git-send-email-bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 11:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMLPE-0003nW-Co
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbYBEKvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbYBEKvZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:51:25 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:36287 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbYBEKvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:51:24 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JMLOd-0001xQ-Cc
	for git@vger.kernel.org; Tue, 05 Feb 2008 05:51:23 -0500
X-Mailer: git-send-email 1.5.4.1138.g882bc-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72644>

This is a preparatory patch to allow using run_hook for the
prepare-commit-msg hook.
---
 builtin-commit.c |   61 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 26 deletions(-)

	Compared to the previous submission, this one includes the
	range check.

diff --git a/builtin-commit.c b/builtin-commit.c
index 2ffca40..405c8b5 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -343,6 +343,40 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	return s.commitable;
 }
 
+static int run_hook(const char *index_file, const char *name, ...)
+{
+	struct child_process hook;
+	const char *argv[10], *env[2];
+	char index[PATH_MAX];
+	va_list args;
+	int i;
+
+	va_start(args, name);
+	argv[0] = git_path("hooks/%s", name);
+	i = 0;
+	do {
+		if (++i >= ARRAY_SIZE(argv))
+			die ("run_hook(): too many arguments");
+		argv[i] = va_arg(args, const char *);
+	} while (argv[i]);
+	va_end(args);
+
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+	env[0] = index;
+	env[1] = NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv = argv;
+	hook.no_stdin = 1;
+	hook.stdout_to_stderr = 1;
+	hook.env = env;
+
+	return run_command(&hook);
+}
+
 static const char sign_off_header[] = "Signed-off-by: ";
 
 static int prepare_log_message(const char *index_file, const char *prefix)
@@ -677,31 +711,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return commitable ? 0 : 1;
 }
 
-static int run_hook(const char *index_file, const char *name, const char *arg)
-{
-	struct child_process hook;
-	const char *argv[3], *env[2];
-	char index[PATH_MAX];
-
-	argv[0] = git_path("hooks/%s", name);
-	argv[1] = arg;
-	argv[2] = NULL;
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-	env[0] = index;
-	env[1] = NULL;
-
-	if (access(argv[0], X_OK) < 0)
-		return 0;
-
-	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.env = env;
-
-	return run_command(&hook);
-}
-
 static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
@@ -876,7 +885,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		launch_editor(git_path(commit_editmsg), NULL, env);
 	}
 	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
+	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
 		rollback_index_files();
 		exit(1);
 	}
-- 
1.5.3.4.910.gc5122-dirty
