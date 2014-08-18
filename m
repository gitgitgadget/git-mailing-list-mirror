From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 18/27] rebase -i: remove no-op do_with_author git commit --amend
Date: Mon, 18 Aug 2014 23:23:01 +0200
Message-ID: <7b099a9806ac31d5b686c6fb790301c0c14aae67.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPr-0000iP-BA
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbaHRVYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:18 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:57985 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbaHRVYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:14 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so4637939lbg.20
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/y3fZdsjB+3GKkai+vboMt4NtfrbkQx2IOODp5X4naQ=;
        b=Het+3sdbf95aSjUrAPSBDAe5qm7TR8wELvNi3GGYlW3WLVrNTscQI4tvl8EfVMI+On
         90IWL825rb0kqR8R3oyjMLlSjquD7OG5cgRCcZMQWf/lN/Y0Z3dWDlAnkh4ygeCmlMBW
         PKXeoWyOP6nhX9McduDvuqbFUOKM8MCM5mZxJJNankMeniOWdfpkdjSNyLOiMY7lsx0m
         wRR/pi5wkUbrRX05jibgIMOvGVdtwwLKWSnqkKj0po4VP/t7AA4vDOgDC8XPjU9Jk7U4
         x1lIko1ub9PZNGxgXiwbZJjA38jhVug0nz8HNHerifs8HXLorvCwj5/H0JC+msXqIHab
         7V8w==
X-Received: by 10.152.25.136 with SMTP id c8mr32455969lag.64.1408397053039;
        Mon, 18 Aug 2014 14:24:13 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:12 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255424>

The author script is a file in the state directory that contains
assignments of the environment variables

    GIT_AUTHOR_NAME
    GIT_AUTHOR_EMAIL
    GIT_AUTHOR_DATE

to be evaluated by the shell. It is used to store author information
and has two applications in `git-rebase--interactive.sh`. Firstly,
the authorship of squash commits is read from it while the squash
commit is being amended step by step. Secondly, after conflict
resolution `git rebase --continue` restores the author information of
the original commit by sourcing the author script. For the
assignments of the git environment variables to take effect,
git-rebase--interactive executes the respective git-commit commands
wrapped in `do_with_author`. That shell function executes the named
command in a subshell that exports the git environment variables.

Since

    git commit --amend

has been used instead of

    git reset --soft HEAD^
    git commit

to amend squash commits, wrapping git-commit in `do_with_author` has
become a no-op because, unless the `--reset-author` option is
specified, `git commit --amend` ignores the user environment and
reuses the authorship of the commit it amends. To make the code
clearer and until we decide to use other authorships for squash
commits than the one of the first commit, unwrap `git commit
--amend`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 17 +++++++----------
 t/t3404-rebase-interactive.sh | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f8be238..ab807e5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -622,9 +622,6 @@ do_next () {
 
 		mark_action_done
 		update_squash_messages $squash_style $sha1
-		author_script_content=$(get_author_ident_from_commit HEAD)
-		echo "$author_script_content" > "$author_script"
-		eval "$author_script_content"
 		if ! pick_one -n $sha1
 		then
 			git rev-parse --verify HEAD >"$amend"
@@ -634,7 +631,7 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			do_with_author output git commit --allow-empty-message --allow-empty \
+			output git commit --allow-empty-message --allow-empty \
 				--amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die_failed_squash $sha1 "$rest"
@@ -643,14 +640,14 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author output git commit --allow-empty-message --allow-empty \
+				output git commit --allow-empty-message --allow-empty \
 					--amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
-				do_with_author output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
+				output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			fi
@@ -939,7 +936,7 @@ continue)
 	then
 		: Nothing to commit -- skip this
 	else
-		if ! test -f "$author_script"
+		if ! test -f "$author_script" && ! test -f "$amend"
 		then
 			gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
 			die "You have staged changes in your working tree. If these changes are meant to be
@@ -956,8 +953,6 @@ In both case, once you're done, continue with:
   git rebase --continue
 "
 		fi
-		. "$author_script" ||
-			die "Error trying to find the author identity to amend commit"
 		if test -f "$amend"
 		then
 			current_head=$(git rev-parse --verify HEAD)
@@ -965,10 +960,12 @@ In both case, once you're done, continue with:
 			die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
-			do_with_author git commit --amend --no-verify -F "$msg" -e \
+			git commit --amend --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		else
+			. "$author_script" ||
+				die "Error trying to find the author identity to amend commit"
 			do_with_author git commit --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8de7a39..c037a07 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1270,4 +1270,27 @@ test_expect_success 'fixup commits with empty commit log messages' '
 	env FAKE_LINES="1 fixup 2" git rebase -i master
 '
 
+test_expect_success 'squash commits have authorship of the first commit' '
+	git checkout -b squash-authorship master &&
+	git cat-file commit HEAD~3 | sed -n -e "/^$/q" -e "/^author /p" >expected.author &&
+	test_tick &&
+	set_fake_editor &&
+	FAKE_LINES="1 squash 2 squash 3 fixup 4" git rebase -i HEAD~4 &&
+	git cat-file commit HEAD | sed -n -e "/^$/q" -e "/^author /p" >actual.author &&
+	test_cmp expected.author actual.author
+'
+
+test_expect_success 'squash commits have authorship of the first commit after conflict' '
+	git checkout -b squash-authorship-conflict conflict-branch &&
+	git cat-file commit HEAD~3 | sed -n -e "/^$/q" -e "/^author /p" >expected.author &&
+	test_tick &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 squash 2 squash 4 fixup 3" git rebase -i HEAD~4 &&
+	git checkout --ours conflict &&
+	git add conflict &&
+	git rebase --continue &&
+	git cat-file commit HEAD | sed -n -e "/^$/q" -e "/^author /p" >actual.author &&
+	test_cmp expected.author actual.author
+'
+
 test_done
-- 
2.0.1
