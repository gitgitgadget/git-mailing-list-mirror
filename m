From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 03/23] rebase -i: allow rewording empty commits without complaints
Date: Thu,  7 Aug 2014 01:59:10 +0200
Message-ID: <1ca51649186b3c51d9d1d69fef7bfd43799349ef.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8E-0003XK-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbaHGAAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:30 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:45319 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHGAAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:30 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so3157590qab.4
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wra5hXkAlB0STbl35DannD2SWLThLwSYGluIq7OZvto=;
        b=AX//t5Zx4ZThXclq9/suCT45OogWCQKB3U/VO/6NEoQ5aHTAluJRKxEMld/zyRzooM
         aed9Hh8m0tI5Gk+eDtyKzDz84zPaxqk+DGwY+jWZoHcA4CckWdyof/L9pQMgv3CBwuku
         3Fh7KI7ieyTWZyT9r3sjwHjXDiPmfBm4yIzZvia8B2IzSdd0ag93mvGlU8lmQrvi13de
         vdyRJn5gUre3qzG3r7++jWGv5gjpWW8ovuHZdUWVnbARfPIFuOb4aWMbrT9NDu4xiliQ
         wvOZRCahhNNJRf+yY2fnvt/z0F8DDdnJWR741gFwaPTccuvLn1BcMMDR9XiumSq77ris
         ObLQ==
X-Received: by 10.140.89.47 with SMTP id u44mr8206945qgd.1.1407369629327;
        Wed, 06 Aug 2014 17:00:29 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254920>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If `--keep-empty` is
passed as option to git-rebase--interactive, empty commits ought to
be replayed without complaints. However, if the users chooses to
reword an empty commit by changing the respective to-do list entry
from

    pick fa1afe1 Empty commit

to

    reword fa1afe1 Empty commit

, then git-rebase--interactive suddenly fails to replay the empty
commit. This is especially counterintuitive because `reword` is
thought of as a `pick` that alters the log message in some way but
nothing more and the unchanged to-do list entry would not fail.

Handle `reword` by cherry-picking the named commit and editing the
log message using

    git commit --allow-empty --amend

instead of

    git commit --amend.

Add test.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  2 +-
 t/t3404-rebase-interactive.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8820eac..89ef5e2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			warn "This is most likely due to an empty commit message, or the pre-commit hook"
 			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a95cb2a..3e64280 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,30 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+test_expect_success 'rebase --keep-empty (reword)' '
+	git checkout -b reword-emptybranch emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 reword 2" git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 6 actual
+'
+
+test_expect_success 'rebase --keep-empty (fixup)' '
+	git checkout -b fixup-emptybranch emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 fixup 2" git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 5 actual
+'
+
+test_expect_success 'rebase --keep-empty (squash)' '
+	git checkout -b squash-emptybranch emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 squash 2" git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 5 actual
+'
+
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
-- 
2.0.1
