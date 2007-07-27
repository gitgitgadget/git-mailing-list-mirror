From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/8] work-trees are allowed inside a git-dir
Date: Fri, 27 Jul 2007 19:57:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271957250.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEV0j-0007Lp-FV
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbXG0S56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbXG0S56
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:57:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:38333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760978AbXG0S55 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:57:57 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:57:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 27 Jul 2007 20:57:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vVfIH7v9vfd5ed/caX+cqPjBpas4TQH613shm6g
	YXvaHU+bjd3PQa
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53944>


It is allowed to call

	$ git --git-dir=../ --work-tree=. bla

when you really want to.  In this case, you are both in the git directory
and in the working tree.

The earlier handling of this situation was seriously bogus.  For regular
working tree operations, it checked if inside git dir.  That makes no
sense, of course, since the check should be for a work tree, and nothing
else.

Fix that.

Coincidently, you can omit the "--work-tree" now, if your repository knows
about the location already.

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
1.5.3.rc3.18.g49a1
