From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 1/2] git: add new option --no-git-dir
Date: Fri, 4 Sep 2009 09:29:18 +0000
Message-ID: <20090904092918.23170.qmail@f4597b4c28fb52.315fe32.mid.smarden.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjV6q-0000ll-7R
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 11:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337AbZIDJ3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933306AbZIDJ3V
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 05:29:21 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:3967 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933301AbZIDJ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 05:29:20 -0400
Received: (qmail 23171 invoked by uid 1000); 4 Sep 2009 09:29:18 -0000
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127699>

This commit adds the --no-git-dir option to the git program.  Setting
this option prevents the git program from searching for a path to a git
repository, which can be useful for commands that do not require one.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git.txt |    6 +++++-
 git.c                 |    6 +++++-
 setup.c               |    2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index ad44cac..6327203 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
     [-p|--paginate|--no-pager]
-    [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
+    [--bare] [--git-dir=GIT_DIR|--no-git-dir] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
 
 DESCRIPTION
@@ -212,6 +212,10 @@ help ...`.
 	setting the GIT_DIR environment variable. It can be an absolute
 	path or relative path to current working directory.
 
+--no-git-dir::
+	Do not set a path to a repository, and do not try to find one.
+	Setting this option is equivalent to setting --git-dir="".
+
 --work-tree=<path>::
 	Set the path to the working tree.  The value will not be
 	used in combination with repositories found automatically in
diff --git a/git.c b/git.c
index 0b22595..8e060b9 100644
--- a/git.c
+++ b/git.c
@@ -5,7 +5,7 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR|--no-git-dir] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
@@ -99,6 +99,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-git-dir")) {
+			setenv(GIT_DIR_ENVIRONMENT, "", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --work-tree.\n" );
diff --git a/setup.c b/setup.c
index e3781b6..ee9be6e 100644
--- a/setup.c
+++ b/setup.c
@@ -335,6 +335,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			*nongit_ok = 1;
 			return NULL;
 		}
+		if (!*gitdirenv)
+			die("This command requires a git repository");
 		die("Not a git repository: '%s'", gitdirenv);
 	}
 
-- 
1.6.0.3
