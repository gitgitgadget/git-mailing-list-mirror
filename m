From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add a new test for git-merge-resolve
Date: Sun, 13 Jul 2008 00:33:35 +0200
Message-ID: <1215902015-5102-1-git-send-email-vmiklos@frugalware.org>
References: <1215888130-3260-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 00:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHnfX-0001HE-DK
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 00:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYGLWdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYGLWdU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 18:33:20 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52289 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYGLWdU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 18:33:20 -0400
Received: from vmobile.example.net (dsl5401CADA.pool.t-online.hu [84.1.202.218])
	by yugo.frugalware.org (Postfix) with ESMTP id 827F31DDC5B;
	Sun, 13 Jul 2008 00:33:17 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 230431A9833; Sun, 13 Jul 2008 00:33:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <1215888130-3260-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88271>

Actually this is a simple test, just to ensure merge-resolve properly
calls read-tree. read-tree itself already has more complex tests.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

This one adds tests in a new file; it tests merge-resolve as well, just
as my previous patch, but I though it's better if I just add the
multiple-base merge one to the end of the existing criss-cross tests.

So this is not a replacement, both are sent for inclusion.

 t/t7605-merge-resolve.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 t/t7605-merge-resolve.sh

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
new file mode 100755
index 0000000..ee21a10
--- /dev/null
+++ b/t/t7605-merge-resolve.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing the resolve strategy.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 > c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	echo c2 > c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2 &&
+	git reset --hard c0 &&
+	echo c3 > c2.c &&
+	git add c2.c &&
+	git commit -m c3 &&
+	git tag c3
+'
+
+test_expect_success 'merge c1 to c2' '
+	git reset --hard c1 &&
+	git merge -s resolve c2 &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test -f c2.c
+'
+
+test_expect_success 'merge c2 to c3 (fails)' '
+	git reset --hard c2 &&
+	test_must_fail git merge -s resolve c3
+'
+test_done
-- 
1.5.6.2.450.g8d367.dirty
