From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2] cvsserver: Fix for histories with multiple roots
Date: Sat, 26 Jan 2008 10:54:06 +0100
Message-ID: <12013412462758-git-send-email-prohaska@zib.de>
References: <12013412461111-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 10:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIhkI-0004HJ-Si
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 10:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYAZJyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 04:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYAZJyM
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 04:54:12 -0500
Received: from mailer.zib.de ([130.73.108.11]:34314 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940AbYAZJyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 04:54:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0Q9s7m0002561
	for <git@vger.kernel.org>; Sat, 26 Jan 2008 10:54:07 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0Q9s6Zw008160;
	Sat, 26 Jan 2008 10:54:06 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <12013412461111-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71771>

Git histories may have multiple roots, which can cause
git merge-base to fail and this caused git cvsserver to die.

This commit teaches git cvsserver to handle a failing git
merge-base gracefully, and modifies the test case to verify this.
All the test cases now use a history with two roots.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-cvsserver.perl              |    5 +++++
 t/t9400-git-cvsserver-server.sh |   10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ecded3b..534b41e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2543,6 +2543,11 @@ sub update
                     if ($parent eq $lastpicked) {
                         next;
                     }
+                    # or it may fail to find a merge base.  In this
+                    # case we just ignore this merge.
+                    if (system("git merge-base $lastpicked $parent >/dev/null 2>/dev/null")) {
+                        next;
+                    }
                     my $base = safe_pipe_capture('git-merge-base',
 						 $lastpicked, $parent);
                     chomp $base;
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 1f2749e..75d1ce4 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -37,6 +37,13 @@ test_expect_success 'setup' '
   echo >empty &&
   git add empty &&
   git commit -q -m "First Commit" &&
+  mkdir secondroot &&
+  ( cd secondroot &&
+  git init &&
+  touch secondrootfile &&
+  git add secondrootfile &&
+  git commit -m "second root") &&
+  git pull secondroot master &&
   git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
   GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log"
@@ -46,7 +53,8 @@ test_expect_success 'setup' '
 # as argument to co -d
 test_expect_success 'basic checkout' \
   'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
-   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"'
+   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/"
+   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | tail -n 1))" = "secondrootfile/1.1/"'
 
 #------------------------
 # PSERVER AUTHENTICATION
-- 
1.5.4.rc4.42.gacc73
