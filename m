From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 13/23] rebase -i: commit only once when rewriting picks
Date: Thu,  7 Aug 2014 01:59:20 +0200
Message-ID: <eb8d96ee984a7e55a43ca0bcbdce74bea7f5e088.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8j-0004DU-At
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461AbaHGAAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:49 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34678 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbaHGAAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:47 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so3552049qgd.19
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTNurlJUHBHFq+t9zQ2EAt68WQ0Iszo1RUcx+EK8UDU=;
        b=QogZEuBuEJMv0xaZi499+rcK1DwYgSjdhkDemBsfMARfCAoEsYsy+4HiYHDY3QfKTh
         a99k/Wo7ZtfQCmmswpImNzk2f89eg/NVFxhwzLp85Lz0Uh9gsL5ysNX9Zx4o7wNwGJYn
         zOUBL0VmLdwVAD2Bf1YRWCnnXKJwTlHSY0j8feNxlMk+h9BNmFdtDnA2/UX2pv6e3Cbh
         pSK0JTRRdeJcbYNYOCX7z+iWm1CWOOsH5SqcF7RRJ3qYqzg9MUXel9DXX8Y/GfBSdl2q
         Kbe2jqpsqfCF/9olaZdDQFTQ/EjpGGtoe6OhB5zxDeOi8xgI1Cfez3eSFufuvyoBkbEv
         s+jA==
X-Received: by 10.229.211.132 with SMTP id go4mr21900408qcb.0.1407369646575;
        Wed, 06 Aug 2014 17:00:46 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254928>

The options passed to `do_pick` determine whether the picked commit
will be rewritten or not. If the commit gets rewritten, because the
user requested to edit the commit message for instance, let
`pick_one` merely apply the changes introduced by the commit and do
not commit the resulting tree yet. If the commit is replayed as is,
leave it to `pick_one` to recreate the commit (possibly by
fast-forwarding the head). This makes it easier to combine git-commit
options like `--edit` and `--amend` in `do_pick` because
git-cherry-pick does not support `--amend`.

In the case of `--edit`, do not `exit_with_patch` but assign
`rewrite` to pick the changes with `-n`. If the pick conflicts, no
commit is created which we would have to amend when continuing the
rebase. To complete the pick after the conflicts are resolved the
user just resumes with `git rebase --continue`.

git-commit lets the user edit the commit log message by default. We
do not want that for the rewriting git-commit command line because
the default behaviour of git-rebase is exactly the opposite. Pass
`--no-edit` when rewriting a picked commit. An explicit `--edit`
passed to `do_pick` (for instance, when reword is executed) enables
the editor launch again. Similarly, pass `--allow-empty-message`
unless the log message is edited.

If `rebase--interactive` is used to rebase a complete branch onto
some head, `rebase` creates a sentinel commit that requires special
treatment by `do_pick`. Do not finalize the pick here either because
its commit message can be altered as for any other pick. Since the
orphaned root commit gets a temporary parent, it is always rewritten.
Safely use the rewrite infrastructure of `do_pick` to create the
final commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 71571c8..b8c734e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -63,7 +63,8 @@ msgnum="$state_dir"/msgnum
 author_script="$state_dir"/author-script
 
 # When an "edit" rebase command is being processed, the SHA1 of the
-# commit to be edited is recorded in this file.  When "git rebase
+# commit to be edited is recorded in this file.  The same happens when
+# rewriting a commit fails, for instance "reword".  When "git rebase
 # --continue" is executed, if there are any staged changes then they
 # will be amended to the HEAD commit, but only provided the HEAD
 # commit is still the commit to be edited.  When any other rebase
@@ -479,12 +480,17 @@ record_in_rewritten() {
 #     The commit message title of <commit>. Used for information
 #     purposes only.
 do_pick () {
-	edit=
+	allow_empty_message=y
+	rewrite=
+	rewrite_amend=
+	rewrite_edit=
 	while test $# -gt 0
 	do
 		case "$1" in
 		-e|--edit)
-			edit=y
+			rewrite=y
+			rewrite_edit=y
+			allow_empty_message=
 			;;
 		-*)
 			die "do_pick: unrecognized option -- $1"
@@ -499,6 +505,10 @@ do_pick () {
 
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
+		rewrite=y
+		rewrite_amend=y
+		git rev-parse --verify HEAD >"$amend"
+
 		# Set the correct commit message and author info on the
 		# sentinel root before cherry-picking the original changes
 		# without committing (-n).  Finally, update the sentinel again
@@ -509,22 +519,21 @@ do_pick () {
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 &&
-			output git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n --no-edit \
-				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+			pick_one -n $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-		pick_one $1 ||
+		pick_one ${rewrite:+-n} $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	fi
 
-	if test -n "$edit"
+	if test -n "$rewrite"
 	then
-		output git commit --allow-empty --amend --no-post-rewrite --no-pre-commit ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $1... $2"
-			exit_with_patch $1 1
-		}
+		output git commit --allow-empty --no-post-rewrite -n --no-edit \
+			   ${allow_empty_message:+--allow-empty-message} \
+			   ${rewrite_amend:+--amend} \
+			   ${rewrite_edit:+--edit --commit-msg} \
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
 	fi
 }
 
-- 
2.0.1
