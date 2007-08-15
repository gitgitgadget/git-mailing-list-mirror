From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix initialization of a bare repository
Date: Wed, 15 Aug 2007 18:25:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLhA-00013f-Kt
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763213AbXHOQZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762454AbXHOQZs
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:25:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:41210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762625AbXHOQZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:25:47 -0400
Received: (qmail invoked by alias); 15 Aug 2007 16:25:45 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp040) with SMTP; 15 Aug 2007 18:25:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HJvlYPMeHip9ox7odmu8RBcLveOYumXZlOQVXGv
	Ft6bb9CAv8zv/x
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55920>


The recent work-tree cleanup broke it; core.bare was set to false
erroneously when calling "git --bare init".  Coincidentally, this
fixes "git clone --bare", too.

Noticed by Junio Hamano.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 15 Aug 2007, Junio C Hamano wrote:

	> It appears that with 1.5.3-rc5
	> 
	> 	$ git clone --bare $origin_url target.git
	> 
	> does not set "core.bare = true" in target.git/config.  We used
	> to, at least with 1.5.2.2.  I am strongly suspecting that this
	> is another fallout from the worktree series.

	Sorry.  Yes, this is another fallout.

	Maybe this is not enough, though.  Maybe we need to check if the 
	GIT_DIR=. too, since 7efeb8f0 would set the work tree to ".", too.

	But maybe this would merit a separate fix in set_work_tree(), like

		if (!strcmp(getenv(GIT_DIR_ENVIRONMENT), ".")) {
			inside_work_tree = 0;
			return NULL;
		}

	Hmm?

 builtin-init-db.c |   13 ++++++++-----
 git.c             |    1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 75fb227..2e45a7e 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -302,11 +302,14 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
-	git_work_tree_cfg = xcalloc(PATH_MAX, 1);
-	if (!getcwd(git_work_tree_cfg, PATH_MAX))
-		die ("Cannot access current working directory.");
-	if (access(get_git_work_tree(), X_OK))
-		die ("Cannot access work tree '%s'", get_git_work_tree());
+	if (!is_bare_repository_cfg) {
+		git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+		if (!getcwd(git_work_tree_cfg, PATH_MAX))
+			die ("Cannot access current working directory.");
+		if (access(get_git_work_tree(), X_OK))
+			die ("Cannot access work tree '%s'",
+					get_git_work_tree());
+	}
 
 	/*
 	 * Set up the default .git directory contents
diff --git a/git.c b/git.c
index 1bf2744..f0062a0 100644
--- a/git.c
+++ b/git.c
@@ -100,6 +100,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
+			is_bare_repository_cfg = 1;
 		} else if (!strcmp(cmd, "-2") ||
 				!strcmp(cmd, "--redirect-stderr")) {
 			if (dup2(1, 2) < 0)
-- 
1.5.1.rc1.4887.ga4a43-dirty
