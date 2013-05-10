From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 8/8] rebase: implement --[no-]autostash and rebase.autostash
Date: Fri, 10 May 2013 19:56:45 +0530
Message-ID: <1368196005-5354-9-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGX-0007V1-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab3EJOZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:31 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37416 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab3EJOZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:28 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so2843663pde.37
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5PvnAnuGkma8Iftekk8UtTpubywnfjHw88EEqscMFSs=;
        b=X/PER4hCaJY/7/KTIrYhrIX1wGq/6oj3sqf2KqzQKdpAUaWChKM/XU742dZ0On0wl+
         oS9f3NXTyoaFZQfk1QqeMCu3Ng3//HqpSleJzUwwWNXGYPtzWj/H4eTW+DwOLTf5dduD
         PF8MP2sYJ5rvfUwNENsT8FEVFQ7To/N5G2WFymZeF/4Trezl7aM/Ncx9Mzba8i/o3L9J
         Dv9uV6qMN0fJEycy2zBuJZrB+pwjJXQUy5j/YdkSBl4DfpeIDsIC2SYRQwj04tRoYcUs
         SFiV0ck2cQJX5Wtx2otg1f0oZm5yUKvOxK8plgFk8CGLNya55uyGKGq8gydjM5iHc9/8
         Y8og==
X-Received: by 10.66.122.74 with SMTP id lq10mr17896285pab.78.1368195927760;
        Fri, 10 May 2013 07:25:27 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223844>

This new feature allows a rebase to be executed on a dirty worktree.
It works by creating a temporary stash and storing it in
$state_dir/autostash before the operation, and applying it after a
successful operation.  It will be removed along with the $state_dir if
the operation is aborted.

The feature creates a special stash that does not affect the normal
stash's reflogs, and will therefore be invisible to the end user.
This special stash is essentially a dangling merge commit which has
reasonable lifetime specified by gc.pruneexpire (default 2 weeks).

Most significantly, this feature means that a caller like pull (with
pull.rebase set to true) can easily be patched to remove the
require_clean_work_tree restriction.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt     |   8 +++
 Documentation/git-rebase.txt |  10 +++
 git-rebase.sh                |  43 ++++++++++++-
 t/t3420-rebase-autostash.sh  | 148 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+), 3 deletions(-)
 create mode 100755 t/t3420-rebase-autostash.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..7fd4035 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1867,6 +1867,14 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.autostash::
+	When set to true, automatically create a temporary stash
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run rebase on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful rebase might result in non-trivial conflicts.
+	Defaults to false.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index aca8405..c84854a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,6 +208,9 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.autostash::
+	If set to true enable '--autostash' option by default.
+
 OPTIONS
 -------
 --onto <newbase>::
@@ -394,6 +397,13 @@ If the '--autosquash' option is enabled by default using the
 configuration variable `rebase.autosquash`, this option can be
 used to override and disable this setting.
 
+--[no-]autostash::
+	Automatically create a temporary stash before the operation
+	begins, and apply it after the operation ends.  This means
+	that you can run rebase on a dirty worktree.  However, use
+	with care: the final stash application after a successful
+	rebase might result in non-trivial conflicts.
+
 --no-ff::
 	With --interactive, cherry-pick all rebased commits instead of
 	fast-forwarding over the unchanged ones.  This ensures that the
diff --git a/git-rebase.sh b/git-rebase.sh
index 84dc7b0..b58c6d9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -13,6 +13,7 @@ git-rebase --continue | --abort | --skip | --edit-todo
  Available options are
 v,verbose!         display a diffstat of what changed upstream
 q,quiet!           be quiet. implies --no-stat
+autostash!         automatically stash/stash pop before and after
 onto=!             rebase onto given branch instead of upstream
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
@@ -64,6 +65,7 @@ apply_dir="$GIT_DIR"/rebase-apply
 verbose=
 diffstat=
 test "$(git config --bool rebase.stat)" = true && diffstat=t
+autostash="$(git config --bool rebase.autostash || echo false)"
 git_am_opt=
 rebase_root=
 force_rebase=
@@ -143,6 +145,28 @@ move_to_original_branch () {
 	esac
 }
 
+finish_rebase () {
+	if test -f "$state_dir/autostash"
+	then
+		stash_sha1=$(cat "$state_dir/autostash")
+		if git stash apply $stash_sha1 2>&1 >/dev/null
+		then
+			echo "Applied autostash"
+		else
+			ref_stash=refs/stash &&
+			: >>"$GIT_DIR/logs/$ref_stash" &&
+			git update-ref -m "autostash" $ref_stash $stash_sha1 \
+				|| die "$(eval_gettext 'Cannot store $stash_sha1')" &&
+			echo "
+$(gettext 'Applying autostash resulted in conflicts.
+Your changes are safe in stash@{0}.
+You can apply or drop it at any time.')"
+		fi
+	fi
+	git gc --auto &&
+	rm -rf "$state_dir"
+}
+
 run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
@@ -153,8 +177,7 @@ run_specific_rebase () {
 	ret=$?
 	if test $ret = 0
 	then
-		git gc --auto &&
-		rm -rf "$state_dir"
+		finish_rebase
 	fi
 	exit $ret
 }
@@ -248,6 +271,9 @@ do
 	--stat)
 		diffstat=t
 		;;
+	--autostash)
+		autostash=true
+		;;
 	-v)
 		verbose=t
 		diffstat=t
@@ -348,7 +374,7 @@ abort)
 		;;
 	esac
 	output git reset --hard $orig_head
-	rm -r "$state_dir"
+	finish_rebase
 	exit
 	;;
 edit-todo)
@@ -487,6 +513,17 @@ case "$#" in
 	;;
 esac
 
+if test "$autostash" = true && ! (require_clean_work_tree) 2>/dev/null
+then
+	stash_sha1=$(git stash create "autostash") \
+		|| die "$(gettext 'Cannot autostash')" &&
+	mkdir -p "$state_dir" &&
+	echo $stash_sha1 >"$state_dir/autostash" &&
+	stash_abbrev=$(git rev-parse --short $stash_sha1) &&
+	echo "$(eval_gettext 'Created autostash: $stash_abbrev')" &&
+	git reset --hard
+fi
+
 require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 
 # Now we are rebasing commits $upstream..$orig_head (or with --root,
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
new file mode 100755
index 0000000..8386998
--- /dev/null
+++ b/t/t3420-rebase-autostash.sh
@@ -0,0 +1,148 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Ramkumar Ramachandra
+#
+
+test_description='git rebase --autostash tests'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo hello-world >file0 &&
+	git add . &&
+	test_tick &&
+	git commit -m "initial commit" &&
+	git checkout -b feature-branch &&
+	echo another-hello >file1 &&
+	echo goodbye >file2 &&
+	git add . &&
+	test_tick &&
+	git commit -m "second commit" &&
+	echo final-goodbye >file3 &&
+	git add . &&
+	test_tick &&
+	git commit -m "third commit"
+	git checkout -b unrelated-onto-branch master &&
+	echo unrelated >file4 &&
+	git add . &&
+	test_tick &&
+	git commit -m "unrelated commit"
+	git checkout -b related-onto-branch master &&
+	echo conflicting-change >file2 &&
+	git add . &&
+	test_tick &&
+	git commit -m "related commit"
+'
+
+testrebase() {
+	type=$1
+	dotest=$2
+
+	test_expect_success "rebase$type: dirty worktree, non-conflicting rebase" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >>file3 &&
+		git rebase$type unrelated-onto-branch &&
+		grep unrelated file4 &&
+		grep dirty file3 &&
+		git checkout feature-branch
+	'
+
+	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch
+		echo dirty >>file3 &&
+		git add file3 &&
+		git rebase$type unrelated-onto-branch &&
+		grep unrelated file4 &&
+		grep dirty file3 &&
+		git checkout feature-branch
+	'
+
+	test_expect_success "rebase$type: conflicting rebase" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >>file3 &&
+		test_must_fail git rebase$type related-onto-branch &&
+		test_path_is_file $dotest/autostash &&
+		! grep dirty file3 &&
+		rm -rf $dotest &&
+		git reset --hard &&
+		git checkout feature-branch
+	'
+
+	test_expect_success "rebase$type: --continue" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >>file3 &&
+		test_must_fail git rebase$type related-onto-branch &&
+		test_path_is_file $dotest/autostash &&
+		! grep dirty file3 &&
+		echo "conflicting-plus-goodbye" >file2 &&
+		git add file2 &&
+		git rebase --continue &&
+		test_path_is_missing $dotest/autostash &&
+		grep dirty file3 &&
+		git checkout feature-branch
+	'
+
+	test_expect_success "rebase$type: --skip" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >>file3 &&
+		test_must_fail git rebase$type related-onto-branch &&
+		test_path_is_file $dotest/autostash &&
+		! grep dirty file3 &&
+		git rebase --skip &&
+		test_path_is_missing $dotest/autostash &&
+		grep dirty file3 &&
+		git checkout feature-branch
+	'
+
+	test_expect_success "rebase$type: --abort" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >>file3 &&
+		test_must_fail git rebase$type related-onto-branch &&
+		test_path_is_file $dotest/autostash &&
+		! grep dirty file3 &&
+		git rebase --abort &&
+		test_path_is_missing $dotest/autostash &&
+		grep dirty file3 &&
+		git checkout feature-branch
+	'
+
+	test_expect_success "rebase$type: non-conflicting rebase, conflicting stash" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >file4 &&
+		git add file4 &&
+		git rebase$type unrelated-onto-branch &&
+		test_path_is_missing $dotest &&
+		git reset --hard &&
+		grep unrelated file4 &&
+		! grep dirty file4 &&
+		git checkout feature-branch &&
+		git stash pop &&
+		grep dirty file4
+	'
+}
+
+testrebase "" .git/rebase-apply
+testrebase " --merge" .git/rebase-merge
+testrebase " --interactive" .git/rebase-merge
+
+test_done
-- 
1.8.3.rc1.52.gc14258d
