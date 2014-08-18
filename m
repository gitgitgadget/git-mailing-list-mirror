From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 20/27] rebase -i: implement squash in terms of do_pick
Date: Mon, 18 Aug 2014 23:23:03 +0200
Message-ID: <4e81ed23e4cb5344fc5e8feb9e8c8bbd2d24b545.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:25:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUQo-0001D9-8T
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbaHRVZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:25:07 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:55888 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbaHRVYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:18 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so5163530lam.0
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NsQ+fgHnJZLJresKvOAHzt128MybLbHkCYqbpXxQGDI=;
        b=XsLsWfvIVbvVRVmDBeVy0WilK3Lhzqx+okrmfev2qs8I7kVm53BEhc9saBSgR9SmMc
         Yo9WIjO5r/2N9sJG22wBnEZqmYGzLmCaPi9TFNYjVlno/fDDoSraP1dlKF9BEZKoVjnU
         mDYpNkqV7rOhwikbce0o3dxWczM7hlEMY50/2CahhKxNx1J2UImfb7xSrif5ZAbJv6cp
         6upMS3d0U8wRDzokiiFQcPSOh8SSYHlhYkRvuH+hk1l1bQp20od8zAVZiGLxk4+AC6OW
         gxBhjGGR/Pzx7+eiei1GduWUhbOLmyluT2j6v1XbtFPUqpRdvtiToMlU41LfO8xQUr2A
         DKoA==
X-Received: by 10.112.78.38 with SMTP id y6mr5317916lbw.94.1408397056711;
        Mon, 18 Aug 2014 14:24:16 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255432>

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
 git-rebase--interactive.sh | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 614579c..6a123f0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -626,39 +626,19 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			if ! pick_one -n $sha1
-			then
-				git rev-parse --verify HEAD >"$amend"
-				die_failed_squash $sha1 "Could not apply $sha1... $rest"
-			fi
-			output git commit --allow-empty-message --allow-empty \
-				--amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die_failed_squash $sha1 "$rest"
+			do_pick --amend -F "$squash_msg" $sha1 \
+				|| die_failed_squash $sha1 "$rest"
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
-				output git commit --allow-empty-message --allow-empty \
-					--amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_pick --amend -F "$fixup_msg" $sha1 \
+					|| die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $sha1 \
+					|| die_failed_squash $sha1 "$rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
 			if test -z "$keep_empty" && is_empty_commit HEAD
-- 
2.0.1
