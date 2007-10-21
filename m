From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else
	fails.
Date: Sun, 21 Oct 2007 11:21:50 -0700
Message-ID: <20071021182150.GG16291@srparish.net>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 20:22:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjfRn-0002vL-Jk
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbXJUSWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 14:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXJUSWf
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 14:22:35 -0400
Received: from [208.70.128.56] ([208.70.128.56]:47805 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751816AbXJUSWe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2007 14:22:34 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjfQu-0003zZ-Vd; Sun, 21 Oct 2007 13:21:53 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 11:21:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710202258440.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61907>

Earlier, we tried to find the git commands in several possible exec
dirs.  Now, if all of these failed, try to find the git command in
PATH.

This allows you to install the git programs somewhere else than
originally specified when building git, as long as you add that location
to the PATH.

Implementation by Johannes Schindelin

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 exec_cmd.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..374ffc9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
 	int i;
 	const char *paths[] = { current_exec_path,
 				getenv(EXEC_PATH_ENVIRONMENT),
-				builtin_exec_path };
+				builtin_exec_path,
+				"" };
 
 	for (i = 0; i < ARRAY_SIZE(paths); ++i) {
 		size_t len;
@@ -44,9 +45,12 @@ int execv_git_cmd(const char **argv)
 		const char *exec_dir = paths[i];
 		const char *tmp;
 
-		if (!exec_dir || !*exec_dir) continue;
+		if (!exec_dir) continue;
 
-		if (*exec_dir != '/') {
+		if (!*exec_dir)
+			/* try PATH */
+			*git_command = '\0';
+		else if (*exec_dir != '/') {
 			if (!getcwd(git_command, sizeof(git_command))) {
 				fprintf(stderr, "git: cannot determine "
 					"current directory: %s\n",
@@ -81,7 +85,7 @@ int execv_git_cmd(const char **argv)
 
 		len = strlen(git_command);
 		rc = snprintf(git_command + len, sizeof(git_command) - len,
-			      "/git-%s", argv[0]);
+			      "%sgit-%s", *exec_dir ? "/" : "", argv[0]);
 		if (rc < 0 || rc >= sizeof(git_command) - len) {
 			fprintf(stderr,
 				"git: command name given is too long.\n");
@@ -99,8 +103,8 @@ int execv_git_cmd(const char **argv)
 
 		trace_argv_printf(argv, -1, "trace: exec:");
 
-		/* execve() can only ever return if it fails */
-		execve(git_command, (char **)argv, environ);
+		/* execvp() can only ever return if it fails */
+		execvp(git_command, (char **)argv);
 
 		trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-- 
1.5.3.4.206.g58ba4-dirty
