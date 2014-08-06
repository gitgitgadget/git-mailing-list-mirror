From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 08/23] rebase -i: reword executes pre-commit hook on interim commit
Date: Thu,  7 Aug 2014 01:59:15 +0200
Message-ID: <03febc7259c741a0891183bf578c93600ab0d68d.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8P-0003kY-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbaHGAAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:41 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34423 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbaHGAAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:38 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so3604270qgd.14
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B58XbYT+JBTPseZMgV8kGIvZE44WlFZHakNoFkTkh5Y=;
        b=TXTfOGd3F/84LN8iXWxjZGaizTHLv3EUljDCYVJR1YDfybLSt4oO9x45fVpR3L3DWX
         X62dliYIqCJxjo3G+INkUzNw+VXxs1zI+9yMcLXkKYlirIsbYLRm8EUbMtLQ8EwSlZ77
         ar/axBwwZ0ZdeB/SuofviEHXl82rpXuNqX1ZOK4JSrvAJYa5VS9w8B9o0NZBpln5xs/W
         bMZp/DH0vTqySFuuvxlzxY2iyhB0vTPlAcwtCAVlfNZvhKYn1wdzPmYiJ1MMLC88zsKL
         JBLBFzhkPdWvm5502kZNQzC2xBqeE5D0zqAvT5SvtBXZAZM2U4+K23kwS7mRe3/F3KnH
         9LxA==
X-Received: by 10.140.20.17 with SMTP id 17mr7895121qgi.85.1407369638318;
        Wed, 06 Aug 2014 17:00:38 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254923>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. This happens in two
steps. Firstly, the named commit is cherry-picked. Secondly, the
commit created in the first step is amended using an unchanged index
to edit the log message. The pre-commit hook is meant to verify the
changes introduced by a commit (for instance, catching inserted
trailing white space). Since the committed tree is not changed
between the two steps and we do not verify rebased patches, do not
execute the pre-commit hook in the second step.

Specify the git-commit option `--no-pre-commit` to disable the
pre-commit hook when editing the log message. The commit-msg hook
will still be executed to verify the edited commit log message. As
before, if the hook finds the new log message ill-formatted, the
rebase will be interrupted with the unchanged commit replayed and the
new log message in `$GIT_DIR/COMMIT_EDITMSG`.

Add tests.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  2 +-
 t/t3404-rebase-interactive.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 97386aa..edc323d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		output git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		output git commit --allow-empty --amend --no-post-rewrite --no-pre-commit ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			exit_with_patch $sha1 1
 		}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index bc2dda1..3dac022 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -672,6 +672,13 @@ test_expect_success 'setup failing pre-commit' '
 	test_commit --no-verify pre-commit-violated-2
 '
 
+test_expect_success 'reword a commit violating pre-commit' '
+	git checkout -b reword-violating-pre-commit violating-pre-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	env FAKE_LINES="reword 1" git rebase -i master
+'
+
 test_expect_success 'squash a commit violating pre-commit' '
 	git checkout -b squash-violating-pre-commit violating-pre-commit &&
 	test_when_finished reset_rebase &&
@@ -715,6 +722,13 @@ test_expect_success 'rebase a commit violating commit-msg' '
 	FAKE_LINES="1" git rebase -i master
 '
 
+test_expect_success 'reword a commit violating commit-msg' '
+	git checkout -b reword-violating-commit-msg violating-commit-msg &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 1" git rebase -i master
+'
+
 test_expect_success 'squash a commit violating commit-msg' '
 	git checkout -b squash-violating-commit-msg violating-commit-msg &&
 	set_fake_editor &&
-- 
2.0.1
