From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH v2] mergetool: Teach about submodules
Date: Wed, 13 Apr 2011 03:00:48 -0700
Message-ID: <1302688848-30518-1-git-send-email-me@JonathonMah.com>
References: <7v62qkwomk.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>,
	Jonathon Mah <me@JonathonMah.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 12:01:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9wso-00019L-QN
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 12:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271Ab1DMKBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 06:01:03 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:39766 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755443Ab1DMKBA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 06:01:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoFXALJwpU1i6vJRPGdsb2JhbACJFJx1CwEBAQE3MsM9hW4EhV4
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO Adamantium.local.net) ([98.234.242.81])
  by ipmail06.adl6.internode.on.net with ESMTP; 13 Apr 2011 19:30:56 +0930
X-Mailer: git-send-email 1.7.5.rc1.1.g64431
In-Reply-To: <7v62qkwomk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171441>

When the index has conflicted submodules, mergetool used to mildly
clobber the module, renaming it to mymodule.BACKUP.nnnn, then failing to
copy it non-recursively.

Recognize submodules and offer a resolution instead:

  Submodule merge conflict for 'Shared':
    {local}: submodule commit ad9f12e3e6205381bf2163a793d1e596a9e211d0
    {remote}: submodule commit f5893fb70ec5646efcd9aa643c5136753ac89253
  Use (l)ocal or (r)emote, or (a)bort?

Selecting a commit will stage it, but not update the submodule (as git
does had there been no conflict). Type changes are also supported,
should the path be a submodule on one side, and a file, symlink,
directory, or deleted on the other.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 git-mergetool.sh     |   90 +++++++++++++++-
 t/t7610-mergetool.sh |  290 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 371 insertions(+), 9 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index bacbda2..3aab5aa 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -21,6 +21,10 @@ is_symlink () {
     test "$1" = 120000
 }
 
+is_submodule () {
+    test "$1" = 160000
+}
+
 local_present () {
     test -n "$local_mode"
 }
@@ -35,7 +39,8 @@ base_present () {
 
 cleanup_temp_files () {
     if test "$1" = --save-backup ; then
-	mv -- "$BACKUP" "$MERGED.orig"
+	rm -rf -- "$MERGED.orig"
+	test -e "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
 	rm -f -- "$LOCAL" "$REMOTE" "$BASE"
     else
 	rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
@@ -52,11 +57,13 @@ describe_file () {
 	echo "deleted"
     elif is_symlink "$mode" ; then
 	echo "a symbolic link -> '$(cat "$file")'"
+    elif is_submodule "$mode" ; then
+	echo "submodule commit $file"
     else
 	if base_present; then
-	    echo "modified"
+	    echo "modified file"
 	else
-	    echo "created"
+	    echo "created file"
 	fi
     fi
 }
@@ -112,6 +119,67 @@ resolve_deleted_merge () {
 	done
 }
 
+resolve_submodule_merge () {
+    while true; do
+	printf "Use (l)ocal or (r)emote, or (a)bort? "
+	read ans
+	case "$ans" in
+	    [lL]*)
+		if ! local_present; then
+		    if test -n "$(git ls-tree HEAD -- "$MERGED")"; then
+			# Local isn't present, but it's a subdirectory
+			git ls-tree --full-name -r HEAD -- "$MERGED" | git update-index --index-info || exit $?
+		    else
+			test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+			git update-index --force-remove "$MERGED"
+			cleanup_temp_files --save-backup
+		    fi
+		elif is_submodule "$local_mode"; then
+		    stage_submodule "$MERGED" "$local_sha1"
+		else
+		    git checkout-index -f --stage=2 -- "$MERGED"
+		    git add -- "$MERGED"
+		fi
+		return 0
+		;;
+	    [rR]*)
+		if ! remote_present; then
+		    if test -n "$(git ls-tree MERGE_HEAD -- "$MERGED")"; then
+			# Remote isn't present, but it's a subdirectory
+			git ls-tree --full-name -r MERGE_HEAD -- "$MERGED" | git update-index --index-info || exit $?
+		    else
+			test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+			git update-index --force-remove "$MERGED"
+		    fi
+		elif is_submodule "$remote_mode"; then
+		    ! is_submodule "$local_mode" && test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+		    stage_submodule "$MERGED" "$remote_sha1"
+		else
+		    test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+		    git checkout-index -f --stage=3 -- "$MERGED"
+		    git add -- "$MERGED"
+		fi
+		cleanup_temp_files --save-backup
+		return 0
+		;;
+	    [aA]*)
+		return 1
+		;;
+	    esac
+	done
+}
+
+stage_submodule () {
+    path="$1"
+    submodule_sha1="$2"
+    mkdir -p "$path" || die "fatal: unable to create directory for module at $path"
+    # Find $path relative to work tree
+    work_tree_root=$(cd_to_toplevel && pwd)
+    work_rel_path=$(cd "$path" && GIT_WORK_TREE="${work_tree_root}" git rev-parse --show-prefix)
+    test -n "$work_rel_path" || die "fatal: unable to get path of module $path relative to work tree"
+    git update-index --add --replace --cacheinfo 160000 "$submodule_sha1" "${work_rel_path%/}" || die
+}
+
 checkout_staged_file () {
     tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
 
@@ -139,13 +207,23 @@ merge_file () {
     REMOTE="./$MERGED.REMOTE.$ext"
     BASE="./$MERGED.BASE.$ext"
 
-    mv -- "$MERGED" "$BACKUP"
-    cp -- "$BACKUP" "$MERGED"
-
     base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
     local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
     remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
 
+    if is_submodule "$local_mode" || is_submodule "$remote_mode"; then
+	echo "Submodule merge conflict for '$MERGED':"
+	local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
+	remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
+	describe_file "$local_mode" "local" "$local_sha1"
+	describe_file "$remote_mode" "remote" "$remote_sha1"
+	resolve_submodule_merge
+	return
+    fi
+
+    mv -- "$MERGED" "$BACKUP"
+    cp -- "$BACKUP" "$MERGED"
+
     base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
     local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
     remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index dc838c9..cbc08e3 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -22,26 +22,50 @@ test_expect_success 'setup' '
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
+    git submodule add git://example.com/submod submod &&
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
 
@@ -52,15 +76,18 @@ test_expect_success 'setup' '
 
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
 
@@ -73,9 +100,12 @@ test_expect_success 'mergetool crlf' '
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
@@ -83,6 +113,7 @@ test_expect_success 'mergetool crlf' '
 
 test_expect_success 'mergetool in subdir' '
     git checkout -b test3 branch1 &&
+    git submodule update -N &&
     (
 	cd subdir &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -98,18 +129,22 @@ test_expect_success 'mergetool on file in parent dir' '
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
@@ -120,10 +155,13 @@ test_expect_success 'mergetool merges all from subdir' '
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
@@ -132,11 +170,257 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
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
 '
 
+test_expect_success 'deleted vs modified submodule' '
+    git checkout -b test6 branch1 &&
+    git submodule update -N &&
+    mv submod submod-movedaside &&
+    git rm submod &&
+    git commit -m "Submodule deleted from branch" &&
+    git checkout -b test6.a test6 &&
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "r" | git mergetool submod ) &&
+    rmdir submod && mv submod-movedaside submod &&
+    test "$(cat submod/bar)" = "branch1 submodule" &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by keeping module" &&
+
+    mv submod submod-movedaside &&
+    git checkout -b test6.b test6 &&
+    git submodule update -N &&
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "l" | git mergetool submod ) &&
+    test ! -e submod &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by deleting module" &&
+
+    mv submod-movedaside submod &&
+    git checkout -b test6.c master &&
+    git submodule update -N &&
+    test_must_fail git merge test6 &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "r" | git mergetool submod ) &&
+    test ! -e submod &&
+    test -d submod.orig &&
+    git submodule update -N &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by deleting module" &&
+    mv submod.orig submod &&
+
+    git checkout -b test6.d master &&
+    git submodule update -N &&
+    test_must_fail git merge test6 &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "l" | git mergetool submod ) &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by keeping module" &&
+    git reset --hard HEAD
+'
+
+test_expect_success 'file vs modified submodule' '
+    git checkout -b test7 branch1 &&
+    git submodule update -N &&
+    mv submod submod-movedaside &&
+    git rm submod &&
+    echo not a submodule >submod &&
+    git add submod &&
+    git commit -m "Submodule path becomes file" &&
+    git checkout -b test7.a branch1 &&
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "r" | git mergetool submod ) &&
+    rmdir submod && mv submod-movedaside submod &&
+    test "$(cat submod/bar)" = "branch1 submodule" &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by keeping module" &&
+
+    mv submod submod-movedaside &&
+    git checkout -b test7.b test7 &&
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "l" | git mergetool submod ) &&
+    git submodule update -N &&
+    test "$(cat submod)" = "not a submodule" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by keeping file" &&
+
+    git checkout -b test7.c master &&
+    rmdir submod && mv submod-movedaside submod &&
+    test ! -e submod.orig &&
+    git submodule update -N &&
+    test_must_fail git merge test7 &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "r" | git mergetool submod ) &&
+    test -d submod.orig &&
+    git submodule update -N &&
+    test "$(cat submod)" = "not a submodule" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by keeping file" &&
+
+    git checkout -b test7.d master &&
+    rmdir submod && mv submod.orig submod &&
+    git submodule update -N &&
+    test_must_fail git merge test7 &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+    ( yes "l" | git mergetool submod ) &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git commit -m "Merge resolved by keeping module"
+'
+
+test_expect_success 'submodule in subdirectory' '
+    git checkout -b test10 branch1 &&
+    git submodule update -N &&
+    (
+	cd subdir &&
+	test_create_repo subdir_module &&
+	(
+	    cd subdir_module &&
+	    : >file15 &&
+	    git add file15 &&
+	    git commit -m "add initial versions"
+	)
+    ) &&
+    git submodule add git://example.com/subsubmodule subdir/subdir_module &&
+    git add subdir/subdir_module &&
+    git commit -m "add submodule in subdirectory" &&
+
+    git checkout -b test10.a test10 &&
+    git submodule update -N &&
+    (
+	cd subdir/subdir_module &&
+	git checkout -b super10.a &&
+	echo test10.a >file15 &&
+	git add file15 &&
+	git commit -m "on branch 10.a"
+    ) &&
+    git add subdir/subdir_module &&
+    git commit -m "change submodule in subdirectory on test10.a" &&
+
+    git checkout -b test10.b test10 &&
+    git submodule update -N &&
+    (
+	cd subdir/subdir_module &&
+	git checkout -b super10.b &&
+	echo test10.b >file15 &&
+	git add file15 &&
+	git commit -m "on branch 10.b"
+    ) &&
+    git add subdir/subdir_module &&
+    git commit -m "change submodule in subdirectory on test10.b" &&
+
+    test_must_fail git merge test10.a >/dev/null 2>&1 &&
+    (
+	cd subdir &&
+	( yes "l" | git mergetool subdir_module )
+    ) &&
+    test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+    git submodule update -N &&
+    test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+    git reset --hard &&
+    git submodule update -N &&
+
+    test_must_fail git merge test10.a >/dev/null 2>&1 &&
+    ( yes "r" | git mergetool subdir/subdir_module ) &&
+    test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+    git submodule update -N &&
+    test "$(cat subdir/subdir_module/file15)" = "test10.a" &&
+    git commit -m "branch1 resolved with mergetool" &&
+    rm -rf subdir/subdir_module
+'
+
+test_expect_success 'directory vs modified submodule' '
+    git checkout -b test11 branch1 &&
+    mv submod submod-movedaside &&
+    git rm submod &&
+    mkdir submod &&
+    echo not a submodule >submod/file16 &&
+    git add submod/file16 &&
+    git commit -m "Submodule path becomes directory" &&
+
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "l" | git mergetool submod ) &&
+    test "$(cat submod/file16)" = "not a submodule" &&
+    rm -rf submod.orig &&
+
+    git reset --hard &&
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    test ! -e submod.orig &&
+    ( yes "r" | git mergetool submod ) &&
+    test -d submod.orig &&
+    test "$(cat submod.orig/file16)" = "not a submodule" &&
+    rm -r submod.orig &&
+    mv submod-movedaside/.git submod &&
+    ( cd submod && git clean -f && git reset --hard ) &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
+    git reset --hard && rm -rf submod-movedaside &&
+
+    git checkout -b test11.c master &&
+    git submodule update -N &&
+    test_must_fail git merge test11 &&
+    test -n "$(git ls-files -u)" &&
+    ( yes "l" | git mergetool submod ) &&
+    git submodule update -N &&
+    test "$(cat submod/bar)" = "master submodule" &&
+
+    git reset --hard &&
+    git submodule update -N &&
+    test_must_fail git merge test11 &&
+    test -n "$(git ls-files -u)" &&
+    test ! -e submod.orig &&
+    ( yes "r" | git mergetool submod ) &&
+    test "$(cat submod/file16)" = "not a submodule" &&
+
+    git reset --hard master &&
+    ( cd submod && git clean -f && git reset --hard ) &&
+    git submodule update -N
+'
+
 test_done
-- 
1.7.5.rc1.1.g64431
