From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2 2/2] git-p4: improve client path detection when branches are used
Date: Sun, 19 Apr 2015 11:56:49 +0100
Message-ID: <1429441009-17775-3-git-send-email-vitor.hda@gmail.com>
References: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 12:57:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjmuo-0001WC-0h
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 12:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbbDSK50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 06:57:26 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37601 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbDSK5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 06:57:24 -0400
Received: by widdi4 with SMTP id di4so62351436wid.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9nB/kIo7576SQlz/7kd5In+a+nHXJt72zVNYxABqGH0=;
        b=VprJpHRUBwpWkHp4JqEczOWlAHbR+22ACn6aUh7PnHs9qOqI24t/6jfsZTJRpvoLgz
         Yg9jfJPNR7RMMq7NHCVML+nSpipWV6pcZ5qU4knQHRw5ULkryViKsPZbWcptBDF2fSUL
         QssWhhtAUyS86bwjkCBkfxcj/Avxmg9F2OOwyE77NXiebLMi7wdq/0wfkDZeA2ACHP1h
         Haa6ebWja0nxAbCeNlwIoBCHzWyonuhhRiZArPjkaimSvBlvXtAXYsZPWM818Mlvy/Oo
         Ul4BRxhE/dmPy+x6T+rVSq8kFl1xpWHh4vcuJwN4OGKpidr3LhKCl08ou9TqCTtX83N8
         hdbw==
X-Received: by 10.194.179.194 with SMTP id di2mr21385384wjc.4.1429441043398;
        Sun, 19 Apr 2015 03:57:23 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id z13sm22576630wjr.44.2015.04.19.03.57.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2015 03:57:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267437>

A client view can be used to remap folder locations in the
workspace. To support this when branch detection is enabled,
it is necessary to get the client path through "p4 where".

This patch does two things to achieve this:

 1. Force usage of "p4 where" when P4 branches exist in the
    git repository.

 2. Search for mappings that contain the depot path, instead
    of requiring an exact match. To guarantee robustness,
    paths only match if ending in "/...".

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py                |   13 +++++++++----
 t/t9801-git-p4-branch.sh |    2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 549022e..34e4fdd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -502,12 +502,14 @@ def p4Cmd(cmd):
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
+            # Search for the base client side depot path, as long as it starts with the branch's P4 path.
+            # The base path always ends with "/...".
+            if entry["depotFile"].find(depotPath) == 0 and entry["depotFile"][-4:] == "/...":
                 output = entry
                 break
         elif "data" in entry:
@@ -1627,7 +1629,10 @@ class P4Submit(Command, P4UserMap):
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
index 36a7f51..0aafd03 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -593,7 +593,7 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
 '
 
 # Now update a file in one of the branches in git and submit to P4
-test_expect_failure 'Update a file in git side and submit to P4 using client view' '
+test_expect_success 'Update a file in git side and submit to P4 using client view' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-- 
1.7.10.4
