From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH v2 5/7] format-patch: make rfc2047 encoding more strict
Date: Thu, 18 Oct 2012 16:43:32 +0200
Message-ID: <1350571414-17907-6-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOrQy-00044m-6T
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab2JROuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:50:40 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:38360 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab2JROuj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:50:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 3793663ED
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:50:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id 6iriKywSjGeA 15484-19;
	Thu, 18 Oct 2012 16:45:37 +0200 (CEST) 13820
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 18 Oct 2012 16:45:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208012>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

RFC 2047 requires more characters to be encoded than it is currently do=
ne.
Especially, RFC 2047 distinguishes between allowed remaining characters
in encoded words in addresses (From, To, etc.) and other headers, such
as Subject.

Make add_rfc2047() and is_rfc2047_special() location dependent and incl=
ude
all non-allowed characters to hopefully be RFC 2047 conform.

This especially fixes a problem, where RFC 822 specials (e. g. ".") wer=
e
left unencoded in addresses, which was solved with a non-standard-confo=
rm
workaround in the past (which is going to be removed in a follow-up pat=
ch).

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
v2:
- part of restructured patch 4 of v1
- disallow even more characters in is_rfc2047_special()

The implementation of isprint() should later probably be substituted by
the one from Nguyen:
http://article.gmane.org/gmane.comp.version-control.git/207666
---
 git-compat-util.h       |  2 ++
 pretty.c                | 67 +++++++++++++++++++++++++++++++++++++++++=
++------
 t/t4014-format-patch.sh | 15 ++++++++---
 3 Dateien ge=C3=A4ndert, 72 Zeilen hinzugef=C3=BCgt(+), 12 Zeilen entf=
ernt(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 000042d..d4ea446 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -475,6 +475,7 @@ extern const char tolower_trans_tbl[256];
 #undef isdigit
 #undef isalpha
 #undef isalnum
+#undef isprint
 #undef islower
 #undef isupper
 #undef tolower
@@ -492,6 +493,7 @@ extern unsigned char sane_ctype[256];
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)
 #define islower(x) sane_iscase(x, 1)
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
diff --git a/pretty.c b/pretty.c
index 482402d..613e4ea 100644
--- a/pretty.c
+++ b/pretty.c
@@ -272,16 +272,65 @@ static void add_rfc822_quoted(struct strbuf *out,=
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
-	if (ch =3D=3D ' ' || ch =3D=3D '\n')
+	/*
+	 * rfc2047, section 4.2:
+	 *
+	 *    8-bit values which correspond to printable ASCII characters oth=
er
+	 *    than "=3D", "?", and "_" (underscore), MAY be represented as th=
ose
+	 *    characters.  (But see section 5 for restrictions.)  In
+	 *    particular, SPACE and TAB MUST NOT be represented as themselves
+	 *    within encoded words.
+	 */
+
+	/*
+	 * rule out non-ASCII characters and non-printable characters (the
+	 * non-ASCII check should be redundant as isprint() is not localized
+	 * and only knows about ASCII, but be defensive about that)
+	 */
+	if (non_ascii(ch) || !isprint(ch))
+		return 1;
+
+	/*
+	 * rule out special printable characters (' ' should be the only
+	 * whitespace character considered printable, but be defensive and us=
e
+	 * isspace())
+	 */
+	if (isspace(ch) || ch =3D=3D '=3D' || ch =3D=3D '?' || ch =3D=3D '_')
 		return 1;
=20
-	return (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (ch =
=3D=3D '_'));
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
+	if (type !=3D RFC2047_ADDRESS)
+		return 0;
+
+	/* '=3D' and '_' are special cases and have been checked above */
+	return !(isalnum(ch) || ch =3D=3D '!' || ch =3D=3D '*' || ch =3D=3D '=
+' || ch =3D=3D '-' || ch =3D=3D '/');
 }
=20
 static void add_rfc2047(struct strbuf *sb, const char *line, int len,
-		       const char *encoding)
+		       const char *encoding, enum rfc2047_type type)
 {
 	static const int max_length =3D 78; /* per rfc2822 */
 	static const int max_encoded_length =3D 76; /* per rfc2047 */
@@ -304,7 +353,7 @@ needquote:
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
 	for (i =3D 0; i < len; i++) {
 		unsigned ch =3D line[i] & 0xFF;
-		int is_special =3D is_rfc2047_special(ch);
+		int is_special =3D is_rfc2047_special(ch, type);
=20
 		/*
 		 * According to RFC 2047, we could encode the special character
@@ -358,11 +407,13 @@ void pp_user_info(const struct pretty_print_conte=
xt *pp,
 		display_name_length =3D name_tail - line;
 		strbuf_addstr(sb, "From: ");
 		if (!has_rfc822_specials(line, display_name_length)) {
-			add_rfc2047(sb, line, display_name_length, encoding);
+			add_rfc2047(sb, line, display_name_length,
+						encoding, RFC2047_ADDRESS);
 		} else {
 			struct strbuf quoted =3D STRBUF_INIT;
 			add_rfc822_quoted(&quoted, line, display_name_length);
-			add_rfc2047(sb, quoted.buf, quoted.len, encoding);
+			add_rfc2047(sb, quoted.buf, quoted.len,
+						encoding, RFC2047_ADDRESS);
 			strbuf_release(&quoted);
 		}
 		if (namelen - display_name_length + last_line_length(sb) > 78) {
@@ -1294,7 +1345,7 @@ void pp_title_line(const struct pretty_print_cont=
ext *pp,
 	strbuf_grow(sb, title.len + 1024);
 	if (pp->subject) {
 		strbuf_addstr(sb, pp->subject);
-		add_rfc2047(sb, title.buf, title.len, encoding);
+		add_rfc2047(sb, title.buf, title.len, encoding, RFC2047_SUBJECT);
 	} else {
 		strbuf_addbuf(sb, &title);
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1d5636d..727d606 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -818,21 +818,28 @@ check_author() {
 cat >expect <<'EOF'
 From: "Foo B. Bar" <author@example.com>
 EOF
-test_expect_success 'format-patch quotes dot in headers' '
+test_expect_success 'format-patch quotes dot in from-headers' '
 	check_author "Foo B. Bar"
 '
=20
 cat >expect <<'EOF'
 From: "Foo \"The Baz\" Bar" <author@example.com>
 EOF
-test_expect_success 'format-patch quotes double-quote in headers' '
+test_expect_success 'format-patch quotes double-quote in from-headers'=
 '
 	check_author "Foo \"The Baz\" Bar"
 '
=20
 cat >expect <<'EOF'
-From: =3D?UTF-8?q?"F=3DC3=3DB6o=3D20B.=3D20Bar"?=3D <author@example.co=
m>
+From: =3D?UTF-8?q?F=3DC3=3DB6o=3D20Bar?=3D <author@example.com>
 EOF
-test_expect_success 'rfc2047-encoded headers also double-quote 822 spe=
cials' '
+test_expect_success 'format-patch uses rfc2047-encoded from-headers wh=
en necessary' '
+	check_author "F=C3=B6o Bar"
+'
+
+cat >expect <<'EOF'
+From: =3D?UTF-8?q?F=3DC3=3DB6o=3D20B=3D2E=3D20Bar?=3D <author@example.=
com>
+EOF
+test_expect_failure 'rfc2047-encoded from-headers leave no rfc822 spec=
ials' '
 	check_author "F=C3=B6o B. Bar"
 '
=20
--=20
1.7.12
