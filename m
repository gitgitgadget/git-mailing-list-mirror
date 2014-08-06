From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 18/23] rebase -i: implement squash in terms of do_pick
Date: Thu,  7 Aug 2014 01:59:25 +0200
Message-ID: <3d6a547c972c3ff057f6494e9e3f02cee5d7af4a.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8l-0004DU-AU
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbaHGAA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:57 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:58747 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbaHGAAz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:55 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so3588295qgd.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cc1lcUQYwHaCLq/uheTJ04EqHMicta2Fk2ZFEOmCyqM=;
        b=J/3NtgZjnqiM5xlA8rVmGmuadsBViX9zQ4vHUVv5a4pHJzjZSVZZ51o3EyUoNEh2h7
         5uiiLIU0PEKZ0yvWb9REDdk5La8oIyT18ki4EOCqEpqNTDFzz3OiyAII4B3RDygKL+89
         KW2YNM8KkWWmOp69gwqtLkM2NB8E21+c5qRd9VegpKaqqmIpZks1WHwH10QG3L80ZUBg
         L/A9+Y00zoUN0lfF1rYp0i+onoE7natxs1pAW4l2QM/Y6b2HNGSON/9+R5ITrQ50SnFW
         eW2k2xzp94dUXj+F9xX60hya/1+WxHKJvSHV7tBjDGhAQahECtdE2bLjba7fJYH9kk4S
         PFQQ==
X-Received: by 10.229.86.9 with SMTP id q9mr21680969qcl.5.1407369654716;
        Wed, 06 Aug 2014 17:00:54 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254929>

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
index 601a2ff..29eca7e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -627,39 +627,19 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			if ! pick_one -n $sha1
-			then
-				git rev-parse --verify HEAD >"$amend"
-				die_failed_squash $sha1 "Could not apply $sha1... $rest"
-			fi
-			do_with_author output git commit --allow-empty-message --allow-empty \
-				--amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die_failed_squash $sha1 "$rest"
+			do_with_author do_pick --amend -F "$squash_msg" $sha1 \
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
-				do_with_author output git commit --allow-empty-message --allow-empty \
-					--amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$fixup_msg" $sha1 \
+					|| die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $sha1 \
+					|| die_failed_squash $sha1 "$rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
 			if test -z "$keep_empty" && is_empty_commit HEAD
-- 
2.0.1
