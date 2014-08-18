From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 08/27] rebase -i: verify squash messages using commit-msg
Date: Mon, 18 Aug 2014 23:22:51 +0200
Message-ID: <2882c5b3f2c385492f6aa8d9f6ed1ec2308ebce3.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPS-0000U7-HF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaHRVX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:58 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35430 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbaHRVX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:56 -0400
Received: by mail-lb0-f172.google.com with SMTP id z11so4740371lbi.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=12Ka2Dr8WI6XoFtSeMSbHmCmSevBNmAZhVoGhviTDeM=;
        b=LrMIG66TUsCT/z52mcE5S7aYz7fQpkloGI8nFgrxgNJSf/pb1iOrbjNdCjbjtFUgWO
         jEUTDTb5D1fbHpVN+bZ/YxLNUzemG2G+UiAgO/+qPOSUBoBVpp3QP4e/NvZJtPqEE6e2
         ViW1lmnLPy311lGo+tbcDNsZlTHM0WOuTEuo30BGUW4KQlkTw8Ocr0E6DelmI3Dph1M0
         G2XaP4lxDQOth9gkZFFNQ9aU4h5/iAU8Nu2sf8YRbnKy8QXjghk7CHSRqqixLQFiwjRD
         fJJsk8he9fLSLa8c078u/YB/tzy+52UduvNLOBSDu1VOQq9NJfTtFdUbs7/h/LWEc/Qh
         K4JA==
X-Received: by 10.112.198.34 with SMTP id iz2mr5296442lbc.96.1408397034905;
        Mon, 18 Aug 2014 14:23:54 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255417>

Using the to-do list command `squash` the user can specify two or
more commits and git-rebase creates one commit that introduces all
their changes combined. The authorship for the created commit is
taken from the first commit specified and the user can edit the log
message. There is a variant of `squash` available named `fixup` which
also takes the first log message without asking for user input.

While it is reasonable to not verify replayed changes twice or
rejecting some other author's changes in her name, it is insufficient
to not verify the user input used as log message in the case of
`squash`. Specify the git-commit option `--no-pre-commit` instead of
`--no-verify` when committing the squash result, but not before, to
let the commit-msg hook verify the final squash message. For the same
reasons the pre-commit hook is disabled in all replay modes, the
commit-msg hook is disabled in `fixup` mode.

Add tests. In addition to the existing test checking that the
pre-commit hook is disabled when simply picking a commit, provide a
test checking that the commit-msg hook is disabled as well.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  2 +-
 t/t3404-rebase-interactive.sh | 80 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cf62daa..54c4614 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -562,7 +562,7 @@ do_next () {
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
-				do_with_author output git commit --allow-empty --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
+				do_with_author output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7cc6ebf..abb829e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -664,6 +664,86 @@ test_expect_success 'rebase a commit violating pre-commit' '
 
 '
 
+test_expect_success 'setup failing pre-commit' '
+	HOOKDIR="$(git rev-parse --git-dir)"/hooks &&
+	mkdir -p "$HOOKDIR" &&
+	PRE_COMMIT="$HOOKDIR"/pre-commit &&
+	cat >"$PRE_COMMIT" <<-EOF &&
+	#!/bin/sh
+	echo running failing pre-commit...
+	exit 1
+	EOF
+	chmod +x "$PRE_COMMIT" &&
+	git checkout -b violating-pre-commit master &&
+	test_must_fail test_commit pre-commit-violated-1 &&
+	test_commit --no-verify pre-commit-violated-1 &&
+	test_must_fail test_commit pre-commit-violated-2 &&
+	test_commit --no-verify pre-commit-violated-2 &&
+	test_must_fail test_commit pre-commit-violated-3 &&
+	test_commit --no-verify pre-commit-violated-3
+'
+
+test_expect_success 'squash commits violating pre-commit' '
+	git checkout -b squash-violating-pre-commit violating-pre-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	env FAKE_LINES="1 squash 2 squash 3" git rebase -i master
+'
+
+test_expect_success 'fixup commits violating pre-commit' '
+	git checkout -b fixup-violating-pre-commit violating-pre-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	env FAKE_LINES="1 fixup 2 fixup 3" git rebase -i master
+'
+
+test_expect_success 'clean up failing pre-commit' '
+	rm "$PRE_COMMIT"
+'
+
+test_expect_success 'setup failing commit-msg' '
+	HOOKDIR="$(git rev-parse --git-dir)"/hooks &&
+	mkdir -p "$HOOKDIR" &&
+	COMMIT_MSG="$HOOKDIR"/commit-msg &&
+	cat >"$COMMIT_MSG" <<-EOF &&
+	#!/bin/sh
+	echo running failing commit-msg...
+	exit 1
+	EOF
+	chmod +x "$COMMIT_MSG" &&
+	git checkout -b violating-commit-msg master &&
+	test_must_fail test_commit commit-msg-violated-1 &&
+	test_commit --no-verify commit-msg-violated-1 &&
+	test_must_fail test_commit commit-msg-violated-2 &&
+	test_commit --no-verify commit-msg-violated-2 &&
+	test_must_fail test_commit commit-msg-violated-3 &&
+	test_commit --no-verify commit-msg-violated-3
+'
+
+test_expect_success 'rebase a commit violating commit-msg' '
+	git checkout -b rebase-violating-commit-msg violating-commit-msg &&
+	set_fake_editor &&
+	FAKE_LINES="1" git rebase -i master
+'
+
+test_expect_success 'squash commits violating commit-msg' '
+	git checkout -b squash-violating-commit-msg violating-commit-msg &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 squash 2 squash 3" git rebase -i master &&
+	git commit --no-verify --amend &&
+	git rebase --continue
+'
+
+test_expect_success 'fixup commits violating commit-msg' '
+	git checkout -b fixup-violating-commit-msg violating-commit-msg &&
+	set_fake_editor &&
+	env FAKE_LINES="1 fixup 2 fixup 3" git rebase -i master
+'
+
+test_expect_success 'clean up failing commit-msg' '
+	rm "$COMMIT_MSG"
+'
+
 test_expect_success 'rebase with a file named HEAD in worktree' '
 
 	rm -fr .git/hooks &&
-- 
2.0.1
