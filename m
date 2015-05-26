From: Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 1/2] t750*: make tests for commit messages more pedantic
Date: Tue, 26 May 2015 08:15:07 +0200
Message-ID: <1432620908-16071-2-git-send-email-patryk.obara@gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 08:16:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx8AA-0006NG-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 08:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbEZGP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 02:15:58 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33902 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbEZGP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 02:15:57 -0400
Received: by wicmc15 with SMTP id mc15so54667079wic.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crAf1lX+TOhXnNtoG4TnxFsFZxLI+281OKt6eU3iIJ0=;
        b=XhUSGAHrHEcdLYDUgxqqBSH/y/ssmknGdtj8pcg39U1vUeR2ErXPt3ipebd14y3htN
         Ltx2qO1+MzvW7Roidx083vVM4F7pX0zeMVOM8CmHeqpDFJHRHJ/08Agzf7HlkL+5yWpo
         /y9mjkRXr1kHYC3LV4/x+RexmjFr+fbT3MMpmsVjsJaaRs3I76HqJWTazw/I/4qbwwpQ
         BrH7OotelBkM6x6pgF/swaIWrz7XwLhAK/206/j7GA59jeD2sBTO9BOum2IRW0yKL8yl
         4uhkWalvxH71fFIxRPMGBB7bS6qxwknZCNnb0LOw0rzr63JIw3dRXpL6HYoR1GjQfHKZ
         stqw==
X-Received: by 10.180.12.104 with SMTP id x8mr37927647wib.85.1432620915623;
        Mon, 25 May 2015 23:15:15 -0700 (PDT)
Received: from tars.localdomain ([188.121.16.104])
        by mx.google.com with ESMTPSA id js3sm20027090wjc.5.2015.05.25.23.15.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 23:15:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269932>

Currently messages are compared with --pretty=format:%s%b which does
not retain raw format of commit message. In result it's not clear what
part of expected commit msg is subject and what part is body. Also, it's
impossible to test if messages with multiple lines are handled
correctly, which may be significant when using nondefault --cleanup.

Change "commit_msg_is" function to use raw message format in log and
interpret escaped sequences in expected message. This way it's possible
to test exactly what commit message text was saved.

Add test to verify, that no additional content is appended to template
message, which uncovers tiny "bug" in --status handling - new line is
always appended before status message. If template file ended with
newline (which is default for many popular text editors, e.g. vim)
then blank line appears before status (which is very annoying when
template ends with line starting with '#'). On the other hand, this
newline needs to be appended if template file didn't end with newline
(which is default for e.g. emacs) - otherwise first line of status
message may be not cleaned up.

Add explicit test to verify if \n is kept unexpanded in commit message -
this used to be part of unrelated template test.

Modify add-content-and-comment fake editor to include both comments and
whitespace, so --cleanup=whitespace is now actually tested.

Modify expected value of test "cleanup commit messages" (t7502), which
shouldn't be passing, because template and logfiles are unnecessarily
stripped before placing them into editor.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 t/t7500-commit.sh               | 91 ++++++++++++++++++++++++++++++-----------
 t/t7500/add-content-and-comment |  4 ++
 t/t7502-commit.sh               | 29 +++++++------
 t/t7504-commit-msg-hook.sh      | 15 ++++---
 4 files changed, 97 insertions(+), 42 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 116885a..fd1bf71 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -13,8 +13,8 @@ commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
 
-	printf "%s" "$(git log --pretty=format:%s%b -1)" >"$actual" &&
-	printf "%s" "$1" >"$expect" &&
+	git log --pretty=format:%B -1 >"$actual" &&
+	printf "%b" "$1" >"$expect" &&
 	test_i18ncmp "$expect" "$actual"
 }
 
@@ -76,7 +76,7 @@ test_expect_success 'adding real content to a template should commit' '
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit --template "$TEMPLATE"
 	) &&
-	commit_msg_is "template linecommit message"
+	commit_msg_is "template line\ncommit message\n"
 '
 
 test_expect_success '-t option should be short for --template' '
@@ -87,7 +87,7 @@ test_expect_success '-t option should be short for --template' '
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit -t "$TEMPLATE"
 	) &&
-	commit_msg_is "short templatecommit message"
+	commit_msg_is "short template\ncommit message\n"
 '
 
 test_expect_success 'config-specified template should commit' '
@@ -99,7 +99,7 @@ test_expect_success 'config-specified template should commit' '
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit
 	) &&
-	commit_msg_is "new templatecommit message"
+	commit_msg_is "new template\ncommit message\n"
 '
 
 test_expect_success 'explicit commit message should override template' '
@@ -107,7 +107,7 @@ test_expect_success 'explicit commit message should override template' '
 	git add foo &&
 	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-content git commit --template "$TEMPLATE" \
 		-m "command line msg" &&
-	commit_msg_is "command line msg"
+	commit_msg_is "command line msg\n"
 '
 
 test_expect_success 'commit message from file should override template' '
@@ -118,7 +118,7 @@ test_expect_success 'commit message from file should override template' '
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit --template "$TEMPLATE" --file -
 	) &&
-	commit_msg_is "standard input msg"
+	commit_msg_is "standard input msg\n"
 '
 
 cat >"$TEMPLATE" <<\EOF
@@ -132,7 +132,7 @@ test_expect_success 'commit message from template with whitespace issue' '
 	git add foo &&
 	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-whitespaced-content git commit \
 		--template "$TEMPLATE" &&
-	commit_msg_is "commit message"
+	commit_msg_is "commit message\n"
 '
 
 test_expect_success 'using alternate GIT_INDEX_FILE (1)' '
@@ -187,7 +187,7 @@ test_expect_success 'commit message from file (1)' '
 		cd subdir &&
 		git commit --allow-empty -F log
 	) &&
-	commit_msg_is "Log in sub directory"
+	commit_msg_is "Log in sub directory\n"
 '
 
 test_expect_success 'commit message from file (2)' '
@@ -197,7 +197,7 @@ test_expect_success 'commit message from file (2)' '
 		cd subdir &&
 		git commit --allow-empty -F log
 	) &&
-	commit_msg_is "Log in sub directory"
+	commit_msg_is "Log in sub directory\n"
 '
 
 test_expect_success 'commit message from stdin' '
@@ -205,17 +205,17 @@ test_expect_success 'commit message from stdin' '
 		cd subdir &&
 		echo "Log with foo word" | git commit --allow-empty -F -
 	) &&
-	commit_msg_is "Log with foo word"
+	commit_msg_is "Log with foo word\n"
 '
 
 test_expect_success 'commit -F overrides -t' '
 	(
 		cd subdir &&
-		echo "-F log" > f.log &&
-		echo "-t template" > t.template &&
+		echo "log content" > f.log &&
+		echo "template content" > t.template &&
 		git commit --allow-empty -F f.log -t t.template
 	) &&
-	commit_msg_is "-F log"
+	commit_msg_is "log content\n"
 '
 
 test_expect_success 'Commit without message is allowed with --allow-empty-message' '
@@ -238,7 +238,7 @@ test_expect_success 'Commit a message with --allow-empty-message' '
 	echo "even more content" >>foo &&
 	git add foo &&
 	git commit --allow-empty-message -m"hello there" &&
-	commit_msg_is "hello there"
+	commit_msg_is "hello there\n"
 '
 
 test_expect_success 'commit -C empty respects --allow-empty-message' '
@@ -269,53 +269,53 @@ EOF
 test_expect_success 'commit --fixup provides correct one-line commit message' '
 	commit_for_rebase_autosquash_setup &&
 	git commit --fixup HEAD~1 &&
-	commit_msg_is "fixup! target message subject line"
+	commit_msg_is "fixup! target message subject line\n"
 '
 
 test_expect_success 'commit --squash works with -F' '
 	commit_for_rebase_autosquash_setup &&
 	echo "log message from file" >msgfile &&
 	git commit --squash HEAD~1 -F msgfile  &&
-	commit_msg_is "squash! target message subject linelog message from file"
+	commit_msg_is "squash! target message subject line\n\nlog message from file\n"
 '
 
 test_expect_success 'commit --squash works with -m' '
 	commit_for_rebase_autosquash_setup &&
-	git commit --squash HEAD~1 -m "foo bar\nbaz" &&
-	commit_msg_is "squash! target message subject linefoo bar\nbaz"
+	git commit --squash HEAD~1 -m "foo bar baz" &&
+	commit_msg_is "squash! target message subject line\n\nfoo bar baz\n"
 '
 
 test_expect_success 'commit --squash works with -C' '
 	commit_for_rebase_autosquash_setup &&
 	git commit --squash HEAD~1 -C HEAD &&
-	commit_msg_is "squash! target message subject lineintermediate commit"
+	commit_msg_is "squash! target message subject line\n\nintermediate commit\n"
 '
 
 test_expect_success 'commit --squash works with -c' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
 	git commit --squash HEAD~1 -c HEAD &&
-	commit_msg_is "squash! target message subject lineedited commit"
+	commit_msg_is "squash! target message subject line\n\nedited commit\n"
 '
 
 test_expect_success 'commit --squash works with -C for same commit' '
 	commit_for_rebase_autosquash_setup &&
 	git commit --squash HEAD -C HEAD &&
-	commit_msg_is "squash! intermediate commit"
+	commit_msg_is "squash! intermediate commit\n"
 '
 
 test_expect_success 'commit --squash works with -c for same commit' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
 	git commit --squash HEAD -c HEAD &&
-	commit_msg_is "squash! edited commit"
+	commit_msg_is "squash! edited commit\n"
 '
 
 test_expect_success 'commit --squash works with editor' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 	git commit --squash HEAD~1 &&
-	commit_msg_is "squash! target message subject linecommit message"
+	commit_msg_is "squash! target message subject line\n\ncommit message\n"
 '
 
 test_expect_success 'invalid message options when using --fixup' '
@@ -329,4 +329,47 @@ test_expect_success 'invalid message options when using --fixup' '
 	test_must_fail git commit --fixup HEAD~1 -F log
 '
 
+test_expect_success 'no blank lines appended after template with --status' '
+	echo "template line" > "$TEMPLATE" &&
+	echo changes >>foo &&
+	git add foo &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+	git commit -e -t "$TEMPLATE" --status &&
+	commit_msg_is "template line\ncommit message\n"
+'
+
+test_expect_success 'template without newline before eof should work with --status' '
+	printf "%s" "template line" > "$TEMPLATE" &&
+	echo changes >>foo &&
+	git add foo &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+	git commit -e -t "$TEMPLATE" --status &&
+	commit_msg_is "template line\ncommit message\n"
+'
+
+test_expect_success 'no blank lines appended after -F text with --status' '
+	echo "log line" >log-file &&
+	echo changes >>foo &&
+	git add foo &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+	git commit -e -F log-file --status &&
+	commit_msg_is "log line\ncommit message\n"
+'
+
+test_expect_success 'logfile without newline before eof should work with --status' '
+	printf "%s" "log line" >log-file &&
+	echo changes >>foo &&
+	git add foo &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+	git commit -e -F log-file --status &&
+	commit_msg_is "log line\ncommit message\n"
+'
+
+test_expect_success 'commit does not expand \n in message' '
+	echo changes >>foo &&
+	git add foo &&
+	git commit -m "foo\nbar" &&
+	commit_msg_is "foo\\\\nbar\n"
+'
+
 test_done
diff --git a/t/t7500/add-content-and-comment b/t/t7500/add-content-and-comment
index c4dccff..2a1fc22 100755
--- a/t/t7500/add-content-and-comment
+++ b/t/t7500/add-content-and-comment
@@ -1,5 +1,9 @@
 #!/bin/sh
 echo "commit message" >> "$1"
+# add multiple newlines to verify if --cleanup=whitespace will remove them
+echo >> "$1"
+echo >> "$1"
+echo >> "$1"
 echo "# comment" >> "$1"
 exit 0
 
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 051489e..d2203ed 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -8,11 +8,12 @@ commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
 
-	printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
-	printf "%s" "$1" >$expect &&
-	test_i18ncmp $expect $actual
+	git log --pretty=format:%B -1 >"$actual" &&
+	printf "%b" "$1" >"$expect" &&
+	test_i18ncmp "$expect" "$actual"
 }
 
+
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
@@ -255,15 +256,17 @@ test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
 	git commit -e -F text -a &&
-	head -n 4 .git/COMMIT_EDITMSG >actual
+	head -n 5 .git/COMMIT_EDITMSG >actual &&
+	commit_msg_is "sample\n"
 '
 
-echo "sample
+echo "
+sample
 
 # Please enter the commit message for your changes. Lines starting
 # with '#' will be ignored, and an empty message aborts the commit." >expect
 
-test_expect_success 'cleanup commit messages (strip option,-F,-e): output' '
+test_expect_success 'editor view before cleanup commit messages (strip option,-F,-e)' '
 	test_i18ncmp expect actual
 '
 
@@ -282,7 +285,7 @@ test_expect_success 'cleanup commit message (no config and no option uses defaul
 	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
 	  git commit --no-status
 	) &&
-	commit_msg_is "commit message"
+	commit_msg_is "commit message\n"
 '
 
 test_expect_success 'cleanup commit message (option overrides default)' '
@@ -292,7 +295,7 @@ test_expect_success 'cleanup commit message (option overrides default)' '
 	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
 	  git commit --cleanup=whitespace --no-status
 	) &&
-	commit_msg_is "commit message # comment"
+	commit_msg_is "commit message\n\n# comment\n"
 '
 
 test_expect_success 'cleanup commit message (config overrides default)' '
@@ -302,7 +305,7 @@ test_expect_success 'cleanup commit message (config overrides default)' '
 	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
 	  git -c commit.cleanup=whitespace commit --no-status
 	) &&
-	commit_msg_is "commit message # comment"
+	commit_msg_is "commit message\n\n# comment\n"
 '
 
 test_expect_success 'cleanup commit message (option overrides config)' '
@@ -312,28 +315,28 @@ test_expect_success 'cleanup commit message (option overrides config)' '
 	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
 	  git -c commit.cleanup=whitespace commit --cleanup=default
 	) &&
-	commit_msg_is "commit message"
+	commit_msg_is "commit message\n"
 '
 
 test_expect_success 'cleanup commit message (default, -m)' '
 	echo content >>file &&
 	git add file &&
 	git commit -m "message #comment " &&
-	commit_msg_is "message #comment"
+	commit_msg_is "message #comment\n"
 '
 
 test_expect_success 'cleanup commit message (whitespace option, -m)' '
 	echo content >>file &&
 	git add file &&
 	git commit --cleanup=whitespace --no-status -m "message #comment " &&
-	commit_msg_is "message #comment"
+	commit_msg_is "message #comment\n"
 '
 
 test_expect_success 'cleanup commit message (whitespace config, -m)' '
 	echo content >>file &&
 	git add file &&
 	git -c commit.cleanup=whitespace commit --no-status -m "message #comment " &&
-	commit_msg_is "message #comment"
+	commit_msg_is "message #comment\n"
 '
 
 test_expect_success 'message shows author when it is not equal to committer' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 1f53ea8..2c03a86 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -179,7 +179,12 @@ EOF
 chmod +x "$HOOK"
 
 commit_msg_is () {
-	test "`git log --pretty=format:%s%b -1`" = "$1"
+	expect=commit_msg_is.expect
+	actual=commit_msg_is.actual
+
+	git log --pretty=format:%B -1 >"$actual" &&
+	printf "%b" "$1" >"$expect" &&
+	test_i18ncmp "$expect" "$actual"
 }
 
 test_expect_success 'hook edits commit message' '
@@ -187,7 +192,7 @@ test_expect_success 'hook edits commit message' '
 	echo "additional" >> file &&
 	git add file &&
 	git commit -m "additional" &&
-	commit_msg_is "new message"
+	commit_msg_is "new message\n"
 
 '
 
@@ -197,7 +202,7 @@ test_expect_success 'hook edits commit message (editor)' '
 	git add file &&
 	echo "additional content" > FAKE_MSG &&
 	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
-	commit_msg_is "new message"
+	commit_msg_is "new message\n"
 
 '
 
@@ -206,7 +211,7 @@ test_expect_success "hook doesn't edit commit message" '
 	echo "plus" >> file &&
 	git add file &&
 	git commit --no-verify -m "plus" &&
-	commit_msg_is "plus"
+	commit_msg_is "plus\n"
 
 '
 
@@ -216,7 +221,7 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 	git add file &&
 	echo "more plus" > FAKE_MSG &&
 	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify &&
-	commit_msg_is "more plus"
+	commit_msg_is "more plus\n"
 
 '
 
-- 
2.4.1
