From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 4/4] git-p4: fixing --changes-block-size handling
Date: Wed, 10 Jun 2015 08:30:59 +0100
Message-ID: <1433921459-16555-5-git-send-email-luke@diamand.org>
References: <1433921459-16555-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 09:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aUn-0000Pl-DJ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbbFJHcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:32:13 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37313 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933188AbbFJHb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:31:59 -0400
Received: by wifx6 with SMTP id x6so37738314wif.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z6lMyUP4xn9+V9fwBg1hRGdS7opJu/g0DTiVIk1njLM=;
        b=HHFv9+DBUaE4ntx8T4+fkOfJ1K0J31+K5+mfT5y/iOQqTWCbkr3EDc0E4cmE75C2Jc
         8vdtTgcWWn3iE8lGcu8Z7TE3E8OMtUsK5rceNa/YMdoaSWOO4pojMrNTeGDVHxpm/cl/
         23PGDgZVeS/143DtAlKGrjhiivaM6IoPYUKo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z6lMyUP4xn9+V9fwBg1hRGdS7opJu/g0DTiVIk1njLM=;
        b=m8/A0raTK2IUQRdSTQR64oH1JwIWrGsDhSsroDrUjD3+T74VPJ0RctBB/B9qkpoD6E
         DoZAKJhM13zR/UBvxLvZeutAbshZE8zLOytTgmgNFTv3n8vIsWaekqvmYdPWoz+PXrW8
         gy9WBOXg1mfqt/UvqsSgNdH5J22RoT5g014GpFTzk5/QZaJuAwjSxJ0cCdDmwAd2eYCr
         6YoeWYK7fosSWT1XL1VjzcTMAL/Ek7/2udCLLkb1ZkhYnXJtrgtqwxAHpuGKaHiN+54a
         6DP/MBFkGyw0xKXSehTfys3CW8LhpvqkgoVvjNmoSmYsGbw/+0SWNcs/ClJkk4iRgn0L
         NtAg==
X-Gm-Message-State: ALoCoQnGpZib0u/89joz4+CjKpOJOU+oSTs0dmkt1UFaSuGfBdH1rrPe0UXa1DK+Wz++1mwneaQ+
X-Received: by 10.194.234.40 with SMTP id ub8mr3626077wjc.21.1433921518666;
        Wed, 10 Jun 2015 00:31:58 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id n8sm6453997wiy.19.2015.06.10.00.31.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 00:31:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433921459-16555-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271266>

The --changes-block-size handling was intended to help when
a user has a limited "maxscanrows" (see "p4 group"). It used
"p4 changes -m $maxchanges" to limit the number of results.

Unfortunately, it turns out that the "maxscanrows" and "maxresults"
limits are actually applied *before* the "-m maxchanges" parameter
is considered (experimentally).

Fix the block-size handling so that it gets blocks of changes
limited by revision number ($Start..$Start+$N, etc). This limits
the number of results early enough that both sets of tests pass.

Note that many other Perforce operations can fail for the same
reason (p4 print, p4 files, etc) and it's probably not possible
to workaround this. In the real world, this is probably not
usually a problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 85 ++++++++++++++++++++++++++++++++++++-------------
 t/t9818-git-p4-block.sh | 12 +++----
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 26ad4bc..073f87b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -43,6 +43,9 @@ verbose = False
 # Only labels/tags matching this will be imported/exported
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
+# Grab changes in blocks of this many revisions, unless otherwise requested
+defaultBlockSize = 512
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -249,6 +252,10 @@ def p4_reopen(type, f):
 def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
+def p4_last_change():
+    results = p4CmdList(["changes", "-m", "1"])
+    return int(results[0]['change'])
+
 def p4_describe(change):
     """Make sure it returns a valid result by checking for
        the presence of field "time".  Return a dict of the
@@ -742,43 +749,77 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
-def p4ChangesForPaths(depotPaths, changeRange, block_size):
+
+def p4ParseNumericChangeRange(parts):
+    changeStart = int(parts[0][1:])
+    if parts[1] == '#head':
+        changeEnd = p4_last_change()
+    else:
+        changeEnd = int(parts[1])
+
+    return (changeStart, changeEnd)
+
+def chooseBlockSize(blockSize):
+    if blockSize:
+        return blockSize
+    else:
+        return defaultBlockSize
+
+def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     assert depotPaths
-    assert block_size
 
-    # Parse the change range into start and end
+    # Parse the change range into start and end. Try to find integer
+    # revision ranges as these can be broken up into blocks to avoid
+    # hitting server-side limits (maxrows, maxscanresults). But if
+    # that doesn't work, fall back to using the raw revision specifier
+    # strings, without using block mode.
+
     if changeRange is None or changeRange == '':
-        changeStart = '@1'
-        changeEnd = '#head'
+        changeStart = 1
+        changeEnd = p4_last_change()
+        block_size = chooseBlockSize(requestedBlockSize)
     else:
         parts = changeRange.split(',')
         assert len(parts) == 2
-        changeStart = parts[0]
-        changeEnd = parts[1]
+        try:
+            (changeStart, changeEnd) = p4ParseNumericChangeRange(parts)
+            block_size = chooseBlockSize(requestedBlockSize)
+        except:
+            changeStart = parts[0][1:]
+            changeEnd = parts[1]
+            if requestedBlockSize:
+                die("cannot use --changes-block-size with non-numeric revisions")
+            block_size = None
 
     # Accumulate change numbers in a dictionary to avoid duplicates
     changes = {}
 
     for p in depotPaths:
         # Retrieve changes a block at a time, to prevent running
-        # into a MaxScanRows error from the server.
-        start = changeStart
-        end = changeEnd
-        get_another_block = True
-        while get_another_block:
-            new_changes = []
+        # into a MaxResults/MaxScanRows error from the server.
+
+        while True:
             cmd = ['changes']
-            cmd += ['-m', str(block_size)]
-            cmd += ["%s...%s,%s" % (p, start, end)]
+
+            if block_size:
+                end = min(changeEnd, changeStart + block_size)
+                revisionRange = "%d,%d" % (changeStart, end)
+            else:
+                revisionRange = "%s,%s" % (changeStart, changeEnd)
+
+            cmd += ["%s...@%s" % (p, revisionRange)]
+
             for line in p4_read_pipe_lines(cmd):
                 changeNum = int(line.split(" ")[1])
-                new_changes.append(changeNum)
                 changes[changeNum] = True
-            if len(new_changes) == block_size:
-                get_another_block = True
-                end = '@' + str(min(new_changes))
-            else:
-                get_another_block = False
+
+            if not block_size:
+                break
+
+            if end >= changeEnd:
+                break
+
+            changeStart = end + 1
 
     changelist = changes.keys()
     changelist.sort()
@@ -1974,7 +2015,7 @@ class P4Sync(Command, P4UserMap):
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
2.4.1.502.gb11c5ab
