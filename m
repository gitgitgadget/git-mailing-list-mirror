From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 7/7] Interactive editor tests for commit-msg hook
Date: Mon, 10 Dec 2007 08:33:26 +0100
Message-ID: <1197272006-5364-1-git-send-email-win@wincent.com>
References: <7vwsrnmczu.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, krh@redhat.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 08:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1d9r-0005Ka-Fn
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 08:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXLJHeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 02:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXLJHeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 02:34:09 -0500
Received: from wincent.com ([72.3.236.74]:38298 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbXLJHeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 02:34:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBA7XSLX019436;
	Mon, 10 Dec 2007 01:33:29 -0600
X-Mailer: git-send-email 1.5.3.7.1116.gf11de
In-Reply-To: <7vwsrnmczu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67689>

Supplement the existing tests for the commit-msg hook (which all use
"git commit -m") with tests which use an interactive editor (no -m
switch) to ensure that all code paths get tested.

At the same time the quoting of some of the existing tests is changed
to conform to Junio's recommendations for test style (single quotes
used around the test unless there is a compelling reason not to, and
the opening quote on the same line as the test_expect and the closing
quote in column 1).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t7504-commit-msg-hook.sh |  218 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 175 insertions(+), 43 deletions(-)

diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 17aad7c..751b113 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -4,15 +4,49 @@ test_description='commit-msg hook'
 
 . ./test-lib.sh
 
-test_expect_success "with no hook" \
-	"echo 'foo' > file &&
-	 git add file &&
-	 git commit -m 'first'"
+test_expect_success 'with no hook' '
 
-test_expect_success "--no-verify with no hook" \
-	"echo 'bar' > file &&
-	 git add file &&
-	 git commit --no-verify -m 'bar'"
+	echo "foo" > file &&
+	git add file &&
+	git commit -m "first"
+
+'
+
+# set up fake editor for interactive editing
+cat > fake-editor <<'EOF'
+#!/bin/sh
+cp FAKE_MSG "$1"
+exit 0
+EOF
+chmod +x fake-editor
+FAKE_EDITOR="$(pwd)/fake-editor"
+export FAKE_EDITOR
+
+test_expect_success 'with no hook (editor)' '
+
+	echo "more foo" >> file &&
+	git add file &&
+	echo "more foo" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit
+
+'
+
+test_expect_success '--no-verify with no hook' '
+
+	echo "bar" > file &&
+	git add file &&
+	git commit --no-verify -m "bar"
+
+'
+
+test_expect_success '--no-verify with no hook (editor)' '
+
+	echo "more bar" > file &&
+	git add file &&
+	echo "more bar" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+
+'
 
 # now install hook that always succeeds
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
@@ -24,15 +58,39 @@ exit 0
 EOF
 chmod +x "$HOOK"
 
-test_expect_success "with succeeding hook" \
-	"echo 'more' >> file &&
-	 git add file &&
-	 git commit -m 'more'"
+test_expect_success 'with succeeding hook' '
 
-test_expect_success "--no-verify with succeeding hook" \
-	"echo 'even more' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'even more'"
+	echo "more" >> file &&
+	git add file &&
+	git commit -m "more"
+
+'
+
+test_expect_success 'with succeeding hook (editor)' '
+
+	echo "more more" >> file &&
+	git add file &&
+	echo "more more" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit
+
+'
+
+test_expect_success '--no-verify with succeeding hook' '
+
+	echo "even more" >> file &&
+	git add file &&
+	git commit --no-verify -m "even more"
+
+'
+
+test_expect_success '--no-verify with succeeding hook (editor)' '
+
+	echo "even more more" >> file &&
+	git add file &&
+	echo "even more more" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+
+'
 
 # now a hook that fails
 cat > "$HOOK" <<EOF
@@ -40,26 +98,74 @@ cat > "$HOOK" <<EOF
 exit 1
 EOF
 
-test_expect_failure "with failing hook" \
-	"echo 'another' >> file &&
-	 git add file &&
-	 git commit -m 'another'"
+test_expect_failure 'with failing hook' '
+
+	echo "another" >> file &&
+	git add file &&
+	git commit -m "another"
+
+'
+
+test_expect_failure 'with failing hook (editor)' '
+
+	echo "more another" >> file &&
+	git add file &&
+	echo "more another" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit
 
-test_expect_success "--no-verify with failing hook" \
-	"echo 'stuff' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'stuff'"
+'
+
+test_expect_success '--no-verify with failing hook' '
+
+	echo "stuff" >> file &&
+	git add file &&
+	git commit --no-verify -m "stuff"
+
+'
+
+test_expect_success '--no-verify with failing hook (editor)' '
+
+	echo "more stuff" >> file &&
+	git add file &&
+	echo "more stuff" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+
+'
 
 chmod -x "$HOOK"
-test_expect_success "with non-executable hook" \
-	"echo 'content' >> file &&
-	 git add file &&
-	 git commit -m 'content'"
+test_expect_success 'with non-executable hook' '
+
+	echo "content" >> file &&
+	git add file &&
+	git commit -m "content"
+
+'
+
+test_expect_success 'with non-executable hook (editor)' '
+
+	echo "content again" >> file &&
+	git add file &&
+	echo "content again" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit -m "content again"
+
+'
+
+test_expect_success '--no-verify with non-executable hook' '
+
+	echo "more content" >> file &&
+	git add file &&
+	git commit --no-verify -m "more content"
+
+'
 
-test_expect_success "--no-verify with non-executable hook" \
-	"echo 'more content' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'more content'"
+test_expect_success '--no-verify with non-executable hook (editor)' '
+
+	echo "even more content" >> file &&
+	git add file &&
+	echo "even more content" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+
+'
 
 # now a hook that edits the commit message
 cat > "$HOOK" <<'EOF'
@@ -73,16 +179,42 @@ commit_msg_is () {
 	test "`git log --pretty=format:%s%b -1`" = "$1"
 }
 
-test_expect_success "hook edits commit message" \
-	"echo 'additional' >> file &&
-	 git add file &&
-	 git commit -m 'additional' &&
-	 commit_msg_is 'new message'"
-
-test_expect_success "hook doesn't edit commit message" \
-	"echo 'plus' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'plus' &&
-	 commit_msg_is 'plus'"
+test_expect_success 'hook edits commit message' '
+
+	echo "additional" >> file &&
+	git add file &&
+	git commit -m "additional" &&
+	commit_msg_is "new message"
+
+'
+
+test_expect_success 'hook edits commit message (editor)' '
+
+	echo "additional content" >> file &&
+	git add file &&
+	echo "additional content" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	commit_msg_is "new message"
+
+'
+
+test_expect_success "hook doesn't edit commit message" '
+
+	echo "plus" >> file &&
+	git add file &&
+	git commit --no-verify -m "plus" &&
+	commit_msg_is "plus"
+
+'
+
+test_expect_success "hook doesn't edit commit message (editor)" '
+
+	echo "more plus" >> file &&
+	git add file &&
+	echo "more plus" > FAKE_MSG &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify &&
+	commit_msg_is "more plus"
+
+'
 
 test_done
-- 
1.5.3.7.1116.gf11de
