From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Fix tests for broken sed on Leopard
Date: Tue, 18 Dec 2007 20:45:58 +0100
Message-ID: <1198007158-27576-1-git-send-email-win@wincent.com>
References: <7vzlw7zwj8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 20:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4iPG-0000rf-B8
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 20:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbXLRTq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 14:46:27 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbXLRTq1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 14:46:27 -0500
Received: from wincent.com ([72.3.236.74]:33831 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbXLRTq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 14:46:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBIJk0XD031436;
	Tue, 18 Dec 2007 13:46:01 -0600
X-Mailer: git-send-email 1.5.4.rc0.68.g15eb8-dirty
In-Reply-To: <7vzlw7zwj8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68797>

El 18/12/2007, a las 19:29, Junio C Hamano escribi=C3=B3:

> Could you work it around not by changing what is tested, but by chang=
ing
> the way the result (actual and expect) are compared, please?  I actua=
lly
> wanted to enhance this to test with values 1023, 2047, and 4095, and
> your change will close the door for such changes.

How about the following? This swaps in perl in place of sed, which we c=
an
hopefully rely upon to work across platforms.

Cheers,
Wincent

-------- 8< --------
=46ix tests for broken sed on Leopard

The newly-added common-tail-optimization test fails on Leopard because
the broken sed implementation bails with a spurious "unterminated
substitute pattern" error because of the length of one of the
arguments.

So use perl instead of sed, and at the same time add test cases for
1024 - 1 and 4096 - 1 as suggested by Junio.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t4024-diff-optimize-common.sh |  104 ++++++++++++++++++++++++++++++-=
--------
 1 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-co=
mmon.sh
index 20fe87b..84dfb05 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -7,28 +7,12 @@ test_description=3D'common tail optimization'
 z=3Dzzzzzzzz ;# 8
 z=3D"$z$z$z$z$z$z$z$z" ;# 64
 z=3D"$z$z$z$z$z$z$z$z" ;# 512
-z=3D"$z$z$z$z" ;# 2048
-z2047=3D$(expr "$z" : '.\(.*\)') ; #2047
-
-test_expect_success setup '
-
-	echo "a$z2047" >file-a &&
-	echo "b" >file-b &&
-	echo "$z2047" >>file-b &&
-	echo "c$z2047" | tr -d "\012" >file-c &&
-	echo "d" >file-d &&
-	echo "$z2047" | tr -d "\012" >>file-d &&
-
-	git add file-a file-b file-c file-d &&
-
-	echo "A$z2047" >file-a &&
-	echo "B" >file-b &&
-	echo "$z2047" >>file-b &&
-	echo "C$z2047" | tr -d "\012" >file-c &&
-	echo "D" >file-d &&
-	echo "$z2047" | tr -d "\012" >>file-d
-
-'
+z1024=3D"$z$z"
+z1023=3D$(expr "$z1024" : '.\(.*\)')
+z2048=3D"$z1024$z1024"
+z2047=3D$(expr "$z2048" : '.\(.*\)')
+z4096=3D"$z2048$z2048"
+z4095=3D$(expr "$z4096" : '.\(.*\)')
=20
 cat >expect <<\EOF
 diff --git a/file-a b/file-a
@@ -59,11 +43,83 @@ diff --git a/file-d b/file-d
 +D
 EOF
=20
-test_expect_success 'diff -U0' '
+test_expect_success 'setup (1023-char sequence)' '
+
+	echo "a$z1023" >file-a &&
+	echo "b" >file-b &&
+	echo "$z1023" >>file-b &&
+	echo "c$z1023" | tr -d "\012" >file-c &&
+	echo "d" >file-d &&
+	echo "$z1023" | tr -d "\012" >>file-d &&
+
+	git add file-a file-b file-c file-d &&
+
+	echo "A$z1023" >file-a &&
+	echo "B" >file-b &&
+	echo "$z1023" >>file-b &&
+	echo "C$z1023" | tr -d "\012" >file-c &&
+	echo "D" >file-d &&
+	echo "$z1023" | tr -d "\012" >>file-d
+
+'
+
+test_expect_success 'diff -U0 (1023-char sequence)' '
+	git diff -U0 | perl -pe "s/^index.+\n//g; s/$z1023/Z/g" >actual &&
+	diff -u expect actual
+
+'
+
+test_expect_success 'setup (2047-char sequence)' '
=20
-	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
+	echo "a$z2047" >file-a &&
+	echo "b" >file-b &&
+	echo "$z2047" >>file-b &&
+	echo "c$z2047" | tr -d "\012" >file-c &&
+	echo "d" >file-d &&
+	echo "$z2047" | tr -d "\012" >>file-d &&
+
+	git add file-a file-b file-c file-d &&
+
+	echo "A$z2047" >file-a &&
+	echo "B" >file-b &&
+	echo "$z2047" >>file-b &&
+	echo "C$z2047" | tr -d "\012" >file-c &&
+	echo "D" >file-d &&
+	echo "$z2047" | tr -d "\012" >>file-d
+
+'
+
+test_expect_success 'diff -U0 (2047-char sequence)' '
+
+	git diff -U0 | perl -pe "s/^index.+\n//g; s/$z2047/Z/g" >actual &&
 	diff -u expect actual
=20
 '
=20
+test_expect_success 'setup (4095-char sequence)' '
+
+	echo "a$z4095" >file-a &&
+	echo "b" >file-b &&
+	echo "$z4095" >>file-b &&
+	echo "c$z4095" | tr -d "\012" >file-c &&
+	echo "d" >file-d &&
+	echo "$z4095" | tr -d "\012" >>file-d &&
+
+	git add file-a file-b file-c file-d &&
+
+	echo "A$z4095" >file-a &&
+	echo "B" >file-b &&
+	echo "$z4095" >>file-b &&
+	echo "C$z4095" | tr -d "\012" >file-c &&
+	echo "D" >file-d &&
+	echo "$z4095" | tr -d "\012" >>file-d
+
+'
+
+test_expect_success 'diff -U0 (4095-char sequence)' '
+
+	git diff -U0 | perl -pe "s/^index.+\n//g; s/$z4095/Z/g" >actual &&
+	diff -u expect actual
+
+'
 test_done
--=20
1.5.4.rc0.68.g15eb8-dirty
