From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Wed, 21 Nov 2007 21:27:21 +0100
Message-ID: <11956768412755-git-send-email-prohaska@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de>
 <11956768412804-git-send-email-prohaska@zib.de>
 <11956768413887-git-send-email-prohaska@zib.de>
Cc: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 21:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuwB4-0008Rz-IK
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 21:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbXKUU1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 15:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXKUU13
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 15:27:29 -0500
Received: from mailer.zib.de ([130.73.108.11]:42021 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbXKUU1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 15:27:25 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lALKRMRd007527;
	Wed, 21 Nov 2007 21:27:22 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lALKRLdI013767;
	Wed, 21 Nov 2007 21:27:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11956768413887-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65704>

From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>

We have a function set_git_dir().  So let's use it, instead
of setting the evironment directly.

This also fixes a problem on Windows: environment.c caches
results of many getenv calls.  A setenv(X) call to the Windows
C runtime (CRT) invalidates all previous values returned by
getenv(X).  So cached values become dangling pointers.

Before this change, git clone was failing with 'invalid object
name HEAD' if ran from Windows' cmd.exe.

[sp: rebased; split off get_git_dir() in builtin-init-db.c
     to separate commit; adjusted commit message. ]

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git.c   |    6 +++---
 path.c  |    2 +-
 setup.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 7604319..8bc25b7 100644
--- a/git.c
+++ b/git.c
@@ -45,14 +45,14 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+			set_git_dir( (*argv)[1] );
 			if (envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+			set_git_dir(cmd + 10);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
@@ -72,7 +72,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
+			set_git_dir(getcwd(git_dir, sizeof(git_dir)));
 			if (envchanged)
 				*envchanged = 1;
 		} else {
diff --git a/path.c b/path.c
index 4260952..f26a4a1 100644
--- a/path.c
+++ b/path.c
@@ -248,7 +248,7 @@ char *enter_repo(char *path, int strict)
 
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_headref("HEAD") == 0) {
-		setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+		set_git_dir(".");
 		check_repository_format();
 		return path;
 	}
diff --git a/setup.c b/setup.c
index 43cd3f9..8dbd46c 100644
--- a/setup.c
+++ b/setup.c
@@ -285,7 +285,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			inside_git_dir = 1;
 			if (!work_tree_env)
 				inside_work_tree = 0;
-			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			set_git_dir(".");
 			return NULL;
 		}
 		chdir("..");
-- 
1.5.3.5.750.g8692
