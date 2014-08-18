From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 03/27] rebase -i: allow rewording empty commits without complaints
Date: Mon, 18 Aug 2014 23:22:46 +0200
Message-ID: <a98cda7aa0c98e6335dd1c6932e30909e49bdb0f.1408396036.git.bafain@gmail.com>
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
	id 1XJUPF-0000N5-ME
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbaHRVXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:48 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:38804 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbaHRVXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:46 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so4964238lab.8
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeusWBPCsavFR7H23eiAuVuGM/Ur81sX2os5ZeGGfsk=;
        b=oKinfbG0Xz39qlvCXHJ7anB4rzspUmrz1evq7qtfXwfCWpCWCsXGmEclEYu9bMI7aJ
         hibNAsCMxRyi6Hu+hkOFxrdlhdMbAdzSlK+iNQLdSZiFLGaeM45jirzn0cnwSy8qxNKp
         dzmBq+qaS7egUzIKt3kdicyTlK30d0INd47CUhn6VxKfU3KMZGFG8W/WmAOingeFnBzv
         HV58o75LVrE+VYcl3BXkaGJselRleq3MLl/bnQe7FDP+hbuL8eO6J0ve0g3J45DmTQ9b
         tk6K0axf2siO59FhhKJwFF3MTi3d19i2KU9B7E7CZxRPXJGBO9zRZkcifm1zrEmDty86
         j+oA==
X-Received: by 10.112.141.193 with SMTP id rq1mr15595783lbb.25.1408397025255;
        Mon, 18 Aug 2014 14:23:45 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255415>

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
 t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ada340c..eb1dcda 100644
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
index a95cb2a..f4e886f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,39 @@ test_expect_success 'rebase --keep-empty' '
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
+test_expect_success 'rebase --keep-empty (edit)' '
+	git checkout -b edit-emptybranch emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 edit 2" git rebase --keep-empty -i HEAD~2 &&
+	git rebase --continue &&
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
