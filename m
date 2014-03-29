From: Charles Bailey <cbailey32@bloomberg.net>
Subject: [PATCH 2/2] Don't rely on strerror text when testing rmdir failure
Date: Sat, 29 Mar 2014 15:39:01 +0000
Message-ID: <1396107541-22974-3-git-send-email-cbailey32@bloomberg.net>
References: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
Cc: Charles Bailey <cbailey32@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 16:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTvM0-0001nO-4b
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 16:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaC2PjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 11:39:15 -0400
Received: from avasout05.plus.net ([84.93.230.250]:54321 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbaC2PjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 11:39:13 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id jTfA1n0072iA9hg01TfBou; Sat, 29 Mar 2014 15:39:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=5x84WwQ-OQAA:10 a=N2sEI2mohSIA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8 a=5KG0FKtP7X-Cq3Uui5gA:9 a=92rhvNbd_XgA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WTvLi-00060O-Nm; Sat, 29 Mar 2014 15:39:10 +0000
X-Mailer: git-send-email 1.8.5.1.2.ge5d1dab
In-Reply-To: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245435>

AIX doesn't make a distiction between EEXIST and ENOTEMPTY so relying on
the strerror string for the rmdir failure is fragile. Just test that the
start of the string matches the Git controlled "failed to rmdir..."
error. The exact text of the OS generated error string isn't important
to the test.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 t/t3600-rm.sh | 5 ++---
 t/t7001-mv.sh | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 3d30581..23eed17 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -709,10 +709,9 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	git commit -m "submodule removal" submod &&
 	git checkout HEAD^ &&
 	git submodule update &&
-	git checkout -q HEAD^ 2>actual &&
+	git checkout -q HEAD^ 2>/dev/null &&
 	git checkout -q master 2>actual &&
-	echo "warning: unable to rmdir submod: Directory not empty" >expected &&
-	test_i18ncmp expected actual &&
+	test_i18ngrep "^warning: unable to rmdir submod:" actual &&
 	git status -s submod >actual &&
 	echo "?? submod/" >expected &&
 	test_cmp expected actual &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 215d43d..34fb1af 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -447,8 +447,7 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
 	git mv sub sub2 &&
 	git commit -m "moved sub to sub2" &&
 	git checkout -q HEAD^ 2>actual &&
-	echo "warning: unable to rmdir sub2: Directory not empty" >expected &&
-	test_i18ncmp expected actual &&
+	test_i18ngrep "^warning: unable to rmdir sub2:" actual &&
 	git status -s sub2 >actual &&
 	echo "?? sub2/" >expected &&
 	test_cmp expected actual &&
-- 
1.8.5.1.2.ge5d1dab
