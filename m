From: =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
	<dpb@corrigendum.ru>
Subject: [PATCH] send-email: handle adjacent RFC 2047-encoded words properly
Date: Mon, 24 Nov 2014 02:50:04 +0300
Message-ID: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jay Soffian <jaysoffian@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 01:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsh5E-0006rd-Ua
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 01:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaKXAAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 19:00:40 -0500
Received: from forward3l.mail.yandex.net ([84.201.143.136]:48665 "EHLO
	forward3l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaKXAAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 19:00:39 -0500
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Nov 2014 19:00:39 EST
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [37.140.190.27])
	by forward3l.mail.yandex.net (Yandex) with ESMTP id F2E391500CB2;
	Mon, 24 Nov 2014 02:50:15 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (localhost [127.0.0.1])
	by smtp2o.mail.yandex.net (Yandex) with ESMTP id 0613936A33EF;
	Mon, 24 Nov 2014 02:50:14 +0300 (MSK)
Received: from cs7-mts-1-124.dialup.mts-nn.ru (cs7-mts-1-124.dialup.mts-nn.ru [82.208.71.124])
	by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id SeVorxZE3T-oEWWxqll;
	Mon, 24 Nov 2014 02:50:14 +0300
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: dc819af9-2150-4399-a9ed-d77c9e551f9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1416786614; bh=zVdytTBndW0jQp5Q8SjfYkLhKCrXXoSKK0OJoCyH/Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	b=oEU1p+buAUof/ETdDXiSrLdBCBtBHEFTe/naifEhN9IdQSBnb4DQaxvod/ZU9RKyc
	 dbgKT6xpDOJ/Crfqt4nP4Y9PK0Kyu7/Hj+Iw9EgPsFJJVdKQ+gKLw08lp7+zC0siTS
	 wKgVaXKIm6qfM4KacOFACNDx64N6BND9cG0e0doo=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
X-Mailer: git-send-email 2.1.3.18.ga66e999.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260109>

The RFC says that they are to be concatenated after decoding (i.e. the
intervening whitespace is ignored).

I change the sender's name to an all-Cyrillic string in the tests so th=
at
its encoded form goes over the 76 characters in a line limit, forcing
format-patch to split it into multiple encoded words.

Since I have to modify the regular expression for an encoded word anywa=
y,
I take the opportunity to bring it closer to the spec, most notably
disallowing embedded spaces and making it case-insensitive (thus allowi=
ng
the encoding to be specified as both "q" and "Q").

Signed-off-by: =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=
=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru>
---
 git-send-email.perl   | 21 +++++++++++++++------
 t/t9001-send-email.sh | 18 +++++++++---------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9949db0..4bb9f6f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -913,13 +913,22 @@ $time =3D time - scalar $#files;
=20
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
+
+	my $et =3D qr/[!->@-~]+/; # encoded-text from RFC 2047
+	my $sep =3D qr/[ \t]+/;
+	my $encoded_word =3D qr/=3D\?($et)\?q\?($et)\?=3D/i;
+
 	my $encoding;
-	s{=3D\?([^?]+)\?q\?(.*?)\?=3D}{
-		$encoding =3D $1;
-		my $e =3D $2;
-		$e =3D~ s/_/ /g;
-		$e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
-		$e;
+	s{$encoded_word(?:$sep$encoded_word)+}{
+		my @words =3D split $sep, $&;
+		foreach (@words) {
+			m/$encoded_word/;
+			$encoding =3D $1;
+			$_ =3D $2;
+			s/_/ /g;
+			s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
+		}
+		join '', @words;
 	}eg;
 	return wantarray ? ($_, $encoding) : $_;
 }
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 19a3ced..318b870 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -236,7 +236,7 @@ test_expect_success $PREREQ 'self name with dot is =
suppressed' "
 "
=20
 test_expect_success $PREREQ 'non-ascii self name is suppressed' "
-	test_suppress_self_quoted 'F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9' 'odd_=
?=3Dmail@example.com' \
+	test_suppress_self_quoted '=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=D0=B8=
=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F' 'odd_?=3Dmail@=
example.com' \
 		'non_ascii_self_suppressed'
 "
=20
@@ -946,25 +946,25 @@ test_expect_success $PREREQ 'utf8 author is corre=
ctly passed on' '
 	clean_fake_sendmail &&
 	test_commit weird_author &&
 	test_when_finished "git reset --hard HEAD^" &&
-	git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd=
_?=3Dmail@example.com>" &&
-	git format-patch --stdout -1 >funny_name.patch &&
+	git commit --amend --author "=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=D0=B8=
=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=3Dmail@e=
xample.com>" &&
+	git format-patch --stdout -1 >nonascii_name.patch &&
 	git send-email --from=3D"Example <nobody@example.com>" \
 	  --to=3Dnobody@example.com \
 	  --smtp-server=3D"$(pwd)/fake.sendmail" \
-	  funny_name.patch &&
-	grep "^From: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exampl=
e.com>" msgtxt1
+	  nonascii_name.patch &&
+	grep "^From: =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=D0=B8=D1=87=D0=B5=D1=
=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=3Dmail@example.com>" ms=
gtxt1
 '
=20
 test_expect_success $PREREQ 'utf8 sender is not duplicated' '
 	clean_fake_sendmail &&
 	test_commit weird_sender &&
 	test_when_finished "git reset --hard HEAD^" &&
-	git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd=
_?=3Dmail@example.com>" &&
-	git format-patch --stdout -1 >funny_name.patch &&
-	git send-email --from=3D"F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3D=
mail@example.com>" \
+	git commit --amend --author "=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=D0=B8=
=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=3Dmail@e=
xample.com>" &&
+	git format-patch --stdout -1 >nonascii_name.patch &&
+	git send-email --from=3D"=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=D0=B8=D1=
=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=3Dmail@exam=
ple.com>" \
 	  --to=3Dnobody@example.com \
 	  --smtp-server=3D"$(pwd)/fake.sendmail" \
-	  funny_name.patch &&
+	  nonascii_name.patch &&
 	grep "^From: " msgtxt1 >msgfrom &&
 	test_line_count =3D 1 msgfrom
 '
--=20
2.1.1
