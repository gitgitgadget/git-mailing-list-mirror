From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] rebase: do not fail silently when the HEAD could not be
 detached
Date: Sat, 7 Feb 2009 18:20:09 +0100 (CET)
Message-ID: <679be9321b4cf4f694917cb9eebba70376a43a0a.1234027102u.git.johannes.schindelin@gmx.de>
References: <cover.1234027102u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 07 18:21:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVqrX-0006CI-RN
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 18:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbZBGRTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 12:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbZBGRTd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 12:19:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:52375 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755642AbZBGRTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 12:19:32 -0500
Received: (qmail invoked by alias); 07 Feb 2009 17:19:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 07 Feb 2009 18:19:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/J3/dCtP/JS0SH9qmXsNKBMZ72r5ZYQ/6h0lc/nH
	eSLS9C0/yYWpLs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1234027102u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108868>

Since 6fd2f5e(rebase: operate on a detached HEAD), rebase operates on a
detached HEAD.  However, it used "checkout -q" to detach the HEAD, which
hid an error message when, say, an untracked file would have to be
overwritten to detach the HEAD.

Instead of hiding the output of the checkout in all cases, only hide it
when no error occurred.

While at it, add a test that "rebase" actually operated on a detached
HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase.sh     |    2 +-
 t/t3400-rebase.sh |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6d3eddb..1526fcb 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -434,7 +434,7 @@ fi
 
 # Detach HEAD and reset the tree
 echo "First, rewinding head to replay your work on top of it..."
-git checkout -q "$onto^0" || die "could not detach HEAD"
+error=$(git checkout "$onto" 2>&1) || die "${error}could not detach HEAD"
 git update-ref ORIG_HEAD $branch
 
 # If the $onto is a proper descendant of the tip of the branch, then
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b7a670e..8c0c5f5 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -14,7 +14,8 @@ export GIT_AUTHOR_EMAIL
 
 test_expect_success \
     'prepare repository with topic branches' \
-    'echo First > A &&
+    'git config core.logAllRefUpdates true &&
+     echo First > A &&
      git update-index --add A &&
      git commit -m "Add A." &&
      git checkout -b my-topic-branch &&
@@ -84,4 +85,14 @@ test_expect_success 'rebase a single mode change' '
      GIT_TRACE=1 git rebase master
 '
 
+test_expect_success 'HEAD was detached during rebase' '
+     test $(git rev-parse HEAD@{1}) != $(git rev-parse modechange@{1})
+'
+
+test_expect_success 'Show verbose error when HEAD could not be detached' '
+     : > B &&
+     test_must_fail git rebase topic 2> output.err > output.out &&
+     grep "Untracked working tree file .B. would be overwritten" output.err
+'
+
 test_done
-- 
1.6.1.2.655.g3f285
