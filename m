From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [UNWANTED PATCH] Die if core.bare = true and core.worktree is set
Date: Mon, 30 Jul 2007 00:29:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300027290.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFICz-0003MJ-9p
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934431AbXG2X3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934124AbXG2X3y
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:29:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:37448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751158AbXG2X3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:29:53 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:29:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 30 Jul 2007 01:29:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GDN9fjxtG1FbewIjl9oRHfApdbF4hzmC+2Oz2H+
	UkpFZpbY0kaVL4
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54159>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch is just here to demonstrate how a core.bare = true / 
	core.worktree conflict could be caught.

	Personally, I do not deem it worth the effort, as can be seen by 
	the lack of adjustments to t1501, which fails utterly with this 
	patch.

 environment.c |    3 +--
 setup.c       |    8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 2af12fd..4c5db32 100644
--- a/environment.c
+++ b/environment.c
@@ -82,8 +82,7 @@ const char *get_git_work_tree(void)
 	static int initialized = 0;
 	if (!initialized) {
 		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
-		/* core.bare = true overrides implicit and config work tree */
-		if (!work_tree && is_bare_repository_cfg < 1) {
+		if (!work_tree) {
 			work_tree = git_work_tree_cfg;
 			/* make_absolute_path also normalizes the path */
 			if (work_tree && !is_absolute_path(work_tree))
diff --git a/setup.c b/setup.c
index 8237fe3..b0febed 100644
--- a/setup.c
+++ b/setup.c
@@ -342,13 +342,17 @@ int check_repository_format_version(const char *var, const char *value)
 		shared_repository = git_config_perm(var, value);
 	else if (strcmp(var, "core.bare") == 0) {
 		is_bare_repository_cfg = git_config_bool(var, value);
-		if (is_bare_repository_cfg == 1)
-			inside_work_tree = -1;
+		if (is_bare_repository_cfg == 1 && inside_work_tree < 0)
+			die ("Contradicting config settings for "
+				"bare and worktree");
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (git_work_tree_cfg)
 			free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
 		inside_work_tree = -1;
+		if (is_bare_repository_cfg == 1)
+			die ("Contradicting config settings for "
+				"bare and worktree");
 	}
 	return 0;
 }
-- 
1.5.3.rc3.28.g1406
