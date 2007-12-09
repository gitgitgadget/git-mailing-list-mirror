From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Interactive editor tests for commit-msg hook
Date: Sun,  9 Dec 2007 13:52:11 +0100
Message-ID: <1197204731-19553-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, krh@redhat.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 13:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Lea-000332-Sl
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 13:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXLIMwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 07:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbXLIMwm
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 07:52:42 -0500
Received: from wincent.com ([72.3.236.74]:36460 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXLIMwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 07:52:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB9CqD6X030302;
	Sun, 9 Dec 2007 06:52:14 -0600
X-Mailer: git-send-email 1.5.3.7.1116.gf11de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67621>

Supplement the existing tests for the commit-msg hook (which all use
"git commit -m") with tests which use an interactive editor (no -m
switch) to ensure that all code paths get tested.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

I didn't add similar tests for the pre-commit hook because I don't
think that's an interesting code path; we don't care about the commit
message in that case, only whether the commit is allowed to proceed or
not.

 t/t7504-commit-msg-hook.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 17aad7c..e154bab 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -9,11 +9,33 @@ test_expect_success "with no hook" \
 	 git add file &&
 	 git commit -m 'first'"
 
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
+test_expect_success "with no hook (editor)" \
+	"echo 'more foo' >> file &&
+	 git add file &&
+	 echo 'more foo' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit"
+
 test_expect_success "--no-verify with no hook" \
 	"echo 'bar' > file &&
 	 git add file &&
 	 git commit --no-verify -m 'bar'"
 
+test_expect_success "--no-verify with no hook (editor)" \
+	"echo 'more bar' > file &&
+	 git add file &&
+	 echo 'more bar' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify"
+
 # now install hook that always succeeds
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/commit-msg"
@@ -29,11 +51,23 @@ test_expect_success "with succeeding hook" \
 	 git add file &&
 	 git commit -m 'more'"
 
+test_expect_success "with succeeding hook (editor)" \
+	"echo 'more more' >> file &&
+	 git add file &&
+	 echo 'more more' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit"
+
 test_expect_success "--no-verify with succeeding hook" \
 	"echo 'even more' >> file &&
 	 git add file &&
 	 git commit --no-verify -m 'even more'"
 
+test_expect_success "--no-verify with succeeding hook (editor)" \
+	"echo 'even more more' >> file &&
+	 git add file &&
+	 echo 'even more more' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify"
+
 # now a hook that fails
 cat > "$HOOK" <<EOF
 #!/bin/sh
@@ -45,22 +79,46 @@ test_expect_failure "with failing hook" \
 	 git add file &&
 	 git commit -m 'another'"
 
+test_expect_failure "with failing hook (editor)" \
+	"echo 'more another' >> file &&
+	 git add file &&
+	 echo 'more another' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit"
+
 test_expect_success "--no-verify with failing hook" \
 	"echo 'stuff' >> file &&
 	 git add file &&
 	 git commit --no-verify -m 'stuff'"
 
+test_expect_success "--no-verify with failing hook (editor)" \
+	"echo 'more stuff' >> file &&
+	 git add file &&
+	 echo 'more stuff' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify"
+
 chmod -x "$HOOK"
 test_expect_success "with non-executable hook" \
 	"echo 'content' >> file &&
 	 git add file &&
 	 git commit -m 'content'"
 
+test_expect_success "with non-executable hook (editor)" \
+	"echo 'content again' >> file &&
+	 git add file &&
+	 echo 'content again' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit -m 'content again'"
+
 test_expect_success "--no-verify with non-executable hook" \
 	"echo 'more content' >> file &&
 	 git add file &&
 	 git commit --no-verify -m 'more content'"
 
+test_expect_success "--no-verify with non-executable hook (editor)" \
+	"echo 'even more content' >> file &&
+	 git add file &&
+	 echo 'even more content' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify"
+
 # now a hook that edits the commit message
 cat > "$HOOK" <<'EOF'
 #!/bin/sh
@@ -79,10 +137,24 @@ test_expect_success "hook edits commit message" \
 	 git commit -m 'additional' &&
 	 commit_msg_is 'new message'"
 
+test_expect_success "hook edits commit message (editor)" \
+	"echo 'additional content' >> file &&
+	 git add file &&
+	 echo 'additional content' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	 commit_msg_is 'new message'"
+
 test_expect_success "hook doesn't edit commit message" \
 	"echo 'plus' >> file &&
 	 git add file &&
 	 git commit --no-verify -m 'plus' &&
 	 commit_msg_is 'plus'"
 
+test_expect_success "hook doesn't edit commit message (editor)" \
+	"echo 'more plus' >> file &&
+	 git add file &&
+	 echo 'more plus' > FAKE_MSG &&
+	 GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify &&
+	 commit_msg_is 'more plus'"
+
 test_done
-- 
1.5.3.7.1116.gf11de
