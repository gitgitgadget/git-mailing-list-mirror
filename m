From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/4] Add a new test for using a custom merge strategy
Date: Wed, 30 Jul 2008 01:17:00 +0200
Message-ID: <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
 <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org>
 <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyRp-0007ys-Vt
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbYG2XQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYG2XQg
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:16:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55573 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYG2XQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:16:35 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 9A8791DDC5D;
	Wed, 30 Jul 2008 01:16:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 80DDC1AB591; Wed, 30 Jul 2008 01:17:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90703>

Testing is done by creating a simple git-merge-theirs strategy which is
the opposite of ours. Using this in real merges is not recommended but
it's perfect for our testing needs.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7606-merge-custom.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 t/t7606-merge-custom.sh

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
new file mode 100755
index 0000000..13e8ff5
--- /dev/null
+++ b/t/t7606-merge-custom.sh
@@ -0,0 +1,46 @@
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
+	test "$(git rev-parse c2^{tree})" = "$(git rev-parse HEAD^{tree})" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test ! -f c1.c &&
+	test -f c2.c
+'
+
+test_done
-- 
1.6.0.rc0.14.g95f8.dirty
