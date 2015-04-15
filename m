From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCH] git-p4: Use -m when running p4 changes
Date: Tue, 14 Apr 2015 23:47:40 -0400
Message-ID: <CALM2SnafBHz8YeWtUtQDUgLBP_s9AiJy=9UC6XveqP0zrYMEqA@mail.gmail.com>
References: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>
	<CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 05:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiEIq-0004Z2-UR
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 05:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbbDODrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 23:47:43 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32846 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260AbbDODrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 23:47:41 -0400
Received: by paboj16 with SMTP id oj16so35186379pab.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kNdcXpZjq9asT6Sj+wDK2OAddIEbPaM+GWQ0+fnykVQ=;
        b=NeFrSUGu983KcpnGygjasVCcpkpaIqpcc2cc2prymUwhup/sb9OoSVvF0vmbg62klI
         RBngr5G+7acAKE6+I0bXM2c/HHkVllxB08awLJp4Pv9ROpRNgXnhN8SNlTZ5q6Oo9n8+
         sxgvFEpxOoYr/lpCXJvyQTbRyicveTKm5kHVgzxIThWON0YXHTdVb56FDMEDiGGIZPzt
         72RzCZ9da4vMlTFOpYHNKHGx1Y54FYxUHiOM7KUZvE/CFs4Ehor88RN3L+xNT6OalQng
         nHrx1OuXgEZXH/ggs6SiD+hoEpWjt5rx+wpa3keJvOQIFzYzQn2/ErdrZlvzUZIpP547
         ImoA==
X-Received: by 10.68.114.194 with SMTP id ji2mr42722181pbb.132.1429069660573;
 Tue, 14 Apr 2015 20:47:40 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Tue, 14 Apr 2015 20:47:40 -0700 (PDT)
In-Reply-To: <CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com>
X-Google-Sender-Auth: 7-a3kN27viADCHSQiQVyN7vpuY0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267182>

>From 9cc607667a20317c837afd90d50c078da659b72f Mon Sep 17 00:00:00 2001
From: Lex Spoon <lex@lexspoon.org>
Date: Sat, 11 Apr 2015 10:01:15 -0400
Subject: [PATCH] git-p4: Use -m when running p4 changes

Signed-off-by: Lex Spoon <lex@lexspoon.org>
---
Updated to include a test case

 git-p4.py               | 51 ++++++++++++++++++++++++++++++---------
 t/t9818-git-p4-block.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 11 deletions(-)
 create mode 100755 t/t9818-git-p4-block.sh

diff --git a/git-p4.py b/git-p4.py
index 549022e..2fc8d9c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -740,17 +740,43 @@ def
createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/",
silent
 def originP4BranchesExist():
         return gitBranchExists("origin") or
gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")

-def p4ChangesForPaths(depotPaths, changeRange):
+def p4ChangesForPaths(depotPaths, changeRange, block_size):
     assert depotPaths
-    cmd = ['changes']
-    for p in depotPaths:
-        cmd += ["%s...%s" % (p, changeRange)]
-    output = p4_read_pipe_lines(cmd)
+    assert block_size
+
+    # Parse the change range into start and end
+    if changeRange is None or changeRange == '':
+        changeStart = '@1'
+        changeEnd = '#head'
+    else:
+        parts = changeRange.split(',')
+        assert len(parts) == 2
+        changeStart = parts[0]
+        changeEnd = parts[1]

+    # Accumulate change numbers in a dictionary to avoid duplicates
     changes = {}
-    for line in output:
-        changeNum = int(line.split(" ")[1])
-        changes[changeNum] = True
+
+    for p in depotPaths:
+        # Retrieve changes a block at a time, to prevent running
+        # into a MaxScanRows error from the server.
+        start = changeStart
+        end = changeEnd
+        get_another_block = True
+        while get_another_block:
+            new_changes = []
+            cmd = ['changes']
+            cmd += ['-m', str(block_size)]
+            cmd += ["%s...%s,%s" % (p, start, end)]
+            for line in p4_read_pipe_lines(cmd):
+                changeNum = int(line.split(" ")[1])
+                new_changes.append(changeNum)
+                changes[changeNum] = True
+            if len(new_changes) == block_size:
+                get_another_block = True
+                end = '@' + str(min(new_changes))
+            else:
+                get_another_block = False

     changelist = changes.keys()
     changelist.sort()
@@ -1912,6 +1938,8 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--import-local",
dest="importIntoRemotes", action="store_false",
                                      help="Import into refs/heads/ ,
not refs/remotes"),
                 optparse.make_option("--max-changes", dest="maxChanges"),
+                optparse.make_option("--changes-block-size",
dest="changes_block_size", type="int",
+                                     help="Block size for calling p4 changes"),
                 optparse.make_option("--keep-path",
dest="keepRepoPath", action='store_true',
                                      help="Keep entire
BRANCH/DIR/SUBDIR prefix during import"),
                 optparse.make_option("--use-client-spec",
dest="useClientSpec", action='store_true',
@@ -1940,6 +1968,7 @@ class P4Sync(Command, P4UserMap):
         self.syncWithOrigin = True
         self.importIntoRemotes = True
         self.maxChanges = ""
+        self.changes_block_size = 500
         self.keepRepoPath = False
         self.depotPaths = None
         self.p4BranchesInGit = []
@@ -2578,7 +2607,7 @@ class P4Sync(Command, P4UserMap):

         return ""

-    def importNewBranch(self, branch, maxChange):
+    def importNewBranch(self, branch, maxChange, changes_block_size):
         # make fast-import flush all changes to disk and update the
refs using the checkpoint
         # command so that we can try to find the branch parent in the
git history
         self.gitStream.write("checkpoint\n\n");
@@ -2586,7 +2615,7 @@ class P4Sync(Command, P4UserMap):
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
         #print "prefix" + branchPrefix
-        changes = p4ChangesForPaths([branchPrefix], range)
+        changes = p4ChangesForPaths([branchPrefix], range, changes_block_size)
         if len(changes) <= 0:
             return False
         firstChange = changes[0]
@@ -3002,7 +3031,7 @@ class P4Sync(Command, P4UserMap):
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (',
'.join(self.depotPaths),
                                                               self.changeRange)
-                changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
+                changes = p4ChangesForPaths(self.depotPaths,
self.changeRange, self.changes_block_size)

                 if len(self.maxChanges) > 0:
                     changes = changes[:min(int(self.maxChanges), len(changes))]
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
new file mode 100755
index 0000000..73e545d
--- /dev/null
+++ b/t/t9818-git-p4-block.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='git p4 fetching changes in multiple blocks'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+ start_p4d
+'
+
+test_expect_success 'Create a repo with 100 changes' '
+ (
+ cd "$cli" &&
+ touch file.txt &&
+ p4 add file.txt &&
+ p4 submit -d "Add file.txt" &&
+ for i in 0 1 2 3 4 5 6 7 8 9
+ do
+ touch outer$i.txt &&
+ p4 add outer$i.txt &&
+ p4 submit -d "Adding outer$i.txt" &&
+ for j in 0 1 2 3 4 5 6 7 8 9
+ do
+ p4 edit file.txt &&
+ echo $i$j > file.txt &&
+ p4 submit -d "Commit $i$j"
+ done
+ done
+ )
+'
+
+test_expect_success 'Clone the repo' '
+ git p4 clone --dest="$git" --changes-block-size=10 --verbose //depot@all
+'
+
+test_expect_success 'All files are present' '
+ echo file.txt >expected &&
+ test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt
outer4.txt >>expected &&
+ test_write_lines outer5.txt outer6.txt outer7.txt outer8.txt
outer9.txt >>expected &&
+ ls "$git" >current &&
+ test_cmp expected current
+'
+
+test_expect_success 'file.txt is correct' '
+ echo 99 >expected &&
+ test_cmp expected "$git/file.txt"
+'
+
+test_expect_success 'Correct number of commits' '
+ (cd "$git"; git log --oneline) >log &&
+ test_line_count = 111 log
+'
+
+test_expect_success 'Previous version of file.txt is correct' '
+ (cd "$git"; git checkout HEAD^^) &&
+ echo 97 >expected &&
+ test_cmp expected "$git/file.txt"
+'
+
+test_expect_success 'kill p4d' '
+ kill_p4d
+'
+
+test_done
-- 
1.9.1
