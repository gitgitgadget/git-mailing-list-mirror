From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/4] git-commit: support variable number of hook arguments
Date: Mon, 21 Jan 2008 15:02:48 +0100
Message-ID: <2885c7896ba72adee6bc5c9e2210a8881904f601.1200933409.git.bonzini@gnu.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM0KU-0006Pl-5W
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbYBDMUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 07:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbYBDMUt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 07:20:49 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:42347 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbYBDMUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 07:20:45 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JM0JW-0007o4-EE
	for git@vger.kernel.org; Mon, 04 Feb 2008 07:20:42 -0500
In-Reply-To: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72495>

This is a preparatory patch to allow using run_hook for the
prepare-commit-msg hook.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>

---
 builtin-commit.c |   59 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0227936..fc59660 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -339,6 +339,38 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
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
+		argv[++i] = va_arg(args, const char *);
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
@@ -673,31 +705,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
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
@@ -872,7 +879,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		launch_editor(git_path(commit_editmsg), NULL, env);
 	}
 	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
+	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
 		rollback_index_files();
 		exit(1);
 	}
