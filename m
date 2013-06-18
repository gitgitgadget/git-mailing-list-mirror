From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Avoid broken Solaris tr
Date: Tue, 18 Jun 2013 22:17:27 +0100
Message-ID: <1371590247-13436-1-git-send-email-bdwalton@gmail.com>
Cc: Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 23:41:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up3e3-0003Ux-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206Ab3FRVkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 17:40:52 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:35141 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab3FRVkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 17:40:51 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 17:40:51 EDT
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:54197 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1Up3HS-0005kK-N8 ; Tue, 18 Jun 2013 17:17:34 -0400
Received: from 86-44-8-209-dynamic.b-ras1.bbh.dublin.eircom.net ([86.44.8.209]:60979 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1Up3HQ-0007wS-1j ; Tue, 18 Jun 2013 17:17:32 -0400
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1Up3HV-0003VG-HL; Tue, 18 Jun 2013 22:17:37 +0100
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228318>

Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) fail to handle the case
where the first argument is a multi-character set and the second is a
single null character. Use perl to perform these substitutions
instead. Now that we're using perl for the transliteration, we might
as well replace the sed invocations with it too.

We make this change globally in t0008-ignores instead of just for the
cases where it matters in order to maintain consistency.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t0008-ignores.sh | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index a56db80..9e4987e 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -552,12 +552,13 @@ cat <<-EOF >expected-verbose
 	$global_excludes:2:!globaltwo	b/globaltwo
 EOF
 
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
-	tr "\n" "\0" >stdin0
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
-	tr "\n" "\0" >expected-default0
-sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
-	tr ":\t\n" "\0" >expected-verbose0
+perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' stdin >stdin0
+
+perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' expected-default > \
+    expected-default0
+
+perl -pne 's/	"/	/; s/\\//; s/"$//; s/[:\t\n]/\0/g' expected-verbose > \
+    expected-verbose0
 
 test_expect_success '--stdin' '
 	expect_from_stdin <expected-default &&
@@ -638,12 +639,13 @@ EOF
 grep -v '^::	' expected-all >expected-verbose
 sed -e 's/.*	//' expected-verbose >expected-default
 
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
-	tr "\n" "\0" >stdin0
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
-	tr "\n" "\0" >expected-default0
-sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
-	tr ":\t\n" "\0" >expected-verbose0
+perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' stdin >stdin0
+
+perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' expected-default > \
+    expected-default0
+
+perl -pne 's/	"/	/; s/\\//; s/"$//; s/[:\t\n]/\0/g' expected-verbose > \
+    expected-verbose0
 
 test_expect_success '--stdin from subdirectory' '
 	expect_from_stdin <expected-default &&
-- 
1.8.1.2
