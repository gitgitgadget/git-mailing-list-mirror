From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 07/23] rebase -i: squash skips commit-msg hook
Date: Thu,  7 Aug 2014 01:59:14 +0200
Message-ID: <116e93f11356f41d1c4726216d486eebca0f1e02.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8i-0004DU-5c
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbaHGAAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:42 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:52353 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbaHGAAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:38 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so3276782qaq.15
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UZW03VUffGexG/RF2EfHejntVDgISvQuPqLnQli6b/k=;
        b=H8RvJK9seFGR2jYl3f0+OiCHYCDNBrni2S6LvuA600Ggj6NNnV+Hydr6+h5zx7AAL7
         Wb9m9jDfAuAlv2CnDdACM0Z4huZIGezV7rJZHFBfW3nmXt8WjvmNziK0equPm/Im7Ps+
         WSaAbvpYCloGhvA07moKxAg2DsxTNOMlm9Vpa3xvzodsDjis3gFO8Ouvc458RHnS9Oe9
         mdrhKJqIzPa1rHGgZJr0zpgOpDgXofBxo7c29dmLLa9LarWy5uC5EmfunhYbVONlCd3Y
         8R054gW7HeLsHDA7K+IsTQhZZeqgjYbTtLaYlwfFQxW8S8Lr2c99uJsuHlhWry41q+l1
         ycfA==
X-Received: by 10.224.38.10 with SMTP id z10mr10140716qad.52.1407369636454;
        Wed, 06 Aug 2014 17:00:36 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254926>

Using the to-do list command `squash` the user can specify two or
more commits and git-rebase creates one commit that introduces all
their changes combined. The authorship for the created commit is
taken from the first commit specified and the user can edit the log
message. There is a variant of `squash` available named `fixup` which
also takes the first log message without asking for user input.

While it is reasonable to not verify replayed changes twice or
rejecting some other author's changes in her name, it is insufficient
to not verify the user input used as log message in the case of
`squash`. Specify the git-commit option `--commit-msg` when
committing the squash result to execute the commit-msg hook and
verify the new log message. For the same reasons the pre-commit hook
is disabled in all replay modes, the commit-msg hook gets disabled in
`fixup` mode.

Add tests. In addition to the existing test checking that the
pre-commit hook is disabled when simply picking a commit, provide a
test checking that the commit-msg hook is disabled as well.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  2 +-
 t/t3404-rebase-interactive.sh | 78 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3ee13c2..97386aa 100644
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
index c6578c3..bc2dda1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -655,6 +655,84 @@ test_expect_success 'rebase a commit violating pre-commit' '
 
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
+	test_commit --no-verify pre-commit-violated-2
+'
+
+test_expect_success 'squash a commit violating pre-commit' '
+	git checkout -b squash-violating-pre-commit violating-pre-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	env FAKE_LINES="1 squash 2" git rebase -i master
+'
+
+test_expect_success 'fixup a commit violating pre-commit' '
+	git checkout -b fixup-violating-pre-commit violating-pre-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	env FAKE_LINES="1 fixup 2" git rebase -i master
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
+test_expect_success 'squash a commit violating commit-msg' '
+	git checkout -b squash-violating-commit-msg violating-commit-msg &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 squash 2 fixup 3" git rebase -i master &&
+	git commit --no-verify --amend &&
+	git rebase --continue
+'
+
+test_expect_success 'fixup a commit violating commit-msg' '
+	git checkout -b fixup-violating-commit-msg violating-commit-msg &&
+	set_fake_editor &&
+	env FAKE_LINES="1 fixup 2" git rebase -i master
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
