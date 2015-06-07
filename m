From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 3/3] git-p4: fixing --changes-block-size handling
Date: Sun,  7 Jun 2015 22:35:05 +0100
Message-ID: <1433712905-7508-4-git-send-email-luke@diamand.org>
References: <55747A05.3070704@diamand.org>
 <1433712905-7508-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 23:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1iEq-0007IA-2b
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 23:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbFGVgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 17:36:05 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33871 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbFGVgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 17:36:00 -0400
Received: by wgv5 with SMTP id 5so89593810wgv.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=emT3snoqGSc9aLE1uIRyKh+GId/lHAaPElseCi3WHuI=;
        b=ZSqnv38mVPJBZSvY2WPrjLmMMACfQFtj1/0G3cIU+i9R2n4gE8HkFZ0PgjZQWA7EMM
         xRThtLdasganN64ZaxUDOOjHFW1hgeCcbrpuq/UR4rNatbJ7ykmi5vFc+Tw7gQ/zmqCH
         kfENL+qqUeHBITZYCEyEjwpQN3NHMfiQpjkog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=emT3snoqGSc9aLE1uIRyKh+GId/lHAaPElseCi3WHuI=;
        b=KXZYgBFg3j+rcZeyc1vFbrWuix+79NUpdC4fWKu5vCoCGPgqY/SGVnS5+ybhGLIeB4
         JCjteRE60r3nl4Tkzf/i3pkYsC8mTdCAQPSQ2G1hyvlZex2+kJ+JB6ayTvDD+4AX3SKD
         W6Ck4ob7717Hpnz2r3J1Nud+krp5TB4i++0wlW74kDl/TSHJbZZs/igP8flYnEd5tHpb
         SGX1eOK0IB8FVC6ux0me4u4bgmqGBwmjiR/YFh6HYcD1SXvhVWTuHTCnyZSOuw0q4fPB
         ImOgSZ6LYH+uuqId9qbIyrGV8JIqefGC1BDoe+XDBIb5WW13LUFBpRS+rYO4oUmLhs3t
         DxHA==
X-Gm-Message-State: ALoCoQlL7Wg6z7tSY/zM8Ov9ykFtb7VdDVlCRf4wgDSpbS15KAmiHkVcsEIf+UYEs3NqV5b5q/Z9
X-Received: by 10.180.72.145 with SMTP id d17mr16106409wiv.69.1433712958788;
        Sun, 07 Jun 2015 14:35:58 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm1140489wjr.48.2015.06.07.14.35.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 14:35:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433712905-7508-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270983>

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
 git-p4.py               | 45 ++++++++++++++++++++++++++++-----------------
 t/t9818-git-p4-block.sh | 12 ++++++------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 26ad4bc..4be0037 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -249,6 +249,10 @@ def p4_reopen(type, f):
 def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
+def p4_last_change():
+    results = p4CmdList(["changes", "-m", "1"])
+    return int(results[0]['change'])
+
 def p4_describe(change):
     """Make sure it returns a valid result by checking for
        the presence of field "time".  Return a dict of the
@@ -746,39 +750,46 @@ def p4ChangesForPaths(depotPaths, changeRange, block_size):
     assert depotPaths
     assert block_size
 
+    # We need the most recent change list number since we can't just
+    # use #head in block mode.
+    lastChange = p4_last_change()
+
     # Parse the change range into start and end
     if changeRange is None or changeRange == '':
-        changeStart = '@1'
-        changeEnd = '#head'
+        changeStart = 1
+        changeEnd = lastChange
     else:
         parts = changeRange.split(',')
         assert len(parts) == 2
-        changeStart = parts[0]
-        changeEnd = parts[1]
+        changeStart = int(parts[0][1:])
+        if parts[1] == '#head':
+            changeEnd = lastChange
+        else:
+            changeEnd = int(parts[1])
 
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
+            end = min(changeEnd, changeStart + block_size)
+
             cmd = ['changes']
-            cmd += ['-m', str(block_size)]
-            cmd += ["%s...%s,%s" % (p, start, end)]
+            cmd += ["%s...@%d,%d" % (p, changeStart, end)]
+
+            new_changes = []
             for line in p4_read_pipe_lines(cmd):
                 changeNum = int(line.split(" ")[1])
                 new_changes.append(changeNum)
                 changes[changeNum] = True
-            if len(new_changes) == block_size:
-                get_another_block = True
-                end = '@' + str(min(new_changes))
-            else:
-                get_another_block = False
+
+            if end >= changeEnd:
+                break
+
+            changeStart = end + 1
 
     changelist = changes.keys()
     changelist.sort()
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
