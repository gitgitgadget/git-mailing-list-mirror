From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 03/11] t5302-pack-index: Skip tests of 64-bit offsets if necessary.
Date: Tue, 13 Nov 2007 21:04:58 +0100
Message-ID: <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21D-0001Be-CZ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761158AbXKMUFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761075AbXKMUFX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:23 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49193 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762478AbXKMUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id DB7C810ABFE;
	Tue, 13 Nov 2007 21:05:07 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64850>

There are platforms where off_t is not 64 bits wide. In this case many tests
are doomed to fail. Let's skip them.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t5302-pack-index.sh |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 4f58c4c..d93abc4 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -61,17 +61,33 @@ test_expect_success \
 
 test_expect_success \
     'index v2: force some 64-bit offsets with pack-objects' \
-    'pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list) &&
-     git verify-pack -v "test-3-${pack3}.pack"'
+    'pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list)'
+
+have_64bits=
+if msg=$(git verify-pack -v "test-3-${pack3}.pack" 2>&1) ||
+	! echo "$msg" | grep "pack too large .* off_t"
+then
+	have_64bits=t
+else
+	say "skipping tests concerning 64-bit offsets"
+fi
+
+test "$have_64bits" &&
+test_expect_success \
+    'index v2: verify a pack with some 64-bit offsets' \
+    'git verify-pack -v "test-3-${pack3}.pack"'
 
+test "$have_64bits" &&
 test_expect_failure \
     '64-bit offsets: should be different from previous index v2 results' \
     'cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"'
 
+test "$have_64bits" &&
 test_expect_success \
     'index v2: force some 64-bit offsets with index-pack' \
     'git-index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"'
 
+test "$have_64bits" &&
 test_expect_success \
     '64-bit offsets: index-pack result should match pack-objects one' \
     'cmp "test-3-${pack3}.idx" "3.idx"'
@@ -113,6 +129,7 @@ test_expect_failure \
     '[index v1] 6) newly created pack is BAD !' \
     'git verify-pack -v "test-4-${pack1}.pack"'
 
+test "$have_64bits" &&
 test_expect_success \
     '[index v2] 1) stream pack to repository' \
     'rm -f .git/objects/pack/* &&
@@ -122,6 +139,7 @@ test_expect_success \
      cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
      cmp "test-3-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
 
+test "$have_64bits" &&
 test_expect_success \
     '[index v2] 2) create a stealth corruption in a delta base reference' \
     '# this test assumes a delta smaller than 16 bytes at the end of the pack
@@ -134,14 +152,17 @@ test_expect_success \
 	  bs=1 count=20 conv=notrunc &&
        git cat-file blob "$delta_sha1" > blob_4 )'
 
+test "$have_64bits" &&
 test_expect_failure \
     '[index v2] 3) corrupted delta happily returned wrong data' \
     'cmp blob_3 blob_4'
 
+test "$have_64bits" &&
 test_expect_failure \
     '[index v2] 4) confirm that the pack is actually corrupted' \
     'git fsck --full $commit'
 
+test "$have_64bits" &&
 test_expect_failure \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
     'git pack-objects test-5 <obj-list'
-- 
1.5.3.5.1592.g0d6db
