From: kevin brintnall <kbrint@rufus.net>
Subject: [PATCH] added -C option to chdir() into another directory first
Date: Thu, 26 Feb 2009 14:11:39 -0600
Message-ID: <1235679099-33994-1-git-send-email-kbrint@rufus.net>
Cc: kevin brintnall <kbrint@rufus.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 21:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcmlK-0007yG-K7
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbZBZUVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 15:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756006AbZBZUVK
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:21:10 -0500
Received: from hamachi.rufus.net ([209.181.236.65]:52175 "EHLO
	hamachi.rufus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbZBZUU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 15:20:59 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Feb 2009 15:20:59 EST
Received: by hamachi.rufus.net (Postfix, from userid 100)
	id EB7D0272D55; Thu, 26 Feb 2009 14:11:39 -0600 (CST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111592>

This allows things like 'git -C /somewhere pull' without specifying both
--work-tree and --git-dir.

Signed-off-by: kevin brintnall <kbrint@rufus.net>
---
 git.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index c2b181e..b218bfe 100644
--- a/git.c
+++ b/git.c
@@ -5,7 +5,7 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [-C BASE_DIR] [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
@@ -116,6 +116,16 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "-C")) {
+			char *dir = (*argv)[1];
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C");
+				usage(git_usage_string);
+			}
+			if (chdir(dir))
+				die("Cannot change to %s: %s", dir, strerror(errno));
+			(*argv)++;
+			(*argc)--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- 
1.6.1.3
