From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Sat, 20 Oct 2007 23:00:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710202258440.25221@racer.site>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQ7d-0002fR-2T
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXJUCAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXJUCAp
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:00:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:44968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750700AbXJUCAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:00:44 -0400
Received: (qmail invoked by alias); 20 Oct 2007 22:00:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 21 Oct 2007 00:00:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZlOUhJuCZtEQk+ENqeWoOKTKAF4w+EaOKUy9SVX
	hc1KItNXM2OAgm
X-X-Sender: gene099@racer.site
In-Reply-To: <20071020205721.GA16291@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61862>


Earlier, we tried to find the git commands in several possible exec
dirs.  Now, if all of these failed, try to find the git command in
PATH.

This allows you to install the git programs somewhere else than
originally specified when building git, as long as you add that location
to the PATH.

Initial implementation by Scott R Parish.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 20 Oct 2007, Scott Parish wrote:

	> Actually, i didn't test it right, execve() were using the files 
	> in my cwd. In addition to you patch, you'd need to use execvp() 
	> instead of execve().

	Ah, right.  I missed that one ;-)

	How about this instead?

 exec_cmd.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..c928f37 100644
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
-- 
1.5.3.4.1287.g8b31e
