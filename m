From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: [PATCH] git-shell and git-cvsserver
Date: Fri, 5 Oct 2007 14:53:47 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710051453.47622.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdmmN-0007Ss-Hn
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbXJEM7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbXJEM7f
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:59:35 -0400
Received: from imap.science.uva.nl ([146.50.4.51]:34959 "EHLO
	imap.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbXJEM7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:59:34 -0400
Received: from gollem.science.uva.nl [146.50.26.20]
          by imap.science.uva.nl with ESMTP (sendmail 8.13.8/config 11.38).
          id l95CxVpL020372; Fri, 5 Oct 2007 14:59:32 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60079>

Hi,

I know, I shouldn't be using git-cvsserver :-( Anyway, I patched
git-shell to start git-cvsserver if it is started interactively and the
one and only line given to it is "cvs server".

The patch to shell.c is below. The trick with the EXEC_PATH is needed
because git-cvsserver doesn't appear to be working if you do not include
the git bindir in $PATH. I think that should be fixed in git-cvsserver
and otherwise we should at least make the value come from the prefix
make variable.  With this patch I was able to use both Unix and Windows
cvs clients using git-shell as login shell.

Note that you must provide ~/.gitconfig with user and email in the
restricted environment.

	Enjoy --- Jan


--- shell.c.org	2007-10-05 13:08:47.000000000 +0200
+++ shell.c	2007-10-05 14:24:11.000000000 +0200
@@ -18,27 +18,80 @@
 	return execv_git_cmd(my_argv);
 }
 
+#define EXEC_PATH "/usr/local/bin"
+
+static int do_cvs_cmd(const char *me, char *arg)
+{
+	const char *my_argv[4];
+	const char *oldpath;
+
+	if ( !arg )
+		die("no argument");
+	if ( strcmp(arg, "server") )
+		die("only allows git-cvsserver server: %s", arg);
+
+	my_argv[0] = "cvsserver";
+	my_argv[1] = "server";
+	my_argv[2] = NULL;
+
+	if ( (oldpath=getenv("PATH")) ) {
+		char *newpath = malloc(strlen(oldpath)+strlen(EXEC_PATH)+5+1+1);
+		
+		sprintf(newpath, "PATH=%s:%s", EXEC_PATH, oldpath);
+		putenv(newpath);
+	} else {
+		char *newpath = malloc(strlen(EXEC_PATH)+5+1);
+		
+		sprintf(newpath, "PATH=%s", EXEC_PATH);
+		putenv(newpath);
+	}
+
+	return execv_git_cmd(my_argv);
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
 
 int main(int argc, char **argv)
 {
 	char *prog;
+	char buf[256];
 	struct commands *cmd;
 
 	/* We want to see "-c cmd args", and nothing else */
-	if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+	if (argc == 1) {
+		if (fgets(buf, sizeof(buf)-1, stdin)) {
+			char *end;
+
+			if ( (end=strchr(buf, '\n')) )
+			{	while(end>buf && end[-1] <= ' ')
+					end--;
+				*end = '\0';
+			} else {
+				die("Bad command");
+			}
+
+			prog = buf;
+		} else {
+			die("No command");
+		}
+	} else {
+		if (argc != 3 || strcmp(argv[1], "-c"))
+			die("What do you think I am? A shell?");
+
+		prog = argv[2];
+		argv += 2;
+		argc -= 2;
+	}
 
-	prog = argv[2];
-	argv += 2;
-	argc -= 2;
 	for (cmd = cmd_list ; cmd->name ; cmd++) {
 		int len = strlen(cmd->name);
 		char *arg;
