From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix setup_git_directory_gently() with relative GIT_DIR &
 GIT_WORK_TREE
Date: Wed, 17 Oct 2007 00:37:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710170037030.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 17 01:37:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihvz3-00076h-Gj
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 01:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031AbXJPXhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 19:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759734AbXJPXhq
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 19:37:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:47473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758882AbXJPXhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 19:37:45 -0400
Received: (qmail invoked by alias); 16 Oct 2007 23:37:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 17 Oct 2007 01:37:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FOq8OEoUFzp9y1aWsI08WuvfoFJsWkxp0mFE/Ym
	xNhIZHRg2iVLvx
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61278>


There are a few programs, such as config and diff, which allow running
without a git repository.  Therefore, they have to call
setup_git_directory_gently().

However, when GIT_DIR and GIT_WORK_TREE were set, and the current
directory was a subdirectory of the work tree,
setup_git_directory_gently() would return a bogus NULL prefix.

This patch fixes that.

Noticed by REPLeffect on IRC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c             |   13 ++++++++++++-
 t/t1501-worktree.sh |    9 +++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 06004f1..145eca5 100644
--- a/setup.c
+++ b/setup.c
@@ -227,9 +227,20 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 		if (is_git_directory(gitdirenv)) {
+			static char buffer[1024 + 1];
+			const char *retval;
+
 			if (!work_tree_env)
 				return set_work_tree(gitdirenv);
-			return NULL;
+			retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
+					get_git_work_tree());
+			if (!retval || !*retval)
+				return NULL;
+			set_git_dir(make_absolute_path(gitdirenv));
+			if (chdir(work_tree_env) < 0)
+				die ("Could not chdir to %s", work_tree_env);
+			strcat(buffer, "/");
+			return retval;
 		}
 		if (nongit_ok) {
 			*nongit_ok = 1;
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7322161..7ee3820 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -103,4 +103,13 @@ test_expect_success 'repo finds its work tree from work tree, too' '
 	 test sub/dir/tracked = "$(git ls-files)")
 '
 
+test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
+	cd repo.git/work/sub/dir &&
+	GIT_DIR=../../.. GIT_WORK_TREE=../.. GIT_PAGER= \
+		git diff --exit-code tracked &&
+	echo changed > tracked &&
+	! GIT_DIR=../../.. GIT_WORK_TREE=../.. GIT_PAGER= \
+		git diff --exit-code tracked
+'
+
 test_done
-- 
1.5.3.4.1223.ga973c
