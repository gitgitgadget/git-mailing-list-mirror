From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] git wrapper: add --git-path=<path> and --bare options
Date: Tue, 25 Jul 2006 19:30:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 25 19:31:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Qjz-0002Mz-O0
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWGYRaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWGYRaX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 13:30:23 -0400
Received: from mail.gmx.de ([213.165.64.21]:9348 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750724AbWGYRaX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 13:30:23 -0400
Received: (qmail invoked by alias); 25 Jul 2006 17:30:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 25 Jul 2006 19:30:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24179>


With this, you can say

	git --bare repack -a -d

inside a bare repository, and it will actually work. While at
documenting these options, also document the --paginate option.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	This is on top of my "allow wrapper options in aliases" patch.

	I hope I did not fsck up the asciidoc formatting; ATM I cannot 
	test that.

	If you agree this is a good approach, should I also move the 
	--version and --exec-path options into handle_options()?

	If you do, I will also make this more user-friendly, i.e.
	it should not crash when saying "git --bare".

 Documentation/git.txt |   12 +++++++++++-
 git.c                 |    9 +++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index ce30581..b5da5f9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -8,7 +8,8 @@ git - the stupid content tracker
 
 SYNOPSIS
 --------
-'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ARGS]
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
+	[--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -41,6 +42,15 @@ OPTIONS
 	environment variable. If no path is given 'git' will print
 	the current setting and then exit.
 
+-p|--paginate::
+	Pipe all output into 'less' (or if set, $PAGER).
+
+--git-path=<path>::
+	Set the path to the repository. This can also be controlled by
+	setting the GIT_DIR environment variable.
+
+--bare::
+	Same as --git-path=`pwd`.
 
 FURTHER DOCUMENTATION
 ---------------------
diff --git a/git.c b/git.c
index 8d7c644..e048f54 100644
--- a/git.c
+++ b/git.c
@@ -46,6 +46,15 @@ static int handle_options(const char*** 
 
 		if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			setup_pager();
+		} else if (!strcmp(cmd, "--git-dir") && *argc > 1) {
+			setenv("GIT_DIR", (*argv)[1], 1);
+			(*argv)++;
+			(*argc)--;
+		} else if (!strncmp(cmd, "--git-dir=", 10)) {
+			setenv("GIT_DIR", cmd + 10, 1);
+		} else if (!strcmp(cmd, "--bare")) {
+			static char git_dir[1024];
+			setenv("GIT_DIR", getcwd(git_dir, 1024), 1);
 		} else
 			die ("Unknown option: %s", cmd);
 
-- 
1.4.2.rc1.gf725-dirty
