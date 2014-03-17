From: David Tran <unsignedzero@gmail.com>
Subject: [PATCH] tests: set temp variables using 'env' in test function instead of subshell
Date: Mon, 17 Mar 2014 08:56:33 +0000
Message-ID: <1395046593-4057-1-git-send-email-unsignedzero@gmail.com>
References: <244240>
Cc: David Tran <unsignedzero@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 17:52:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPamK-0001l5-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 17:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbaCQQwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 12:52:38 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51806 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbaCQQwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 12:52:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so6004715pab.27
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jjhOvdEzSgPdFZjp3WWU4FJCFizo7U0dcnmtKrw/4yc=;
        b=L9A14YfY8WkhXDp0cnphny4t0K29rWadXhl6vuh98iex/1IoT6THjK+OU2JXM/Fumx
         RqtmUsgqiNAwkpxWm6rKnCJkRanhSTN057UN9bBbnjFMbYyREa7k+01PH64J5dyFb4gS
         wdRCA6fGwlz9zwfIyG62dub58bT95GElmzTSrOo6hCwV5zGEaUwwDnnsm8ZZrm1jBmnP
         TyLCgaopfCBk+zIJx6WkOu2f49KYD8ljjLUCQoRbEJzv5ky9Ou5fMM1iozmLB+Fb1jh9
         FXuCe+OQXT0y2mXxwr1v8WWg33wqEC7S54AKgVTZJfYY3xX7zsSV087elIK/5XIYcBvI
         4Uog==
X-Received: by 10.68.201.97 with SMTP id jz1mr26819592pbc.26.1395075156463;
        Mon, 17 Mar 2014 09:52:36 -0700 (PDT)
Received: from localhost.localdomain (c-24-130-104-43.hsd1.ca.comcast.net. [24.130.104.43])
        by mx.google.com with ESMTPSA id yx3sm44746274pbb.6.2014.03.17.09.52.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 09:52:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <244240>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244256>

Originally, the code used subshells instead of FOO=BAR command because
the variable would otherwise leak into the surrounding context of the POSIX
shell when 'command' is a shell function. The subshell was used to hold the
context for the test. Using 'env' in the test function sets the temp variables
without leaking, removing the need of a subshell.

Signed-off-by: David Tran <unsignedzero@gmail.com>

---

Let's see if I replied correctly with send-email.

I am David Tran a graduating CS/Math senior from Sonoma State University,
United States. I would like to work with git for GSoC'14, specifically the line
options for git rebase --interactive [1]. I have used git for a few years and
know how destructive but important rebase is to git. I have created a few shell
scripts here and there to make life using bash/zsh easier. I would like to
apply these skills and work with the best.

Github: unsignedzero

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243933/focus=243967

> The patch itself has some problems. See comments below.

Fixed the broken &&-chain and the tests run correctly. The double env is
fixed to be a single env. The useless subshells are removed.

>>         echo "edited again" > file7 &&
>>         git add file7 &&
>>  <at>  <at>  -949,9 +924,7  <at>  <at>  test_expect_success 'rebase -i --root temporary sentinel commit' '
>>         git checkout B &&
>>         (
>>                 set_fake_editor &&
>> -               FAKE_LINES="2" &&
>> -               export FAKE_LINES &&
>> -               test_must_fail git rebase -i --root
>> +               test_must_fail env FAKE_LINES="2" git rebase -i --root
>>         ) &&
> And maybe here (or does this test or later tests break if
> set_fake_editor is taken out of the subshell)?

I thought it did but when I ran it, it doesn't. Fixed.

>> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
>> index 9874403..b43fb67 100755
>> --- a/t/t6006-rev-list-format.sh
>> +++ b/t/t6006-rev-list-format.sh
>>  <at>  <at>  -191,8 +191,7  <at>  <at>  test_expect_success '%C(auto) respects --no-color' '
>>
>>  test_expect_success TTY '%C(auto) respects --color=auto (stdout is tty)' '
>>         (
>> -               TERM=vt100 && export TERM &&
>> -               test_terminal \
>> +               test_terminal env TERM=vt100 \
>>                         git log --format=$AUTO_COLOR -1 --color=auto >actual &&
>>                 has_color actual
>>         )
> Is this subshell still necessary? Does has_color rely upon the value of TERM?

Like above, I thought it did but it doesn't need it. Fixed.

Signed-off-by: David Tran <unsignedzero@gmail.com>
---
 t/t1300-repo-config.sh        |   17 ++--------
 t/t1510-repo-setup.sh         |    4 +--
 t/t3200-branch.sh             |   12 +------
 t/t3301-notes.sh              |   22 ++++----------
 t/t3404-rebase-interactive.sh |   63 ++++++++--------------------------------
 t/t3413-rebase-hook.sh        |    6 +---
 t/t4014-format-patch.sh       |   14 ++-------
 t/t5305-include-tag.sh        |    4 +--
 t/t5602-clone-remote-exec.sh  |   13 ++------
 t/t5801-remote-helpers.sh     |    6 +--
 t/t6006-rev-list-format.sh    |    9 ++----
 t/t7006-pager.sh              |   18 ++----------
 12 files changed, 42 insertions(+), 146 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c9c426c..3e3f77b 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -974,24 +974,15 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 '
 
 test_expect_success 'nonexistent configuration' '
-	(
-		GIT_CONFIG=doesnotexist &&
-		export GIT_CONFIG &&
-		test_must_fail git config --list &&
-		test_must_fail git config test.xyzzy
-	)
+	test_must_fail env GIT_CONFIG=doesnotexist git config --list &&
+	test_must_fail env GIT_CONFIG=doesnotexist git config test.xyzzy
 '
 
 test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
 	ln -s doesnotexist linktonada &&
 	ln -s linktonada linktolinktonada &&
-	(
-		GIT_CONFIG=linktonada &&
-		export GIT_CONFIG &&
-		test_must_fail git config --list &&
-		GIT_CONFIG=linktolinktonada &&
-		test_must_fail git config --list
-	)
+	test_must_fail env GIT_CONFIG=linktonada git config --list &&
+	test_must_fail env GIT_CONFIG=linktolinktonada git config --list
 '
 
 test_expect_success 'check split_cmdline return' "
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index cf2ee78..e1b2a99 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -777,9 +777,7 @@ test_expect_success '#30: core.worktree and core.bare conflict (gitfile version)
 	setup_repo 30 "$here/30" gitfile true &&
 	(
 		cd 30 &&
-		GIT_DIR=.git &&
-		export GIT_DIR &&
-		test_must_fail git symbolic-ref HEAD 2>result
+		test_must_fail env GIT_DIR=.git git symbolic-ref HEAD 2>result
 	) &&
 	grep "core.bare and core.worktree" 30/result
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..d45e95c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -849,11 +849,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
-	(
-		EDITOR=./editor &&
-		export EDITOR &&
-		test_must_fail git branch --edit-description no-such-branch
-	)
+	test_must_fail env EDITOR=./editor git branch --edit-description no-such-branch
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
@@ -861,11 +857,7 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 		echo "New contents" >"$1"
 	EOF
 	git checkout --orphan unborn &&
-	(
-		EDITOR=./editor &&
-		export EDITOR &&
-		test_must_fail git branch --edit-description
-	)
+	test_must_fail env EDITOR=./editor git branch --edit-description
 '
 
 test_expect_success '--merged catches invalid object names' '
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3bb79a4..db491ac 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -17,7 +17,7 @@ GIT_EDITOR=./fake_editor.sh
 export GIT_EDITOR
 
 test_expect_success 'cannot annotate non-existing HEAD' '
-	(MSG=3 && export MSG && test_must_fail git notes add)
+	test_must_fail env MSG=3 git notes add
 '
 
 test_expect_success setup '
@@ -32,22 +32,16 @@ test_expect_success setup '
 '
 
 test_expect_success 'need valid notes ref' '
-	(MSG=1 GIT_NOTES_REF=/ && export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes add) &&
-	(MSG=2 GIT_NOTES_REF=/ && export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes show)
+	test_must_fail env MSG=1 env GIT_NOTES_REF=/ git notes show &&
+	test_must_fail env MSG=2 env GIT_NOTES_REF=/ git notes show
 '
 
 test_expect_success 'refusing to add notes in refs/heads/' '
-	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
-	 export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes add)
+	test_must_fail env MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes add
 '
 
 test_expect_success 'refusing to edit notes in refs/remotes/' '
-	(MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
-	 export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes edit)
+	test_must_fail env MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes edit
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
@@ -865,11 +859,7 @@ test_expect_success 'create note from non-existing note with "git notes add -c"
 	git add a10 &&
 	test_tick &&
 	git commit -m 10th &&
-	(
-		MSG="yet another note" &&
-		export MSG &&
-		test_must_fail git notes add -c deadbeef
-	) &&
+	test_must_fail env MSG="yet another note" git notes add -c deadbeef &&
 	test_must_fail git notes list HEAD
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 50e22b1..2e75e4d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -104,9 +104,7 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git checkout master &&
 	(
 	set_fake_editor &&
-	FAKE_LINES="exec_echo_foo_>file1 1" &&
-	export FAKE_LINES &&
-	test_must_fail git rebase -i HEAD^
+	test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^
 	) &&
 	test_cmp_rev master^ HEAD &&
 	git reset --hard &&
@@ -118,9 +116,8 @@ test_expect_success 'rebase -i with exec of inexistent command' '
 	test_when_finished "git rebase --abort" &&
 	(
 	set_fake_editor &&
-	FAKE_LINES="exec_this-command-does-not-exist 1" &&
-	export FAKE_LINES &&
-	test_must_fail git rebase -i HEAD^ >actual 2>&1
+	test_must_fail env FAKE_LINES="exec_this-command-does-not-exist 1" \
+	git rebase -i HEAD^ >actual 2>&1
 	) &&
 	! grep "Maybe git-rebase is broken" actual
 '
@@ -375,11 +372,7 @@ test_expect_success 'commit message used after conflict' '
 	git checkout -b conflict-fixup conflict-branch &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
-	(
-		FAKE_LINES="1 fixup 3 fixup 4" &&
-		export FAKE_LINES &&
-		test_must_fail git rebase -i $base
-	) &&
+	test_must_fail env FAKE_LINES="1 fixup 3 fixup 4" git rebase -i $base &&
 	echo three > conflict &&
 	git add conflict &&
 	FAKE_COMMIT_AMEND="ONCE" EXPECT_HEADER_COUNT=2 \
@@ -394,11 +387,7 @@ test_expect_success 'commit message retained after conflict' '
 	git checkout -b conflict-squash conflict-branch &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
-	(
-		FAKE_LINES="1 fixup 3 squash 4" &&
-		export FAKE_LINES &&
-		test_must_fail git rebase -i $base
-	) &&
+	test_must_fail env FAKE_LINES="1 fixup 3 squash 4" git rebase -i $base &&
 	echo three > conflict &&
 	git add conflict &&
 	FAKE_COMMIT_AMEND="TWICE" EXPECT_HEADER_COUNT=2 \
@@ -469,11 +458,7 @@ test_expect_success 'interrupted squash works as expected' '
 	git checkout -b interrupted-squash conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
-	(
-		FAKE_LINES="1 squash 3 2" &&
-		export FAKE_LINES &&
-		test_must_fail git rebase -i HEAD~3
-	) &&
+	test_must_fail env FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
 	(echo one; echo two; echo four) > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
@@ -487,11 +472,7 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 	git checkout -b interrupted-squash2 conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
-	(
-		FAKE_LINES="3 squash 1 2" &&
-		export FAKE_LINES &&
-		test_must_fail git rebase -i HEAD~3
-	) &&
+	test_must_fail env FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
 	(echo one; echo four) > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
@@ -529,9 +510,7 @@ test_expect_success 'aborted --continue does not squash commits after "edit"' '
 	echo "edited again" > file7 &&
 	git add file7 &&
 	(
-		FAKE_COMMIT_MESSAGE=" " &&
-		export FAKE_COMMIT_MESSAGE &&
-		test_must_fail git rebase --continue
+		test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue
 	) &&
 	test $old = $(git rev-parse HEAD) &&
 	git rebase --abort
@@ -547,11 +526,7 @@ test_expect_success 'auto-amend only edited commits after "edit"' '
 	echo "and again" > file7 &&
 	git add file7 &&
 	test_tick &&
-	(
-		FAKE_COMMIT_MESSAGE="and again" &&
-		export FAKE_COMMIT_MESSAGE &&
-		test_must_fail git rebase --continue
-	) &&
+	test_must_fail env FAKE_COMMIT_MESSAGE="and again" git rebase --continue &&
 	git rebase --abort
 '
 
@@ -559,11 +534,7 @@ test_expect_success 'clean error after failed "exec"' '
 	test_tick &&
 	test_when_finished "git rebase --abort || :" &&
 	set_fake_editor &&
-	(
-		FAKE_LINES="1 exec_false" &&
-		export FAKE_LINES &&
-		test_must_fail git rebase -i HEAD^
-	) &&
+	test_must_fail env FAKE_LINES="1 exec_false" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
@@ -947,12 +918,8 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 
 test_expect_success 'rebase -i --root temporary sentinel commit' '
 	git checkout B &&
-	(
-		set_fake_editor &&
-		FAKE_LINES="2" &&
-		export FAKE_LINES &&
-		test_must_fail git rebase -i --root
-	) &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="2" git rebase -i --root &&
 	git cat-file commit HEAD | grep "^tree 4b825dc642cb" &&
 	git rebase --abort
 '
@@ -1042,11 +1009,7 @@ test_expect_success 'rebase -i error on commits with \ in message' '
 	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
 	test_commit TO-REMOVE will-conflict old-content &&
 	test_commit "\temp" will-conflict new-content dummy &&
-	(
-	EDITOR=true &&
-	export EDITOR &&
-	test_must_fail git rebase -i HEAD^ --onto HEAD^^ 2>error
-	) &&
+	test_must_fail env EDITOR=true git rebase -i HEAD^ --onto HEAD^^ 2>error &&
 	test_expect_code 1 grep  "	emp" error
 '
 
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 098b755..b6833e9 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -118,11 +118,7 @@ test_expect_success 'pre-rebase hook stops rebase (1)' '
 test_expect_success 'pre-rebase hook stops rebase (2)' '
 	git checkout test &&
 	git reset --hard side &&
-	(
-		EDITOR=:
-		export EDITOR
-		test_must_fail git rebase -i master
-	) &&
+	test_must_fail env EDITOR=: git rebase -i master &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
 	test 0 = $(git rev-list HEAD...side | wc -l)
 '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 73194b2..9c80633 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -764,22 +764,14 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
 
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
-	(
-		GIT_PAGER="wc >pager_used" &&
-		export GIT_PAGER &&
-		test_terminal git format-patch --stdout --all
-	) &&
+	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
 	test_path_is_file pager_used
 '
 
  test_expect_success TTY 'format-patch --stdout pagination can be disabled' '
 	rm -f pager_used &&
-	(
-		GIT_PAGER="wc >pager_used" &&
-		export GIT_PAGER &&
-		test_terminal git --no-pager format-patch --stdout --all &&
-		test_terminal git -c "pager.format-patch=false" format-patch --stdout --all
-	) &&
+	test_terminal env GIT_PAGER="wc >pager_used" git --no-pager format-patch --stdout --all &&
+	test_terminal env GIT_PAGER="wc >pager_used" git -c "pager.format-patch=false" format-patch --stdout --all &&
 	test_path_is_missing pager_used &&
 	test_path_is_missing .git/pager_used
 '
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index b061864..21517c7 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -45,9 +45,7 @@ test_expect_success 'unpack objects' '
 test_expect_success 'check unpacked result (have commit, no tag)' '
 	git rev-list --objects $commit >list.expect &&
 	(
-		GIT_DIR=clone.git &&
-		export GIT_DIR &&
-		test_must_fail git cat-file -e $tag &&
+		test_must_fail env GIT_DIR=clone.git git cat-file -e $tag &&
 		git rev-list --objects $commit
 	) >list.actual &&
 	test_cmp list.expect list.actual
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index 3f353d9..cbcceab 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -12,21 +12,14 @@ test_expect_success setup '
 '
 
 test_expect_success 'clone calls git upload-pack unqualified with no -u option' '
-	(
-		GIT_SSH=./not_ssh &&
-		export GIT_SSH &&
-		test_must_fail git clone localhost:/path/to/repo junk
-	) &&
+	test_must_fail env GIT_SSH=./not_ssh git clone localhost:/path/to/repo junk &&
 	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
 test_expect_success 'clone calls specified git upload-pack with -u option' '
-	(
-		GIT_SSH=./not_ssh &&
-		export GIT_SSH &&
-		test_must_fail git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk
-	) &&
+	test_must_fail env GIT_SSH=./not_ssh \
+		git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk &&
 	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 613f69a..ca19838 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -218,10 +218,8 @@ test_expect_success 'proper failure checks for fetching' '
 '
 
 test_expect_success 'proper failure checks for pushing' '
-	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
-	export GIT_REMOTE_TESTGIT_FAILURE &&
-	cd local &&
-	test_must_fail git push --all
+	(cd local &&
+	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all
 	)
 '
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9874403..9d9d9de 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -190,12 +190,9 @@ test_expect_success '%C(auto) respects --no-color' '
 '
 
 test_expect_success TTY '%C(auto) respects --color=auto (stdout is tty)' '
-	(
-		TERM=vt100 && export TERM &&
-		test_terminal \
-			git log --format=$AUTO_COLOR -1 --color=auto >actual &&
-		has_color actual
-	)
+	test_terminal env TERM=vt100 \
+		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
+	has_color actual
 '
 
 test_expect_success '%C(auto) respects --color=auto (stdout not tty)' '
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index b9365b4..da958a8 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -146,11 +146,7 @@ test_expect_success 'no color when stdout is a regular file' '
 test_expect_success TTY 'color when writing to a pager' '
 	rm -f paginated.out &&
 	test_config color.ui auto &&
-	(
-		TERM=vt100 &&
-		export TERM &&
-		test_terminal git log
-	) &&
+	test_terminal env TERM=vt100 git log &&
 	colorful paginated.out
 '
 
@@ -158,11 +154,7 @@ test_expect_success TTY 'colors are suppressed by color.pager' '
 	rm -f paginated.out &&
 	test_config color.ui auto &&
 	test_config color.pager false &&
-	(
-		TERM=vt100 &&
-		export TERM &&
-		test_terminal git log
-	) &&
+	test_terminal env TERM=vt100 git log &&
 	! colorful paginated.out
 '
 
@@ -181,11 +173,7 @@ test_expect_success 'color when writing to a file intended for a pager' '
 test_expect_success TTY 'colors are sent to pager for external commands' '
 	test_config alias.externallog "!git log" &&
 	test_config color.ui auto &&
-	(
-		TERM=vt100 &&
-		export TERM &&
-		test_terminal git -p externallog
-	) &&
+	test_terminal env TERM=vt100 git -p externallog &&
 	colorful paginated.out
 '
 
-- 
1.7.9
