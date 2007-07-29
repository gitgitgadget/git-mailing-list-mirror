From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 8/9] Fix t1501 for updated work-tree logic
Date: Mon, 30 Jul 2007 00:26:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300026030.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI9q-0002hl-SV
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936490AbXG2X0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965352AbXG2X0j
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:26:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:52161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936419AbXG2X0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:26:38 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:26:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 30 Jul 2007 01:26:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BFJ0i+6ABdNiqMTkejLcG7YDoyxwvFJdnkCfgNt
	vQ52KQW8w1TCbG
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54157>


t1501 is still a PITA to debug.  But I decided not to change it, so
that it is easier to see what the differences in the logic are.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1501-worktree.sh |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index aadeeab..7322161 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -33,17 +33,17 @@ mv .git repo.git || exit 1
 
 say "core.worktree = relative path"
 export GIT_DIR=repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 unset GIT_WORK_TREE
 git config core.worktree ../work
 test_rev_parse 'outside'      false false false
 cd work || exit 1
 export GIT_DIR=../repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 test_rev_parse 'inside'       false false true ''
 cd sub/dir || exit 1
 export GIT_DIR=../../../repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
@@ -84,9 +84,23 @@ test_rev_parse 'in repo.git'              false true  false
 cd objects || exit 1
 test_rev_parse 'in repo.git/objects'      false true  false
 cd ../work || exit 1
-test_rev_parse 'in repo.git/work'         false false true ''
+test_rev_parse 'in repo.git/work'         false true true ''
 cd sub/dir || exit 1
-test_rev_parse 'in repo.git/sub/dir' false false true sub/dir/
+test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
 cd ../../../.. || exit 1
 
+test_expect_success 'repo finds its work tree' '
+	(cd repo.git &&
+	 : > work/sub/dir/untracked &&
+	 test sub/dir/untracked = "$(git ls-files --others)")
+'
+
+test_expect_success 'repo finds its work tree from work tree, too' '
+	(cd repo.git/work/sub/dir &&
+	 : > tracked &&
+	 git --git-dir=../../.. add tracked &&
+	 cd ../../.. &&
+	 test sub/dir/tracked = "$(git ls-files)")
+'
+
 test_done
-- 
1.5.3.rc3.28.g1406
