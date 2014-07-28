From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 10/19] rebase -i: do not die in do_pick
Date: Tue, 29 Jul 2014 01:18:10 +0200
Message-ID: <f653cde6193722194f2777b985ec08aa72d8a86b.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDx-0006Bf-M6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbaG1XUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:55 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54834 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbaG1XUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:52 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so5217939wiv.5
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGWaSNpFjSprKgaM8MnCzjWQ37lY+MOAaRfhHiTNs4w=;
        b=o0bl81WfwiiG/paNMO/RMcRupwdNpYQEavl/Pky7mqjz9MKUjgmrd1ma3aBUqpaYGT
         pX7otSRwz+IVGtaww3pRNkFXqy/JMvmDekW60X0746JOisAKKaubb9vG6O4iIV3U/3Lx
         8qSjT7W2vA1ytNPO7bkNp2hwTlftNs1ZIAtUs0cBs2Nad6yFymdaxOVWoFZmRLvsHohc
         K/uXGllJma175p8UgEosU0gnrGdgSW6x55fLGCCembmZtMWH+hF01Aq3drE8YG+yoyga
         sFf5X4k5S2uQ6LXTNyS/mP3G9+maWx8NYjRKsYbfXQQ6oRPiB9zcj4HQFUGAnxNzadUH
         oXHQ==
X-Received: by 10.180.82.97 with SMTP id h1mr571111wiy.74.1406589651184;
        Mon, 28 Jul 2014 16:20:51 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254369>

Since `do_pick` might be executed in a sub-shell (a modified author
environment for instance), calling `die` in `do_pick` has no effect
but exiting the sub-shell with a failure exit status. The
git-rebase--interactive script is not terminated. Moreover, if
`do_pick` is called while a squash or fixup is in effect,
`die_with_patch` will discard `$squash_msg` as commit message.
Lastly, after a `die` in `do_pick` `do_next` has no chance to
reschedule tasks that failed before changes could be applied.

Indicate an error in `do_pick` using return statements and properly
kill the script at the call sites. Although possible in principle,
the issued error messages are no more indicating whether `do_pick`
failed while applying or while committing the changes. This reduces
code complexity at the call site and does not matter from a user's
point of view because a glance at the index reveals whether there are
conflicts or not and in-depth troubleshooting is still possible using
the `--verbose` option.

Remove the commit message title argument from `do_pick`'s interface,
which has become unused.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 96c24e8..9f08f1b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -464,7 +464,7 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--edit] <commit> <title>
+# do_pick [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
@@ -476,9 +476,11 @@ record_in_rewritten() {
 # <commit>
 #     The commit to cherry-pick.
 #
-# <title>
-#     The commit message title of <commit>. Used for information
-#     purposes only.
+# The return value is 1 if applying the changes resulted in a conflict
+# and 2 if the specified arguments were incorrect. If the changes could
+# be applied successfully but creating the commit failed, a value
+# greater than 2 is returned. No commit is created in either case and
+# the index is left with the (conflicting) changes in place.
 do_pick () {
 	allow_empty_message=y
 	rewrite=
@@ -493,7 +495,8 @@ do_pick () {
 			allow_empty_message=
 			;;
 		-*)
-			die "do_pick: unrecognized option -- $1"
+			warn "do_pick: unrecognized option -- $1"
+			return 2
 			;;
 		*)
 			break
@@ -501,7 +504,11 @@ do_pick () {
 		esac
 		shift
 	done
-	test $# -ne 2 && die "do_pick: wrong number of arguments"
+	if test $# -ne 1
+	then
+		warn "do_pick: wrong number of arguments"
+		return 2
+	fi
 
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
@@ -519,11 +526,9 @@ do_pick () {
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+			pick_one -n $1 || return 1
 	else
-		pick_one ${rewrite:+-n} $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+		pick_one ${rewrite:+-n} $1 || return 1
 	fi
 
 	if test -n "$rewrite"
@@ -532,8 +537,7 @@ do_pick () {
 			   ${allow_empty_message:+--allow-empty-message} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
-			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 
 	# TODO: Work around the fact that git-commit lets us
@@ -546,8 +550,7 @@ do_pick () {
 		if test -x "$GIT_DIR"/hooks/commit-msg
 		then
 			"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
-		fi ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+		fi || return 3
 	fi
 }
 
@@ -562,21 +565,21 @@ do_next () {
 		comment_for_reflog pick
 
 		mark_action_done
-		do_pick $sha1 "$rest"
+		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick --edit $sha1 "$rest"
+		do_pick --edit $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
 		comment_for_reflog edit
 
 		mark_action_done
-		do_pick $sha1 "$rest"
+		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
 		warn "Stopped at $sha1... $rest"
 		exit_with_patch $sha1 0
 		;;
-- 
2.0.1
