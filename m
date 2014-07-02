From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 10/19] rebase -i: Do not die in do_pick
Date: Wed,  2 Jul 2014 19:48:02 +0200
Message-ID: <50ca26dbebbc291af5110770665c283375345bbd.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OfW-0006lZ-6x
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbaGBRt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:49:57 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46325 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbaGBRtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:55 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so10029918wiv.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T91jAzwEqDE0O9ehXTf0Pghp92qQrB+5F0DI7wLV6Aw=;
        b=eSab+Ym1TSJelium5EcUQYgXCHilKnDCqHE/a2ZzgEcOCp4dKwicFPqMNdEU+77phh
         2ZXRX2atDvULEABTSnP7fKZNWlnwC77Hp8gVhqvd4PMKJRG/Y1jBb4IjL5S3pWHTpOzd
         Lnfp3TXDEGhTPaQJvQWBp1RuxRby1r9F6m6vzd6Hk7iHX2xy0TDUtNuIh5rOeCganX3I
         h9zUWM6rxjSNxERV4WQZuVIprCzvGXS/LNcbuT++2lNP+OjedmI/d854w/3w5pEIgqiT
         LWCtff6Kav2lZ4np04LQdjoddgVSuSjGakALt78zA5sseyF0Ucdp2cWSKepxl8Xcf3hH
         hBvw==
X-Received: by 10.180.76.132 with SMTP id k4mr5806467wiw.1.1404323393792;
        Wed, 02 Jul 2014 10:49:53 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252812>

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
index 46b2db1..0070b3e 100644
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
 	rewrite=
 	rewrite_amend=
@@ -491,7 +493,8 @@ do_pick () {
 			rewrite_edit=y
 			;;
 		-*)
-			die "do_pick: unrecognized option -- $1"
+			warn "do_pick: unrecognized option -- $1"
+			return 2
 			;;
 		*)
 			break
@@ -499,7 +502,11 @@ do_pick () {
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
@@ -517,11 +524,9 @@ do_pick () {
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
@@ -529,8 +534,7 @@ do_pick () {
 		git commit --allow-empty --no-post-rewrite -n --no-edit \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
-			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 
 	# TODO: Work around the fact that git-commit lets us
@@ -543,8 +547,7 @@ do_pick () {
 		if test -x "$GIT_DIR"/hooks/commit-msg
 		then
 			"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
-		fi ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+		fi || return 3
 	fi
 }
 
@@ -559,21 +562,21 @@ do_next () {
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
2.0.0
