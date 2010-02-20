From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t1450: fix testcases that were wrongly expecting failure
Date: Sat, 20 Feb 2010 01:18:44 +0100
Message-ID: <491d6695b46414db1721235759fa1887421c9915.1266625101.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 01:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nid3z-0003CX-8d
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 01:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab0BTATK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 19:19:10 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:32503 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323Ab0BTATI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 19:19:08 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 01:19:04 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 01:18:44 +0100
X-Mailer: git-send-email 1.7.0.139.gd1a75.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140507>

Almost exactly a year ago in 02a6552 (Test fsck a bit harder), I
introduced two testcases that were expecting failure.

However, the only bug was that the testcases wrote *blobs* because I
forgot to pass -t tag to hash-object.  Fix this, and then adjust the
rest of the test to properly check the result.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t1450-fsck.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a22632f..49cae3e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -66,12 +66,12 @@ tagger T A Gger <tagger@example.com> 1234567890 -0000
 This is an invalid tag.
 EOF
 
-test_expect_failure 'tag pointing to nonexistent' '
-	tag=$(git hash-object -w --stdin < invalid-tag) &&
+test_expect_success 'tag pointing to nonexistent' '
+	tag=$(git hash-object -t tag -w --stdin < invalid-tag) &&
 	echo $tag > .git/refs/tags/invalid &&
-	git fsck --tags 2>out &&
+	test_must_fail git fsck --tags >out &&
 	cat out &&
-	grep "could not load tagged object" out &&
+	grep "broken link" out &&
 	rm .git/refs/tags/invalid
 '
 
@@ -84,12 +84,12 @@ tagger T A Gger <tagger@example.com> 1234567890 -0000
 This is an invalid tag.
 EOF
 
-test_expect_failure 'tag pointing to something else than its type' '
-	tag=$(git hash-object -w --stdin < wrong-tag) &&
+test_expect_success 'tag pointing to something else than its type' '
+	tag=$(git hash-object -t tag -w --stdin < wrong-tag) &&
 	echo $tag > .git/refs/tags/wrong &&
-	git fsck --tags 2>out &&
+	test_must_fail git fsck --tags 2>out &&
 	cat out &&
-	grep "some sane error message" out &&
+	grep "error in tag.*broken links" out &&
 	rm .git/refs/tags/wrong
 '
 
-- 
1.7.0.139.gd1a75.dirty
