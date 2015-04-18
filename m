From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git-p4: Improve client path detection when branches are used
Date: Sun, 19 Apr 2015 00:24:05 +0100
Message-ID: <1429399445-11024-1-git-send-email-vitor.hda@gmail.com>
References: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 01:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjc6H-0003TF-PT
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 01:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbbDRXYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 19:24:32 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35469 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbDRXYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 19:24:32 -0400
Received: by widdi4 with SMTP id di4so59411968wid.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8XeKfEoeyogsn2Iw7RpEmk7tyZZ1d0prg5+5kgnZvc=;
        b=WSei7i1eg8m9s74PliYu/q1zej0uXphgpT9qrMfczqhD2CW4tDdzD92HkYtN8vE4Zx
         2mupofjNmJ8nU7u33dJsKF/lNl/0KXo/sgCIhWwC2WY8WfptTjYOSYzt9uAITEmK0teM
         fRymijQf5Sat8RpBARG79zz6kqQC4otzXFgGdU6yTrPNk4H9YrEzNV2cfAQXiFWfYTWt
         q6tfwYdvKr55+9Q5WYa/ZFe/tyLzweC9gfVRaYgfTVLkltNnHXeaeUVsgRO4mB3mX2c+
         N8LJCfvJOFETBIOWgFu3xnBeeANo4wvn6zqvPZQvlvDIsuqnkHLEHy+K/hr2Rir5A2af
         wbMQ==
X-Received: by 10.180.72.230 with SMTP id g6mr13189255wiv.39.1429399470831;
        Sat, 18 Apr 2015 16:24:30 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id gu7sm8747107wib.21.2015.04.18.16.24.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 16:24:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267428>

This patch makes the client path detection more robust by limiting the valid
results from p4 where. The test case is also made more complex, to guarantee
that such client views are supported.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 git-p4.py                |    4 +++-
 t/t9801-git-p4-branch.sh |   12 ++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 262a95b..28d0d90 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -507,7 +507,9 @@ def p4Where(depotPath):
     output = None
     for entry in outputList:
         if "depotFile" in entry:
-            if entry["depotFile"].find(depotPath) >= 0:
+            # Search for the base client side depot path, as long as it starts with the branch's P4 path.
+            # The base path always ends with "/...".
+            if entry["depotFile"].find(depotPath) == 0 and entry["depotFile"][-4:] == "/...":
                 output = entry
                 break
         elif "data" in entry:
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 4fe4e18..0aafd03 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -512,23 +512,28 @@ test_expect_success 'restart p4d' '
 #
 # 1: //depot/branch1/base/file1
 #    //depot/branch1/base/file2
+#    //depot/branch1/base/dir/sub_file1
 # 2: integrate //depot/branch1/base/... -> //depot/branch2/base/...
 # 3: //depot/branch1/base/file3
 # 4: //depot/branch1/base/file2 (edit)
 # 5: integrate //depot/branch1/base/... -> //depot/branch3/base/...
 #
-# Note: the client view remove the "base" folder from the workspace
+# Note: the client view removes the "base" folder from the workspace
+#       and moves sub_file1 one level up.
 test_expect_success 'add simple p4 branches with common base folder on each branch' '
 	(
 		cd "$cli" &&
 		client_view "//depot/branch1/base/... //client/branch1/..." \
+			    "//depot/branch1/base/dir/sub_file1 //client/branch1/sub_file1" \
 			    "//depot/branch2/base/... //client/branch2/..." \
 			    "//depot/branch3/base/... //client/branch3/..." &&
 		mkdir -p branch1 &&
 		cd branch1 &&
 		echo file1 >file1 &&
 		echo file2 >file2 &&
-		p4 add file1 file2 &&
+		mkdir dir &&
+		echo sub_file1 >sub_file1 &&
+		p4 add file1 file2 sub_file1 &&
 		p4 submit -d "Create branch1" &&
 		p4 integrate //depot/branch1/base/... //depot/branch2/base/... &&
 		p4 submit -d "Integrate branch2 from branch1" &&
@@ -561,16 +566,19 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
 		test -f file1 &&
 		test -f file2 &&
 		test -f file3 &&
+		test -f sub_file1 &&
 		grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test -f file1 &&
 		test -f file2 &&
 		test ! -f file3 &&
+		test -f sub_file1 &&
 		! grep update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test -f file1 &&
 		test -f file2 &&
 		test -f file3 &&
+		test -f sub_file1 &&
 		grep update file2 &&
 		cd "$cli" &&
 		cd branch1 &&
-- 
1.7.10.4
