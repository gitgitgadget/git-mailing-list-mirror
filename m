From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 09/14] git p4: allow short ref names to --branch
Date: Mon, 14 Jan 2013 19:47:03 -0500
Message-ID: <1358210828-2369-10-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuujc-0002bF-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab3AOAuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:50:14 -0500
Received: from honk.padd.com ([74.3.171.149]:52482 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757242Ab3AOAuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:50:13 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 318942F3F;
	Mon, 14 Jan 2013 16:50:12 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 59C6028EC2; Mon, 14 Jan 2013 19:50:09 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213560>

For a clone or sync, --branch says where the newly imported
branch should go, or which existing branch to sync up.  It
takes an argument, which is currently either something that
starts with "refs/", or if not, "refs/heads/p4" is prepended.

Putting it in heads seems like a bad default; these should
go in remotes/p4/ in most situations.  Make that the new default,
and be more liberal in the form of the branch name.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt  |  7 +++++--
 git-p4.py                 | 12 +++++++++++-
 t/t9806-git-p4-options.sh | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 7c5230e..7bd5c29 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -173,8 +173,11 @@ subsequent 'sync' operations.
 
 --branch <branch>::
 	Import changes into given branch.  If the branch starts with
-	'refs/', it will be used as is, otherwise the path 'refs/heads/'
-	will be prepended.  The default branch is 'p4/master'.
+	'refs/', it will be used as is.  Otherwise if it does not start
+	with 'p4/', that prefix is added.  The branch is assumed to
+	name a remote tracking, but this can be modified using
+	'--import-local', or by giving a full ref name.  The default
+	branch is 'master'.
 +
 This example imports a new remote "p4/proj2" into an existing
 git repository:
diff --git a/git-p4.py b/git-p4.py
index d92f00c..5dcb527 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2847,8 +2847,18 @@ class P4Sync(Command, P4UserMap):
                 if not self.silent and not self.detectBranches:
                     print "Performing incremental import into %s git branch" % self.branch
 
+        # accept multiple ref name abbreviations:
+        #    refs/foo/bar/branch -> use it exactly
+        #    p4/branch -> prepend refs/remotes/ or refs/heads/
+        #    branch -> prepend refs/remotes/p4/ or refs/heads/p4/
         if not self.branch.startswith("refs/"):
-            self.branch = "refs/heads/" + self.branch
+            if self.importIntoRemotes:
+                prepend = "refs/remotes/"
+            else:
+                prepend = "refs/heads/"
+            if not self.branch.startswith("p4/"):
+                prepend += "p4/"
+            self.branch = prepend + self.branch
 
         if len(args) == 0 and self.depotPaths:
             if not self.silent:
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 2ad3a3e..c0d4433 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -51,6 +51,27 @@ test_expect_failure 'sync when branch is not called master should work' '
 	)
 '
 
+test_expect_success 'sync --branch builds the full ref name correctly' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init &&
+
+		git p4 sync --branch=b1 //depot &&
+		git rev-parse --verify refs/remotes/p4/b1 &&
+		git p4 sync --branch=p4/b2 //depot &&
+		git rev-parse --verify refs/remotes/p4/b2 &&
+
+		git p4 sync --import-local --branch=h1 //depot &&
+		git rev-parse --verify refs/heads/p4/h1 &&
+		git p4 sync --import-local --branch=p4/h2 //depot &&
+		git rev-parse --verify refs/heads/p4/h2 &&
+
+		git p4 sync --branch=refs/stuff //depot &&
+		git rev-parse --verify refs/stuff
+	)
+'
+
 # engages --detect-branches code, which will do filename filtering so
 # no sync to either b1 or b2
 test_expect_success 'sync when two branches but no master should noop' '
-- 
1.8.1.350.gdbf6fd0
