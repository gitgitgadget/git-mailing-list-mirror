From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V3 2/2] git-p4: improve client path detection when branches are used
Date: Tue, 21 Apr 2015 23:49:30 +0100
Message-ID: <1429656570-21825-3-git-send-email-vitor.hda@gmail.com>
References: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 00:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykgzy-0006fr-B4
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 00:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbbDUWu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 18:50:29 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35508 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965137AbbDUWu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 18:50:26 -0400
Received: by widdi4 with SMTP id di4so156663518wid.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O6vjpX5ByPyhAOqgZBfYmEDyHApRlTsjBaMQVj4fQ2M=;
        b=VPQraXnUtsFJ/IT8ZzYpHDg+KFrjNcsZQ0jcfdauFdsgPOlBsy+YZKJ9MY8cdaLHNF
         p5h8Pr0Waz7HPrwa0AfQurFKyFrtwH/dLiYMU32zdW7RG79TXsDTbAyze46ODNuRFJoO
         yrx03M3ob+dmkUw/z2AOkF431C7Q5ekfewQuEM6gbegzZWQ/47pMeOxS2GoufIXOu4IF
         k4nxw8sj7YjVg4tP7NJOyZ5YVRz1K/qBWgsahrkY3S1yikpjruZScDoEatn755wBJPlf
         xSLGhJPkQQQrPlUUrpP3bffinKvu0NP14irazWIIIS1w15JIWQ5RI0F+v+hNaXg7YBCA
         nlPg==
X-Received: by 10.180.95.36 with SMTP id dh4mr503017wib.82.1429656624868;
        Tue, 21 Apr 2015 15:50:24 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id dg8sm4573201wjc.9.2015.04.21.15.50.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 15:50:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267564>

Perforce allows client side file/directory remapping through
the use of the client view definition that is part of the
user's client spec.

To support this functionality while branch detection is
enabled it is important to determine the branch location in
the workspace such that the correct files are patched before
Perforce submission. Perforce provides a command that
facilitates this process: p4 where.

This patch does two things to fix improve file location
detection when git-p4 has branch detection and use of client
spec enabled:

 1. Enable usage of "p4 where" when Perforce branches exist
    in the git repository, even when client specification is
    used. This makes use of the already existing function
    p4Where.

 2. Allow identifying partial matches of the branch's depot
    path while processing the output of "p4 where". For
    robustness, paths will only match if ending in "/...".

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
