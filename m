From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 2/3] git-p4: Search for parent commit on branch creation
Date: Sat, 21 Jan 2012 00:21:31 +0000
Message-ID: <1327105292-30092-3-git-send-email-vitor.hda@gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOin-0005vt-Vz
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624Ab2AUAWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:22:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61679 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab2AUAWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:22:00 -0500
Received: by mail-ww0-f44.google.com with SMTP id ed3so950759wgb.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 16:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M2QFKeDDfkv8G5zcOT6Rsi5T39rK62Zw5x7LemWJF6c=;
        b=uA/WUyGTi7Us56ggAtUHp5aPIe2qxGlmEUILlEG+ZPb4PXgtqOZcoY+zMOGedNxRvf
         bhefn2FeidUmaHMdK9r5oqo3yvs9z3TBFT6TdjtrfFrd1bRrr0yire2lteaQIF3QJghF
         ywOJ3ZNXSIqeuFbYyByn4f/XI0P9QefmyLr5g=
Received: by 10.180.96.161 with SMTP id dt1mr441425wib.13.1327105320017;
        Fri, 20 Jan 2012 16:22:00 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q7sm566234wix.5.2012.01.20.16.21.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 16:21:59 -0800 (PST)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188915>

To find out which is its parent the commit of the new branch is applied
sequentially to each blob of the parent branch from the newest to the
oldest. The first blob which results in a zero diff is considered the
parent commit. If none is found, then the commit is applied to the top
of the parent branch.

A fast-import "checkpoint" call is required for each comparison because
diff-tree is only able to work with blobs on disk. But most of these
commits will not be part of the final imported tree, making fast-import
fail. To avoid this, the temporary branches are tracked and then removed
at the end of the import process.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 417d119..2e3b741 100755
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
@@ -2012,7 +2014,27 @@ class P4Sync(Command, P4UserMap):
                             parent = self.initialParents[branch]
                             del self.initialParents[branch]
 
-                        self.commit(description, filesForCommit, branch, [branchPrefix], parent)
+                        parentFound = False
+                        if len(parent) > 0:
+                            tempBranch = os.path.join(self.tempBranchLocation, "%d" % (change))
+                            if self.verbose:
+                                print "Creating temporary branch: " + tempBranch
+                            self.commit(description, filesForCommit, tempBranch, [branchPrefix])
+                            self.tempBranches.append(tempBranch)
+                            self.checkpoint()
+                            for blob in read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
+                                blob = blob.strip()
+                                if len( read_pipe("git diff-tree %s %s" % (blob, tempBranch)) ) == 0:
+                                    parentFound = True
+                                    if self.verbose:
+                                        print "Found parent of %s in commit %s" % (branch, blob)
+                                    break
+                        if parentFound:
+                            self.commit(description, filesForCommit, branch, [branchPrefix], blob)
+                        else:
+                            if self.verbose:
+                                print "Parent of %s not found. Committing into head of %s" % (branch, parent)
+                            self.commit(description, filesForCommit, branch, [branchPrefix], parent)
                 else:
                     files = self.extractFilesFromCommit(description)
                     self.commit(description, files, self.branch, self.depotPaths,
@@ -2347,6 +2369,12 @@ class P4Sync(Command, P4UserMap):
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
1.7.7.rc2.14.g5e044.dirty
