From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] [RED] git-init: Cannot setup bare repository
Date: Sun, 26 Aug 2007 22:45:31 +0200
Message-ID: <20070826204531.11592.36481.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOzJ-0003AB-B6
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXHZUpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXHZUpd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:45:33 -0400
Received: from rover.dkm.cz ([62.24.64.27]:49496 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbXHZUpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:45:33 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 9DAD68B3C9;
	Sun, 26 Aug 2007 22:45:31 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56731>

git-init is totally broken wrt. setting up bare repository - it thinks no
repository is bare (maybe I could coerce it to think some repositories
indeed are bare, but I have my doubts). This patch is more like a cry for
help, not something to be applied, though it works as a crude workaround if
you're hit by the same problem as me. Unfortunately it's hard to make sense
of the tangled git_working_tree_cfg, work_tree, is_bare_tree_cfg etc.
network of variables, so I don't have any clear idea about a proper fix nor
the time to figure it out. :-(

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 builtin-init-db.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 0d9b1e0..3718355 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -299,11 +299,15 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
-	git_work_tree_cfg = xcalloc(PATH_MAX, 1);
-	if (!getcwd(git_work_tree_cfg, PATH_MAX))
-		die ("Cannot access current working directory.");
-	if (access(get_git_work_tree(), X_OK))
-		die ("Cannot access work tree '%s'", get_git_work_tree());
+	if (!strcmp(get_git_dir(), ".git")) {
+		git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+		if (!getcwd(git_work_tree_cfg, PATH_MAX))
+			die ("Cannot access current working directory.");
+		if (access(get_git_work_tree(), X_OK))
+			die ("Cannot access work tree '%s'", get_git_work_tree());
+	} else {
+		git_work_tree_cfg = NULL;
+	}
 
 	/*
 	 * Set up the default .git directory contents
