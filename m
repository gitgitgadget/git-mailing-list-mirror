From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/8] Add a function to set a non-default work tree
Date: Sun, 27 Apr 2008 13:39:21 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804271302390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:40:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqArI-0007gU-QY
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbYD0Rja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757502AbYD0Rja
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:39:30 -0400
Received: from iabervon.org ([66.92.72.58]:42193 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756878AbYD0Rj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:39:29 -0400
Received: (qmail 12790 invoked by uid 1000); 27 Apr 2008 17:39:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Apr 2008 17:39:21 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80469>

This function may only be used before the work tree is used.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 cache.h       |    1 +
 environment.c |   19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index cdde6b0..b337b3d 100644
--- a/cache.h
+++ b/cache.h
@@ -311,6 +311,7 @@ extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
+extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index 6739a3f..1919125 100644
--- a/environment.c
+++ b/environment.c
@@ -41,7 +41,7 @@ enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-static const char *work_tree;
+static char *work_tree;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
@@ -81,10 +81,21 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+static int git_work_tree_initialized;
+
+void set_git_work_tree(const char *new_work_tree)
+{
+	if (is_bare_repository_cfg >= 0)
+		die("cannot set work tree after initialization");
+	git_work_tree_initialized = 1;
+	free(work_tree);
+	work_tree = xstrdup(make_absolute_path(new_work_tree));
+	is_bare_repository_cfg = 0;
+}
+
 const char *get_git_work_tree(void)
 {
-	static int initialized = 0;
-	if (!initialized) {
+	if (!git_work_tree_initialized) {
 		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
 		/* core.bare = true overrides implicit and config work tree */
 		if (!work_tree && is_bare_repository_cfg < 1) {
@@ -94,7 +105,7 @@ const char *get_git_work_tree(void)
 				work_tree = xstrdup(make_absolute_path(git_path(work_tree)));
 		} else if (work_tree)
 			work_tree = xstrdup(make_absolute_path(work_tree));
-		initialized = 1;
+		git_work_tree_initialized = 1;
 		if (work_tree)
 			is_bare_repository_cfg = 0;
 	}
-- 
1.5.4.3.610.gea6cd
