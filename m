From: =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
	<dpb@corrigendum.ru>
Subject: [PATCH v2 1/2] send-email: align RFC 2047 decoding more closely with the spec
Date: Sun, 14 Dec 2014 18:59:46 +0300
Message-ID: <1418572787-2056-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 14 17:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0Bal-0007p6-4z
	for gcvg-git-2@plane.gmane.org; Sun, 14 Dec 2014 17:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbaLNQAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2014 11:00:11 -0500
Received: from forward6l.mail.yandex.net ([84.201.143.139]:54290 "EHLO
	forward6l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbaLNQAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2014 11:00:06 -0500
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward6l.mail.yandex.net (Yandex) with ESMTP id 54B1414E0F87;
	Sun, 14 Dec 2014 19:00:01 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id CC2C3DE312C;
	Sun, 14 Dec 2014 19:00:00 +0300 (MSK)
Received: from 95-37-173-200.dynamic.mts-nn.ru (95-37-173-200.dynamic.mts-nn.ru [95.37.173.200])
	by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id WMovLIO4FZ-00NCHrre;
	Sun, 14 Dec 2014 19:00:00 +0300
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1418572800; bh=qE38UBbXJZ6WywdSaYZ6k3aUXI1M//W8Q3PSkgabe3I=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	b=Vr2F3e/8XtwDwTPlOskl9gzRvFeG0cXwYWYhmIEUr5AVQeEfWqozqN6qmydqpyUuF
	 wQli1ARTYs4paucU8FI4EjybwIwwXeLDPu+wtvgToOJsS67E3hs710PIvvvWGN4sb4
	 U4Rf6NVYaKaPYNdG1NCD/kKJYul+5BShPJsTysyw=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
X-Mailer: git-send-email 2.2.0.67.gf656295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261399>

More specifically:

* Add "\" to the list of characters not allowed in a token (see RFC 204=
7
  errata).

* Share regexes between unquote_rfc2047 and is_rfc2047_quoted. Besides
  removing duplication, this also makes unquote_rfc2047 more stringent.

* Allow both "q" and "Q" to identify the encoding.

* Allow lowercase hexadecimal digits in the "Q" encoding.

And, more on the cosmetic side:

* Change the "encoded-text" regex to exclude rather than include charac=
ters,
  for clarity and consistency with "token".

Signed-off-by: =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=
=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru>
Acked-by: Jeff King <peff@peff.net>
---
 git-send-email.perl | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9949db0..d461ffb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -145,6 +145,11 @@ my $have_mail_address =3D eval { require Mail::Add=
ress; 1 };
 my $smtp;
 my $auth;
=20
+# Regexes for RFC 2047 productions.
+my $re_token =3D qr/[^][()<>@,;:\\"\/?.=3D \000-\037\177-\377]+/;
+my $re_encoded_text =3D qr/[^? \000-\037\177-\377]+/;
+my $re_encoded_word =3D qr/=3D\?($re_token)\?($re_token)\?($re_encoded=
_text)\?=3D/;
+
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh=
,
 	$initial_reply_to,$initial_subject,@files,
@@ -913,15 +918,20 @@ $time =3D time - scalar $#files;
=20
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
-	my $encoding;
-	s{=3D\?([^?]+)\?q\?(.*?)\?=3D}{
-		$encoding =3D $1;
-		my $e =3D $2;
-		$e =3D~ s/_/ /g;
-		$e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
-		$e;
+	my $charset;
+	s{$re_encoded_word}{
+		$charset =3D $1;
+		my $encoding =3D $2;
+		my $text =3D $3;
+		if ($encoding eq 'q' || $encoding eq 'Q') {
+			$text =3D~ s/_/ /g;
+			$text =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/egi;
+			$text;
+		} else {
+			$&; # other encodings not supported yet
+		}
 	}eg;
-	return wantarray ? ($_, $encoding) : $_;
+	return wantarray ? ($_, $charset) : $_;
 }
=20
 sub quote_rfc2047 {
@@ -934,10 +944,8 @@ sub quote_rfc2047 {
=20
 sub is_rfc2047_quoted {
 	my $s =3D shift;
-	my $token =3D qr/[^][()<>@,;:"\/?.=3D \000-\037\177-\377]+/;
-	my $encoded_text =3D qr/[!->@-~]+/;
 	length($s) <=3D 75 &&
-	$s =3D~ m/^(?:"[[:ascii:]]*"|=3D\?$token\?$token\?$encoded_text\?=3D)=
$/o;
+	$s =3D~ m/^(?:"[[:ascii:]]*"|$re_encoded_word)$/o;
 }
=20
 sub subject_needs_rfc2047_quoting {
--=20
2.1.1
