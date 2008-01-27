From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2] cvsserver: Fix for histories with multiple roots
Date: Sun, 27 Jan 2008 10:37:09 +0100
Message-ID: <12014266292347-git-send-email-prohaska@zib.de>
References: <7v8x2cyqsg.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 27 10:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ3xl-0006lp-Ef
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 10:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYA0JhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 04:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbYA0JhV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 04:37:21 -0500
Received: from mailer.zib.de ([130.73.108.11]:41047 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbYA0JhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 04:37:18 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0R9bDqj019778;
	Sun, 27 Jan 2008 10:37:13 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0R9b9hR024424;
	Sun, 27 Jan 2008 10:37:09 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <7v8x2cyqsg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71810>

Junio,
here is a replacement for the second patch.  Different from your diff,
I replaced tabs with 8 spaces because all of the surrounding code
uses spaces for indentation.

    Steffen

---- snip ---

Git histories may have multiple roots, which can cause
git merge-base to fail and this caused git cvsserver to die.

This commit teaches git cvsserver to handle a failing git
merge-base gracefully, and modifies the test case to verify this.
All the test cases now use a history with two roots.

Thanks to Junio C Hamano for the implementation that avoids
calling git-merge-base twice.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-cvsserver.perl              |   11 +++++++++--
 t/t9400-git-cvsserver-server.sh |   10 +++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ecded3b..920e7de 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2543,8 +2543,15 @@ sub update
                     if ($parent eq $lastpicked) {
                         next;
                     }
-                    my $base = safe_pipe_capture('git-merge-base',
-						 $lastpicked, $parent);
+                    my $base = eval {
+                            safe_pipe_capture('git-merge-base',
+                                                 $lastpicked, $parent);
+                    };
+                    # The two branches may not be related at all,
+                    # in which case merge base simply fails to find
+                    # any, but that's Ok.
+                    next if ($@);
+
                     chomp $base;
                     if ($base) {
                         my @merged;
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
