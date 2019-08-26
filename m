Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846A71F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfHZT6v (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:58:51 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:54891 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHZT6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:51 -0400
Date:   Mon, 26 Aug 2019 19:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566849504; bh=q8pNwCS6Bb7ZygW8+eYofDENcvlA9Jza/7w8EurybJk=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=aFCv9WOnlAh5LSvmwZEow9846VWPmISH7rm/IYz4SHbU45kJW71+MgPd0LWp2/3pW
         lmGsdXAqFdCVXM5B+C0Tdjn4xhT0Zv8nVyhD43lFBTluZ5qns92LMX9KBh11wWGeJt
         gBdRs7131DWTenSX51YqYXRtJ7BY68hzQEMR8DRCXQtZXd9g/RaCsNUyTROHk4J89a
         wvd2D8Cw67CrEEOTHg/rwrSdg27W2aKOLWnn9rJeOj7fioXnYqeAYZ7JsEOJKrrCwT
         kVFeuPnd7ZmL7fcSIG1M09hg5tv/g2qWpBnEnUwOHOTmxhDzoNWxmfofMJ8g4NGtgn
         LoNPDedqeEFOg==
To:     git@vger.kernel.org
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     Ibrahim El Rhezzali <ibrahim.el@pm.me>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: [PATCH 5/5] Signing API: Duplicated signing tests using new config aliases
Message-ID: <xidzc1zBudSNNUInNKpDPgAw3AlwtABPT9VpKuPpAfVodvQejHn5WHIYTrqlMlJEYB11iMVhxNCQKBnx7phcHaiPQhHLaqKgeVZwPTCx4n4=@pm.me>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ibrahim El Rhezzali <ibrahim.el@pm.me>

c6a1d1c21 Duplicated signing tests using new config aliases

Duplicating existing tests that are signature related and updating them to =
use the new config aliases

Signed-off-by: Ibrahim El <ibrahim.el@pm.me>
---
 t/t3431-rebase-interactive-signconfig.sh | 1480 +++++++++++++++++++++
 t/t4215-log-signconfig.sh                | 1710 ++++++++++++++++++++++++
 t/t5548-push-signed-signconfig.sh        |  276 ++++
 t/t7013-tag-signconfig.sh                | 2074 ++++++++++++++++++++++++++=
++++
 t/t7031-verify-tag-signconfig.sh         |  175 +++
 t/t7522-signed-commit-signconfig.sh      |  288 +++++
 6 files changed, 6003 insertions(+)
 create mode 100755 t/t3431-rebase-interactive-signconfig.sh
 create mode 100755 t/t4215-log-signconfig.sh
 create mode 100755 t/t5548-push-signed-signconfig.sh
 create mode 100755 t/t7013-tag-signconfig.sh
 create mode 100755 t/t7031-verify-tag-signconfig.sh
 create mode 100755 t/t7522-signed-commit-signconfig.sh

diff --git a/t/t3431-rebase-interactive-signconfig.sh b/t/t3431-rebase-inte=
ractive-signconfig.sh
new file mode 100755
index 000000000..ffa409292
--- /dev/null
+++ b/t/t3431-rebase-interactive-signconfig.sh
@@ -0,0 +1,1480 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description=3D'git rebase interactive
+
+This test runs git rebase "interactively", by faking an edit, and verifies
+that the result still makes sense.
+
+Initial setup:
+
+     one - two - three - four (conflict-branch)
+   /
+ A - B - C - D - E            (master)
+ | \
+ |   F - G - H                (branch1)
+ |     \
+ |\      I                    (branch2)
+ | \
+ |   J - K - L - M            (no-conflict-branch)
+  \
+    N - O - P                 (no-ff-branch)
+
+ where A, B, D and G all touch file1, and one, two, three, four all
+ touch file "conflict".
+'
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# WARNING: Modifications to the initial repository can change the SHA ID u=
sed
+# in the expect2 file for the 'stop on conflicting pick' test.
+
+test_expect_success 'setup' '
+=09test_commit A file1 &&
+=09test_commit B file1 &&
+=09test_commit C file2 &&
+=09test_commit D file1 &&
+=09test_commit E file3 &&
+=09git checkout -b branch1 A &&
+=09test_commit F file4 &&
+=09test_commit G file1 &&
+=09test_commit H file5 &&
+=09git checkout -b branch2 F &&
+=09test_commit I file6 &&
+=09git checkout -b conflict-branch A &&
+=09test_commit one conflict &&
+=09test_commit two conflict &&
+=09test_commit three conflict &&
+=09test_commit four conflict &&
+=09git checkout -b no-conflict-branch A &&
+=09test_commit J fileJ &&
+=09test_commit K fileK &&
+=09test_commit L fileL &&
+=09test_commit M fileM &&
+=09git checkout -b no-ff-branch A &&
+=09test_commit N fileN &&
+=09test_commit O fileO &&
+=09test_commit P fileP
+'
+
+# "exec" commands are run with the user shell by default, but this may
+# be non-POSIX. For example, if SHELL=3Dzsh then ">file" doesn't work
+# to create a file. Unsetting SHELL avoids such non-portable behavior
+# in tests. It must be exported for it to take effect where needed.
+SHELL=3D
+export SHELL
+
+test_expect_success 'rebase --keep-empty' '
+=09git checkout -b emptybranch master &&
+=09git commit --allow-empty -m "empty" &&
+=09git rebase --keep-empty -i HEAD~2 &&
+=09git log --oneline >actual &&
+=09test_line_count =3D 6 actual
+'
+
+cat > expect <<EOF
+error: nothing to do
+EOF
+
+test_expect_success 'rebase -i with empty HEAD' '
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 exec_true" git rebase -i HEAD^ >actu=
al 2>&1 &&
+=09test_i18ncmp expect actual
+'
+
+test_expect_success 'rebase -i with the exec command' '
+=09git checkout master &&
+=09(
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 exec_>touch-one
+=09=092 exec_>touch-two exec_false exec_>touch-three
+=09=093 4 exec_>\"touch-file__name_with_spaces\";_>touch-after-semicolon 5=
" &&
+=09export FAKE_LINES &&
+=09test_must_fail git rebase -i A
+=09) &&
+=09test_path_is_file touch-one &&
+=09test_path_is_file touch-two &&
+=09test_path_is_missing touch-three " (should have stopped before)" &&
+=09test_cmp_rev C HEAD &&
+=09git rebase --continue &&
+=09test_path_is_file touch-three &&
+=09test_path_is_file "touch-file  name with spaces" &&
+=09test_path_is_file touch-after-semicolon &&
+=09test_cmp_rev master HEAD &&
+=09rm -f touch-*
+'
+
+test_expect_success 'rebase -i with the exec command runs from tree root' =
'
+=09git checkout master &&
+=09mkdir subdir && (cd subdir &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 exec_>touch-subdir" \
+=09=09git rebase -i HEAD^
+=09) &&
+=09test_path_is_file touch-subdir &&
+=09rm -fr subdir
+'
+
+test_expect_success 'rebase -i with exec allows git commands in subdirs' '
+=09test_when_finished "rm -rf subdir" &&
+=09test_when_finished "git rebase --abort ||:" &&
+=09git checkout master &&
+=09mkdir subdir && (cd subdir &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 x_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
+=09=09git rebase -i HEAD^
+=09)
+'
+
+test_expect_success 'rebase -i sets work tree properly' '
+=09test_when_finished "rm -rf subdir" &&
+=09test_when_finished "test_might_fail git rebase --abort" &&
+=09mkdir subdir &&
+=09git rebase -x "(cd subdir && git rev-parse --show-toplevel)" HEAD^ \
+=09=09>actual &&
+=09! grep "/subdir$" actual
+'
+
+test_expect_success 'rebase -i with the exec command checks tree cleanness=
' '
+=09git checkout master &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"exec_echo_foo_>file1 1" git rebase -i =
HEAD^ &&
+=09test_cmp_rev master^ HEAD &&
+=09git reset --hard &&
+=09git rebase --continue
+'
+
+test_expect_success 'rebase -x with empty command fails' '
+=09test_when_finished "git rebase --abort ||:" &&
+=09test_must_fail env git rebase -x "" @ 2>actual &&
+=09test_write_lines "error: empty exec command" >expected &&
+=09test_i18ncmp expected actual &&
+=09test_must_fail env git rebase -x " " @ 2>actual &&
+=09test_i18ncmp expected actual
+'
+
+LF=3D'
+'
+test_expect_success 'rebase -x with newline in command fails' '
+=09test_when_finished "git rebase --abort ||:" &&
+=09test_must_fail env git rebase -x "a${LF}b" @ 2>actual &&
+=09test_write_lines "error: exec commands cannot contain newlines" \
+=09=09=09 >expected &&
+=09test_i18ncmp expected actual
+'
+
+test_expect_success 'rebase -i with exec of inexistent command' '
+=09git checkout master &&
+=09test_when_finished "git rebase --abort" &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"exec_this-command-does-not-exist 1" \
+=09git rebase -i HEAD^ >actual 2>&1 &&
+=09! grep "Maybe git-rebase is broken" actual
+'
+
+test_expect_success 'implicit interactive rebase does not invoke sequence =
editor' '
+=09test_when_finished "git rebase --abort ||:" &&
+=09GIT_SEQUENCE_EDITOR=3D"echo bad >" git rebase -x"echo one" @^
+'
+
+test_expect_success 'no changes are a nop' '
+=09git checkout branch2 &&
+=09set_fake_editor &&
+=09git rebase -i F &&
+=09test "$(git symbolic-ref -q HEAD)" =3D "refs/heads/branch2" &&
+=09test $(git rev-parse I) =3D $(git rev-parse HEAD)
+'
+
+test_expect_success 'test the [branch] option' '
+=09git checkout -b dead-end &&
+=09git rm file6 &&
+=09git commit -m "stop here" &&
+=09set_fake_editor &&
+=09git rebase -i F branch2 &&
+=09test "$(git symbolic-ref -q HEAD)" =3D "refs/heads/branch2" &&
+=09test $(git rev-parse I) =3D $(git rev-parse branch2) &&
+=09test $(git rev-parse I) =3D $(git rev-parse HEAD)
+'
+
+test_expect_success 'test --onto <branch>' '
+=09git checkout -b test-onto branch2 &&
+=09set_fake_editor &&
+=09git rebase -i --onto branch1 F &&
+=09test "$(git symbolic-ref -q HEAD)" =3D "refs/heads/test-onto" &&
+=09test $(git rev-parse HEAD^) =3D $(git rev-parse branch1) &&
+=09test $(git rev-parse I) =3D $(git rev-parse branch2)
+'
+
+test_expect_success 'rebase on top of a non-conflicting commit' '
+=09git checkout branch1 &&
+=09git tag original-branch1 &&
+=09set_fake_editor &&
+=09git rebase -i branch2 &&
+=09test file6 =3D $(git diff --name-only original-branch1) &&
+=09test "$(git symbolic-ref -q HEAD)" =3D "refs/heads/branch1" &&
+=09test $(git rev-parse I) =3D $(git rev-parse branch2) &&
+=09test $(git rev-parse I) =3D $(git rev-parse HEAD~2)
+'
+
+test_expect_success 'reflog for the branch shows state before rebase' '
+=09test $(git rev-parse branch1@{1}) =3D $(git rev-parse original-branch1)
+'
+
+test_expect_success 'reflog for the branch shows correct finish message' '
+=09printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
+=09=09"$(git rev-parse branch2)" >expected &&
+=09git log -g --pretty=3D%gs -1 refs/heads/branch1 >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'exchange two commits' '
+=09set_fake_editor &&
+=09FAKE_LINES=3D"2 1" git rebase -i HEAD~2 &&
+=09test H =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+=09test G =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+cat > expect << EOF
+diff --git a/file1 b/file1
+index f70f10e..fd79235 100644
+--- a/file1
++++ b/file1
+@@ -1 +1 @@
+-A
++G
+EOF
+
+cat > expect2 << EOF
+<<<<<<< HEAD
+D
+=3D=3D=3D=3D=3D=3D=3D
+G
+>>>>>>> 5d18e54... G
+EOF
+
+test_expect_success 'stop on conflicting pick' '
+=09git tag new-branch1 &&
+=09set_fake_editor &&
+=09test_must_fail git rebase -i master &&
+=09test "$(git rev-parse HEAD~3)" =3D "$(git rev-parse master)" &&
+=09test_cmp expect .git/rebase-merge/patch &&
+=09test_cmp expect2 file1 &&
+=09test "$(git diff --name-status |
+=09=09sed -n -e "/^U/s/^U[^a-z]*//p")" =3D file1 &&
+=09test 4 =3D $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
+=09test 0 =3D $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
+'
+
+test_expect_success 'show conflicted patch' '
+=09GIT_TRACE=3D1 git rebase --show-current-patch >/dev/null 2>stderr &&
+=09grep "show.*REBASE_HEAD" stderr &&
+=09# the original stopped-sha1 is abbreviated
+=09stopped_sha1=3D"$(git rev-parse $(cat ".git/rebase-merge/stopped-sha"))=
" &&
+=09test "$(git rev-parse REBASE_HEAD)" =3D "$stopped_sha1"
+'
+
+test_expect_success 'abort' '
+=09git rebase --abort &&
+=09test $(git rev-parse new-branch1) =3D $(git rev-parse HEAD) &&
+=09test "$(git symbolic-ref -q HEAD)" =3D "refs/heads/branch1" &&
+=09test_path_is_missing .git/rebase-merge
+'
+
+test_expect_success 'abort with error when new base cannot be checked out'=
 '
+=09git rm --cached file1 &&
+=09git commit -m "remove file in base" &&
+=09set_fake_editor &&
+=09test_must_fail git rebase -i master > output 2>&1 &&
+=09test_i18ngrep "The following untracked working tree files would be over=
written by checkout:" \
+=09=09output &&
+=09test_i18ngrep "file1" output &&
+=09test_path_is_missing .git/rebase-merge &&
+=09git reset --hard HEAD^
+'
+
+test_expect_success 'retain authorship' '
+=09echo A > file7 &&
+=09git add file7 &&
+=09test_tick &&
+=09GIT_AUTHOR_NAME=3D"Twerp Snog" git commit -m "different author" &&
+=09git tag twerp &&
+=09set_fake_editor &&
+=09git rebase -i --onto master HEAD^ &&
+=09git show HEAD | grep "^Author: Twerp Snog"
+'
+
+test_expect_success 'retain authorship w/ conflicts' '
+=09oGIT_AUTHOR_NAME=3D$GIT_AUTHOR_NAME &&
+=09test_when_finished "GIT_AUTHOR_NAME=3D\$oGIT_AUTHOR_NAME" &&
+
+=09git reset --hard twerp &&
+=09test_commit a conflict a conflict-a &&
+=09git reset --hard twerp &&
+
+=09GIT_AUTHOR_NAME=3DAttributeMe &&
+=09export GIT_AUTHOR_NAME &&
+=09test_commit b conflict b conflict-b &&
+=09GIT_AUTHOR_NAME=3D$oGIT_AUTHOR_NAME &&
+
+=09set_fake_editor &&
+=09test_must_fail git rebase -i conflict-a &&
+=09echo resolved >conflict &&
+=09git add conflict &&
+=09git rebase --continue &&
+=09test $(git rev-parse conflict-a^0) =3D $(git rev-parse HEAD^) &&
+=09git show >out &&
+=09grep AttributeMe out
+'
+
+test_expect_success 'squash' '
+=09git reset --hard twerp &&
+=09echo B > file7 &&
+=09test_tick &&
+=09GIT_AUTHOR_NAME=3D"Nitfol" git commit -m "nitfol" file7 &&
+=09echo "******************************" &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 squash 2" EXPECT_HEADER_COUNT=3D2 \
+=09=09git rebase -i --onto master HEAD~2 &&
+=09test B =3D $(cat file7) &&
+=09test $(git rev-parse HEAD^) =3D $(git rev-parse master)
+'
+
+test_expect_success 'retain authorship when squashing' '
+=09git show HEAD | grep "^Author: Twerp Snog"
+'
+
+test_expect_success REBASE_P '-p handles "no changes" gracefully' '
+=09HEAD=3D$(git rev-parse HEAD) &&
+=09set_fake_editor &&
+=09git rebase -i -p HEAD^ &&
+=09git update-index --refresh &&
+=09git diff-files --quiet &&
+=09git diff-index --quiet --cached HEAD -- &&
+=09test $HEAD =3D $(git rev-parse HEAD)
+'
+
+test_expect_failure REBASE_P 'exchange two commits with -p' '
+=09git checkout H &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"2 1" git rebase -i -p HEAD~2 &&
+=09test H =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+=09test G =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+test_expect_success REBASE_P 'preserve merges with -p' '
+=09git checkout -b to-be-preserved master^ &&
+=09: > unrelated-file &&
+=09git add unrelated-file &&
+=09test_tick &&
+=09git commit -m "unrelated" &&
+=09git checkout -b another-branch master &&
+=09echo B > file1 &&
+=09test_tick &&
+=09git commit -m J file1 &&
+=09test_tick &&
+=09git merge to-be-preserved &&
+=09echo C > file1 &&
+=09test_tick &&
+=09git commit -m K file1 &&
+=09echo D > file1 &&
+=09test_tick &&
+=09git commit -m L1 file1 &&
+=09git checkout HEAD^ &&
+=09echo 1 > unrelated-file &&
+=09test_tick &&
+=09git commit -m L2 unrelated-file &&
+=09test_tick &&
+=09git merge another-branch &&
+=09echo E > file1 &&
+=09test_tick &&
+=09git commit -m M file1 &&
+=09git checkout -b to-be-rebased &&
+=09test_tick &&
+=09set_fake_editor &&
+=09git rebase -i -p --onto branch1 master &&
+=09git update-index --refresh &&
+=09git diff-files --quiet &&
+=09git diff-index --quiet --cached HEAD -- &&
+=09test $(git rev-parse HEAD~6) =3D $(git rev-parse branch1) &&
+=09test $(git rev-parse HEAD~4^2) =3D $(git rev-parse to-be-preserved) &&
+=09test $(git rev-parse HEAD^^2^) =3D $(git rev-parse HEAD^^^) &&
+=09test $(git show HEAD~5:file1) =3D B &&
+=09test $(git show HEAD~3:file1) =3D C &&
+=09test $(git show HEAD:file1) =3D E &&
+=09test $(git show HEAD:unrelated-file) =3D 1
+'
+
+test_expect_success REBASE_P 'edit ancestor with -p' '
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 2 edit 3 4" git rebase -i -p HEAD~3 &&
+=09echo 2 > unrelated-file &&
+=09test_tick &&
+=09git commit -m L2-modified --amend unrelated-file &&
+=09git rebase --continue &&
+=09git update-index --refresh &&
+=09git diff-files --quiet &&
+=09git diff-index --quiet --cached HEAD -- &&
+=09test $(git show HEAD:unrelated-file) =3D 2
+'
+
+test_expect_success '--continue tries to commit' '
+=09git reset --hard D &&
+=09test_tick &&
+=09set_fake_editor &&
+=09test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
+=09echo resolved > file1 &&
+=09git add file1 &&
+=09FAKE_COMMIT_MESSAGE=3D"chouette!" git rebase --continue &&
+=09test $(git rev-parse HEAD^) =3D $(git rev-parse new-branch1) &&
+=09git show HEAD | grep chouette
+'
+
+test_expect_success 'verbose flag is heeded, even after --continue' '
+=09git reset --hard master@{1} &&
+=09test_tick &&
+=09set_fake_editor &&
+=09test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
+=09echo resolved > file1 &&
+=09git add file1 &&
+=09git rebase --continue > output &&
+=09grep "^ file1 | 2 +-$" output
+'
+
+test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor onc=
e' '
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"1 squash 2 squash 3 squash 4" =
\
+=09=09EXPECT_HEADER_COUNT=3D4 \
+=09=09git rebase -i $base &&
+=09test $base =3D $(git rev-parse HEAD^) &&
+=09test 1 =3D $(git show | grep ONCE | wc -l)
+'
+
+test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' =
'
+=09git checkout -b multi-fixup E &&
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09FAKE_COMMIT_AMEND=3D"NEVER" FAKE_LINES=3D"1 fixup 2 fixup 3 fixup 4" \
+=09=09git rebase -i $base &&
+=09test $base =3D $(git rev-parse HEAD^) &&
+=09test 0 =3D $(git show | grep NEVER | wc -l) &&
+=09git checkout @{-1} &&
+=09git branch -D multi-fixup
+'
+
+test_expect_success 'commit message used after conflict' '
+=09git checkout -b conflict-fixup conflict-branch &&
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 fixup 3 fixup 4" git rebase -i $base=
 &&
+=09echo three > conflict &&
+=09git add conflict &&
+=09FAKE_COMMIT_AMEND=3D"ONCE" EXPECT_HEADER_COUNT=3D2 \
+=09=09git rebase --continue &&
+=09test $base =3D $(git rev-parse HEAD^) &&
+=09test 1 =3D $(git show | grep ONCE | wc -l) &&
+=09git checkout @{-1} &&
+=09git branch -D conflict-fixup
+'
+
+test_expect_success 'commit message retained after conflict' '
+=09git checkout -b conflict-squash conflict-branch &&
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 fixup 3 squash 4" git rebase -i $bas=
e &&
+=09echo three > conflict &&
+=09git add conflict &&
+=09FAKE_COMMIT_AMEND=3D"TWICE" EXPECT_HEADER_COUNT=3D2 \
+=09=09git rebase --continue &&
+=09test $base =3D $(git rev-parse HEAD^) &&
+=09test 2 =3D $(git show | grep TWICE | wc -l) &&
+=09git checkout @{-1} &&
+=09git branch -D conflict-squash
+'
+
+cat > expect-squash-fixup << EOF
+B
+
+D
+
+ONCE
+EOF
+
+test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log=
 messages' '
+=09git checkout -b squash-fixup E &&
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"1 fixup 2 squash 3 fixup 4" \
+=09=09EXPECT_HEADER_COUNT=3D4 \
+=09=09git rebase -i $base &&
+=09git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
+=09test_cmp expect-squash-fixup actual-squash-fixup &&
+=09git cat-file commit HEAD@{2} |
+=09=09grep "^# This is a combination of 3 commits\."  &&
+=09git cat-file commit HEAD@{3} |
+=09=09grep "^# This is a combination of 2 commits\."  &&
+=09git checkout @{-1} &&
+=09git branch -D squash-fixup
+'
+
+test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
+=09git checkout -b skip-comments E &&
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"# 1 # squash 2 # squash 3 # sq=
uash 4 #" \
+=09=09EXPECT_HEADER_COUNT=3D4 \
+=09=09git rebase -i $base &&
+=09test $base =3D $(git rev-parse HEAD^) &&
+=09test 1 =3D $(git show | grep ONCE | wc -l) &&
+=09git checkout @{-1} &&
+=09git branch -D skip-comments
+'
+
+test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
+=09git checkout -b skip-blank-lines E &&
+=09base=3D$(git rev-parse HEAD~4) &&
+=09set_fake_editor &&
+=09FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"> 1 > squash 2 > squash 3 > sq=
uash 4 >" \
+=09=09EXPECT_HEADER_COUNT=3D4 \
+=09=09git rebase -i $base &&
+=09test $base =3D $(git rev-parse HEAD^) &&
+=09test 1 =3D $(git show | grep ONCE | wc -l) &&
+=09git checkout @{-1} &&
+=09git branch -D skip-blank-lines
+'
+
+test_expect_success 'squash works as expected' '
+=09git checkout -b squash-works no-conflict-branch &&
+=09one=3D$(git rev-parse HEAD~3) &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 s 3 2" EXPECT_HEADER_COUNT=3D2 \
+=09=09git rebase -i HEAD~3 &&
+=09test $one =3D $(git rev-parse HEAD~2)
+'
+
+test_expect_success 'interrupted squash works as expected' '
+=09git checkout -b interrupted-squash conflict-branch &&
+=09one=3D$(git rev-parse HEAD~3) &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 squash 3 2" git rebase -i HEAD~3 &&
+=09test_write_lines one two four > conflict &&
+=09git add conflict &&
+=09test_must_fail git rebase --continue &&
+=09echo resolved > conflict &&
+=09git add conflict &&
+=09git rebase --continue &&
+=09test $one =3D $(git rev-parse HEAD~2)
+'
+
+test_expect_success 'interrupted squash works as expected (case 2)' '
+=09git checkout -b interrupted-squash2 conflict-branch &&
+=09one=3D$(git rev-parse HEAD~3) &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"3 squash 1 2" git rebase -i HEAD~3 &&
+=09test_write_lines one four > conflict &&
+=09git add conflict &&
+=09test_must_fail git rebase --continue &&
+=09test_write_lines one two four > conflict &&
+=09git add conflict &&
+=09test_must_fail git rebase --continue &&
+=09echo resolved > conflict &&
+=09git add conflict &&
+=09git rebase --continue &&
+=09test $one =3D $(git rev-parse HEAD~2)
+'
+
+test_expect_success '--continue tries to commit, even for "edit"' '
+=09echo unrelated > file7 &&
+=09git add file7 &&
+=09test_tick &&
+=09git commit -m "unrelated change" &&
+=09parent=3D$(git rev-parse HEAD^) &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
+=09echo edited > file7 &&
+=09git add file7 &&
+=09FAKE_COMMIT_MESSAGE=3D"chouette!" git rebase --continue &&
+=09test edited =3D $(git show HEAD:file7) &&
+=09git show HEAD | grep chouette &&
+=09test $parent =3D $(git rev-parse HEAD^)
+'
+
+test_expect_success 'aborted --continue does not squash commits after "edi=
t"' '
+=09old=3D$(git rev-parse HEAD) &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
+=09echo "edited again" > file7 &&
+=09git add file7 &&
+=09test_must_fail env FAKE_COMMIT_MESSAGE=3D" " git rebase --continue &&
+=09test $old =3D $(git rev-parse HEAD) &&
+=09git rebase --abort
+'
+
+test_expect_success 'auto-amend only edited commits after "edit"' '
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
+=09echo "edited again" > file7 &&
+=09git add file7 &&
+=09FAKE_COMMIT_MESSAGE=3D"edited file7 again" git commit &&
+=09echo "and again" > file7 &&
+=09git add file7 &&
+=09test_tick &&
+=09test_must_fail env FAKE_COMMIT_MESSAGE=3D"and again" git rebase --conti=
nue &&
+=09git rebase --abort
+'
+
+test_expect_success 'clean error after failed "exec"' '
+=09test_tick &&
+=09test_when_finished "git rebase --abort || :" &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 exec_false" git rebase -i HEAD^ &&
+=09echo "edited again" > file7 &&
+=09git add file7 &&
+=09test_must_fail git rebase --continue 2>error &&
+=09test_i18ngrep "you have staged changes in your working tree" error
+'
+
+test_expect_success 'rebase a detached HEAD' '
+=09grandparent=3D$(git rev-parse HEAD~2) &&
+=09git checkout $(git rev-parse HEAD) &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"2 1" git rebase -i HEAD~2 &&
+=09test $grandparent =3D $(git rev-parse HEAD~2)
+'
+
+test_expect_success 'rebase a commit violating pre-commit' '
+
+=09mkdir -p .git/hooks &&
+=09write_script .git/hooks/pre-commit <<-\EOF &&
+=09test -z "$(git diff --cached --check)"
+=09EOF
+=09echo "monde! " >> file1 &&
+=09test_tick &&
+=09test_must_fail git commit -m doesnt-verify file1 &&
+=09git commit -m doesnt-verify --no-verify file1 &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D2 git rebase -i HEAD~2
+
+'
+
+test_expect_success 'rebase with a file named HEAD in worktree' '
+
+=09rm -fr .git/hooks &&
+=09git reset --hard &&
+=09git checkout -b branch3 A &&
+
+=09(
+=09=09GIT_AUTHOR_NAME=3D"Squashed Away" &&
+=09=09export GIT_AUTHOR_NAME &&
+=09=09>HEAD &&
+=09=09git add HEAD &&
+=09=09git commit -m "Add head" &&
+=09=09>BODY &&
+=09=09git add BODY &&
+=09=09git commit -m "Add body"
+=09) &&
+
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 squash 2" git rebase -i @{-1} &&
+=09test "$(git show -s --pretty=3Dformat:%an)" =3D "Squashed Away"
+
+'
+
+test_expect_success 'do "noop" when there is nothing to cherry-pick' '
+
+=09git checkout -b branch4 HEAD &&
+=09GIT_EDITOR=3D: git commit --amend \
+=09=09--author=3D"Somebody else <somebody@else.com>" &&
+=09test $(git rev-parse branch3) !=3D $(git rev-parse branch4) &&
+=09set_fake_editor &&
+=09git rebase -i branch3 &&
+=09test $(git rev-parse branch3) =3D $(git rev-parse branch4)
+
+'
+
+test_expect_success 'submodule rebase setup' '
+=09git checkout A &&
+=09mkdir sub &&
+=09(
+=09=09cd sub && git init && >elif &&
+=09=09git add elif && git commit -m "submodule initial"
+=09) &&
+=09echo 1 >file1 &&
+=09git add file1 sub &&
+=09test_tick &&
+=09git commit -m "One" &&
+=09echo 2 >file1 &&
+=09test_tick &&
+=09git commit -a -m "Two" &&
+=09(
+=09=09cd sub && echo 3 >elif &&
+=09=09git commit -a -m "submodule second"
+=09) &&
+=09test_tick &&
+=09set_fake_editor &&
+=09git commit -a -m "Three changes submodule"
+'
+
+test_expect_success 'submodule rebase -i' '
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 squash 2 3" git rebase -i A
+'
+
+test_expect_success 'submodule conflict setup' '
+=09git tag submodule-base &&
+=09git checkout HEAD^ &&
+=09(
+=09=09cd sub && git checkout HEAD^ && echo 4 >elif &&
+=09=09git add elif && git commit -m "submodule conflict"
+=09) &&
+=09git add sub &&
+=09test_tick &&
+=09git commit -m "Conflict in submodule" &&
+=09git tag submodule-topic
+'
+
+test_expect_success 'rebase -i continue with only submodule staged' '
+=09set_fake_editor &&
+=09test_must_fail git rebase -i submodule-base &&
+=09git add sub &&
+=09git rebase --continue &&
+=09test $(git rev-parse submodule-base) !=3D $(git rev-parse HEAD)
+'
+
+test_expect_success 'rebase -i continue with unstaged submodule' '
+=09git checkout submodule-topic &&
+=09git reset --hard &&
+=09set_fake_editor &&
+=09test_must_fail git rebase -i submodule-base &&
+=09git reset &&
+=09git rebase --continue &&
+=09test $(git rev-parse submodule-base) =3D $(git rev-parse HEAD)
+'
+
+test_expect_success 'avoid unnecessary reset' '
+=09git checkout master &&
+=09git reset --hard &&
+=09test-tool chmtime =3D123456789 file3 &&
+=09git update-index --refresh &&
+=09HEAD=3D$(git rev-parse HEAD) &&
+=09set_fake_editor &&
+=09git rebase -i HEAD~4 &&
+=09test $HEAD =3D $(git rev-parse HEAD) &&
+=09MTIME=3D$(test-tool chmtime --get file3) &&
+=09test 123456789 =3D $MTIME
+'
+
+test_expect_success 'reword' '
+=09git checkout -b reword-branch master &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 2 3 reword 4" FAKE_COMMIT_MESSAGE=3D"E changed" git reb=
ase -i A &&
+=09git show HEAD | grep "E changed" &&
+=09test $(git rev-parse master) !=3D $(git rev-parse HEAD) &&
+=09test $(git rev-parse master^) =3D $(git rev-parse HEAD^) &&
+=09FAKE_LINES=3D"1 2 reword 3 4" FAKE_COMMIT_MESSAGE=3D"D changed" git reb=
ase -i A &&
+=09git show HEAD^ | grep "D changed" &&
+=09FAKE_LINES=3D"reword 1 2 3 4" FAKE_COMMIT_MESSAGE=3D"B changed" git reb=
ase -i A &&
+=09git show HEAD~3 | grep "B changed" &&
+=09FAKE_LINES=3D"1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE=3D"C changed" git r=
ebase -i A &&
+=09git show HEAD~2 | grep "C changed"
+'
+
+test_expect_success 'rebase -i can copy notes' '
+=09git config notes.rewrite.rebase true &&
+=09git config notes.rewriteRef "refs/notes/*" &&
+=09test_commit n1 &&
+=09test_commit n2 &&
+=09test_commit n3 &&
+=09git notes add -m"a note" n3 &&
+=09set_fake_editor &&
+=09git rebase -i --onto n1 n2 &&
+=09test "a note" =3D "$(git notes show HEAD)"
+'
+
+cat >expect <<EOF
+an earlier note
+
+a note
+EOF
+
+test_expect_success 'rebase -i can copy notes over a fixup' '
+=09git reset --hard n3 &&
+=09git notes add -m"an earlier note" n2 &&
+=09set_fake_editor &&
+=09GIT_NOTES_REWRITE_MODE=3Dconcatenate FAKE_LINES=3D"1 f 2" git rebase -i=
 n1 &&
+=09git notes show > output &&
+=09test_cmp expect output
+'
+
+test_expect_success 'rebase while detaching HEAD' '
+=09git symbolic-ref HEAD &&
+=09grandparent=3D$(git rev-parse HEAD~2) &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"2 1" git rebase -i HEAD~2 HEAD^0 &&
+=09test $grandparent =3D $(git rev-parse HEAD~2) &&
+=09test_must_fail git symbolic-ref HEAD
+'
+
+test_tick # Ensure that the rebased commits get a different timestamp.
+test_expect_success 'always cherry-pick with --no-ff' '
+=09git checkout no-ff-branch &&
+=09git tag original-no-ff-branch &&
+=09set_fake_editor &&
+=09git rebase -i --no-ff A &&
+=09for p in 0 1 2
+=09do
+=09=09test ! $(git rev-parse HEAD~$p) =3D $(git rev-parse original-no-ff-b=
ranch~$p) &&
+=09=09git diff HEAD~$p original-no-ff-branch~$p > out &&
+=09=09test_must_be_empty out
+=09done &&
+=09test $(git rev-parse HEAD~3) =3D $(git rev-parse original-no-ff-branch~=
3) &&
+=09git diff HEAD~3 original-no-ff-branch~3 > out &&
+=09test_must_be_empty out
+'
+
+test_expect_success 'set up commits with funny messages' '
+=09git checkout -b funny A &&
+=09echo >>file1 &&
+=09test_tick &&
+=09git commit -a -m "end with slash\\" &&
+=09echo >>file1 &&
+=09test_tick &&
+=09git commit -a -m "something (\000) that looks like octal" &&
+=09echo >>file1 &&
+=09test_tick &&
+=09git commit -a -m "something (\n) that looks like a newline" &&
+=09echo >>file1 &&
+=09test_tick &&
+=09git commit -a -m "another commit"
+'
+
+test_expect_success 'rebase-i history with funny messages' '
+=09git rev-list A..funny >expect &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 2 3 4" git rebase -i A &&
+=09git rev-list A.. >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'prepare for rebase -i --exec' '
+=09git checkout master &&
+=09git checkout -b execute &&
+=09test_commit one_exec main.txt one_exec &&
+=09test_commit two_exec main.txt two_exec &&
+=09test_commit three_exec main.txt three_exec
+'
+
+test_expect_success 'running "git rebase -i --exec git show HEAD"' '
+=09set_fake_editor &&
+=09git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
+=09(
+=09=09FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+=09=09export FAKE_LINES &&
+=09=09git rebase -i HEAD~2 >expect
+=09) &&
+=09sed -e "1,9d" expect >expected &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'running "git rebase --exec git show HEAD -i"' '
+=09git reset --hard execute &&
+=09set_fake_editor &&
+=09git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
+=09(
+=09=09FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+=09=09export FAKE_LINES &&
+=09=09git rebase -i HEAD~2 >expect
+=09) &&
+=09sed -e "1,9d" expect >expected &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'running "git rebase -ix git show HEAD"' '
+=09git reset --hard execute &&
+=09set_fake_editor &&
+=09git rebase -ix "git show HEAD" HEAD~2 >actual &&
+=09(
+=09=09FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+=09=09export FAKE_LINES &&
+=09=09git rebase -i HEAD~2 >expect
+=09) &&
+=09sed -e "1,9d" expect >expected &&
+=09test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several <CMD>' '
+=09git reset --hard execute &&
+=09set_fake_editor &&
+=09git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
+=09(
+=09=09FAKE_LINES=3D"1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &=
&
+=09=09export FAKE_LINES &&
+=09=09git rebase -i HEAD~2 >expect
+=09) &&
+=09sed -e "1,9d" expect >expected &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'rebase -ix with several instances of --exec' '
+=09git reset --hard execute &&
+=09set_fake_editor &&
+=09git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
+=09(
+=09=09FAKE_LINES=3D"1 exec_git_show_HEAD exec_pwd 2
+=09=09=09=09exec_git_show_HEAD exec_pwd" &&
+=09=09export FAKE_LINES &&
+=09=09git rebase -i HEAD~2 >expect
+=09) &&
+=09sed -e "1,11d" expect >expected &&
+=09test_cmp expected actual
+'
+
+test_expect_success C_LOCALE_OUTPUT 'rebase -ix with --autosquash' '
+=09git reset --hard execute &&
+=09git checkout -b autosquash &&
+=09echo second >second.txt &&
+=09git add second.txt &&
+=09git commit -m "fixup! two_exec" &&
+=09echo bis >bis.txt &&
+=09git add bis.txt &&
+=09git commit -m "fixup! two_exec" &&
+=09set_fake_editor &&
+=09(
+=09=09git checkout -b autosquash_actual &&
+=09=09git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual
+=09) &&
+=09git checkout autosquash &&
+=09(
+=09=09git checkout -b autosquash_expected &&
+=09=09FAKE_LINES=3D"1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_H=
EAD" &&
+=09=09export FAKE_LINES &&
+=09=09git rebase -i HEAD~4 >expect
+=09) &&
+=09sed -e "1,13d" expect >expected &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'rebase --exec works without -i ' '
+=09git reset --hard execute &&
+=09rm -rf exec_output &&
+=09EDITOR=3D"echo >invoked_editor" git rebase --exec "echo a line >>exec_o=
utput"  HEAD~2 2>actual &&
+=09test_i18ngrep  "Successfully rebased and updated" actual &&
+=09test_line_count =3D 2 exec_output &&
+=09test_path_is_missing invoked_editor
+'
+
+test_expect_success 'rebase -i --exec without <CMD>' '
+=09git reset --hard execute &&
+=09set_fake_editor &&
+=09test_must_fail git rebase -i --exec 2>actual &&
+=09test_i18ngrep "requires a value" actual &&
+=09git checkout master
+'
+
+test_expect_success 'rebase -i --root re-order and drop commits' '
+=09git checkout E &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"3 1 2 5" git rebase -i --root &&
+=09test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+=09test B =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+=09test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p) &&
+=09test C =3D $(git cat-file commit HEAD^^^ | sed -ne \$p) &&
+=09test 0 =3D $(git cat-file commit HEAD^^^ | grep -c ^parent\ )
+'
+
+test_expect_success 'rebase -i --root retain root commit author and messag=
e' '
+=09git checkout A &&
+=09echo B >file7 &&
+=09git add file7 &&
+=09GIT_AUTHOR_NAME=3D"Twerp Snog" git commit -m "different author" &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"2" git rebase -i --root &&
+=09git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
+=09git cat-file commit HEAD | grep -q "^different author$"
+'
+
+test_expect_success 'rebase -i --root temporary sentinel commit' '
+=09git checkout B &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"2" git rebase -i --root &&
+=09git cat-file commit HEAD | grep "^tree 4b825dc642cb" &&
+=09git rebase --abort
+'
+
+test_expect_success 'rebase -i --root fixup root commit' '
+=09git checkout B &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 fixup 2" git rebase -i --root &&
+=09test A =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+=09test B =3D $(git show HEAD:file1) &&
+=09test 0 =3D $(git cat-file commit HEAD | grep -c ^parent\ )
+'
+
+test_expect_success 'rebase -i --root reword root commit' '
+=09test_when_finished "test_might_fail git rebase --abort" &&
+=09git checkout -b reword-root-branch master &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"reword 1 2" FAKE_COMMIT_MESSAGE=3D"A changed" \
+=09git rebase -i --root &&
+=09git show HEAD^ | grep "A changed" &&
+=09test -z "$(git show -s --format=3D%p HEAD^)"
+'
+
+test_expect_success 'rebase -i --root when root has untracked file confilc=
t' '
+=09test_when_finished "reset_rebase" &&
+=09git checkout -b failing-root-pick A &&
+=09echo x >file2 &&
+=09git rm file1 &&
+=09git commit -m "remove file 1 add file 2" &&
+=09echo z >file1 &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 2" git rebase -i --root &&
+=09rm file1 &&
+=09git rebase --continue &&
+=09test "$(git log -1 --format=3D%B)" =3D "remove file 1 add file 2" &&
+=09test "$(git rev-list --count HEAD)" =3D 2
+'
+
+test_expect_success 'rebase -i --root reword root when root has untracked =
file conflict' '
+=09test_when_finished "reset_rebase" &&
+=09echo z>file1 &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"reword 1 2" \
+=09=09FAKE_COMMIT_MESSAGE=3D"Modified A" git rebase -i --root &&
+=09rm file1 &&
+=09FAKE_COMMIT_MESSAGE=3D"Reworded A" git rebase --continue &&
+=09test "$(git log -1 --format=3D%B HEAD^)" =3D "Reworded A" &&
+=09test "$(git rev-list --count HEAD)" =3D 2
+'
+
+test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on n=
on-interactive rebase' '
+=09git checkout reword-root-branch &&
+=09git reset --hard &&
+=09git checkout conflict-branch &&
+=09set_fake_editor &&
+=09test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+=09test_must_fail git rebase --edit-todo &&
+=09git rebase --abort
+'
+
+test_expect_success 'rebase --edit-todo can be used to modify todo' '
+=09git reset --hard &&
+=09git checkout no-conflict-branch^0 &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1 2 3" git rebase -i HEAD~3 &&
+=09FAKE_LINES=3D"2 1" git rebase --edit-todo &&
+=09git rebase --continue &&
+=09test M =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+=09test L =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+test_expect_success 'rebase -i produces readable reflog' '
+=09git reset --hard &&
+=09git branch -f branch-reflog-test H &&
+=09set_fake_editor &&
+=09git rebase -i --onto I F branch-reflog-test &&
+=09cat >expect <<-\EOF &&
+=09rebase -i (finish): returning to refs/heads/branch-reflog-test
+=09rebase -i (pick): H
+=09rebase -i (pick): G
+=09rebase -i (start): checkout I
+=09EOF
+=09git reflog -n4 HEAD |
+=09sed "s/[^:]*: //" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'rebase -i respects core.commentchar' '
+=09git reset --hard &&
+=09git checkout E^0 &&
+=09test_config core.commentchar "\\" &&
+=09write_script remove-all-but-first.sh <<-\EOF &&
+=09sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
+=09mv "$1.tmp" "$1"
+=09EOF
+=09test_set_editor "$(pwd)/remove-all-but-first.sh" &&
+=09git rebase -i B &&
+=09test B =3D $(git cat-file commit HEAD^ | sed -ne \$p)
+'
+
+test_expect_success 'rebase -i respects core.commentchar=3Dauto' '
+=09test_config core.commentchar auto &&
+=09write_script copy-edit-script.sh <<-\EOF &&
+=09cp "$1" edit-script
+=09EOF
+=09test_set_editor "$(pwd)/copy-edit-script.sh" &&
+=09test_when_finished "git rebase --abort || :" &&
+=09git rebase -i HEAD^ &&
+=09test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
+'
+
+test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/=
quuxery' '
+=09test_when_finished "git branch -D torebase" &&
+=09git checkout -b torebase branch1 &&
+=09upstream=3D$(git rev-parse ":/J") &&
+=09onto=3D$(git rev-parse ":/A") &&
+=09git rebase --onto $onto $upstream &&
+=09git reset --hard branch1 &&
+=09git rebase --onto ":/A" ":/J" &&
+=09git checkout branch1
+'
+
+test_expect_success 'rebase -i with --strategy and -X' '
+=09git checkout -b conflict-merge-use-theirs conflict-branch &&
+=09git reset --hard HEAD^ &&
+=09echo five >conflict &&
+=09echo Z >file1 &&
+=09git commit -a -m "one file conflict" &&
+=09EDITOR=3Dtrue git rebase -i --strategy=3Drecursive -Xours conflict-bran=
ch &&
+=09test $(git show conflict-branch:conflict) =3D $(cat conflict) &&
+=09test $(cat file1) =3D Z
+'
+
+test_expect_success 'interrupted rebase -i with --strategy and -X' '
+=09git checkout -b conflict-merge-use-theirs-interrupted conflict-branch &=
&
+=09git reset --hard HEAD^ &&
+=09>breakpoint &&
+=09git add breakpoint &&
+=09git commit -m "breakpoint for interactive mode" &&
+=09echo five >conflict &&
+=09echo Z >file1 &&
+=09git commit -a -m "one file conflict" &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1 2" git rebase -i --strategy=3Drecursive -Xours con=
flict-branch &&
+=09git rebase --continue &&
+=09test $(git show conflict-branch:conflict) =3D $(cat conflict) &&
+=09test $(cat file1) =3D Z
+'
+
+test_expect_success 'rebase -i error on commits with \ in message' '
+=09current_head=3D$(git rev-parse HEAD) &&
+=09test_when_finished "git rebase --abort; git reset --hard $current_head;=
 rm -f error" &&
+=09test_commit TO-REMOVE will-conflict old-content &&
+=09test_commit "\temp" will-conflict new-content dummy &&
+=09test_must_fail env EDITOR=3Dtrue git rebase -i HEAD^ --onto HEAD^^ 2>er=
ror &&
+=09test_expect_code 1 grep  "=09emp" error
+'
+
+test_expect_success 'short SHA-1 setup' '
+=09test_when_finished "git checkout master" &&
+=09git checkout --orphan collide &&
+=09git rm -rf . &&
+=09(
+=09unset test_tick &&
+=09test_commit collide1 collide &&
+=09test_commit --notick collide2 collide &&
+=09test_commit --notick collide3 collide
+=09)
+'
+
+test_expect_success 'short SHA-1 collide' '
+=09test_when_finished "reset_rebase && git checkout master" &&
+=09git checkout collide &&
+=09(
+=09unset test_tick &&
+=09test_tick &&
+=09set_fake_editor &&
+=09FAKE_COMMIT_MESSAGE=3D"collide2 ac4f2ee" \
+=09FAKE_LINES=3D"reword 1 2" git rebase -i HEAD~2
+=09)
+'
+
+test_expect_success 'respect core.abbrev' '
+=09git config core.abbrev 12 &&
+=09set_cat_todo_editor &&
+=09test_must_fail git rebase -i HEAD~4 >todo-list &&
+=09test 4 =3D $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
+'
+
+test_expect_success 'todo count' '
+=09write_script dump-raw.sh <<-\EOF &&
+=09=09cat "$1"
+=09EOF
+=09test_set_editor "$(pwd)/dump-raw.sh" &&
+=09git rebase -i HEAD~4 >actual &&
+=09test_i18ngrep "^# Rebase ..* onto ..* ([0-9]" actual
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (pic=
k)' '
+=09git checkout --force branch2 &&
+=09git clean -f &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1 2" git rebase -i A &&
+=09test_cmp_rev HEAD F &&
+=09test_path_is_missing file6 &&
+=09>file6 &&
+=09test_must_fail git rebase --continue &&
+=09test_cmp_rev HEAD F &&
+=09rm file6 &&
+=09git rebase --continue &&
+=09test_cmp_rev HEAD I
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (squ=
ash)' '
+=09git checkout --force branch2 &&
+=09git clean -f &&
+=09git tag original-branch2 &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1 squash 2" git rebase -i A &&
+=09test_cmp_rev HEAD F &&
+=09test_path_is_missing file6 &&
+=09>file6 &&
+=09test_must_fail git rebase --continue &&
+=09test_cmp_rev HEAD F &&
+=09rm file6 &&
+=09git rebase --continue &&
+=09test $(git cat-file commit HEAD | sed -ne \$p) =3D I &&
+=09git reset --hard original-branch2
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (no =
ff)' '
+=09git checkout --force branch2 &&
+=09git clean -f &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1 2" git rebase -i --no-ff A &&
+=09test $(git cat-file commit HEAD | sed -ne \$p) =3D F &&
+=09test_path_is_missing file6 &&
+=09>file6 &&
+=09test_must_fail git rebase --continue &&
+=09test $(git cat-file commit HEAD | sed -ne \$p) =3D F &&
+=09rm file6 &&
+=09git rebase --continue &&
+=09test $(git cat-file commit HEAD | sed -ne \$p) =3D I
+'
+
+test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
+=09git checkout -b commit-to-skip &&
+=09for double in X 3 1
+=09do
+=09=09test_seq 5 | sed "s/$double/&&/" >seq &&
+=09=09git add seq &&
+=09=09test_tick &&
+=09=09git commit -m seq-$double
+=09done &&
+=09git tag seq-onto &&
+=09git reset --hard HEAD~2 &&
+=09git cherry-pick seq-onto &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D git rebase -i seq-onto &&
+=09test -d .git/rebase-merge &&
+=09git rebase --continue &&
+=09git diff --exit-code seq-onto &&
+=09test ! -d .git/rebase-merge &&
+=09test ! -f .git/CHERRY_PICK_HEAD
+'
+
+rebase_setup_and_clean () {
+=09test_when_finished "
+=09=09git checkout master &&
+=09=09test_might_fail git branch -D $1 &&
+=09=09test_might_fail git rebase --abort
+=09" &&
+=09git checkout -b $1 ${2:-master}
+}
+
+test_expect_success 'drop' '
+=09rebase_setup_and_clean drop-test &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 drop 2 3 d 4 5" git rebase -i --root &&
+=09test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+=09test C =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+=09test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
+'
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D ign=
ore' '
+=09test_config rebase.missingCommitsCheck ignore &&
+=09rebase_setup_and_clean missing-commit &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 2 3 4" \
+=09=09git rebase -i --root 2>actual &&
+=09test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+=09test_i18ngrep \
+=09=09"Successfully rebased and updated refs/heads/missing-commit" \
+=09=09actual
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git config rebase.missingCommitsCheck' to change the level of warning=
s.
+The possible behaviours are: ignore, warn, error.
+
+Rebasing (1/4)
+Rebasing (2/4)
+Rebasing (3/4)
+Rebasing (4/4)
+Successfully rebased and updated refs/heads/missing-commit.
+EOF
+
+cr_to_nl () {
+=09tr '\015' '\012'
+}
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D war=
n' '
+=09test_config rebase.missingCommitsCheck warn &&
+=09rebase_setup_and_clean missing-commit &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"1 2 3 4" \
+=09=09git rebase -i --root 2>actual.2 &&
+=09cr_to_nl <actual.2 >actual &&
+=09test_i18ncmp expect actual &&
+=09test D =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git config rebase.missingCommitsCheck' to change the level of warning=
s.
+The possible behaviours are: ignore, warn, error.
+
+You can fix this with 'git rebase --edit-todo' and then run 'git rebase --=
continue'.
+Or you can abort the rebase with 'git rebase --abort'.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D err=
or' '
+=09test_config rebase.missingCommitsCheck error &&
+=09rebase_setup_and_clean missing-commit &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 2 4" \
+=09=09git rebase -i --root 2>actual &&
+=09test_i18ncmp expect actual &&
+=09cp .git/rebase-merge/git-rebase-todo.backup \
+=09=09.git/rebase-merge/git-rebase-todo &&
+=09FAKE_LINES=3D"1 2 drop 3 4 drop 5" \
+=09=09git rebase --edit-todo &&
+=09git rebase --continue &&
+=09test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+=09test B =3D $(git cat-file commit HEAD^ | sed -ne \$p)
+'
+
+test_expect_success 'respects rebase.abbreviateCommands with fixup, squash=
 and exec' '
+=09rebase_setup_and_clean abbrevcmd &&
+=09test_commit "first" file1.txt "first line" first &&
+=09test_commit "second" file1.txt "another line" second &&
+=09test_commit "fixup! first" file2.txt "first line again" first_fixup &&
+=09test_commit "squash! second" file1.txt "another line here" second_squas=
h &&
+=09cat >expected <<-EOF &&
+=09p $(git rev-list --abbrev-commit -1 first) first
+=09f $(git rev-list --abbrev-commit -1 first_fixup) fixup! first
+=09x git show HEAD
+=09p $(git rev-list --abbrev-commit -1 second) second
+=09s $(git rev-list --abbrev-commit -1 second_squash) squash! second
+=09x git show HEAD
+=09EOF
+=09git checkout abbrevcmd &&
+=09set_cat_todo_editor &&
+=09test_config rebase.abbreviateCommands true &&
+=09test_must_fail git rebase -i --exec "git show HEAD" \
+=09=09--autosquash master >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'static check of bad command' '
+=09rebase_setup_and_clean bad-cmd &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 2 3 bad 4 5" \
+=09=09git rebase -i --root 2>actual &&
+=09test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" actual &&
+=09test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual =
&&
+=09FAKE_LINES=3D"1 2 3 drop 4 5" git rebase --edit-todo &&
+=09git rebase --continue &&
+=09test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+=09test C =3D $(git cat-file commit HEAD^ | sed -ne \$p)
+'
+
+test_expect_success 'tabs and spaces are accepted in the todolist' '
+=09rebase_setup_and_clean indented-comment &&
+=09write_script add-indent.sh <<-\EOF &&
+=09(
+=09=09# Turn single spaces into space/tab mix
+=09=09sed "1s/ /=09/g; 2s/ /  /g; 3s/ / =09/g" "$1"
+=09=09printf "\n\t# comment\n #more\n\t # comment\n"
+=09) >"$1.new"
+=09mv "$1.new" "$1"
+=09EOF
+=09test_set_editor "$(pwd)/add-indent.sh" &&
+=09git rebase -i HEAD^^^ &&
+=09test E =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+test_expect_success 'static check of bad SHA-1' '
+=09rebase_setup_and_clean bad-sha &&
+=09set_fake_editor &&
+=09test_must_fail env FAKE_LINES=3D"1 2 edit fakesha 3 4 5 #" \
+=09=09git rebase -i --root 2>actual &&
+=09test_i18ngrep "edit XXXXXXX False commit" actual &&
+=09test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual =
&&
+=09FAKE_LINES=3D"1 2 4 5 6" git rebase --edit-todo &&
+=09git rebase --continue &&
+=09test E =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+test_expect_success 'editor saves as CR/LF' '
+=09git checkout -b with-crlf &&
+=09write_script add-crs.sh <<-\EOF &&
+=09sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
+=09mv -f "$1".new "$1"
+=09EOF
+=09(
+=09=09test_set_editor "$(pwd)/add-crs.sh" &&
+=09=09git rebase -i HEAD^
+=09)
+'
+
+SQ=3D"'"
+test_expect_success 'rebase -i --gpg-sign=3D<key-id>' '
+=09test_when_finished "test_might_fail git rebase --abort" &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1" git rebase -i --gpg-sign=3D"\"S I Gner\"" HEAD^ \
+=09=09>out 2>err &&
+=09test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
+'
+
+test_expect_success 'rebase -i --gpg-sign=3D<key-id> overrides commit.sign=
' '
+=09test_when_finished "test_might_fail git rebase --abort" &&
+=09test_config commit.sign true &&
+=09set_fake_editor &&
+=09FAKE_LINES=3D"edit 1" git rebase -i --gpg-sign=3D"\"S I Gner\"" HEAD^ \
+=09=09>out 2>err &&
+=09test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
+'
+
+test_expect_success 'valid author header after --root swap' '
+=09rebase_setup_and_clean author-header no-conflict-branch &&
+=09set_fake_editor &&
+=09git commit --amend --author=3D"Au ${SQ}thor <author@example.com>" --no-=
edit &&
+=09git cat-file commit HEAD | grep ^author >expected &&
+=09FAKE_LINES=3D"5 1" git rebase -i --root &&
+=09git cat-file commit HEAD^ | grep ^author >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'valid author header when author contains single quote=
' '
+=09rebase_setup_and_clean author-header no-conflict-branch &&
+=09set_fake_editor &&
+=09git commit --amend --author=3D"Au ${SQ}thor <author@example.com>" --no-=
edit &&
+=09git cat-file commit HEAD | grep ^author >expected &&
+=09FAKE_LINES=3D"2" git rebase -i HEAD~2 &&
+=09git cat-file commit HEAD | grep ^author >actual &&
+=09test_cmp expected actual
+'
+
+test_done
diff --git a/t/t4215-log-signconfig.sh b/t/t4215-log-signconfig.sh
new file mode 100755
index 000000000..a2f2342b0
--- /dev/null
+++ b/t/t4215-log-signconfig.sh
@@ -0,0 +1,1710 @@
+#!/bin/sh
+
+test_description=3D'git log'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+. "$TEST_DIRECTORY/lib-terminal.sh"
+
+test_expect_success setup '
+
+=09echo one >one &&
+=09git add one &&
+=09test_tick &&
+=09git commit -m initial &&
+
+=09echo ichi >one &&
+=09git add one &&
+=09test_tick &&
+=09git commit -m second &&
+
+=09git mv one ichi &&
+=09test_tick &&
+=09git commit -m third &&
+
+=09cp ichi ein &&
+=09git add ein &&
+=09test_tick &&
+=09git commit -m fourth &&
+
+=09mkdir a &&
+=09echo ni >a/two &&
+=09git add a/two &&
+=09test_tick &&
+=09git commit -m fifth  &&
+
+=09git rm a/two &&
+=09test_tick &&
+=09git commit -m sixth
+
+'
+
+printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
+test_expect_success 'pretty' '
+
+=09git log --pretty=3D"format:%s" > actual &&
+=09test_cmp expect actual
+'
+
+printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
+test_expect_success 'pretty (tformat)' '
+
+=09git log --pretty=3D"tformat:%s" > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'pretty (shortcut)' '
+
+=09git log --pretty=3D"%s" > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'format' '
+
+=09git log --format=3D"%s" > actual &&
+=09test_cmp expect actual
+'
+
+cat > expect << EOF
+ This is
+  the sixth
+  commit.
+ This is
+  the fifth
+  commit.
+EOF
+
+test_expect_success 'format %w(11,1,2)' '
+
+=09git log -2 --format=3D"%w(11,1,2)This is the %s commit." > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'format %w(,1,2)' '
+
+=09git log -2 --format=3D"%w(,1,2)This is%nthe %s%ncommit." > actual &&
+=09test_cmp expect actual
+'
+
+cat > expect << EOF
+804a787 sixth
+394ef78 fifth
+5d31159 fourth
+2fbe8c0 third
+f7dab8e second
+3a2fdcb initial
+EOF
+test_expect_success 'oneline' '
+
+=09git log --oneline > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'diff-filter=3DA' '
+
+=09git log --no-renames --pretty=3D"format:%s" --diff-filter=3DA HEAD > ac=
tual &&
+=09git log --no-renames --pretty=3D"format:%s" --diff-filter A HEAD > actu=
al-separate &&
+=09printf "fifth\nfourth\nthird\ninitial" > expect &&
+=09test_cmp expect actual &&
+=09test_cmp expect actual-separate
+
+'
+
+test_expect_success 'diff-filter=3DM' '
+
+=09actual=3D$(git log --pretty=3D"format:%s" --diff-filter=3DM HEAD) &&
+=09expect=3D$(echo second) &&
+=09verbose test "$actual" =3D "$expect"
+
+'
+
+test_expect_success 'diff-filter=3DD' '
+
+=09actual=3D$(git log --no-renames --pretty=3D"format:%s" --diff-filter=3D=
D HEAD) &&
+=09expect=3D$(echo sixth ; echo third) &&
+=09verbose test "$actual" =3D "$expect"
+
+'
+
+test_expect_success 'diff-filter=3DR' '
+
+=09actual=3D$(git log -M --pretty=3D"format:%s" --diff-filter=3DR HEAD) &&
+=09expect=3D$(echo third) &&
+=09verbose test "$actual" =3D "$expect"
+
+'
+
+test_expect_success 'diff-filter=3DC' '
+
+=09actual=3D$(git log -C -C --pretty=3D"format:%s" --diff-filter=3DC HEAD)=
 &&
+=09expect=3D$(echo fourth) &&
+=09verbose test "$actual" =3D "$expect"
+
+'
+
+test_expect_success 'git log --follow' '
+
+=09actual=3D$(git log --follow --pretty=3D"format:%s" ichi) &&
+=09expect=3D$(echo third ; echo second ; echo initial) &&
+=09verbose test "$actual" =3D "$expect"
+'
+
+test_expect_success 'git config log.follow works like --follow' '
+=09test_config log.follow true &&
+=09actual=3D$(git log --pretty=3D"format:%s" ichi) &&
+=09expect=3D$(echo third ; echo second ; echo initial) &&
+=09verbose test "$actual" =3D "$expect"
+'
+
+test_expect_success 'git config log.follow does not die with multiple path=
s' '
+=09test_config log.follow true &&
+=09git log --pretty=3D"format:%s" ichi ein
+'
+
+test_expect_success 'git config log.follow does not die with no paths' '
+=09test_config log.follow true &&
+=09git log --
+'
+
+test_expect_success 'git config log.follow is overridden by --no-follow' '
+=09test_config log.follow true &&
+=09actual=3D$(git log --no-follow --pretty=3D"format:%s" ichi) &&
+=09expect=3D"third" &&
+=09verbose test "$actual" =3D "$expect"
+'
+
+cat > expect << EOF
+804a787 sixth
+394ef78 fifth
+5d31159 fourth
+EOF
+test_expect_success 'git log --no-walk <commits> sorts by commit time' '
+=09git log --no-walk --oneline 5d31159 804a787 394ef78 > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'git log --no-walk=3Dsorted <commits> sorts by commit =
time' '
+=09git log --no-walk=3Dsorted --oneline 5d31159 804a787 394ef78 > actual &=
&
+=09test_cmp expect actual
+'
+
+cat > expect << EOF
+=3D=3D=3D 804a787 sixth
+=3D=3D=3D 394ef78 fifth
+=3D=3D=3D 5d31159 fourth
+EOF
+test_expect_success 'git log --line-prefix=3D"=3D=3D=3D " --no-walk <commi=
ts> sorts by commit time' '
+=09git log --line-prefix=3D"=3D=3D=3D " --no-walk --oneline 5d31159 804a78=
7 394ef78 > actual &&
+=09test_cmp expect actual
+'
+
+cat > expect << EOF
+5d31159 fourth
+804a787 sixth
+394ef78 fifth
+EOF
+test_expect_success 'git log --no-walk=3Dunsorted <commits> leaves list of=
 commits as given' '
+=09git log --no-walk=3Dunsorted --oneline 5d31159 804a787 394ef78 > actual=
 &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'git show <commits> leaves list of commits as given' '
+=09git show --oneline -s 5d31159 804a787 394ef78 > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'setup case sensitivity tests' '
+=09echo case >one &&
+=09test_tick &&
+=09git add one &&
+=09git commit -a -m Second
+'
+
+test_expect_success 'log --grep' '
+=09echo second >expect &&
+=09git log -1 --pretty=3D"tformat:%s" --grep=3Dsec >actual &&
+=09test_cmp expect actual
+'
+
+cat > expect << EOF
+second
+initial
+EOF
+test_expect_success 'log --invert-grep --grep' '
+=09# Fixed
+=09git -c grep.patternType=3Dfixed log --pretty=3D"tformat:%s" --invert-gr=
ep --grep=3Dth --grep=3DSec >actual &&
+=09test_cmp expect actual &&
+
+=09# POSIX basic
+=09git -c grep.patternType=3Dbasic log --pretty=3D"tformat:%s" --invert-gr=
ep --grep=3Dt[h] --grep=3DS[e]c >actual &&
+=09test_cmp expect actual &&
+
+=09# POSIX extended
+=09git -c grep.patternType=3Dbasic log --pretty=3D"tformat:%s" --invert-gr=
ep --grep=3Dt[h] --grep=3DS[e]c >actual &&
+=09test_cmp expect actual &&
+
+=09# PCRE
+=09if test_have_prereq PCRE
+=09then
+=09=09git -c grep.patternType=3Dperl log --pretty=3D"tformat:%s" --invert-=
grep --grep=3Dt[h] --grep=3DS[e]c >actual &&
+=09=09test_cmp expect actual
+=09fi
+'
+
+test_expect_success 'log --invert-grep --grep -i' '
+=09echo initial >expect &&
+
+=09# Fixed
+=09git -c grep.patternType=3Dfixed log --pretty=3D"tformat:%s" --invert-gr=
ep -i --grep=3Dth --grep=3DSec >actual &&
+=09test_cmp expect actual &&
+
+=09# POSIX basic
+=09git -c grep.patternType=3Dbasic log --pretty=3D"tformat:%s" --invert-gr=
ep -i --grep=3Dt[h] --grep=3DS[e]c >actual &&
+=09test_cmp expect actual &&
+
+=09# POSIX extended
+=09git -c grep.patternType=3Dextended log --pretty=3D"tformat:%s" --invert=
-grep -i --grep=3Dt[h] --grep=3DS[e]c >actual &&
+=09test_cmp expect actual &&
+
+=09# PCRE
+=09if test_have_prereq PCRE
+=09then
+=09=09git -c grep.patternType=3Dperl log --pretty=3D"tformat:%s" --invert-=
grep -i --grep=3Dt[h] --grep=3DS[e]c >actual &&
+=09=09test_cmp expect actual
+=09fi
+'
+
+test_expect_success 'log --grep option parsing' '
+=09echo second >expect &&
+=09git log -1 --pretty=3D"tformat:%s" --grep sec >actual &&
+=09test_cmp expect actual &&
+=09test_must_fail git log -1 --pretty=3D"tformat:%s" --grep
+'
+
+test_expect_success 'log -i --grep' '
+=09echo Second >expect &&
+=09git log -1 --pretty=3D"tformat:%s" -i --grep=3Dsec >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log --grep -i' '
+=09echo Second >expect &&
+
+=09# Fixed
+=09git log -1 --pretty=3D"tformat:%s" --grep=3Dsec -i >actual &&
+=09test_cmp expect actual &&
+
+=09# POSIX basic
+=09git -c grep.patternType=3Dbasic log -1 --pretty=3D"tformat:%s" --grep=
=3Ds[e]c -i >actual &&
+=09test_cmp expect actual &&
+
+=09# POSIX extended
+=09git -c grep.patternType=3Dextended log -1 --pretty=3D"tformat:%s" --gre=
p=3Ds[e]c -i >actual &&
+=09test_cmp expect actual &&
+
+=09# PCRE
+=09if test_have_prereq PCRE
+=09then
+=09=09git -c grep.patternType=3Dperl log -1 --pretty=3D"tformat:%s" --grep=
=3Ds[e]c -i >actual &&
+=09=09test_cmp expect actual
+=09fi
+'
+
+test_expect_success 'log -F -E --grep=3D<ere> uses ere' '
+=09echo second >expect &&
+=09# basic would need \(s\) to do the same
+=09git log -1 --pretty=3D"tformat:%s" -F -E --grep=3D"(s).c.nd" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success PCRE 'log -F -E --perl-regexp --grep=3D<pcre> uses PCR=
E' '
+=09test_when_finished "rm -rf num_commits" &&
+=09git init num_commits &&
+=09(
+=09=09cd num_commits &&
+=09=09test_commit 1d &&
+=09=09test_commit 2e
+=09) &&
+
+=09# In PCRE \d in [\d] is like saying "0-9", and matches the 2
+=09# in 2e...
+=09echo 2e >expect &&
+=09git -C num_commits log -1 --pretty=3D"tformat:%s" -F -E --perl-regexp -=
-grep=3D"[\d]" >actual &&
+=09test_cmp expect actual &&
+
+=09# ...in POSIX basic and extended it is the same as [d],
+=09# i.e. "d", which matches 1d, but does not match 2e.
+=09echo 1d >expect &&
+=09git -C num_commits log -1 --pretty=3D"tformat:%s" -F -E --grep=3D"[\d]"=
 >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log with grep.patternType configuration' '
+=09git -c grep.patterntype=3Dfixed \
+=09log -1 --pretty=3Dtformat:%s --grep=3Ds.c.nd >actual &&
+=09test_must_be_empty actual
+'
+
+test_expect_success 'log with grep.patternType configuration and command l=
ine' '
+=09echo second >expect &&
+=09git -c grep.patterntype=3Dfixed \
+=09log -1 --pretty=3Dtformat:%s --basic-regexp --grep=3Ds.c.nd >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success !FAIL_PREREQS 'log with various grep.patternType confi=
gurations & command-lines' '
+=09git init pattern-type &&
+=09(
+=09=09cd pattern-type &&
+=09=09test_commit 1 file A &&
+
+=09=09# The tagname is overridden here because creating a
+=09=09# tag called "(1|2)" as test_commit would otherwise
+=09=09# implicitly do would fail on e.g. MINGW.
+=09=09test_commit "(1|2)" file B 2 &&
+
+=09=09echo "(1|2)" >expect.fixed &&
+=09=09cp expect.fixed expect.basic &&
+=09=09cp expect.fixed expect.extended &&
+=09=09cp expect.fixed expect.perl &&
+
+=09=09# A strcmp-like match with fixed.
+=09=09git -c grep.patternType=3Dfixed log --pretty=3Dtformat:%s \
+=09=09=09--grep=3D"(1|2)" >actual.fixed &&
+
+=09=09# POSIX basic matches (, | and ) literally.
+=09=09git -c grep.patternType=3Dbasic log --pretty=3Dtformat:%s \
+=09=09=09--grep=3D"(.|.)" >actual.basic &&
+
+=09=09# POSIX extended needs to have | escaped to match it
+=09=09# literally, whereas under basic this is the same as
+=09=09# (|2), i.e. it would also match "1". This test checks
+=09=09# for extended by asserting that it is not matching
+=09=09# what basic would match.
+=09=09git -c grep.patternType=3Dextended log --pretty=3Dtformat:%s \
+=09=09=09--grep=3D"\|2" >actual.extended &&
+=09=09if test_have_prereq PCRE
+=09=09then
+=09=09=09# Only PCRE would match [\d]\| with only
+=09=09=09# "(1|2)" due to [\d]. POSIX basic would match
+=09=09=09# both it and "1" since similarly to the
+=09=09=09# extended match above it is the same as
+=09=09=09# \([\d]\|\). POSIX extended would
+=09=09=09# match neither.
+=09=09=09git -c grep.patternType=3Dperl log --pretty=3Dtformat:%s \
+=09=09=09=09--grep=3D"[\d]\|" >actual.perl &&
+=09=09=09test_cmp expect.perl actual.perl
+=09=09fi &&
+=09=09test_cmp expect.fixed actual.fixed &&
+=09=09test_cmp expect.basic actual.basic &&
+=09=09test_cmp expect.extended actual.extended &&
+
+=09=09git log --pretty=3Dtformat:%s -F \
+=09=09=09--grep=3D"(1|2)" >actual.fixed.short-arg &&
+=09=09git log --pretty=3Dtformat:%s -E \
+=09=09=09--grep=3D"\|2" >actual.extended.short-arg &&
+=09=09if test_have_prereq PCRE
+=09=09then
+=09=09=09git log --pretty=3Dtformat:%s -P \
+=09=09=09=09--grep=3D"[\d]\|" >actual.perl.short-arg
+=09=09else
+=09=09=09test_must_fail git log -P \
+=09=09=09=09--grep=3D"[\d]\|"
+=09=09fi &&
+=09=09test_cmp expect.fixed actual.fixed.short-arg &&
+=09=09test_cmp expect.extended actual.extended.short-arg &&
+=09=09if test_have_prereq PCRE
+=09=09then
+=09=09=09test_cmp expect.perl actual.perl.short-arg
+=09=09fi &&
+
+=09=09git log --pretty=3Dtformat:%s --fixed-strings \
+=09=09=09--grep=3D"(1|2)" >actual.fixed.long-arg &&
+=09=09git log --pretty=3Dtformat:%s --basic-regexp \
+=09=09=09--grep=3D"(.|.)" >actual.basic.long-arg &&
+=09=09git log --pretty=3Dtformat:%s --extended-regexp \
+=09=09=09--grep=3D"\|2" >actual.extended.long-arg &&
+=09=09if test_have_prereq PCRE
+=09=09then
+=09=09=09git log --pretty=3Dtformat:%s --perl-regexp \
+=09=09=09=09--grep=3D"[\d]\|" >actual.perl.long-arg &&
+=09=09=09test_cmp expect.perl actual.perl.long-arg
+=09=09else
+=09=09=09test_must_fail git log --perl-regexp \
+=09=09=09=09--grep=3D"[\d]\|"
+=09=09fi &&
+=09=09test_cmp expect.fixed actual.fixed.long-arg &&
+=09=09test_cmp expect.basic actual.basic.long-arg &&
+=09=09test_cmp expect.extended actual.extended.long-arg
+=09)
+'
+
+cat > expect <<EOF
+* Second
+* sixth
+* fifth
+* fourth
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'simple log --graph' '
+=09git log --graph --pretty=3Dtformat:%s >actual &&
+=09test_cmp expect actual
+'
+
+cat > expect <<EOF
+123 * Second
+123 * sixth
+123 * fifth
+123 * fourth
+123 * third
+123 * second
+123 * initial
+EOF
+
+test_expect_success 'simple log --graph --line-prefix=3D"123 "' '
+=09git log --graph --line-prefix=3D"123 " --pretty=3Dtformat:%s >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'set up merge history' '
+=09git checkout -b side HEAD~4 &&
+=09test_commit side-1 1 1 &&
+=09test_commit side-2 2 2 &&
+=09git checkout master &&
+=09git merge side
+'
+
+cat > expect <<\EOF
+*   Merge branch 'side'
+|\
+| * side-2
+| * side-1
+* | Second
+* | sixth
+* | fifth
+* | fourth
+|/
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge' '
+=09git log --graph --date-order --pretty=3Dtformat:%s |
+=09=09sed "s/ *\$//" >actual &&
+=09test_cmp expect actual
+'
+
+cat > expect <<\EOF
+| | | *   Merge branch 'side'
+| | | |\
+| | | | * side-2
+| | | | * side-1
+| | | * | Second
+| | | * | sixth
+| | | * | fifth
+| | | * | fourth
+| | | |/
+| | | * third
+| | | * second
+| | | * initial
+EOF
+
+test_expect_success 'log --graph --line-prefix=3D"| | | " with merge' '
+=09git log --line-prefix=3D"| | | " --graph --date-order --pretty=3Dtforma=
t:%s |
+=09=09sed "s/ *\$//" >actual &&
+=09test_cmp expect actual
+'
+
+cat > expect.colors <<\EOF
+*   Merge branch 'side'
+<BLUE>|<RESET><CYAN>\<RESET>
+<BLUE>|<RESET> * side-2
+<BLUE>|<RESET> * side-1
+* <CYAN>|<RESET> Second
+* <CYAN>|<RESET> sixth
+* <CYAN>|<RESET> fifth
+* <CYAN>|<RESET> fourth
+<CYAN>|<RESET><CYAN>/<RESET>
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge with log.graphColors' '
+=09test_config log.graphColors " blue,invalid-color, cyan, red  , " &&
+=09git log --color=3Dalways --graph --date-order --pretty=3Dtformat:%s |
+=09=09test_decode_color | sed "s/ *\$//" >actual &&
+=09test_cmp expect.colors actual
+'
+
+test_expect_success 'log --raw --graph -m with merge' '
+=09git log --raw --graph --oneline -m master | head -n 500 >actual &&
+=09grep "initial" actual
+'
+
+test_expect_success 'diff-tree --graph' '
+=09git diff-tree --graph master^ | head -n 500 >actual &&
+=09grep "one" actual
+'
+
+cat > expect <<\EOF
+*   commit master
+|\  Merge: A B
+| | Author: A U Thor <author@example.com>
+| |
+| |     Merge branch 'side'
+| |
+| * commit tags/side-2
+| | Author: A U Thor <author@example.com>
+| |
+| |     side-2
+| |
+| * commit tags/side-1
+| | Author: A U Thor <author@example.com>
+| |
+| |     side-1
+| |
+* | commit master~1
+| | Author: A U Thor <author@example.com>
+| |
+| |     Second
+| |
+* | commit master~2
+| | Author: A U Thor <author@example.com>
+| |
+| |     sixth
+| |
+* | commit master~3
+| | Author: A U Thor <author@example.com>
+| |
+| |     fifth
+| |
+* | commit master~4
+|/  Author: A U Thor <author@example.com>
+|
+|       fourth
+|
+* commit tags/side-1~1
+| Author: A U Thor <author@example.com>
+|
+|     third
+|
+* commit tags/side-1~2
+| Author: A U Thor <author@example.com>
+|
+|     second
+|
+* commit tags/side-1~3
+  Author: A U Thor <author@example.com>
+
+      initial
+EOF
+
+test_expect_success 'log --graph with full output' '
+=09git log --graph --date-order --pretty=3Dshort |
+=09=09git name-rev --name-only --stdin |
+=09=09sed "s/Merge:.*/Merge: A B/;s/ *\$//" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'set up more tangled history' '
+=09git checkout -b tangle HEAD~6 &&
+=09test_commit tangle-a tangle-a a &&
+=09git merge master~3 &&
+=09git merge side~1 &&
+=09git checkout master &&
+=09git merge tangle &&
+=09git checkout -b reach &&
+=09test_commit reach &&
+=09git checkout master &&
+=09git checkout -b octopus-a &&
+=09test_commit octopus-a &&
+=09git checkout master &&
+=09git checkout -b octopus-b &&
+=09test_commit octopus-b &&
+=09git checkout master &&
+=09test_commit seventh &&
+=09git merge octopus-a octopus-b &&
+=09git merge reach
+'
+
+cat > expect <<\EOF
+*   Merge tag 'reach'
+|\
+| \
+|  \
+*-. \   Merge tags 'octopus-a' and 'octopus-b'
+|\ \ \
+* | | | seventh
+| | * | octopus-b
+| |/ /
+|/| |
+| * | octopus-a
+|/ /
+| * reach
+|/
+*   Merge branch 'tangle'
+|\
+| *   Merge branch 'side' (early part) into tangle
+| |\
+| * \   Merge branch 'master' (early part) into tangle
+| |\ \
+| * | | tangle-a
+* | | |   Merge branch 'side'
+|\ \ \ \
+| * | | | side-2
+| | |_|/
+| |/| |
+| * | | side-1
+* | | | Second
+* | | | sixth
+| |_|/
+|/| |
+* | | fifth
+* | | fourth
+|/ /
+* | third
+|/
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge' '
+=09git log --graph --date-order --pretty=3Dtformat:%s |
+=09=09sed "s/ *\$//" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log.decorate configuration' '
+=09git log --oneline --no-decorate >expect.none &&
+=09git log --oneline --decorate >expect.short &&
+=09git log --oneline --decorate=3Dfull >expect.full &&
+
+=09echo "[log] decorate" >>.git/config &&
+=09git log --oneline >actual &&
+=09test_cmp expect.short actual &&
+
+=09test_config log.decorate true &&
+=09git log --oneline >actual &&
+=09test_cmp expect.short actual &&
+=09git log --oneline --decorate=3Dfull >actual &&
+=09test_cmp expect.full actual &&
+=09git log --oneline --decorate=3Dno >actual &&
+=09test_cmp expect.none actual &&
+
+=09test_config log.decorate no &&
+=09git log --oneline >actual &&
+=09test_cmp expect.none actual &&
+=09git log --oneline --decorate >actual &&
+=09test_cmp expect.short actual &&
+=09git log --oneline --decorate=3Dfull >actual &&
+=09test_cmp expect.full actual &&
+
+=09test_config log.decorate 1 &&
+=09git log --oneline >actual &&
+=09test_cmp expect.short actual &&
+=09git log --oneline --decorate=3Dfull >actual &&
+=09test_cmp expect.full actual &&
+=09git log --oneline --decorate=3Dno >actual &&
+=09test_cmp expect.none actual &&
+
+=09test_config log.decorate short &&
+=09git log --oneline >actual &&
+=09test_cmp expect.short actual &&
+=09git log --oneline --no-decorate >actual &&
+=09test_cmp expect.none actual &&
+=09git log --oneline --decorate=3Dfull >actual &&
+=09test_cmp expect.full actual &&
+
+=09test_config log.decorate full &&
+=09git log --oneline >actual &&
+=09test_cmp expect.full actual &&
+=09git log --oneline --no-decorate >actual &&
+=09test_cmp expect.none actual &&
+=09git log --oneline --decorate >actual &&
+=09test_cmp expect.short actual &&
+
+=09test_unconfig log.decorate &&
+=09git log --pretty=3Draw >expect.raw &&
+=09test_config log.decorate full &&
+=09git log --pretty=3Draw >actual &&
+=09test_cmp expect.raw actual
+
+'
+
+test_expect_success 'decorate-refs with glob' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh
+=09octopus-b (octopus-b)
+=09octopus-a (octopus-a)
+=09reach
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs=3D"heads/octopus*" >actual &&
+=09test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs without globs' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh
+=09octopus-b
+=09octopus-a
+=09reach (tag: reach)
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs=3D"tags/reach" >actual &&
+=09test_cmp expect.decorate actual
+'
+
+test_expect_success 'multiple decorate-refs' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh
+=09octopus-b (octopus-b)
+=09octopus-a (octopus-a)
+=09reach (tag: reach)
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs=3D"heads/octopus*" \
+=09=09--decorate-refs=3D"tags/reach" >actual &&
+    test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs-exclude with glob' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach (HEAD -> master)
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh (tag: seventh)
+=09octopus-b (tag: octopus-b)
+=09octopus-a (tag: octopus-a)
+=09reach (tag: reach, reach)
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs-exclude=3D"heads/octopus*" >actual &&
+=09test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs-exclude without globs' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach (HEAD -> master)
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh (tag: seventh)
+=09octopus-b (tag: octopus-b, octopus-b)
+=09octopus-a (tag: octopus-a, octopus-a)
+=09reach (reach)
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs-exclude=3D"tags/reach" >actual &&
+=09test_cmp expect.decorate actual
+'
+
+test_expect_success 'multiple decorate-refs-exclude' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach (HEAD -> master)
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh (tag: seventh)
+=09octopus-b (tag: octopus-b)
+=09octopus-a (tag: octopus-a)
+=09reach (reach)
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs-exclude=3D"heads/octopus*" \
+=09=09--decorate-refs-exclude=3D"tags/reach" >actual &&
+=09test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs and decorate-refs-exclude' '
+=09cat >expect.decorate <<-\EOF &&
+=09Merge-tag-reach (master)
+=09Merge-tags-octopus-a-and-octopus-b
+=09seventh
+=09octopus-b
+=09octopus-a
+=09reach (reach)
+=09EOF
+=09git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+=09=09--decorate-refs=3D"heads/*" \
+=09=09--decorate-refs-exclude=3D"heads/oc*" >actual &&
+=09test_cmp expect.decorate actual
+'
+
+test_expect_success 'log.decorate config parsing' '
+=09git log --oneline --decorate=3Dfull >expect.full &&
+=09git log --oneline --decorate=3Dshort >expect.short &&
+
+=09test_config log.decorate full &&
+=09test_config log.mailmap true &&
+=09git log --oneline >actual &&
+=09test_cmp expect.full actual &&
+=09git log --oneline --decorate=3Dshort >actual &&
+=09test_cmp expect.short actual
+'
+
+test_expect_success TTY 'log output on a TTY' '
+=09git log --color --oneline --decorate >expect.short &&
+
+=09test_terminal git log --oneline >actual &&
+=09test_cmp expect.short actual
+'
+
+test_expect_success 'reflog is expected format' '
+=09git log -g --abbrev-commit --pretty=3Doneline >expect &&
+=09git reflog >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'whatchanged is expected format' '
+=09git log --no-merges --raw >expect &&
+=09git whatchanged >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log.abbrevCommit configuration' '
+=09git log --abbrev-commit >expect.log.abbrev &&
+=09git log --no-abbrev-commit >expect.log.full &&
+=09git log --pretty=3Draw >expect.log.raw &&
+=09git reflog --abbrev-commit >expect.reflog.abbrev &&
+=09git reflog --no-abbrev-commit >expect.reflog.full &&
+=09git whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
+=09git whatchanged --no-abbrev-commit >expect.whatchanged.full &&
+
+=09test_config log.abbrevCommit true &&
+
+=09git log >actual &&
+=09test_cmp expect.log.abbrev actual &&
+=09git log --no-abbrev-commit >actual &&
+=09test_cmp expect.log.full actual &&
+
+=09git log --pretty=3Draw >actual &&
+=09test_cmp expect.log.raw actual &&
+
+=09git reflog >actual &&
+=09test_cmp expect.reflog.abbrev actual &&
+=09git reflog --no-abbrev-commit >actual &&
+=09test_cmp expect.reflog.full actual &&
+
+=09git whatchanged >actual &&
+=09test_cmp expect.whatchanged.abbrev actual &&
+=09git whatchanged --no-abbrev-commit >actual &&
+=09test_cmp expect.whatchanged.full actual
+'
+
+test_expect_success 'show added path under "--follow -M"' '
+=09# This tests for a regression introduced in v1.7.2-rc0~103^2~2
+=09test_create_repo regression &&
+=09(
+=09=09cd regression &&
+=09=09test_commit needs-another-commit &&
+=09=09test_commit foo.bar &&
+=09=09git log -M --follow -p foo.bar.t &&
+=09=09git log -M --follow --stat foo.bar.t &&
+=09=09git log -M --follow --name-only foo.bar.t
+=09)
+'
+
+test_expect_success 'git log -c --follow' '
+=09test_create_repo follow-c &&
+=09(
+=09=09cd follow-c &&
+=09=09test_commit initial file original &&
+=09=09git rm file &&
+=09=09test_commit rename file2 original &&
+=09=09git reset --hard initial &&
+=09=09test_commit modify file foo &&
+=09=09git merge -m merge rename &&
+=09=09git log -c --follow file2
+=09)
+'
+
+cat >expect <<\EOF
+*   commit COMMIT_OBJECT_NAME
+|\  Merge: MERGE_PARENTS
+| | Author: A U Thor <author@example.com>
+| |
+| |     Merge HEADS DESCRIPTION
+| |
+| * commit COMMIT_OBJECT_NAME
+| | Author: A U Thor <author@example.com>
+| |
+| |     reach
+| | ---
+| |  reach.t | 1 +
+| |  1 file changed, 1 insertion(+)
+| |
+| | diff --git a/reach.t b/reach.t
+| | new file mode 100644
+| | index 0000000..10c9591
+| | --- /dev/null
+| | +++ b/reach.t
+| | @@ -0,0 +1 @@
+| | +reach
+| |
+|  \
+*-. \   commit COMMIT_OBJECT_NAME
+|\ \ \  Merge: MERGE_PARENTS
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     Merge HEADS DESCRIPTION
+| | | |
+| | * | commit COMMIT_OBJECT_NAME
+| | |/  Author: A U Thor <author@example.com>
+| | |
+| | |       octopus-b
+| | |   ---
+| | |    octopus-b.t | 1 +
+| | |    1 file changed, 1 insertion(+)
+| | |
+| | |   diff --git a/octopus-b.t b/octopus-b.t
+| | |   new file mode 100644
+| | |   index 0000000..d5fcad0
+| | |   --- /dev/null
+| | |   +++ b/octopus-b.t
+| | |   @@ -0,0 +1 @@
+| | |   +octopus-b
+| | |
+| * | commit COMMIT_OBJECT_NAME
+| |/  Author: A U Thor <author@example.com>
+| |
+| |       octopus-a
+| |   ---
+| |    octopus-a.t | 1 +
+| |    1 file changed, 1 insertion(+)
+| |
+| |   diff --git a/octopus-a.t b/octopus-a.t
+| |   new file mode 100644
+| |   index 0000000..11ee015
+| |   --- /dev/null
+| |   +++ b/octopus-a.t
+| |   @@ -0,0 +1 @@
+| |   +octopus-a
+| |
+* | commit COMMIT_OBJECT_NAME
+|/  Author: A U Thor <author@example.com>
+|
+|       seventh
+|   ---
+|    seventh.t | 1 +
+|    1 file changed, 1 insertion(+)
+|
+|   diff --git a/seventh.t b/seventh.t
+|   new file mode 100644
+|   index 0000000..9744ffc
+|   --- /dev/null
+|   +++ b/seventh.t
+|   @@ -0,0 +1 @@
+|   +seventh
+|
+*   commit COMMIT_OBJECT_NAME
+|\  Merge: MERGE_PARENTS
+| | Author: A U Thor <author@example.com>
+| |
+| |     Merge branch 'tangle'
+| |
+| *   commit COMMIT_OBJECT_NAME
+| |\  Merge: MERGE_PARENTS
+| | | Author: A U Thor <author@example.com>
+| | |
+| | |     Merge branch 'side' (early part) into tangle
+| | |
+| * |   commit COMMIT_OBJECT_NAME
+| |\ \  Merge: MERGE_PARENTS
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     Merge branch 'master' (early part) into tangle
+| | | |
+| * | | commit COMMIT_OBJECT_NAME
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     tangle-a
+| | | | ---
+| | | |  tangle-a | 1 +
+| | | |  1 file changed, 1 insertion(+)
+| | | |
+| | | | diff --git a/tangle-a b/tangle-a
+| | | | new file mode 100644
+| | | | index 0000000..7898192
+| | | | --- /dev/null
+| | | | +++ b/tangle-a
+| | | | @@ -0,0 +1 @@
+| | | | +a
+| | | |
+* | | |   commit COMMIT_OBJECT_NAME
+|\ \ \ \  Merge: MERGE_PARENTS
+| | | | | Author: A U Thor <author@example.com>
+| | | | |
+| | | | |     Merge branch 'side'
+| | | | |
+| * | | | commit COMMIT_OBJECT_NAME
+| | |_|/  Author: A U Thor <author@example.com>
+| |/| |
+| | | |       side-2
+| | | |   ---
+| | | |    2 | 1 +
+| | | |    1 file changed, 1 insertion(+)
+| | | |
+| | | |   diff --git a/2 b/2
+| | | |   new file mode 100644
+| | | |   index 0000000..0cfbf08
+| | | |   --- /dev/null
+| | | |   +++ b/2
+| | | |   @@ -0,0 +1 @@
+| | | |   +2
+| | | |
+| * | | commit COMMIT_OBJECT_NAME
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     side-1
+| | | | ---
+| | | |  1 | 1 +
+| | | |  1 file changed, 1 insertion(+)
+| | | |
+| | | | diff --git a/1 b/1
+| | | | new file mode 100644
+| | | | index 0000000..d00491f
+| | | | --- /dev/null
+| | | | +++ b/1
+| | | | @@ -0,0 +1 @@
+| | | | +1
+| | | |
+* | | | commit COMMIT_OBJECT_NAME
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     Second
+| | | | ---
+| | | |  one | 1 +
+| | | |  1 file changed, 1 insertion(+)
+| | | |
+| | | | diff --git a/one b/one
+| | | | new file mode 100644
+| | | | index 0000000..9a33383
+| | | | --- /dev/null
+| | | | +++ b/one
+| | | | @@ -0,0 +1 @@
+| | | | +case
+| | | |
+* | | | commit COMMIT_OBJECT_NAME
+| |_|/  Author: A U Thor <author@example.com>
+|/| |
+| | |       sixth
+| | |   ---
+| | |    a/two | 1 -
+| | |    1 file changed, 1 deletion(-)
+| | |
+| | |   diff --git a/a/two b/a/two
+| | |   deleted file mode 100644
+| | |   index 9245af5..0000000
+| | |   --- a/a/two
+| | |   +++ /dev/null
+| | |   @@ -1 +0,0 @@
+| | |   -ni
+| | |
+* | | commit COMMIT_OBJECT_NAME
+| | | Author: A U Thor <author@example.com>
+| | |
+| | |     fifth
+| | | ---
+| | |  a/two | 1 +
+| | |  1 file changed, 1 insertion(+)
+| | |
+| | | diff --git a/a/two b/a/two
+| | | new file mode 100644
+| | | index 0000000..9245af5
+| | | --- /dev/null
+| | | +++ b/a/two
+| | | @@ -0,0 +1 @@
+| | | +ni
+| | |
+* | | commit COMMIT_OBJECT_NAME
+|/ /  Author: A U Thor <author@example.com>
+| |
+| |       fourth
+| |   ---
+| |    ein | 1 +
+| |    1 file changed, 1 insertion(+)
+| |
+| |   diff --git a/ein b/ein
+| |   new file mode 100644
+| |   index 0000000..9d7e69f
+| |   --- /dev/null
+| |   +++ b/ein
+| |   @@ -0,0 +1 @@
+| |   +ichi
+| |
+* | commit COMMIT_OBJECT_NAME
+|/  Author: A U Thor <author@example.com>
+|
+|       third
+|   ---
+|    ichi | 1 +
+|    one  | 1 -
+|    2 files changed, 1 insertion(+), 1 deletion(-)
+|
+|   diff --git a/ichi b/ichi
+|   new file mode 100644
+|   index 0000000..9d7e69f
+|   --- /dev/null
+|   +++ b/ichi
+|   @@ -0,0 +1 @@
+|   +ichi
+|   diff --git a/one b/one
+|   deleted file mode 100644
+|   index 9d7e69f..0000000
+|   --- a/one
+|   +++ /dev/null
+|   @@ -1 +0,0 @@
+|   -ichi
+|
+* commit COMMIT_OBJECT_NAME
+| Author: A U Thor <author@example.com>
+|
+|     second
+| ---
+|  one | 2 +-
+|  1 file changed, 1 insertion(+), 1 deletion(-)
+|
+| diff --git a/one b/one
+| index 5626abf..9d7e69f 100644
+| --- a/one
+| +++ b/one
+| @@ -1 +1 @@
+| -one
+| +ichi
+|
+* commit COMMIT_OBJECT_NAME
+  Author: A U Thor <author@example.com>
+
+      initial
+  ---
+   one | 1 +
+   1 file changed, 1 insertion(+)
+
+  diff --git a/one b/one
+  new file mode 100644
+  index 0000000..5626abf
+  --- /dev/null
+  +++ b/one
+  @@ -0,0 +1 @@
+  +one
+EOF
+
+sanitize_output () {
+=09sed -e 's/ *$//' \
+=09    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
+=09    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
+=09    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
+=09    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
+=09    -e 's/, 0 deletions(-)//' \
+=09    -e 's/, 0 insertions(+)//' \
+=09    -e 's/ 1 files changed, / 1 file changed, /' \
+=09    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
+=09    -e 's/, 1 insertions(+)/, 1 insertion(+)/'
+}
+
+test_expect_success 'log --graph with diff and stats' '
+=09git log --no-renames --graph --pretty=3Dshort --stat -p >actual &&
+=09sanitize_output >actual.sanitized <actual &&
+=09test_i18ncmp expect actual.sanitized
+'
+
+cat >expect <<\EOF
+*** *   commit COMMIT_OBJECT_NAME
+*** |\  Merge: MERGE_PARENTS
+*** | | Author: A U Thor <author@example.com>
+*** | |
+*** | |     Merge HEADS DESCRIPTION
+*** | |
+*** | * commit COMMIT_OBJECT_NAME
+*** | | Author: A U Thor <author@example.com>
+*** | |
+*** | |     reach
+*** | | ---
+*** | |  reach.t | 1 +
+*** | |  1 file changed, 1 insertion(+)
+*** | |
+*** | | diff --git a/reach.t b/reach.t
+*** | | new file mode 100644
+*** | | index 0000000..10c9591
+*** | | --- /dev/null
+*** | | +++ b/reach.t
+*** | | @@ -0,0 +1 @@
+*** | | +reach
+*** | |
+*** |  \
+*** *-. \   commit COMMIT_OBJECT_NAME
+*** |\ \ \  Merge: MERGE_PARENTS
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     Merge HEADS DESCRIPTION
+*** | | | |
+*** | | * | commit COMMIT_OBJECT_NAME
+*** | | |/  Author: A U Thor <author@example.com>
+*** | | |
+*** | | |       octopus-b
+*** | | |   ---
+*** | | |    octopus-b.t | 1 +
+*** | | |    1 file changed, 1 insertion(+)
+*** | | |
+*** | | |   diff --git a/octopus-b.t b/octopus-b.t
+*** | | |   new file mode 100644
+*** | | |   index 0000000..d5fcad0
+*** | | |   --- /dev/null
+*** | | |   +++ b/octopus-b.t
+*** | | |   @@ -0,0 +1 @@
+*** | | |   +octopus-b
+*** | | |
+*** | * | commit COMMIT_OBJECT_NAME
+*** | |/  Author: A U Thor <author@example.com>
+*** | |
+*** | |       octopus-a
+*** | |   ---
+*** | |    octopus-a.t | 1 +
+*** | |    1 file changed, 1 insertion(+)
+*** | |
+*** | |   diff --git a/octopus-a.t b/octopus-a.t
+*** | |   new file mode 100644
+*** | |   index 0000000..11ee015
+*** | |   --- /dev/null
+*** | |   +++ b/octopus-a.t
+*** | |   @@ -0,0 +1 @@
+*** | |   +octopus-a
+*** | |
+*** * | commit COMMIT_OBJECT_NAME
+*** |/  Author: A U Thor <author@example.com>
+*** |
+*** |       seventh
+*** |   ---
+*** |    seventh.t | 1 +
+*** |    1 file changed, 1 insertion(+)
+*** |
+*** |   diff --git a/seventh.t b/seventh.t
+*** |   new file mode 100644
+*** |   index 0000000..9744ffc
+*** |   --- /dev/null
+*** |   +++ b/seventh.t
+*** |   @@ -0,0 +1 @@
+*** |   +seventh
+*** |
+*** *   commit COMMIT_OBJECT_NAME
+*** |\  Merge: MERGE_PARENTS
+*** | | Author: A U Thor <author@example.com>
+*** | |
+*** | |     Merge branch 'tangle'
+*** | |
+*** | *   commit COMMIT_OBJECT_NAME
+*** | |\  Merge: MERGE_PARENTS
+*** | | | Author: A U Thor <author@example.com>
+*** | | |
+*** | | |     Merge branch 'side' (early part) into tangle
+*** | | |
+*** | * |   commit COMMIT_OBJECT_NAME
+*** | |\ \  Merge: MERGE_PARENTS
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     Merge branch 'master' (early part) into tangle
+*** | | | |
+*** | * | | commit COMMIT_OBJECT_NAME
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     tangle-a
+*** | | | | ---
+*** | | | |  tangle-a | 1 +
+*** | | | |  1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | | diff --git a/tangle-a b/tangle-a
+*** | | | | new file mode 100644
+*** | | | | index 0000000..7898192
+*** | | | | --- /dev/null
+*** | | | | +++ b/tangle-a
+*** | | | | @@ -0,0 +1 @@
+*** | | | | +a
+*** | | | |
+*** * | | |   commit COMMIT_OBJECT_NAME
+*** |\ \ \ \  Merge: MERGE_PARENTS
+*** | | | | | Author: A U Thor <author@example.com>
+*** | | | | |
+*** | | | | |     Merge branch 'side'
+*** | | | | |
+*** | * | | | commit COMMIT_OBJECT_NAME
+*** | | |_|/  Author: A U Thor <author@example.com>
+*** | |/| |
+*** | | | |       side-2
+*** | | | |   ---
+*** | | | |    2 | 1 +
+*** | | | |    1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | |   diff --git a/2 b/2
+*** | | | |   new file mode 100644
+*** | | | |   index 0000000..0cfbf08
+*** | | | |   --- /dev/null
+*** | | | |   +++ b/2
+*** | | | |   @@ -0,0 +1 @@
+*** | | | |   +2
+*** | | | |
+*** | * | | commit COMMIT_OBJECT_NAME
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     side-1
+*** | | | | ---
+*** | | | |  1 | 1 +
+*** | | | |  1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | | diff --git a/1 b/1
+*** | | | | new file mode 100644
+*** | | | | index 0000000..d00491f
+*** | | | | --- /dev/null
+*** | | | | +++ b/1
+*** | | | | @@ -0,0 +1 @@
+*** | | | | +1
+*** | | | |
+*** * | | | commit COMMIT_OBJECT_NAME
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     Second
+*** | | | | ---
+*** | | | |  one | 1 +
+*** | | | |  1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | | diff --git a/one b/one
+*** | | | | new file mode 100644
+*** | | | | index 0000000..9a33383
+*** | | | | --- /dev/null
+*** | | | | +++ b/one
+*** | | | | @@ -0,0 +1 @@
+*** | | | | +case
+*** | | | |
+*** * | | | commit COMMIT_OBJECT_NAME
+*** | |_|/  Author: A U Thor <author@example.com>
+*** |/| |
+*** | | |       sixth
+*** | | |   ---
+*** | | |    a/two | 1 -
+*** | | |    1 file changed, 1 deletion(-)
+*** | | |
+*** | | |   diff --git a/a/two b/a/two
+*** | | |   deleted file mode 100644
+*** | | |   index 9245af5..0000000
+*** | | |   --- a/a/two
+*** | | |   +++ /dev/null
+*** | | |   @@ -1 +0,0 @@
+*** | | |   -ni
+*** | | |
+*** * | | commit COMMIT_OBJECT_NAME
+*** | | | Author: A U Thor <author@example.com>
+*** | | |
+*** | | |     fifth
+*** | | | ---
+*** | | |  a/two | 1 +
+*** | | |  1 file changed, 1 insertion(+)
+*** | | |
+*** | | | diff --git a/a/two b/a/two
+*** | | | new file mode 100644
+*** | | | index 0000000..9245af5
+*** | | | --- /dev/null
+*** | | | +++ b/a/two
+*** | | | @@ -0,0 +1 @@
+*** | | | +ni
+*** | | |
+*** * | | commit COMMIT_OBJECT_NAME
+*** |/ /  Author: A U Thor <author@example.com>
+*** | |
+*** | |       fourth
+*** | |   ---
+*** | |    ein | 1 +
+*** | |    1 file changed, 1 insertion(+)
+*** | |
+*** | |   diff --git a/ein b/ein
+*** | |   new file mode 100644
+*** | |   index 0000000..9d7e69f
+*** | |   --- /dev/null
+*** | |   +++ b/ein
+*** | |   @@ -0,0 +1 @@
+*** | |   +ichi
+*** | |
+*** * | commit COMMIT_OBJECT_NAME
+*** |/  Author: A U Thor <author@example.com>
+*** |
+*** |       third
+*** |   ---
+*** |    ichi | 1 +
+*** |    one  | 1 -
+*** |    2 files changed, 1 insertion(+), 1 deletion(-)
+*** |
+*** |   diff --git a/ichi b/ichi
+*** |   new file mode 100644
+*** |   index 0000000..9d7e69f
+*** |   --- /dev/null
+*** |   +++ b/ichi
+*** |   @@ -0,0 +1 @@
+*** |   +ichi
+*** |   diff --git a/one b/one
+*** |   deleted file mode 100644
+*** |   index 9d7e69f..0000000
+*** |   --- a/one
+*** |   +++ /dev/null
+*** |   @@ -1 +0,0 @@
+*** |   -ichi
+*** |
+*** * commit COMMIT_OBJECT_NAME
+*** | Author: A U Thor <author@example.com>
+*** |
+*** |     second
+*** | ---
+*** |  one | 2 +-
+*** |  1 file changed, 1 insertion(+), 1 deletion(-)
+*** |
+*** | diff --git a/one b/one
+*** | index 5626abf..9d7e69f 100644
+*** | --- a/one
+*** | +++ b/one
+*** | @@ -1 +1 @@
+*** | -one
+*** | +ichi
+*** |
+*** * commit COMMIT_OBJECT_NAME
+***   Author: A U Thor <author@example.com>
+***
+***       initial
+***   ---
+***    one | 1 +
+***    1 file changed, 1 insertion(+)
+***
+***   diff --git a/one b/one
+***   new file mode 100644
+***   index 0000000..5626abf
+***   --- /dev/null
+***   +++ b/one
+***   @@ -0,0 +1 @@
+***   +one
+EOF
+
+test_expect_success 'log --line-prefix=3D"*** " --graph with diff and stat=
s' '
+=09git log --line-prefix=3D"*** " --no-renames --graph --pretty=3Dshort --=
stat -p >actual &&
+=09sanitize_output >actual.sanitized <actual &&
+=09test_i18ncmp expect actual.sanitized
+'
+
+cat >expect <<-\EOF
+* reach
+|
+| A=09reach.t
+* Merge branch 'tangle'
+*   Merge branch 'side'
+|\
+| * side-2
+|
+|   A=092
+* Second
+|
+| A=09one
+* sixth
+
+  D=09a/two
+EOF
+
+test_expect_success 'log --graph with --name-status' '
+=09git log --graph --format=3D%s --name-status tangle..reach >actual &&
+=09sanitize_output <actual >actual.sanitized &&
+=09test_cmp expect actual.sanitized
+'
+
+cat >expect <<-\EOF
+* reach
+|
+| reach.t
+* Merge branch 'tangle'
+*   Merge branch 'side'
+|\
+| * side-2
+|
+|   2
+* Second
+|
+| one
+* sixth
+
+  a/two
+EOF
+
+test_expect_success 'log --graph with --name-only' '
+=09git log --graph --format=3D%s --name-only tangle..reach >actual &&
+=09sanitize_output <actual >actual.sanitized &&
+=09test_cmp expect actual.sanitized
+'
+
+test_expect_success 'dotdot is a parent directory' '
+=09mkdir -p a/b &&
+=09( echo sixth && echo fifth ) >expect &&
+=09( cd a/b && git log --format=3D%s .. ) >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'setup signed branch' '
+=09test_when_finished "git reset --hard && git checkout master" &&
+=09git checkout -b signed master &&
+=09echo foo >foo &&
+=09git add foo &&
+=09git commit -S -m signed_commit
+'
+
+test_expect_success GPGSM 'setup signed branch x509' '
+=09test_when_finished "git reset --hard && git checkout master" &&
+=09git checkout -b signed-x509 master &&
+=09echo foo >foo &&
+=09git add foo &&
+=09test_config signing.default x509 &&
+=09test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+=09git commit -S -m signed_commit
+'
+
+test_expect_success GPG 'log --graph --show-signature' '
+=09git log --graph --show-signature -n1 signed >actual &&
+=09grep "^| gpg: Signature made" actual &&
+=09grep "^| gpg: Good signature" actual
+'
+
+test_expect_success GPGSM 'log --graph --show-signature x509' '
+=09git log --graph --show-signature -n1 signed-x509 >actual &&
+=09grep "^| gpgsm: Signature made" actual &&
+=09grep "^| gpgsm: Good signature" actual
+'
+
+test_expect_success GPG 'log --graph --show-signature for merged tag' '
+=09test_when_finished "git reset --hard && git checkout master" &&
+=09git checkout -b plain master &&
+=09echo aaa >bar &&
+=09git add bar &&
+=09git commit -m bar_commit &&
+=09git checkout -b tagged master &&
+=09echo bbb >baz &&
+=09git add baz &&
+=09git commit -m baz_commit &&
+=09git tag -s -m signed_tag_msg signed_tag &&
+=09git checkout plain &&
+=09git merge --no-ff -m msg signed_tag &&
+=09git log --graph --show-signature -n1 plain >actual &&
+=09grep "^|\\\  merged tag" actual &&
+=09grep "^| | gpg: Signature made" actual &&
+=09grep "^| | gpg: Good signature" actual
+'
+
+test_expect_success GPGSM 'log --graph --show-signature for merged tag x50=
9' '
+=09test_when_finished "git reset --hard && git checkout master" &&
+=09test_config signing.default x509 &&
+=09test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+=09git checkout -b plain-x509 master &&
+=09echo aaa >bar &&
+=09git add bar &&
+=09git commit -m bar_commit &&
+=09git checkout -b tagged-x509 master &&
+=09echo bbb >baz &&
+=09git add baz &&
+=09git commit -m baz_commit &&
+=09git tag -s -m signed_tag_msg signed_tag_x509 &&
+=09git checkout plain-x509 &&
+=09git merge --no-ff -m msg signed_tag_x509 &&
+=09git log --graph --show-signature -n1 plain-x509 >actual &&
+=09grep "^|\\\  merged tag" actual &&
+=09grep "^| | gpgsm: Signature made" actual &&
+=09grep "^| | gpgsm: Good signature" actual
+'
+
+test_expect_success GPG '--no-show-signature overrides --show-signature' '
+=09git log -1 --show-signature --no-show-signature signed >actual &&
+=09! grep "^gpg:" actual
+'
+
+test_expect_success GPG 'log.showsignature=3Dtrue behaves like --show-sign=
ature' '
+=09test_config log.showsignature true &&
+=09git log -1 signed >actual &&
+=09grep "gpg: Signature made" actual &&
+=09grep "gpg: Good signature" actual
+'
+
+test_expect_success GPG '--no-show-signature overrides log.showsignature=
=3Dtrue' '
+=09test_config log.showsignature true &&
+=09git log -1 --no-show-signature signed >actual &&
+=09! grep "^gpg:" actual
+'
+
+test_expect_success GPG '--show-signature overrides log.showsignature=3Dfa=
lse' '
+=09test_config log.showsignature false &&
+=09git log -1 --show-signature signed >actual &&
+=09grep "gpg: Signature made" actual &&
+=09grep "gpg: Good signature" actual
+'
+
+test_expect_success 'log --graph --no-walk is forbidden' '
+=09test_must_fail git log --graph --no-walk
+'
+
+test_expect_success 'log diagnoses bogus HEAD' '
+=09git init empty &&
+=09test_must_fail git -C empty log 2>stderr &&
+=09test_i18ngrep does.not.have.any.commits stderr &&
+=09echo 1234abcd >empty/.git/refs/heads/master &&
+=09test_must_fail git -C empty log 2>stderr &&
+=09test_i18ngrep broken stderr &&
+=09echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
+=09test_must_fail git -C empty log 2>stderr &&
+=09test_i18ngrep broken stderr &&
+=09test_must_fail git -C empty log --default totally-bogus 2>stderr &&
+=09test_i18ngrep broken stderr
+'
+
+test_expect_success 'log does not default to HEAD when rev input is given'=
 '
+=09git log --branches=3Ddoes-not-exist >actual &&
+=09test_must_be_empty actual
+'
+
+test_expect_success 'set up --source tests' '
+=09git checkout --orphan source-a &&
+=09test_commit one &&
+=09test_commit two &&
+=09git checkout -b source-b HEAD^ &&
+=09test_commit three
+'
+
+test_expect_success 'log --source paints branch names' '
+=09cat >expect <<-\EOF &&
+=0909e12a9=09source-b three
+=098e393e1=09source-a two
+=091ac6c77=09source-b one
+=09EOF
+=09git log --oneline --source source-a source-b >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log --source paints tag names' '
+=09git tag -m tagged source-tag &&
+=09cat >expect <<-\EOF &&
+=0909e12a9=09source-tag three
+=098e393e1=09source-a two
+=091ac6c77=09source-tag one
+=09EOF
+=09git log --oneline --source source-tag source-a >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log --source paints symmetric ranges' '
+=09cat >expect <<-\EOF &&
+=0909e12a9=09source-b three
+=098e393e1=09source-a two
+=09EOF
+=09git log --oneline --source source-a...source-b >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--exclude-promisor-objects does not BUG-crash' '
+=09test_must_fail git log --exclude-promisor-objects source-a
+'
+
+test_done
diff --git a/t/t5548-push-signed-signconfig.sh b/t/t5548-push-signed-signco=
nfig.sh
new file mode 100755
index 000000000..f39b2e9dc
--- /dev/null
+++ b/t/t5548-push-signed-signconfig.sh
@@ -0,0 +1,276 @@
+#!/bin/sh
+
+test_description=3D'signed push'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+
+prepare_dst () {
+=09rm -fr dst &&
+=09test_create_repo dst &&
+
+=09git push dst master:noop master:ff master:noff
+}
+
+test_expect_success setup '
+=09# master, ff and noff branches pointing at the same commit
+=09test_tick &&
+=09git commit --allow-empty -m initial &&
+
+=09git checkout -b noop &&
+=09git checkout -b ff &&
+=09git checkout -b noff &&
+
+=09# noop stays the same, ff advances, noff rewrites
+=09test_tick &&
+=09git commit --allow-empty --amend -m rewritten &&
+=09git checkout ff &&
+
+=09test_tick &&
+=09git commit --allow-empty -m second
+'
+
+test_expect_success 'unsigned push does not send push certificate' '
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09write_script dst/.git/hooks/post-receive <<-\EOF &&
+=09# discard the update list
+=09cat >/dev/null
+=09# record the push certificate
+=09if test -n "${GIT_PUSH_CERT-}"
+=09then
+=09=09git cat-file blob $GIT_PUSH_CERT >../push-cert
+=09fi
+=09EOF
+
+=09git push dst noop ff +noff &&
+=09! test -f dst/push-cert
+'
+
+test_expect_success 'talking with a receiver without push certificate supp=
ort' '
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09write_script dst/.git/hooks/post-receive <<-\EOF &&
+=09# discard the update list
+=09cat >/dev/null
+=09# record the push certificate
+=09if test -n "${GIT_PUSH_CERT-}"
+=09then
+=09=09git cat-file blob $GIT_PUSH_CERT >../push-cert
+=09fi
+=09EOF
+
+=09git push dst noop ff +noff &&
+=09! test -f dst/push-cert
+'
+
+test_expect_success 'push --signed fails with a receiver without push cert=
ificate support' '
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09test_must_fail git push --signed dst noop ff +noff 2>err &&
+=09test_i18ngrep "the receiving end does not support" err
+'
+
+test_expect_success 'push --signed=3D1 is accepted' '
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09test_must_fail git push --signed=3D1 dst noop ff +noff 2>err &&
+=09test_i18ngrep "the receiving end does not support" err
+'
+
+test_expect_success GPG 'no certificate for a signed push with no update' =
'
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09write_script dst/.git/hooks/post-receive <<-\EOF &&
+=09if test -n "${GIT_PUSH_CERT-}"
+=09then
+=09=09git cat-file blob $GIT_PUSH_CERT >../push-cert
+=09fi
+=09EOF
+=09git push dst noop &&
+=09! test -f dst/push-cert
+'
+
+test_expect_success GPG 'signed push sends push certificate' '
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09git -C dst config receive.certnonceseed sekrit &&
+=09write_script dst/.git/hooks/post-receive <<-\EOF &&
+=09# discard the update list
+=09cat >/dev/null
+=09# record the push certificate
+=09if test -n "${GIT_PUSH_CERT-}"
+=09then
+=09=09git cat-file blob $GIT_PUSH_CERT >../push-cert
+=09fi &&
+
+=09cat >../push-cert-status <<E_O_F
+=09SIGNER=3D${GIT_PUSH_CERT_SIGNER-nobody}
+=09KEY=3D${GIT_PUSH_CERT_KEY-nokey}
+=09STATUS=3D${GIT_PUSH_CERT_STATUS-nostatus}
+=09NONCE_STATUS=3D${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+=09NONCE=3D${GIT_PUSH_CERT_NONCE-nononce}
+=09E_O_F
+
+=09EOF
+
+=09git push --signed dst noop ff +noff &&
+
+=09(
+=09=09cat <<-\EOF &&
+=09=09SIGNER=3DC O Mitter <committer@example.com>
+=09=09KEY=3D13B6F51ECDDE430D
+=09=09STATUS=3DG
+=09=09NONCE_STATUS=3DOK
+=09=09EOF
+=09=09sed -n -e "s/^nonce /NONCE=3D/p" -e "/^$/q" dst/push-cert
+=09) >expect &&
+
+=09noop=3D$(git rev-parse noop) &&
+=09ff=3D$(git rev-parse ff) &&
+=09noff=3D$(git rev-parse noff) &&
+=09grep "$noop $ff refs/heads/ff" dst/push-cert &&
+=09grep "$noop $noff refs/heads/noff" dst/push-cert &&
+=09test_cmp expect dst/push-cert-status
+'
+
+test_expect_success GPG 'inconsistent push options in signed push not allo=
wed' '
+=09# First, invoke receive-pack with dummy input to obtain its preamble.
+=09prepare_dst &&
+=09git -C dst config receive.certnonceseed sekrit &&
+=09git -C dst config receive.advertisepushoptions 1 &&
+=09printf xxxx | test_might_fail git receive-pack dst >preamble &&
+
+=09# Then, invoke push. Simulate a receive-pack that sends the preamble we
+=09# obtained, followed by a dummy packet.
+=09write_script myscript <<-\EOF &&
+=09=09cat preamble &&
+=09=09printf xxxx &&
+=09=09cat >push
+=09EOF
+=09test_might_fail git push --push-option=3D"foo" --push-option=3D"bar" \
+=09=09--receive-pack=3D"\"$(pwd)/myscript\"" --signed dst --delete ff &&
+
+=09# Replay the push output on a fresh dst, checking that ff is truly
+=09# deleted.
+=09prepare_dst &&
+=09git -C dst config receive.certnonceseed sekrit &&
+=09git -C dst config receive.advertisepushoptions 1 &&
+=09git receive-pack dst <push &&
+=09test_must_fail git -C dst rev-parse ff &&
+
+=09# Tweak the push output to make the push option outside the cert
+=09# different, then replay it on a fresh dst, checking that ff is not
+=09# deleted.
+=09perl -pe "s/([^ ])bar/\$1baz/" push >push.tweak &&
+=09prepare_dst &&
+=09git -C dst config receive.certnonceseed sekrit &&
+=09git -C dst config receive.advertisepushoptions 1 &&
+=09git receive-pack dst <push.tweak >out &&
+=09git -C dst rev-parse ff &&
+=09grep "inconsistent push options" out
+'
+
+test_expect_success GPG 'fail without key and heed user.signingkey' '
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09git -C dst config receive.certnonceseed sekrit &&
+=09write_script dst/.git/hooks/post-receive <<-\EOF &&
+=09# discard the update list
+=09cat >/dev/null
+=09# record the push certificate
+=09if test -n "${GIT_PUSH_CERT-}"
+=09then
+=09=09git cat-file blob $GIT_PUSH_CERT >../push-cert
+=09fi &&
+
+=09cat >../push-cert-status <<E_O_F
+=09SIGNER=3D${GIT_PUSH_CERT_SIGNER-nobody}
+=09KEY=3D${GIT_PUSH_CERT_KEY-nokey}
+=09STATUS=3D${GIT_PUSH_CERT_STATUS-nostatus}
+=09NONCE_STATUS=3D${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+=09NONCE=3D${GIT_PUSH_CERT_NONCE-nononce}
+=09E_O_F
+
+=09EOF
+
+=09test_config user.email hasnokey@nowhere.com &&
+=09(
+=09=09sane_unset GIT_COMMITTER_EMAIL &&
+=09=09test_must_fail git push --signed dst noop ff +noff
+=09) &&
+=09test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+=09git push --signed dst noop ff +noff &&
+
+=09(
+=09=09cat <<-\EOF &&
+=09=09SIGNER=3DC O Mitter <committer@example.com>
+=09=09KEY=3D13B6F51ECDDE430D
+=09=09STATUS=3DG
+=09=09NONCE_STATUS=3DOK
+=09=09EOF
+=09=09sed -n -e "s/^nonce /NONCE=3D/p" -e "/^$/q" dst/push-cert
+=09) >expect &&
+
+=09noop=3D$(git rev-parse noop) &&
+=09ff=3D$(git rev-parse ff) &&
+=09noff=3D$(git rev-parse noff) &&
+=09grep "$noop $ff refs/heads/ff" dst/push-cert &&
+=09grep "$noop $noff refs/heads/noff" dst/push-cert &&
+=09test_cmp expect dst/push-cert-status
+'
+
+test_expect_success GPGSM 'fail without key and heed user.signingkey x509'=
 '
+=09test_config signing.default x509 &&
+=09prepare_dst &&
+=09mkdir -p dst/.git/hooks &&
+=09git -C dst config receive.certnonceseed sekrit &&
+=09write_script dst/.git/hooks/post-receive <<-\EOF &&
+=09# discard the update list
+=09cat >/dev/null
+=09# record the push certificate
+=09if test -n "${GIT_PUSH_CERT-}"
+=09then
+=09=09git cat-file blob $GIT_PUSH_CERT >../push-cert
+=09fi &&
+
+=09cat >../push-cert-status <<E_O_F
+=09SIGNER=3D${GIT_PUSH_CERT_SIGNER-nobody}
+=09KEY=3D${GIT_PUSH_CERT_KEY-nokey}
+=09STATUS=3D${GIT_PUSH_CERT_STATUS-nostatus}
+=09NONCE_STATUS=3D${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+=09NONCE=3D${GIT_PUSH_CERT_NONCE-nononce}
+=09E_O_F
+
+=09EOF
+
+=09test_config user.email hasnokey@nowhere.com &&
+=09test_config user.signingkey "" &&
+=09(
+=09=09sane_unset GIT_COMMITTER_EMAIL &&
+=09=09test_must_fail git push --signed dst noop ff +noff
+=09) &&
+=09test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+=09git push --signed dst noop ff +noff &&
+
+=09(
+=09=09cat <<-\EOF &&
+=09=09SIGNER=3D/CN=3DC O Mitter/O=3DExample/SN=3DC O/GN=3DMitter
+=09=09KEY=3D
+=09=09STATUS=3DG
+=09=09NONCE_STATUS=3DOK
+=09=09EOF
+=09=09sed -n -e "s/^nonce /NONCE=3D/p" -e "/^$/q" dst/push-cert
+=09) >expect.in &&
+=09key=3D$(cat "${GNUPGHOME}/trustlist.txt" | cut -d" " -f1 | tr -d ":") &=
&
+=09sed -e "s/^KEY=3D/KEY=3D${key}/" expect.in >expect &&
+
+=09noop=3D$(git rev-parse noop) &&
+=09ff=3D$(git rev-parse ff) &&
+=09noff=3D$(git rev-parse noff) &&
+=09grep "$noop $ff refs/heads/ff" dst/push-cert &&
+=09grep "$noop $noff refs/heads/noff" dst/push-cert &&
+=09test_cmp expect dst/push-cert-status
+'
+
+test_done
diff --git a/t/t7013-tag-signconfig.sh b/t/t7013-tag-signconfig.sh
new file mode 100755
index 000000000..691ab7b7e
--- /dev/null
+++ b/t/t7013-tag-signconfig.sh
@@ -0,0 +1,2074 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Carlos Rica
+#
+
+test_description=3D'git tag
+
+Tests for operations with tags.'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+# creating and listing lightweight tags:
+
+tag_exists () {
+=09git show-ref --quiet --verify refs/tags/"$1"
+}
+
+test_expect_success 'listing all tags in an empty tree should succeed' '
+=09git tag -l &&
+=09git tag
+'
+
+test_expect_success 'listing all tags in an empty tree should output nothi=
ng' '
+=09test $(git tag -l | wc -l) -eq 0 &&
+=09test $(git tag | wc -l) -eq 0
+'
+
+test_expect_success 'sort tags, ignore case' '
+=09(
+=09=09git init sort &&
+=09=09cd sort &&
+=09=09test_commit initial &&
+=09=09git tag tag-one &&
+=09=09git tag TAG-two &&
+=09=09git tag -l >actual &&
+=09=09cat >expected <<-\EOF &&
+=09=09TAG-two
+=09=09initial
+=09=09tag-one
+=09=09EOF
+=09=09test_cmp expected actual &&
+=09=09git tag -l -i >actual &&
+=09=09cat >expected <<-\EOF &&
+=09=09initial
+=09=09tag-one
+=09=09TAG-two
+=09=09EOF
+=09=09test_cmp expected actual
+=09)
+'
+
+test_expect_success 'looking for a tag in an empty tree should fail' \
+=09'! (tag_exists mytag)'
+
+test_expect_success 'creating a tag in an empty tree should fail' '
+=09test_must_fail git tag mynotag &&
+=09! tag_exists mynotag
+'
+
+test_expect_success 'creating a tag for HEAD in an empty tree should fail'=
 '
+=09test_must_fail git tag mytaghead HEAD &&
+=09! tag_exists mytaghead
+'
+
+test_expect_success 'creating a tag for an unknown revision should fail' '
+=09test_must_fail git tag mytagnorev aaaaaaaaaaa &&
+=09! tag_exists mytagnorev
+'
+
+# commit used in the tests, test_tick is also called here to freeze the da=
te:
+test_expect_success 'creating a tag using default HEAD should succeed' '
+=09test_config core.logAllRefUpdates true &&
+=09test_tick &&
+=09echo foo >foo &&
+=09git add foo &&
+=09git commit -m Foo &&
+=09git tag mytag &&
+=09test_must_fail git reflog exists refs/tags/mytag
+'
+
+test_expect_success 'creating a tag with --create-reflog should create ref=
log' '
+=09git log -1 \
+=09=09--format=3D"format:tag: tagging %h (%s, %cd)%n" \
+=09=09--date=3Dformat:%Y-%m-%d >expected &&
+=09test_when_finished "git tag -d tag_with_reflog" &&
+=09git tag --create-reflog tag_with_reflog &&
+=09git reflog exists refs/tags/tag_with_reflog &&
+=09sed -e "s/^.*=09//" .git/logs/refs/tags/tag_with_reflog >actual &&
+=09test_i18ncmp expected actual
+'
+
+test_expect_success 'annotated tag with --create-reflog has correct messag=
e' '
+=09git log -1 \
+=09=09--format=3D"format:tag: tagging %h (%s, %cd)%n" \
+=09=09--date=3Dformat:%Y-%m-%d >expected &&
+=09test_when_finished "git tag -d tag_with_reflog" &&
+=09git tag -m "annotated tag" --create-reflog tag_with_reflog &&
+=09git reflog exists refs/tags/tag_with_reflog &&
+=09sed -e "s/^.*=09//" .git/logs/refs/tags/tag_with_reflog >actual &&
+=09test_i18ncmp expected actual
+'
+
+test_expect_success '--create-reflog does not create reflog on failure' '
+=09test_must_fail git tag --create-reflog mytag &&
+=09test_must_fail git reflog exists refs/tags/mytag
+'
+
+test_expect_success 'option core.logAllRefUpdates=3Dalways creates reflog'=
 '
+=09test_when_finished "git tag -d tag_with_reflog" &&
+=09test_config core.logAllRefUpdates always &&
+=09git tag tag_with_reflog &&
+=09git reflog exists refs/tags/tag_with_reflog
+'
+
+test_expect_success 'listing all tags if one exists should succeed' '
+=09git tag -l &&
+=09git tag
+'
+
+cat >expect <<EOF
+mytag
+EOF
+test_expect_success 'Multiple -l or --list options are equivalent to one -=
l option' '
+=09git tag -l -l >actual &&
+=09test_cmp expect actual &&
+=09git tag --list --list >actual &&
+=09test_cmp expect actual &&
+=09git tag --list -l --list >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'listing all tags if one exists should output that tag=
' '
+=09test $(git tag -l) =3D mytag &&
+=09test $(git tag) =3D mytag
+'
+
+# pattern matching:
+
+test_expect_success 'listing a tag using a matching pattern should succeed=
' \
+=09'git tag -l mytag'
+
+test_expect_success 'listing a tag with --ignore-case' \
+=09'test $(git tag -l --ignore-case MYTAG) =3D mytag'
+
+test_expect_success \
+=09'listing a tag using a matching pattern should output that tag' \
+=09'test $(git tag -l mytag) =3D mytag'
+
+test_expect_success \
+=09'listing tags using a non-matching pattern should succeed' \
+=09'git tag -l xxx'
+
+test_expect_success \
+=09'listing tags using a non-matching pattern should output nothing' \
+=09'test $(git tag -l xxx | wc -l) -eq 0'
+
+# special cases for creating tags:
+
+test_expect_success \
+=09'trying to create a tag with the name of one existing should fail' \
+=09'test_must_fail git tag mytag'
+
+test_expect_success \
+=09'trying to create a tag with a non-valid name should fail' '
+=09test $(git tag -l | wc -l) -eq 1 &&
+=09test_must_fail git tag "" &&
+=09test_must_fail git tag .othertag &&
+=09test_must_fail git tag "other tag" &&
+=09test_must_fail git tag "othertag^" &&
+=09test_must_fail git tag "other~tag" &&
+=09test $(git tag -l | wc -l) -eq 1
+'
+
+test_expect_success 'creating a tag using HEAD directly should succeed' '
+=09git tag myhead HEAD &&
+=09tag_exists myhead
+'
+
+test_expect_success '--force can create a tag with the name of one existin=
g' '
+=09tag_exists mytag &&
+=09git tag --force mytag &&
+=09tag_exists mytag'
+
+test_expect_success '--force is moot with a non-existing tag name' '
+=09test_when_finished git tag -d newtag forcetag &&
+=09git tag newtag >expect &&
+=09git tag --force forcetag >actual &&
+=09test_cmp expect actual
+'
+
+# deleting tags:
+
+test_expect_success 'trying to delete an unknown tag should fail' '
+=09! tag_exists unknown-tag &&
+=09test_must_fail git tag -d unknown-tag
+'
+
+cat >expect <<EOF
+myhead
+mytag
+EOF
+test_expect_success \
+=09'trying to delete tags without params should succeed and do nothing' '
+=09git tag -l > actual && test_cmp expect actual &&
+=09git tag -d &&
+=09git tag -l > actual && test_cmp expect actual
+'
+
+test_expect_success \
+=09'deleting two existing tags in one command should succeed' '
+=09tag_exists mytag &&
+=09tag_exists myhead &&
+=09git tag -d mytag myhead &&
+=09! tag_exists mytag &&
+=09! tag_exists myhead
+'
+
+test_expect_success \
+=09'creating a tag with the name of another deleted one should succeed' '
+=09! tag_exists mytag &&
+=09git tag mytag &&
+=09tag_exists mytag
+'
+
+test_expect_success \
+=09'trying to delete two tags, existing and not, should fail in the 2nd' '
+=09tag_exists mytag &&
+=09! tag_exists myhead &&
+=09test_must_fail git tag -d mytag anothertag &&
+=09! tag_exists mytag &&
+=09! tag_exists myhead
+'
+
+test_expect_success 'trying to delete an already deleted tag should fail' =
\
+=09'test_must_fail git tag -d mytag'
+
+# listing various tags with pattern matching:
+
+cat >expect <<EOF
+a1
+aa1
+cba
+t210
+t211
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+EOF
+test_expect_success 'listing all tags should print them ordered' '
+=09git tag v1.0.1 &&
+=09git tag t211 &&
+=09git tag aa1 &&
+=09git tag v0.2.1 &&
+=09git tag v1.1.3 &&
+=09git tag cba &&
+=09git tag a1 &&
+=09git tag v1.0 &&
+=09git tag t210 &&
+=09git tag -l > actual &&
+=09test_cmp expect actual &&
+=09git tag > actual &&
+=09test_cmp expect actual
+'
+
+cat >expect <<EOF
+a1
+aa1
+cba
+EOF
+test_expect_success \
+=09'listing tags with substring as pattern must print those matching' '
+=09rm *a* &&
+=09git tag -l "*a*" > current &&
+=09test_cmp expect current
+'
+
+cat >expect <<EOF
+v0.2.1
+v1.0.1
+EOF
+test_expect_success \
+=09'listing tags with a suffix as pattern must print those matching' '
+=09git tag -l "*.1" > actual &&
+=09test_cmp expect actual
+'
+
+cat >expect <<EOF
+t210
+t211
+EOF
+test_expect_success \
+=09'listing tags with a prefix as pattern must print those matching' '
+=09git tag -l "t21*" > actual &&
+=09test_cmp expect actual
+'
+
+cat >expect <<EOF
+a1
+EOF
+test_expect_success \
+=09'listing tags using a name as pattern must print that one matching' '
+=09git tag -l a1 > actual &&
+=09test_cmp expect actual
+'
+
+cat >expect <<EOF
+v1.0
+EOF
+test_expect_success \
+=09'listing tags using a name as pattern must print that one matching' '
+=09git tag -l v1.0 > actual &&
+=09test_cmp expect actual
+'
+
+cat >expect <<EOF
+v1.0.1
+v1.1.3
+EOF
+test_expect_success \
+=09'listing tags with ? in the pattern should print those matching' '
+=09git tag -l "v1.?.?" > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success \
+=09'listing tags using v.* should print nothing because none have v.' '
+=09git tag -l "v.*" > actual &&
+=09test_must_be_empty actual
+'
+
+cat >expect <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+EOF
+test_expect_success \
+=09'listing tags using v* should print only those having v' '
+=09git tag -l "v*" > actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'tag -l can accept multiple patterns' '
+=09git tag -l "v1*" "v0*" >actual &&
+=09test_cmp expect actual
+'
+
+# Between v1.7.7 & v2.13.0 a fair reading of the git-tag documentation
+# could leave you with the impression that "-l <pattern> -l <pattern>"
+# was how we wanted to accept multiple patterns.
+#
+# This test should not imply that this is a sane thing to support. but
+# since the documentation was worded like it was let's at least find
+# out if we're going to break this long-documented form of taking
+# multiple patterns.
+test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy doc=
umentation previously suggested' '
+=09git tag -l "v1*" -l "v0*" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'listing tags in column' '
+=09COLUMNS=3D41 git tag -l --column=3Drow >actual &&
+=09cat >expected <<\EOF &&
+a1      aa1     cba     t210    t211
+v0.2.1  v1.0    v1.0.1  v1.1.3
+EOF
+=09test_cmp expected actual
+'
+
+test_expect_success 'listing tags in column with column.*' '
+=09test_config column.tag row &&
+=09test_config column.ui dense &&
+=09COLUMNS=3D40 git tag -l >actual &&
+=09cat >expected <<\EOF &&
+a1      aa1   cba     t210    t211
+v0.2.1  v1.0  v1.0.1  v1.1.3
+EOF
+=09test_cmp expected actual
+'
+
+test_expect_success 'listing tag with -n --column should fail' '
+=09test_must_fail git tag --column -n
+'
+
+test_expect_success 'listing tags -n in column with column.ui ignored' '
+=09test_config column.ui "row dense" &&
+=09COLUMNS=3D40 git tag -l -n >actual &&
+=09cat >expected <<\EOF &&
+a1              Foo
+aa1             Foo
+cba             Foo
+t210            Foo
+t211            Foo
+v0.2.1          Foo
+v1.0            Foo
+v1.0.1          Foo
+v1.1.3          Foo
+EOF
+=09test_cmp expected actual
+'
+
+# creating and verifying lightweight tags:
+
+test_expect_success \
+=09'a non-annotated tag created without parameters should point to HEAD' '
+=09git tag non-annotated-tag &&
+=09test $(git cat-file -t non-annotated-tag) =3D commit &&
+=09test $(git rev-parse non-annotated-tag) =3D $(git rev-parse HEAD)
+'
+
+test_expect_success 'trying to verify an unknown tag should fail' \
+=09'test_must_fail git tag -v unknown-tag'
+
+test_expect_success \
+=09'trying to verify a non-annotated and non-signed tag should fail' \
+=09'test_must_fail git tag -v non-annotated-tag'
+
+test_expect_success \
+=09'trying to verify many non-annotated or unknown tags, should fail' \
+=09'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+
+# creating annotated tags:
+
+get_tag_msg () {
+=09git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
+}
+
+# run test_tick before committing always gives the time in that timezone
+get_tag_header () {
+cat <<EOF
+object $2
+type $3
+tag $1
+tagger C O Mitter <committer@example.com> $4 -0700
+
+EOF
+}
+
+commit=3D$(git rev-parse HEAD)
+time=3D$test_tick
+
+get_tag_header annotated-tag $commit commit $time >expect
+echo "A message" >>expect
+test_expect_success \
+=09'creating an annotated tag with -m message should succeed' '
+=09git tag -m "A message" annotated-tag &&
+=09get_tag_msg annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header annotated-tag-edit $commit commit $time >expect
+echo "An edited message" >>expect
+test_expect_success 'set up editor' '
+=09write_script fakeeditor <<-\EOF
+=09sed -e "s/A message/An edited message/g" <"$1" >"$1-"
+=09mv "$1-" "$1"
+=09EOF
+'
+test_expect_success \
+=09'creating an annotated tag with -m message --edit should succeed' '
+=09GIT_EDITOR=3D./fakeeditor git tag -m "A message" --edit annotated-tag-e=
dit &&
+=09get_tag_msg annotated-tag-edit >actual &&
+=09test_cmp expect actual
+'
+
+cat >msgfile <<EOF
+Another message
+in a file.
+EOF
+get_tag_header file-annotated-tag $commit commit $time >expect
+cat msgfile >>expect
+test_expect_success \
+=09'creating an annotated tag with -F messagefile should succeed' '
+=09git tag -F msgfile file-annotated-tag &&
+=09get_tag_msg file-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header file-annotated-tag-edit $commit commit $time >expect
+sed -e "s/Another message/Another edited message/g" msgfile >>expect
+test_expect_success 'set up editor' '
+=09write_script fakeeditor <<-\EOF
+=09sed -e "s/Another message/Another edited message/g" <"$1" >"$1-"
+=09mv "$1-" "$1"
+=09EOF
+'
+test_expect_success \
+=09'creating an annotated tag with -F messagefile --edit should succeed' '
+=09GIT_EDITOR=3D./fakeeditor git tag -F msgfile --edit file-annotated-tag-=
edit &&
+=09get_tag_msg file-annotated-tag-edit >actual &&
+=09test_cmp expect actual
+'
+
+cat >inputmsg <<EOF
+A message from the
+standard input
+EOF
+get_tag_header stdin-annotated-tag $commit commit $time >expect
+cat inputmsg >>expect
+test_expect_success 'creating an annotated tag with -F - should succeed' '
+=09git tag -F - stdin-annotated-tag <inputmsg &&
+=09get_tag_msg stdin-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success \
+=09'trying to create a tag with a non-existing -F file should fail' '
+=09! test -f nonexistingfile &&
+=09! tag_exists notag &&
+=09test_must_fail git tag -F nonexistingfile notag &&
+=09! tag_exists notag
+'
+
+test_expect_success \
+=09'trying to create tags giving both -m or -F options should fail' '
+=09echo "message file 1" >msgfile1 &&
+=09echo "message file 2" >msgfile2 &&
+=09! tag_exists msgtag &&
+=09test_must_fail git tag -m "message 1" -F msgfile1 msgtag &&
+=09! tag_exists msgtag &&
+=09test_must_fail git tag -F msgfile1 -m "message 1" msgtag &&
+=09! tag_exists msgtag &&
+=09test_must_fail git tag -m "message 1" -F msgfile1 \
+=09=09-m "message 2" msgtag &&
+=09! tag_exists msgtag
+'
+
+# blank and empty messages:
+
+get_tag_header empty-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with an empty -m message should succeed' '
+=09git tag -m "" empty-annotated-tag &&
+=09get_tag_msg empty-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+>emptyfile
+get_tag_header emptyfile-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with an empty -F messagefile should succeed' '
+=09git tag -F emptyfile emptyfile-annotated-tag &&
+=09get_tag_msg emptyfile-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
+printf '\n\t \t  \nRepeated blank lines\n' >>blanksfile
+printf '\n\n\nTrailing spaces      \t  \n' >>blanksfile
+printf '\nTrailing blank lines\n\n\t \n\n' >>blanksfile
+get_tag_header blanks-annotated-tag $commit commit $time >expect
+cat >>expect <<EOF
+Leading blank lines
+
+Repeated blank lines
+
+Trailing spaces
+
+Trailing blank lines
+EOF
+test_expect_success \
+=09'extra blanks in the message for an annotated tag should be removed' '
+=09git tag -F blanksfile blanks-annotated-tag &&
+=09get_tag_msg blanks-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header blank-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with blank -m message with spaces should succeed' '
+=09git tag -m "     " blank-annotated-tag &&
+=09get_tag_msg blank-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+echo '     ' >blankfile
+echo ''      >>blankfile
+echo '  '    >>blankfile
+get_tag_header blankfile-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with blank -F messagefile with spaces should succeed' '
+=09git tag -F blankfile blankfile-annotated-tag &&
+=09get_tag_msg blankfile-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+printf '      ' >blanknonlfile
+get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with -F file of spaces and no newline should succeed' '
+=09git tag -F blanknonlfile blanknonlfile-annotated-tag &&
+=09get_tag_msg blanknonlfile-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+# messages with commented lines:
+
+cat >commentsfile <<EOF
+# A comment
+
+############
+The message.
+############
+One line.
+
+
+# commented lines
+# commented lines
+
+Another line.
+# comments
+
+Last line.
+EOF
+get_tag_header comments-annotated-tag $commit commit $time >expect
+cat >>expect <<EOF
+The message.
+One line.
+
+Another line.
+
+Last line.
+EOF
+test_expect_success \
+=09'creating a tag using a -F messagefile with #comments should succeed' '
+=09git tag -F commentsfile comments-annotated-tag &&
+=09get_tag_msg comments-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header comment-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with a #comment in the -m message should succeed' '
+=09git tag -m "#comment" comment-annotated-tag &&
+=09get_tag_msg comment-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+echo '#comment' >commentfile
+echo ''         >>commentfile
+echo '####'     >>commentfile
+get_tag_header commentfile-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with #comments in the -F messagefile should succeed' '
+=09git tag -F commentfile commentfile-annotated-tag &&
+=09get_tag_msg commentfile-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+printf '#comment' >commentnonlfile
+get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
+test_expect_success \
+=09'creating a tag with a file of #comment and no newline should succeed' =
'
+=09git tag -F commentnonlfile commentnonlfile-annotated-tag &&
+=09get_tag_msg commentnonlfile-annotated-tag >actual &&
+=09test_cmp expect actual
+'
+
+# listing messages for annotated non-signed tags:
+
+test_expect_success \
+=09'listing the one-line message of a non-signed tag should succeed' '
+=09git tag -m "A msg" tag-one-line &&
+
+=09echo "tag-one-line" >expect &&
+=09git tag -l | grep "^tag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l | grep "^tag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l tag-one-line >actual &&
+=09test_cmp expect actual &&
+
+=09git tag -n0 | grep "^tag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 tag-one-line >actual &&
+=09test_cmp expect actual &&
+
+=09echo "tag-one-line    A msg" >expect &&
+=09git tag -n1 -l | grep "^tag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n -l | grep "^tag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n1 -l tag-one-line >actual &&
+=09test_cmp expect actual &&
+=09git tag -n2 -l tag-one-line >actual &&
+=09test_cmp expect actual &&
+=09git tag -n999 -l tag-one-line >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'The -n 100 invocation means -n --list 100, not -n100'=
 '
+=09git tag -n 100 >actual &&
+=09test_must_be_empty actual &&
+
+=09git tag -m "A msg" 100 &&
+=09echo "100             A msg" >expect &&
+=09git tag -n 100 >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success \
+=09'listing the zero-lines message of a non-signed tag should succeed' '
+=09git tag -m "" tag-zero-lines &&
+
+=09echo "tag-zero-lines" >expect &&
+=09git tag -l | grep "^tag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l | grep "^tag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l tag-zero-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "tag-zero-lines  " >expect &&
+=09git tag -n1 -l | grep "^tag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n -l | grep "^tag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n1 -l tag-zero-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n2 -l tag-zero-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n999 -l tag-zero-lines >actual &&
+=09test_cmp expect actual
+'
+
+echo 'tag line one' >annotagmsg
+echo 'tag line two' >>annotagmsg
+echo 'tag line three' >>annotagmsg
+test_expect_success \
+=09'listing many message lines of a non-signed tag should succeed' '
+=09git tag -F annotagmsg tag-lines &&
+
+=09echo "tag-lines" >expect &&
+=09git tag -l | grep "^tag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l | grep "^tag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l tag-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "tag-lines       tag line one" >expect &&
+=09git tag -n1 -l | grep "^tag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n -l | grep "^tag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n1 -l tag-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "    tag line two" >>expect &&
+=09git tag -n2 -l | grep "^ *tag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n2 -l tag-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "    tag line three" >>expect &&
+=09git tag -n3 -l | grep "^ *tag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n3 -l tag-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n4 -l | grep "^ *tag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n4 -l tag-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n99 -l | grep "^ *tag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n99 -l tag-lines >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'annotations for blobs are empty' '
+=09blob=3D$(git hash-object -w --stdin <<-\EOF
+=09Blob paragraph 1.
+
+=09Blob paragraph 2.
+=09EOF
+=09) &&
+=09git tag tag-blob $blob &&
+=09echo "tag-blob        " >expect &&
+=09git tag -n1 -l tag-blob >actual &&
+=09test_cmp expect actual
+'
+
+# trying to verify annotated non-signed tags:
+
+test_expect_success GPG \
+=09'trying to verify an annotated non-signed tag should fail' '
+=09tag_exists annotated-tag &&
+=09test_must_fail git tag -v annotated-tag
+'
+
+test_expect_success GPG \
+=09'trying to verify a file-annotated non-signed tag should fail' '
+=09tag_exists file-annotated-tag &&
+=09test_must_fail git tag -v file-annotated-tag
+'
+
+test_expect_success GPG \
+=09'trying to verify two annotated non-signed tags should fail' '
+=09tag_exists annotated-tag file-annotated-tag &&
+=09test_must_fail git tag -v annotated-tag file-annotated-tag
+'
+
+# creating and verifying signed tags:
+
+get_tag_header signed-tag $commit commit $time >expect
+echo 'A signed tag message' >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG 'creating a signed tag with -m message should succ=
eed' '
+=09git tag -s -m "A signed tag message" signed-tag &&
+=09get_tag_msg signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header u-signed-tag $commit commit $time >expect
+echo 'Another message' >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG 'sign with a given key id' '
+
+=09git tag -u committer@example.com -m "Another message" u-signed-tag &&
+=09get_tag_msg u-signed-tag >actual &&
+=09test_cmp expect actual
+
+'
+
+test_expect_success GPG 'sign with an unknown id (1)' '
+
+=09test_must_fail git tag -u author@example.com \
+=09=09-m "Another message" o-signed-tag
+
+'
+
+test_expect_success GPG 'sign with an unknown id (2)' '
+
+=09test_must_fail git tag -u DEADBEEF -m "Another message" o-signed-tag
+
+'
+
+cat >fakeeditor <<'EOF'
+#!/bin/sh
+test -n "$1" && exec >"$1"
+echo A signed tag message
+echo from a fake editor.
+EOF
+chmod +x fakeeditor
+
+get_tag_header implied-sign $commit commit $time >expect
+./fakeeditor >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG '-u implies signed tag' '
+=09GIT_EDITOR=3D./fakeeditor git tag -u CDDE430D implied-sign &&
+=09get_tag_msg implied-sign >actual &&
+=09test_cmp expect actual
+'
+
+cat >sigmsgfile <<EOF
+Another signed tag
+message in a file.
+EOF
+get_tag_header file-signed-tag $commit commit $time >expect
+cat sigmsgfile >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with -F messagefile should succeed' '
+=09git tag -s -F sigmsgfile file-signed-tag &&
+=09get_tag_msg file-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+cat >siginputmsg <<EOF
+A signed tag message from
+the standard input
+EOF
+get_tag_header stdin-signed-tag $commit commit $time >expect
+cat siginputmsg >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG 'creating a signed tag with -F - should succeed' '
+=09git tag -s -F - stdin-signed-tag <siginputmsg &&
+=09get_tag_msg stdin-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header implied-annotate $commit commit $time >expect
+./fakeeditor >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG '-s implies annotated tag' '
+=09GIT_EDITOR=3D./fakeeditor git tag -s implied-annotate &&
+=09get_tag_msg implied-annotate >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header forcesignannotated-implied-sign $commit commit $time >expec=
t
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'git tag -s implied if configured with tag.forcesignannotated' \
+=09'test_config tag.forcesignannotated true &&
+=09git tag -m "A message" forcesignannotated-implied-sign &&
+=09get_tag_msg forcesignannotated-implied-sign >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG \
+=09'lightweight with no message when configured with tag.forcesignannotate=
d' \
+=09'test_config tag.forcesignannotated true &&
+=09git tag forcesignannotated-lightweight &&
+=09tag_exists forcesignannotated-lightweight &&
+=09test_must_fail git tag -v forcesignannotated-no-message
+'
+
+get_tag_header forcesignannotated-annotate $commit commit $time >expect
+echo "A message" >>expect
+test_expect_success GPG \
+=09'git tag -a disable configured tag.forcesignannotated' \
+=09'test_config tag.forcesignannotated true &&
+=09git tag -a -m "A message" forcesignannotated-annotate &&
+=09get_tag_msg forcesignannotated-annotate >actual &&
+=09test_cmp expect actual &&
+=09test_must_fail git tag -v forcesignannotated-annotate
+'
+
+get_tag_header forcesignannotated-disabled $commit commit $time >expect
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'git tag --sign enable GPG sign' \
+=09'test_config tag.forcesignannotated false &&
+=09git tag --sign -m "A message" forcesignannotated-disabled &&
+=09get_tag_msg forcesignannotated-disabled >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG \
+=09'trying to create a signed tag with non-existing -F file should fail' '
+=09! test -f nonexistingfile &&
+=09! tag_exists nosigtag &&
+=09test_must_fail git tag -s -F nonexistingfile nosigtag &&
+=09! tag_exists nosigtag
+'
+
+test_expect_success GPG 'verifying a signed tag should succeed' \
+=09'git tag -v signed-tag'
+
+test_expect_success GPG 'verifying two signed tags in one command should s=
ucceed' \
+=09'git tag -v signed-tag file-signed-tag'
+
+test_expect_success GPG \
+=09'verifying many signed and non-signed tags should fail' '
+=09test_must_fail git tag -v signed-tag annotated-tag &&
+=09test_must_fail git tag -v file-annotated-tag file-signed-tag &&
+=09test_must_fail git tag -v annotated-tag \
+=09=09file-signed-tag file-annotated-tag &&
+=09test_must_fail git tag -v signed-tag annotated-tag file-signed-tag
+'
+
+test_expect_success GPG 'verifying a forged tag should fail' '
+=09forged=3D$(git cat-file tag signed-tag |
+=09=09sed -e "s/signed-tag/forged-tag/" |
+=09=09git mktag) &&
+=09git tag forged-tag $forged &&
+=09test_must_fail git tag -v forged-tag
+'
+
+test_expect_success GPG 'verifying a proper tag with --format pass and for=
mat accordingly' '
+=09cat >expect <<-\EOF &&
+=09tagname : signed-tag
+=09EOF
+=09git tag -v --format=3D"tagname : %(tag)" "signed-tag" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'verifying a forged tag with --format should fail =
silently' '
+=09test_must_fail git tag -v --format=3D"tagname : %(tag)" "forged-tag" >a=
ctual &&
+=09test_must_be_empty actual
+'
+
+# blank and empty messages for signed tags:
+
+get_tag_header empty-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with an empty -m message should succeed' '
+=09git tag -s -m "" empty-signed-tag &&
+=09get_tag_msg empty-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v empty-signed-tag
+'
+
+>sigemptyfile
+get_tag_header emptyfile-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with an empty -F messagefile should succeed' '
+=09git tag -s -F sigemptyfile emptyfile-signed-tag &&
+=09get_tag_msg emptyfile-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v emptyfile-signed-tag
+'
+
+printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
+printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
+printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
+printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
+get_tag_header blanks-signed-tag $commit commit $time >expect
+cat >>expect <<EOF
+Leading blank lines
+
+Repeated blank lines
+
+Trailing spaces
+
+Trailing blank lines
+EOF
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'extra blanks in the message for a signed tag should be removed' '
+=09git tag -s -F sigblanksfile blanks-signed-tag &&
+=09get_tag_msg blanks-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v blanks-signed-tag
+'
+
+get_tag_header blank-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with a blank -m message should succeed' '
+=09git tag -s -m "     " blank-signed-tag &&
+=09get_tag_msg blank-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v blank-signed-tag
+'
+
+echo '     ' >sigblankfile
+echo ''      >>sigblankfile
+echo '  '    >>sigblankfile
+get_tag_header blankfile-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with blank -F file with spaces should succeed' '
+=09git tag -s -F sigblankfile blankfile-signed-tag &&
+=09get_tag_msg blankfile-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v blankfile-signed-tag
+'
+
+printf '      ' >sigblanknonlfile
+get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with spaces and no newline should succeed' '
+=09git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
+=09get_tag_msg blanknonlfile-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v blanknonlfile-signed-tag
+'
+
+test_expect_success GPG 'signed tag with embedded PGP message' '
+=09cat >msg <<-\EOF &&
+=09-----BEGIN PGP MESSAGE-----
+
+=09this is not a real PGP message
+=09-----END PGP MESSAGE-----
+=09EOF
+=09git tag -s -F msg confusing-pgp-message &&
+=09git tag -v confusing-pgp-message
+'
+
+# messages with commented lines for signed tags:
+
+cat >sigcommentsfile <<EOF
+# A comment
+
+############
+The message.
+############
+One line.
+
+
+# commented lines
+# commented lines
+
+Another line.
+# comments
+
+Last line.
+EOF
+get_tag_header comments-signed-tag $commit commit $time >expect
+cat >>expect <<EOF
+The message.
+One line.
+
+Another line.
+
+Last line.
+EOF
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with a -F file with #comments should succeed' '
+=09git tag -s -F sigcommentsfile comments-signed-tag &&
+=09get_tag_msg comments-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v comments-signed-tag
+'
+
+get_tag_header comment-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with #commented -m message should succeed' '
+=09git tag -s -m "#comment" comment-signed-tag &&
+=09get_tag_msg comment-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v comment-signed-tag
+'
+
+echo '#comment' >sigcommentfile
+echo ''         >>sigcommentfile
+echo '####'     >>sigcommentfile
+get_tag_header commentfile-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with #commented -F messagefile should succeed' '
+=09git tag -s -F sigcommentfile commentfile-signed-tag &&
+=09get_tag_msg commentfile-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v commentfile-signed-tag
+'
+
+printf '#comment' >sigcommentnonlfile
+get_tag_header commentnonlfile-signed-tag $commit commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag with a #comment and no newline should succeed' '
+=09git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
+=09get_tag_msg commentnonlfile-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -v commentnonlfile-signed-tag
+'
+
+# listing messages for signed tags:
+
+test_expect_success GPG \
+=09'listing the one-line message of a signed tag should succeed' '
+=09git tag -s -m "A message line signed" stag-one-line &&
+
+=09echo "stag-one-line" >expect &&
+=09git tag -l | grep "^stag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l | grep "^stag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l stag-one-line >actual &&
+=09test_cmp expect actual &&
+
+=09echo "stag-one-line   A message line signed" >expect &&
+=09git tag -n1 -l | grep "^stag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n -l | grep "^stag-one-line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n1 -l stag-one-line >actual &&
+=09test_cmp expect actual &&
+=09git tag -n2 -l stag-one-line >actual &&
+=09test_cmp expect actual &&
+=09git tag -n999 -l stag-one-line >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG \
+=09'listing the zero-lines message of a signed tag should succeed' '
+=09git tag -s -m "" stag-zero-lines &&
+
+=09echo "stag-zero-lines" >expect &&
+=09git tag -l | grep "^stag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l | grep "^stag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l stag-zero-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "stag-zero-lines " >expect &&
+=09git tag -n1 -l | grep "^stag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n -l | grep "^stag-zero-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n1 -l stag-zero-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n2 -l stag-zero-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n999 -l stag-zero-lines >actual &&
+=09test_cmp expect actual
+'
+
+echo 'stag line one' >sigtagmsg
+echo 'stag line two' >>sigtagmsg
+echo 'stag line three' >>sigtagmsg
+test_expect_success GPG \
+=09'listing many message lines of a signed tag should succeed' '
+=09git tag -s -F sigtagmsg stag-lines &&
+
+=09echo "stag-lines" >expect &&
+=09git tag -l | grep "^stag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l | grep "^stag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n0 -l stag-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "stag-lines      stag line one" >expect &&
+=09git tag -n1 -l | grep "^stag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n -l | grep "^stag-lines" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n1 -l stag-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "    stag line two" >>expect &&
+=09git tag -n2 -l | grep "^ *stag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n2 -l stag-lines >actual &&
+=09test_cmp expect actual &&
+
+=09echo "    stag line three" >>expect &&
+=09git tag -n3 -l | grep "^ *stag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n3 -l stag-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n4 -l | grep "^ *stag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n4 -l stag-lines >actual &&
+=09test_cmp expect actual &&
+=09git tag -n99 -l | grep "^ *stag.line" >actual &&
+=09test_cmp expect actual &&
+=09git tag -n99 -l stag-lines >actual &&
+=09test_cmp expect actual
+'
+
+# tags pointing to objects different from commits:
+
+tree=3D$(git rev-parse HEAD^{tree})
+blob=3D$(git rev-parse HEAD:foo)
+tag=3D$(git rev-parse signed-tag 2>/dev/null)
+
+get_tag_header tree-signed-tag $tree tree $time >expect
+echo "A message for a tree" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag pointing to a tree should succeed' '
+=09git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
+=09get_tag_msg tree-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header blob-signed-tag $blob blob $time >expect
+echo "A message for a blob" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag pointing to a blob should succeed' '
+=09git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
+=09get_tag_msg blob-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+get_tag_header tag-signed-tag $tag tag $time >expect
+echo "A message for another tag" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+=09'creating a signed tag pointing to another tag should succeed' '
+=09git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
+=09get_tag_msg tag-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+# usage with rfc1991 signatures
+get_tag_header rfc1991-signed-tag $commit commit $time >expect
+echo "RFC1991 signed tag" >>expect
+echo '-----BEGIN PGP MESSAGE-----' >>expect
+test_expect_success GPG,RFC1991 \
+=09'creating a signed tag with rfc1991' '
+=09echo "rfc1991" >gpghome/gpg.conf &&
+=09git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
+=09get_tag_msg rfc1991-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+cat >fakeeditor <<'EOF'
+#!/bin/sh
+cp "$1" actual
+EOF
+chmod +x fakeeditor
+
+test_expect_success GPG,RFC1991 \
+=09'reediting a signed tag body omits signature' '
+=09echo "rfc1991" >gpghome/gpg.conf &&
+=09echo "RFC1991 signed tag" >expect &&
+=09GIT_EDITOR=3D./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG,RFC1991 \
+=09'verifying rfc1991 signature' '
+=09echo "rfc1991" >gpghome/gpg.conf &&
+=09git tag -v rfc1991-signed-tag
+'
+
+test_expect_success GPG,RFC1991 \
+=09'list tag with rfc1991 signature' '
+=09echo "rfc1991" >gpghome/gpg.conf &&
+=09echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
+=09git tag -l -n1 rfc1991-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -l -n2 rfc1991-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -l -n999 rfc1991-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+rm -f gpghome/gpg.conf
+
+test_expect_success GPG,RFC1991 \
+=09'verifying rfc1991 signature without --rfc1991' '
+=09git tag -v rfc1991-signed-tag
+'
+
+test_expect_success GPG,RFC1991 \
+=09'list tag with rfc1991 signature without --rfc1991' '
+=09echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
+=09git tag -l -n1 rfc1991-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -l -n2 rfc1991-signed-tag >actual &&
+=09test_cmp expect actual &&
+=09git tag -l -n999 rfc1991-signed-tag >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG,RFC1991 \
+=09'reediting a signed tag body omits signature' '
+=09echo "RFC1991 signed tag" >expect &&
+=09GIT_EDITOR=3D./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+=09test_cmp expect actual
+'
+
+# try to sign with bad user.signingkey
+test_expect_success GPG \
+=09'git tag -s fails if gpg is misconfigured (bad key)' \
+=09'test_config user.signingkey BobTheMouse &&
+=09test_must_fail git tag -s -m tail tag-gpg-failure'
+
+# try to produce invalid signature
+test_expect_success GPG \
+=09'git tag -s fails if gpg is misconfigured (bad signature format)' \
+=09'test_config signing.openpgp.program echo &&
+=09 test_must_fail git tag -s -m tail tag-gpg-failure'
+
+# try to sign with bad user.signingkey
+test_expect_success GPGSM \
+=09'git tag -s fails if gpgsm is misconfigured (bad key)' \
+=09'test_config user.signingkey BobTheMouse &&
+=09 test_config signing.default x509 &&
+=09 test_must_fail git tag -s -m tail tag-gpg-failure'
+
+# try to produce invalid signature
+test_expect_success GPGSM \
+=09'git tag -s fails if gpgsm is misconfigured (bad signature format)' \
+=09'test_config signing.x509.program echo &&
+=09 test_config signing.default x509 &&
+=09 test_must_fail git tag -s -m tail tag-gpg-failure'
+
+# try to verify without gpg:
+
+rm -rf gpghome
+test_expect_success GPG \
+=09'verify signed tag fails when public key is not present' \
+=09'test_must_fail git tag -v signed-tag'
+
+test_expect_success \
+=09'git tag -a fails if tag annotation is empty' '
+=09! (GIT_EDITOR=3Dcat git tag -a initial-comment)
+'
+
+test_expect_success \
+=09'message in editor has initial comment' '
+=09! (GIT_EDITOR=3Dcat git tag -a initial-comment > actual)
+'
+
+test_expect_success 'message in editor has initial comment: first line' '
+=09# check the first line --- should be empty
+=09echo >first.expect &&
+=09sed -e 1q <actual >first.actual &&
+=09test_i18ncmp first.expect first.actual
+'
+
+test_expect_success \
+=09'message in editor has initial comment: remainder' '
+=09# remove commented lines from the remainder -- should be empty
+=09sed -e 1d -e "/^#/d" <actual >rest.actual &&
+=09test_must_be_empty rest.actual
+'
+
+get_tag_header reuse $commit commit $time >expect
+echo "An annotation to be reused" >> expect
+test_expect_success \
+=09'overwriting an annoted tag should use its previous body' '
+=09git tag -a -m "An annotation to be reused" reuse &&
+=09GIT_EDITOR=3Dtrue git tag -f -a reuse &&
+=09get_tag_msg reuse >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'filename for the message is relative to cwd' '
+=09mkdir subdir &&
+=09echo "Tag message in top directory" >msgfile-5 &&
+=09echo "Tag message in sub directory" >subdir/msgfile-5 &&
+=09(
+=09=09cd subdir &&
+=09=09git tag -a -F msgfile-5 tag-from-subdir
+=09) &&
+=09git cat-file tag tag-from-subdir | grep "in sub directory"
+'
+
+test_expect_success 'filename for the message is relative to cwd' '
+=09echo "Tag message in sub directory" >subdir/msgfile-6 &&
+=09(
+=09=09cd subdir &&
+=09=09git tag -a -F msgfile-6 tag-from-subdir-2
+=09) &&
+=09git cat-file tag tag-from-subdir-2 | grep "in sub directory"
+'
+
+# create a few more commits to test --contains
+
+hash1=3D$(git rev-parse HEAD)
+
+test_expect_success 'creating second commit and tag' '
+=09echo foo-2.0 >foo &&
+=09git add foo &&
+=09git commit -m second &&
+=09git tag v2.0
+'
+
+hash2=3D$(git rev-parse HEAD)
+
+test_expect_success 'creating third commit without tag' '
+=09echo foo-dev >foo &&
+=09git add foo &&
+=09git commit -m third
+'
+
+hash3=3D$(git rev-parse HEAD)
+
+# simple linear checks of --continue
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+EOF
+
+test_expect_success 'checking that first commit is in all tags (hash)' "
+=09git tag -l --contains $hash1 v* >actual &&
+=09test_cmp expected actual
+"
+
+# other ways of specifying the commit
+test_expect_success 'checking that first commit is in all tags (tag)' "
+=09git tag -l --contains v1.0 v* >actual &&
+=09test_cmp expected actual
+"
+
+test_expect_success 'checking that first commit is in all tags (relative)'=
 "
+=09git tag -l --contains HEAD~2 v* >actual &&
+=09test_cmp expected actual
+"
+
+# All the --contains tests above, but with --no-contains
+test_expect_success 'checking that first commit is not listed in any tag w=
ith --no-contains  (hash)' "
+=09git tag -l --no-contains $hash1 v* >actual &&
+=09test_must_be_empty actual
+"
+
+test_expect_success 'checking that first commit is in all tags (tag)' "
+=09git tag -l --no-contains v1.0 v* >actual &&
+=09test_must_be_empty actual
+"
+
+test_expect_success 'checking that first commit is in all tags (relative)'=
 "
+=09git tag -l --no-contains HEAD~2 v* >actual &&
+=09test_must_be_empty actual
+"
+
+cat > expected <<EOF
+v2.0
+EOF
+
+test_expect_success 'checking that second commit only has one tag' "
+=09git tag -l --contains $hash2 v* >actual &&
+=09test_cmp expected actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+EOF
+
+test_expect_success 'inverse of the last test, with --no-contains' "
+=09git tag -l --no-contains $hash2 v* >actual &&
+=09test_cmp expected actual
+"
+
+test_expect_success 'checking that third commit has no tags' "
+=09git tag -l --contains $hash3 v* >actual &&
+=09test_must_be_empty actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+EOF
+
+test_expect_success 'conversely --no-contains on the third commit lists al=
l tags' "
+=09git tag -l --no-contains $hash3 v* >actual &&
+=09test_cmp expected actual
+"
+
+# how about a simple merge?
+
+test_expect_success 'creating simple branch' '
+=09git branch stable v2.0 &&
+        git checkout stable &&
+=09echo foo-3.0 > foo &&
+=09git commit foo -m fourth &&
+=09git tag v3.0
+'
+
+hash4=3D$(git rev-parse HEAD)
+
+cat > expected <<EOF
+v3.0
+EOF
+
+test_expect_success 'checking that branch head only has one tag' "
+=09git tag -l --contains $hash4 v* >actual &&
+=09test_cmp expected actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+EOF
+
+test_expect_success 'checking that branch head with --no-contains lists al=
l but one tag' "
+=09git tag -l --no-contains $hash4 v* >actual &&
+=09test_cmp expected actual
+"
+
+test_expect_success 'merging original branch into this branch' '
+=09git merge --strategy=3Dours master &&
+        git tag v4.0
+'
+
+cat > expected <<EOF
+v4.0
+EOF
+
+test_expect_success 'checking that original branch head has one tag now' "
+=09git tag -l --contains $hash3 v* >actual &&
+=09test_cmp expected actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+v3.0
+EOF
+
+test_expect_success 'checking that original branch head with --no-contains=
 lists all but one tag now' "
+=09git tag -l --no-contains $hash3 v* >actual &&
+=09test_cmp expected actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+v3.0
+v4.0
+EOF
+
+test_expect_success 'checking that initial commit is in all tags' "
+=09git tag -l --contains $hash1 v* >actual &&
+=09test_cmp expected actual
+"
+
+test_expect_success 'checking that --contains can be used in non-list mode=
' '
+=09git tag --contains $hash1 v* >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success 'checking that initial commit is in all tags with --no=
-contains' "
+=09git tag -l --no-contains $hash1 v* >actual &&
+=09test_must_be_empty actual
+"
+
+# mixing modes and options:
+
+test_expect_success 'mixing incompatibles modes and options is forbidden' =
'
+=09test_must_fail git tag -a &&
+=09test_must_fail git tag -a -l &&
+=09test_must_fail git tag -s &&
+=09test_must_fail git tag -s -l &&
+=09test_must_fail git tag -m &&
+=09test_must_fail git tag -m -l &&
+=09test_must_fail git tag -m "hlagh" &&
+=09test_must_fail git tag -m "hlagh" -l &&
+=09test_must_fail git tag -F &&
+=09test_must_fail git tag -F -l &&
+=09test_must_fail git tag -f &&
+=09test_must_fail git tag -f -l &&
+=09test_must_fail git tag -a -s -m -F &&
+=09test_must_fail git tag -a -s -m -F -l &&
+=09test_must_fail git tag -l -v &&
+=09test_must_fail git tag -l -d &&
+=09test_must_fail git tag -l -v -d &&
+=09test_must_fail git tag -n 100 -v &&
+=09test_must_fail git tag -l -m msg &&
+=09test_must_fail git tag -l -F some file &&
+=09test_must_fail git tag -v -s &&
+=09test_must_fail git tag --contains tag-tree &&
+=09test_must_fail git tag --contains tag-blob &&
+=09test_must_fail git tag --no-contains tag-tree &&
+=09test_must_fail git tag --no-contains tag-blob &&
+=09test_must_fail git tag --contains --no-contains &&
+=09test_must_fail git tag --no-with HEAD &&
+=09test_must_fail git tag --no-without HEAD
+'
+
+for option in --contains --with --no-contains --without --merged --no-merg=
ed --points-at
+do
+=09test_expect_success "mixing incompatible modes with $option is forbidde=
n" "
+=09=09test_must_fail git tag -d $option HEAD &&
+=09=09test_must_fail git tag -d $option HEAD some-tag &&
+=09=09test_must_fail git tag -v $option HEAD
+=09"
+=09test_expect_success "Doing 'git tag --list-like $option <commit> <patte=
rn> is permitted" "
+=09=09git tag -n $option HEAD HEAD &&
+=09=09git tag $option HEAD HEAD &&
+=09=09git tag $option
+=09"
+done
+
+# check points-at
+
+test_expect_success '--points-at can be used in non-list mode' '
+=09echo v4.0 >expect &&
+=09git tag --points-at=3Dv4.0 "v*" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--points-at is a synonym for --points-at HEAD' '
+=09echo v4.0 >expect &&
+=09git tag --points-at >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--points-at finds lightweight tags' '
+=09echo v4.0 >expect &&
+=09git tag --points-at v4.0 >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--points-at finds annotated tags of commits' '
+=09git tag -m "v4.0, annotated" annotated-v4.0 v4.0 &&
+=09echo annotated-v4.0 >expect &&
+=09git tag -l --points-at v4.0 "annotated*" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--points-at finds annotated tags of tags' '
+=09git tag -m "describing the v4.0 tag object" \
+=09=09annotated-again-v4.0 annotated-v4.0 &&
+=09cat >expect <<-\EOF &&
+=09annotated-again-v4.0
+=09annotated-v4.0
+=09EOF
+=09git tag --points-at=3Dannotated-v4.0 >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'recursive tagging should give advice' '
+=09sed -e "s/|$//" <<-EOF >expect &&
+=09hint: You have created a nested tag. The object referred to by your new=
 tag is
+=09hint: already a tag. If you meant to tag the object that it points to, =
use:
+=09hint: |
+=09hint: =09git tag -f nested annotated-v4.0^{}
+=09EOF
+=09git tag -m nested nested annotated-v4.0 2>actual &&
+=09test_i18ncmp expect actual
+'
+
+test_expect_success 'multiple --points-at are OR-ed together' '
+=09cat >expect <<-\EOF &&
+=09v2.0
+=09v3.0
+=09EOF
+=09git tag --points-at=3Dv2.0 --points-at=3Dv3.0 >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'lexical sort' '
+=09git tag foo1.3 &&
+=09git tag foo1.6 &&
+=09git tag foo1.10 &&
+=09git tag -l --sort=3Drefname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.10
+=09foo1.3
+=09foo1.6
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort' '
+=09git tag -l --sort=3Dversion:refname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.3
+=09foo1.6
+=09foo1.10
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'reverse version sort' '
+=09git tag -l --sort=3D-version:refname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.10
+=09foo1.6
+=09foo1.3
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'reverse lexical sort' '
+=09git tag -l --sort=3D-refname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.6
+=09foo1.3
+=09foo1.10
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'configured lexical sort' '
+=09test_config tag.sort "v:refname" &&
+=09git tag -l "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.3
+=09foo1.6
+=09foo1.10
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'option override configured sort' '
+=09test_config tag.sort "v:refname" &&
+=09git tag -l --sort=3D-refname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.6
+=09foo1.3
+=09foo1.10
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'invalid sort parameter on command line' '
+=09test_must_fail git tag -l --sort=3Dnotvalid "foo*" >actual
+'
+
+test_expect_success 'invalid sort parameter in configuratoin' '
+=09test_config tag.sort "v:notvalid" &&
+=09test_must_fail git tag -l "foo*"
+'
+
+test_expect_success 'version sort with prerelease reordering' '
+=09test_config versionsort.prereleaseSuffix -rc &&
+=09git tag foo1.6-rc1 &&
+=09git tag foo1.6-rc2 &&
+=09git tag -l --sort=3Dversion:refname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.3
+=09foo1.6-rc1
+=09foo1.6-rc2
+=09foo1.6
+=09foo1.10
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'reverse version sort with prerelease reordering' '
+=09test_config versionsort.prereleaseSuffix -rc &&
+=09git tag -l --sort=3D-version:refname "foo*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.10
+=09foo1.6
+=09foo1.6-rc2
+=09foo1.6-rc1
+=09foo1.3
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort with prerelease reordering and common le=
ading character' '
+=09test_config versionsort.prereleaseSuffix -before &&
+=09git tag foo1.7-before1 &&
+=09git tag foo1.7 &&
+=09git tag foo1.7-after1 &&
+=09git tag -l --sort=3Dversion:refname "foo1.7*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.7-before1
+=09foo1.7
+=09foo1.7-after1
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort with prerelease reordering, multiple suf=
fixes and common leading character' '
+=09test_config versionsort.prereleaseSuffix -before &&
+=09git config --add versionsort.prereleaseSuffix -after &&
+=09git tag -l --sort=3Dversion:refname "foo1.7*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.7-before1
+=09foo1.7-after1
+=09foo1.7
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort with prerelease reordering, multiple suf=
fixes match the same tag' '
+=09test_config versionsort.prereleaseSuffix -bar &&
+=09git config --add versionsort.prereleaseSuffix -foo-baz &&
+=09git config --add versionsort.prereleaseSuffix -foo-bar &&
+=09git tag foo1.8-foo-bar &&
+=09git tag foo1.8-foo-baz &&
+=09git tag foo1.8 &&
+=09git tag -l --sort=3Dversion:refname "foo1.8*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.8-foo-baz
+=09foo1.8-foo-bar
+=09foo1.8
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort with prerelease reordering, multiple suf=
fixes match starting at the same position' '
+=09test_config versionsort.prereleaseSuffix -pre &&
+=09git config --add versionsort.prereleaseSuffix -prerelease &&
+=09git tag foo1.9-pre1 &&
+=09git tag foo1.9-pre2 &&
+=09git tag foo1.9-prerelease1 &&
+=09git tag -l --sort=3Dversion:refname "foo1.9*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.9-pre1
+=09foo1.9-pre2
+=09foo1.9-prerelease1
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort with general suffix reordering' '
+=09test_config versionsort.suffix -alpha &&
+=09git config --add versionsort.suffix -beta &&
+=09git config --add versionsort.suffix ""  &&
+=09git config --add versionsort.suffix -gamma &&
+=09git config --add versionsort.suffix -delta &&
+=09git tag foo1.10-alpha &&
+=09git tag foo1.10-beta &&
+=09git tag foo1.10-gamma &&
+=09git tag foo1.10-delta &&
+=09git tag foo1.10-unlisted-suffix &&
+=09git tag -l --sort=3Dversion:refname "foo1.10*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.10-alpha
+=09foo1.10-beta
+=09foo1.10
+=09foo1.10-unlisted-suffix
+=09foo1.10-gamma
+=09foo1.10-delta
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'versionsort.suffix overrides versionsort.prereleaseSu=
ffix' '
+=09test_config versionsort.suffix -before &&
+=09test_config versionsort.prereleaseSuffix -after &&
+=09git tag -l --sort=3Dversion:refname "foo1.7*" >actual &&
+=09cat >expect <<-\EOF &&
+=09foo1.7-before1
+=09foo1.7
+=09foo1.7-after1
+=09EOF
+=09test_cmp expect actual
+'
+
+test_expect_success 'version sort with very long prerelease suffix' '
+=09test_config versionsort.prereleaseSuffix -very-looooooooooooooooooooooo=
oong-prerelease-suffix &&
+=09git tag -l --sort=3Dversion:refname
+'
+
+test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work i=
n a deep repo' '
+=09i=3D1 &&
+=09while test $i -lt 8000
+=09do
+=09=09echo "commit refs/heads/master
+committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
+data <<EOF
+commit #$i
+EOF"
+=09=09test $i =3D 1 && echo "from refs/heads/master^0"
+=09=09i=3D$(($i + 1))
+=09done | git fast-import &&
+=09git checkout master &&
+=09git tag far-far-away HEAD^ &&
+=09run_with_limited_stack git tag --contains HEAD >actual &&
+=09test_must_be_empty actual &&
+=09run_with_limited_stack git tag --no-contains HEAD >actual &&
+=09test_line_count "-gt" 10 actual
+'
+
+test_expect_success '--format should list tags as per format given' '
+=09cat >expect <<-\EOF &&
+=09refname : refs/tags/v1.0
+=09refname : refs/tags/v1.0.1
+=09refname : refs/tags/v1.1.3
+=09EOF
+=09git tag -l --format=3D"refname : %(refname)" "v1*" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success "set up color tests" '
+=09echo "<RED>v1.0<RESET>" >expect.color &&
+=09echo "v1.0" >expect.bare &&
+=09color_args=3D"--format=3D%(color:red)%(refname:short) --list v1.0"
+'
+
+test_expect_success '%(color) omitted without tty' '
+=09TERM=3Dvt100 git tag $color_args >actual.raw &&
+=09test_decode_color <actual.raw >actual &&
+=09test_cmp expect.bare actual
+'
+
+test_expect_success TTY '%(color) present with tty' '
+=09test_terminal git tag $color_args >actual.raw &&
+=09test_decode_color <actual.raw >actual &&
+=09test_cmp expect.color actual
+'
+
+test_expect_success '--color overrides auto-color' '
+=09git tag --color $color_args >actual.raw &&
+=09test_decode_color <actual.raw >actual &&
+=09test_cmp expect.color actual
+'
+
+test_expect_success 'color.ui=3Dalways overrides auto-color' '
+=09git -c color.ui=3Dalways tag $color_args >actual.raw &&
+=09test_decode_color <actual.raw >actual &&
+=09test_cmp expect.color actual
+'
+
+test_expect_success 'setup --merged test tags' '
+=09git tag mergetest-1 HEAD~2 &&
+=09git tag mergetest-2 HEAD~1 &&
+=09git tag mergetest-3 HEAD
+'
+
+test_expect_success '--merged can be used in non-list mode' '
+=09cat >expect <<-\EOF &&
+=09mergetest-1
+=09mergetest-2
+=09EOF
+=09git tag --merged=3Dmergetest-2 "mergetest*" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--merged is incompatible with --no-merged' '
+=09test_must_fail git tag --merged HEAD --no-merged HEAD
+'
+
+test_expect_success '--merged shows merged tags' '
+=09cat >expect <<-\EOF &&
+=09mergetest-1
+=09mergetest-2
+=09EOF
+=09git tag -l --merged=3Dmergetest-2 mergetest-* >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--no-merged show unmerged tags' '
+=09cat >expect <<-\EOF &&
+=09mergetest-3
+=09EOF
+=09git tag -l --no-merged=3Dmergetest-2 mergetest-* >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--no-merged can be used in non-list mode' '
+=09git tag --no-merged=3Dmergetest-2 mergetest-* >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'ambiguous branch/tags not marked' '
+=09git tag ambiguous &&
+=09git branch ambiguous &&
+=09echo ambiguous >expect &&
+=09git tag -l ambiguous >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success '--contains combined with --no-contains' '
+=09(
+=09=09git init no-contains &&
+=09=09cd no-contains &&
+=09=09test_commit v0.1 &&
+=09=09test_commit v0.2 &&
+=09=09test_commit v0.3 &&
+=09=09test_commit v0.4 &&
+=09=09test_commit v0.5 &&
+=09=09cat >expected <<-\EOF &&
+=09=09v0.2
+=09=09v0.3
+=09=09v0.4
+=09=09EOF
+=09=09git tag --contains v0.2 --no-contains v0.5 >actual &&
+=09=09test_cmp expected actual
+=09)
+'
+
+# As the docs say, list tags which contain a specified *commit*. We
+# don't recurse down to tags for trees or blobs pointed to by *those*
+# commits.
+test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
+=09cd no-contains &&
+=09blob=3D$(git rev-parse v0.3:v0.3.t) &&
+=09tree=3D$(git rev-parse v0.3^{tree}) &&
+=09git tag tag-blob $blob &&
+=09git tag tag-tree $tree &&
+=09git tag --contains v0.3 >actual &&
+=09cat >expected <<-\EOF &&
+=09v0.3
+=09v0.4
+=09v0.5
+=09EOF
+=09test_cmp expected actual &&
+=09git tag --no-contains v0.3 >actual &&
+=09cat >expected <<-\EOF &&
+=09v0.1
+=09v0.2
+=09EOF
+=09test_cmp expected actual
+'
+
+test_done
diff --git a/t/t7031-verify-tag-signconfig.sh b/t/t7031-verify-tag-signconf=
ig.sh
new file mode 100755
index 000000000..b5238585a
--- /dev/null
+++ b/t/t7031-verify-tag-signconfig.sh
@@ -0,0 +1,175 @@
+#!/bin/sh
+
+test_description=3D'signed tag tests using new config'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed tags' '
+=09echo 1 >file && git add file &&
+=09test_tick && git commit -m initial &&
+=09git tag -s -m initial initial &&
+=09git branch side &&
+
+=09echo 2 >file && test_tick && git commit -a -m second &&
+=09git tag -s -m second second &&
+
+=09git checkout side &&
+=09echo 3 >elif && git add elif &&
+=09test_tick && git commit -m "third on side" &&
+
+=09git checkout master &&
+=09test_tick && git merge -S side &&
+=09git tag -s -m merge merge &&
+
+=09echo 4 >file && test_tick && git commit -a -S -m "fourth unsigned" &&
+=09git tag -a -m fourth-unsigned fourth-unsigned &&
+
+=09test_tick && git commit --amend -S -m "fourth signed" &&
+=09git tag -s -m fourth fourth-signed &&
+
+=09echo 5 >file && test_tick && git commit -a -m "fifth" &&
+=09git tag fifth-unsigned &&
+
+=09git config commit.sign true &&
+=09echo 6 >file && test_tick && git commit -a -m "sixth" &&
+=09git tag -a -m sixth sixth-unsigned &&
+
+=09test_tick && git rebase -f HEAD^^ && git tag -s -m 6th sixth-signed HEA=
D^ &&
+=09git tag -m seventh -s seventh-signed &&
+
+=09echo 8 >file && test_tick && git commit -a -m eighth &&
+=09git tag -uB7227189 -m eighth eighth-signed-alt
+'
+
+test_expect_success GPGSM 'create signed tags x509 ' '
+=09test_config signing.default x509 &&
+=09test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+=09echo 9 >file && test_tick && git commit -a -m "nineth gpgsm-signed" &&
+=09git tag -s -m nineth nineth-signed-x509
+'
+
+test_expect_success GPG 'verify and show signatures' '
+=09(
+=09=09for tag in initial second merge fourth-signed sixth-signed seventh-s=
igned
+=09=09do
+=09=09=09git verify-tag $tag 2>actual &&
+=09=09=09grep "Good signature from" actual &&
+=09=09=09! grep "BAD signature from" actual &&
+=09=09=09echo $tag OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+=09=09do
+=09=09=09test_must_fail git verify-tag $tag 2>actual &&
+=09=09=09! grep "Good signature from" actual &&
+=09=09=09! grep "BAD signature from" actual &&
+=09=09=09echo $tag OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for tag in eighth-signed-alt
+=09=09do
+=09=09=09git verify-tag $tag 2>actual &&
+=09=09=09grep "Good signature from" actual &&
+=09=09=09! grep "BAD signature from" actual &&
+=09=09=09grep "not certified" actual &&
+=09=09=09echo $tag OK || exit 1
+=09=09done
+=09)
+'
+
+test_expect_success GPGSM 'verify and show signatures x509' '
+=09git verify-tag nineth-signed-x509 2>actual &&
+=09grep "Good signature from" actual &&
+=09! grep "BAD signature from" actual &&
+=09echo nineth-signed-x509 OK
+'
+
+test_expect_success GPG 'detect fudged signature' '
+=09git cat-file tag seventh-signed >raw &&
+=09sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
+=09git hash-object -w -t tag forged1 >forged1.tag &&
+=09test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
+=09grep "BAD signature from" actual1 &&
+=09! grep "Good signature from" actual1
+'
+
+test_expect_success GPG 'verify signatures with --raw' '
+=09(
+=09=09for tag in initial second merge fourth-signed sixth-signed seventh-s=
igned
+=09=09do
+=09=09=09git verify-tag --raw $tag 2>actual &&
+=09=09=09grep "GOODSIG" actual &&
+=09=09=09! grep "BADSIG" actual &&
+=09=09=09echo $tag OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+=09=09do
+=09=09=09test_must_fail git verify-tag --raw $tag 2>actual &&
+=09=09=09! grep "GOODSIG" actual &&
+=09=09=09! grep "BADSIG" actual &&
+=09=09=09echo $tag OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for tag in eighth-signed-alt
+=09=09do
+=09=09=09git verify-tag --raw $tag 2>actual &&
+=09=09=09grep "GOODSIG" actual &&
+=09=09=09! grep "BADSIG" actual &&
+=09=09=09grep "TRUST_UNDEFINED" actual &&
+=09=09=09echo $tag OK || exit 1
+=09=09done
+=09)
+'
+
+test_expect_success GPGSM 'verify signatures with --raw x509' '
+=09git verify-tag --raw nineth-signed-x509 2>actual &&
+=09grep "GOODSIG" actual &&
+=09! grep "BADSIG" actual &&
+=09echo nineth-signed-x509 OK
+'
+
+test_expect_success GPG 'verify multiple tags' '
+=09tags=3D"fourth-signed sixth-signed seventh-signed" &&
+=09for i in $tags
+=09do
+=09=09git verify-tag -v --raw $i || return 1
+=09done >expect.stdout 2>expect.stderr.1 &&
+=09grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
+=09git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+=09grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
+=09test_cmp expect.stdout actual.stdout &&
+=09test_cmp expect.stderr actual.stderr
+'
+
+test_expect_success GPGSM 'verify multiple tags x509' '
+=09tags=3D"seventh-signed nineth-signed-x509" &&
+=09for i in $tags
+=09do
+=09=09git verify-tag -v --raw $i || return 1
+=09done >expect.stdout 2>expect.stderr.1 &&
+=09grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
+=09git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+=09grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
+=09test_cmp expect.stdout actual.stdout &&
+=09test_cmp expect.stderr actual.stderr
+'
+
+test_expect_success GPG 'verifying tag with --format' '
+=09cat >expect <<-\EOF &&
+=09tagname : fourth-signed
+=09EOF
+=09git verify-tag --format=3D"tagname : %(tag)" "fourth-signed" >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'verifying a forged tag with --format should fail =
silently' '
+=09test_must_fail git verify-tag --format=3D"tagname : %(tag)" $(cat forge=
d1.tag) >actual-forged &&
+=09test_must_be_empty actual-forged
+'
+
+test_done
diff --git a/t/t7522-signed-commit-signconfig.sh b/t/t7522-signed-commit-si=
gnconfig.sh
new file mode 100755
index 000000000..682b23a06
--- /dev/null
+++ b/t/t7522-signed-commit-signconfig.sh
@@ -0,0 +1,288 @@
+#!/bin/sh
+
+test_description=3D'signed commit tests'
+. ./test-lib.sh
+GNUPGHOME_NOT_USED=3D$GNUPGHOME
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed commits' '
+=09test_when_finished "test_unconfig commit.gpgsign" &&
+
+=09echo 1 >file && git add file &&
+=09test_tick && git commit -S -m initial &&
+=09git tag initial &&
+=09git branch side &&
+
+=09echo 2 >file && test_tick && git commit -a -S -m second &&
+=09git tag second &&
+
+=09git checkout side &&
+=09echo 3 >elif && git add elif &&
+=09test_tick && git commit -m "third on side" &&
+
+=09git checkout master &&
+=09test_tick && git merge -S side &&
+=09git tag merge &&
+
+=09echo 4 >file && test_tick && git commit -a -m "fourth unsigned" &&
+=09git tag fourth-unsigned &&
+
+=09test_tick && git commit --amend -S -m "fourth signed" &&
+=09git tag fourth-signed &&
+
+=09git config commit.gpgsign true &&
+=09echo 5 >file && test_tick && git commit -a -m "fifth signed" &&
+=09git tag fifth-signed &&
+
+=09git config commit.gpgsign false &&
+=09echo 6 >file && test_tick && git commit -a -m "sixth" &&
+=09git tag sixth-unsigned &&
+
+=09git config commit.gpgsign true &&
+=09echo 7 >file && test_tick && git commit -a -m "seventh" --no-gpg-sign &=
&
+=09git tag seventh-unsigned &&
+
+=09test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
+=09git tag seventh-signed &&
+
+=09echo 8 >file && test_tick && git commit -a -m eighth -SB7227189 &&
+=09git tag eighth-signed-alt &&
+
+=09# commit.gpgsign is still on but this must not be signed
+=09echo 9 | git commit-tree HEAD^{tree} >oid &&
+=09test_line_count =3D 1 oid &&
+=09git tag ninth-unsigned $(cat oid) &&
+=09# explicit -S of course must sign.
+=09echo 10 | git commit-tree -S HEAD^{tree} >oid &&
+=09test_line_count =3D 1 oid &&
+=09git tag tenth-signed $(cat oid) &&
+
+=09# --gpg-sign[=3D<key-id>] must sign.
+=09echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
+=09test_line_count =3D 1 oid &&
+=09git tag eleventh-signed $(cat oid) &&
+=09echo 12 | git commit-tree --gpg-sign=3DB7227189 HEAD^{tree} >oid &&
+=09test_line_count =3D 1 oid &&
+=09git tag twelfth-signed-alt $(cat oid)
+'
+
+test_expect_success GPG 'verify and show signatures' '
+=09(
+=09=09for commit in initial second merge fourth-signed \
+=09=09=09fifth-signed sixth-signed seventh-signed tenth-signed \
+=09=09=09eleventh-signed
+=09=09do
+=09=09=09git verify-commit $commit &&
+=09=09=09git show --pretty=3Dshort --show-signature $commit >actual &&
+=09=09=09grep "Good signature from" actual &&
+=09=09=09! grep "BAD signature from" actual &&
+=09=09=09echo $commit OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for commit in merge^2 fourth-unsigned sixth-unsigned \
+=09=09=09seventh-unsigned ninth-unsigned
+=09=09do
+=09=09=09test_must_fail git verify-commit $commit &&
+=09=09=09git show --pretty=3Dshort --show-signature $commit >actual &&
+=09=09=09! grep "Good signature from" actual &&
+=09=09=09! grep "BAD signature from" actual &&
+=09=09=09echo $commit OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for commit in eighth-signed-alt twelfth-signed-alt
+=09=09do
+=09=09=09git show --pretty=3Dshort --show-signature $commit >actual &&
+=09=09=09grep "Good signature from" actual &&
+=09=09=09! grep "BAD signature from" actual &&
+=09=09=09grep "not certified" actual &&
+=09=09=09echo $commit OK || exit 1
+=09=09done
+=09)
+'
+
+test_expect_success GPG 'verify-commit exits success on untrusted signatur=
e' '
+=09git verify-commit eighth-signed-alt 2>actual &&
+=09grep "Good signature from" actual &&
+=09! grep "BAD signature from" actual &&
+=09grep "not certified" actual
+'
+
+test_expect_success GPG 'verify signatures with --raw' '
+=09(
+=09=09for commit in initial second merge fourth-signed fifth-signed sixth-=
signed seventh-signed
+=09=09do
+=09=09=09git verify-commit --raw $commit 2>actual &&
+=09=09=09grep "GOODSIG" actual &&
+=09=09=09! grep "BADSIG" actual &&
+=09=09=09echo $commit OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigne=
d
+=09=09do
+=09=09=09test_must_fail git verify-commit --raw $commit 2>actual &&
+=09=09=09! grep "GOODSIG" actual &&
+=09=09=09! grep "BADSIG" actual &&
+=09=09=09echo $commit OK || exit 1
+=09=09done
+=09) &&
+=09(
+=09=09for commit in eighth-signed-alt
+=09=09do
+=09=09=09git verify-commit --raw $commit 2>actual &&
+=09=09=09grep "GOODSIG" actual &&
+=09=09=09! grep "BADSIG" actual &&
+=09=09=09grep "TRUST_UNDEFINED" actual &&
+=09=09=09echo $commit OK || exit 1
+=09=09done
+=09)
+'
+
+test_expect_success GPG 'show signed commit with signature' '
+=09git show -s initial >commit &&
+=09git show -s --show-signature initial >show &&
+=09git verify-commit -v initial >verify.1 2>verify.2 &&
+=09git cat-file commit initial >cat &&
+=09grep -v -e "gpg: " -e "Warning: " show >show.commit &&
+=09grep -e "gpg: " -e "Warning: " show >show.gpg &&
+=09grep -v "^ " cat | grep -v "^gpgsig " >cat.commit &&
+=09test_cmp show.commit commit &&
+=09test_cmp show.gpg verify.2 &&
+=09test_cmp cat.commit verify.1
+'
+
+test_expect_success GPG 'detect fudged signature' '
+=09git cat-file commit seventh-signed >raw &&
+=09sed -e "s/^seventh/7th forged/" raw >forged1 &&
+=09git hash-object -w -t commit forged1 >forged1.commit &&
+=09test_must_fail git verify-commit $(cat forged1.commit) &&
+=09git show --pretty=3Dshort --show-signature $(cat forged1.commit) >actua=
l1 &&
+=09grep "BAD signature from" actual1 &&
+=09! grep "Good signature from" actual1
+'
+
+test_expect_success GPG 'detect fudged signature with NUL' '
+=09git cat-file commit seventh-signed >raw &&
+=09cat raw >forged2 &&
+=09echo Qwik | tr "Q" "\000" >>forged2 &&
+=09git hash-object -w -t commit forged2 >forged2.commit &&
+=09test_must_fail git verify-commit $(cat forged2.commit) &&
+=09git show --pretty=3Dshort --show-signature $(cat forged2.commit) >actua=
l2 &&
+=09grep "BAD signature from" actual2 &&
+=09! grep "Good signature from" actual2
+'
+
+test_expect_success GPG 'amending already signed commit' '
+=09git checkout fourth-signed^0 &&
+=09git commit --amend -S --no-edit &&
+=09git verify-commit HEAD &&
+=09git show -s --show-signature HEAD >actual &&
+=09grep "Good signature from" actual &&
+=09! grep "BAD signature from" actual
+'
+
+test_expect_success GPG 'show good signature with custom format' '
+=09cat >expect <<-\EOF &&
+=09G
+=0913B6F51ECDDE430D
+=09C O Mitter <committer@example.com>
+=0973D758744BE721698EC54E8713B6F51ECDDE430D
+=0973D758744BE721698EC54E8713B6F51ECDDE430D
+=09EOF
+=09git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'show bad signature with custom format' '
+=09cat >expect <<-\EOF &&
+=09B
+=0913B6F51ECDDE430D
+=09C O Mitter <committer@example.com>
+
+
+=09EOF
+=09git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >=
actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with custom format' '
+=09cat >expect <<-\EOF &&
+=09U
+=0965A0EEA02E30CAD7
+=09Eris Discordia <discord@example.net>
+=09F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+=09D4BE22311AD3131E5EDA29A461092E85B7227189
+=09EOF
+=09git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actu=
al &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'show unknown signature with custom format' '
+=09cat >expect <<-\EOF &&
+=09E
+=0965A0EEA02E30CAD7
+
+
+
+=09EOF
+=09GNUPGHOME=3D"$GNUPGHOME_NOT_USED" git log -1 --format=3D"%G?%n%GK%n%GS%=
n%GF%n%GP" eighth-signed-alt >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'show lack of signature with custom format' '
+=09cat >expect <<-\EOF &&
+=09N
+
+
+
+
+=09EOF
+=09git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actua=
l &&
+=09test_cmp expect actual
+'
+
+test_expect_success GPG 'log.showsignature behaves like --show-signature' =
'
+=09test_config log.showsignature true &&
+=09git show initial >actual &&
+=09grep "gpg: Signature made" actual &&
+=09grep "gpg: Good signature" actual
+'
+
+test_expect_success GPG 'check config gpg.format values' '
+=09test_config gpg.format openpgp &&
+=09git commit -S --amend -m "success" &&
+=09test_config gpg.format OpEnPgP &&
+=09test_must_fail git commit -S --amend -m "fail"
+'
+
+test_expect_success GPG 'detect fudged commit with double signature' '
+=09sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
+=09sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
+=09=09sed -e "s/^gpgsig//;s/^ //" | gpg --dearmor >double-sig1.sig &&
+=09gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
+=09cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.as=
c &&
+=09sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/gpgsig /;2,\$s/^/ /" \
+=09=09double-combined.asc > double-gpgsig &&
+=09sed -e "/committer/r double-gpgsig" double-base >double-commit &&
+=09git hash-object -w -t commit double-commit >double-commit.commit &&
+=09test_must_fail git verify-commit $(cat double-commit.commit) &&
+=09git show --pretty=3Dshort --show-signature $(cat double-commit.commit) =
>double-actual &&
+=09grep "BAD signature from" double-actual &&
+=09grep "Good signature from" double-actual
+'
+
+test_expect_success GPG 'show double signature with custom format' '
+=09cat >expect <<-\EOF &&
+=09E
+
+
+
+
+=09EOF
+=09git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.com=
mit) >actual &&
+=09test_cmp expect actual
+'
+
+test_done
--=20
2.11.0


