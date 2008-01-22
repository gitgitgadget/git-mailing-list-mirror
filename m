From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t9001: enhance fake sendmail test harness
Date: Mon, 21 Jan 2008 22:25:44 -0500
Message-ID: <20080122032544.GC24758@coredump.intra.peff.net>
References: <m2y7aj9glo.fsf@userprimary.net> <1200945466-21154-1-git-send-email-hendeby@isy.liu.se> <1200945466-21154-2-git-send-email-hendeby@isy.liu.se> <20080122031932.GA24758@coredump.intra.peff.net> <20080122032353.GB24758@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Seth Falcon <seth@userprimary.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9mE-0005eT-AN
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbYAVDZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYAVDZs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:25:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1743 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbYAVDZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 22:25:47 -0500
Received: (qmail 30564 invoked by uid 111); 22 Jan 2008 03:25:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 21 Jan 2008 22:25:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2008 22:25:44 -0500
Content-Disposition: inline
In-Reply-To: <20080122032353.GB24758@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71410>

Previously, the fake.sendmail test harness would write its
output to a hardcoded file, allowing only a single message
to be tested. Instead, let's have it save the messages for
all of its invocations so that we can see which messages
which were sent, and in which order.

Signed-off-by: Jeff King <peff@peff.net>
---
This shouldn't change the test behavior at all, but is needed for the
test in 3/3.

 t/t9001-send-email.sh |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 08f7c3d..dd0c395 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -15,16 +15,22 @@ test_expect_success \
     'Setup helper tool' \
     '(echo "#!/bin/sh"
       echo shift
+      echo output=1
+      echo "while test -e commandline\$output; do output=\$((\$output+1)); done"
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
-- 
1.5.4.rc3.1130.gd9718-dirty
