From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH 2/2] mergetool: Don't assume paths are unmerged
Date: Tue, 21 Jun 2011 19:46:28 -0700
Message-ID: <92B6FB42-FE0D-48DC-ABD0-BA1903D842D2@JonathonMah.com>
Mime-Version: 1.0 (Apple Message framework v1242)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 04:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZDSh-0007nd-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 04:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab1FVCqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 22:46:34 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:48551 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757863Ab1FVCqe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 22:46:34 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlszAP1UAU5i6vJRPGdsb2JhbAAMSIkRngQBAQEBN8hRhisEhyOabw
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO [192.168.120.10]) ([98.234.242.81])
  by ipmail06.adl2.internode.on.net with ESMTP; 22 Jun 2011 12:16:31 +0930
X-Mailer: Apple Mail (2.1242)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176216>

Like commit, mergetool now treats its path arguments as restricting
operation to the listed paths. Running "git mergetool subdir" will
prompt to resolve all conflicted blobs under subdir.

Previously mergetool would assume each path was in an unresolved state,
and get confused when it couldn't check out their other stages.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
Apologies, having some issues with my mail agent. This should be in-reply-to: 734F376D-0CF5-4417-8DC2-8A46AA05D995@JonathonMah.com

 Documentation/git-mergetool.txt |    7 ++-
 git-mergetool.sh                |   83 +++++++++++++++++---------------------
 t/t7610-mergetool.sh            |   28 +++++++++++--
 3 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 8c79ae8..f1f4e7a 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -16,9 +16,10 @@ Use `git mergetool` to run one of several merge utilities to resolve
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
index 3aab5aa..81cf2cb 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -342,64 +342,55 @@ merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo fa
 
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
-    fi
-
-    files=$(files_to_merge)
-    if test -z "$files" ; then
-	echo "No files need merging"
-	exit 0
+	files=$(git rerere remaining)
+    else
+	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
     fi
-
-    # Save original stdin
-    exec 3<&0
-
-    printf "Merging:\n"
-    printf "$files\n"
-
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
 else
     while test $# -gt 0; do
-	if test $last_status -ne 0; then
-	    prompt_after_failed_merge || exit 1
-	fi
-	printf "\n"
-	merge_file "$1"
-	last_status=$?
-	if test $last_status -ne 0; then
-	    rollup_status=1
+	matches=$(git ls-files -u -- "$1" | sed -e 's/^[^	]*	//' | sort -u)
+	if test -n "$matches"; then
+	    if test -z "$files"; then
+		files=$matches
+	    else
+		files=$(printf "%s\n%s" "$files" "$matches")
+	    fi
 	fi
 	shift
     done
+    files=$(printf "%s" "$files" | sort -u)
 fi
 
+if test -z "$files" ; then
+    echo "No files need merging"
+    exit 0
+fi
+
+# Save original stdin
+exec 3<&0
+
+printf "Merging:\n"
+printf "$files\n"
+
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
+
 exit $rollup_status
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f00caa3..4aab2a7 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -81,7 +81,7 @@ test_expect_success 'custom mergetool' '
     git checkout -b test1 branch1 &&
     git submodule update -N &&
     test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file1 ) &&
     ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
@@ -184,6 +184,24 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
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
@@ -392,7 +410,7 @@ test_expect_success 'directory vs modified submodule' '
     test "$(cat submod/file16)" = "not a submodule" &&
     rm -rf submod.orig &&
 
-    git reset --hard &&
+    git reset --hard >/dev/null 2>&1 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     test ! -e submod.orig &&
@@ -404,7 +422,7 @@ test_expect_success 'directory vs modified submodule' '
     ( cd submod && git clean -f && git reset --hard ) &&
     git submodule update -N &&
     test "$(cat submod/bar)" = "master submodule" &&
-    git reset --hard && rm -rf submod-movedaside &&
+    git reset --hard >/dev/null 2>&1 && rm -rf submod-movedaside &&
 
     git checkout -b test11.c master &&
     git submodule update -N &&
@@ -414,7 +432,7 @@ test_expect_success 'directory vs modified submodule' '
     git submodule update -N &&
     test "$(cat submod/bar)" = "master submodule" &&
 
-    git reset --hard &&
+    git reset --hard >/dev/null 2>&1 &&
     git submodule update -N &&
     test_must_fail git merge test11 &&
     test -n "$(git ls-files -u)" &&
@@ -422,7 +440,7 @@ test_expect_success 'directory vs modified submodule' '
     ( yes "r" | git mergetool submod ) &&
     test "$(cat submod/file16)" = "not a submodule" &&
 
-    git reset --hard master &&
+    git reset --hard master >/dev/null 2>&1 &&
     ( cd submod && git clean -f && git reset --hard ) &&
     git submodule update -N
 '
-- 
1.7.4.4
