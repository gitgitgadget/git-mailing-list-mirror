From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 14/19] rebase -i: Implement squash in terms of do_pick
Date: Wed,  2 Jul 2014 19:48:06 +0200
Message-ID: <aef64805e4209549739f5a066426a4909d701388.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgT-0007cA-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbaGBRuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:54 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:51181 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbaGBRuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:50:03 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so11535217wgg.8
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHNjydaYY5grNOudi2N4MdE0g5zJqlRtEM9SZzfTmVg=;
        b=AN5uwTFJwmnDLEBCpoJzDtF80oubk3KmDjPl2+mHcuydbM2PvuJY2G8HwICJtdoDfG
         1MTemvwAdL6Hmlaeg0HO2dt0jaWQKAf4YdZ/FbTNVOKMvR1xcOgVs/8tCX37rEm53wOo
         f2Nqgo4hugk4GG4zCUDN8v/IME/He1XG4iJffAF4WxVL27pkm/P6MhTzUtpccL3OeK5I
         KBr7sC1oSjIlSDiOCHsPjyNb2QvEq4TZE49NG3ALKt0b+jFxUioTb5EpN/VoRzOyicgg
         Sf83JZ2u5DCe/uBtlW6Q/i7ahf8t2x+S4vNSRy792mTr1u7vsQhV5CqYt5HRkO4fl9h7
         mEag==
X-Received: by 10.194.174.35 with SMTP id bp3mr51203589wjc.33.1404323402248;
        Wed, 02 Jul 2014 10:50:02 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.50.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:50:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252822>

The to-do list command `squash` and its close relative `fixup` replay
the changes of a commit like `pick` but do not recreate the commit.
Instead they replace the previous commit with a new commit that also
introduces the changes of the squashed commit. This is roughly like
cherry-picking without committing and using git-commit to amend the
previous commit.

The to-do list

    pick   a Some changes
    squash b Some more changes

gets translated into the sequence of git commands

    git cherry-pick a
    git cherry-pick -n b
    git commit --amend

and if git-cherry-pick supported `--amend` this would look even more
like the to-do list it is based on

    git cherry-pick a
    git cherry-pick --amend b.

Since `do_pick` takes care of `pick` entries and the above suggests
`squash` as an alias for `pick --amend`, reimplement `squash` in
terms of `do_pick --amend`. Introduce `$squash_msg` as the commit
message via the `--file` option. When the last commit of a squash
series is processed, the user is asked to review the log message.
Pass `--edit` as additional option in this case. The only difference
in the options passed to git-commit and `do_pick` is the omitted
`--no-verify`. However, `do_pick` does not execute the verification
hooks anyway because it solely replays commits and assumes that they
have been verified before.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 37800be..008f3a0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -637,37 +637,19 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			if ! pick_one -n $sha1
-			then
-				git rev-parse --verify HEAD >"$amend"
-				die_failed_squash $sha1 "Could not apply $sha1... $rest"
-			fi
-			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die_failed_squash $sha1 "$rest"
+			do_with_author do_pick --amend -F "$squash_msg" $sha1 \
+				|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$fixup_msg" $sha1 \
+					|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $sha1 \
+					|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
 			;;
-- 
2.0.0
