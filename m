From: =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
	<dpb@corrigendum.ru>
Subject: [PATCH v2 1/2] send-email: align RFC 2047 decoding more closely with the spec
Date: Sat,  6 Dec 2014 22:36:22 +0300
Message-ID: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jay Soffian <jaysoffian@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 20:36:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxL9p-0003qM-1s
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 20:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaLFTgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 14:36:36 -0500
Received: from forward4l.mail.yandex.net ([84.201.143.137]:42485 "EHLO
	forward4l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaLFTge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 14:36:34 -0500
Received: from smtp17.mail.yandex.net (smtp17.mail.yandex.net [95.108.252.17])
	by forward4l.mail.yandex.net (Yandex) with ESMTP id 15C881440DB7;
	Sat,  6 Dec 2014 22:36:30 +0300 (MSK)
Received: from smtp17.mail.yandex.net (localhost [127.0.0.1])
	by smtp17.mail.yandex.net (Yandex) with ESMTP id A547D1900164;
	Sat,  6 Dec 2014 22:36:29 +0300 (MSK)
Received: from 109-184-135-154.dynamic.mts-nn.ru (109-184-135-154.dynamic.mts-nn.ru [109.184.135.154])
	by smtp17.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id AG4MC1hKDi-aSKGQS6b;
	Sat,  6 Dec 2014 22:36:29 +0300
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 34e53474-a405-4156-8a47-0f246e5f6721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1417894589; bh=wxH0PA8IIo+W8xzvP92CI37/Pc1pS/sDrgIX1p/fBEY=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	b=NuWeeXVrg4ZA1Vo4xK0+5JjYYUL761IvpNqmMqrxtBxbs7Mu5hd7p/aftPpqpMdKU
	 22Y5lDlzlE3yktiXWVZHfm+lVIbw2wBPmvbQd4wBD1xVaOAG/LzgWh6bSc+RMMEhJ4
	 yJQE5YuHazz+EXsR7SovrdUY+5a7eyxKusQ3EVDs=
Authentication-Results: smtp17.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
X-Mailer: git-send-email 2.2.0.34.g02e215e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260960>

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
