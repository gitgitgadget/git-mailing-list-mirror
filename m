From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] t5530-upload-pack-error: Check more carefully for failures.
Date: Mon, 5 Nov 2007 22:40:12 +0100
Message-ID: <200711052240.12822.johannes.sixt@telecom.at>
References: <200711042046.48257.johannes.sixt@telecom.at> <7v3avkqwyz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 22:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9gO-0007sw-4h
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXKEVkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbXKEVkR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:40:17 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49472 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbXKEVkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:40:16 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id CD37610A940;
	Mon,  5 Nov 2007 22:40:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7801A59E03;
	Mon,  5 Nov 2007 22:40:13 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3avkqwyz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63562>

Previously, the test only triggered a failure in upload-pack's rev-list
subprocess. Here we also test for a failure of pack-objects, and make sure
that the right process failed.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
  On Monday 05 November 2007 21:05, Junio C Hamano wrote:
  > > 	The test case checks for failures in rev-list (a missing
  > > 	object). Any hints how to trigger a failure in pack-objects
  > > 	that does not also trigger in rev-list would be welcome.
  >
  > How about removing a blob from the test repository  to corrupt
  > it?  rev-list --objects I think would happily list the blob
  > because it sees its name in its containing tree without checking
  > its existence.

  That does it. This goes on top of my previous patch.

  -- Hannes

 t/t5530-upload-pack-error.sh |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 9923ba0..70d4f86 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup and corrupt repository' '
 	test_tick &&
 	echo changed >file &&
 	git commit -a -m changed &&
-	rm -f .git/objects/f7/3f3093ff865c514c6c51f867e35f693487d0d3
+	rm -f .git/objects/5e/a2ed416fbd4a4cbe227b75fe255dd7fa6bd4d6
 
 '
 
@@ -24,14 +24,33 @@ test_expect_failure 'fsck fails' '
 	git fsck
 '
 
-test_expect_failure 'upload pack fails due to error in rev-list' '
+test_expect_success 'upload-pack fails due to error in pack-objects' '
 
-	echo "0032want $(git rev-parse HEAD)
+	! echo "0032want $(git rev-parse HEAD)
 00000009done
-0000" | git-upload-pack . > /dev/null
+0000" | git-upload-pack . > /dev/null 2> output.err &&
+	grep "pack-objects died" output.err
+'
+
+test_expect_success 'corrupt repo differently' '
+
+	git hash-object -w file &&
+	rm -f .git/objects/be/c63e37d08c454ad3a60cde90b70f3f7d077852
 
 '
 
+test_expect_failure 'fsck fails' '
+
+	git fsck
+'
+test_expect_success 'upload-pack fails due to error in rev-list' '
+
+	! echo "0032want $(git rev-parse HEAD)
+00000009done
+0000" | git-upload-pack . > /dev/null 2> output.err &&
+	grep "waitpid (async) failed" output.err
+'
+
 test_expect_success 'create empty repository' '
 
 	mkdir foo &&
-- 
1.5.3.4.315.g2ce38
