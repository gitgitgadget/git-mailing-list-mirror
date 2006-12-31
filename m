From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Add test case for update hooks in receive-pack.
Date: Sun, 31 Dec 2006 02:20:23 -0500
Message-ID: <20061231072023.GA6479@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 08:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0uzp-0001Fh-US
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 08:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088AbWLaHUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 02:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933089AbWLaHU3
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 02:20:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47129 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933088AbWLaHU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 02:20:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0uzm-00081z-9g; Sun, 31 Dec 2006 02:20:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D156620FB65; Sun, 31 Dec 2006 02:20:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35685>

Verify that the update hooks work as documented/advertised.  This is
a simple set of tests to check that the update hooks run with the
parameters expected, have their STDOUT and STDERR redirected to
the client side of the connection, and that their STDIN does not
contain any data (as its actually /dev/null).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 On top of my previous series of patches for receive-pack.  This test
 fails unless those patches are applied.  ;-)

 t/t5401-update-hooks.sh |   77 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
new file mode 100755
index 0000000..8a879f7
--- /dev/null
+++ b/t/t5401-update-hooks.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Shawn O. Pearce
+#
+
+test_description='Test the update hook infrastructure.'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo This is a test. >a &&
+	git-update-index --add a &&
+	tree0=$(git-write-tree) &&
+	commit0=$(echo setup | git-commit-tree $tree0) &&
+	git-update-ref HEAD $commit0 &&
+	git-clone ./. victim &&
+	echo We hope it works. >a &&
+	git-update-index a &&
+	tree1=$(git-write-tree) &&
+	commit1=$(echo modify | git-commit-tree $tree1 -p $commit0) &&
+	git-update-ref HEAD $commit1
+	'
+
+cat >victim/.git/hooks/update <<'EOF'
+#!/bin/sh
+echo "$@" >$GIT_DIR/update.args
+read x; echo -n "$x" >$GIT_DIR/update.stdin
+echo STDOUT update
+echo STDERR update >&2
+EOF
+chmod u+x victim/.git/hooks/update
+
+cat >victim/.git/hooks/post-update <<'EOF'
+#!/bin/sh
+echo "$@" >$GIT_DIR/post-update.args
+read x; echo -n "$x" >$GIT_DIR/post-update.stdin
+echo STDOUT post-update
+echo STDERR post-update >&2
+EOF
+chmod u+x victim/.git/hooks/post-update
+
+test_expect_success push '
+	git-send-pack ./victim/.git/ master >send.out 2>send.err
+	'
+test_expect_success 'hooks ran' '
+	test -f victim/.git/update.args &&
+	test -f victim/.git/update.stdin &&
+	test -f victim/.git/post-update.args &&
+	test -f victim/.git/post-update.stdin
+	'
+
+test_expect_success 'update hook arguments' '
+	echo refs/heads/master $commit0 $commit1 \
+	 | diff -u - victim/.git/update.args
+	'
+test_expect_success 'post-update hook arguments' '
+	echo refs/heads/master \
+	 | diff -u - victim/.git/post-update.args
+	'
+
+test_expect_failure 'update hook stdin is /dev/null' '
+	test -s victim/.git/update.stdin
+	'
+test_expect_failure 'post-update hook stdin is /dev/null' '
+	test -s victim/.git/post-update.stdin
+	'
+
+test_expect_failure 'send-pack produced no output' '
+	test -s send.out
+	'
+test_expect_success 'send-pack stderr contains hook messages' '
+	grep "STDOUT update" send.err &&
+	grep "STDERR update" send.err &&
+	grep "STDOUT post-update" send.err &&
+	grep "STDERR post-update" send.err
+	'
+
+test_done
-- 
1.5.0.rc0.g7200
