From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] t1506: factor out test for "Did you mean..."
Date: Thu, 31 Mar 2011 11:17:33 +0200
Message-ID: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
References: <4D94322A.8030409@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 11:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5E4E-00039P-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213Ab1CaJVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 05:21:10 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36430 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932977Ab1CaJVI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 05:21:08 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5766020A3A;
	Thu, 31 Mar 2011 05:21:07 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 05:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=SoTZDMh2QwoUtL++SI4dEN+CCwY=; b=dosOwYZLDtEMyx8f9HJGXk3/yl+rN+yhyIswMPpGRynKv/Py1EFP6cHPREPeCZcrizLjsooEkSoArLw+3/5XblmsUPie8j1zoMYN5ltlJatGJkrIThTYUsbniWYMj6ORpMz9a2iR6wYYhaZ+TYp3tCCCR8+rpkPNjO12E7VJUqU=
X-Sasl-enc: Ua4K6H41xNaswfnwM+m/mM7rKKDw+39ja+MUnNx/EKCE 1301563266
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E8F70408844;
	Thu, 31 Mar 2011 05:21:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <4D94322A.8030409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170460>

With the current code, it's a "'"'"'" jungle, and we test only 1 line of
the 2 line response. Factor out and test both.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t1506-rev-parse-diagnosis.sh |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 9f8adb1..f9cb202 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -6,6 +6,13 @@ exec </dev/null
 
 . ./test-lib.sh
 
+test_did_you_mean ()
+{
+	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
+	printf "Did you mean '$1:$2$3'?\n" >>expected &&
+	test_cmp expected error
+}
+
 HASH_file=
 
 test_expect_success 'set up basic repo' '
@@ -106,7 +113,7 @@ test_expect_success 'incorrect file in sha1:path' '
 	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." error &&
 	(cd subdir &&
 	 test_must_fail git rev-parse HEAD:file2.txt 2> error &&
-	 grep "Did you mean '"'"'HEAD:subdir/file2.txt'"'"'?" error )
+	 test_did_you_mean HEAD subdir/ file2.txt exists )
 '
 
 test_expect_success 'incorrect file in :path and :N:path' '
@@ -115,14 +122,14 @@ test_expect_success 'incorrect file in :path and :N:path' '
 	test_must_fail git rev-parse :1:nothing.txt 2> error &&
 	grep "Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
 	test_must_fail git rev-parse :1:file.txt 2> error &&
-	grep "Did you mean '"'"':0:file.txt'"'"'?" error &&
+	test_did_you_mean ":0" "" file.txt "is in the index" "at stage 1" &&
 	(cd subdir &&
 	 test_must_fail git rev-parse :1:file.txt 2> error &&
-	 grep "Did you mean '"'"':0:file.txt'"'"'?" error &&
+	 test_did_you_mean ":0" "" file.txt "is in the index" "at stage 1" &&
 	 test_must_fail git rev-parse :file2.txt 2> error &&
-	 grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" error &&
+	 test_did_you_mean ":0" subdir/ file2.txt "is in the index" &&
 	 test_must_fail git rev-parse :2:file2.txt 2> error &&
-	 grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" error) &&
+	 test_did_you_mean :0 subdir/ file2.txt "is in the index") &&
 	test_must_fail git rev-parse :disk-only.txt 2> error &&
 	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index." error
 '
-- 
1.7.4.2.668.gba03a4
