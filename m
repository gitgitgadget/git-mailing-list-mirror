From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 05/14] git p4: create p4/HEAD on initial clone
Date: Mon, 14 Jan 2013 19:46:59 -0500
Message-ID: <1358210828-2369-6-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuuiG-0001RE-VI
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab3AOAsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:48:52 -0500
Received: from honk.padd.com ([74.3.171.149]:52471 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757166Ab3AOAsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:48:52 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 9727432C9;
	Mon, 14 Jan 2013 16:48:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 328C528EC2; Mon, 14 Jan 2013 19:48:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213556>

There is code to create a symbolic reference from p4/HEAD to
p4/master.  This allows saying "git show p4" as a shortcut
to "git show p4/master", for example.

But this reference was only created on the second "git p4 sync"
(or first sync after a clone).  Make it work on the initial
clone or sync.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                 | 12 ++++++++----
 t/t9806-git-p4-options.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8814049..537eac6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2778,10 +2778,7 @@ class P4Sync(Command, P4UserMap):
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
                 system("git update-ref %s refs/heads/p4" % self.branch)
-                system("git branch -D p4");
-            # create it /after/ importing, when master exists
-            if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
-                system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
+                system("git branch -D p4")
 
         # accept either the command-line option, or the configuration variable
         if self.useClientSpec:
@@ -3013,6 +3010,13 @@ class P4Sync(Command, P4UserMap):
                 read_pipe("git update-ref -d %s" % branch)
             os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
 
+        # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
+        # a convenient shortcut refname "p4".
+        if self.importIntoRemotes:
+            head_ref = self.refPrefix + "HEAD"
+            if not gitBranchExists(head_ref) and gitBranchExists(self.branch):
+                system(["git", "symbolic-ref", head_ref, self.branch])
+
         return True
 
 class P4Rebase(Command):
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 844aae0..4900aef 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -83,6 +83,29 @@ test_expect_failure 'sync --branch updates specified branch' '
 	)
 '
 
+# allows using the refname "p4" as a short name for p4/master
+test_expect_success 'clone creates HEAD symbolic reference' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git rev-parse --verify refs/remotes/p4/master >master &&
+		git rev-parse --verify p4 >p4 &&
+		test_cmp master p4
+	)
+'
+
+test_expect_success 'clone --branch creates HEAD symbolic reference' '
+	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git rev-parse --verify refs/remotes/p4/sb >sb &&
+		git rev-parse --verify p4 >p4 &&
+		test_cmp sb p4
+	)
+'
+
 test_expect_success 'clone --changesfile' '
 	test_when_finished "rm cf" &&
 	printf "1\n3\n" >cf &&
-- 
1.8.1.350.gdbf6fd0
