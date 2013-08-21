From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] t3404: make tests more self-contained
Date: Wed, 21 Aug 2013 15:12:57 -0400
Message-ID: <1377112378-45511-3-git-send-email-sunshine@sunshineco.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 21:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDqS-0004k4-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab3HUTNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:13:19 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:57470 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3HUTNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:13:16 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so1706237oag.31
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FOoyhCQmhVPiqzITeN9JL6OeZaWSX4fU67Nze2EGr9U=;
        b=vWeVH0UzbDAIBodA7IRU+EdwUkjWd58fZ6LrjzG7DYEN7azw39wsWW8FOdMfpAkNJx
         bXAvwcAPxs7DtK1FAR37zQ3cPJ+P11x81YcKTeEF7xeR7FsbHt6XEmseZk+oD23mGmQA
         OdWsx7uLX4Yl3ChEKkUi/mfX4z4CdY39GqseimznL3yPRHfCJUWLifNgVjP4ECjSLVtc
         2AoF/h+ub0FxSq8SUKzLVM7x5ngNz1yG7rNNjTHj/PDtcsCEXC34u1kRslnQfY53PLzC
         ZwcWgCnypvrXKd+HcEZKVtA02bboUgWEFpfbh9J0X+JaEcyF3dlfyRG4jtFKd3h1bJXX
         uYOw==
X-Received: by 10.182.61.19 with SMTP id l19mr9943584obr.55.1377112396055;
        Wed, 21 Aug 2013 12:13:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm12357303obi.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 12:13:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.499.gfb33910
In-Reply-To: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232719>

As its very first action, t3404 installs (via set_fake_editor) a
specialized $EDITOR which simplifies automated 'rebase -i' testing. Many
tests rely upon this setting, thus tests which need a different editor
must take extra care upon completion to restore $EDITOR in order to
avoid breaking following tests. This places extra burden upon such tests
and requires that they undesirably have extra knowledge about
surrounding tests. Ease this burden by having each test install the
$EDITOR it requires, rather than relying upon a global setting.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3404-rebase-interactive.sh | 67 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6be97ba..7d15c7a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -29,8 +29,6 @@ Initial setup:
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-set_fake_editor
-
 # WARNING: Modifications to the initial repository can change the SHA ID used
 # in the expect2 file for the 'stop on conflicting pick' test.
 
@@ -72,6 +70,7 @@ export SHELL
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
+	set_fake_editor &&
 	FAKE_LINES="1 exec_>touch-one
 		2 exec_>touch-two exec_false exec_>touch-three
 		3 4 exec_>\"touch-file__name_with_spaces\";_>touch-after-semicolon 5" &&
@@ -93,6 +92,7 @@ test_expect_success 'rebase -i with the exec command' '
 test_expect_success 'rebase -i with the exec command runs from tree root' '
 	git checkout master &&
 	mkdir subdir && (cd subdir &&
+	set_fake_editor &&
 	FAKE_LINES="1 exec_>touch-subdir" \
 		git rebase -i HEAD^
 	) &&
@@ -103,6 +103,7 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git checkout master &&
 	(
+	set_fake_editor &&
 	FAKE_LINES="exec_echo_foo_>file1 1" &&
 	export FAKE_LINES &&
 	test_must_fail git rebase -i HEAD^
@@ -116,6 +117,7 @@ test_expect_success 'rebase -i with exec of inexistent command' '
 	git checkout master &&
 	test_when_finished "git rebase --abort" &&
 	(
+	set_fake_editor &&
 	FAKE_LINES="exec_this-command-does-not-exist 1" &&
 	export FAKE_LINES &&
 	test_must_fail git rebase -i HEAD^ >actual 2>&1
@@ -125,6 +127,7 @@ test_expect_success 'rebase -i with exec of inexistent command' '
 
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
+	set_fake_editor &&
 	git rebase -i F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
 	test $(git rev-parse I) = $(git rev-parse HEAD)
@@ -134,6 +137,7 @@ test_expect_success 'test the [branch] option' '
 	git checkout -b dead-end &&
 	git rm file6 &&
 	git commit -m "stop here" &&
+	set_fake_editor &&
 	git rebase -i F branch2 &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
 	test $(git rev-parse I) = $(git rev-parse branch2) &&
@@ -142,6 +146,7 @@ test_expect_success 'test the [branch] option' '
 
 test_expect_success 'test --onto <branch>' '
 	git checkout -b test-onto branch2 &&
+	set_fake_editor &&
 	git rebase -i --onto branch1 F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
 	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
@@ -151,6 +156,7 @@ test_expect_success 'test --onto <branch>' '
 test_expect_success 'rebase on top of a non-conflicting commit' '
 	git checkout branch1 &&
 	git tag original-branch1 &&
+	set_fake_editor &&
 	git rebase -i branch2 &&
 	test file6 = $(git diff --name-only original-branch1) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
@@ -163,6 +169,7 @@ test_expect_success 'reflog for the branch shows state before rebase' '
 '
 
 test_expect_success 'exchange two commits' '
+	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
 	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
@@ -188,6 +195,7 @@ EOF
 
 test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
+	set_fake_editor &&
 	test_must_fail git rebase -i master &&
 	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
 	test_cmp expect .git/rebase-merge/patch &&
@@ -208,6 +216,7 @@ test_expect_success 'abort' '
 test_expect_success 'abort with error when new base cannot be checked out' '
 	git rm --cached file1 &&
 	git commit -m "remove file in base" &&
+	set_fake_editor &&
 	test_must_fail git rebase -i master > output 2>&1 &&
 	grep "The following untracked working tree files would be overwritten by checkout:" \
 		output &&
@@ -222,6 +231,7 @@ test_expect_success 'retain authorship' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
 	git tag twerp &&
+	set_fake_editor &&
 	git rebase -i --onto master HEAD^ &&
 	git show HEAD | grep "^Author: Twerp Snog"
 '
@@ -232,6 +242,7 @@ test_expect_success 'squash' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
 	echo "******************************" &&
+	set_fake_editor &&
 	FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
 		git rebase -i --onto master HEAD~2 &&
 	test B = $(cat file7) &&
@@ -244,6 +255,7 @@ test_expect_success 'retain authorship when squashing' '
 
 test_expect_success '-p handles "no changes" gracefully' '
 	HEAD=$(git rev-parse HEAD) &&
+	set_fake_editor &&
 	git rebase -i -p HEAD^ &&
 	git update-index --refresh &&
 	git diff-files --quiet &&
@@ -253,6 +265,7 @@ test_expect_success '-p handles "no changes" gracefully' '
 
 test_expect_failure 'exchange two commits with -p' '
 	git checkout H &&
+	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i -p HEAD~2 &&
 	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
@@ -287,6 +300,7 @@ test_expect_success 'preserve merges with -p' '
 	git commit -m M file1 &&
 	git checkout -b to-be-rebased &&
 	test_tick &&
+	set_fake_editor &&
 	git rebase -i -p --onto branch1 master &&
 	git update-index --refresh &&
 	git diff-files --quiet &&
@@ -301,6 +315,7 @@ test_expect_success 'preserve merges with -p' '
 '
 
 test_expect_success 'edit ancestor with -p' '
+	set_fake_editor &&
 	FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3 &&
 	echo 2 > unrelated-file &&
 	test_tick &&
@@ -314,6 +329,7 @@ test_expect_success 'edit ancestor with -p' '
 
 test_expect_success '--continue tries to commit' '
 	test_tick &&
+	set_fake_editor &&
 	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
@@ -325,6 +341,7 @@ test_expect_success '--continue tries to commit' '
 test_expect_success 'verbose flag is heeded, even after --continue' '
 	git reset --hard master@{1} &&
 	test_tick &&
+	set_fake_editor &&
 	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
@@ -334,6 +351,7 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 
 test_expect_success 'multi-squash only fires up editor once' '
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 squash 2 squash 3 squash 4" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
@@ -344,6 +362,7 @@ test_expect_success 'multi-squash only fires up editor once' '
 test_expect_success 'multi-fixup does not fire up editor' '
 	git checkout -b multi-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	FAKE_COMMIT_AMEND="NEVER" FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
 		git rebase -i $base &&
 	test $base = $(git rev-parse HEAD^) &&
@@ -355,6 +374,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
 test_expect_success 'commit message used after conflict' '
 	git checkout -b conflict-fixup conflict-branch &&
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	(
 		FAKE_LINES="1 fixup 3 fixup 4" &&
 		export FAKE_LINES &&
@@ -373,6 +393,7 @@ test_expect_success 'commit message used after conflict' '
 test_expect_success 'commit message retained after conflict' '
 	git checkout -b conflict-squash conflict-branch &&
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	(
 		FAKE_LINES="1 fixup 3 squash 4" &&
 		export FAKE_LINES &&
@@ -399,6 +420,7 @@ EOF
 test_expect_success 'squash and fixup generate correct log messages' '
 	git checkout -b squash-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 fixup 2 squash 3 fixup 4" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
@@ -411,6 +433,7 @@ test_expect_success 'squash and fixup generate correct log messages' '
 test_expect_success 'squash ignores comments' '
 	git checkout -b skip-comments E &&
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="# 1 # squash 2 # squash 3 # squash 4 #" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
@@ -423,6 +446,7 @@ test_expect_success 'squash ignores comments' '
 test_expect_success 'squash ignores blank lines' '
 	git checkout -b skip-blank-lines E &&
 	base=$(git rev-parse HEAD~4) &&
+	set_fake_editor &&
 	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="> 1 > squash 2 > squash 3 > squash 4 >" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
@@ -435,6 +459,7 @@ test_expect_success 'squash ignores blank lines' '
 test_expect_success 'squash works as expected' '
 	git checkout -b squash-works no-conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
+	set_fake_editor &&
 	FAKE_LINES="1 squash 3 2" EXPECT_HEADER_COUNT=2 \
 		git rebase -i HEAD~3 &&
 	test $one = $(git rev-parse HEAD~2)
@@ -443,6 +468,7 @@ test_expect_success 'squash works as expected' '
 test_expect_success 'interrupted squash works as expected' '
 	git checkout -b interrupted-squash conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
+	set_fake_editor &&
 	(
 		FAKE_LINES="1 squash 3 2" &&
 		export FAKE_LINES &&
@@ -460,6 +486,7 @@ test_expect_success 'interrupted squash works as expected' '
 test_expect_success 'interrupted squash works as expected (case 2)' '
 	git checkout -b interrupted-squash2 conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
+	set_fake_editor &&
 	(
 		FAKE_LINES="3 squash 1 2" &&
 		export FAKE_LINES &&
@@ -484,6 +511,7 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 	git commit -m "unrelated change" &&
 	parent=$(git rev-parse HEAD^) &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	echo edited > file7 &&
 	git add file7 &&
@@ -496,6 +524,7 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 test_expect_success 'aborted --continue does not squash commits after "edit"' '
 	old=$(git rev-parse HEAD) &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
@@ -510,6 +539,7 @@ test_expect_success 'aborted --continue does not squash commits after "edit"' '
 
 test_expect_success 'auto-amend only edited commits after "edit"' '
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
@@ -528,6 +558,7 @@ test_expect_success 'auto-amend only edited commits after "edit"' '
 test_expect_success 'clean error after failed "exec"' '
 	test_tick &&
 	test_when_finished "git rebase --abort || :" &&
+	set_fake_editor &&
 	(
 		FAKE_LINES="1 exec_false" &&
 		export FAKE_LINES &&
@@ -543,6 +574,7 @@ test_expect_success 'rebase a detached HEAD' '
 	grandparent=$(git rev-parse HEAD~2) &&
 	git checkout $(git rev-parse HEAD) &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
 	test $grandparent = $(git rev-parse HEAD~2)
 '
@@ -559,6 +591,7 @@ test_expect_success 'rebase a commit violating pre-commit' '
 	test_must_fail git commit -m doesnt-verify file1 &&
 	git commit -m doesnt-verify --no-verify file1 &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES=2 git rebase -i HEAD~2
 
 '
@@ -580,6 +613,7 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
 		git commit -m "Add body"
 	) &&
 
+	set_fake_editor &&
 	FAKE_LINES="1 squash 2" git rebase -i to-be-rebased &&
 	test "$(git show -s --pretty=format:%an)" = "Squashed Away"
 
@@ -591,6 +625,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
 	GIT_EDITOR=: git commit --amend \
 		--author="Somebody else <somebody@else.com>" &&
 	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
+	set_fake_editor &&
 	git rebase -i branch3 &&
 	test $(git rev-parse branch3) = $(git rev-parse branch4)
 
@@ -615,10 +650,12 @@ test_expect_success 'submodule rebase setup' '
 		git commit -a -m "submodule second"
 	) &&
 	test_tick &&
+	set_fake_editor &&
 	git commit -a -m "Three changes submodule"
 '
 
 test_expect_success 'submodule rebase -i' '
+	set_fake_editor &&
 	FAKE_LINES="1 squash 2 3" git rebase -i A
 '
 
@@ -636,6 +673,7 @@ test_expect_success 'submodule conflict setup' '
 '
 
 test_expect_success 'rebase -i continue with only submodule staged' '
+	set_fake_editor &&
 	test_must_fail git rebase -i submodule-base &&
 	git add sub &&
 	git rebase --continue &&
@@ -645,6 +683,7 @@ test_expect_success 'rebase -i continue with only submodule staged' '
 test_expect_success 'rebase -i continue with unstaged submodule' '
 	git checkout submodule-topic &&
 	git reset --hard &&
+	set_fake_editor &&
 	test_must_fail git rebase -i submodule-base &&
 	git reset &&
 	git rebase --continue &&
@@ -657,6 +696,7 @@ test_expect_success 'avoid unnecessary reset' '
 	test-chmtime =123456789 file3 &&
 	git update-index --refresh &&
 	HEAD=$(git rev-parse HEAD) &&
+	set_fake_editor &&
 	git rebase -i HEAD~4 &&
 	test $HEAD = $(git rev-parse HEAD) &&
 	MTIME=$(test-chmtime -v +0 file3 | sed 's/[^0-9].*$//') &&
@@ -665,6 +705,7 @@ test_expect_success 'avoid unnecessary reset' '
 
 test_expect_success 'reword' '
 	git checkout -b reword-branch master &&
+	set_fake_editor &&
 	FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" git rebase -i A &&
 	git show HEAD | grep "E changed" &&
 	test $(git rev-parse master) != $(git rev-parse HEAD) &&
@@ -684,6 +725,7 @@ test_expect_success 'rebase -i can copy notes' '
 	test_commit n2 &&
 	test_commit n3 &&
 	git notes add -m"a note" n3 &&
+	set_fake_editor &&
 	git rebase -i --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
 '
@@ -697,6 +739,7 @@ EOF
 test_expect_success 'rebase -i can copy notes over a fixup' '
 	git reset --hard n3 &&
 	git notes add -m"an earlier note" n2 &&
+	set_fake_editor &&
 	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 fixup 2" git rebase -i n1 &&
 	git notes show > output &&
 	test_cmp expect output
@@ -706,6 +749,7 @@ test_expect_success 'rebase while detaching HEAD' '
 	git symbolic-ref HEAD &&
 	grandparent=$(git rev-parse HEAD~2) &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
 	test $grandparent = $(git rev-parse HEAD~2) &&
 	test_must_fail git symbolic-ref HEAD
@@ -715,6 +759,7 @@ test_tick # Ensure that the rebased commits get a different timestamp.
 test_expect_success 'always cherry-pick with --no-ff' '
 	git checkout no-ff-branch &&
 	git tag original-no-ff-branch &&
+	set_fake_editor &&
 	git rebase -i --no-ff A &&
 	touch empty &&
 	for p in 0 1 2
@@ -747,6 +792,7 @@ test_expect_success 'set up commits with funny messages' '
 test_expect_success 'rebase-i history with funny messages' '
 	git rev-list A..funny >expect &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_LINES="1 2 3 4" git rebase -i A &&
 	git rev-list A.. >actual &&
 	test_cmp expect actual
@@ -763,6 +809,7 @@ test_expect_success 'prepare for rebase -i --exec' '
 
 
 test_expect_success 'running "git rebase -i --exec git show HEAD"' '
+	set_fake_editor &&
 	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
@@ -776,6 +823,7 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 
 test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	git reset --hard execute &&
+	set_fake_editor &&
 	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
@@ -789,6 +837,7 @@ test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 
 test_expect_success 'running "git rebase -ix git show HEAD"' '
 	git reset --hard execute &&
+	set_fake_editor &&
 	git rebase -ix "git show HEAD" HEAD~2 >actual &&
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
@@ -802,6 +851,7 @@ test_expect_success 'running "git rebase -ix git show HEAD"' '
 
 test_expect_success 'rebase -ix with several <CMD>' '
 	git reset --hard execute &&
+	set_fake_editor &&
 	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
 	(
 		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
@@ -815,6 +865,7 @@ test_expect_success 'rebase -ix with several <CMD>' '
 
 test_expect_success 'rebase -ix with several instances of --exec' '
 	git reset --hard execute &&
+	set_fake_editor &&
 	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
 	(
 		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
@@ -836,6 +887,7 @@ test_expect_success 'rebase -ix with --autosquash' '
 	echo bis >bis.txt &&
 	git add bis.txt &&
 	git commit -m "fixup! two_exec" &&
+	set_fake_editor &&
 	(
 		git checkout -b autosquash_actual &&
 		git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual
@@ -854,6 +906,7 @@ test_expect_success 'rebase -ix with --autosquash' '
 
 test_expect_success 'rebase --exec without -i shows error message' '
 	git reset --hard execute &&
+	set_fake_editor &&
 	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
 	echo "The --exec option must be used with the --interactive option" >expected &&
 	test_i18ncmp expected actual
@@ -862,6 +915,7 @@ test_expect_success 'rebase --exec without -i shows error message' '
 
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
+	set_fake_editor &&
 	test_must_fail git rebase -i --exec 2>tmp &&
 	sed -e "1d" tmp >actual &&
 	test_must_fail git rebase -h >expected &&
@@ -871,6 +925,7 @@ test_expect_success 'rebase -i --exec without <CMD>' '
 
 test_expect_success 'rebase -i --root re-order and drop commits' '
 	git checkout E &&
+	set_fake_editor &&
 	FAKE_LINES="3 1 2 5" git rebase -i --root &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p) &&
@@ -884,6 +939,7 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 	echo B >file7 &&
 	git add file7 &&
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
+	set_fake_editor &&
 	FAKE_LINES="2" git rebase -i --root &&
 	git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
 	git cat-file commit HEAD | grep -q "^different author$"
@@ -892,6 +948,7 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 test_expect_success 'rebase -i --root temporary sentinel commit' '
 	git checkout B &&
 	(
+		set_fake_editor &&
 		FAKE_LINES="2" &&
 		export FAKE_LINES &&
 		test_must_fail git rebase -i --root
@@ -902,6 +959,7 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
 
 test_expect_success 'rebase -i --root fixup root commit' '
 	git checkout B &&
+	set_fake_editor &&
 	FAKE_LINES="1 fixup 2" git rebase -i --root &&
 	test A = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test B = $(git show HEAD:file1) &&
@@ -911,6 +969,7 @@ test_expect_success 'rebase -i --root fixup root commit' '
 test_expect_success 'rebase --edit-todo does not works on non-interactive rebase' '
 	git reset --hard &&
 	git checkout conflict-branch &&
+	set_fake_editor &&
 	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
@@ -919,6 +978,7 @@ test_expect_success 'rebase --edit-todo does not works on non-interactive rebase
 test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	git reset --hard &&
 	git checkout no-conflict-branch^0 &&
+	set_fake_editor &&
 	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
 	FAKE_LINES="2 1" git rebase --edit-todo &&
 	git rebase --continue
@@ -929,6 +989,7 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 test_expect_success 'rebase -i produces readable reflog' '
 	git reset --hard &&
 	git branch -f branch-reflog-test H &&
+	set_fake_editor &&
 	git rebase -i --onto I F branch-reflog-test &&
 	cat >expect <<-\EOF &&
 	rebase -i (start): checkout I
@@ -949,7 +1010,6 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
 	mv "$1.tmp" "$1"
 	EOF
-	test_when_finished "set_fake_editor" &&
 	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
 	git rebase -i B &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
@@ -1008,6 +1068,7 @@ test_expect_success 'short SHA-1 collide' '
 	(
 	unset test_tick &&
 	test_tick &&
+	set_fake_editor &&
 	FAKE_COMMIT_MESSAGE="collide2 815200e" \
 	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
 	)
-- 
1.8.4.rc4.499.gfb33910
