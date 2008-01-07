From: Christian Thaeter <ct@pipapo.org>
Subject: [PATCH 2/5] First step, making setup (somewhat) reentrant
Date: Mon,  7 Jan 2008 06:47:32 +0100
Message-ID: <1199684855-14246-2-git-send-email-ct@pipapo.org>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org>
Cc: gitster@pobox.com, Christian Thaeter <ct@pipapo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 06:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBkqJ-0006Yg-9D
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 06:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbYAGFro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 00:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbYAGFrn
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 00:47:43 -0500
Received: from pipapo.org ([217.140.77.75]:1099 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196AbYAGFrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 00:47:40 -0500
Received: from localhost (mercur.pipapo.org [10.20.70.10])
	by mail.pipapo.org (Postfix) with SMTP id A91FA34F59DD6;
	Mon,  7 Jan 2008 06:47:37 +0100 (CET)
Received: by localhost (sSMTP sendmail emulation); Mon, 07 Jan 2008 06:47:37 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <1199684855-14246-1-git-send-email-ct@pipapo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69762>

setup_git_env() just initialized some static data and then let it
leak. For reentrant operation, as in using a git process to access
serveral repositories in order, this data has to be freed and properly
reinitialized.

get_git_work_tree() used a once only initialization flag, we now provide
a reset_git_work_tree() to free allocated resources and let it initialize
itself on the next call.

create_default_files() in init-db needed to be fixed to compare strings
properly.

Signed-off-by: Christian Thaeter <ct@pipapo.org>
---
 builtin-init-db.c |    4 ++--
 environment.c     |   43 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1393b8..d5a5dd9 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -270,8 +270,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
-		    git_config_set("core.logallrefupdates", "true");
-		if (work_tree != git_work_tree_cfg)
+			git_config_set("core.logallrefupdates", "true");
+		if (!streq(work_tree, git_work_tree_cfg))
 			git_config_set("core.worktree", work_tree);
 	}
 
diff --git a/environment.c b/environment.c
index 18a1c4e..492d87c 100644
--- a/environment.c
+++ b/environment.c
@@ -38,31 +38,48 @@ int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
-char *git_work_tree_cfg;
-static const char *work_tree;
+char *git_work_tree_cfg = NULL;
+static char *work_tree = NULL;
+static int work_tree_initialized = 0;
 
 static const char *git_dir;
-static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
+static char *git_object_dir = NULL, *git_index_file = NULL, *git_refs_dir = NULL, *git_graft_file = NULL;
 
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	if (git_object_dir)
+		free(git_object_dir);
 	git_object_dir = getenv(DB_ENVIRONMENT);
-	if (!git_object_dir) {
+	if (git_object_dir) {
+		git_object_dir = xstrdup(git_object_dir);
+	}
+	else {
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
+	if (git_refs_dir)
+		free(git_refs_dir);
 	git_refs_dir = xmalloc(strlen(git_dir) + 6);
 	sprintf(git_refs_dir, "%s/refs", git_dir);
+	if (git_index_file)
+		free(git_index_file);
 	git_index_file = getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file) {
+	if (git_index_file) {
+		git_index_file = xstrdup(git_index_file);
+	}
+	else {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
 		sprintf(git_index_file, "%s/index", git_dir);
 	}
+	if (git_graft_file)
+		free (git_graft_file);
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
-	if (!git_graft_file)
+	if (git_graft_file)
+		git_graft_file = xstrdup(git_graft_file);
+	else
 		git_graft_file = xstrdup(git_path("info/grafts"));
 }
 
@@ -79,10 +96,16 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+void reset_git_work_tree(void)
+{
+	work_tree_initialized = 0;
+	if (work_tree)
+		free (work_tree);
+}
+
 const char *get_git_work_tree(void)
 {
-	static int initialized = 0;
-	if (!initialized) {
+	if (!work_tree_initialized) {
 		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
 		/* core.bare = true overrides implicit and config work tree */
 		if (!work_tree && is_bare_repository_cfg < 1) {
@@ -90,11 +113,13 @@ const char *get_git_work_tree(void)
 			/* make_absolute_path also normalizes the path */
 			if (work_tree && !is_absolute_path(work_tree))
 				work_tree = xstrdup(make_absolute_path(git_path(work_tree)));
+			else if (work_tree)
+				work_tree = xstrdup(work_tree);
 		} else if (work_tree)
 			work_tree = xstrdup(make_absolute_path(work_tree));
-		initialized = 1;
 		if (work_tree)
 			is_bare_repository_cfg = 0;
+		work_tree_initialized = 1;
 	}
 	return work_tree;
 }
-- 
1.5.3.7
