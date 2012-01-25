From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 1/3] git-p4: Search for parent commit on branch creation
Date: Wed, 25 Jan 2012 23:48:22 +0000
Message-ID: <1327535304-11332-2-git-send-email-vitor.hda@gmail.com>
References: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 00:48:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqCaD-0002PC-S1
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 00:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab2AYXsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 18:48:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60432 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2AYXsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 18:48:43 -0500
Received: by wgbed3 with SMTP id ed3so3269wgb.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 15:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wkEBhpUsyaHTCZ4+c9ODybdgKYzvkdJgW/J3FocTt/s=;
        b=PvVmOd5/2PEJypCrgjNG3EpfaZNOwQ2NtLYxnjoZXZT/PNlvPeE0kZ3+p7WY9pKCrP
         3Qd6hXRxsJzoMmSRq6C2FcHs1PGGwwTCbb8j4EnC6t7VQnnmhjGXxBCKCTRkHAHzOQSW
         YORh1K5FarWuhsu2RirDpq9+0QQkvxrYJ4NXc=
Received: by 10.180.73.111 with SMTP id k15mr372414wiv.5.1327535322311;
        Wed, 25 Jan 2012 15:48:42 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id df2sm2551041wib.4.2012.01.25.15.48.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 15:48:41 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189136>

To find out which is its parent the commit of the new branch is compared
sequentially to each blob of the parent branch from the newest to the
oldest. The first blob which results in a zero diff is considered the
parent commit. If none is found, then the commit is applied to the top
of the parent branch.

A fast-import "checkpoint" call is required because diff-tree is only
able to work with blobs on disk. But most of these commits will not be
part of the final imported tree, making fast-import fail. To avoid this,
the temporary branches are tracked and then removed at the end of the
import process.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   46 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3e1aa27..584cc41 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1429,6 +1429,8 @@ class P4Sync(Command, P4UserMap):
         self.cloneExclude = []
         self.useClientSpec = False
         self.clientSpecDirs = None
+        self.tempBranches = []
+        self.tempBranchLocation = "git-p4-tmp"
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -1450,6 +1452,14 @@ class P4Sync(Command, P4UserMap):
                    .replace("%25", "%")
         return path
 
+    # Force a checkpoint in fast-import and wait for it to finish
+    def checkpoint(self):
+        self.gitStream.write("checkpoint\n\n")
+        self.gitStream.write("progress checkpoint\n\n")
+        out = self.gitOutput.readline()
+        if self.verbose:
+            print "checkpoint finished: " + out
+
     def extractFilesFromCommit(self, commit):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
@@ -1948,6 +1958,20 @@ class P4Sync(Command, P4UserMap):
         self.importChanges(changes)
         return True
 
+    def searchParent(self, parent, branch, target):
+        parentFound = False
+        for blob in read_pipe_lines(["git", "rev-list", "--reverse", "--no-merges", parent]):
+            blob = blob.strip()
+            if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
+                parentFound = True
+                if self.verbose:
+                    print "Found parent of %s in commit %s" % (branch, blob)
+                break
+        if parentFound:
+            return blob
+        else:
+            return None
+
     def importChanges(self, changes):
         cnt = 1
         for change in changes:
@@ -2004,7 +2028,21 @@ class P4Sync(Command, P4UserMap):
                             parent = self.initialParents[branch]
                             del self.initialParents[branch]
 
-                        self.commit(description, filesForCommit, branch, [branchPrefix], parent)
+                        blob = None
+                        if len(parent) > 0:
+                            tempBranch = os.path.join(self.tempBranchLocation, "%d" % (change))
+                            if self.verbose:
+                                print "Creating temporary branch: " + tempBranch
+                            self.commit(description, filesForCommit, tempBranch, [branchPrefix])
+                            self.tempBranches.append(tempBranch)
+                            self.checkpoint()
+                            blob = self.searchParent(parent, branch, tempBranch)
+                        if blob:
+                            self.commit(description, filesForCommit, branch, [branchPrefix], blob)
+                        else:
+                            if self.verbose:
+                                print "Parent of %s not found. Committing into head of %s" % (branch, parent)
+                            self.commit(description, filesForCommit, branch, [branchPrefix], parent)
                 else:
                     files = self.extractFilesFromCommit(description)
                     self.commit(description, files, self.branch, self.depotPaths,
@@ -2339,6 +2377,12 @@ class P4Sync(Command, P4UserMap):
         self.gitOutput.close()
         self.gitError.close()
 
+        # Cleanup temporary branches created during import
+        if self.tempBranches != []:
+            for branch in self.tempBranches:
+                read_pipe("git update-ref -d %s" % branch)
+            os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
+
         return True
 
 class P4Rebase(Command):
-- 
1.7.8.3
