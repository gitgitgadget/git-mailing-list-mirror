From: Maciej Pasternacki <maciej@pasternacki.net>
Subject: [PATCH v2] Add command line option --chdir/-C to allow setting git process work directory.
Date: Sun, 19 Oct 2008 09:18:19 -0700
Message-ID: <20081019161819.GA12495@charybdis.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 09:10:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krb2m-0001Uv-4s
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 18:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbYJSQSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 12:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYJSQSV
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 12:18:21 -0400
Received: from smarty.dreamhost.com ([208.113.175.8]:40365 "EHLO
	smarty.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYJSQSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 12:18:20 -0400
X-Greylist: delayed 58552 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Oct 2008 12:18:20 EDT
Received: from charybdis.dreamhost.com (unknown [66.33.197.39])
	by smarty.dreamhost.com (Postfix) with ESMTP id 78594EE249;
	Sun, 19 Oct 2008 09:18:19 -0700 (PDT)
Received: by charybdis.dreamhost.com (Postfix, from userid 2307417)
	id 7611331FC9; Sun, 19 Oct 2008 09:18:19 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98622>

When "git pull" is ran outside of work tree, it is unable to update work tree
with pulled changes; specifying --git-dir and --work-tree does not help here
because "cd_to_toplevel" call in git-pull occurs after "require_work_tree";
changing order may break the commend if there is no working tree.  Some more
commands behave in a similar way.

In my project, I need to call "git pull" from outside of work tree, but I need
it to update the work tree.  It seems to require doing chdir() before running
git, but this is problematic thing to do in the calling program because of
portability issues.  Proper solution seems to be providing -C / --chdir command
line option, similar to this of Make, that would make main git program perform
chdir() to specified directory before running the specific command.  This would
make using git from outside programs much more straightforward.

This patch provides -C and --chdir command line options that behave as
described above.

Signed-off-by: Maciej Pasternacki <maciej@pasternacki.net>
---
 Documentation/git.txt |    6 +++++-
 git.c                 |   19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index df420ae..6676d68 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
     [-p|--paginate|--no-pager]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
-    [--help] COMMAND [ARGS]
+    [-C DIRECTORY|--chdir=DIRECTORY] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -185,6 +185,10 @@ help ...`.
 	environment is not set, it is set to the current working
 	directory.
 
+-C <directory>::
+--chdir=<directory>::
+	Change working directory before doing anything.
+
 
 FURTHER DOCUMENTATION
 ---------------------
diff --git a/git.c b/git.c
index 89feb0b..c63d754 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [-C DIR|--chdir=DIR] [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
@@ -115,6 +115,23 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "-C") || !strcmp(cmd, "--chdir")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --chdir or -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1])) {
+				fprintf(stderr, "Cannot change directory to %s: %s\n", (*argv)[1], strerror(errno));
+				usage(git_usage_string);
+			}
+			(*argv)++;
+			(*argc)--;
+			handled++;
+		} else if (!prefixcmp(cmd,"--chdir=")) {
+			if (chdir(cmd+8)) {
+				fprintf(stderr, "Cannot change directory to %s: %s\n", cmd+8, strerror(errno));				     
+				usage(git_usage_string);
+			}
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- 
1.6.0.1
