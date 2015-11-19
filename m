From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/7] modernize t9300: use test_when_finished for clean-up
Date: Thu, 19 Nov 2015 20:09:47 +0100
Message-ID: <3c526bd9b7edfeb117263d785f11c18cd28e5fd7.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUbz-0007wr-2O
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbbKSTKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:31 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:57971 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161160AbbKSTK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:26 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDw1kZxz5tlW;
	Thu, 19 Nov 2015 20:10:24 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id EC97F29D8;
	Thu, 19 Nov 2015 20:10:23 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281488>

A number of clean-ups of test cases are performed outside of
test_expect_success. Replace these cases by using test_when_finished.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c36afdb..adabd68 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -344,9 +344,9 @@ M 755 0000000000000000000000000000000000000001 zero1
 
 INPUT_END
 test_expect_success 'B: fail on invalid blob sha1' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
 	test_must_fail git fast-import <input
 '
-rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
 commit TEMP_TAG
@@ -359,14 +359,13 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: accept branch name "TEMP_TAG"' '
+	test_when_finished "rm -f .git/TEMP_TAG
+		git gc
+		git prune" &&
 	git fast-import <input &&
 	test -f .git/TEMP_TAG &&
 	test `git rev-parse master` = `git rev-parse TEMP_TAG^`
 '
-rm -f .git/TEMP_TAG
-
-git gc 2>/dev/null >/dev/null
-git prune 2>/dev/null >/dev/null
 
 cat >input <<INPUT_END
 commit refs/heads/empty-committer-1
@@ -376,15 +375,14 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: accept empty committer' '
+	test_when_finished "git update-ref -d refs/heads/empty-committer-1
+		git gc
+		git prune" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
 	test -z "$out"
 '
-git update-ref -d refs/heads/empty-committer-1 || true
-
-git gc 2>/dev/null >/dev/null
-git prune 2>/dev/null >/dev/null
 
 cat >input <<INPUT_END
 commit refs/heads/empty-committer-2
@@ -394,15 +392,14 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: accept and fixup committer with no name' '
+	test_when_finished "git update-ref -d refs/heads/empty-committer-2
+		git gc
+		git prune" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
 	test -z "$out"
 '
-git update-ref -d refs/heads/empty-committer-2 || true
-
-git gc 2>/dev/null >/dev/null
-git prune 2>/dev/null >/dev/null
 
 cat >input <<INPUT_END
 commit refs/heads/invalid-committer
@@ -412,9 +409,9 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: fail on invalid committer (1)' '
+	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
-git update-ref -d refs/heads/invalid-committer || true
 
 cat >input <<INPUT_END
 commit refs/heads/invalid-committer
@@ -424,9 +421,9 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: fail on invalid committer (2)' '
+	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
-git update-ref -d refs/heads/invalid-committer || true
 
 cat >input <<INPUT_END
 commit refs/heads/invalid-committer
@@ -436,9 +433,9 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: fail on invalid committer (3)' '
+	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
-git update-ref -d refs/heads/invalid-committer || true
 
 cat >input <<INPUT_END
 commit refs/heads/invalid-committer
@@ -448,9 +445,9 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: fail on invalid committer (4)' '
+	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
-git update-ref -d refs/heads/invalid-committer || true
 
 cat >input <<INPUT_END
 commit refs/heads/invalid-committer
@@ -460,9 +457,9 @@ empty commit
 COMMIT
 INPUT_END
 test_expect_success 'B: fail on invalid committer (5)' '
+	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
-git update-ref -d refs/heads/invalid-committer || true
 
 ###
 ### series C
@@ -914,6 +911,7 @@ g/b/h
 EOF
 
 test_expect_success 'L: nested tree copy does not corrupt deltas' '
+	test_when_finished "git update-ref -d refs/heads/L2" &&
 	git fast-import <input &&
 	git ls-tree L2 g/b/ >tmp &&
 	cat tmp | cut -f 2 >actual &&
@@ -921,8 +919,6 @@ test_expect_success 'L: nested tree copy does not corrupt deltas' '
 	git fsck `git rev-parse L2`
 '
 
-git update-ref -d refs/heads/L2
-
 ###
 ### series M
 ###
-- 
2.6.2.337.ga235d84
