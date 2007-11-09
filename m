From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-checkout: Test for relative path use.
Date: Fri,  9 Nov 2007 20:12:28 +1100
Message-ID: <11945995483966-git-send-email-dsymonds@gmail.com>
References: <ee77f5c20711090110s5d6c533et5e1e016a95fde943@mail.gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPv2-00049O-MZ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 10:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXKIJMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 04:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXKIJMe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 04:12:34 -0500
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:50610 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392AbXKIJMc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 04:12:32 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAPKyM0d5LBGK/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,394,1188743400"; 
   d="scan'208";a="224354642"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail02.adl2.internode.on.net with ESMTP; 09 Nov 2007 19:42:30 +1030
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <ee77f5c20711090110s5d6c533et5e1e016a95fde943@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64149>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 t/t2008-checkout-subdir.sh |   80 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 t/t2008-checkout-subdir.sh

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
new file mode 100755
index 0000000..98d8eb3
--- /dev/null
+++ b/t/t2008-checkout-subdir.sh
@@ -0,0 +1,80 @@
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
+	(
+		cd dir1 &&
+		rm ../file0 &&
+		git checkout HEAD -- ../file0 &&
+		test "base" = "$(cat ../file0)" &&
+		rm ../dir2/file2 &&
+		git checkout HEAD -- ../dir2/file2 &&
+		test "bonjour" = "$(cat ../dir2/file2)" &&
+		rm ../file0 ./file1 &&
+		git checkout HEAD -- .. &&
+		test "base" = "$(cat ../file0)" &&
+		test "hello" = "$(cat file1)"
+	)
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
+	'( cd dir1 && git checkout HEAD -- ./file0 )'
+
+test_expect_failure 'incorrect relative path should fail (3)' \
+	'( cd dir1 && git checkout HEAD -- ../../file0 )'
+
+test_done
-- 
1.5.3.1
