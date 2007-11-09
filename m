From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-checkout: Test for relative path use.
Date: Fri,  9 Nov 2007 11:36:07 +1100
Message-ID: <11945685732608-git-send-email-dsymonds@gmail.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFQ-00047A-CZ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbXKIBAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbXKIBAv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:00:51 -0500
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:28568 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751321AbXKIBAt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 20:00:49 -0500
X-IronPort-AV: E=Sophos;i="4.21,392,1188743400"; 
   d="scan'208";a="224084302"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail02.adl2.internode.on.net with ESMTP; 09 Nov 2007 11:06:15 +1030
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11945685673280-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64090>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
	Test 5 in this series fails because of a bug in git-ls-files, where
		git-ls-files t/../
	(with or without --full-name) returns no files.

 t/t2008-checkout-subdir.sh |   79 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100755 t/t2008-checkout-subdir.sh

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
new file mode 100755
index 0000000..f226511
--- /dev/null
+++ b/t/t2008-checkout-subdir.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David Symonds
+
+test_description='git checkout from subdirectories'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo "base" > file0 &&
+	git add file0 &&
+	mkdir dir1 &&
+	echo "hello" > dir1/file1 &&
+	git add dir1/file1 &&
+	mkdir dir2 &&
+	echo "bonjour" > dir2/file2 &&
+	git add dir2/file2 &&
+	test_tick &&
+	git commit -m "populate tree"
+
+'
+
+test_expect_success 'remove and restore with relative path' '
+
+	cd dir1 &&
+	rm ../file0 &&
+	git checkout HEAD -- ../file0 &&
+	test "base" = "$(cat ../file0)" &&
+	rm ../dir2/file2 &&
+	git checkout HEAD -- ../dir2/file2 &&
+	test "bonjour" = "$(cat ../dir2/file2)" &&
+	rm ../file0 ./file1 &&
+	git checkout HEAD -- .. &&
+	test "base" = "$(cat ../file0)" &&
+	test "hello" = "$(cat file1)" &&
+	cd -
+
+'
+
+test_expect_success 'checkout with empty prefix' '
+
+	rm file0 &&
+	git checkout HEAD -- file0 &&
+	test "base" = "$(cat file0)"
+
+'
+
+test_expect_success 'checkout with simple prefix' '
+
+	rm dir1/file1 &&
+	git checkout HEAD -- dir1 &&
+	test "hello" = "$(cat dir1/file1)" &&
+	rm dir1/file1 &&
+	git checkout HEAD -- dir1/file1 &&
+	test "hello" = "$(cat dir1/file1)"
+
+'
+
+test_expect_success 'checkout with complex relative path' '
+
+	rm file1 &&
+	git checkout HEAD -- ../dir1/../dir1/file1 && test -f ./file1
+
+'
+
+test_expect_failure 'relative path outside tree should fail' \
+	'git checkout HEAD -- ../../Makefile'
+
+test_expect_failure 'incorrect relative path to file should fail (1)' \
+	'git checkout HEAD -- ../file0'
+
+test_expect_failure 'incorrect relative path should fail (2)' \
+	'cd dir1 && git checkout HEAD -- ./file0'
+
+test_expect_failure 'incorrect relative path should fail (3)' \
+	'cd dir1 && git checkout HEAD -- ../../file0'
+
+test_done
-- 
1.5.3.1
