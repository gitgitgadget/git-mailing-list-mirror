From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Tue, 27 Jun 2006 10:28:22 +0200
Message-ID: <20060627083508.E912A5BBAB@nox.op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 10:35:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv92R-00037k-FG
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWF0IfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWF0IfL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:35:11 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:62896 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751165AbWF0IfK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 04:35:10 -0400
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 283986BCF3
	for <git@vger.kernel.org>; Tue, 27 Jun 2006 10:35:09 +0200 (CEST)
Received: by nox.op5.se (Postfix, from userid 500)
	id E912A5BBAB; Tue, 27 Jun 2006 10:35:08 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22713>

Somewhere in the alias handling git turned hostile on fat fingers:

	$ git showbranch
	Failed to run command '': Is a directory

This patch fixes that by doing 2 things:
 * The variable git_command[MAX_PATH + 1] is now retired from
   git.c:main() where it was never set. Instead the variable "cmd"
   is used for all error messages.
 * The introduction of the "exec_errno" variable which preserves the
   errno number from the execve() attempt. Later "why did it fail"
   tests evaluate exec_errno, which gives the correct error message
   along with the brief command-list (telling me I missed the dash in
   "show-branch").

It's possible that alias handling can fail and set errno to something
proper, making this change less sane than I think, but handle_alias()
seems to take care of its own error-handling so it shouldn't matter.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 git.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 94e9a4a..b04424f 100644
--- a/git.c
+++ b/git.c
@@ -206,9 +206,8 @@ int main(int argc, const char **argv, ch
 {
 	const char *cmd = argv[0];
 	char *slash = strrchr(cmd, '/');
-	char git_command[PATH_MAX + 1];
 	const char *exec_path = NULL;
-	int done_alias = 0;
+	int exec_errno = 0, done_alias = 0;
 
 	/*
 	 * Take the basename of argv[0] as the command
@@ -300,6 +299,9 @@ int main(int argc, const char **argv, ch
 		/* .. then try the external ones */
 		execv_git_cmd(argv);
 
+		/* if it's not an alias, the execve() errno is what we want */
+		exec_errno = errno;
+
 		/* It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
@@ -309,11 +311,11 @@ int main(int argc, const char **argv, ch
 		done_alias = 1;
 	}
 
-	if (errno == ENOENT)
+	if (exec_errno == ENOENT)
 		cmd_usage(0, exec_path, "'%s' is not a git-command", cmd);
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
-		git_command, strerror(errno));
+		cmd, strerror(exec_errno));
 
 	return 1;
 }
-- 
1.4.1.rc1.g1ef9
