From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/6] t5401: Use a bare repository for the remote peer
Date: Tue,  9 Feb 2010 18:01:29 -0800
Message-ID: <1265767290-25863-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 03:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf1tc-0007Ab-N4
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 03:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab0BJCBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 21:01:33 -0500
Received: from george.spearce.org ([209.20.77.23]:56824 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab0BJCBc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 21:01:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9ADB7381F2
	for <git@vger.kernel.org>; Wed, 10 Feb 2010 02:01:31 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc2.170.gbc565
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139471>

We want to avoid the warnings (or later, test failures) about
updating the current branch.  It was never my intention to have
this test deal with a repository with a working directory, and it
is a very old bug that the test even used a non-bare repository
for the remote side of the push operations.

This fixes the interleaved output error we were seeing as a test
failure by avoiding the giant warning message we were getting back
about updating the current branch being risky.

Its not a real fix, but is something we should do no matter what,
because the behavior will change in the future to reject, and the
test would break at that time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 t/t5401-update-hooks.sh |   58 +++++++++++++++++++++++-----------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index c3cf397..7240fab 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -17,22 +17,22 @@ test_expect_success setup '
 	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
 	git update-ref refs/heads/master $commit0 &&
 	git update-ref refs/heads/tofail $commit1 &&
-	git clone ./. victim &&
-	GIT_DIR=victim/.git git update-ref refs/heads/tofail $commit1 &&
+	git clone --bare ./. victim.git &&
+	GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/master $commit1 &&
 	git update-ref refs/heads/tofail $commit0
 '
 
-cat >victim/.git/hooks/pre-receive <<'EOF'
+cat >victim.git/hooks/pre-receive <<'EOF'
 #!/bin/sh
 printf %s "$@" >>$GIT_DIR/pre-receive.args
 cat - >$GIT_DIR/pre-receive.stdin
 echo STDOUT pre-receive
 echo STDERR pre-receive >&2
 EOF
-chmod u+x victim/.git/hooks/pre-receive
+chmod u+x victim.git/hooks/pre-receive
 
-cat >victim/.git/hooks/update <<'EOF'
+cat >victim.git/hooks/update <<'EOF'
 #!/bin/sh
 echo "$@" >>$GIT_DIR/update.args
 read x; printf %s "$x" >$GIT_DIR/update.stdin
@@ -40,77 +40,77 @@ echo STDOUT update $1
 echo STDERR update $1 >&2
 test "$1" = refs/heads/master || exit
 EOF
-chmod u+x victim/.git/hooks/update
+chmod u+x victim.git/hooks/update
 
-cat >victim/.git/hooks/post-receive <<'EOF'
+cat >victim.git/hooks/post-receive <<'EOF'
 #!/bin/sh
 printf %s "$@" >>$GIT_DIR/post-receive.args
 cat - >$GIT_DIR/post-receive.stdin
 echo STDOUT post-receive
 echo STDERR post-receive >&2
 EOF
-chmod u+x victim/.git/hooks/post-receive
+chmod u+x victim.git/hooks/post-receive
 
-cat >victim/.git/hooks/post-update <<'EOF'
+cat >victim.git/hooks/post-update <<'EOF'
 #!/bin/sh
 echo "$@" >>$GIT_DIR/post-update.args
 read x; printf %s "$x" >$GIT_DIR/post-update.stdin
 echo STDOUT post-update
 echo STDERR post-update >&2
 EOF
-chmod u+x victim/.git/hooks/post-update
+chmod u+x victim.git/hooks/post-update
 
 test_expect_success push '
-	test_must_fail git send-pack --force ./victim/.git \
+	test_must_fail git send-pack --force ./victim.git \
 		master tofail >send.out 2>send.err
 '
 
 test_expect_success 'updated as expected' '
-	test $(GIT_DIR=victim/.git git rev-parse master) = $commit1 &&
-	test $(GIT_DIR=victim/.git git rev-parse tofail) = $commit1
+	test $(GIT_DIR=victim.git git rev-parse master) = $commit1 &&
+	test $(GIT_DIR=victim.git git rev-parse tofail) = $commit1
 '
 
 test_expect_success 'hooks ran' '
-	test -f victim/.git/pre-receive.args &&
-	test -f victim/.git/pre-receive.stdin &&
-	test -f victim/.git/update.args &&
-	test -f victim/.git/update.stdin &&
-	test -f victim/.git/post-receive.args &&
-	test -f victim/.git/post-receive.stdin &&
-	test -f victim/.git/post-update.args &&
-	test -f victim/.git/post-update.stdin
+	test -f victim.git/pre-receive.args &&
+	test -f victim.git/pre-receive.stdin &&
+	test -f victim.git/update.args &&
+	test -f victim.git/update.stdin &&
+	test -f victim.git/post-receive.args &&
+	test -f victim.git/post-receive.stdin &&
+	test -f victim.git/post-update.args &&
+	test -f victim.git/post-update.stdin
 '
 
 test_expect_success 'pre-receive hook input' '
 	(echo $commit0 $commit1 refs/heads/master;
 	 echo $commit1 $commit0 refs/heads/tofail
-	) | test_cmp - victim/.git/pre-receive.stdin
+	) | test_cmp - victim.git/pre-receive.stdin
 '
 
 test_expect_success 'update hook arguments' '
 	(echo refs/heads/master $commit0 $commit1;
 	 echo refs/heads/tofail $commit1 $commit0
-	) | test_cmp - victim/.git/update.args
+	) | test_cmp - victim.git/update.args
 '
 
 test_expect_success 'post-receive hook input' '
 	echo $commit0 $commit1 refs/heads/master |
-	test_cmp - victim/.git/post-receive.stdin
+	test_cmp - victim.git/post-receive.stdin
 '
 
 test_expect_success 'post-update hook arguments' '
 	echo refs/heads/master |
-	test_cmp - victim/.git/post-update.args
+	test_cmp - victim.git/post-update.args
 '
 
 test_expect_success 'all hook stdin is /dev/null' '
-	! test -s victim/.git/update.stdin &&
-	! test -s victim/.git/post-update.stdin
+	! test -s victim.git/update.stdin &&
+	! test -s victim.git/post-update.stdin
 '
 
 test_expect_success 'all *-receive hook args are empty' '
-	! test -s victim/.git/pre-receive.args &&
-	! test -s victim/.git/post-receive.args
+	! test -s victim.git/pre-receive.args &&
+	! test -s victim.git/post-receive.args
 '
 
 test_expect_success 'send-pack produced no output' '
-- 
1.7.0.rc2.170.gbc565
