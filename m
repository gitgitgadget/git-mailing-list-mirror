From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 3/3] git-p4: fixing --changes-block-size handling
Date: Sun,  7 Jun 2015 11:21:45 +0100
Message-ID: <1433672505-11940-4-git-send-email-luke@diamand.org>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 12:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Xj7-0004so-3H
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 12:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbbFGKWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 06:22:42 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33778 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbFGKWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 06:22:38 -0400
Received: by wiwd19 with SMTP id d19so58308013wiw.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhWu91HoF/qYvpFYQH0GmV/gJIwyny3xwRCIuWeUSNE=;
        b=E0pccPDfv3cAtYDW+io3BnDBLsv0aqy2yHdXd2WTcck2yb6GDC719hseusX46eO3Fo
         19v/vVVNSSyB8F1N3AAYiqfWGL0penb48hoku+s7WCBBF3P6ZxUEZNiJL6ZAlnZr4HwQ
         +DAJgrWe836MFMjfpSKauWx5Ij7f5rHI80hwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhWu91HoF/qYvpFYQH0GmV/gJIwyny3xwRCIuWeUSNE=;
        b=ht4fcd5nhexxBBr3HBly/4rz/VKmZPUwtQ8kUz5X0xAlrwe3BXeCkeDAE5toYZzV5C
         QD6DE5r5ISL1m7f5u/xHxuzxnjpgR6QlhwyPP2VZWbWYIPE6cQO7gdE7nm6gmttnZQsI
         SFFnKSiHE9RzES+hzTVOSPm7nBJCDUNhVuRPASXfm3v48cXNhZTR3n0NGy8ApZ29ZjiX
         OFIYeGMKeP56yHouMaYbj1hKunZ/5sEriSvmrwDVw5Y2MnOVaPLlv36qMSCdIDsnIx2J
         c583xIMyJjX8F+DcmyO7e5d5H4e53BWSuPj7gcshUPqzcIcI5uGYtaOejwok14CfBAyY
         FZoA==
X-Gm-Message-State: ALoCoQn3/bvW2WZqq3c0ESLQ0z9qXKyx3jy9WiMHI/NJdCbyeIzV5J0ds1FIuubQfuSqtPOL1Hsn
X-Received: by 10.180.91.137 with SMTP id ce9mr11958242wib.76.1433672557129;
        Sun, 07 Jun 2015 03:22:37 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm18911961wjr.48.2015.06.07.03.22.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 03:22:36 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1433672505-11940-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270962>

The --changes-block-size handling was intended to help when
a user has a limited "maxscanrows" (see "p4 group"). It used
"p4 changes -m $maxchanges" to limit the number of results.

Unfortunately, it turns out that the "maxscanrows" and "maxresults"
limits are actually applied *before* the "-m maxchanges" parameter
is considered (experimentally).

Fix the block-size handling so that it gets blocks of changes
limited by revision number ($Start..$Start+$N, etc). This limits
the number of results early enough that both sets of tests pass.

If the --changes-block-size option is not in use, then the code
naturally falls back to the original scheme and gets as many changes
as possible.

Unfortunately, it also turns out that "p4 print" can fail on
files with more changes than "maxscanrows". This fix is unable to
workaround this problem, although in the real world this shouldn't
normally happen.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 48 +++++++++++++++++++++++++++++++++++-------------
 t/t9818-git-p4-block.sh | 12 ++++++------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 26ad4bc..0e29b75 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -744,41 +744,63 @@ def originP4BranchesExist():
 
 def p4ChangesForPaths(depotPaths, changeRange, block_size):
     assert depotPaths
-    assert block_size
 
     # Parse the change range into start and end
     if changeRange is None or changeRange == '':
-        changeStart = '@1'
-        changeEnd = '#head'
+        changeStart = 1
+        changeEnd = None
     else:
         parts = changeRange.split(',')
         assert len(parts) == 2
-        changeStart = parts[0]
-        changeEnd = parts[1]
+        changeStart = int(parts[0][1:])
+        if parts[1] == '#head':
+            changeEnd = None
+        else:
+            changeEnd = int(parts[1])
 
     # Accumulate change numbers in a dictionary to avoid duplicates
     changes = {}
 
+    # We need the most recent change list number if we're operating in
+    # batch mode. For whatever reason, clients with limited MaxResults
+    # can get this for the entire depot, but not for individual bits of
+    # the depot.
+    if block_size:
+        results = p4CmdList(["changes", "-m", "1"])
+        mostRecentCommit = int(results[0]['change'])
+
     for p in depotPaths:
         # Retrieve changes a block at a time, to prevent running
         # into a MaxScanRows error from the server.
         start = changeStart
-        end = changeEnd
         get_another_block = True
         while get_another_block:
             new_changes = []
             cmd = ['changes']
-            cmd += ['-m', str(block_size)]
-            cmd += ["%s...%s,%s" % (p, start, end)]
+
+            if block_size:
+                end = changeStart + block_size    # only fetch a few at a time
+            else:
+                end = changeEnd             # fetch as many as possible
+
+            if end:
+                endStr = str(end)
+            else:
+                endStr = '#head'
+
+            cmd += ["%s...@%d,%s" % (p, changeStart, endStr)]
             for line in p4_read_pipe_lines(cmd):
                 changeNum = int(line.split(" ")[1])
                 new_changes.append(changeNum)
                 changes[changeNum] = True
-            if len(new_changes) == block_size:
-                get_another_block = True
-                end = '@' + str(min(new_changes))
-            else:
+
+            if not block_size:
+                # Not batched, so nothing more to do
                 get_another_block = False
+            elif end >= mostRecentCommit:
+                get_another_block = False
+            else:
+                changeStart = end + 1
 
     changelist = changes.keys()
     changelist.sort()
@@ -1974,7 +1996,7 @@ class P4Sync(Command, P4UserMap):
         self.syncWithOrigin = True
         self.importIntoRemotes = True
         self.maxChanges = ""
-        self.changes_block_size = 500
+        self.changes_block_size = None
         self.keepRepoPath = False
         self.depotPaths = None
         self.p4BranchesInGit = []
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index aae1121..3b3ae1f 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -49,11 +49,11 @@ test_expect_success 'Default user cannot fetch changes' '
 	! p4 changes -m 1 //depot/...
 '
 
-test_expect_failure 'Clone the repo' '
+test_expect_success 'Clone the repo' '
 	git p4 clone --dest="$git" --changes-block-size=7 --verbose //depot/included@all
 '
 
-test_expect_failure 'All files are present' '
+test_expect_success 'All files are present' '
 	echo file.txt >expected &&
 	test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt outer4.txt >>expected &&
 	test_write_lines outer5.txt >>expected &&
@@ -61,18 +61,18 @@ test_expect_failure 'All files are present' '
 	test_cmp expected current
 '
 
-test_expect_failure 'file.txt is correct' '
+test_expect_success 'file.txt is correct' '
 	echo 55 >expected &&
 	test_cmp expected "$git/file.txt"
 '
 
-test_expect_failure 'Correct number of commits' '
+test_expect_success 'Correct number of commits' '
 	(cd "$git" && git log --oneline) >log &&
 	wc -l log &&
 	test_line_count = 43 log
 '
 
-test_expect_failure 'Previous version of file.txt is correct' '
+test_expect_success 'Previous version of file.txt is correct' '
 	(cd "$git" && git checkout HEAD^^) &&
 	echo 53 >expected &&
 	test_cmp expected "$git/file.txt"
@@ -102,7 +102,7 @@ test_expect_success 'Add some more files' '
 
 # This should pick up the 10 new files in "included", but not be confused
 # by the additional files in "excluded"
-test_expect_failure 'Syncing files' '
+test_expect_success 'Syncing files' '
 	(
 		cd "$git" &&
 		git p4 sync --changes-block-size=7 &&
-- 
2.3.4.48.g223ab37
