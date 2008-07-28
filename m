From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 03:21:10 +0200
Message-ID: <03fa2187a72957d98d63ab899b39e9adc2edfe99.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org>
 <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
 <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org>
 <10c4292de30b5868bd9fb54b557e8dae827f1241.1217207602.git.vmiklos@frugalware.org>
 <42e8615f6cbd236e40b19f2a754807f08e4b85a6.1217207602.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 03:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHRL-0007Ey-Oe
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbYG1BU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYG1BUx
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:20:53 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41575 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYG1BUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:20:47 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id C5DB71DDC60
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:20:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C7BBA1AB594; Mon, 28 Jul 2008 03:21:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <42e8615f6cbd236e40b19f2a754807f08e4b85a6.1217207602.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90391>

Testing is done by creating a simple git-merge-theirs strategy which is
the opposite of ours. Using this in real merges is not recommended but
it's perfect for our testing needs.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7606-merge-custom.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 t/t7606-merge-custom.sh

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
new file mode 100755
index 0000000..f295e56
--- /dev/null
+++ b/t/t7606-merge-custom.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing a custom strategy.'
+
+. ./test-lib.sh
+
+cat > git-merge-theirs << EOF
+#!/bin/sh
+eval git read-tree --reset -u \\\$\$#
+EOF
+chmod +x git-merge-theirs
+PATH=.:$PATH
+export PATH
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
+	git tag c2
+'
+
+test_expect_success 'merge c2 with a custom strategy' '
+	git reset --hard c1 &&
+	git merge -s theirs c2 &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test ! -f c1.c &&
+	test -f c2.c
+'
+
+test_done
-- 
1.6.0.rc0.14.g95f8.dirty
