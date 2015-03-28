From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/2] git-p4: Improve client path detection when branches are used
Date: Sat, 28 Mar 2015 12:28:50 +0000
Message-ID: <1427545730-3563-3-git-send-email-vitor.hda@gmail.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 13:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybps0-0004ca-2V
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 13:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbbC1M3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 08:29:41 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36260 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbC1M3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 08:29:40 -0400
Received: by wgra20 with SMTP id a20so124734372wgr.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gn16mNlwuEnB5ufTHjukPCk714WdwQ65FaKG58vZL10=;
        b=oIl2GkyP9XlokHDUQJ1tI0E9+k7ql6tYEQ7Gp9X68ViCC5XzI0IQ5c9QNU7EwrqL8Y
         MdK56AzORgoWxfT5ko3q1/ATYpFadfXFgX++qoJP3J2EpMN0lVpF3vYfgRmHPgazhjJC
         HNBnTd/bmlIXewJ1cqVV5B8KMsi44nT/kDRhZwZ0LLXRnSs1XK8gtN5q9IWSh15j2yZU
         cVgtlhF0nXWcUsy9OJwFchj2yuO0zS5e9iIORRsnMd1NxHApHDIOVgcTlOrm+zlvzxe6
         KpyhUqqAgJzZJB9NbtoXSHsHmhR58Z3bjqpMtX8EcGEpbN5b3aIXefuYBx3Q+puOd7PY
         CW0g==
X-Received: by 10.180.98.137 with SMTP id ei9mr5631500wib.92.1427545779224;
        Sat, 28 Mar 2015 05:29:39 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id e2sm6948133wjy.46.2015.03.28.05.29.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2015 05:29:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266415>

A client view can be used to remap folder locations in the workspace. To support
this when branch detection is enabled it is necessary to get the client path
through "p4 where". This patch does two things to achieve this:

1. Force usage of "p4 where" when P4 branches exist in the git repository.
2. Search for mappings that contain the depot path, instead of requiring an
   exact match.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 git-p4.py                |   11 +++++++----
 t/t9801-git-p4-branch.sh |    2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 549022e..6954549 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -502,12 +502,12 @@ def p4Cmd(cmd):
 def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
-    depotPath = depotPath + "..."
-    outputList = p4CmdList(["where", depotPath])
+    depotPathLong = depotPath + "..."
+    outputList = p4CmdList(["where", depotPathLong])
     output = None
     for entry in outputList:
         if "depotFile" in entry:
-            if entry["depotFile"] == depotPath:
+            if entry["depotFile"].find(depotPath) >= 0:
                 output = entry
                 break
         elif "data" in entry:
@@ -1627,7 +1627,10 @@ class P4Submit(Command, P4UserMap):
         if self.useClientSpec:
             self.clientSpecDirs = getClientSpec()
 
-        if self.useClientSpec:
+        # Check for the existance of P4 branches
+        branchesDetected = (len(p4BranchesInGit().keys()) > 1)
+
+        if self.useClientSpec and not branchesDetected:
             # all files are relative to the client spec
             self.clientPath = getClientRoot()
         else:
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 2f0361a..4fe4e18 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -585,7 +585,7 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
 '
 
 # Now update a file in one of the branches in git and submit to P4
-test_expect_failure 'Update a file in git side and submit to P4 using client view' '
+test_expect_success 'Update a file in git side and submit to P4 using client view' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-- 
1.7.10.4
