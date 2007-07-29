From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/9] work-trees are allowed inside a git-dir
Date: Mon, 30 Jul 2007 00:25:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300025250.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI9B-0002Wx-Q4
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbXG2XZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935438AbXG2XZ7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:25:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:35250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935375AbXG2XZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:25:58 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:25:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 30 Jul 2007 01:25:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cdMcysyRcYHN6JmFr7hy13GRhTMNgsD50jIXXdT
	gZdeUanQn4hzwE
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54155>


It is allowed to call

	$ git --git-dir=../ --work-tree=. bla

when you really want to.  In this case, you are both in the git directory
and in the working tree.

The earlier handling of this situation was seriously bogus.  For regular
working tree operations, it checked if inside git dir.  That makes no
sense, of course, since the check should be for a work tree, and nothing
else.

Fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-ls-files.c |    8 +++++---
 git-sh-setup.sh    |    3 +--
 git.c              |   11 ++++++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 61577ea..d36181a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -469,9 +469,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (require_work_tree &&
-			(!is_inside_work_tree() || is_inside_git_dir()))
-		die("This operation must be run in a work tree");
+	if (require_work_tree && !is_inside_work_tree()) {
+		const char *work_tree = get_git_work_tree();
+		if (!work_tree || chdir(work_tree))
+			die("This operation must be run in a work tree");
+	}
 
 	pathspec = get_pathspec(prefix, argv + i);
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c51985e..7bef43f 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -59,8 +59,7 @@ cd_to_toplevel () {
 }
 
 require_work_tree () {
-	test $(git rev-parse --is-inside-work-tree) = true &&
-	test $(git rev-parse --is-inside-git-dir) = false ||
+	test $(git rev-parse --is-inside-work-tree) = true ||
 	die "fatal: $0 cannot be used without a working tree."
 }
 
diff --git a/git.c b/git.c
index a647f9c..2433355 100644
--- a/git.c
+++ b/git.c
@@ -272,9 +272,14 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 		prefix = setup_git_directory();
 	if (p->option & USE_PAGER)
 		setup_pager();
-	if ((p->option & NEED_WORK_TREE) &&
-	    (!is_inside_work_tree() || is_inside_git_dir()))
-		die("%s must be run in a work tree", p->cmd);
+	if (p->option & NEED_WORK_TREE) {
+		const char *work_tree = get_git_work_tree();
+		const char *git_dir = get_git_dir();
+		if (!is_absolute_path(git_dir))
+			set_git_dir(make_absolute_path(git_dir));
+		if (!work_tree || chdir(work_tree))
+			die("%s must be run in a work tree", p->cmd);
+	}
 	trace_argv_printf(argv, argc, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
-- 
1.5.3.rc3.28.g1406
