From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 06/19] rebase -i: allow replaying commits with empty log messages
Date: Tue, 29 Jul 2014 01:18:06 +0200
Message-ID: <95e1a2aa6855b38ce9aaacdc8564b2c4668b4ec7.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDw-0006Bf-KY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbaG1XUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:50 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35181 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaG1XUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:47 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so8037853wes.19
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SFbLTdbuS/tUIVL+CaDr62i8CZLa5epZY3G9S5W/y7w=;
        b=D5KapZEjDEmahhyagySz98UyYs5RSD1mu3yU+bjfw09tpejrG/oflbTdVmcQ6CIAMe
         1Udib5vFaWrvGaxnRjRBC5QycyFXwi7lHH7YYYhjToKOSJBaSmhZS3piczOiY3LxT2oC
         j0s1JelRpj5c2WDB6qaAxfktFfLZTy5zcysOdrG4GDAz6aBkfZCZbmReP/sYrV2mMuW0
         KPm3/T6tpsNayC7ruHDxUKdbjObPfOphK10ySeHSSzHKR5Nv7FvFLNy1yHPCAv9dVatz
         q2GhEhGjK87zt7Bi6WwrPP89FBl/VQVZHYHB4+d1ZXbPQromkDYI0VJ6UbX7U69QsYWw
         ibBQ==
X-Received: by 10.194.62.140 with SMTP id y12mr54996365wjr.27.1406589645200;
        Mon, 28 Jul 2014 16:20:45 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254364>

git-rebase--interactive handles empty log messages inconsistently
between enabled and disabled fast-forwards. By default, commits with
empty log messages are rebased successfully like in non-interactive
mode. In contrast, the `--no-ff` option aborts the replay of such
commits.

In line with not verifying rebased commits and behaving like
git-rebase for `pick` lines, use the `--allow-empty-message` option
to replay commits. Root commits are replayed by recreating them in
`do_pick` using git-commit and commits with parents are replayed
using git-cherry-pick in `pick_one`. Apply the option, understood by
both git-commit and git-cherry-pick, at the respective sites.

In case of `reword` and `squash`/`fixup` continue to abort the rebase
if the resulting commit would have no commit message. The rationale
behind this default is that patches and their log messages should be
verified at least once. For unchanged commits this is assumed to have
happened according to the author's standards when she created the
commits the first time. While the empty log message can always be
kept in place by editing and resuming the aborted rebase, a debatable
alternative could be to teach git-rebase--interactive the option
`--allow-empty-message` for disabling complaints about empty log
messages in changed commits. The to-do list command `edit` is handled
just like `pick` for this matter, because git-rebase--interactive
replays the named commit without changes before the rebase is
interrupted and the user can make her changes to the replayed commit.

Add tests.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  4 ++--
 t/t3404-rebase-interactive.sh | 24 ++++++++++++++++++++++++
 t/t3412-rebase-root.sh        | 19 +++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4c875d5..6e2c429 100644
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
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2da4b9c..2e8fa27 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1085,4 +1085,28 @@ test_expect_success 'short SHA-1 collide' '
 	)
 '
 
+test_expect_success 'rebase commits with empty commit log messages' '
+	git checkout -b no-msg-commit &&
+	test_commit no-msg-commit-1 &&
+	git commit --amend --allow-empty-message -m " " &&
+	test_commit no-msg-commit-2 &&
+	git commit --amend --allow-empty-message -m " " &&
+	EDITOR=true git rebase -i HEAD^ &&
+	EDITOR=true git rebase -i --no-ff HEAD^
+'
+
+test_expect_success 'reword commit with empty commit log message' '
+	git checkout no-msg-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 1" git rebase -i HEAD^
+'
+
+test_expect_success 'squash commits with empty commit log messages' '
+	git checkout no-msg-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 squash 2" git rebase -i HEAD^^
+'
+
 test_done
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 0b52105..798c9f1 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -278,4 +278,23 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	test_cmp expect-conflict-p out
 '
 
+test_expect_success 'rebase --root with empty root log message' '
+	git checkout --orphan no-msg-root-commit &&
+	test_commit no-msg-root-commit &&
+	git commit --amend -m " " --allow-empty-message &&
+	git rebase --root &&
+	test_path_is_file no-msg-root-commit.t &&
+	git rebase --root --no-ff &&
+	test_path_is_file no-msg-root-commit.t
+'
+
+test_expect_success 'rebase --root with empty child log message' '
+	test_commit no-msg-child-commit &&
+	git commit --amend -m " " --allow-empty-message &&
+	git rebase --root &&
+	test_path_is_file no-msg-child-commit.t &&
+	git rebase --root --no-ff &&
+	test_path_is_file no-msg-child-commit.t
+'
+
 test_done
-- 
2.0.1
