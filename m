From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH 2/5] format-patch: do not wrap rfc2047 encoded headers too late
Date: Mon,  8 Oct 2012 19:33:26 +0200
Message-ID: <1349717609-4770-3-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 19:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHSe-0006r3-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab2JHRtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 13:49:33 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:48594 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab2JHRt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:49:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 750B17DEA
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 19:38:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id CeAOGQ-NJoIE 10614-17;
	Mon,  8 Oct 2012 19:38:41 +0200 (CEST) 13547
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Mon,  8 Oct 2012 19:38:41 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207251>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

Encoded characters add more than one character at once to an encoded
header. Include all characters that are about to be added in the length
calculation for wrapping.

Additionally, RFC 2047 imposes a maximum line length of 76 characters
if that line contains an rfc2047 encoded word.

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
 pretty.c                | 24 +++++++++++---------
 t/t4014-format-patch.sh | 58 +++++++++++++++++++++++++++++------------=
--------
 2 Dateien ge=C3=A4ndert, 49 Zeilen hinzugef=C3=BCgt(+), 33 Zeilen entf=
ernt(-)

diff --git a/pretty.c b/pretty.c
index f5caecb..daf8581 100644
--- a/pretty.c
+++ b/pretty.c
@@ -263,13 +263,22 @@ static void add_rfc822_quoted(struct strbuf *out,=
 const char *s, int len)
=20
 static int is_rfc2047_special(char ch)
 {
+	/*
+	 * We encode ' ' using '=3D20' even though rfc2047
+	 * allows using '_' for readability.  Unfortunately,
+	 * many programs do not understand this and just
+	 * leave the underscore in place.
+	 */
+	if (ch =3D=3D ' ' || ch =3D=3D '\n')
+		return 1;
+
 	return (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (ch =
=3D=3D '_'));
 }
=20
 static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 		       const char *encoding)
 {
-	static const int max_length =3D 78; /* per rfc2822 */
+	static const int max_length =3D 76; /* per rfc2047 */
 	int i;
 	int line_len;
=20
@@ -286,7 +295,7 @@ static void add_rfc2047(struct strbuf *sb, const ch=
ar *line, int len,
 		if ((i + 1 < len) && (ch =3D=3D '=3D' && line[i+1] =3D=3D '?'))
 			goto needquote;
 	}
-	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, max_length+1);
+	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, 78+1);
 	return;
=20
 needquote:
@@ -295,19 +304,14 @@ needquote:
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
 	for (i =3D 0; i < len; i++) {
 		unsigned ch =3D line[i] & 0xFF;
+		int is_special =3D is_rfc2047_special(ch);
=20
-		if (line_len >=3D max_length - 2) {
+		if (line_len + 2 + (is_special ? 3 : 1) > max_length) {
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
 			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
 		}
=20
-		/*
-		 * We encode ' ' using '=3D20' even though rfc2047
-		 * allows using '_' for readability.  Unfortunately,
-		 * many programs do not understand this and just
-		 * leave the underscore in place.
-		 */
-		if (is_rfc2047_special(ch) || ch =3D=3D ' ' || ch =3D=3D '\n') {
+		if (is_special) {
 			strbuf_addf(sb, "=3D%02X", ch);
 			line_len +=3D 3;
 		}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d66e358..1d5636d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -772,30 +772,31 @@ M8=3D"f=C3=B6=C3=B6 bar "
 M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
 M512=3D$M64$M64$M64$M64$M64$M64$M64$M64
 cat >expect <<'EOF'
-Subject: [PATCH] =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3D=
B6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+Subject: [PATCH] =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3D=
B6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
+ =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
+ =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
+ =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
+ =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
+ =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
+ =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar?=3D
 EOF
-test_expect_success 'format-patch wraps extremely long headers (rfc204=
7)' '
+test_expect_success 'format-patch wraps extremely long subject (rfc204=
7)' '
 	rm -rf patches/ &&
 	echo content >>file &&
 	git add file &&
@@ -862,6 +863,17 @@ test_expect_success 'format-patch wraps extremely =
long from-header (rfc822)' '
 '
=20
 cat >expect <<'EOF'
+From: =3D?UTF-8?q?Fo=3DC3=3DB6=3D20Bar=3D20Foo=3D20Bar=3D20Foo=3D20Bar=
=3D20Foo=3D20Bar=3D20Foo?=3D
+ =3D?UTF-8?q?=3D20Bar=3D20Foo=3D20Bar=3D20Foo=3D20Bar=3D20Foo=3D20Bar=3D=
20Foo=3D20Bar=3D20Foo=3D20?=3D
+ =3D?UTF-8?q?Bar=3D20Foo=3D20Bar=3D20Foo=3D20Bar=3D20Foo=3D20Bar=3D20F=
oo=3D20Bar=3D20Foo=3D20Bar?=3D
+ =3D?UTF-8?q?=3D20Foo=3D20Bar=3D20Foo=3D20Bar=3D20Foo=3D20Bar=3D20Foo=3D=
20Bar=3D20Foo=3D20Bar=3D20?=3D
+ =3D?UTF-8?q?Foo=3D20Bar=3D20Foo=3D20Bar?=3D <author@example.com>
+EOF
+test_expect_success 'format-patch wraps extremely long from-header (rf=
c2047)' '
+	check_author "Fo=C3=B6 Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Fo=
o Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar F=
oo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
+'
+
+cat >expect <<'EOF'
 Subject: header with . in it
 EOF
 test_expect_success 'subject lines do not have 822 atom-quoting' '
--=20
1.7.12
