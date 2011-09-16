From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH] mergetool: Use args as pathspec to unmerged files
Date: Thu, 15 Sep 2011 19:12:10 -0700
Message-ID: <C5AD8BFC-DA48-4CE9-B821-D0076825F33C@JonathonMah.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vipox2wd6.fsf@alter.siamese.dyndns.org> <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com> <7vsjnysuyl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Dan McGee <dpmcgee@gmail.com>, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 04:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Nvz-0004nD-Q1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 04:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab1IPCMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 22:12:42 -0400
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:29033 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751453Ab1IPCMl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 22:12:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApIBAKKvck5M5FL2/2dsb2JhbAAMNaolAQU6OgUQUVcZvRyGFGAEh2+YWoRI
Received: from adsl-76-228-82-246.dsl.pltn13.sbcglobal.net (HELO [10.0.1.93]) ([76.228.82.246])
  by ipmail04.adl6.internode.on.net with ESMTP; 16 Sep 2011 11:42:16 +0930
In-Reply-To: <7vsjnysuyl.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181524>

Mergetool now treats its path arguments as a pathspec (like other git
subcommands), restricting action to the given files and directories.
Files matching the pathspec are filtered so mergetool only acts on
unmerged paths; previously it would assume each path argument was in an
unresolved state, and get confused when it couldn't check out their
other stages.

Running "git mergetool subdir" will prompt to resolve all conflicted
blobs under subdir.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
With Junio's change, I'm happy with the code in git-mergetool.sh.
I've tried to clarify the commit message since the first submission.

 Documentation/git-mergetool.txt |    7 ++--
 git-mergetool.sh                |   76 ++++++++++++++------------------------
 t/t7610-mergetool.sh            |   58 ++++++++++++++++++++---------
 3 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 3470910..2a49de7 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -17,9 +17,10 @@ Use `git mergetool` to run one of several merge utilities to resolve
 merge conflicts.  It is typically run after 'git merge'.
 
 If one or more <file> parameters are given, the merge tool program will
-be run to resolve differences on each file.  If no <file> names are
-specified, 'git mergetool' will run the merge tool program on every file
-with merge conflicts.
+be run to resolve differences on each file (skipping those without
+conflicts).  Specifying a directory will include all unresolved files in
+that path.  If no <file> names are specified, 'git mergetool' will run
+the merge tool program on every file with merge conflicts.
 
 OPTIONS
 -------
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 3c157bc..12a2706 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -342,64 +342,44 @@ merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo fa
 
 last_status=0
 rollup_status=0
-rerere=false
-
-files_to_merge() {
-    if test "$rerere" = true
-    then
-	git rerere remaining
-    else
-	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u
-    fi
-}
-
+files=
 
 if test $# -eq 0 ; then
     cd_to_toplevel
 
     if test -e "$GIT_DIR/MERGE_RR"
     then
-	rerere=true
+	files=$(git rerere remaining)
+    else
+	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
     fi
+else
+    files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u)
+fi
 
-    files=$(files_to_merge)
-    if test -z "$files" ; then
-	echo "No files need merging"
-	exit 0
-    fi
+if test -z "$files" ; then
+    echo "No files need merging"
+    exit 0
+fi
 
-    # Save original stdin
-    exec 3<&0
+# Save original stdin
+exec 3<&0
 
-    printf "Merging:\n"
-    printf "$files\n"
+printf "Merging:\n"
+printf "$files\n"
 
-    files_to_merge |
-    while IFS= read i
-    do
-	if test $last_status -ne 0; then
-	    prompt_after_failed_merge <&3 || exit 1
-	fi
-	printf "\n"
-	merge_file "$i" <&3
-	last_status=$?
-	if test $last_status -ne 0; then
-	    rollup_status=1
-	fi
-    done
-else
-    while test $# -gt 0; do
-	if test $last_status -ne 0; then
-	    prompt_after_failed_merge || exit 1
-	fi
-	printf "\n"
-	merge_file "$1"
-	last_status=$?
-	if test $last_status -ne 0; then
-	    rollup_status=1
-	fi
-	shift
-    done
-fi
+IFS='
+'; for i in $files
+do
+    if test $last_status -ne 0; then
+	prompt_after_failed_merge <&3 || exit 1
+    fi
+    printf "\n"
+    merge_file "$i" <&3
+    last_status=$?
+    if test $last_status -ne 0; then
+	rollup_status=1
+    fi
+done
 
 exit $rollup_status
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index cbc08e3..4aab2a7 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -16,6 +16,7 @@ Testing basic merge tool invocation'
 test_expect_success 'setup' '
     git config rerere.enabled true &&
     echo master >file1 &&
+    echo master spaced >"spaced name" &&
     echo master file11 >file11 &&
     echo master file12 >file12 &&
     echo master file13 >file13 &&
@@ -30,13 +31,14 @@ test_expect_success 'setup' '
 	git commit -m "Add foo"
     ) &&
     git submodule add git://example.com/submod submod &&
-    git add file1 file1[1-4] subdir/file3 .gitmodules submod &&
+    git add file1 "spaced name" file1[1-4] subdir/file3 .gitmodules submod &&
     git commit -m "add initial versions" &&
 
     git checkout -b branch1 master &&
     git submodule update -N &&
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
+    echo branch1 spaced >"spaced name" &&
     echo branch1 change file11 >file11 &&
     echo branch1 change file13 >file13 &&
     echo branch1 sub >subdir/file3 &&
@@ -47,7 +49,7 @@ test_expect_success 'setup' '
 	git commit -m "Add bar on branch1" &&
 	git checkout -b submod-branch1
     ) &&
-    git add file1 file11 file13 file2 subdir/file3 submod &&
+    git add file1 "spaced name" file11 file13 file2 subdir/file3 submod &&
     git rm file12 &&
     git commit -m "branch1 changes" &&
 
@@ -55,6 +57,7 @@ test_expect_success 'setup' '
     git submodule update -N &&
     echo master updated >file1 &&
     echo master new >file2 &&
+    echo master updated spaced >"spaced name" &&
     echo master updated file12 >file12 &&
     echo master updated file14 >file14 &&
     echo master new sub >subdir/file3 &&
@@ -65,7 +68,7 @@ test_expect_success 'setup' '
 	git commit -m "Add bar on master" &&
 	git checkout -b submod-master
     ) &&
-    git add file1 file12 file14 file2 subdir/file3 submod &&
+    git add file1 "spaced name" file12 file14 file2 subdir/file3 submod &&
     git rm file11 &&
     git commit -m "master updates" &&
 
@@ -78,8 +81,8 @@ test_expect_success 'custom mergetool' '
     git checkout -b test1 branch1 &&
     git submodule update -N &&
     test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file1 ) &&
+    ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
@@ -97,6 +100,7 @@ test_expect_success 'mergetool crlf' '
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
@@ -126,7 +130,7 @@ test_expect_success 'mergetool on file in parent dir' '
     (
 	cd subdir &&
 	( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
@@ -180,6 +184,24 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
     git reset --hard
 '
 
+test_expect_success 'mergetool takes partial path' '
+    git config rerere.enabled false &&
+    git checkout -b test12 branch1 &&
+    git submodule update -N &&
+    test_must_fail git merge master &&
+
+    #shouldnt need these lines
+    #( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    #( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
+    #( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
+    #( yes "" | git mergetool file1 file2 >/dev/null 2>&1 ) &&
+
+    ( yes "" | git mergetool subdir ) &&
+
+    test "$(cat subdir/file3)" = "master new sub" &&
+    git reset --hard
+'
+
 test_expect_success 'deleted vs modified submodule' '
     git checkout -b test6 branch1 &&
     git submodule update -N &&
@@ -189,7 +211,7 @@ test_expect_success 'deleted vs modified submodule' '
     git checkout -b test6.a test6 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     rmdir submod && mv submod-movedaside submod &&
@@ -205,7 +227,7 @@ test_expect_success 'deleted vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test ! -e submod &&
@@ -218,7 +240,7 @@ test_expect_success 'deleted vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test6 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     test ! -e submod &&
@@ -233,7 +255,7 @@ test_expect_success 'deleted vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test6 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test "$(cat submod/bar)" = "master submodule" &&
@@ -256,7 +278,7 @@ test_expect_success 'file vs modified submodule' '
     git checkout -b test7.a branch1 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     rmdir submod && mv submod-movedaside submod &&
@@ -271,7 +293,7 @@ test_expect_success 'file vs modified submodule' '
     git checkout -b test7.b test7 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     git submodule update -N &&
@@ -286,7 +308,7 @@ test_expect_success 'file vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test7 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     test -d submod.orig &&
@@ -301,7 +323,7 @@ test_expect_success 'file vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test7 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test "$(cat submod/bar)" = "master submodule" &&
@@ -388,7 +410,7 @@ test_expect_success 'directory vs modified submodule' '
     test "$(cat submod/file16)" = "not a submodule" &&
     rm -rf submod.orig &&
 
-    git reset --hard &&
+    git reset --hard >/dev/null 2>&1 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     test ! -e submod.orig &&
@@ -400,7 +422,7 @@ test_expect_success 'directory vs modified submodule' '
     ( cd submod && git clean -f && git reset --hard ) &&
     git submodule update -N &&
     test "$(cat submod/bar)" = "master submodule" &&
-    git reset --hard && rm -rf submod-movedaside &&
+    git reset --hard >/dev/null 2>&1 && rm -rf submod-movedaside &&
 
     git checkout -b test11.c master &&
     git submodule update -N &&
@@ -410,7 +432,7 @@ test_expect_success 'directory vs modified submodule' '
     git submodule update -N &&
     test "$(cat submod/bar)" = "master submodule" &&
 
-    git reset --hard &&
+    git reset --hard >/dev/null 2>&1 &&
     git submodule update -N &&
     test_must_fail git merge test11 &&
     test -n "$(git ls-files -u)" &&
@@ -418,7 +440,7 @@ test_expect_success 'directory vs modified submodule' '
     ( yes "r" | git mergetool submod ) &&
     test "$(cat submod/file16)" = "not a submodule" &&
 
-    git reset --hard master &&
+    git reset --hard master >/dev/null 2>&1 &&
     ( cd submod && git clean -f && git reset --hard ) &&
     git submodule update -N
 '
-- 
1.7.5.4
