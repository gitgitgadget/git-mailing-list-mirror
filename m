From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 02/19] rebase -i: reword complains about empty commit despite --keep-empty
Date: Wed,  2 Jul 2014 19:47:54 +0200
Message-ID: <b7ee74ddb785f0e087b30ca6be11723ca199fa03.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:49:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OfE-0006WL-9y
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbaGBRtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:49:36 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:44782 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbaGBRtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:35 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so955824wiv.14
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VitfxCM/K7jufh/FrQ6GUWhkXQoL0j+8fMabByFloDk=;
        b=XVRM4Lhqiy3qwiw2a+5nVcGEscfi8g1hFfv1jSmOIpaFJjKAFaPiZhONmy7E44K/kq
         oq55/c4ZTacmG0/TVDkM79IYq1XymOl1+n0kSqGBLHgNpxRN+p8zDHAuJGUmxic3GxOd
         DrXJ3YngC8aP08kK2KTN0XSzHDmxDuUQopUmWNGbN0f2wTZuu3THyihlELbFXLdBxpHS
         nxjX+nfYtWNGHh0wGVcCI56+/uOSiHFT9H0WXnPK0YM1zPOOvUIEUZhiZj7ZTj3pCvYI
         M9iikCQCRQTkFFpeeYXbMyC1uZqI96qGoQlmFAFxbGJTCXXRLEdhYhkNx8JE8hyIeb/H
         TZXQ==
X-Received: by 10.180.103.228 with SMTP id fz4mr44317487wib.4.1404323374382;
        Wed, 02 Jul 2014 10:49:34 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252806>

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
 git-rebase--interactive.sh    | 2 +-
 t/t3404-rebase-interactive.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e733d7f..689400e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			exit_with_patch $sha1 1
 		}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed2..9931143 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,14 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+test_expect_success 'rebase --keep-empty' '
+	git checkout emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 reword 2" git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 6 actual
+'
+
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
-- 
2.0.0
