From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t7610: cd inside subshell instead of around
Date: Mon, 23 Aug 2010 22:37:24 -0400
Message-ID: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 24 04:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnjOT-0008Kk-5v
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 04:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab0HXChk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 22:37:40 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48915 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab0HXChi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 22:37:38 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id F40AD1FFC43C; Tue, 24 Aug 2010 02:37:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 4D23C1FFC43A;
	Tue, 24 Aug 2010 02:37:18 +0000 (UTC)
X-Mailer: git-send-email 1.7.2.2.399.g628fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154279>

Instead of using `cd dir && (...) && cd..` use `(cd dir && ...)`

This ensures that the test doesn't get caught in the subdirectory if
there is an error in the subshell.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t7610-mergetool.sh |   49 ++++++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f5a7bf4..3c436e1 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -68,22 +68,24 @@ test_expect_success 'mergetool crlf' '
 '
 
 test_expect_success 'mergetool in subdir' '
-    git checkout -b test3 branch1
-    cd subdir && (
-    test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
-    test "$(cat file3)" = "master new sub") &&
-    cd ..
+    git checkout -b test3 branch1 &&
+    (
+        cd subdir &&
+        test_must_fail git merge master >/dev/null 2>&1 &&
+        ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
+        test "$(cat file3)" = "master new sub"
+    )
 '
 
 test_expect_success 'mergetool on file in parent dir' '
-    cd subdir && (
-    ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
-    test "$(cat ../file1)" = "master updated" &&
-    test "$(cat ../file2)" = "master new" &&
-    git commit -m "branch1 resolved with mergetool - subdir") &&
-    cd ..
+    (
+        cd subdir && 
+        ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
+        ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+        test "$(cat ../file1)" = "master updated" &&
+        test "$(cat ../file2)" = "master new" &&
+        git commit -m "branch1 resolved with mergetool - subdir"
+    )
 '
 
 test_expect_success 'mergetool skips autoresolved' '
@@ -96,16 +98,17 @@ test_expect_success 'mergetool skips autoresolved' '
 '
 
 test_expect_success 'mergetool merges all from subdir' '
-    cd subdir && (
-    git config rerere.enabled false &&
-    test_must_fail git merge master &&
-    git mergetool --no-prompt &&
-    test "$(cat ../file1)" = "master updated" &&
-    test "$(cat ../file2)" = "master new" &&
-    test "$(cat file3)" = "master new sub" &&
-    git add ../file1 ../file2 file3 &&
-    git commit -m "branch2 resolved by mergetool from subdir") &&
-    cd ..
+    (
+        cd subdir &&
+        git config rerere.enabled false &&
+        test_must_fail git merge master &&
+        git mergetool --no-prompt &&
+        test "$(cat ../file1)" = "master updated" &&
+        test "$(cat ../file2)" = "master new" &&
+        test "$(cat file3)" = "master new sub" &&
+        git add ../file1 ../file2 file3 &&
+        git commit -m "branch2 resolved by mergetool from subdir"
+    )
 '
 
 test_done
-- 
1.7.2.2.399.g628fd
