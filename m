From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 33/33] tests: add ref-storage argument
Date: Mon, 29 Feb 2016 19:53:06 -0500
Message-ID: <1456793586-22082-34-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaI-0007ZN-D6
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbcCAAye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:34 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:32837 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbcCAAyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:54:07 -0500
Received: by mail-qg0-f54.google.com with SMTP id d32so74642794qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6UbENr+mf4e6EMX5LMe2Vw0cadWgiGmaAWPqT/E7ISo=;
        b=leQF7TDoo3cAww0tZ8/sMHiTP31FpzIGiLIIx278l5FxeAlXUxHxa/MTtYXP+Ce5ZW
         PCd5sEu3DWYPE5igbMINRJ2hWwIOFsqY0IQqVQgFIZT0DrxYyWs5TRgbaDF5NQ3MGoPL
         yViKs4dqNWH8sqbpK8KvIB5YLTAZFtiuUc+cr1nfhILVcBh2l+GwhWsXrGyhSlAdfYe1
         02n1aYYyulZ/mz2NiKS5OQCmhQyfvJZgv/N+VtuADrWviCdf35AfuN8RmkkRNNitzty1
         79pHMtRG9GQIv5wbDs6/9ef7mUwRX3URfK02E7bfa+jwHkAjzM7m/+EOszPA8pOmtCP6
         OOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6UbENr+mf4e6EMX5LMe2Vw0cadWgiGmaAWPqT/E7ISo=;
        b=X7iQOLIlpg5qk1lHuelQk6QgwjdsAutKgAUWmPodF1Z1DabrUJXkGSQr6L7TDalK9j
         11O7SRvyA1gxKKRhu755BSycN0dcJb0jRf+95kRHz0zy+JnyVgau4J/ybquRpgMcNfec
         IDTg7w6sm7V8obzVDXeWbriRIBZgTHSoRLDBATXpQkyn7oKrbfUB7pQKi8asCV/V70EB
         S0hTpt59/oADlZnm+xZkC/M/dcXVQjl7zuRJq/pZOYk5OmHEszXaZFY6tiTE2OFeN1xb
         VxyKKsAFjN3q+g4MUrABHf00FPtBm5jjdaqDBVdvJGAq5znoPP0/9gtKuNp1steNe9pd
         09Xg==
X-Gm-Message-State: AD7BkJJrfG8QC2gy73d/oDcPwwkmVue5j64/OGQqyyAI1i11jDmLLU7qRuItLuncoFx/VA==
X-Received: by 10.140.28.133 with SMTP id 5mr22877759qgz.79.1456793646020;
        Mon, 29 Feb 2016 16:54:06 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:54:05 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287974>

Add a --ref-storage argument to make it easy to test alternate ref
storage backends.  This means that every test that calls git init or
git clone must use the new ref storage argument.

Modify many tests to work under alternate ref storage backends.

Introduce abstractions for raw ref/reflog reading/writing in tests
instead of directly frobbing the filesystem.

Conditionally skip tests that are not expected to succeed under this
condition. Most of this is straightforward. Of particular note are the
following test changes:

* The rearrangement of commands in t1401 is because without HEAD in
the right place, git doesn't recognized the trash dir as a git repo,
so no git commands work.

* t1430-bad-ref-name specifically blocks lmdb because other alternate
backends might want to keep this test.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README                                 |  6 +++
 t/lib-submodule-update.sh                | 15 +++++--
 t/lib-t6000.sh                           |  7 ++-
 t/t0008-ignores.sh                       |  2 +-
 t/t0062-revision-walking.sh              |  6 +++
 t/t1021-rerere-in-workdir.sh             |  6 +++
 t/t1200-tutorial.sh                      |  8 +++-
 t/t1302-repo-version.sh                  |  6 +++
 t/t1305-config-include.sh                | 17 ++++++--
 t/t1400-update-ref.sh                    |  6 +++
 t/t1401-symbolic-ref.sh                  | 17 +++++---
 t/t1404-update-ref-df-conflicts.sh       |  8 +++-
 t/t1410-reflog.sh                        |  6 +++
 t/t1430-bad-ref-name.sh                  |  6 +++
 t/t1450-fsck.sh                          | 12 ++---
 t/t1506-rev-parse-diagnosis.sh           |  4 +-
 t/t2013-checkout-submodule.sh            |  2 +-
 t/t2105-update-index-gitfile.sh          |  4 +-
 t/t2107-update-index-basic.sh            |  6 +--
 t/t2201-add-update-typechange.sh         |  4 +-
 t/t3001-ls-files-others-exclude.sh       |  2 +-
 t/t3010-ls-files-killed-modified.sh      |  4 +-
 t/t3040-subprojects-basic.sh             |  4 +-
 t/t3050-subprojects-fetch.sh             |  2 +-
 t/t3200-branch.sh                        | 75 ++++++++++++++++++--------------
 t/t3210-pack-refs.sh                     |  7 +++
 t/t3211-peel-ref.sh                      |  6 +++
 t/t3308-notes-merge.sh                   |  2 +-
 t/t3404-rebase-interactive.sh            |  2 +-
 t/t3600-rm.sh                            |  2 +-
 t/t3800-mktag.sh                         |  4 +-
 t/t3903-stash.sh                         |  2 +-
 t/t4010-diff-pathspec.sh                 |  2 +-
 t/t4020-diff-external.sh                 |  2 +-
 t/t4027-diff-submodule.sh                |  2 +-
 t/t4035-diff-quiet.sh                    |  2 +-
 t/t4255-am-submodule.sh                  |  2 +-
 t/t5000-tar-tree.sh                      |  3 +-
 t/t5304-prune.sh                         |  2 +-
 t/t5312-prune-corruption.sh              | 11 ++++-
 t/t5500-fetch-pack.sh                    | 10 ++---
 t/t5510-fetch.sh                         | 30 ++++++-------
 t/t5526-fetch-submodules.sh              |  4 +-
 t/t5527-fetch-odd-refs.sh                |  7 +++
 t/t5537-fetch-shallow.sh                 |  7 +++
 t/t5700-clone-reference.sh               | 42 +++++++++---------
 t/t6001-rev-list-graft.sh                |  3 +-
 t/t6010-merge-base.sh                    |  2 +-
 t/t6050-replace.sh                       |  4 +-
 t/t6120-describe.sh                      |  6 ++-
 t/t6301-for-each-ref-errors.sh           | 12 ++---
 t/t7201-co.sh                            |  2 +-
 t/t7300-clean.sh                         | 25 ++++++-----
 t/t7400-submodule-basic.sh               | 22 +++++-----
 t/t7402-submodule-rebase.sh              |  2 +-
 t/t7405-submodule-merge.sh               | 10 ++---
 t/t9104-git-svn-follow-parent.sh         |  3 +-
 t/t9115-git-svn-dcommit-funky-renames.sh |  2 +-
 t/t9350-fast-export.sh                   |  6 +--
 t/t9902-completion.sh                    |  4 +-
 t/t9903-bash-prompt.sh                   |  2 +-
 t/test-lib-functions.sh                  | 53 +++++++++++++++++++++-
 t/test-lib.sh                            | 11 +++++
 63 files changed, 370 insertions(+), 185 deletions(-)

diff --git a/t/README b/t/README
index 1dc908e..8e047cb 100644
--- a/t/README
+++ b/t/README
@@ -178,6 +178,12 @@ appropriately before running "make".
 	this feature by setting the GIT_TEST_CHAIN_LINT environment
 	variable to "1" or "0", respectively.
 
+--ref-storage=<backend>::
+	If --ref-storage is set, run tests under an alternate ref
+	backend.  Tests that rely on the original files backend will
+	be skipped.  You may also enable or disable this feature by
+	setting the GIT_TEST_REF_STORAGE environment variable
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34..b037eb3 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -32,7 +32,7 @@
 #                     invalid_sub1
 #
 create_lib_submodule_repo () {
-	git init submodule_update_repo &&
+	git init $ref_storage_arg submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
 		echo "expect" >>.gitignore &&
@@ -125,7 +125,16 @@ test_git_directory_is_unchanged () {
 		# "$1/.git/config" lacks it...
 		git config --unset core.worktree
 	) &&
-	diff -r ".git/modules/$1" "$1/.git" &&
+	if test "$ref_storage" = "lmdb"
+	then
+	    diff -x refs.lmdb -r ".git/modules/$1" "$1/.git" &&
+	    mdb_dump -p ".git/modules/$1/refs.lmdb" >one &&
+	    mdb_dump -p "$1/.git/refs.lmdb" >two &&
+	    diff one two &&
+	    rm one two
+	else
+	    diff -r ".git/modules/$1" "$1/.git"
+	fi
 	(
 		# ... and then restore.
 		cd ".git/modules/$1" &&
@@ -147,7 +156,7 @@ prolog () {
 # should be updated to an existing commit.
 reset_work_tree_to () {
 	rm -rf submodule_update &&
-	git clone submodule_update_repo submodule_update &&
+	git clone $ref_storage_arg submodule_update_repo submodule_update &&
 	(
 		cd submodule_update &&
 		rm -rf sub1 &&
diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index 3f2d873..5fb4345 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -4,11 +4,10 @@ mkdir -p .git/refs/tags
 
 >sed.script
 
-# Answer the sha1 has associated with the tag. The tag must exist in .git/refs/tags
+# Answer the sha1 has associated with the tag. The tag must exist under refs/tags
 tag () {
 	_tag=$1
-	test -f ".git/refs/tags/$_tag" || error "tag: \"$_tag\" does not exist"
-	cat ".git/refs/tags/$_tag"
+	git rev-parse --verify "refs/tags/$_tag" || error "tag: \"$_tag\" does not exist"
 }
 
 # Generate a commit using the text specified to make it unique and the tree
@@ -26,7 +25,7 @@ save_tag () {
 	_tag=$1
 	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >".git/refs/tags/$_tag"
+	write_ref "refs/tags/$_tag" $("$@")
 
 	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
 	cat sed.script >>sed.script.tmp
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 89544dd..63fe6d5 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -184,7 +184,7 @@ test_expect_success 'setup' '
 	fi &&
 	(
 		cd a/submodule &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo a >a &&
 		git add a &&
 		git commit -m"commit in submodule"
diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
index 113c728..0bd3981 100755
--- a/t/t0062-revision-walking.sh
+++ b/t/t0062-revision-walking.sh
@@ -7,6 +7,12 @@ test_description='Test revision walking api'
 
 . ./test-lib.sh
 
+if test "$ref_storage" != "files"
+then
+	skip_all="Alternate storage doesn't do test-revision-walking"
+	test_done
+fi
+
 cat >run_twice_expected <<-EOF
 1st
  > add b
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 301e071..8fe5de7 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -3,6 +3,12 @@
 test_description='rerere run in a workdir'
 . ./test-lib.sh
 
+if test "$ref_storage" != "files"
+then
+	skip_all="Workdirs don't support alternate ref backends"
+	test_done
+fi
+
 test_expect_success SYMLINKS setup '
 	git config rerere.enabled true &&
 	>world &&
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 397ccb6..c67c7da 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -93,12 +93,16 @@ test_expect_success 'git whatchanged -p --root' '
 
 test_expect_success 'git tag my-first-tag' '
 	git tag my-first-tag &&
-	test_cmp .git/refs/heads/master .git/refs/tags/my-first-tag
+	git rev-parse --verify refs/heads/master >expect &&
+	git rev-parse --verify refs/tags/my-first-tag >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git checkout -b mybranch' '
 	git checkout -b mybranch &&
-	test_cmp .git/refs/heads/master .git/refs/heads/mybranch
+	git rev-parse --verify refs/heads/master >expect &&
+	git rev-parse --verify refs/heads/mybranch >actual &&
+	test_cmp expect actual
 '
 
 cat > branch.expect <<EOF
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 9bcd349..270a8d3 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -7,6 +7,12 @@ test_description='Test repository version check'
 
 . ./test-lib.sh
 
+if test "$ref_storage" != "files"
+then
+	skip_all="Alternate ref storage sets core.repositoryformatversion=1"
+	test_done
+fi
+
 test_expect_success 'setup' '
 	cat >test.patch <<-\EOF &&
 	diff --git a/test.txt b/test.txt
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 9ba2ba1..220cd63 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -45,14 +45,23 @@ test_expect_success 'include options can still be examined' '
 	test_cmp expect actual
 '
 
-test_expect_success 'listing includes option and expansion' '
-	echo "[test]one = 1" >one &&
-	echo "[include]path = one" >.gitconfig &&
-	cat >expect <<-\EOF &&
+write_expected_config()
+{
+	cat <<-\EOF &&
 	include.path=one
 	test.one=1
 	EOF
+	if test "$ref_storage" != "files"
+	then
+		echo "extensions.refstorage=$ref_storage"
+	fi
+}
+
+test_expect_success 'listing includes option and expansion' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
 	git config --list >actual.full &&
+	write_expected_config >expect &&
 	grep -v ^core actual.full >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index af1b20d..878dc53 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -6,6 +6,12 @@
 test_description='Test git update-ref and basic ref logging'
 . ./test-lib.sh
 
+if test "$ref_storage" != "files"
+then
+	skip_all="This test is ref storage backend-specific"
+	test_done
+fi
+
 Z=$_z40
 
 test_expect_success setup '
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 417eecc..5bfe7d2 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -35,15 +35,16 @@ reset_to_sane
 
 test_expect_success 'symbolic-ref deletes HEAD' '
 	git symbolic-ref -d HEAD &&
-	test_path_is_file .git/refs/heads/foo &&
-	test_path_is_missing .git/HEAD
+	test_path_is_missing .git/HEAD &&
+	reset_to_sane &&
+	git rev-parse --verify refs/heads/foo
 '
 reset_to_sane
 
 test_expect_success 'symbolic-ref deletes dangling HEAD' '
 	git symbolic-ref HEAD refs/heads/missing &&
 	git symbolic-ref -d HEAD &&
-	test_path_is_missing .git/refs/heads/missing &&
+	test_must_fail git rev-parse --verify refs/heads/missing &&
 	test_path_is_missing .git/HEAD
 '
 reset_to_sane
@@ -58,7 +59,7 @@ reset_to_sane
 test_expect_success 'symbolic-ref fails to delete real ref' '
 	echo "fatal: Cannot delete refs/heads/foo, not a symbolic ref" >expect &&
 	test_must_fail git symbolic-ref -d refs/heads/foo >actual 2>&1 &&
-	test_path_is_file .git/refs/heads/foo &&
+	git rev-parse --verify refs/heads/foo &&
 	test_cmp expect actual
 '
 reset_to_sane
@@ -114,7 +115,13 @@ test_expect_success 'symbolic-ref writes reflog entry' '
 	test_cmp expect actual
 '
 
-test_expect_success 'symbolic-ref does not create ref d/f conflicts' '
+if test "$ref_storage" = "files"
+then
+    test_cmd=test_expect_success
+else
+    test_cmd=test_expect_failure
+fi
+$test_cmd 'symbolic-ref does not create ref d/f conflicts' '
 	git checkout -b df &&
 	test_commit df &&
 	test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df &&
diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index 66bafb5..e918abc 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -96,7 +96,13 @@ test_expect_success 'new ref is a deeper prefix of existing packed' '
 
 '
 
-test_expect_success 'one new ref is a simple prefix of another' '
+expect=test_expect_success
+if test "$ref_storage" != "files"
+then
+	expect=test_expect_failure
+fi
+
+$expect 'one new ref is a simple prefix of another' '
 
 	prefix=refs/5 &&
 	test_update_rejected $prefix "a e" false "b c c/x d" \
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 9cf91dc..41ff1a2 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -6,6 +6,12 @@
 test_description='Test prune and reflog expiration'
 . ./test-lib.sh
 
+if test "$ref_storage" != "files"
+then
+	skip_all="This test is ref storage backend-specific"
+	test_done
+fi
+
 check_have () {
 	gaah= &&
 	for N in "$@"
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c465abe..bfcec3c 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -3,6 +3,12 @@
 test_description='Test handling of ref names that check-ref-format rejects'
 . ./test-lib.sh
 
+if test "$ref_storage" = "lmdb"
+then
+	skip_all="The lmdb backend refuses to save refs with bad names"
+	test_done
+fi
+
 test_expect_success setup '
 	test_commit one &&
 	test_commit two
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index e66b7cb..5fd3921 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -75,7 +75,7 @@ test_expect_success 'object with bad sha1' '
 '
 
 test_expect_success 'branch pointing to non-commit' '
-	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
+	write_ref refs/heads/invalid $(git rev-parse HEAD^{tree}) &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
@@ -220,7 +220,7 @@ test_expect_success 'tag pointing to nonexistent' '
 
 	tag=$(git hash-object -t tag -w --stdin <invalid-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/invalid &&
+	write_ref refs/tags/invalid $tag &&
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
 	cat out &&
@@ -241,7 +241,7 @@ test_expect_success 'tag pointing to something else than its type' '
 
 	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	write_ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags
 '
@@ -258,7 +258,7 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 
 	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	write_ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	git fsck --tags 2>out &&
 
@@ -282,7 +282,7 @@ test_expect_success 'tag with bad tagger' '
 
 	tag=$(git hash-object --literally -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	write_ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	grep "error in tag .*: invalid author/committer" out
@@ -301,7 +301,7 @@ test_expect_success 'tag with NUL in header' '
 
 	tag=$(git hash-object --literally -t tag -w --stdin <tag-NUL-header) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	write_ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	cat out &&
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 613d9bf..a9a15ca 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -167,7 +167,7 @@ test_expect_success 'relative path when cwd is outside worktree' '
 '
 
 test_expect_success 'relative path when startup_info is NULL' '
-	test_must_fail test-match-trees HEAD:./file.txt HEAD:./file.txt 2>error &&
+	test_must_fail test-match-trees $(git rev-parse HEAD):./file.txt $(git rev-parse HEAD):./file.txt 2>error &&
 	grep "BUG: startup_info struct is not initialized." error
 '
 
@@ -213,7 +213,7 @@ test_expect_success 'arg before dashdash must be a revision (ambiguous)' '
 	{
 		# we do not want to use rev-parse here, because
 		# we are testing it
-		cat .git/refs/heads/foobar &&
+		raw_ref refs/heads/foobar &&
 		printf "%s\n" --
 	} >expect &&
 	git rev-parse foobar -- >actual &&
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6847f75..94e8ec8 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -8,7 +8,7 @@ test_description='checkout can handle submodules'
 test_expect_success 'setup' '
 	mkdir submodule &&
 	(cd submodule &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 test_commit first) &&
 	git add submodule &&
 	test_tick &&
diff --git a/t/t2105-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
index a7f3d47..ce151a4 100755
--- a/t/t2105-update-index-gitfile.sh
+++ b/t/t2105-update-index-gitfile.sh
@@ -11,7 +11,7 @@ test_description='git update-index for gitlink to .git file.
 test_expect_success 'submodule with absolute .git file' '
 	mkdir sub1 &&
 	(cd sub1 &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 REAL="$(pwd)/.real" &&
 	 mv .git "$REAL" &&
 	 echo "gitdir: $REAL" >.git &&
@@ -25,7 +25,7 @@ test_expect_success 'add gitlink to absolute .git file' '
 test_expect_success 'submodule with relative .git file' '
 	mkdir sub2 &&
 	(cd sub2 &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 mv .git .real &&
 	 echo "gitdir: .real" >.git &&
 	 test_commit first)
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index dfe02f4..b00adef 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -22,7 +22,7 @@ test_expect_success 'update-index -h with corrupt index' '
 	mkdir broken &&
 	(
 		cd broken &&
-		git init &&
+		git init $ref_storage_arg &&
 		>.git/index &&
 		test_expect_code 129 git update-index -h >usage 2>&1
 	) &&
@@ -43,7 +43,7 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
 '
 
 test_expect_success '--cacheinfo does not accept gitlink null sha1' '
-	git init submodule &&
+	git init submodule $ref_storage_arg &&
 	(cd submodule && test_commit foo) &&
 	git add submodule &&
 	git rev-parse :submodule >expect &&
@@ -70,7 +70,7 @@ test_expect_success '.lock files cleaned up' '
 	(
 	cd cleanup &&
 	mkdir worktree &&
-	git init repo &&
+	git init $ref_storage_arg repo &&
 	cd repo &&
 	git config core.worktree ../../worktree &&
 	# --refresh triggers late setup_work_tree,
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 954fc51..882a5b7 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -46,7 +46,7 @@ test_expect_success modify '
 	>yomin/yomin &&
 	(
 		cd yomin &&
-		git init &&
+		git init $ref_storage_arg &&
 		git add yomin &&
 		git commit -m "sub initial"
 	) &&
@@ -60,7 +60,7 @@ test_expect_success modify '
 	>yonk/yonk &&
 	(
 		cd yonk &&
-		git init &&
+		git init $ref_storage_arg &&
 		git add yonk &&
 		git commit -m "sub initial"
 	) &&
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index d043078..ee42c1e 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -194,7 +194,7 @@ test_expect_success 'subdirectory ignore (setup)' '
 	mkdir -p top/l1/l2 &&
 	(
 		cd top &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo /.gitignore >.gitignore &&
 		echo l1 >>.gitignore &&
 		echo l2 >l1/.gitignore &&
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 580e158..3cf2a74 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -55,9 +55,9 @@ test_expect_success 'git update-index --add to add various paths.' '
 	: >path9 &&
 	date >path10 &&
 	git update-index --add -- path0 path?/file? pathx/ju path7 path8 path9 path10 &&
-	git init submod1 &&
+	git init $ref_storage_arg submod1 &&
 	git -C submod1 commit --allow-empty -m "empty 1" &&
-	git init submod2 &&
+	git init $ref_storage_arg submod2 &&
 	git -C submod2 commit --allow-empty -m "empty 2" &&
 	git update-index --add submod[12] &&
 	(
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 0a4ff6d..368c03e 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -11,10 +11,10 @@ test_expect_success 'setup: create superproject' '
 
 test_expect_success 'setup: create subprojects' '
 	mkdir sub1 &&
-	( cd sub1 && git init && : >Makefile && git add * &&
+	( cd sub1 && git init $ref_storage_arg && : >Makefile && git add * &&
 	git commit -q -m "subproject 1" ) &&
 	mkdir sub2 &&
-	( cd sub2 && git init && : >Makefile && git add * &&
+	( cd sub2 && git init $ref_storage_arg && : >Makefile && git add * &&
 	git commit -q -m "subproject 2" ) &&
 	git update-index --add sub1 &&
 	git add sub2 &&
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 2f5f41a..8d26bb9 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -8,7 +8,7 @@ test_expect_success setup '
 	test_tick &&
 	mkdir -p sub && (
 		cd sub &&
-		git init &&
+		git init $ref_storage_arg &&
 		>subfile &&
 		git add subfile &&
 		git commit -m "subproject commit #1"
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 144e9ce..aa31444 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -19,26 +19,26 @@ test_expect_success 'prepare a trivial repository' '
 
 test_expect_success 'git branch --help should not have created a bogus branch' '
 	test_might_fail git branch --man --help </dev/null >/dev/null 2>&1 &&
-	test_path_is_missing .git/refs/heads/--help
+	test_must_fail git rev-parse --verify refs/heads/--help
 '
 
 test_expect_success 'branch -h in broken repository' '
 	mkdir broken &&
 	(
 		cd broken &&
-		git init &&
-		>.git/refs/heads/master &&
+		git init $ref_storage_arg &&
+		write_ref refs/heads/master "" &&
 		test_expect_code 129 git branch -h >usage 2>&1
 	) &&
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
 test_expect_success 'git branch abc should create a branch' '
-	git branch abc && test_path_is_file .git/refs/heads/abc
+	git branch abc && git rev-parse --verify refs/heads/abc
 '
 
 test_expect_success 'git branch a/b/c should create a branch' '
-	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
+	git branch a/b/c && git rev-parse --verify refs/heads/a/b/c
 '
 
 test_expect_success 'git branch HEAD should fail' '
@@ -51,14 +51,14 @@ EOF
 test_expect_success 'git branch -l d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git branch -l d/e/f &&
-	test_path_is_file .git/refs/heads/d/e/f &&
-	test_path_is_file .git/logs/refs/heads/d/e/f &&
-	test_cmp expect .git/logs/refs/heads/d/e/f
+	git rev-parse --verify refs/heads/d/e/f &&
+	raw_reflog refs/heads/d/e/f > reflog &&
+	test_cmp expect reflog
 '
 
 test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
 	git branch -d d/e/f &&
-	test_path_is_missing .git/refs/heads/d/e/f &&
+	test_must_fail git rev-parse --verify refs/heads/d/e/f &&
 	test_must_fail git reflog exists refs/heads/d/e/f
 '
 
@@ -156,34 +156,34 @@ test_expect_success 'git branch -M master2 master2 should work when master is ch
 
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse --verify refs/heads/t &&
 	git branch -v -d t &&
-	test_path_is_missing .git/refs/heads/t
+	test_must_fail git rev-parse --verify refs/heads/t
 '
 
 test_expect_success 'git branch -v -m t s should work' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse --verify refs/heads/t &&
 	git branch -v -m t s &&
-	test_path_is_missing .git/refs/heads/t &&
-	test_path_is_file .git/refs/heads/s &&
+	test_must_fail git rev-parse --verify refs/heads/t &&
+	git rev-parse --verify refs/heads/s &&
 	git branch -d s
 '
 
 test_expect_success 'git branch -m -d t s should fail' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse refs/heads/t &&
 	test_must_fail git branch -m -d t s &&
 	git branch -d t &&
-	test_path_is_missing .git/refs/heads/t
+	test_must_fail git rev-parse refs/heads/t
 '
 
 test_expect_success 'git branch --list -d t should fail' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse refs/heads/t &&
 	test_must_fail git branch --list -d t &&
 	git branch -d t &&
-	test_path_is_missing .git/refs/heads/t
+	test_must_fail git rev-parse refs/heads/t
 '
 
 test_expect_success 'git branch --column' '
@@ -263,6 +263,10 @@ EOF
 	test_cmp expected actual
 '
 
+# All alternate ref storage backends require config, so we just skip
+# the "no-config" test if we're using one.
+if test $ref_storage = "files"
+then
 mv .git/config .git/config-saved
 
 test_expect_success 'git branch -m q q2 without config should succeed' '
@@ -271,6 +275,7 @@ test_expect_success 'git branch -m q q2 without config should succeed' '
 '
 
 mv .git/config-saved .git/config
+fi
 
 git config branch.s/s.dummy Hello
 
@@ -294,26 +299,26 @@ test_expect_success 'deleting a symref' '
 	git symbolic-ref refs/heads/symref refs/heads/target &&
 	echo "Deleted branch symref (was refs/heads/target)." >expect &&
 	git branch -d symref >actual &&
-	test_path_is_file .git/refs/heads/target &&
-	test_path_is_missing .git/refs/heads/symref &&
+	git rev-parse refs/heads/target &&
+	test_must_fail git rev-parse refs/heads/symref &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'deleting a dangling symref' '
 	git symbolic-ref refs/heads/dangling-symref nowhere &&
-	test_path_is_file .git/refs/heads/dangling-symref &&
+	raw_ref refs/heads/dangling-symref &&
 	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
-	test_path_is_missing .git/refs/heads/dangling-symref &&
+	test_must_fail git rev-parse refs/heads/dangling-symref &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'deleting a self-referential symref' '
 	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
-	test_path_is_file .git/refs/heads/self-reference &&
+	raw_ref refs/heads/self-reference &&
 	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
 	git branch -d self-reference >actual &&
-	test_path_is_missing .git/refs/heads/self-reference &&
+	test_must_fail git rev-parse refs/heads/self-reference &&
 	test_i18ncmp expect actual
 '
 
@@ -321,16 +326,20 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
-	test_path_is_file .git/refs/heads/master &&
-	test_path_is_missing .git/refs/heads/master3
+	git rev-parse refs/heads/master &&
+	test_must_fail git rev-parse refs/heads/master3
 '
 
+# lmdb doesn't support store reflogs in the filesystem
+if test $ref_storage != "lmdb"
+then
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
 	git branch -l u &&
 	mv .git/logs/refs/heads/u real-u &&
 	ln -s real-u .git/logs/refs/heads/u &&
 	test_must_fail git branch -m u v
 '
+fi
 
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
@@ -570,9 +579,9 @@ EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git checkout -b g/h/i -l master &&
-	test_path_is_file .git/refs/heads/g/h/i &&
-	test_path_is_file .git/logs/refs/heads/g/h/i &&
-	test_cmp expect .git/logs/refs/heads/g/h/i
+	git rev-parse refs/heads/g/h/i &&
+	raw_reflog refs/heads/g/h/i > reflog &&
+	test_cmp expect reflog
 '
 
 test_expect_success 'checkout -b makes reflog by default' '
@@ -922,17 +931,17 @@ test_expect_success '--merged catches invalid object names' '
 
 test_expect_success 'tracking with unexpected .fetch refspec' '
 	rm -rf a b c d &&
-	git init a &&
+	git init $ref_storage_arg a &&
 	(
 		cd a &&
 		test_commit a
 	) &&
-	git init b &&
+	git init $ref_storage_arg b &&
 	(
 		cd b &&
 		test_commit b
 	) &&
-	git init c &&
+	git init $ref_storage_arg c &&
 	(
 		cd c &&
 		test_commit c &&
@@ -940,7 +949,7 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 		git remote add b ../b &&
 		git fetch --all
 	) &&
-	git init d &&
+	git init $ref_storage_arg d &&
 	(
 		cd d &&
 		git remote add c ../c &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 9b182a0..5d55be3 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -11,6 +11,13 @@ semantic is still the same.
 '
 . ./test-lib.sh
 
+backend=$ref_storage
+if test "$backend" = "lmdb"
+then
+	skip_all="The lmdb ref storage doesn't pack refs"
+	test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 3b7caca..84d1e8e 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -3,6 +3,12 @@
 test_description='tests for the peel_ref optimization of packed-refs'
 . ./test-lib.sh
 
+if test "$ref_storage" = "lmdb"
+then
+	skip_all="The lmdb ref storage doesn't pack refs"
+	test_done
+fi
+
 test_expect_success 'create annotated tag in refs/tags' '
 	test_commit base &&
 	git tag -m annotated foo
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 19aed7e..49148a2 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -79,7 +79,7 @@ test_expect_success 'fail to merge empty notes ref into empty notes ref (z => y)
 test_expect_success 'fail to merge into various non-notes refs' '
 	test_must_fail git -c "core.notesRef=refs/notes" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/" notes merge x &&
-	mkdir -p .git/refs/notes/dir &&
+	git update-ref refs/notes/dir/test HEAD &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir/" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 544f9ad..5508eb0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -608,7 +608,7 @@ test_expect_success 'submodule rebase setup' '
 	git checkout A &&
 	mkdir sub &&
 	(
-		cd sub && git init && >elif &&
+		cd sub && git init $ref_storage_arg && >elif &&
 		git add elif && git commit -m "submodule initial"
 	) &&
 	echo 1 >file1 &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d046d98..01d207e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -220,7 +220,7 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 test_expect_success 'Call "rm" from outside the work tree' '
 	mkdir repo &&
 	(cd repo &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 echo something > somefile &&
 	 git add somefile &&
 	 git commit -m "add a file" &&
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 8eb4794..e7ac52e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -224,7 +224,7 @@ EOF
 
 test_expect_success \
     'allow empty tag email' \
-    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'write_ref refs/tags/mytag $(git mktag <tag.sig 2>message)'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -352,7 +352,7 @@ EOF
 
 test_expect_success \
     'create valid tag' \
-    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'write_ref refs/tags/mytag $(git mktag <tag.sig 2>message)'
 
 ############################################################
 # 25. check mytag
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2142c1f..1e3b50e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -671,7 +671,7 @@ test_expect_success 'store updates stash ref and reflog' '
 	git reset --hard &&
 	! grep quux bazzy &&
 	git stash store -m quuxery $STASH_ID &&
-	test $(cat .git/refs/stash) = $STASH_ID &&
+	test $(git rev-parse stash) = $STASH_ID &&
 	git reflog --format=%H stash| grep $STASH_ID &&
 	git stash pop &&
 	grep quux bazzy
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 43c488b..76b3b64 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -112,7 +112,7 @@ test_expect_success 'diff-tree -r with wildcard' '
 
 test_expect_success 'setup submodules' '
 	test_tick &&
-	git init submod &&
+	git init $ref_storage_arg submod &&
 	( cd submod && test_commit first; ) &&
 	git add submod &&
 	git commit -m first &&
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0446201..b03b4f6 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -247,7 +247,7 @@ test_expect_success 'clean up crlf leftovers' '
 '
 
 test_expect_success 'submodule diff' '
-	git init sub &&
+	git init $ref_storage_arg sub &&
 	( cd sub && test_commit sub1 ) &&
 	git add sub &&
 	test_tick &&
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 518bf95..147351d 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -344,7 +344,7 @@ test_expect_success 'combined (empty submodule)' '
 
 test_expect_success 'combined (with submodule)' '
 	rm -fr sub &&
-	git clone --no-checkout . sub &&
+	git clone $ref_storage_arg --no-checkout . sub &&
 	git diff >actual &&
 	test_cmp expect.withsub actual
 '
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 461f4bb..553cabe 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup' '
 	git commit -a -m second &&
 	mkdir -p test-outside/repo && (
 		cd test-outside/repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo "1 1" >a &&
 		git add . &&
 		git commit -m 1
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 0ba8194..427b601 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup diff.submodule' '
 	test_commit one &&
 	INITIAL=$(git rev-parse HEAD) &&
 
-	git init submodule &&
+	git init $ref_storage_arg submodule &&
 	(
 		cd submodule &&
 		test_commit two &&
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 4b68bba..79249ef 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -190,7 +190,8 @@ test_expect_success \
 test_expect_success \
     'git get-tar-commit-id' \
     'git get-tar-commit-id <b.tar >b.commitid &&
-     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
+     raw_ref $(git symbolic-ref HEAD) > expect &&
+     test_cmp expect b.commitid'
 
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index ad7ad2f..cfe8038 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -93,7 +93,7 @@ test_expect_success 'prune: prune nonsense parameters' '
 test_expect_success 'prune: prune unreachable heads' '
 
 	git config core.logAllRefUpdates false &&
-	mv .git/logs .git/logs.old &&
+	delete_all_reflogs &&
 	: > file2 &&
 	git add file2 &&
 	git commit -m temporary &&
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index da9d599..f118735 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -21,7 +21,7 @@ test_expect_success 'create history reachable only from a bogus-named ref' '
 	test_tick && git commit --allow-empty -m bogus &&
 	bogus=$(git rev-parse HEAD) &&
 	git cat-file commit $bogus >saved &&
-	echo $bogus >.git/refs/heads/bogus..name &&
+	write_ref refs/heads/bogus..name $bogus &&
 	git reset --hard HEAD^
 '
 
@@ -47,7 +47,7 @@ test_expect_success 'destructive repack keeps packed object' '
 
 # subsequent tests will have different corruptions
 test_expect_success 'clean up bogus ref' '
-	rm .git/refs/heads/bogus..name
+	delete_ref refs/heads/bogus..name
 '
 
 # We create two new objects here, "one" and "two". Our
@@ -85,6 +85,13 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
 	test_cmp expect actual
 '
 
+backend=$ref_storage
+if test "$backend" = "lmdb"
+then
+       skip="The lmdb backend doesn't write a packed-refs file"
+       test_done
+fi
+
 # we do not want to count on running pack-refs to
 # actually pack it, as it is perfectly reasonable to
 # skip processing a broken ref
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f512098..0ab58f5 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -30,7 +30,7 @@ add () {
 	test_tick &&
 	commit=$(echo "$text" | git commit-tree $tree $parents) &&
 	eval "$name=$commit; export $name" &&
-	echo $commit > .git/refs/heads/$branch &&
+	git update-ref refs/heads/$branch $commit &&
 	eval ${branch}TIP=$commit
 }
 
@@ -45,10 +45,10 @@ pull_to_client () {
 
 			case "$heads" in
 			    *A*)
-				    echo $ATIP > .git/refs/heads/A;;
+				    git update-ref refs/heads/A $ATIP;;
 			esac &&
 			case "$heads" in *B*)
-			    echo $BTIP > .git/refs/heads/B;;
+			    git update-ref refs/heads/B $BTIP;;
 			esac &&
 			git symbolic-ref HEAD refs/heads/$(echo $heads \
 				| sed -e "s/^\(.\).*$/\1/") &&
@@ -92,8 +92,8 @@ test_expect_success 'setup' '
 		cur=$(($cur+1))
 	done &&
 	add B1 $A1 &&
-	echo $ATIP > .git/refs/heads/A &&
-	echo $BTIP > .git/refs/heads/B &&
+	git update-ref refs/heads/A $ATIP &&
+	git update-ref refs/heads/B $BTIP &&
 	git symbolic-ref HEAD refs/heads/B
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0c10c85..9591271 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -28,20 +28,20 @@ test_expect_success setup '
 	git commit -a -m original'
 
 test_expect_success "clone and setup child repos" '
-	git clone . one &&
+	git clone $ref_storage_arg . one &&
 	(
 		cd one &&
 		echo >file updated by one &&
 		git commit -a -m "updated by one"
 	) &&
-	git clone . two &&
+	git clone $ref_storage_arg  . two &&
 	(
 		cd two &&
 		git config branch.master.remote one &&
 		git config remote.one.url ../one/.git/ &&
 		git config remote.one.fetch refs/heads/master:refs/heads/one
 	) &&
-	git clone . three &&
+	git clone $ref_storage_arg  . three &&
 	(
 		cd three &&
 		git config branch.master.remote two &&
@@ -53,8 +53,8 @@ test_expect_success "clone and setup child repos" '
 			echo "Pull: refs/heads/one:refs/heads/one"
 		} >.git/remotes/two
 	) &&
-	git clone . bundle &&
-	git clone . seven
+	git clone $ref_storage_arg  . bundle &&
+	git clone $ref_storage_arg  . seven
 '
 
 test_expect_success "fetch test" '
@@ -63,7 +63,7 @@ test_expect_success "fetch test" '
 	git commit -a -m "updated by origin" &&
 	cd two &&
 	git fetch &&
-	test -f .git/refs/heads/one &&
+	git rev-parse --verify refs/heads/one &&
 	mine=$(git rev-parse refs/heads/one) &&
 	his=$(cd ../one && git rev-parse refs/heads/master) &&
 	test "z$mine" = "z$his"
@@ -73,8 +73,8 @@ test_expect_success "fetch test for-merge" '
 	cd "$D" &&
 	cd three &&
 	git fetch &&
-	test -f .git/refs/heads/two &&
-	test -f .git/refs/heads/one &&
+	git rev-parse --verify refs/heads/two &&
+	git rev-parse --verify refs/heads/one &&
 	master_in_two=$(cd ../two && git rev-parse master) &&
 	one_in_two=$(cd ../two && git rev-parse one) &&
 	{
@@ -180,7 +180,7 @@ test_expect_success 'fetch tags when there is no tags' '
 
     mkdir notags &&
     cd notags &&
-    git init &&
+    git init $ref_storage_arg &&
 
     git fetch -t ..
 
@@ -194,7 +194,7 @@ test_expect_success 'fetch following tags' '
 
 	mkdir four &&
 	cd four &&
-	git init &&
+	git init $ref_storage_arg &&
 
 	git fetch .. :track &&
 	git show-ref --verify refs/tags/anno &&
@@ -204,7 +204,7 @@ test_expect_success 'fetch following tags' '
 
 test_expect_success 'fetch uses remote ref names to describe new refs' '
 	cd "$D" &&
-	git init descriptive &&
+	git init $ref_storage_arg descriptive &&
 	(
 		cd descriptive &&
 		git config remote.o.url .. &&
@@ -238,7 +238,7 @@ test_expect_success 'fetch must not resolve short tag name' '
 
 	mkdir five &&
 	cd five &&
-	git init &&
+	git init $ref_storage_arg &&
 
 	test_must_fail git fetch .. anno:five
 
@@ -251,7 +251,7 @@ test_expect_success 'fetch can now resolve short remote name' '
 
 	mkdir six &&
 	cd six &&
-	git init &&
+	git init $ref_storage_arg &&
 
 	git fetch .. six:six
 '
@@ -529,7 +529,7 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	mkdir dups &&
 	(
 		cd dups &&
-		git init &&
+		git init $ref_storage_arg &&
 		git config branch.master.remote three &&
 		git config remote.three.url ../three/.git &&
 		git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
@@ -665,7 +665,7 @@ test_expect_success 'fetching a one-level ref works' '
 	test_commit extra &&
 	git reset --hard HEAD^ &&
 	git update-ref refs/foo extra &&
-	git init one-level &&
+	git init $ref_storage_arg one-level &&
 	(
 		cd one-level &&
 		git fetch .. HEAD refs/foo
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 954d0e4..0fef8ac 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -38,7 +38,7 @@ test_expect_success setup '
 	mkdir deepsubmodule &&
 	(
 		cd deepsubmodule &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo deepsubcontent > deepsubfile &&
 		git add deepsubfile &&
 		git commit -m new deepsubfile
@@ -46,7 +46,7 @@ test_expect_success setup '
 	mkdir submodule &&
 	(
 		cd submodule &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo subcontent > subfile &&
 		git add subfile &&
 		git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 207899a..b9ecfa0 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -26,6 +26,13 @@ test_expect_success 'suffix ref is ignored during fetch' '
 	test_cmp expect actual
 '
 
+backend=$ref_storage
+if test "$backend" = "lmdb"
+then
+    skip="The lmdb backend doesn't do crazy-long refs"
+    test_done
+fi
+
 test_expect_success 'try to create repo with absurdly long refname' '
 	ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40 &&
 	ref1440=$ref240/$ref240/$ref240/$ref240/$ref240/$ref240 &&
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index df8d2f0..114d25a 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,6 +173,13 @@ EOF
 	)
 '
 
+backend=$ref_storage
+if test "$backend" = "lmdb"
+then
+	skip="The lmdb backend needs write access for its locks"
+	test_done
+fi
+
 test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	cp -R .git read-only.git &&
 	find read-only.git -print | xargs chmod -w &&
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 4320082..49e7868 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -34,14 +34,14 @@ test_expect_success 'preparing first repository' '
 '
 
 test_expect_success 'preparing second repository' '
-	git clone A B &&
+	git clone $ref_storage_arg A B &&
 	commit_in B file2 &&
 	git -C B repack -ad &&
 	git -C B prune
 '
 
 test_expect_success 'cloning with reference (-l -s)' '
-	git clone -l -s --reference B A C
+	git clone $ref_storage_arg -l -s --reference B A C
 '
 
 test_expect_success 'existence of info/alternates' '
@@ -57,7 +57,7 @@ test_expect_success 'that reference gets used' '
 '
 
 test_expect_success 'cloning with reference (no -l -s)' '
-	GIT_TRACE_PACKET=$U.D git clone --reference B "file://$(pwd)/A" D
+	GIT_TRACE_PACKET=$U.D git clone $ref_storage_arg --reference B "file://$(pwd)/A" D
 '
 
 test_expect_success 'fetched no objects' '
@@ -108,20 +108,20 @@ test_expect_success 'preparing alternate repository #1' '
 '
 
 test_expect_success 'cloning alternate repo #2 and adding changes to repo #1' '
-	git clone F G &&
+	git clone $ref_storage_arg F G &&
 	commit_in F file2
 '
 
 test_expect_success 'cloning alternate repo #1, using #2 as reference' '
-	git clone --reference G F H
+	git clone $ref_storage_arg --reference G F H
 '
 
 test_expect_success 'cloning with reference being subset of source (-l -s)' '
-	git clone -l -s --reference A B E
+	git clone $ref_storage_arg -l -s --reference A B E
 '
 
 test_expect_success 'cloning with multiple references drops duplicates' '
-	git clone -s --reference B --reference A --reference B A dups &&
+	git clone $ref_storage_arg -s --reference B --reference A --reference B A dups &&
 	test_line_count = 2 dups/.git/objects/info/alternates
 '
 
@@ -129,11 +129,11 @@ test_expect_success 'clone with reference from a tagged repository' '
 	(
 		cd A && git tag -a -m tagged HEAD
 	) &&
-	git clone --reference=A A I
+	git clone $ref_storage_arg --reference=A A I
 '
 
 test_expect_success 'prepare branched repository' '
-	git clone A J &&
+	git clone $ref_storage_arg A J &&
 	(
 		cd J &&
 		git checkout -b other master^ &&
@@ -145,7 +145,7 @@ test_expect_success 'prepare branched repository' '
 '
 
 test_expect_success 'fetch with incomplete alternates' '
-	git init K &&
+	git init $ref_storage_arg K &&
 	echo "$base_dir/A/.git/objects" >K/.git/objects/info/alternates &&
 	(
 		cd K &&
@@ -160,29 +160,29 @@ test_expect_success 'fetch with incomplete alternates' '
 '
 
 test_expect_success 'clone using repo with gitfile as a reference' '
-	git clone --separate-git-dir=L A M &&
-	git clone --reference=M A N &&
+	git clone $ref_storage_arg --separate-git-dir=L A M &&
+	git clone $ref_storage_arg --reference=M A N &&
 	echo "$base_dir/L/objects" >expected &&
 	test_cmp expected "$base_dir/N/.git/objects/info/alternates"
 '
 
 test_expect_success 'clone using repo pointed at by gitfile as reference' '
-	git clone --reference=M/.git A O &&
+	git clone $ref_storage_arg --reference=M/.git A O &&
 	echo "$base_dir/L/objects" >expected &&
 	test_cmp expected "$base_dir/O/.git/objects/info/alternates"
 '
 
 test_expect_success 'clone and dissociate from reference' '
-	git init P &&
+	git init $ref_storage_arg P &&
 	(
 		cd P &&	test_commit one
 	) &&
-	git clone P Q &&
+	git clone $ref_storage_arg P Q &&
 	(
 		cd Q && test_commit two
 	) &&
-	git clone --no-local --reference=P Q R &&
-	git clone --no-local --reference=P --dissociate Q S &&
+	git clone $ref_storage_arg --no-local --reference=P Q R &&
+	git clone $ref_storage_arg --no-local --reference=P --dissociate Q S &&
 	# removing the reference P would corrupt R but not S
 	rm -fr P &&
 	test_must_fail git -C R fsck &&
@@ -198,14 +198,14 @@ test_expect_success 'clone, dissociate from partial reference and repack' '
 		test_commit two &&
 		git repack
 	) &&
-	git clone --bare P Q &&
+	git clone $ref_storage_arg  --bare P Q &&
 	(
 		cd P &&
 		git checkout -b second &&
 		test_commit three &&
 		git repack
 	) &&
-	git clone --bare --dissociate --reference=P Q R &&
+	git clone $ref_storage_arg  --bare --dissociate --reference=P Q R &&
 	ls R/objects/pack/*.pack >packs.txt &&
 	test_line_count = 1 packs.txt
 '
@@ -214,9 +214,9 @@ test_expect_success 'clone, dissociate from alternates' '
 	rm -fr A B C &&
 	test_create_repo A &&
 	commit_in A file1 &&
-	git clone --reference=A A B &&
+	git clone $ref_storage_arg  --reference=A A B &&
 	test_line_count = 1 B/.git/objects/info/alternates &&
-	git clone --local --dissociate B C &&
+	git clone $ref_storage_arg  --local --dissociate B C &&
 	! test -f C/.git/objects/info/alternates &&
 	( cd C && git fsck )
 '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 05ddc69..0c009ab 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -20,7 +20,8 @@ test_expect_success setup '
 	git commit -a -m "Third in one history." &&
 	A2=$(git rev-parse --verify HEAD) &&
 
-	rm -f .git/refs/heads/master .git/index &&
+	delete_ref refs/heads/master &&
+	rm -f .git/index &&
 
 	echo >fileA fileA again &&
 	echo >subdir/fileB fileB again &&
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 39b3238..b2003c5 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -34,7 +34,7 @@ doit () {
 
 	commit=$(echo $NAME | git commit-tree $T $PARENTS) &&
 
-	echo $commit >.git/refs/tags/$NAME &&
+	git update-ref refs/tags/$NAME $commit &&
 	echo $commit
 }
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba..60f0011 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -124,13 +124,13 @@ tagger T A Gger <> 0 +0000
 EOF
 
 test_expect_success 'tag replaced commit' '
-     git mktag <tag.sig >.git/refs/tags/mytag 2>message
+    write_ref refs/tags/mytag $(git mktag <tag.sig 2>message)
 '
 
 test_expect_success '"git fsck" works' '
      git fsck master >fsck_master.out &&
      grep "dangling commit $R" fsck_master.out &&
-     grep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
+     grep "dangling tag $(raw_ref refs/tags/mytag)" fsck_master.out &&
      test -z "$(git fsck)"
 '
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 85f2694..ca30c18 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -128,7 +128,8 @@ test_expect_success 'no warning was displayed for A' '
 '
 
 test_expect_success 'rename tag A to Q locally' '
-	mv .git/refs/tags/A .git/refs/tags/Q
+	write_ref refs/tags/Q $(raw_ref refs/tags/A) &&
+	delete_ref refs/tags/A
 '
 cat - >err.expect <<EOF
 warning: tag 'A' is really 'Q' here
@@ -138,7 +139,8 @@ test_expect_success 'warning was displayed for Q' '
 	test_i18ncmp err.expect err.actual
 '
 test_expect_success 'rename tag Q back to A' '
-	mv .git/refs/tags/Q .git/refs/tags/A
+	write_ref refs/tags/A $(raw_ref refs/tags/Q) &&
+	delete_ref refs/tags/Q
 '
 
 test_expect_success 'pack tag refs' 'git pack-refs'
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index cdb67a0..f7ba4ca 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -16,8 +16,8 @@ test_expect_success setup '
 
 test_expect_success 'Broken refs are reported correctly' '
 	r=refs/heads/bogus &&
-	: >.git/$r &&
-	test_when_finished "rm -f .git/$r" &&
+	write_ref $r '' &&
+	test_when_finished "delete_ref $r" &&
 	echo "warning: ignoring broken ref $r" >broken-err &&
 	git for-each-ref >out 2>err &&
 	test_cmp full-list out &&
@@ -26,8 +26,8 @@ test_expect_success 'Broken refs are reported correctly' '
 
 test_expect_success 'NULL_SHA1 refs are reported correctly' '
 	r=refs/heads/zeros &&
-	echo $ZEROS >.git/$r &&
-	test_when_finished "rm -f .git/$r" &&
+	write_ref $r $ZEROS &&
+	test_when_finished "delete_ref $r" &&
 	echo "warning: ignoring broken ref $r" >zeros-err &&
 	git for-each-ref >out 2>err &&
 	test_cmp full-list out &&
@@ -39,8 +39,8 @@ test_expect_success 'NULL_SHA1 refs are reported correctly' '
 
 test_expect_success 'Missing objects are reported correctly' '
 	r=refs/heads/missing &&
-	echo $MISSING >.git/$r &&
-	test_when_finished "rm -f .git/$r" &&
+	write_ref $r $MISSING &&
+	test_when_finished "delete_ref $r" &&
 	echo "fatal: missing object $MISSING for $r" >missing-err &&
 	test_must_fail git for-each-ref 2>err &&
 	test_cmp missing-err err &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 8859236..ab1fb99 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -65,7 +65,7 @@ test_expect_success setup '
 test_expect_success "checkout from non-existing branch" '
 
 	git checkout -b delete-me master &&
-	rm .git/refs/heads/delete-me &&
+	git update-ref -d --no-deref refs/heads/delete-me &&
 	test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
 	git checkout master &&
 	test refs/heads/master = "$(git symbolic-ref HEAD)"
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 86ceb38..36832ec 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -431,7 +431,7 @@ test_expect_success 'nested git work tree' '
 	mkdir -p foo bar baz/boo &&
 	(
 		cd foo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit nested hello.world
 	) &&
 	(
@@ -440,7 +440,7 @@ test_expect_success 'nested git work tree' '
 	) &&
 	(
 		cd baz/boo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -d &&
@@ -455,6 +455,7 @@ test_expect_success 'should clean things that almost look like git but are not'
 	rm -fr almost_git almost_bare_git almost_submodule &&
 	mkdir -p almost_git/.git/objects &&
 	mkdir -p almost_git/.git/refs &&
+	mkdir -p almost_git/.git/refs.lmdb &&
 	cat >almost_git/.git/HEAD <<-\EOF &&
 	garbage
 	EOF
@@ -475,7 +476,7 @@ test_expect_success 'should not clean submodules' '
 	mkdir repo to_clean &&
 	(
 		cd repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit msg hello.world
 	) &&
 	git submodule add ./repo/.git sub1 &&
@@ -511,7 +512,7 @@ test_expect_success POSIXPERM 'should avoid cleaning possible submodules' '
 
 test_expect_success 'nested (empty) git should be kept' '
 	rm -fr empty_repo to_clean &&
-	git init empty_repo &&
+	git init $ref_storage_arg empty_repo &&
 	mkdir to_clean &&
 	>to_clean/should_clean.this &&
 	git clean -f -d &&
@@ -521,7 +522,7 @@ test_expect_success 'nested (empty) git should be kept' '
 
 test_expect_success 'nested bare repositories should be cleaned' '
 	rm -fr bare1 bare2 subdir &&
-	git init --bare bare1 &&
+	git init $ref_storage_arg --bare bare1 &&
 	git clone --local --bare . bare2 &&
 	mkdir subdir &&
 	cp -r bare2 subdir/bare3 &&
@@ -534,7 +535,7 @@ test_expect_success 'nested bare repositories should be cleaned' '
 test_expect_failure 'nested (empty) bare repositories should be cleaned even when in .git' '
 	rm -fr strange_bare &&
 	mkdir strange_bare &&
-	git init --bare strange_bare/.git &&
+	git init $ref_storage_arg --bare strange_bare/.git &&
 	git clean -f -d &&
 	test_path_is_missing strange_bare
 '
@@ -552,7 +553,7 @@ test_expect_success 'giving path in nested git work tree will remove it' '
 	mkdir repo &&
 	(
 		cd repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		mkdir -p bar/baz &&
 		test_commit msg bar/baz/hello.world
 	) &&
@@ -567,7 +568,7 @@ test_expect_success 'giving path to nested .git will not remove it' '
 	mkdir repo untracked &&
 	(
 		cd repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit msg hello.world
 	) &&
 	git clean -f -d repo/.git &&
@@ -582,7 +583,7 @@ test_expect_success 'giving path to nested .git/ will remove contents' '
 	mkdir repo untracked &&
 	(
 		cd repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit msg hello.world
 	) &&
 	git clean -f -d repo/.git/ &&
@@ -596,7 +597,7 @@ test_expect_success 'force removal of nested git work tree' '
 	mkdir -p foo bar baz/boo &&
 	(
 		cd foo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit nested hello.world
 	) &&
 	(
@@ -605,7 +606,7 @@ test_expect_success 'force removal of nested git work tree' '
 	) &&
 	(
 		cd baz/boo &&
-		git init &&
+		git init $ref_storage_arg &&
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -f -d &&
@@ -619,7 +620,7 @@ test_expect_success 'git clean -e' '
 	mkdir repo &&
 	(
 		cd repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		touch known 1 2 3 &&
 		git add known &&
 		git clean -f -e 1 -e 2 &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5572327..5892e48 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup - repository in init subdirectory' '
 	mkdir init &&
 	(
 		cd init &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo a >a &&
 		git add a &&
 		git commit -m "submodule commit 1" &&
@@ -52,8 +52,8 @@ test_expect_success 'setup - hide init subdirectory' '
 '
 
 test_expect_success 'setup - repository to add submodules to' '
-	git init addtest &&
-	git init addtest-ignore
+	git init $ref_storage_arg addtest &&
+	git init $ref_storage_arg addtest-ignore
 '
 
 # The 'submodule add' tests need some repository to add as a submodule.
@@ -540,7 +540,7 @@ test_expect_success 'add submodules without specifying an explicit path' '
 	mkdir repo &&
 	(
 		cd repo &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo r >r &&
 		git add r &&
 		git commit -m "repo commit 1"
@@ -585,11 +585,11 @@ test_expect_success 'set up for relative path tests' '
 	mkdir reltest &&
 	(
 		cd reltest &&
-		git init &&
+		git init $ref_storage_arg &&
 		mkdir sub &&
 		(
 			cd sub &&
-			git init &&
+			git init $ref_storage_arg &&
 			test_commit foo
 		) &&
 		git add sub &&
@@ -754,7 +754,7 @@ test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.gi
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		mkdir -p a/b/c &&
-		(cd a/b/c; git init) &&
+		(cd a/b/c; git init $ref_storage_arg) &&
 		git config remote.origin.url ../foo/bar.git &&
 		git submodule add ../bar/a/b/c ./a/b/c &&
 		git submodule init &&
@@ -975,7 +975,7 @@ test_expect_success 'submodule with UTF-8 name' '
 	mkdir "$svname" &&
 	(
 		cd "$svname" &&
-		git init &&
+		git init $ref_storage_arg &&
 		>sub &&
 		git add sub &&
 		git commit -m "init sub"
@@ -990,7 +990,7 @@ test_expect_success 'submodule add clone shallow submodule' '
 	pwd=$(pwd) &&
 	(
 		cd super &&
-		git init &&
+		git init $ref_storage_arg &&
 		git submodule add --depth=1 file://"$pwd"/example2 submodule &&
 		(
 			cd submodule &&
@@ -1003,7 +1003,7 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	mkdir -p dir1/b &&
 	(
 		cd dir1/b &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo hi >testfile2 &&
 		git add . &&
 		git commit -m "test1"
@@ -1011,7 +1011,7 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	mkdir -p dir2/b &&
 	(
 		cd dir2/b &&
-		git init &&
+		git init $ref_storage_arg &&
 		echo hello >testfile1 &&
 		git add .  &&
 		git commit -m "test2"
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19..85166da 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
-	git clone . submodule &&
+	git clone $ref_storage_arg . submodule &&
 	git add submodule &&
 	test_tick &&
 	git commit -m submodule &&
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 0d5b42a..9d147df 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 
 	mkdir sub &&
 	(cd sub &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 echo original > file &&
 	 git add file &&
 	 test_tick &&
@@ -68,10 +68,10 @@ test_expect_success setup '
 test_expect_success 'setup for merge search' '
 	mkdir merge-search &&
 	(cd merge-search &&
-	git init &&
+	git init $ref_storage_arg &&
 	mkdir sub &&
 	(cd sub &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 echo "file-a" > file-a &&
 	 git add file-a &&
 	 git commit -m "sub-a" &&
@@ -232,10 +232,10 @@ test_expect_success 'merging with a modify/modify conflict between merge bases'
 test_expect_success 'setup for recursive merge with submodule' '
 	mkdir merge-recursive &&
 	(cd merge-recursive &&
-	 git init &&
+	 git init $ref_storage_arg &&
 	 mkdir sub &&
 	 (cd sub &&
-	  git init &&
+	  git init $ref_storage_arg &&
 	  test_commit a &&
 	  git checkout -b sub-b master &&
 	  test_commit b &&
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index cd480ed..0c9c8f9 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -213,7 +213,8 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" '
-	rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
+	rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
+	git reflog expire --all --expire=all &&
 	mkdir "$GIT_DIR/svn" &&
 	git svn multi-fetch
 	'
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 0990f8d..7b9140a 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -60,7 +60,7 @@ test_expect_success 'add a file with plus signs' '
 	'
 
 test_expect_success 'clone the repository to test rebase' '
-	git svn clone "$svnrepo" test-rebase &&
+	git svn clone $ref_storage_arg "$svnrepo" test-rebase &&
 	(
 		cd test-rebase &&
 		echo test-rebase >test-rebase &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b5149fd..b36008c 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -42,7 +42,7 @@ test_expect_success 'fast-export | fast-import' '
 	WER=$(git rev-parse --verify wer) &&
 	MUSS=$(git rev-parse --verify muss) &&
 	mkdir new &&
-	git --git-dir=new/.git init &&
+	git --git-dir=new/.git init $ref_storage_arg &&
 	git fast-export --all |
 	(cd new &&
 	 git fast-import &&
@@ -158,7 +158,7 @@ test_expect_success 'setup submodule' '
 	mkdir sub &&
 	(
 		cd sub &&
-		git init  &&
+		git init $ref_storage_arg &&
 		echo test file > file &&
 		git add file &&
 		git commit -m sub_initial
@@ -183,7 +183,7 @@ test_expect_success 'submodule fast-export | fast-import' '
 	SUBENT2=$(git ls-tree master sub) &&
 	rm -rf new &&
 	mkdir new &&
-	git --git-dir=new/.git init &&
+	git --git-dir=new/.git init $ref_storage_arg &&
 	git fast-export --signed-tags=strip --all |
 	(cd new &&
 	 git fast-import &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2ba62fb..605816a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -126,7 +126,7 @@ actual="$TRASH_DIRECTORY/actual"
 
 test_expect_success 'setup for __gitdir tests' '
 	mkdir -p subdir/subsubdir &&
-	git init otherrepo
+	git init $ref_storage_arg otherrepo
 '
 
 test_expect_success '__gitdir - from command line (through $__git_dir)' '
@@ -177,7 +177,7 @@ test_expect_success '__gitdir - cwd is a .git directory' '
 test_expect_success '__gitdir - parent is a .git directory' '
 	echo "$(pwd -P)/.git" >expected &&
 	(
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index ffbfa0e..ae18e14 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory' '
 test_expect_success 'prompt - deep inside .git directory' '
 	printf " (GIT_DIR!)" >expected &&
 	(
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d99eb3..9907201 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -783,8 +783,8 @@ test_create_repo () {
 	repo="$1"
 	mkdir -p "$repo"
 	(
-		cd "$repo" || error "Cannot setup test environment"
-		"$GIT_EXEC_PATH/git-init" "--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
+	    cd "$repo" || error "Cannot setup test environment"
+		"$GIT_EXEC_PATH/git-init" $ref_storage_arg "--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
 	) || exit
@@ -941,3 +941,52 @@ mingw_read_file_strip_cr_ () {
 		eval "$1=\$$1\$line"
 	done
 }
+
+raw_ref() {
+    if test $ref_storage = "lmdb"
+    then
+	test-refs-lmdb-backend "$1" 2>/dev/null
+    else
+	cat ".git/$1"
+    fi
+}
+
+delete_ref() {
+    if test $ref_storage = "lmdb"
+    then
+	test-refs-lmdb-backend -d "$1" 2>/dev/null
+    else
+	rm ".git/$1"
+    fi
+}
+
+write_ref() {
+    if test $ref_storage = "lmdb"
+    then
+	test-refs-lmdb-backend "$1" "$2" 2>/dev/null
+    else
+	echo "$2" > ".git/$1"
+    fi
+}
+
+raw_reflog() {
+    if test $ref_storage = "lmdb"
+    then
+	test-refs-lmdb-backend -l "$1" 2>/dev/null
+    else
+	cat ".git/logs/$1"
+    fi
+}
+
+delete_all_reflogs() {
+    if test $ref_storage = "lmdb"
+    then
+	test-refs-lmdb-backend -c
+    fi
+    # We have to do this in any case to handle logs for per-worktree refs
+    rm -rf .git/logs
+}
+
+append_reflog() {
+	test-refs-lmdb-backend -a "$1"
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ce40770..e736554 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -186,6 +186,8 @@ test "x$TERM" != "xdumb" && (
 	) &&
 	color=t
 
+ref_storage="files"
+ref_storage_arg=
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -201,6 +203,9 @@ do
 			exit 1;
 		}
 		run_list=$1; shift ;;
+	--ref-storage=*)
+	    GIT_TEST_REF_STORAGE=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift
+	    ;;
 	--run=*)
 		run_list=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift ;;
 	-h|--h|--he|--hel|--help)
@@ -247,6 +252,12 @@ do
 	esac
 done
 
+if test -n "$GIT_TEST_REF_STORAGE"
+then
+	ref_storage=$GIT_TEST_REF_STORAGE
+	ref_storage_arg="--ref-storage=$ref_storage"
+fi
+
 if test -n "$valgrind_only"
 then
 	test -z "$valgrind" && valgrind=memcheck
-- 
2.4.2.767.g62658d5-twtrsrc
