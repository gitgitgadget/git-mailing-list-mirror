From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 14/27] rebase -i: commit only once when rewriting picks
Date: Mon, 18 Aug 2014 23:22:57 +0200
Message-ID: <1ac131d6fbcb3ba7e086e31db9a8d87cae66b8b5.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJURD-0001RZ-VB
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbaHRVZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:25:43 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61452 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbaHRVYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:07 -0400
Received: by mail-lb0-f172.google.com with SMTP id z11so4740538lbi.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Tz79r7hqag6W1ok7+Jvsi5HyL46p7Sr5VE/QkKQLkc=;
        b=psxS4m+FshrGJJWbsp551XIfPAgGJMi88cbN/vZgZFq9jmwxvX/M+wAinVTUNSXMjp
         qMouVUNjtmKQ4dTmEZ5l4/V64ts7IWK2FsbfOxrKi9QjlzvmI9s11WtiqFr8ChGTq4MO
         XpQPMboSGVVq2AkwvWUcJy1OrOJaURETJQhKPVWQ+HjmPwt60VizUyo2QFI+IIlxqNPr
         S7QqnamABJB/eMpnQj+uY8yhe7L45iAYKCAXJOcSszu8jeEIQ5qHAduVgULwinvxvN3z
         bAikyZI6ykbxhACGhbvvrsBhlUGVHdT51ssPmBapVqi6NCY0tqHsqoMP4A35XfBDPkbr
         wO3Q==
X-Received: by 10.152.87.229 with SMTP id bb5mr32214678lab.75.1408397045883;
        Mon, 18 Aug 2014 14:24:05 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255436>

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
 git-rebase--interactive.sh    | 41 ++++++++++++++++++++++++++---------------
 t/t3404-rebase-interactive.sh | 10 ++++++++++
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6561831..181e06a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -63,9 +63,10 @@ msgnum="$state_dir"/msgnum
 author_script="$state_dir"/author-script
 
 # When an "edit" rebase command is being processed, the SHA1 of the
-# commit to be edited is recorded in this file.  When "git rebase
-# --continue" is executed, if there are any staged changes then they
-# will be amended to the HEAD commit, but only provided the HEAD
+# commit to be edited is recorded in this file.  The same happens when
+# rewriting a root commit fails, for instance "reword".  When "git
+# rebase --continue" is executed, if there are any staged changes then
+# they will be amended to the HEAD commit, but only provided the HEAD
 # commit is still the commit to be edited.  When any other rebase
 # command is processed, this file is deleted.
 amend="$state_dir"/amend
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
@@ -509,22 +519,23 @@ do_pick () {
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
+		eval $(get_author_ident_from_commit $1)
+		do_with_author output git commit \
+			   --allow-empty --no-post-rewrite -n --no-edit \
+			   ${allow_empty_message:+--allow-empty-message} \
+			   ${rewrite_amend:+--amend} \
+			   ${rewrite_edit:+--edit --commit-msg} \
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
 	fi
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ecdab11..8de7a39 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -270,6 +270,16 @@ test_expect_success 'retain authorship' '
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
+test_expect_success 'retain authorship (reword)' '
+	echo A > file8 &&
+	git add file8 &&
+	test_tick &&
+	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
+	set_fake_editor &&
+	FAKE_LINES="reword 1" git rebase -i --onto master HEAD^ &&
+	git show HEAD | grep "^Author: Twerp Snog"
+'
+
 test_expect_success 'setup squash/fixup reverted and fixed feature' '
 	git checkout -b reverted-feature master &&
 	test_commit feature &&
-- 
2.0.1
