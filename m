From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/4] git-p4: handle p4 branches and labels containing shell chars
Date: Mon, 16 Jan 2012 23:14:46 +0000
Message-ID: <1326755689-3344-2-git-send-email-luke@diamand.org>
References: <1326755689-3344-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 00:15:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmvlj-0008Dy-Hr
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab2APXPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 18:15:06 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45212 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2APXPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:15:04 -0500
Received: by wgbdq11 with SMTP id dq11so1211614wgb.1
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:15:03 -0800 (PST)
Received: by 10.180.101.161 with SMTP id fh1mr12937100wib.0.1326755703508;
        Mon, 16 Jan 2012 15:15:03 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id hv1sm13727543wib.1.2012.01.16.15.15.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 15:15:02 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1326755689-3344-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188669>

Don't use shell expansion when detecting branches, as it will
fail if the branch name contains a shell metachar. Similarly
for labels.

Add additional test for branches with shell metachars.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4        |    8 +++---
 t/t9803-git-p4-shell-metachars.sh |   48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3e1aa27..822e6f1 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -799,7 +799,7 @@ class P4Submit(Command, P4UserMap):
     def canChangeChangelists(self):
         # check to see if we have p4 admin or super-user permissions, either of
         # which are required to modify changelists.
-        results = p4CmdList("protects %s" % self.depotPath)
+        results = p4CmdList(["protects", self.depotPath])
         for r in results:
             if r.has_key('perm'):
                 if r['perm'] == 'admin':
@@ -1758,7 +1758,7 @@ class P4Sync(Command, P4UserMap):
     def getLabels(self):
         self.labels = {}
 
-        l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
+        l = p4CmdList(["labels", "%s..." % ' '.join (self.depotPaths)])
         if len(l) > 0 and not self.silent:
             print "Finding files belonging to labels in %s" % `self.depotPaths`
 
@@ -1800,7 +1800,7 @@ class P4Sync(Command, P4UserMap):
             command = "branches"
 
         for info in p4CmdList(command):
-            details = p4Cmd("branch -o %s" % info["branch"])
+            details = p4Cmd(["branch", "-o", info["branch"]])
             viewIdx = 0
             while details.has_key("View%s" % viewIdx):
                 paths = details["View%s" % viewIdx].split(" ")
@@ -1938,7 +1938,7 @@ class P4Sync(Command, P4UserMap):
         sourceRef = self.gitRefForBranch(sourceBranch)
         #print "source " + sourceBranch
 
-        branchParentChange = int(p4Cmd("changes -m 1 %s...@1,%s" % (sourceDepotPath, firstChange))["change"])
+        branchParentChange = int(p4Cmd(["changes", "-m", "1", "%s...@1,%s" % (sourceDepotPath, firstChange)])["change"])
         #print "branch parent: %s" % branchParentChange
         gitParent = self.gitCommitByP4Change(sourceRef, branchParentChange)
         if len(gitParent) > 0:
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index db04375..db67020 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -57,6 +57,54 @@ test_expect_success 'deleting with shell metachars' '
 	)
 '
 
+# Create a branch with a shell metachar in its name
+#
+# 1. //depot/main
+# 2. //depot/branch$3
+
+test_expect_success 'branch with shell char' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$cli" &&
+
+		mkdir -p main &&
+
+		echo f1 >main/f1 &&
+		p4 add main/f1 &&
+		p4 submit -d "main/f1" &&
+
+		p4 integrate //depot/main/... //depot/branch\$3/... &&
+		p4 submit -d "integrate main to branch\$3" &&
+
+		echo f1 >branch\$3/shell_char_branch_file &&
+		p4 add branch\$3/shell_char_branch_file &&
+		p4 submit -d "branch\$3/shell_char_branch_file" &&
+
+		p4 branch -i <<-EOF &&
+		Branch: branch\$3
+		View: //depot/main/... //depot/branch\$3/...
+		EOF
+
+		p4 edit main/f1 &&
+		echo "a change" >> main/f1 &&
+		p4 submit -d "a change" main/f1 &&
+
+		p4 integrate -b branch\$3 &&
+		p4 resolve -am branch\$3/... &&
+		p4 submit -d "integrate main to branch\$3" &&
+
+		cd "$git" &&
+
+		git config git-p4.branchList main:branch\$3 &&
+		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch\$3 &&
+		test -f shell_char_branch_file &&
+		test -f f1
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.rc1.209.geac91.dirty
