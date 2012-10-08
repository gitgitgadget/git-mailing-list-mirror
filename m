From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH 4/5] format-patch: fix rfc2047 address encoding with respect to rfc822 specials
Date: Mon,  8 Oct 2012 19:33:28 +0200
Message-ID: <1349717609-4770-5-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 19:40:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHJA-00021F-O3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab2JHRjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 13:39:49 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:47924 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab2JHRjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:39:49 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2012 13:39:48 EDT
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 279A37E0B
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 19:39:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id A3DVLnKWEuby 02576-18;
	Mon,  8 Oct 2012 19:39:32 +0200 (CEST) 13666
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Mon,  8 Oct 2012 19:39:32 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207245>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

According to RFC 2047 and RFC 822, rfc2047 encoded words and and rfc822
quoted strings do not mix.

Be more strict about rfc2047 encoded words in addresses, so that it is =
a
bit more conform to RFC 2047.

(Especially, my own name gets correctly decoded as Jan H. Sch=C3=B6nher=
r
(without quotes) and not as "Jan H. Sch=C3=B6nherr" (with quotes).)

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
 pretty.c                | 80 ++++++++++++++++++++++++++++++++++++++---=
--------
 t/t4014-format-patch.sh | 11 +++++--
 2 Dateien ge=C3=A4ndert, 71 Zeilen hinzugef=C3=BCgt(+), 20 Zeilen entf=
ernt(-)

diff --git a/pretty.c b/pretty.c
index ee76219..f3a7383 100644
--- a/pretty.c
+++ b/pretty.c
@@ -231,7 +231,7 @@ static int is_rfc822_special(char ch)
 	}
 }
=20
-static int has_rfc822_specials(const char *s, int len)
+static int needs_rfc822_quoting(const char *s, int len)
 {
 	int i;
 	for (i =3D 0; i < len; i++)
@@ -272,7 +272,12 @@ static void add_rfc822_quoted(struct strbuf *out, =
const char *s, int len)
 	strbuf_addch(out, '"');
 }
=20
-static int is_rfc2047_special(char ch)
+enum rfc2047_type {
+	RFC2047_SUBJECT,
+	RFC2047_ADDRESS,
+};
+
+static int is_rfc2047_special(char ch, enum rfc2047_type type)
 {
 	/*
 	 * We encode ' ' using '=3D20' even though rfc2047
@@ -283,33 +288,62 @@ static int is_rfc2047_special(char ch)
 	if (ch =3D=3D ' ' || ch =3D=3D '\n')
 		return 1;
=20
-	return (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (ch =
=3D=3D '_'));
+	if (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (ch =3D=3D=
 '_'))
+		return 1;
+
+	if (type !=3D RFC2047_ADDRESS)
+		return 0;
+
+	/*
+	 * rfc2047, section 5.3:
+	 *
+	 *    As a replacement for a 'word' entity within a 'phrase', for exa=
mple,
+	 *    one that precedes an address in a From, To, or Cc header.  The =
ABNF
+	 *    definition for 'phrase' from RFC 822 thus becomes:
+	 *
+	 *    phrase =3D 1*( encoded-word / word )
+	 *
+	 *    In this case the set of characters that may be used in a "Q"-en=
coded
+	 *    'encoded-word' is restricted to: <upper and lower case ASCII
+	 *    letters, decimal digits, "!", "*", "+", "-", "/", "=3D", and "_=
"
+	 *    (underscore, ASCII 95.)>.  An 'encoded-word' that appears withi=
n a
+	 *    'phrase' MUST be separated from any adjacent 'word', 'text' or
+	 *    'special' by 'linear-white-space'.
+	 */
+
+	/* '=3D' and '_' are special cases and have been checked above */
+	return !(isalnum(ch) || ch =3D=3D '!' || ch =3D=3D '*' || ch =3D=3D '=
+' || ch =3D=3D '-' || ch =3D=3D '/');
 }
=20
-static void add_rfc2047(struct strbuf *sb, const char *line, int len,
-		       const char *encoding)
+static int needs_rfc2047_encoding(const char *line, int len,
+				  enum rfc2047_type type)
 {
-	static const int max_length =3D 76; /* per rfc2047 */
 	int i;
-	int line_len =3D last_line_length(sb);
=20
 	for (i =3D 0; i < len; i++) {
 		int ch =3D line[i];
 		if (non_ascii(ch) || ch =3D=3D '\n')
-			goto needquote;
+			return 1;
 		if ((i + 1 < len) && (ch =3D=3D '=3D' && line[i+1] =3D=3D '?'))
-			goto needquote;
+			return 1;
 	}
-	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, 78+1);
-	return;
=20
-needquote:
+	return 0;
+}
+
+static void add_rfc2047(struct strbuf *sb, const char *line, int len,
+		       const char *encoding, enum rfc2047_type type)
+{
+	static const int max_length =3D 76; /* per rfc2047 */
+	int i;
+	int line_len =3D last_line_length(sb);
+
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
 	for (i =3D 0; i < len; i++) {
 		unsigned ch =3D line[i] & 0xFF;
-		int is_special =3D is_rfc2047_special(ch);
+		int is_special =3D is_rfc2047_special(ch, type);
=20
 		if (line_len + 2 + (is_special ? 3 : 1) > max_length) {
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
@@ -355,13 +389,18 @@ void pp_user_info(const struct pretty_print_conte=
xt *pp,
 			name_tail--;
 		display_name_length =3D name_tail - line;
 		strbuf_addstr(sb, "From: ");
-		if (!has_rfc822_specials(line, display_name_length)) {
-			add_rfc2047(sb, line, display_name_length, encoding);
-		} else {
+		if (needs_rfc2047_encoding(line, display_name_length, RFC2047_ADDRES=
S)) {
+			add_rfc2047(sb, line, display_name_length,
+						encoding, RFC2047_ADDRESS);
+		} else if (needs_rfc822_quoting(line, display_name_length)) {
 			struct strbuf quoted =3D STRBUF_INIT;
 			add_rfc822_quoted(&quoted, line, display_name_length);
-			add_rfc2047(sb, quoted.buf, quoted.len, encoding);
+			strbuf_add_wrapped_bytes(sb, quoted.buf, quoted.len,
+								-6, 1, 78+1);
 			strbuf_release(&quoted);
+		} else {
+			strbuf_add_wrapped_bytes(sb, line, display_name_length,
+								-6, 1, 78+1);
 		}
 		if (namelen - display_name_length + last_line_length(sb) > 78) {
 			strbuf_addch(sb, '\n');
@@ -1292,7 +1331,12 @@ void pp_title_line(const struct pretty_print_con=
text *pp,
 	strbuf_grow(sb, title.len + 1024);
 	if (pp->subject) {
 		strbuf_addstr(sb, pp->subject);
-		add_rfc2047(sb, title.buf, title.len, encoding);
+		if (needs_rfc2047_encoding(title.buf, title.len, RFC2047_SUBJECT))
+			add_rfc2047(sb, title.buf, title.len, encoding,
+				    RFC2047_SUBJECT);
+		else
+			strbuf_add_wrapped_bytes(sb, title.buf, title.len,
+						 -last_line_length(sb), 1, 78+1);
 	} else {
 		strbuf_addbuf(sb, &title);
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1d5636d..1a3b6e8 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -830,9 +830,16 @@ test_expect_success 'format-patch quotes double-qu=
ote in headers' '
 '
=20
 cat >expect <<'EOF'
-From: =3D?UTF-8?q?"F=3DC3=3DB6o=3D20B.=3D20Bar"?=3D <author@example.co=
m>
+From: =3D?UTF-8?q?F=3DC3=3DB6o=3D20Bar?=3D <author@example.com>
 EOF
-test_expect_success 'rfc2047-encoded headers also double-quote 822 spe=
cials' '
+test_expect_success 'format-patch uses rfc2047-encoded headers when ne=
cessary' '
+	check_author "F=C3=B6o Bar"
+'
+
+cat >expect <<'EOF'
+From: =3D?UTF-8?q?F=3DC3=3DB6o=3D20B=3D2E=3D20Bar?=3D <author@example.=
com>
+EOF
+test_expect_success 'rfc2047-encoded headers leave no rfc822 specials'=
 '
 	check_author "F=C3=B6o B. Bar"
 '
=20
--=20
1.7.12
