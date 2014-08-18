From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 05/27] rebase -i: hide interactive command messages in verbose mode
Date: Mon, 18 Aug 2014 23:22:48 +0200
Message-ID: <8a3fe174ce0bdc3d083187d2258c16352e450652.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPG-0000N5-NY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbaHRVXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53542 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaHRVXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:50 -0400
Received: by mail-lb0-f174.google.com with SMTP id c11so4678462lbj.19
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXt69xLrwV4YJBNT1kxzOTDGGc9lAsuzNPp+nWiDWOE=;
        b=FnJdAJrchwXoSge+9XWzX/uLQq6GBo5bc+LoO4QlyHDUIF7nMAu4/Aj9idRKsLCAgG
         E17INHG6gvJf6LBlH7T5wCEoyIr6RGC9MQOBj6KoUZf5bB9fOoqnjq5xwBEcg/Bvt1G1
         7hQLVq3MWIKB0c+if+FxGjOAO8B+N+sZrypZm/5ohIfgyWsV2UbhulOvyQBMY3D4KyrG
         4yplPa9AyKS6V1+o1a1BSecnv0ohJnGu5bZ5N2YfOpPLZqmo+BQ4M/vIrikAeGldoAq0
         5Equgf4/nioj4UN8Wl1K6FFhEhYdZ5z1SQqeXNgBUswCDi6Zbd8+JvfQT+rmd7WSvSlu
         gxiw==
X-Received: by 10.112.55.238 with SMTP id v14mr5285533lbp.93.1408397028993;
        Mon, 18 Aug 2014 14:23:48 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255414>

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
message editor `GIT_EDITOR` which usually requires a working terminal
attached to stdin. Wrapping the `reword` and `squash` command lines
in `output` would seemingly freeze the terminal (see commit 7725cb5,
"rebase -i: fix reword when using a terminal editor"). Temporarily
redirect the `GIT_EDITOR` output to a third file descriptor in order
to ship it around the capture stream. Wrap the remaining git-commit
command lines in the new `output`. At the moment, it is still no
alternative to pass the `--quiet` option in non-verbose mode because
git-merge-recursive for instance prints some messages regardless of
the verbosity level.

In order to temporarily redirect the editor output, the new
definition of `output` creates a wrapper script in the state
directory to be used as `GIT_EDITOR`. Make sure the state directory
exists before `output` is called for the first time.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh |  9 +++++----
 git-rebase.sh              | 13 +++++++++++--
 t/t3406-rebase-message.sh  | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index eb1dcda..cebe742 100644
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
index 55da9db..46141b8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -131,9 +131,18 @@ write_basic_state () {
 output () {
 	case "$verbose" in
 	'')
-		output=$("$@" 2>&1 )
+		cat >"$state_dir"/editor.sh <<-EOF
+		#!/bin/sh
+		$(git var GIT_EDITOR) "\$@" >&3
+		EOF
+		chmod +x "$state_dir"/editor.sh
+		(
+			GIT_EDITOR=$(git rev-parse --sq-quote "$state_dir"/editor.sh)
+			export GIT_EDITOR
+			"$@" 3>&1 1>"$state_dir"/output 2>&1
+		)
 		status=$?
-		test $status != 0 && printf "%s\n" "$output"
+		test $status != 0 && cat "$state_dir"/output
 		return $status
 		;;
 	*)
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
