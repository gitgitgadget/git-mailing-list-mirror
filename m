From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 27/27] rebase -i: enable --signoff, --reset-author for pick, reword, edit
Date: Mon, 18 Aug 2014 23:23:10 +0200
Message-ID: <3e91ba1f6f59b9667c329b224a4f54bf0af9ee3e.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUQ6-0000qU-0l
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbaHRVYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:33 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:44038 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbaHRVYb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:31 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so4682285lbj.23
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lfQfd5xhTHEN1FYtD8L4L85rMvmEbvL33EndBeplevQ=;
        b=fdOWeVxkENKYD1KtCple8akrjZHcaO3bPi5IFVK7HabBMtNu0o/0fV3Dg6AnokmwRc
         P9z5x6jeED8gsXEwJzIqPqNbUMKiTcsQDGTlwWuAyeph8G9V1+QML7P1suNJS0cXDO7Y
         53kzvDQjgfAiLlahUYuCLCDr0+IQFnDpo7DOKAt0VKQJsYxkXvMb/o3nKb+ZPQteiFFx
         rt7PJhV8Phzp1cIIdOsqhKEQZoagbhrK9KL0EZ1zAWbqwoRXTB/hzCFmzu3fZ1gh4JmH
         6DRSzAvm8607bGcnj/5w3VW7lQnFW4XZXDGphw3h/ETmnYiKXB29zXJgMBZSdcLUCeXg
         M0FQ==
X-Received: by 10.112.221.37 with SMTP id qb5mr30053056lbc.69.1408397069881;
        Mon, 18 Aug 2014 14:24:29 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255429>

Lift the general unknown option blockade for the `pick`, `reword` and
`edit` commands. If `do_cmd` comes across one of the options
`--signoff` and `--reset-author` while parsing a to-do entry and the
scheduled command is either `pick` or `reword`, relay the option to
`do_pick`.

Remember to add Signed-off-by: and to reset the authorship even when
the rebase is interrupted for conflict resolution and `git rebase
--continue` creates the commit. Employ the same mechanism that is
used to remember amending an interim squash commit after conflict
resolution or a commit after editing. If a line option was specified,
create the files `signoff` and `resetauthor` respectively in the
state directory. While `signoff` is handled by simply specifying the
`--signoff` option when creating the commit, the `resetauthor` case
is somewhat more involved. The author script contains the author
information of the replayed commit. Renewing the authorship means
using the user environment for the authorship so that we need to skip
the author script if `resetauthor` exists and we are not amending. If
we are amending, `--reset-author` must be passed to git-commit
because otherwise the authorship of HEAD would be used.

`do_pick` options like `--gpg-sign` and `--file` are not yet
supported because `do_cmd` cannot handle option arguments and options
with spaces at the moment. `squash` and `fixup` still do not accept
user options as the interplay of `--reset-author` and the author
script is yet to be determined.

Document the new options by listing them in the to-do help and giving
a usage example in the "INTERACTIVE MODE" section of the git-rebase
man page.

Add tests.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 Documentation/git-rebase.txt   |  13 +++
 git-rebase--interactive.sh     |  38 +++++++-
 t/t3427-rebase-line-options.sh | 192 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 240 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2a93c64..10c0fd2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -508,6 +508,19 @@ rebasing.
 If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
 
+The commands "pick", "reword" and "edit" understand some well-known
+options. To add a Signed-off-by line at the end of the commit
+message, pass the `--signoff` option. The authorship can be renewed
+by specifying the `--reset-author` option. For instance, before you
+decide to publish a heavily edited commit you might want to reset the
+authorship and add your signature. You can do so on a per line basis:
+
+-------------------------------------------
+pick deadbee The oneline of this commit
+pick --reset-author --signoff fa1afe1 The oneline of the next commit
+...
+-------------------------------------------
+
 If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 51ee80c..0db5001 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -72,9 +72,15 @@ last_head="$state_dir"/last_head
 # file 'amend' is created. When "git rebase --continue" is executed,
 # if there are any staged changes then they will be amended to the
 # HEAD commit, but only provided the HEAD commit is still the commit
-# to be edited or the squash commit. When any other rebase command is
+# to be edited or the squash commit. Similarly, when a Signed-off-by:
+# should be added to a log message or the authorship should be
+# renewed, the files 'signoff' and 'resetauthor' are created
+# respectively, and "git rebase --continue" carries out the changes
+# after conflict resolution. When any other rebase command is
 # processed, these files are deleted.
 amend="$state_dir"/amend
+signoff="$state_dir"/signoff
+resetauthor="$state_dir"/resetauthor
 
 # For the post-rewrite hook, we make a list of rewritten commits and
 # their new sha1s.  The rewritten-pending list keeps the sha1s of
@@ -149,6 +155,10 @@ Commands:
  f, fixup = like "squash", but discard this commit's log message
  x, exec = run command (the rest of the line) using shell
 
+Options:
+ [pick | reword | edit] --signoff = add a Signed-off-by line
+ [pick | reword | edit] --reset-author = renew authorship
+
 These lines can be re-ordered; they are executed from top to bottom.
 
 If you remove a line here THAT COMMIT WILL BE LOST.
@@ -528,10 +538,12 @@ do_pick () {
 		-s|--signoff)
 			rewrite=y
 			rewrite_signoff=y
+			>"$signoff"
 			;;
 		--reset-author)
 			rewrite=y
 			rewrite_reset_author=y
+			>"$resetauthor"
 			;;
 		--amend)
 			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse -q --verify HEAD >/dev/null
@@ -630,6 +642,15 @@ do_replay () {
 	while test $# -gt 0 && test -z "$malformed"
 	do
 		case "$1" in
+		--signoff|--reset-author)
+			case "$command" in
+			pick|reword|edit)
+				;;
+			*)
+				malformed="Unsupported '$command' option: $1"
+				;;
+			esac
+			;;
 		-*)
 			malformed="Unknown '$command' option: $1"
 			;;
@@ -739,7 +760,7 @@ do_replay () {
 }
 
 do_next () {
-	rm -f "$msg" "$author_script" "$amend" || exit
+	rm -f "$msg" "$author_script" "$amend" "$signoff" "$resetauthor" || exit
 	git rev-parse --verify HEAD >"$last_head" || exit
 	read -r command args <"$todo"
 
@@ -1043,15 +1064,28 @@ In both case, once you're done, continue with:
 			die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
+		rewrite_reset_author=
+		rewrite_signoff=
+		test -f "$resetauthor" && rewrite_reset_author=y
+		test -f "$signoff" && rewrite_signoff=y
 		if test -f "$amend"
 		then
 			git commit --amend --no-verify -F "$msg" -e \
+				${rewrite_signoff:+--signoff} \
+				${rewrite_reset_author:+--reset-author} \
+				${gpg_sign_opt:+"$gpg_sign_opt"} ||
+				die "Could not commit staged changes."
+		elif test -n "$rewrite_reset_author"
+		then
+			git commit --no-verify -F "$msg" -e \
+				${rewrite_signoff:+--signoff} \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		else
 			test -r "$author_script" ||
 				die "Error trying to find the author identity to amend commit"
 			do_with_author $(cat "$author_script") git commit --no-verify -F "$msg" -e \
+				${rewrite_signoff:+--signoff} \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		fi
diff --git a/t/t3427-rebase-line-options.sh b/t/t3427-rebase-line-options.sh
index 5881162..9c9501a 100755
--- a/t/t3427-rebase-line-options.sh
+++ b/t/t3427-rebase-line-options.sh
@@ -6,10 +6,32 @@ test_description='git rebase -i with line options'
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+commit_message () {
+	git cat-file commit "$1" | sed '1,/^$/d'
+}
+
+commit_authorship () {
+	git cat-file commit "$1" | sed -n '/^$/q;/^author /p'
+}
+
+authorship () {
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE"
+}
+
+test_diff_file () {
+	if cmp "$1" "$2" >/dev/null
+	then
+		echo "'$1' and '$2' are the same"
+		return 1
+	fi
+}
+
 test_expect_success 'Set up repository' '
 	test_commit Initial &&
 	test_commit Commit1 &&
-	test_commit Commit2
+	test_commit Commit2 &&
+	git checkout -b branch Commit1 &&
+	test_commit Commit2_ Commit2.t
 '
 
 test_expect_success 'Unknown option' '
@@ -23,4 +45,172 @@ test_expect_success 'Unknown option' '
 	git rebase --continue
 '
 
+test_msg_author () {
+	set_fake_editor &&
+	FAKE_LINES="1 $1 2" git rebase -i HEAD~2 &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+}
+
+test_msg_author_misspelled () {
+	set_cat_todo_editor &&
+	test_must_fail git rebase -i HEAD^ >todo &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 $1-misspelled 2" git rebase -i HEAD~2 &&
+	set_fixed_todo_editor "$(pwd)"/todo &&
+	FAKE_LINES="$1 1" git rebase --edit-todo &&
+	git rebase --continue &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+}
+
+test_msg_author_conflicted () {
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="$1 1" git rebase -i master &&
+	git checkout --theirs Commit2.t &&
+	git add Commit2.t &&
+	git rebase --continue &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+}
+
+test_expect_success 'Misspelled pick --signoff' '
+	git checkout -b misspelled-pick--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author_misspelled pick_--signoff
+'
+
+test_expect_success 'Conflicted pick --signoff' '
+	git checkout -b conflicted-pick--signoff branch &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author_conflicted pick_--signoff
+'
+
+test_expect_success 'pick --signoff' '
+	git checkout -b pick--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author pick_--signoff
+'
+
+test_expect_success 'reword --signoff' '
+	git checkout -b reword--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author reword_--signoff
+'
+
+test_expect_success 'edit --signoff' '
+	git checkout -b edit--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	set_fake_editor &&
+	FAKE_LINES="1 edit_--signoff 2" git rebase -i HEAD~2 &&
+	git rebase --continue &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+'
+
+test_expect_success 'Misspelled pick --reset-author' '
+	git checkout -b misspelled-pick--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author_misspelled pick_--reset-author
+'
+
+test_expect_success 'Conflicted pick --reset-author' '
+	git checkout -b conflicted-pick--reset-author branch &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author_conflicted pick_--reset-author
+'
+
+test_expect_success 'pick --reset-author' '
+	git checkout -b pick--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author pick_--reset-author
+'
+
+test_expect_success 'pick --reset-author --signoff' '
+	git checkout -b pick--reset-author--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author pick_--reset-author_--signoff
+'
+
+test_expect_success 'reword --reset-author' '
+	git checkout -b reword--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author reword_--reset-author
+'
+
+test_expect_success 'edit --reset-author' '
+	git checkout -b edit--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	set_fake_editor &&
+	FAKE_LINES="1 edit_--reset-author 2" git rebase -i HEAD~2 &&
+	>Commit2.t &&
+	git add Commit2.t &&
+	test_tick &&
+	authorship >expected.author &&
+	git rebase --continue &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+'
+
 test_done
-- 
2.0.1
