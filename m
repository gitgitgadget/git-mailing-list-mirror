From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 05/19] rebase -i: Implement reword in terms of do_pick
Date: Wed,  2 Jul 2014 19:47:57 +0200
Message-ID: <a82fd64f943d4b59a01509ae52fc2d7a05d51f4a.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OfV-0006lZ-6d
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbaGBRtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:49:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39176 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbaGBRtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:50 -0400
Received: by mail-wi0-f178.google.com with SMTP id n15so916543wiw.17
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k0Li6dp1TpGKumc9CcGDDHAxNBT2KC/VKE0fO1qrGHI=;
        b=GEZPG89TBfRGoQxJ1b8fXMGTRMnbNHTNRAkZRauLc23hoSWsKLO1lRaenuC9DAXVmq
         mP6oyzqhz52ksaBrEXBbDg3PYx1feKerbDIiU9eiVreIFWXrfLoE5acuqqQS/b8fbgah
         L1fNjKcCIwu4tmrmdcEyT34/q/ntlkrVl4/WJVXGC+3JpoRtLt1+Wxw78A6T7HRp7hNU
         xG4rlsL3zFD1rRccth+yPqM9UXxoKxjfnjYadZmNvO81P8ttA7Ei60gSW13TgUxa+PBx
         qRAT0QIpgbZeeCrUcZPc5OYLQkVL70xti6vq7I4mTIwWRNUx2l+2Y23dpj7NubLKwFa2
         breA==
X-Received: by 10.194.90.228 with SMTP id bz4mr28440639wjb.65.1404323382893;
        Wed, 02 Jul 2014 10:49:42 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252810>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If one thinks of `pick`
entries as scheduled `cherry-pick` command lines, then `reword`
becomes an alias for the command line `cherry-pick --edit`. The
porcelain `rebase--interactive` defines a function `do_pick` for
processing the `pick` entries on to-do lists. Reimplement `reword` in
terms of `do_pick --edit`.

If the user picks a commit using the to-do list line

    reword fa1afe1 Some change

execute the command `do_pick --edit fa1afe1 "Some change"` which
carries out exactly the same steps as the case arm for `reword` in
`do_next` so far.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e06d9b6..4c875d5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -555,20 +555,7 @@ do_next () {
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick $sha1 "$rest"
-		# TODO: Work around the fact that git-commit lets us
-		# disable either both the pre-commit and the commit-msg
-		# hook or none. Disable the pre-commit hook because the
-		# tree is left unchanged but run the commit-msg hook
-		# from here because the log message is altered.
-		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
-			if test -x "$GIT_DIR"/hooks/commit-msg
-			then
-				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
-			fi || {
-				warn "Could not amend commit after successfully picking $sha1... $rest"
-				exit_with_patch $sha1 1
-			}
+		do_pick --edit $sha1 "$rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
-- 
2.0.0
