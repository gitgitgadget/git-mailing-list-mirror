From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 02/11] t2100: modernize style and unroll a loop of test cases
Date: Sat,  1 Jun 2013 11:34:21 +0200
Message-ID: <e0707cd8cb027e8fb7f17fd7ec1083cffc6e8fef.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:34:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiD4-00022T-C6
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab3FAJel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:34:41 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:34511 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753284Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 988CC130050
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id F36A919F5E1
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:31 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226109>

In particular, move all test preparations inside test_expect_success.

In a subsequent patch, we are going to move test case path3 out of the
loop of test cases. Use this opportunity to linearize the tests.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t2100-update-cache-badpath.sh | 81 ++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 2df3fdd..a3f9255 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -24,38 +24,51 @@ All of the attempts should fail.
 
 . ./test-lib.sh
 
-mkdir path2 path3
-date >path0
-if test_have_prereq SYMLINKS
-then
-	ln -s xyzzy path1
-else
-	date > path1
-fi
-date >path2/file2
-date >path3/file3
-
-test_expect_success \
-    'git update-index --add to add various paths.' \
-    'git update-index --add -- path0 path1 path2/file2 path3/file3'
-
-rm -fr path?
-
-mkdir path0 path1
-date >path2
-if test_have_prereq SYMLINKS
-then
-	ln -s frotz path3
-else
-	date > path3
-fi
-date >path0/file0
-date >path1/file1
-
-for p in path0/file0 path1/file1 path2 path3
-do
-	test_expect_success \
-	    "git update-index to add conflicting path $p should fail." \
-	    "test_must_fail git update-index --add -- $p"
-done
+test_expect_success 'git update-index --add to add various paths' '
+
+	mkdir path2 path3 &&
+	date >path0 &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s xyzzy path1
+	else
+		date >path1
+	fi &&
+	date >path2/file2 &&
+	date >path3/file3 &&
+	test_when_finished "rm -fr path0 path1 path2 path3" &&
+	git update-index --add -- path0 path1 path2/file2 path3/file3
+'
+
+test_expect_success 'git update-index to add conflicting path path0/file0 should fail' '
+
+	mkdir path0 &&
+	date >path0/file0 &&
+	test_must_fail git update-index --add -- path0/file0
+'
+
+test_expect_success 'git update-index to add conflicting path path1/file1 should fail' '
+
+	mkdir path1 &&
+	date >path1/file1 &&
+	test_must_fail git update-index --add -- path1/file1
+'
+
+test_expect_success 'git update-index to add conflicting file path2 should fail' '
+
+	date >path2 &&
+	test_must_fail git update-index --add -- path2
+'
+
+test_expect_success 'git update-index to add conflicting symlink path3 should fail' '
+
+	if test_have_prereq SYMLINKS
+	then
+		ln -s xyzzy path3
+	else
+		date >path3
+	fi &&
+	test_must_fail git update-index --add -- path3
+'
+
 test_done
-- 
1.8.3.rc1.32.g8b61cbb
