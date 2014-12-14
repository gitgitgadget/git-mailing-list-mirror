From: =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
	<dpb@corrigendum.ru>
Subject: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded words properly
Date: Sun, 14 Dec 2014 18:59:47 +0300
Message-ID: <1418572787-2056-2-git-send-email-dpb@corrigendum.ru>
References: <1418572787-2056-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 14 17:00:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0Bae-0007YD-78
	for gcvg-git-2@plane.gmane.org; Sun, 14 Dec 2014 17:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbaLNQAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2014 11:00:08 -0500
Received: from forward8l.mail.yandex.net ([84.201.143.141]:52567 "EHLO
	forward8l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaLNQAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2014 11:00:06 -0500
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward8l.mail.yandex.net (Yandex) with ESMTP id 4CDA81A41031;
	Sun, 14 Dec 2014 19:00:02 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id CF5E8DE312C;
	Sun, 14 Dec 2014 19:00:01 +0300 (MSK)
Received: from 95-37-173-200.dynamic.mts-nn.ru (95-37-173-200.dynamic.mts-nn.ru [95.37.173.200])
	by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id WMovLIO4FZ-01Naq6g5;
	Sun, 14 Dec 2014 19:00:01 +0300
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1418572801; bh=w6kVH0c0bY+1K2SB9wb+DROfb+JnFGqSrQDNzRZHBHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Ji/AlAKufzT8pFROhAS7wuJUuwC6Fijl3R8stJR8HYKrhzNmf+wvEZKryzrlx1J3v
	 XEWA+IIyQZoGD1dZflU4y+M9sM92WT7Jy6rvcmjVGRfyqB7TP2ZCY3QC8TfkvLlGjP
	 FMnbRse6s70/S4f4sFDMR0676W3I8H34v67ebYtQ=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
X-Mailer: git-send-email 2.2.0.67.gf656295
In-Reply-To: <1418572787-2056-1-git-send-email-dpb@corrigendum.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261398>

The RFC says that they are to be concatenated after decoding (i.e. the
intervening whitespace is ignored).

Signed-off-by: =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=
=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru>
Acked-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   | 26 ++++++++++++++++----------
 t/t9001-send-email.sh |  7 +++++++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d461ffb..7d5cc8a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -919,17 +919,23 @@ $time =3D time - scalar $#files;
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
 	my $charset;
-	s{$re_encoded_word}{
-		$charset =3D $1;
-		my $encoding =3D $2;
-		my $text =3D $3;
-		if ($encoding eq 'q' || $encoding eq 'Q') {
-			$text =3D~ s/_/ /g;
-			$text =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/egi;
-			$text;
-		} else {
-			$&; # other encodings not supported yet
+	my $sep =3D qr/[ \t]+/;
+	s{$re_encoded_word(?:$sep$re_encoded_word)*}{
+		my @words =3D split $sep, $&;
+		foreach (@words) {
+			m/$re_encoded_word/;
+			$charset =3D $1;
+			my $encoding =3D $2;
+			my $text =3D $3;
+			if ($encoding eq 'q' || $encoding eq 'Q') {
+				$_ =3D $text;
+				s/_/ /g;
+				s/=3D([0-9A-F]{2})/chr(hex($1))/egi;
+			} else {
+				# other encodings not supported yet
+			}
 		}
+		join '', @words;
 	}eg;
 	return wantarray ? ($_, $charset) : $_;
 }
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 19a3ced..fa965ff 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -240,6 +240,13 @@ test_expect_success $PREREQ 'non-ascii self name i=
s suppressed' "
 		'non_ascii_self_suppressed'
 "
=20
+# This name is long enough to force format-patch to split it into mult=
iple
+# encoded-words, assuming it uses UTF-8 with the "Q" encoding.
+test_expect_success $PREREQ 'long non-ascii self name is suppressed' "
+	test_suppress_self_quoted '=C6=91=C3=BC=C3=B1n=C3=AD=C4=99=C5=99 =E2=82=
=AC. N=C3=A2=E1=B9=81=C3=A9' 'odd_?=3Dmail@example.com' \
+		'long_non_ascii_self_suppressed'
+"
+
 test_expect_success $PREREQ 'sanitized self name is suppressed' "
 	test_suppress_self_unquoted '\"A U. Thor\"' 'author@example.com' \
 		'self_name_sanitized_suppressed'
--=20
2.1.1
