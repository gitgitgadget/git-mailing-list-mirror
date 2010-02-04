From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/3] fix multiple issues with t5300
Date: Wed, 03 Feb 2010 22:48:26 -0500
Message-ID: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 04:48:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncshn-00058V-FP
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 04:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab0BDDsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 22:48:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38281 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab0BDDs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 22:48:29 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA000WCT8S3332@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 22:48:28 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.149.g0b0b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138943>

First of all, trying to run 'git verify-pack' on packs  produced by
the tests using pack.packSizeLimit always failed.  After lots of digging
and head scratching, it turns out that the preceeding test simulating
a SHA1 collision did leave the repository quite confused, impacting
subsequent tests.

So let's move that destructive test last, and add tests to run
verify-pack on the output from those packSizeLimit tests to catch such
goofage.

Finally, group those packSizeLimit tests together.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 t/t5300-pack-object.sh |   54 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index e2aa254..ac81114 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -280,26 +280,8 @@ test_expect_success \
 
      :'
 
-test_expect_success \
-    'fake a SHA1 hash collision' \
-    'test -f	.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 &&
-     cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
-		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
-
-test_expect_success \
-    'make sure index-pack detects the SHA1 collision' \
-    'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
-     grep "SHA1 COLLISION FOUND" msg'
-
-test_expect_success \
-    'honor pack.packSizeLimit' \
-    'git config pack.packSizeLimit 200 &&
-     packname_4=$(git pack-objects test-4 <obj-list) &&
-     test 3 = $(ls test-4-*.pack | wc -l)'
-
 test_expect_success 'unpacking with --strict' '
 
-	git config --unset pack.packsizelimit &&
 	for j in a b c d e f g
 	do
 		for i in 0 1 2 3 4 5 6 7 8 9
@@ -392,10 +374,42 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
+test_expect_success 'honor pack.packSizeLimit' '
+	git config pack.packSizeLimit 200 &&
+ 	packname_10=$(git pack-objects test-10 <obj-list) &&
+ 	test 3 = $(ls test-10-*.pack | wc -l)
+'
+
+test_expect_success 'verify resulting packs' '
+	git verify-pack test-10-*.pack
+'
+
 test_expect_success 'tolerate absurdly small packsizelimit' '
 	git config pack.packSizeLimit 2 &&
-	packname_9=$(git pack-objects test-9 <obj-list) &&
-	test $(wc -l <obj-list) = $(ls test-9-*.pack | wc -l)
+	packname_11=$(git pack-objects test-11 <obj-list) &&
+	test $(wc -l <obj-list) = $(ls test-11-*.pack | wc -l)
 '
 
+test_expect_success 'verify resulting packs' '
+	git verify-pack test-11-*.pack
+'
+
+#
+# WARNING!
+#
+# The following test is destructive.  Please keep the next
+# two tests at the end of this file.
+#
+
+test_expect_success \
+    'fake a SHA1 hash collision' \
+    'test -f	.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 &&
+     cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
+		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
+
+test_expect_success \
+    'make sure index-pack detects the SHA1 collision' \
+    'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
+     grep "SHA1 COLLISION FOUND" msg'
+
 test_done
-- 
1.7.0.rc1.149.g0b0b7
