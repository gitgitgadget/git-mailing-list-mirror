From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] With work-trees possibly inside git-dir, be more generous
Date: Thu, 26 Jul 2007 07:32:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260732360.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 26 08:33:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwu9-0006l1-If
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbXGZGcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXGZGcy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:32:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:59069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754896AbXGZGcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:32:53 -0400
Received: (qmail invoked by alias); 26 Jul 2007 06:32:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 26 Jul 2007 08:32:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MSBhKAybMdC9MjYO9Lw4Y1UulwuRDbMMDVljrQo
	uArAUQY5GfudBD
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53782>


The earlier work-tree behaviour was seriously bogus.  For regular working
tree operations, it checked if inside git dir.  That makes no sense, of
course, since the check should be for a work tree, and nothing else.

Fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Please consider giving this a real hard beating.  I think the
	old series was so bad only because nobody cared (including me).

 builtin-ls-files.c  |    8 +++++---
 builtin-rev-parse.c |    6 ++++++
 git-sh-setup.sh     |    3 +--
 git.c               |    7 +++++--
 4 files changed, 17 insertions(+), 7 deletions(-)

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
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 497903a..3804541 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -320,7 +320,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
+				const char *work_tree = get_git_work_tree();
 				const char *pfx = prefix;
+
+				if (work_tree) {
+					printf("%s\n", work_tree);
+					continue;
+				}
 				while (pfx) {
 					pfx = strchr(pfx, '/');
 					if (pfx) {
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
index 5df10d3..03ce3bb 100644
--- a/git.c
+++ b/git.c
@@ -273,8 +273,11 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	if (p->option & USE_PAGER)
 		setup_pager();
 	if ((p->option & NEED_WORK_TREE) &&
-	    (!is_inside_work_tree() || is_inside_git_dir()))
-		die("%s must be run in a work tree", p->cmd);
+	    !is_inside_work_tree()) {
+		const char *work_tree = get_git_work_tree();
+		if (!work_tree || chdir(work_tree))
+			die("%s must be run in a work tree", p->cmd);
+	}
 	trace_argv_printf(argv, argc, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
-- 
1.5.3.rc2.42.gda8d-dirty
