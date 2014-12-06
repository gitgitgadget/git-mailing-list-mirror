From: =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
	<dpb@corrigendum.ru>
Subject: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded words properly
Date: Sat,  6 Dec 2014 22:36:23 +0300
Message-ID: <1417894583-2352-2-git-send-email-dpb@corrigendum.ru>
References: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jay Soffian <jaysoffian@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 20:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxL9o-0003qM-Fn
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 20:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaLFTgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 14:36:35 -0500
Received: from forward7l.mail.yandex.net ([84.201.143.140]:51492 "EHLO
	forward7l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbaLFTge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 14:36:34 -0500
Received: from smtp17.mail.yandex.net (smtp17.mail.yandex.net [95.108.252.17])
	by forward7l.mail.yandex.net (Yandex) with ESMTP id 6B596BC1207;
	Sat,  6 Dec 2014 22:36:31 +0300 (MSK)
Received: from smtp17.mail.yandex.net (localhost [127.0.0.1])
	by smtp17.mail.yandex.net (Yandex) with ESMTP id C2D0F190018E;
	Sat,  6 Dec 2014 22:36:30 +0300 (MSK)
Received: from 109-184-135-154.dynamic.mts-nn.ru (109-184-135-154.dynamic.mts-nn.ru [109.184.135.154])
	by smtp17.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id AG4MC1hKDi-aUKGrRPL;
	Sat,  6 Dec 2014 22:36:30 +0300
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 99e00424-eed7-4302-a75b-b2e20ee9f38e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1417894590; bh=xNKV5Hz0m+YVh4WFq4ARrk8RC0YktYIrH9+VkLhJfc0=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=STwBF/4qTwEHAGLDTVwrFggZNpJP4bpxi8wphD6hQQVLxYdTcI1ovVzOSLQqltLnQ
	 c5jF2am7uB1zrY3hLHfyjmA0ECviNFo+ByU1/YOHSxmXOJJp3rcNUq7ebYGNexEMQS
	 GNKwhgNG1Dqdqe7GHEVWtEqTPgvVYi5tLTyje+co=
Authentication-Results: smtp17.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
X-Mailer: git-send-email 2.2.0.34.g02e215e.dirty
In-Reply-To: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260959>

The RFC says that they are to be concatenated after decoding (i.e. the
intervening whitespace is ignored).
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
