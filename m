From: Jeff King <peff@peff.net>
Subject: [PATCH] t9001: enhance fake sendmail test harness
Date: Sun, 24 Feb 2008 16:03:52 -0500
Message-ID: <20080224210352.GA9150@coredump.intra.peff.net>
References: <20080224205720.GA7085@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 22:05:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTO1r-0007Kz-UR
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 22:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758864AbYBXVD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 16:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYBXVDz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 16:03:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4541 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757214AbYBXVDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 16:03:55 -0500
Received: (qmail 1853 invoked by uid 111); 24 Feb 2008 21:03:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 16:03:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 16:03:52 -0500
Content-Disposition: inline
In-Reply-To: <20080224205720.GA7085@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74962>

Previously, the fake.sendmail test harness would write its
output to a hardcoded file, allowing only a single message
to be tested. Instead, let's have it save the messages for
all of its invocations so that we can see which messages
were sent, and in which order.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9001-send-email.sh |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2efaed4..4975048 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -15,16 +15,22 @@ test_expect_success \
     'Setup helper tool' \
     '(echo "#!/bin/sh"
       echo shift
+      echo output=1
+      echo "while test -f commandline\$output; do output=\$((\$output+1)); done"
       echo for a
       echo do
       echo "  echo \"!\$a!\""
-      echo "done >commandline"
-      echo "cat > msgtxt"
+      echo "done >commandline\$output"
+      echo "cat > msgtxt\$output"
       ) >fake.sendmail &&
      chmod +x ./fake.sendmail &&
      git add fake.sendmail &&
      GIT_AUTHOR_NAME="A" git commit -a -m "Second."'
 
+clean_fake_sendmail() {
+	rm -f commandline* msgtxt*
+}
+
 test_expect_success 'Extract patches' '
     patches=`git format-patch -n HEAD^1`
 '
@@ -39,7 +45,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'Verify commandline' \
-    'diff commandline expected'
+    'diff commandline1 expected'
 
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
@@ -82,7 +88,7 @@ z8=zzzzzzzz
 z64=$z8$z8$z8$z8$z8$z8$z8$z8
 z512=$z64$z64$z64$z64$z64$z64$z64$z64
 test_expect_success 'reject long lines' '
-	rm -f commandline &&
+	clean_fake_sendmail &&
 	cp $patches longline.patch &&
 	echo $z512$z512 >>longline.patch &&
 	! git send-email \
@@ -95,7 +101,7 @@ test_expect_success 'reject long lines' '
 '
 
 test_expect_success 'no patch was sent' '
-	! test -e commandline
+	! test -e commandline1
 '
 
 test_expect_success 'allow long lines with --no-validate' '
@@ -109,6 +115,7 @@ test_expect_success 'allow long lines with --no-validate' '
 '
 
 test_expect_success 'Invalid In-Reply-To' '
+	clean_fake_sendmail &&
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
@@ -116,17 +123,18 @@ test_expect_success 'Invalid In-Reply-To' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches
 		2>errors
-	! grep "^In-Reply-To: < *>" msgtxt
+	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
 test_expect_success 'Valid In-Reply-To when prompting' '
+	clean_fake_sendmail &&
 	(echo "From Example <from@example.com>"
 	 echo "To Example <to@example.com>"
 	 echo ""
 	) | env GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches 2>errors &&
-	! grep "^In-Reply-To: < *>" msgtxt
+	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
 test_done
-- 
1.5.4.3.307.gacd7
