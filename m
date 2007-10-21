From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Sun, 21 Oct 2007 22:59:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710212256270.25221@racer.site>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net>
 <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijipb-000273-Km
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 23:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbXJUV7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 17:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbXJUV7X
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 17:59:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:53949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750777AbXJUV7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 17:59:22 -0400
Received: (qmail invoked by alias); 21 Oct 2007 21:59:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 21 Oct 2007 23:59:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e/HRz91Ae0CnFW+Yw/GFQIxg1OE1icBRN7+20Dz
	KW2jaC+gMaZQRC
X-X-Sender: gene099@racer.site
In-Reply-To: <20071021023614.GB14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61913>


Earlier, we tried to find the git commands in several possible exec
dirs.  Now, if all of these failed, try to find the git command in
PATH.

This allows you to install the git programs somewhere else than
originally specified when building git, as long as you add that location
to the PATH.

Initial implementation by Scott R Parish.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 20 Oct 2007, Shawn O. Pearce wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
	> > On Sat, 20 Oct 2007, Scott Parish wrote:
	> > 
	> > > Actually, i didn't test it right, execve() were using the 
	> > > files in my cwd. In addition to you patch, you'd need to use 
	> > > execvp() instead of execve().
	> > 
	> > Ah, right.  I missed that one ;-)
	> > 
	> > How about this instead?
	> 
	> Uhhh.  Its the same, isn't it?  Still using execve() which means 
	> we will not look at PATH in the final attempt.

	Sorry.  I forgot to --amend.

 exec_cmd.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..70b84b0 100644
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
@@ -100,7 +104,10 @@ int execv_git_cmd(const char **argv)
 		trace_argv_printf(argv, -1, "trace: exec:");
 
 		/* execve() can only ever return if it fails */
-		execve(git_command, (char **)argv, environ);
+		if (*exec_dir)
+			execve(git_command, (char **)argv, environ);
+		else
+			execvp(git_command, (char **)argv);
 
 		trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-- 
1.5.3.4.1289.ga1432
