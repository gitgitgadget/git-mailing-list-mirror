From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 01/27] rebase -i: allow replaying commits with empty log messages
Date: Mon, 18 Aug 2014 23:22:44 +0200
Message-ID: <ea58c1b83349b8bc4c2a0abf31de53a54f651299.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:23:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUP4-0000Hp-VC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbaHRVXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:42 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38713 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaHRVXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:41 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so4637512lbg.20
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zj7WRwHPyyBsPY2gyJgjzP9NS5HOc9jQr6MtUQPWx3Y=;
        b=kN3s2EINXNLcv+jG0VYbSLLj6plM08UZSIi7pAQhV13xKw/ycc/soIvacSuWm5rVOK
         /FdGpkElEhCg83VlcesOEKC4NIWqOvEBGDyajeGecUIMzk+nyBlOf02KmvfqTWNZ2M7w
         fqodxuFscZbwA1Yahx7uPvbUrI3xH1wZmT4nnzY4kySvrWUf1U1zRi7VyqE5lNehUPKy
         EyoowC/0XEi3e/a1vlnwvO2aejwEHtvBQ1tpIIY3n4N9evl249KYBKgKKEmSYJcxrSRY
         NgnDqwQKbi0Z3EqmxZOSJuubIFH6+ZhJpCsGN7/aSVob+KQ5qMnqh9W3GRcZlz8PY6cJ
         aSEg==
X-Received: by 10.112.169.35 with SMTP id ab3mr30046145lbc.41.1408397020077;
        Mon, 18 Aug 2014 14:23:40 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255411>

git-rebase--interactive handles empty log messages inconsistently
between enabled and disabled fast-forwards. By default, commits with
empty log messages are rebased successfully like in non-interactive
mode. In contrast, the `--no-ff` option aborts the replay of such
commits.

In line with not verifying rebased commits and behaving like
git-rebase for `pick` lines, use the `--allow-empty-message` option
to replay commits. Root commits are replayed by recreating them in
`do_pick` using git-commit and all other commits are replayed using
git-cherry-pick in `pick_one`. Apply the option, understood by both
git-commit and git-cherry-pick, at the respective sites.

In case of `reword` and `squash`, continue to abort the rebase if the
_resulting_ commit would have no commit message. The rationale behind
this default is that patches and their log messages should be
verified at least once. For unchanged commits this is assumed to have
happened according to the author's standards when she created the
commits for the first time. While the empty log message can always be
kept in place by editing and resuming the aborted rebase, a debatable
alternative could be to teach git-rebase--interactive the option
`--allow-empty-message` for disabling complaints about empty log
messages even in changed commits.

The `fixup` case is different again because it throws away the second
commit's log message and uses the first log message for the changed
commit. Do not abort the rebase if that message is empty either since
it is assumed to have been verified already.

The remaining to-do list command `edit` is handled just like `pick`
for this matter, because git-rebase--interactive replays the named
commit without changes before the rebase is interrupted and the user
can make her changes to the replayed commit.

Add tests. In particular, design the `squash`-specific test case such
that it involves interim commits and `fixup` steps. Interim commits
should not trigger failures themselves and `fixup` steps should not
let git-rebase--interactive forget that it is still dealing with a
`squash` result.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 10 ++++++----
 t/t3404-rebase-interactive.sh | 38 ++++++++++++++++++++++++++++++++++++++
 t/t3412-rebase-root.sh        | 16 ++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b64dd28..3222bf6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -249,7 +249,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick \
+	output eval git cherry-pick --allow-empty-message \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 			"$strategy_args" $empty_args $ff "$@"
 }
@@ -363,7 +363,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick \
+			output eval git cherry-pick --allow-empty-message \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 				"$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
@@ -549,7 +549,8 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
+			do_with_author output git commit --allow-empty-message \
+				--amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die_failed_squash $sha1 "$rest"
 			;;
@@ -557,7 +558,8 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
+				do_with_author git commit --allow-empty-message \
+					--amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed2..9c71835 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1039,4 +1039,42 @@ test_expect_success 'short SHA-1 collide' '
 	)
 '
 
+test_expect_success 'setup commits with empty commit log messages' '
+	git checkout -b empty-log-messages master &&
+	test_commit no-msg-commit-1 &&
+	git commit --amend --allow-empty-message -F - </dev/null &&
+	test_commit no-msg-commit-2 &&
+	git commit --amend --allow-empty-message -F - </dev/null &&
+	test_commit no-msg-commit-3 &&
+	git commit --amend --allow-empty-message -F - </dev/null
+'
+
+test_expect_success 'rebase commits with empty commit log messages' '
+	git checkout -b rebase-empty-log-messages empty-log-messages &&
+	set_fake_editor &&
+	test_expect_code 0 env FAKE_LINES="1" git rebase -i master &&
+	test_expect_code 0 env FAKE_LINES="1" git rebase -i --no-ff master
+'
+
+test_expect_success 'reword commits with empty commit log messages' '
+	git checkout -b reword-empty-log-messages empty-log-messages &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 1" git rebase -i master
+'
+
+test_expect_success 'squash commits with empty commit log messages' '
+	git checkout -b squash-empty-log-messages empty-log-messages &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 squash 2 fixup 3" git rebase -i master &&
+	git commit --allow-empty-message --amend &&
+	git rebase --continue
+'
+
+test_expect_success 'fixup commits with empty commit log messages' '
+	git checkout -b fixup-empty-log-messages empty-log-messages &&
+	set_fake_editor &&
+	env FAKE_LINES="1 fixup 2" git rebase -i master
+'
+
 test_done
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 0b52105..7add7a1 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -278,4 +278,20 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	test_cmp expect-conflict-p out
 '
 
+test_expect_success 'rebase --root root with empty log message' '
+	git checkout --orphan empty-log-messages-root master &&
+	test_commit no-msg-root-commit &&
+	git commit --amend --allow-empty-message -F - </dev/null &&
+	test_expect_code 0 git rebase --root &&
+	test_expect_code 0 git rebase --root --no-ff
+'
+
+test_expect_success 'rebase --root commits with empty log messages' '
+	git checkout -b empty-log-messages master &&
+	test_commit no-msg-commit &&
+	git commit --amend --allow-empty-message -F - </dev/null &&
+	test_expect_code 0 git rebase --root &&
+	test_expect_code 0 git rebase --root --no-ff
+'
+
 test_done
-- 
2.0.1
