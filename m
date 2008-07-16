From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 3/3] Add git-sequencer test suite (t3350)
Date: Wed, 16 Jul 2008 22:45:18 +0200
Message-ID: <fd9b4f2b04c9b997c6bdba90352eb1ef973114ae.1216233915.git.s-beyer@gmx.net>
References: <14224c96008f30754acb021bc0af6b6641897a1e.1216233915.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDty-0004gx-Ph
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbYGPUps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbYGPUpq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:59199 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756238AbYGPUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:32 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp007) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005ns-Dh; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <14224c96008f30754acb021bc0af6b6641897a1e.1216233915.git.s-beyer@gmx.net> 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88753>

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t3350-sequencer.sh |  838 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 838 insertions(+), 0 deletions(-)
 create mode 100755 t/t3350-sequencer.sh

diff --git a/t/t3350-sequencer.sh b/t/t3350-sequencer.sh
new file mode 100755
index 0000000..3cc7da8
--- /dev/null
+++ b/t/t3350-sequencer.sh
@@ -0,0 +1,838 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Stephan Beyer
+#
+# `setup' is based on t3404* by Johannes Schindelin.
+
+test_description='git sequencer
+
+These are basic usage tests for git sequencer.
+'
+. ./test-lib.sh
+
+# set up two branches like this:
+#
+# A - B - C - D - E
+#   \
+#     F - G - H
+#       \
+#         I
+#
+# where B, D and G touch increment value in file1.
+# The others generate empty file[23456].
+
+SEQDIR=".git/sequencer"
+SEQMARK="refs/sequencer-marks"
+MARKDIR=".git/$SEQMARK"
+
+test_expect_success 'setup' '
+	: >file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "generate empty file1" &&
+	git tag A &&
+	echo 1 >file1 &&
+	test_tick &&
+	git commit -m "write 1 into file1" file1 &&
+	git tag B &&
+	: >file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m "generate empty file2" &&
+	git tag C &&
+	echo 2 >file1 &&
+	test_tick &&
+	git commit -m "write 2 into file1" file1 &&
+	git tag D &&
+	: >file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m "generate empty file3" &&
+	git tag E &&
+	git checkout -b branch1 A &&
+	: >file4 &&
+	git add file4 &&
+	test_tick &&
+	git commit -m "generate empty file4" &&
+	git tag F &&
+	echo 3 >file1 &&
+	test_tick &&
+	git commit -m "write 3 into file1" file1 &&
+	git tag G &&
+	: >file5 &&
+	git add file5 &&
+	test_tick &&
+	git commit -m "generate empty file5" &&
+	git tag H &&
+	git checkout -b branch2 F &&
+	: >file6 &&
+	git add file6 &&
+	test_tick &&
+	git commit -m "generate empty file6" &&
+	git tag I &&
+	git diff -p --raw C..D >patchD.raw &&
+	git diff -p --raw A..F >patchF.raw &&
+	git format-patch --stdout A..B >patchB &&
+	git format-patch --stdout B..C >patchC &&
+	git format-patch --stdout C..D >patchD &&
+	git format-patch --stdout A..F >patchF &&
+	git format-patch --stdout F..G >patchG
+'
+
+orig_author="$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+
+# Functions to verify exit status of sequencer.
+# Do not just use "test_must_fail git sequencer ..."!
+expect_fail () {
+	"$@"
+	test $? -eq 1
+}
+expect_continue () {
+	"$@"
+	test $? -eq 2
+}
+expect_conflict () {
+	"$@"
+	test $? -eq 3
+}
+
+
+# Other test helpers:
+
+# Test if commit $1 has author $2
+expect_author () {
+	test "$2" = "$(git cat-file commit "$1" |
+		sed -n -e "s/^author \(.*\)> .*$/\1>/p")"
+}
+
+# Test if commit $1 has commit message in file $2
+# Side effect: overwrites actual
+expect_msg () {
+	git cat-file commit "$1" | sed -e "1,/^$/d" >actual &&
+	test_cmp "$2" actual
+}
+
+# Test that no marks are set.
+no_marks_set () {
+	if test -e "$MARKDIR"
+	then
+		rmdir "$MARKDIR"
+	fi
+}
+
+test_expect_success 'fail on empty TODO from stdin' '
+	expect_fail git sequencer <file6 &&
+	! test -d "$SEQDIR"
+'
+
+# Generate fake editor
+#
+# Simple and practical concept:
+#  We use only a small string identifier for "editor sessions".
+#  Each sessions knows what to do and perhaps defines
+#  which session to choose next.
+echo "#!$SHELL_PATH" >fake-editor.sh
+cat >>fake-editor.sh <<\EOF
+test -f fake-editor-session || exit 1
+#test -t 1 || exit 1
+# This test could be useful, but as the test-lib is not always
+# verbose, this will fail.
+next=ok
+read this <fake-editor-session
+case "$this" in
+commitmsg)
+	echo 'echo 2 >file1'
+	;;
+squashCE)
+	echo 'generate file2 and file3'
+	;;
+squashCI)
+	echo 'generate file2 and file6'
+	next=squashDCE
+	;;
+squashDCE)
+	echo 'generate file2 and file3 and write 2 into file1'
+	next=merge1
+	;;
+merge1)
+	echo 'A typed merge message.'
+	;;
+merge2)
+	test "$(sed -n -e 1p "$1")" = 'test merge' &&
+		echo 'cleanup merge' ||
+		echo error
+	sed -e 1d "$1"
+	;;
+editXXXXXXXXX)
+	printf 'last edited'
+	;;
+edit*)
+	printf 'edited: '
+	cat "$1"
+	next="${this}X"
+	;;
+nochange)
+	cat "$1"
+	;;
+ok|fail)
+	echo '-- THIS IS UNEXPECTED --'
+	next=fail
+	;;
+*)
+	echo 'I do not know.'
+	;;
+esac >"$1".tmp
+mv "$1".tmp "$1"
+echo $next >fake-editor-session
+exit 0
+EOF
+chmod a+x fake-editor.sh
+test_set_editor "$(pwd)/fake-editor.sh"
+
+next_session () {
+	echo "$1" >fake-editor-session
+}
+
+# check if fake-editor-session is ok.
+# If "$1" is set to anything, it will set the
+# next session to "ok", which is nice for
+# test_expect_failure.
+session_ok () {
+	test "ok" = $(cat fake-editor-session)
+	ret=$?
+	test -n "$1" && next_session ok
+	return $ret
+}
+
+
+cat >todotest1 <<EOF
+pick C
+squash E
+ref refs/tags/CE
+EOF
+
+test_expect_success '"pick", "squash", "ref" from stdin' '
+	next_session squashCE &&
+	git sequencer <todotest1 &&
+	! test -d "$SEQDIR" &&
+	session_ok &&
+	test -f file2 &&
+	test -f file3 &&
+	test $(git rev-parse CE) = $(git rev-parse HEAD) &&
+	test $(git rev-parse I) = $(git rev-parse HEAD^)
+'
+
+cat >todotest2 <<EOF
+# This is a test
+
+reset I  # go back to I
+
+EOF
+
+test_expect_success '"reset" from file with comments and blank lines' '
+	git sequencer todotest2 &&
+	session_ok &&
+	test $(git rev-parse I) = $(git rev-parse HEAD)
+'
+
+cat >todotest1 <<EOF
+pick C
+EOF
+
+test_expect_success '--onto <branch> keeps branch' '
+	git checkout -b test-branch A &&
+	git checkout master &&
+	git sequencer --onto test-branch <todotest1 &&
+	session_ok &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-branch" &&
+	test "$(git rev-parse test-branch^)" = "$(git rev-parse A)"
+'
+
+test_expect_success '--onto commit (detached HEAD) works' '
+	git sequencer --onto A <todotest1 &&
+	session_ok &&
+	test_must_fail git symbolic-ref -q HEAD &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse test-branch)"
+'
+
+echo 'pick -R C' >>todotest1
+
+test_expect_success 'pick -R works' '
+	git checkout A &&
+	git sequencer todotest1 &&
+	session_ok &&
+	! test -f file2
+'
+
+mkdir testdir
+cat >testdir/script <<EOF
+#!/bin/sh
+test -s ../file1
+EOF
+chmod 755 testdir/script
+cat >todotest1 <<EOF
+run -- test -s file1  # this will fail
+pick B
+run --dir testdir -- test -s ../file1
+pick D
+run --dir=testdir ./script
+EOF
+
+test_expect_success '"run" insn works' '
+	git checkout A &&
+	expect_conflict git sequencer todotest1 &&
+	: >newfile &&
+	git add newfile &&
+	next_session nochange &&
+	git sequencer --continue &&
+	session_ok &&
+	test -f newfile
+'
+
+echo thisdoesnotexist >>todotest1
+
+test_expect_success 'junk is conflict' '
+	git checkout A &&
+	expect_conflict git sequencer todotest1 &&
+	test -d "$SEQDIR" &&
+	git sequencer --abort &&
+	! test -d "$SEQDIR" &&
+	session_ok &&
+	test $(git rev-parse A) = $(git rev-parse HEAD)
+'
+
+GIT_AUTHOR_NAME="Another 'ant' Thor"
+GIT_AUTHOR_EMAIL="a.thor@example.com"
+GIT_COMMITTER_NAME="Co M Miter"
+GIT_COMMITTER_EMAIL="c.miter@example.com"
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+yet_another="Max Min <mm@example.com>"
+
+cat >todotest1 <<EOF
+patch patchB      # write 1 into file1
+patch -k patchC   # generate file2
+patch patchD.raw  # write 2 into file1
+EOF
+
+echo 'write 1 into file1' >expected1
+echo '[PATCH] generate empty file2' >expected2
+echo 'echo 2 >file1' >expected3
+
+test_expect_success '"patch" insn works' '
+	git checkout A &&
+	next_session commitmsg &&
+	git sequencer todotest1 &&
+	! test -d "$SEQDIR" &&
+	session_ok &&
+	test "$(git rev-parse HEAD~3)" = "$(git rev-parse A)" &&
+	test "$(git show HEAD~2:file1)" = "1" &&
+	test -z "$(git show HEAD^:file2)" &&
+	test "$(git show HEAD:file1)" = "2" &&
+	expect_author HEAD~2 "$orig_author" &&
+	expect_author HEAD~1 "$orig_author" &&
+	expect_author HEAD~0 "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" &&
+	expect_msg HEAD~2 expected1 &&
+	expect_msg HEAD~1 expected2 &&
+	expect_msg HEAD~0 expected3
+'
+
+cat >todotest1 <<EOF
+pick B	# write 1 into file1
+pause
+pick C	# generate file2
+EOF
+
+echo 'generate empty file2' >expected1
+echo 'write 1 into file1' >expected2
+
+test_expect_success "pick ; pause insns and --continue works" '
+	git checkout A &&
+	expect_continue git sequencer todotest1 &&
+	session_ok &&
+	echo 5 >file1 &&
+	git add file1 &&
+	next_session nochange &&
+	git sequencer --continue &&
+	test "$(git show HEAD:file1)" = 5 &&
+	test -z "$(git show HEAD:file2)" &&
+	expect_msg HEAD expected1 &&
+	expect_msg HEAD^ expected2 &&
+	session_ok
+'
+
+cat >todotest1 <<EOF
+edit B	# write 1 into file1
+pick C	# generate file2
+EOF
+
+test_expect_success "edit insn and --continue works" '
+	git checkout A &&
+	expect_continue git sequencer todotest1 &&
+	session_ok &&
+	echo 5 >file1 &&
+	git add file1 &&
+	next_session nochange &&
+	git sequencer --continue &&
+	test "$(git show HEAD:file1)" = 5 &&
+	test -z "$(git show HEAD:file2)" &&
+	expect_msg HEAD expected1 &&
+	expect_msg HEAD^ expected2 &&
+	session_ok
+'
+
+cat >todotest1 <<EOF
+patch patchB	# write 1 into file1
+pick H		# generate file5
+mark :1
+patch patchC	# generate file2
+squash I	# generate file6
+patch patchD	# write 2 into file1
+ref refs/tags/CID
+mark :2
+reset :1	# reset to new H
+patch patchD	# write 2 into file1
+squash CE	# generate file2 and file3
+ref refs/tags/DCE
+merge :2	# merge :2 into HEAD
+patch patchF	# generate file4
+EOF
+
+test_expect_success 'all insns work without options' '
+	git checkout A &&
+	next_session squashCI &&
+	no_marks_set &&
+	git sequencer todotest1 &&
+	no_marks_set &&
+	test "$(git show HEAD:file1)" = "2" &&
+	test -z "$(git show HEAD:file2)" &&
+	test -z "$(git show HEAD:file3)" &&
+	test -z "$(git show HEAD:file4)" &&
+	test -z "$(git show HEAD:file5)" &&
+	test -z "$(git show HEAD:file6)" &&
+	echo "$(git rev-parse DCE)" >expected &&
+	echo "$(git rev-parse CID)" >>expected &&
+	git cat-file commit HEAD^ | sed -n -e "s/^parent //p" >actual &&
+	test_cmp expected actual &&
+	session_ok
+'
+
+cat >todotest1 <<EOF
+merge --standard DCE
+EOF
+
+echo "Merge DCE into HEAD" >expected1
+
+test_expect_success 'merge --standard works' '
+	git checkout CID &&
+	git sequencer todotest1 &&
+	expect_msg HEAD expected1 &&
+	session_ok
+'
+
+cat >todotest1 <<EOF
+merge --standard --message="foo" DCE
+EOF
+
+
+test_expect_success 'merge --standard --message="foo" is conflict' '
+	git checkout CID &&
+	expect_conflict git sequencer todotest1 &&
+	git sequencer --abort &&
+	session_ok
+'
+
+for command in 'pick ' 'patch patch' 'squash ' 'merge --standard '
+do
+	cat >todotest1 <<EOF
+patch patchB	# 1 into file1
+${command}G	# 3 into file1
+patch -3 patchF	# empty file4
+EOF
+
+	test_expect_success "conflict test: ${command%% *} and --abort" '
+		git checkout A &&
+		expect_conflict git sequencer todotest1 &&
+		session_ok &&
+		test -d "$SEQDIR" &&
+		git sequencer --abort &&
+		session_ok &&
+		test $(git rev-parse HEAD) = $(git rev-parse A)
+	'
+
+	test_expect_success "conflict test: ${command%% *} and --continue" '
+		git checkout A &&
+		expect_conflict git sequencer todotest1 &&
+		session_ok &&
+		test -d "$SEQDIR" &&
+		## XXX: It would be perfect if we could remove the if
+		{ if test "${command%% *}" != "patch"
+		then grep "^<<<<<<<" file1 ; fi } &&
+		echo 3 >file1 &&
+		git add file1 &&
+		next_session nochange &&
+		git sequencer --continue &&
+		session_ok &&
+		! test -d "$SEQDIR" &&
+		test "$(git show HEAD:file1)" = "3" &&
+		test -f file4
+	'
+
+	test_expect_success "conflict test: ${command%% *} and --skip" '
+		git checkout A &&
+		expect_conflict git sequencer todotest1 &&
+		session_ok &&
+		test -d "$SEQDIR" &&
+		git sequencer --skip &&
+		session_ok &&
+		! test -d "$SEQDIR" &&
+		test "$(git show HEAD:file1)" = "1" &&
+		test -f file4
+	'
+done
+
+echo 'file5-gen' >commitmsg
+
+cat >todotest1 <<EOF
+patch --signoff patchB
+pause
+pick --author="$yet_another" --file="commitmsg" --signoff H
+mark :1
+patch --message="file2-gen" patchC
+squash --signoff --author="$yet_another" I
+pause
+patch --message="echo 2 >file1" patchD
+mark :2
+reset :1
+patch --author="$yet_another" patchD
+squash --signoff --message="generate file[23]" CE
+merge --signoff --message="test merge" --author="$yet_another" :2
+pause
+ref refs/tags/a_merge
+patch --message="Generate file4 and write 23 into it" patchF.raw
+pause
+pick I
+EOF
+
+cat >expected1 <<EOF
+write 1 into file
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+test_expect_success 'insns work with options and another author 1' '
+	git checkout A &&
+	no_marks_set &&
+
+	# patch --signoff patchB  # write 1 into file1
+	# pause
+	expect_continue git sequencer todotest1 &&
+	test "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" = \
+		"$(git cat-file commit HEAD | grep "^Signed-off-by")" &&
+	expect_author HEAD "$orig_author" &&
+	test -d "$SEQDIR" &&
+	session_ok
+'
+
+cat >expected1 <<EOF
+file5-gen
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+cat >expected2 <<EOF
+file2-gen
+
+generate empty file6
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+test_expect_success 'insns work with options and another author 2' '
+	: >file7 &&
+	git add file7 &&
+	next_session nochange &&
+	git commit --amend &&
+	session_ok &&
+
+	next_session nochange &&
+	expect_continue git sequencer --continue &&
+	session_ok &&
+
+	# amended commit
+	test "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" = \
+		"$(git cat-file commit HEAD^^ | grep "^Signed-off-by")" &&
+	expect_author HEAD^^ "$orig_author" &&
+	test -z "$(git show HEAD:file7)" &&
+
+	# pick --author="$yet_another" --file="commitmsg" --signoff H
+	expect_author HEAD^ "$yet_another" &&
+	expect_msg HEAD^ expected1 &&
+	test -z "$(git show HEAD:file5)" &&
+
+	# mark :1
+	test "$(git rev-parse "$SEQMARK/1")" = "$(git rev-parse HEAD^)" &&
+
+	# patch --message="file2-gen" patchC
+	# squash --signoff --author="$yet_another" I # generate file6
+	# pause
+	test -z "$(git show HEAD:file2)" &&
+	test -z "$(git show HEAD:file6)" &&
+	git ls-files | grep "^file2" &&
+	git ls-files | grep "^file6" &&
+	expect_msg HEAD expected2 &&
+	expect_author HEAD "$yet_another"
+'
+
+echo 'echo 2 >file1' >expected1
+
+cat >expected2 <<EOF
+generate file[23]
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+cat >expected3 <<EOF
+test merge
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+cat >expected4 <<EOF
+file1
+file2
+file3
+file5
+file6
+file7
+EOF
+
+test_expect_success 'insns work with options and another author 3' '
+	# do not change anything
+	expect_continue git sequencer --continue &&
+	session_ok &&
+
+	# patch --message="echo 2 >file1" patchD
+	# mark :2
+	commit="$(git rev-parse --verify "$SEQMARK/2")" &&
+	expect_author "$commit" "$orig_author" &&
+	expect_msg "$commit" expected1 &&
+
+	# reset :1
+	# patch --author="$yet_another" patchD # write 2 into file1
+	# squash --signoff --message="generate file[23]" CE
+	expect_author HEAD^ "$yet_another" &&
+	expect_msg HEAD^ expected2 &&
+
+	# merge --signoff --message="test merge" --author="$yet_another" :2
+	# pause
+	expect_author HEAD "$yet_another" &&
+	expect_msg HEAD expected3 &&
+	git ls-files >actual &&
+	test_cmp expected4 actual
+'
+
+cat >expected_merge <<EOF
+cleanup merge
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+echo 'Generate file4 and write 23 into it' >expected2
+
+test_expect_success 'insns work with options and another author 4' '
+	git rm file5 file6 file7 &&
+	next_session merge2 &&
+	expect_continue git sequencer --continue &&
+	session_ok &&
+
+	# ref refs/tags/a_merge
+	expect_author a_merge "$yet_another" &&
+	expect_msg a_merge expected_merge &&
+
+	# patch --message="Generate file4 and write 23 into it" patchF.raw
+	# pause
+	git ls-files | grep "^file4" &&
+	echo 23 >file4 &&
+	git add file4 &&
+	next_session nochange &&
+	git sequencer --continue &&
+	session_ok &&
+	no_marks_set &&
+	test "$(git show HEAD:file1)" = "2" &&
+	test "$(git show HEAD:file4)" = "23" &&
+	expect_msg HEAD^ expected2 &&
+	expect_author HEAD^ "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" &&
+
+	# pick I
+	test -z "$(git show HEAD:file6)" &&
+	git ls-files | grep "^file6" &&
+	session_ok
+'
+
+# almost the same to test --quiet
+cat >todotest1 <<EOF
+patch patchB
+pick H
+mark :1
+patch patchC
+squash --message="a squash" I
+patch patchD
+mark :2
+reset :1
+patch patchD
+squash --message="another squash" CE
+merge --message="test merge" :2
+pause
+patch patchF
+EOF
+
+test_expect_failure '--quiet works' '
+	git checkout A &&
+	expect_continue git sequencer --quiet todotest1 >actual &&
+	session_ok &&
+	! test -s actual
+'
+
+test_expect_failure '--quiet works on continue' '
+	git sequencer --continue >>actual &&
+	session_ok &&
+	! test -s actual
+'
+
+echo 'merge --strategy=ours --reuse-commit=a_merge branch1 branch2 CE CID' >todotest1
+
+test_expect_success 'merge multiple branches and --reuse-commit works' '
+	git checkout -b merge-multiple master &&
+	git sequencer todotest1 &&
+	session_ok &&
+	expect_msg HEAD expected_merge &&
+	git rev-parse HEAD^ >expected &&
+	git rev-parse branch1 >>expected &&
+	git rev-parse branch2 >>expected &&
+	git rev-parse CE >>expected &&
+	git rev-parse CID >>expected &&
+	git cat-file commit HEAD | sed -n -e "s/^parent //p" >actual &&
+	test_cmp expected actual &&
+	! test -f file6
+'
+
+echo 'pick --mainline=5 merge-multiple' >todotest1
+
+test_expect_success 'pick --mainline works' '
+	git checkout -b mainline CID &&
+	git sequencer todotest1 &&
+	session_ok &&
+	expect_msg HEAD expected_merge &&
+	! test -f file6 &&
+	test -f file3 &&
+	test -f file2 &&
+	test "$(git show HEAD:file1)" = 2
+'
+
+cat >todotest1 <<EOF
+pick C		# file2
+mark :1
+patch patchB	# write 1 into file1
+patch patchD	# write 2 into file1
+pick I		# file6
+squash --message="2 in file1 and file6 exists" --signoff --from :1
+EOF
+
+cat >expected1 <<EOF
+2 in file1 and file6 exists
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+EOF
+
+test_expect_success 'squash --from works' '
+	git checkout A &&
+	git sequencer <todotest1 &&
+	session_ok &&
+	test "$(git rev-parse A)" = "$(git rev-parse HEAD~2)" &&
+	test "$(git show HEAD:file1)" = "2" &&
+	test -z "$(git show HEAD:file6)" &&
+	expect_msg HEAD expected1
+'
+
+cat >todotest1 <<EOF
+patch patchB	# write 1 into file1
+pick H		# generate file5
+mark :1
+patch patchC	# generate file2
+squash --message="file5" I	# generate file6
+patch patchD	# write 2 into file1
+mark :2
+reset :1	# reset to new H
+patch patchD	# write 2 into file1
+squash --message="CE" CE	# generate file2 and file3
+merge --standard :2	# merge :2 into HEAD
+patch patchF	# generate file4
+EOF
+cp todotest1 todotest2
+cat todotest1 | sed -e 's/^\(patch\|pick\|squash\|merge\) /&--edit /' >todotest3
+echo 'squash --message="doesnt work either" --from :1' >>todotest1
+echo 'squash --include-merges --message="stupid" --from :1' >>todotest2
+
+test_expect_success 'squash --from conflicts with merge in between' '
+	git checkout A &&
+	expect_conflict git sequencer todotest1 &&
+	git sequencer --abort &&
+	session_ok &&
+	! test -d "$SEQDIR"
+'
+
+test_expect_success 'squash --include-merges --from succeeds with merge in between' '
+	git checkout A &&
+	git sequencer todotest2 &&
+	session_ok &&
+	test "$(git rev-parse HEAD~3)" = "$(git rev-parse A)"
+'
+
+test_expect_success 'patch|pick|squash|merge --edit works' '
+	git checkout A &&
+	next_session editX &&
+	git sequencer todotest3 &&
+	session_ok
+'
+
+cat >todotest1 <<EOF
+patch patchB
+pause
+EOF
+
+test_expect_success 'batch mode fails on pause insn' '
+	git checkout A &&
+	expect_fail git sequencer --batch todotest1 &&
+	session_ok &&
+	! test -d "$SEQDIR"
+'
+
+cat >todotest1 <<EOF
+patch patchB
+pick G
+EOF
+
+test_expect_success 'batch mode fails on conflict' '
+	git checkout A &&
+	expect_fail git sequencer --batch <todotest1 &&
+	session_ok &&
+	! test -d "$SEQDIR" &&
+	test -z "$(git show HEAD:file1)"
+'
+
+cat >todotest1 <<EOF
+patch patchB
+pause
+EOF
+
+test_expect_success '--caller works' '
+	git checkout A &&
+	expect_continue git sequencer \
+		--caller="this works|abrt||skip" todotest1 &&
+	expect_fail git sequencer --abort &&
+	expect_fail git sequencer --skip &&
+	git sequencer --continue &&
+	session_ok
+'
+
+test_done
-- 
1.5.6.3.391.ge45b
