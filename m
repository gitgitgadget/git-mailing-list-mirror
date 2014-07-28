From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 03/19] rebase -i: reword executes pre-commit hook on interim commit
Date: Tue, 29 Jul 2014 01:18:03 +0200
Message-ID: <1bb7c0b9aed60f7c65bf812ac42b2f1ad8fd3f82.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDv-0006Bf-33
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaG1XUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:43 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:55554 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaG1XUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:42 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so7990939wev.26
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CuuUsIi1Oxyrx9VcZPzWK7MIJejQnUIQlA3+gGWaVMA=;
        b=t3A99fZmpW/1LKrArmepd8C+PEkw7jOW05Ua2s97LO0ErBJNa5uuYYdTq5oqEz5L0G
         yc9X/xVHljSf9Mj/MaK/0rJTxl/oJdnpEUeRwaihGbhHco6CXGRI1uvD1RUv7V1pV5PT
         s+o446Sqk8dJ8WPxf1l8WwyQ6aWcLmJlGdhvbpewkjK6r6PDbd7lrlxL2RVU1wMjHf2J
         WzgVT2RFAPpEEqc6oo+WIsMn6odtiLGK53QsAHLR4+j7gNNC4nmg+w+BmRx7Wgom06EA
         GoDG6k97Mk9Y9tIqM4CsbRQqXjhX40DsdCdjdhgbqna2oiWewQgaRA9ama2xotcAzjH/
         PWtQ==
X-Received: by 10.194.58.180 with SMTP id s20mr35700161wjq.119.1406589640897;
        Mon, 28 Jul 2014 16:20:40 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254363>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. This happens in two
steps. Firstly, the named commit is cherry-picked. Secondly, the
commit created in the first step is amended using an unchanged index
to edit the log message. The pre-commit hook is meant to verify the
changes introduced by a commit (for instance, catching inserted
trailing white space). Since the committed tree is not changed
between the two steps and we do not verify rebased patches, do not
execute the pre-commit hook in the second step.

Specify the git-commit option `--no-verify` to disable the pre-commit
hook when editing the log message. Because `--no-verify` also skips
the commit-msg hook, execute the hook from within
git-rebase--interactive after the commit is created. Fortunately, the
commit message is still available in `$GIT_DIR/COMMIT_EDITMSG` after
git-commit terminates. Caveat: In case the commit-msg hook finds the
new log message ill-formatted, the user is only notified of the
failed commit-msg hook but the log message is used for the commit
anyway. git-commit ought to offer more fine-grained control over
which hooks are executed.

Teach `test_commit` the `--no-verify` option and add test.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 17 +++++++++++++----
 t/t3404-rebase-interactive.sh | 38 ++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh       |  6 +++++-
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 689400e..b50770d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,10 +504,19 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $sha1... $rest"
-			exit_with_patch $sha1 1
-		}
+		# TODO: Work around the fact that git-commit lets us
+		# disable either both the pre-commit and the commit-msg
+		# hook or none. Disable the pre-commit hook because the
+		# tree is left unchanged but run the commit-msg hook
+		# from here because the log message is altered.
+		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
+			if test -x "$GIT_DIR"/hooks/commit-msg
+			then
+				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
+			fi || {
+				warn "Could not amend commit after successfully picking $sha1... $rest"
+				exit_with_patch $sha1 1
+			}
 		record_in_rewritten $sha1
 		;;
 	edit|e)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9931143..2da4b9c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -577,6 +577,44 @@ test_expect_success 'rebase a commit violating pre-commit' '
 
 '
 
+test_expect_success 'reword a commit violating pre-commit' '
+	test_when_finished rm -r .git/hooks &&
+	mkdir -p .git/hooks &&
+	PRE_COMMIT=.git/hooks/pre-commit &&
+	cat >"$PRE_COMMIT" <<EOF
+#!/bin/sh
+echo running pre-commit: exit 1
+exit 1
+EOF
+	chmod +x "$PRE_COMMIT" &&
+	test_must_fail test_commit pre-commit-violated &&
+	test_commit --no-verify pre-commit-violated &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	FAKE_LINES="pick 1" git rebase -i HEAD^ &&
+	FAKE_LINES="pick 1" git rebase -i --no-ff HEAD^ &&
+	FAKE_LINES="reword 1" git rebase -i HEAD^
+'
+
+test_expect_success 'reword a commit violating commit-msg' '
+	test_when_finished rm -r .git/hooks &&
+	mkdir -p .git/hooks &&
+	COMMIT_MSG=.git/hooks/commit-msg &&
+	cat >"$COMMIT_MSG" <<EOF
+#!/bin/sh
+echo running commit-msg: exit 1
+exit 1
+EOF
+	chmod +x "$COMMIT_MSG" &&
+	test_must_fail test_commit commit-msg-violated &&
+	test_commit --no-verify commit-msg-violated &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	FAKE_LINES="pick 1" git rebase -i HEAD^ &&
+	FAKE_LINES="pick 1" git rebase -i --no-ff HEAD^ &&
+	test_must_fail env FAKE_LINES="reword 1" git rebase -i HEAD^
+'
+
 test_expect_success 'rebase with a file named HEAD in worktree' '
 
 	rm -fr .git/hooks &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0377d3e..db65653 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -155,6 +155,7 @@ test_pause () {
 test_commit () {
 	notick= &&
 	signoff= &&
+	noverify= &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -164,6 +165,9 @@ test_commit () {
 		--signoff)
 			signoff="$1"
 			;;
+		--no-verify)
+			noverify="$1"
+			;;
 		*)
 			break
 			;;
@@ -177,7 +181,7 @@ test_commit () {
 	then
 		test_tick
 	fi &&
-	git commit $signoff -m "$1" &&
+	git commit $signoff $noverify -m "$1" &&
 	git tag "${4:-$1}"
 }
 
-- 
2.0.1
