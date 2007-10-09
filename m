From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Support cvs via git-shell
Date: Tue, 9 Oct 2007 15:33:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091531360.4174@racer.site>
References: <200710051453.47622.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Wielemaker <wielemak@science.uva.nl>,
	Git Mailing List <git@vger.kernel.org>
To: gitster@pobox.com, hjemli@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 09 16:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfG9i-0006Ye-4n
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 16:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbXJIOdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbXJIOdo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 10:33:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:42466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752722AbXJIOdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 10:33:43 -0400
Received: (qmail invoked by alias); 09 Oct 2007 14:33:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 09 Oct 2007 16:33:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ro+JoqImRz+XteLjdADGXLG8AAYHhtdpiiZIRxd
	n43VQqybJWCMGC
X-X-Sender: gene099@racer.site
In-Reply-To: <200710051453.47622.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60418>


This adds cvs support to the git-shell; You can now give new users
a restricted git-shell and they still can commit via git's cvs
emulator.

Note that either the gecos information must be accurate, or you must
provide a $HOME/.gitconfig with the appropriate user credentials.
Since the git-shell is too restricted to allow the user to do it
(on purpose!), it is up to the administrator to take care of that.

Based on an idea by Jan Wielemaker.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Since Jan seems to be too busy to do it (in contrast to everybody 
	else), I ended up implementing my advices myself.  At least that 
	way, I can take the credit, too, since not many things are left 
	from the original patch.

 shell.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/shell.c b/shell.c
index c983fc7..cfe372b 100644
--- a/shell.c
+++ b/shell.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "strbuf.h"
 
 static int do_generic_cmd(const char *me, char *arg)
 {
@@ -18,12 +19,34 @@ static int do_generic_cmd(const char *me, char *arg)
 	return execv_git_cmd(my_argv);
 }
 
+static int do_cvs_cmd(const char *me, char *arg)
+{
+	const char *cvsserver_argv[3] = {
+		"cvsserver", "server", NULL
+	};
+	const char *oldpath = getenv("PATH");
+	struct strbuf newpath = STRBUF_INIT;
+
+	if (!arg || strcmp(arg, "server"))
+		die("git-cvsserver only handles server: %s", arg);
+
+	strbuf_addstr(&newpath, git_exec_path());
+	strbuf_addch(&newpath, ':');
+	strbuf_addstr(&newpath, oldpath);
+
+	setenv("PATH", strbuf_detach(&newpath, NULL), 1);
+
+	return execv_git_cmd(cvsserver_argv);
+}
+
+
 static struct commands {
 	const char *name;
 	int (*exec)(const char *me, char *arg);
 } cmd_list[] = {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
+	{ "cvs", do_cvs_cmd },
 	{ NULL },
 };
 
@@ -32,8 +55,10 @@ int main(int argc, char **argv)
 	char *prog;
 	struct commands *cmd;
 
+	if (argc == 2 && !strcmp(argv[1], "cvs server"))
+		argv--;
 	/* We want to see "-c cmd args", and nothing else */
-	if (argc != 3 || strcmp(argv[1], "-c"))
+	else if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");
 
 	prog = argv[2];
-- 
1.5.3.4.1169.g5fb8d
