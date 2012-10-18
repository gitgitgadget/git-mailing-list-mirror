From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH v2 1/7] utf8: fix off-by-one wrapping of text
Date: Thu, 18 Oct 2012 16:43:28 +0200
Message-ID: <1350571414-17907-2-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:45:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOrLa-000555-PN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab2JROpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:45:05 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:58304 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab2JROpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:45:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 3A22D61C4
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:45:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id 98+MUSc2FpAC 12050-20;
	Thu, 18 Oct 2012 16:44:53 +0200 (CEST) 13540
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 18 Oct 2012 16:44:53 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208008>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

The wrapping logic in strbuf_add_wrapped_text() does currently not allo=
w
lines that entirely fill the allowed width, instead it wraps the line o=
ne
character too early.

=46or example, the text "This is the sixth commit." formatted via
"%w(11,1,2)" (wrap at 11 characters, 1 char indent of first line, 2 cha=
r
indent of following lines) results in four lines: " This is", "  the",
"  sixth", "  commit." This is wrong, because "  the sixth" is exactly
11 characters long, and thus allowed.

=46ix this by allowing the (width+1) character of a line to be a valid
wrapping point if it is a whitespace character.

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
v2: new patch, result of v1 discussion
---
 t/t4202-log.sh | 4 ++--
 utf8.c         | 2 +-
 2 Dateien ge=C3=A4ndert, 3 Zeilen hinzugef=C3=BCgt(+), 3 Zeilen entfer=
nt(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index b3ac6be..584e3d8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -72,9 +72,9 @@ cat > expect << EOF
   commit.
 EOF
=20
-test_expect_success 'format %w(12,1,2)' '
+test_expect_success 'format %w(11,1,2)' '
=20
-	git log -2 --format=3D"%w(12,1,2)This is the %s commit." > actual &&
+	git log -2 --format=3D"%w(11,1,2)This is the %s commit." > actual &&
 	test_cmp expect actual
 '
=20
diff --git a/utf8.c b/utf8.c
index a544f15..28791a7 100644
--- a/utf8.c
+++ b/utf8.c
@@ -353,7 +353,7 @@ retry:
=20
 		c =3D *text;
 		if (!c || isspace(c)) {
-			if (w < width || !space) {
+			if (w <=3D width || !space) {
 				const char *start =3D bol;
 				if (!c && text =3D=3D start)
 					return w;
--=20
1.7.12
