From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 01/11] t5300-pack-object.sh: Split the big verify-pack test into smaller parts.
Date: Tue, 13 Nov 2007 21:04:56 +0100
Message-ID: <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21A-0001Be-Q3
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762516AbXKMUFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762510AbXKMUFN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:13 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49186 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762471AbXKMUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:09 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 5459B10A90B;
	Tue, 13 Nov 2007 21:05:07 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64854>

This makes it easier to spot which of the tests failed.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t5300-pack-object.sh |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index ba7579c..f1106e6 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -187,49 +187,51 @@ test_expect_success \
 			test-3-${packname_3}.idx'
 
 test_expect_success \
-    'corrupt a pack and see if verify catches' \
+    'verify-pack catches mismatched .idx and .pack files' \
     'cat test-1-${packname_1}.idx >test-3.idx &&
      cat test-2-${packname_2}.pack >test-3.pack &&
      if git verify-pack test-3.idx
      then false
      else :;
-     fi &&
+     fi'
 
-     : PACK_SIGNATURE &&
-     cat test-1-${packname_1}.pack >test-3.pack &&
+test_expect_success \
+    'verify-pack catches a corrupted pack signature' \
+    'cat test-1-${packname_1}.pack >test-3.pack &&
      dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
      if git verify-pack test-3.idx
      then false
      else :;
-     fi &&
+     fi'
 
-     : PACK_VERSION &&
-     cat test-1-${packname_1}.pack >test-3.pack &&
+test_expect_success \
+    'verify-pack catches a corrupted pack version' \
+    'cat test-1-${packname_1}.pack >test-3.pack &&
      dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
      if git verify-pack test-3.idx
      then false
      else :;
-     fi &&
+     fi'
 
-     : TYPE/SIZE byte of the first packed object data &&
-     cat test-1-${packname_1}.pack >test-3.pack &&
+test_expect_success \
+    'verify-pack catches a corrupted type/size of the 1st packed object data' \
+    'cat test-1-${packname_1}.pack >test-3.pack &&
      dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
      if git verify-pack test-3.idx
      then false
      else :;
-     fi &&
+     fi'
 
-     : sum of the index file itself &&
-     l=`wc -c <test-3.idx` &&
+test_expect_success \
+    'verify-pack catches a corrupted sum of the index file itself' \
+    'l=`wc -c <test-3.idx` &&
      l=`expr $l - 20` &&
      cat test-1-${packname_1}.pack >test-3.pack &&
      dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
      if git verify-pack test-3.pack
      then false
      else :;
-     fi &&
-
-     :'
+     fi'
 
 test_expect_success \
     'build pack index for an existing pack' \
-- 
1.5.3.5.1592.g0d6db
