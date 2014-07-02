From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 09/19] rebase -i: Commit only once when rewriting picks
Date: Wed,  2 Jul 2014 19:48:01 +0200
Message-ID: <778d3832309bc21f74301926844cacc862ce9bb2.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OfV-0006lZ-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703AbaGBRty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:49:54 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:50282 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbaGBRtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:52 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so11825600wgg.32
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sxUVPYjwNPQSLVCvRHxIIklqmjPTazsjYS3h5Lu7/3c=;
        b=fOifVlzVFRdDy4rDqbf786W7rmlAv9q8gpn5uvAzCIH6IN9Vy8BV4aaX8zQlR35zkB
         nVtOsXEXKqrbEemhvhl60sWhtAk9lvsQulJV/nxaInvOGti1EYcXwaoeidqpu8OK+KMU
         7Bpz7P4EwTWVL+/V5LRdFi5/JBdAJ3QgKDQvSTIB/imhC94tDgGX9DW+UwNJ1cu7UnwN
         RflN5JQZpqE1EDVeeB6ux0Au4gsWColdCqxgnX463ebr1N7ERlKGjhYsYVp3pUGmNpsY
         3qWkJZprB5wpxnukEm/tG1K4UOj2kOT4BZiBkJ8c5SBgXWHBbq4V19gExpk5VzyXm7l2
         9V4g==
X-Received: by 10.180.13.230 with SMTP id k6mr45171155wic.1.1404323391477;
        Wed, 02 Jul 2014 10:49:51 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252809>

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
the default behaviour of git-cherry-pick is exactly the opposite.
Pass `--no-edit` when rewriting a picked commit. An explicit `--edit`
passed to `do_pick` (for instance, when reword is executed) enables
the editor launch again.

If `rebase--interactive` is used to rebase a complete branch onto
some head, `rebase` creates a sentinel commit that requires special
treatment by `do_pick`. Do not finalize the pick here either because
its commit message can be altered as for any other pick. Since the
orphaned root commit gets a temporary parent, it is always rewritten.
Safely use the rewrite infrastructure of `do_pick` to create the
final commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 55 +++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 17836d5..46b2db1 100644
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
@@ -479,12 +480,15 @@ record_in_rewritten() {
 #     The commit message title of <commit>. Used for information
 #     purposes only.
 do_pick () {
-	edit=
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
 			;;
 		-*)
 			die "do_pick: unrecognized option -- $1"
@@ -499,6 +503,10 @@ do_pick () {
 
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
+		rewrite=y
+		rewrite_amend=y
+		git rev-parse --verify HEAD >"$amend"
+
 		# Set the correct commit message and author info on the
 		# sentinel root before cherry-picking the original changes
 		# without committing (-n).  Finally, update the sentinel again
@@ -509,31 +517,34 @@ do_pick () {
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 &&
-			git commit --allow-empty \
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
-				warn "Could not amend commit after successfully picking $1... $2"
-				exit_with_patch $1 1
-			}
+		git commit --allow-empty --no-post-rewrite -n --no-edit \
+			   ${rewrite_amend:+--amend} \
+			   ${rewrite_edit:+--edit} \
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+	fi
+
+	# TODO: Work around the fact that git-commit lets us
+	# disable either both the pre-commit and the commit-msg
+	# hook or none. Disable the pre-commit hook because the
+	# tree is left unchanged but run the commit-msg hook
+	# from here because the log message is altered.
+	if test -n "$rewrite_edit"
+	then
+		if test -x "$GIT_DIR"/hooks/commit-msg
+		then
+			"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
+		fi ||
+			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
 	fi
 }
 
-- 
2.0.0
