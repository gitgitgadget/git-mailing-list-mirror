From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 4/4] Add tests for pre-commit and commit-msg hooks
Date: Sat,  8 Dec 2007 13:29:47 +0100
Message-ID: <1197116987-21802-1-git-send-email-win@wincent.com>
References: <1197113889-16243-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, krh@redhat.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 13:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ypf-0007BL-Ik
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 13:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbXLHMaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 07:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbXLHMaV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 07:30:21 -0500
Received: from wincent.com ([72.3.236.74]:34338 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbXLHMaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 07:30:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB8CTnxd022630;
	Sat, 8 Dec 2007 06:29:50 -0600
X-Mailer: git-send-email 1.5.3.7.1115.g3d1c
In-Reply-To: <1197113889-16243-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67551>

As desired, these pass for git-commit.sh, fail for builtin-commit (prior
to the fixes), and succeeded for builtin-commit (after the fixes).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t7501-commit.sh          |    2 +-
 t/t7503-pre-commit-hook.sh |   64 ++++++++++++++++++++++++++++++++
 t/t7504-commit-msg-hook.sh |   88 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 1 deletions(-)
 create mode 100755 t/t7503-pre-commit-hook.sh
 create mode 100755 t/t7504-commit-msg-hook.sh

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 19c4b2c..05aa97d 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -4,7 +4,7 @@
 #
 
 # FIXME: Test the various index usages, -i and -o, test reflog,
-# signoff, hooks
+# signoff
 
 test_description='git-commit'
 . ./test-lib.sh
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
new file mode 100755
index 0000000..c8097a7
--- /dev/null
+++ b/t/t7503-pre-commit-hook.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='pre-commit hook'
+
+. ./test-lib.sh
+
+test_expect_success "with no hook" \
+	"echo 'foo' > file &&
+	 git add file &&
+	 git commit -m 'first'"
+
+test_expect_success "--no-verify with no hook" \
+	"echo 'bar' > file &&
+	 git add file &&
+	 git commit --no-verify -m 'bar'"
+
+# now install hook that always succeeds
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+HOOK="$HOOKDIR/pre-commit"
+mkdir -p "$HOOKDIR"
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 0
+EOF
+chmod +x "$HOOK"
+
+test_expect_success "with succeeding hook" \
+	"echo 'more' >> file &&
+	 git add file &&
+	 git commit -m 'more'"
+
+test_expect_success "--no-verify with succeeding hook" \
+	"echo 'even more' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'even more'"
+
+# now a hook that fails
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 1
+EOF
+
+test_expect_failure "with failing hook" \
+	"echo 'another' >> file &&
+	 git add file &&
+	 git commit -m 'another'"
+
+test_expect_success "--no-verify with failing hook" \
+	"echo 'stuff' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'stuff'"
+
+chmod -x "$HOOK"
+test_expect_success "with non-executable hook" \
+	"echo 'content' >> file &&
+	 git add file &&
+	 git commit -m 'content'"
+
+test_expect_success "--no-verify with non-executable hook" \
+	"echo 'more content' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'more content'"
+
+test_done
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
new file mode 100755
index 0000000..17aad7c
--- /dev/null
+++ b/t/t7504-commit-msg-hook.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='commit-msg hook'
+
+. ./test-lib.sh
+
+test_expect_success "with no hook" \
+	"echo 'foo' > file &&
+	 git add file &&
+	 git commit -m 'first'"
+
+test_expect_success "--no-verify with no hook" \
+	"echo 'bar' > file &&
+	 git add file &&
+	 git commit --no-verify -m 'bar'"
+
+# now install hook that always succeeds
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+HOOK="$HOOKDIR/commit-msg"
+mkdir -p "$HOOKDIR"
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 0
+EOF
+chmod +x "$HOOK"
+
+test_expect_success "with succeeding hook" \
+	"echo 'more' >> file &&
+	 git add file &&
+	 git commit -m 'more'"
+
+test_expect_success "--no-verify with succeeding hook" \
+	"echo 'even more' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'even more'"
+
+# now a hook that fails
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 1
+EOF
+
+test_expect_failure "with failing hook" \
+	"echo 'another' >> file &&
+	 git add file &&
+	 git commit -m 'another'"
+
+test_expect_success "--no-verify with failing hook" \
+	"echo 'stuff' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'stuff'"
+
+chmod -x "$HOOK"
+test_expect_success "with non-executable hook" \
+	"echo 'content' >> file &&
+	 git add file &&
+	 git commit -m 'content'"
+
+test_expect_success "--no-verify with non-executable hook" \
+	"echo 'more content' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'more content'"
+
+# now a hook that edits the commit message
+cat > "$HOOK" <<'EOF'
+#!/bin/sh
+echo "new message" > "$1"
+exit 0
+EOF
+chmod +x "$HOOK"
+
+commit_msg_is () {
+	test "`git log --pretty=format:%s%b -1`" = "$1"
+}
+
+test_expect_success "hook edits commit message" \
+	"echo 'additional' >> file &&
+	 git add file &&
+	 git commit -m 'additional' &&
+	 commit_msg_is 'new message'"
+
+test_expect_success "hook doesn't edit commit message" \
+	"echo 'plus' >> file &&
+	 git add file &&
+	 git commit --no-verify -m 'plus' &&
+	 commit_msg_is 'plus'"
+
+test_done
-- 
1.5.3.7.1115.g3d1c
