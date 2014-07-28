From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 05/19] rebase -i: implement reword in terms of do_pick
Date: Tue, 29 Jul 2014 01:18:05 +0200
Message-ID: <7b9d35275dc8c466d3387da920e3ccd6789b34ab.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDw-0006Bf-4R
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaG1XUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:49 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49520 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbaG1XUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:45 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so5255212wiw.6
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MqinRREZnBZcQifdN/i9NJYFrJHjbebbDQ4vK+M8s0U=;
        b=pEADiZrxurMvoljHO6sqrsV/FW7ay2uyPE14Qulr0REWprHqh2k6p3rcKoL6LWTrt5
         S0cgb8t5qKlM+3Bq1DbA40NbTy4tkFkjpL8wJ1I+Civ3ckAdANT3dXurRGMi6VudoiAY
         AIKmf/ttLlvve88HcfpG1BnWqvgbVoncCQH7kIp5SMuBZzKOICRdPouRrAkPt6QhYqVY
         E4ldmDEyIPTrTIV5uL/exhywrB5eaFIi7wDAnWOflhFvi+80jG06/BGrQrJjvBSOkcEO
         pq7iH5lQ4OSBql3CEzmCDum8MxTasqfmvKbbKq91KH4pkLP/kr7/OAQCN3sVsdgY8kuB
         qPhw==
X-Received: by 10.195.13.102 with SMTP id ex6mr52721182wjd.48.1406589643784;
        Mon, 28 Jul 2014 16:20:43 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254367>

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
2.0.1
