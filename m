From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 09/19] rebase -i: commit only once when rewriting picks
Date: Tue, 29 Jul 2014 01:18:09 +0200
Message-ID: <235b55a0ec3db4a111fbb32e58e578ced6307d72.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEJ-0006Li-O4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbaG1XU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:56 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:39975 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaG1XUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:51 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so5064969wiw.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xrk+l3T7/NvfwzI/QgZ2XcgWXBCfI2qEg3yyz8P6I6g=;
        b=zjhtuIpjFnLFYrnjKH2MAoc0Z2HdzOhFIk+Dz4YBZr4NRhmbTdnfU8ulqJFmEmk52M
         WTIf+jiGkHkbFrLjIRWsBi8kwhDZiD0/GXVx1aqZeYHnhbhvj2msXjrkGtesuFZ7Ihqm
         sGvkZ1BHDLXPnH3kxrsF4pJRAZmQp26O5Sqc2O66RNm3cwoFmfSsaLeJtt3Zn1Y0Z2xD
         9SICYjy4bExZXPDCi1nUhl8hkQDI2fVJY8hFPyT0/Tz5s/ba39XMfNKohx9/E0Q4Ghbn
         qGzHQvUWit9zqES023ezw+P6o/ThkcaS3f7hVOCwPhQUPZFARF2IDpEoAWyTN/gwicsi
         DdNQ==
X-Received: by 10.180.187.197 with SMTP id fu5mr24646046wic.64.1406589649782;
        Mon, 28 Jul 2014 16:20:49 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254371>

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
 git-rebase--interactive.sh | 58 ++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 46f436f..96c24e8 100644
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
@@ -509,31 +519,35 @@ do_pick () {
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 &&
-			git commit --allow-empty --allow-empty-message \
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
+			   ${allow_empty_message:+--allow-empty-message} \
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
2.0.1
