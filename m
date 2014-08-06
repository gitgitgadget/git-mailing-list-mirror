From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 04/23] rebase -i: hide interactive command messages in verbose mode
Date: Thu,  7 Aug 2014 01:59:11 +0200
Message-ID: <6d4f66b21315661e4f267f59341ebb798232a381.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8N-0003kY-Gv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbaHGAAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:33 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:52267 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHGAAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:31 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so3200881qae.20
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qY0g0DyCwYDB7j8UIso5SWLYW1EWaqpEMLtBxvH9AeQ=;
        b=tcG/hLntotg4wMbLP3FWr67ZOM41yP99v5J+8/BWxlTiOnI2gD40Z7c+K9E6us/udz
         Q35wWoH/Q2m7rZ1MJE6+n0q768I9DrmQa0/4sUhuxHS5Rtp4sauwDGuYkxh3QbzcwWvT
         0q5yV3G7Ii/8ovMKvooZEY3tD2paG3XS3iTzwBGM6TH6TgHUizBrxQqS6p6ribFUS1oE
         tILLmZDhomVsHT8m8c6g/duPTML7jNd2PtW3YyrrBKSlkOBPgb6QQ5KStD52QfU5A8lc
         0HZPwBVdP1q6cRkzcJPdkwnCR6JrY4iaL+wB0iVkmof+oOpDFU00TlpX9MR+X6fg4SlX
         8KyA==
X-Received: by 10.224.53.137 with SMTP id m9mr21931235qag.66.1407369631272;
        Wed, 06 Aug 2014 17:00:31 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254921>

git-rebase--interactive prints summary messages of the commits it
creates in the final history only if the `--verbose` option is
specified by the user and suppresses them otherwise. This behaviour
is implemented by wrapping git-commit calls in a shell function named
`output` which redirects stderr to stdout, captures stdout in a shell
variable and ignores its contents unless the command exits with an
error status.

The command lines used to implement the to-do list commands `reword`
and `squash` print diagnostic messages even in non-verbose mode. The
reason for this inconsistency is that both commands launch the log
message editor which usually requires a working terminal attached to
stdin. Temporarily redirect the editor output to a third file
descriptor in order to ship it around the capture stream. Wrap the
respective git-commit command lines in `output`.

fake_editor prints the to-do list before and after applying the
`FAKE_LINES` rewrite rules to it. Redirect this debug output to
stderr so that it does not interfere with the git-rebase status
output. Add test.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  9 +++++----
 git-rebase.sh                 | 12 ++++++++++--
 t/lib-rebase.sh               |  8 ++++----
 t/t3404-rebase-interactive.sh | 18 ++++++------------
 t/t3406-rebase-message.sh     | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 89ef5e2..5dfdf13 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		output git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			warn "This is most likely due to an empty commit message, or the pre-commit hook"
 			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
@@ -558,14 +558,14 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --allow-empty-message --allow-empty \
+				do_with_author output git commit --allow-empty-message --allow-empty \
 					--amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
-				do_with_author git commit --allow-empty --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
+				do_with_author output git commit --allow-empty --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			fi
@@ -923,6 +923,8 @@ EOF
 	;;
 esac
 
+mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
+
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
@@ -938,7 +940,6 @@ then
 fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
diff --git a/git-rebase.sh b/git-rebase.sh
index 55da9db..f90541e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -131,9 +131,17 @@ write_basic_state () {
 output () {
 	case "$verbose" in
 	'')
-		output=$("$@" 2>&1 )
+		cat >"$state_dir"/editor.sh <<EOF
+#!/bin/sh
+$(git var GIT_EDITOR) "\$@" >&3
+EOF
+		chmod +x "$state_dir"/editor.sh
+		(
+			export GIT_EDITOR=\""$state_dir"/editor.sh\"
+			"$@" 3>&1 >"$state_dir"/output 2>&1
+		)
 		status=$?
-		test $status != 0 && printf "%s\n" "$output"
+		test $status != 0 && cat "$state_dir"/output
 		return $status
 		;;
 	*)
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6bd2522..0cd1193 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -41,8 +41,8 @@ set_fake_editor () {
 	test -z "$FAKE_LINES" && exit
 	grep -v '^#' < "$1" > "$1".tmp
 	rm -f "$1"
-	echo 'rebase -i script before editing:'
-	cat "$1".tmp
+	echo 'rebase -i script before editing:' >&2
+	cat "$1".tmp >&2
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
@@ -59,8 +59,8 @@ set_fake_editor () {
 			action=pick;;
 		esac
 	done
-	echo 'rebase -i script after editing:'
-	cat "$1"
+	echo 'rebase -i script after editing:' >&2
+	cat "$1" >&2
 	EOF
 
 	test_set_editor "$(pwd)/fake-editor.sh"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3e64280..c6578c3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -873,9 +873,8 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -887,9 +886,8 @@ test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -901,9 +899,8 @@ test_expect_success 'running "git rebase -ix git show HEAD"' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -915,9 +912,8 @@ test_expect_success 'rebase -ix with several <CMD>' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -930,9 +926,8 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
 				exec_git_show_HEAD exec_pwd" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,11d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -956,9 +951,8 @@ test_expect_success 'rebase -ix with --autosquash' '
 		git checkout -b autosquash_expected &&
 		FAKE_LINES="1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~4 >expect
+		git rebase -i HEAD~4 >expected
 	) &&
-	sed -e "1,13d" expect >expected &&
 	test_cmp expected actual
 '
 
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36..d7003a9 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -4,6 +4,8 @@ test_description='messages from rebase operation'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 test_expect_success 'setup' '
 	test_commit O fileO &&
 	test_commit X fileX &&
@@ -84,4 +86,20 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_i18ngrep "invalid-ref" err
 '
 
+test_expect_success 'commit summary is suppressed in non-verbose mode' '
+	git checkout --detach Y &&
+	cat >expected.out <<-EOF &&
+	Rebasing (1/5)\r
+	Rebasing (2/5)\r
+	Rebasing (3/5)\r
+	Rebasing (4/5)\r
+	Rebasing (5/5)\r
+	EOF
+	set_fake_editor &&
+	FAKE_LINES="reword 1 fixup 2 fixup 3 4 squash 5" \
+	git rebase -i --root >actual.out.tmp &&
+	sed -e "s/\r/\\\\r\n/g" <actual.out.tmp >actual.out &&
+	test_cmp expected.out actual.out
+'
+
 test_done
-- 
2.0.1
