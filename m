From: David Symonds <dsymonds@gmail.com>
Subject: [NEW REPLACEMENT PATCH] git-checkout: Add a test case for relative paths use.
Date: Fri,  9 Nov 2007 00:13:52 +1100
Message-ID: <11945276321726-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7D3-0007mt-Cv
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbXKHNN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbXKHNN5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:13:57 -0500
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:24007 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754234AbXKHNN5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 08:13:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAA+YMkd5LBGKWmdsb2JhbACBW40aASA
X-IronPort-AV: E=Sophos;i="4.21,389,1188743400"; 
   d="scan'208";a="183620694"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail03.adl2.internode.on.net with ESMTP; 08 Nov 2007 23:43:54 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64015>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 t/t2008-checkout-subdir.sh |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t2008-checkout-subdir.sh

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
new file mode 100755
index 0000000..45b9e13
--- /dev/null
+++ b/t/t2008-checkout-subdir.sh
@@ -0,0 +1,47 @@
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
+	echo base > file0 &&
+	git add file0 &&
+	mkdir dir1 &&
+	echo hello > dir1/file1 &&
+	git add dir1/file1 &&
+	test_tick &&
+	mkdir dir2 &&
+	echo bonjour > dir2/file2 &&
+	git add dir2/file2 &&
+	git commit -m "populate tree"
+
+'
+
+test_expect_success 'remove and restore with relative path' '
+
+	cd dir1 &&
+	rm ../file0 &&
+	git checkout HEAD -- ../file0 && test -f ../file0 &&
+	rm ../dir2/file2 &&
+	git checkout HEAD -- ../dir2/file2 && test -f ../dir2/file2 &&
+	rm ../file0 ./file1 &&
+	git checkout HEAD -- .. && test -f ../file0 && test -f ./file1 &&
+	rm file1 &&
+	git checkout HEAD -- ../dir1/../dir1/file1 && test -f ./file1
+
+'
+
+test_expect_failure 'checkout with relative path outside tree should fail (1)' \
+	'git checkout HEAD -- ../file0'
+
+test_expect_failure 'checkout with relative path outside tree should fail (2)' \
+	'cd dir1 && git checkout HEAD -- ./file0'
+
+test_expect_failure 'checkout with relative path outside tree should fail (2)' \
+	'cd dir1 && git checkout HEAD -- ../../file0'
+
+test_done
-- 
1.5.3.1
