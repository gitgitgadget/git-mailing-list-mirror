From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/4] git-p4: handle p4 branches and labels containing shell chars
Date: Wed, 30 Nov 2011 09:03:34 +0000
Message-ID: <1322643817-13051-2-git-send-email-luke@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:04:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVg5f-0005FT-BV
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 10:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756Ab1K3JE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 04:04:27 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206Ab1K3JEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 04:04:23 -0500
Received: by mail-bw0-f46.google.com with SMTP id s6so570681bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 01:04:22 -0800 (PST)
Received: by 10.204.0.80 with SMTP id 16mr1325170bka.29.1322643862336;
        Wed, 30 Nov 2011 01:04:22 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id c4sm2565364bkk.13.2011.11.30.01.04.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 01:04:21 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1322643817-13051-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186118>

Don't use shell expansion when detecting branches, as it will
fail if the branch name contains a shell metachar. Similarly
for labels.

Add additional test for branches with shell metachars.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |    8 +++---
 t/t9801-git-p4-branch.sh   |   48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index b975d67..bcac6ec 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -793,7 +793,7 @@ class P4Submit(Command, P4UserMap):
     def canChangeChangelists(self):
         # check to see if we have p4 admin or super-user permissions, either of
         # which are required to modify changelists.
-        results = p4CmdList("protects %s" % self.depotPath)
+        results = p4CmdList(["protects", self.depotPath])
         for r in results:
             if r.has_key('perm'):
                 if r['perm'] == 'admin':
@@ -1528,7 +1528,7 @@ class P4Sync(Command, P4UserMap):
     def getLabels(self):
         self.labels = {}
 
-        l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
+        l = p4CmdList(["labels", "%s..." % ' '.join (self.depotPaths)])
         if len(l) > 0 and not self.silent:
             print "Finding files belonging to labels in %s" % `self.depotPaths`
 
@@ -1570,7 +1570,7 @@ class P4Sync(Command, P4UserMap):
             command = "branches"
 
         for info in p4CmdList(command):
-            details = p4Cmd("branch -o %s" % info["branch"])
+            details = p4Cmd(["branch", "-o", info["branch"]])
             viewIdx = 0
             while details.has_key("View%s" % viewIdx):
                 paths = details["View%s" % viewIdx].split(" ")
@@ -1708,7 +1708,7 @@ class P4Sync(Command, P4UserMap):
         sourceRef = self.gitRefForBranch(sourceBranch)
         #print "source " + sourceBranch
 
-        branchParentChange = int(p4Cmd("changes -m 1 %s...@1,%s" % (sourceDepotPath, firstChange))["change"])
+        branchParentChange = int(p4Cmd(["changes", "-m", "1", "%s...@1,%s" % (sourceDepotPath, firstChange)])["change"])
         #print "branch parent: %s" % branchParentChange
         gitParent = self.gitCommitByP4Change(sourceRef, branchParentChange)
         if len(gitParent) > 0:
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index a25f18d..bd08dff 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -226,6 +226,54 @@ test_expect_success 'git-p4 clone simple branches' '
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
