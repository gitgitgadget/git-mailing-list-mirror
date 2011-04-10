From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH] mergetool: Added tests for submodule
Date: Sun, 10 Apr 2011 03:18:24 -0700
Message-ID: <1302430704-22754-1-git-send-email-me@JonathonMah.com>
References: <39B95643-D7FB-436F-B407-D716D43C3922@JonathonMah.com>
Cc: Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>,
	Jonathon Mah <me@JonathonMah.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 12:18:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8rjF-00022v-Ki
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 12:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab1DJKSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 06:18:44 -0400
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:31896 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755826Ab1DJKSo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 06:18:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah+hAGiAoU1i6vJRIWdsb2JhbACJE50LCwEBAQEBAR4XMr5ShW4EhVs
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO Adamantium.local.net) ([98.234.242.81])
  by ipmail05.adl6.internode.on.net with ESMTP; 10 Apr 2011 19:48:40 +0930
X-Mailer: git-send-email 1.7.5.rc1.1.g64431
In-Reply-To: <39B95643-D7FB-436F-B407-D716D43C3922@JonathonMah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171247>

---
 t/t7610-mergetool.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index dc838c9..96d7d9b 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -22,26 +22,53 @@ test_expect_success 'setup' '
     echo master file14 >file14 &&
     mkdir subdir &&
     echo master sub >subdir/file3 &&
-    git add file1 file1[1-4] subdir/file3 &&
+    test_create_repo submod &&
+    (
+	cd submod &&
+	: >foo &&
+	git add foo &&
+	git commit -m "Add foo"
+    ) &&
+    git config -f .gitmodules submodule.submod.path submod &&
+    git config -f .gitmodules submodule.submod.url git://example.com/submod &&
+    git config submodule.submod.url git://example.com/submod &&
+    git config fetch.recurseSubmodules false &&
+    git add file1 file1[1-4] subdir/file3 .gitmodules submod &&
     git commit -m "add initial versions" &&
 
     git checkout -b branch1 master &&
+    git submodule update -N &&
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
     echo branch1 change file11 >file11 &&
     echo branch1 change file13 >file13 &&
     echo branch1 sub >subdir/file3 &&
-    git add file1 file11 file13 file2 subdir/file3 &&
+    (
+	cd submod &&
+	echo branch1 submodule >bar &&
+	git add bar &&
+	git commit -m "Add bar on branch1" &&
+	git checkout -b submod-branch1
+    ) &&
+    git add file1 file11 file13 file2 subdir/file3 submod &&
     git rm file12 &&
     git commit -m "branch1 changes" &&
 
     git checkout master &&
+    git submodule update -N &&
     echo master updated >file1 &&
     echo master new >file2 &&
     echo master updated file12 >file12 &&
     echo master updated file14 >file14 &&
     echo master new sub >subdir/file3 &&
-    git add file1 file12 file14 file2 subdir/file3 &&
+    (
+	cd submod &&
+	echo master submodule >bar &&
+	git add bar &&
+	git commit -m "Add bar on master" &&
+	git checkout -b submod-master
+    ) &&
+    git add file1 file12 file14 file2 subdir/file3 submod &&
     git rm file11 &&
     git commit -m "master updates" &&
 
@@ -52,15 +79,18 @@ test_expect_success 'setup' '
 
 test_expect_success 'custom mergetool' '
     git checkout -b test1 branch1 &&
+    git submodule update -N &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
+    ( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
     test "$(cat file1)" = "master updated" &&
     test "$(cat file2)" = "master new" &&
     test "$(cat subdir/file3)" = "master new sub" &&
+    test "$(cat submod/bar)" = "branch1 submodule" &&
     git commit -m "branch1 resolved with mergetool"
 '
 
@@ -73,9 +103,12 @@ test_expect_success 'mergetool crlf' '
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
+    ( yes "r" | git mergetool submod >/dev/null 2>&1 ) &&
     test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
     test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
     test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
     git commit -m "branch1 resolved with mergetool - autocrlf" &&
     git config core.autocrlf false &&
     git reset --hard
@@ -83,6 +116,7 @@ test_expect_success 'mergetool crlf' '
 
 test_expect_success 'mergetool in subdir' '
     git checkout -b test3 branch1 &&
+    git submodule update -N &&
     (
 	cd subdir &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -98,18 +132,22 @@ test_expect_success 'mergetool on file in parent dir' '
 	( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
+	( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
 	test "$(cat ../file1)" = "master updated" &&
 	test "$(cat ../file2)" = "master new" &&
+	test "$(cat ../submod/bar)" = "branch1 submodule" &&
 	git commit -m "branch1 resolved with mergetool - subdir"
     )
 '
 
 test_expect_success 'mergetool skips autoresolved' '
     git checkout -b test4 branch1 &&
+    git submodule update -N &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
+    ( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
     output="$(git mergetool --no-prompt)" &&
     test "$output" = "No files need merging" &&
     git reset --hard
@@ -120,10 +158,13 @@ test_expect_success 'mergetool merges all from subdir' '
 	cd subdir &&
 	git config rerere.enabled false &&
 	test_must_fail git merge master &&
+	( yes "r" | git mergetool ../submod ) &&
 	( yes "d" "d" | git mergetool --no-prompt ) &&
 	test "$(cat ../file1)" = "master updated" &&
 	test "$(cat ../file2)" = "master new" &&
 	test "$(cat file3)" = "master new sub" &&
+	( cd .. && git submodule update -N ) &&
+	test "$(cat ../submod/bar)" = "master submodule" &&
 	git commit -m "branch2 resolved by mergetool from subdir"
     )
 '
@@ -132,8 +173,11 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
     git config rerere.enabled true &&
     rm -rf .git/rr-cache &&
     git checkout -b test5 branch1
+    git submodule update -N &&
     test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
     ( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
+    git submodule update -N &&
     output="$(yes "n" | git mergetool --no-prompt)" &&
     test "$output" = "No files need merging" &&
     git reset --hard
-- 
1.7.5.rc1.1.g64431
