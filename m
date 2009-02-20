From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/4] Use CVS's -f option if available (ignore user's ~/.cvsrc file)
Date: Fri, 20 Feb 2009 06:18:11 +0100
Message-ID: <c202fb4c8c1eb0121cc15df6ad4a600dc3074f21.1235106222.git.mhagger@alum.mit.edu>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
 <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 06:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNoP-0003D5-60
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 06:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbZBTFSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 00:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbZBTFSl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 00:18:41 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49834 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZBTFSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 00:18:38 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1K5IEtW005509;
	Fri, 20 Feb 2009 06:18:15 +0100
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
In-Reply-To: <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
References: <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110796>

A user's ~/.cvsrc file can change the basic behavior of CVS commands.
Therefore we should ignore it in order to ensure consistent results
from the test suite.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9600-cvsimport.sh |   16 ++++++++--------
 t/t96xx/cvs-lib.sh   |    3 +++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index b4b9896..66393ae 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -6,12 +6,12 @@ test_description='git cvsimport basic tests'
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
 
-test_expect_success 'setup cvsroot' 'cvs init'
+test_expect_success 'setup cvsroot' '$CVS init'
 
 test_expect_success 'setup a cvs module' '
 
 	mkdir "$CVSROOT/module" &&
-	cvs co -d module-cvs module &&
+	$CVS co -d module-cvs module &&
 	cd module-cvs &&
 	cat <<EOF >o_fortuna &&
 O Fortuna
@@ -30,13 +30,13 @@ egestatem,
 potestatem
 dissolvit ut glaciem.
 EOF
-	cvs add o_fortuna &&
+	$CVS add o_fortuna &&
 	cat <<EOF >message &&
 add "O Fortuna" lyrics
 
 These public domain lyrics make an excellent sample text.
 EOF
-	cvs commit -F message &&
+	$CVS commit -F message &&
 	cd ..
 '
 
@@ -74,7 +74,7 @@ translate to English
 
 My Latin is terrible.
 EOF
-	cvs commit -F message &&
+	$CVS commit -F message &&
 	cd ..
 '
 
@@ -92,8 +92,8 @@ test_expect_success 'update cvs module' '
 
 	cd module-cvs &&
 		echo 1 >tick &&
-		cvs add tick &&
-		cvs commit -m 1
+		$CVS add tick &&
+		$CVS commit -m 1
 	cd ..
 
 '
@@ -111,7 +111,7 @@ test_expect_success 'cvsimport.module config works' '
 
 test_expect_success 'import from a CVS working tree' '
 
-	cvs co -d import-from-wt module &&
+	$CVS co -d import-from-wt module &&
 	cd import-from-wt &&
 		git cvsimport -a -z0 &&
 		echo 1 >expect &&
diff --git a/t/t96xx/cvs-lib.sh b/t/t96xx/cvs-lib.sh
index bfc1c12..6738901 100644
--- a/t/t96xx/cvs-lib.sh
+++ b/t/t96xx/cvs-lib.sh
@@ -14,6 +14,9 @@ then
 	exit
 fi
 
+CVS="cvs -f"
+export CVS
+
 cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
 2.1 | 2.2*)
-- 
1.6.1.3
