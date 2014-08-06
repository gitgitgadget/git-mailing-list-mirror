From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 14/23] rebase -i: do not die in do_pick
Date: Thu,  7 Aug 2014 01:59:21 +0200
Message-ID: <2bd4cfaa20c582c9dd78d2ff917294e8250bf3b6.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB97-0004qT-G0
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbaHGABW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:22 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:46743 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbaHGAAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:48 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so3272302qab.18
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+m9Iv7kFZ+JHIgDEBFYM3L8mDzGnTl69DUeK/wT6AM=;
        b=fIOYROF7cgJdyo+m6zcRySMuo6RvFcP7C8ORFm7I6zlmLRa8n5B93kE0d2WSj3Mn8p
         k8R0QxhW7ePAFpEym8d37A2WjZZoqmbZH+gJr5iauo8svqCFsn+oVPuR8cw17QRrIpq+
         EAubM5QPMBYlMcnZ9IOMYGT9vmR1rnMBLCTNMajNoAHGLoeq24k8fZinNClXCs8fmcJR
         1/QIN3WgqKHtLf+POAPoYUqPh2hgW8aswZVU2aEGMHof9PPmrB1WwB2DHkpgzYD9Wmb9
         2gbGpEWxKqDwKRpzVRSyjS669hcOA4L/P1xZg/d4+ZyTAEW7/cRSv/fY3MiioZr0w0tL
         CovA==
X-Received: by 10.229.225.131 with SMTP id is3mr21855643qcb.2.1407369648163;
        Wed, 06 Aug 2014 17:00:48 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254938>

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
index b8c734e..d812bad 100644
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
 			   ${rewrite_edit:+--edit --commit-msg} \
-			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
 
@@ -548,21 +552,21 @@ do_next () {
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
