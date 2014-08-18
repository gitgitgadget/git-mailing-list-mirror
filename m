From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 15/27] rebase -i: do not die in do_pick
Date: Mon, 18 Aug 2014 23:22:58 +0200
Message-ID: <9d68cb8df89937fa71a93416d573213fcadec6ba.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPd-0000aA-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbaHRVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:10 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:48868 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaHRVYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:09 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so4602442lbi.24
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I7KfAN8HbFXbeK1c7sKppdkhPwbiQsQZSbUPWlo5T5w=;
        b=mwwYUwP1qX4pjRtUqmAQg/oYiDo+TJufznRB0cRR3E0o/mCPbk/5wUcD/roRI3RE9b
         1xdsDPxmvN5Axp4E9w6qaxZwlj2CFCc8C/zvKfxhRcBPxpzCz/S4evVTihc17l5MfX2C
         cQ6AwTxTDTN3pzEjAvzvt6iW+Th1zoWZPIbXLMTq9GL9O/kdCUS7PRU+Yr0oP6Gni+OP
         me2S4J40KJ1+9weNetgFebNHuuPeQrjj/2jV4GhWpqcV0zS2k8msof/KaPWFLr4woA6o
         BwLTWbamWv1JlRVYZFZ1VV3pzqYi3ANUgITdiEPgPQ9yg7D/f6QyeYiim1EBHcQ7ujCI
         8ouA==
X-Received: by 10.152.29.135 with SMTP id k7mr32379866lah.14.1408397047646;
        Mon, 18 Aug 2014 14:24:07 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255420>

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
 git-rebase--interactive.sh | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 181e06a..a5a8aa3 100644
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
@@ -534,8 +539,7 @@ do_pick () {
 			   ${allow_empty_message:+--allow-empty-message} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit --commit-msg} \
-			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
 
@@ -550,21 +554,21 @@ do_next () {
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
