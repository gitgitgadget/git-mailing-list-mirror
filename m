From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 07/14] git p4: clone --branch should checkout master
Date: Mon, 14 Jan 2013 19:47:01 -0500
Message-ID: <1358210828-2369-8-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:49:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuuiu-000231-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209Ab3AOAtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:49:32 -0500
Received: from honk.padd.com ([74.3.171.149]:52476 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756802Ab3AOAtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:49:32 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id C15112F3F;
	Mon, 14 Jan 2013 16:49:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4608728EC2; Mon, 14 Jan 2013 19:49:29 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213558>

When using the --branch argument to "git p4 clone", one
might specify a destination for p4 changes different from
the default refs/remotes/p4/master.  Both cases should
create a master branch and checkout files.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt  |  3 +--
 git-p4.py                 | 20 +++++++++-----------
 t/t9806-git-p4-options.sh |  2 +-
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index beff622..2623bee 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -174,8 +174,7 @@ subsequent 'sync' operations.
 --branch <branch>::
 	Import changes into given branch.  If the branch starts with
 	'refs/', it will be used as is, otherwise the path 'refs/heads/'
-	will be prepended.  The default branch is 'master'.  If used
-	with an initial clone, no HEAD will be checked out.
+	will be prepended.  The default branch is 'p4/master'.
 +
 This example imports a new remote "p4/proj2" into an existing
 git repository:
diff --git a/git-p4.py b/git-p4.py
index 537eac6..d92f00c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3124,17 +3124,15 @@ class P4Clone(P4Sync):
 
         if not P4Sync.run(self, depotPaths):
             return False
-        if self.branch != "master":
-            if self.importIntoRemotes:
-                masterbranch = "refs/remotes/p4/master"
-            else:
-                masterbranch = "refs/heads/p4/master"
-            if gitBranchExists(masterbranch):
-                system("git branch master %s" % masterbranch)
-                if not self.cloneBare:
-                    system("git checkout -f")
-            else:
-                print "Could not detect main branch. No checkout/master branch created."
+
+        # create a master branch and check out a work tree
+        if gitBranchExists(self.branch):
+            system([ "git", "branch", "master", self.branch ])
+            if not self.cloneBare:
+                system([ "git", "checkout", "-f" ])
+        else:
+            print 'Not checking out any branch, use ' \
+                  '"git checkout -q -b master <branch>"'
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 4900aef..2ad3a3e 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -27,7 +27,7 @@ test_expect_success 'clone no --git-dir' '
 	test_must_fail git p4 clone --git-dir=xx //depot
 '
 
-test_expect_failure 'clone --branch should checkout master' '
+test_expect_success 'clone --branch should checkout master' '
 	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
-- 
1.8.1.350.gdbf6fd0
