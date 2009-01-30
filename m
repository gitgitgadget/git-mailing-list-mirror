From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] mergetool: Add a test for running mergetool in a sub-directory
Date: Fri, 30 Jan 2009 23:20:10 +0000
Message-ID: <1233357611-31820-1-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org,
	=?utf-8?q?Jonas=20Flod=C3=A9n?= <jonas.floden@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 00:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2gA-0001Ub-Rx
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 00:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbZA3XUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 18:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbZA3XUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 18:20:16 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:21525 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754206AbZA3XUO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 18:20:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEADAag0nUnw4T/2dsb2JhbADKP4QQBg
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.ptn-ipout02.plus.net with ESMTP; 30 Jan 2009 23:20:13 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1LT2ei-0005pa-Jx; Fri, 30 Jan 2009 23:20:12 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UNKB3T031860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 23:20:11 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UNKBGA031859;
	Fri, 30 Jan 2009 23:20:11 GMT
X-Mailer: git-send-email 1.6.1.235.gc9d403
X-Plusnet-Relay: e8e11d2072d4f546111de4636de1ee64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107884>

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 t/t7610-mergetool.sh |   70 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index edb6a57..ee8589e 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -9,49 +9,81 @@ Testing basic merge tool invocation'
 
 . ./test-lib.sh
 
+# All the mergetool test work by checking out a temporary branch based
+# off 'branch1' and then merging in master and checking the results of
+# running mergetool
+
 test_expect_success 'setup' '
     echo master >file1 &&
-    git add file1 &&
+    mkdir subdir &&
+    echo master sub >subdir/file3 &&
+    git add file1 subdir/file3 &&
     git commit -m "added file1" &&
+
     git checkout -b branch1 master &&
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
-    git add file1 file2 &&
+    echo branch1 sub >subdir/file3 &&
+    git add file1 file2 subdir/file3 &&
     git commit -m "branch1 changes" &&
-    git checkout -b branch2 master &&
-    echo branch2 change >file1 &&
-    echo branch2 newfile >file2 &&
-    git add file1 file2 &&
-    git commit -m "branch2 changes" &&
+
     git checkout master &&
     echo master updated >file1 &&
     echo master new >file2 &&
-    git add file1 file2 &&
-    git commit -m "master updates"
-'
+    echo master new sub >subdir/file3 &&
+    git add file1 file2 subdir/file3 &&
+    git commit -m "master updates" &&
 
-test_expect_success 'custom mergetool' '
     git config merge.tool mytool &&
     git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
-    git config mergetool.mytool.trustExitCode true &&
-    git checkout branch1 &&
+    git config mergetool.mytool.trustExitCode true
+'
+
+test_expect_success 'custom mergetool' '
+    git checkout -b test1 branch1 &&
     test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     test "$(cat file1)" = "master updated" &&
     test "$(cat file2)" = "master new" &&
+    test "$(cat subdir/file3)" = "master new sub" &&
     git commit -m "branch1 resolved with mergetool"
 '
 
 test_expect_success 'mergetool crlf' '
     git config core.autocrlf true &&
-    git reset --hard HEAD^
+    git checkout -b test2 branch1
     test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
     test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
-    git commit -m "branch1 resolved with mergetool - autocrlf"
+    test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
+    git commit -m "branch1 resolved with mergetool - autocrlf" &&
+    git config core.autocrlf false &&
+    git reset --hard
+'
+
+test_expect_failure 'mergetool in subdir' '
+    git checkout -b test3 branch1
+    cd subdir && (
+    test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
+    test "$(cat file3)" = "master new sub" )
 '
 
+# We can't merge files from parent directories when running mergetool
+# from a subdir. Is this a bug?
+#
+#test_expect_failure 'mergetool in subdir' '
+#    cd subdir && (
+#    ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
+#    ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+#    test "$(cat ../file1)" = "master updated" &&
+#    test "$(cat ../file2)" = "master new" &&
+#    git commit -m "branch1 resolved with mergetool - subdir" )
+#'
+
 test_done
-- 
1.6.1.235.gc9d403
