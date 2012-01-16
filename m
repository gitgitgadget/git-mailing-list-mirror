From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/3] git-p4: Search for parent commit on branch creation
Date: Mon, 16 Jan 2012 00:39:19 +0000
Message-ID: <1326674360-2771-3-git-send-email-vitor.hda@gmail.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 01:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmac7-000672-4L
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 01:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab2APAjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 19:39:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:57843 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2APAjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 19:39:48 -0500
Received: by werb13 with SMTP id b13so1632830wer.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+1gkGh3G/mPd3OcNnBxdC9LdPCi4wDffDEyW144iqbE=;
        b=wlXjQQQzGdqJuKzNfW36sKPP97h3t83CLpPPbDdE13OQPd3+FLEMuNdBwIrCPJ7Avn
         Y/X1Wl3pewyyLaDDkd1UMnYYmx3t9Gj+qZX0CHjVknwyJHm+vuW3DH7QiHKjpZEY0JEa
         kZ2YP87r6SMFNK42jC95B8phe2ikSocIeGqyI=
Received: by 10.216.133.143 with SMTP id q15mr2787169wei.12.1326674387634;
        Sun, 15 Jan 2012 16:39:47 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q5sm20225601wbo.8.2012.01.15.16.39.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 16:39:46 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188603>

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
 contrib/fast-import/git-p4 |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 417d119..e2f9165 100755
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
@@ -2012,7 +2014,28 @@ class P4Sync(Command, P4UserMap):
                             parent = self.initialParents[branch]
                             del self.initialParents[branch]
 
-                        self.commit(description, filesForCommit, branch, [branchPrefix], parent)
+                        parentFound = 0
+                        if len(parent) > 0:
+                            self.checkpoint()
+                            for blob in read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
+                                blob = blob.strip()
+                                tempBranch = self.tempBranchLocation + os.sep + "%d-%s" % (change, blob)
+                                if self.verbose:
+                                    print "Creating temporary branch: " + tempBranch
+                                self.commit(description, filesForCommit, tempBranch, [branchPrefix], blob)
+                                self.tempBranches.append(tempBranch)
+                                self.checkpoint()
+                                if len( read_pipe("git diff-tree %s %s" % (blob, tempBranch)) ) == 0:
+                                    parentFound = 1
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
@@ -2347,6 +2370,12 @@ class P4Sync(Command, P4UserMap):
         self.gitOutput.close()
         self.gitError.close()
 
+        # Cleanup temporary branches created during import
+        if self.tempBranches != []:
+            for branch in self.tempBranches:
+                os.remove(".git" + os.sep + branch)
+            os.rmdir(".git" + os.sep + self.tempBranchLocation)
+
         return True
 
 class P4Rebase(Command):
-- 
1.7.8.3
