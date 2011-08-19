From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH/RFC 1/2] git-p4: Search for parent commit on branch creation
Date: Fri, 19 Aug 2011 01:09:49 +0100
Message-ID: <1313712590-26876-2-git-send-email-vitor.hda@gmail.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 02:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCgO-0007Dk-7V
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 02:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab1HSALI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 20:11:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59052 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab1HSALG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 20:11:06 -0400
Received: by wyg24 with SMTP id 24so1766479wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vF+XZqB0k8S4SmWnP6aoGQ5APHKN6uvMWgNN7Vl1X6E=;
        b=ko3/8mhkOZ1g2pnlGlBGplbGhlbWqhX5tdcMH5T4C3XDdQ2kDZjDLyf1Hsz/2oK1L5
         QrrqrwfrdociMSH08TVQlxF/HQeRp0rAu8SX7FdwyqHFDF4dc8Jes0CSaauIU5PQ6Mgj
         Cj99Vav7f6ovmiZWSxLWhfj+A2rcE7n+oq8oE=
Received: by 10.227.25.74 with SMTP id y10mr2504003wbb.38.1313712664824;
        Thu, 18 Aug 2011 17:11:04 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2152633wbb.49.2011.08.18.17.11.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 17:11:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179665>

The new commit is applied sequentially to each blob of the parent branch. The
first blob which results in a zero diff with the new commit is considered the
parent commit. If none is found, then the commit is applied to the top of the
parent branch.
This algorithm requires a checkpoint and a time.sleep() to be able to use
diff-tree, making it slower than what would be desirable. It also requires using
--force argument of fast-import, leaving lots of trash commits when finished.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index f622a38..0bced6d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1671,7 +1671,25 @@ class P4Sync(Command, P4UserMap):
                             parent = self.initialParents[branch]
                             del self.initialParents[branch]
 
-                        self.commit(description, filesForCommit, branch, [branchPrefix], parent)
+                        parentFound = 0
+                        if len(parent) > 0:
+                            self.gitStream.write("checkpoint\n\n")
+                            time.sleep(0.1)
+                            for blob in read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
+                                blob = blob.strip()
+                                self.gitStream.write("reset %s\nfrom %s\n" % (branch, blob))
+                                self.commit(description, filesForCommit, branch, [branchPrefix], blob)
+                                self.gitStream.write("checkpoint\n\n")
+                                time.sleep(0.1)
+                                if len( read_pipe("git diff-tree %s %s" % (blob, branch)) ) == 0:
+                                    parentFound = 1
+                                    if self.verbose:
+                                        print "Found parent of %s in commit %s" % (branch, blob)
+                                    break
+                        if not parentFound:
+                            if self.verbose:
+                                print "Parent of %s not found. Committing into head of %s" % (branch, parent)
+                            self.commit(description, filesForCommit, branch, [branchPrefix], parent)
                 else:
                     files = self.extractFilesFromCommit(description)
                     self.commit(description, files, self.branch, self.depotPaths,
@@ -1948,7 +1966,7 @@ class P4Sync(Command, P4UserMap):
 
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
 
-        importProcess = subprocess.Popen(["git", "fast-import"],
+        importProcess = subprocess.Popen(["git", "fast-import", "--force"],
                                          stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                          stderr=subprocess.PIPE);
         self.gitOutput = importProcess.stdout
-- 
1.7.5.4
