From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH v2 6/7] format-patch: fix rfc2047 address encoding with respect to rfc822 specials
Date: Thu, 18 Oct 2012 16:43:33 +0200
Message-ID: <1350571414-17907-7-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOrR6-0004HC-Q6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab2JROuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:50:44 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:38398 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab2JROun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:50:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id DE42D63F8
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:50:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id joTdu97d9JKR 06149-16;
	Thu, 18 Oct 2012 16:50:38 +0200 (CEST) 13711
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 18 Oct 2012 16:50:38 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208013>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

According to RFC 2047 and RFC 822, rfc2047 encoded words and and rfc822
quoted strings do not mix. Since add_rfc2047() no longer leaves RFC 822
specials behind, the quoting is also no longer necessary to create a
standard-conform mail.

Remove the quoting, when RFC 2047 encoding takes place. This actually
requires to refactor add_rfc2047() a bit, so that the different cases
can be distinguished.

With this patch, my own name gets correctly decoded as Jan H. Sch=C3=B6=
nherr
(without quotes) and not as "Jan H. Sch=C3=B6nherr" (with quotes).

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
v2:
- part of restructured patch 4 of v1
- use constants for both, the 76 and 78 char limit
- select correct maximum length for possible final folding
- removed off-by-one correction now handled by first patch
---
 pretty.c                | 49 ++++++++++++++++++++++++++++++++---------=
--------
 t/t4014-format-patch.sh |  2 +-
 2 Dateien ge=C3=A4ndert, 33 Zeilen hinzugef=C3=BCgt(+), 18 Zeilen entf=
ernt(-)

diff --git a/pretty.c b/pretty.c
index 613e4ea..413e758 100644
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
@@ -329,25 +329,29 @@ static int is_rfc2047_special(char ch, enum rfc20=
47_type type)
 	return !(isalnum(ch) || ch =3D=3D '!' || ch =3D=3D '*' || ch =3D=3D '=
+' || ch =3D=3D '-' || ch =3D=3D '/');
 }
=20
-static void add_rfc2047(struct strbuf *sb, const char *line, int len,
-		       const char *encoding, enum rfc2047_type type)
+static int needs_rfc2047_encoding(const char *line, int len,
+				  enum rfc2047_type type)
 {
-	static const int max_length =3D 78; /* per rfc2822 */
-	static const int max_encoded_length =3D 76; /* per rfc2047 */
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
-	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, max_length);
-	return;
=20
-needquote:
+	return 0;
+}
+
+static void add_rfc2047(struct strbuf *sb, const char *line, int len,
+		       const char *encoding, enum rfc2047_type type)
+{
+	static const int max_encoded_length =3D 76; /* per rfc2047 */
+	int i;
+	int line_len =3D last_line_length(sb);
+
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
@@ -383,6 +387,7 @@ void pp_user_info(const struct pretty_print_context=
 *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	int max_length =3D 78; /* per rfc2822 */
 	char *date;
 	int namelen;
 	unsigned long time;
@@ -406,17 +411,21 @@ void pp_user_info(const struct pretty_print_conte=
xt *pp,
 			name_tail--;
 		display_name_length =3D name_tail - line;
 		strbuf_addstr(sb, "From: ");
-		if (!has_rfc822_specials(line, display_name_length)) {
+		if (needs_rfc2047_encoding(line, display_name_length, RFC2047_ADDRES=
S)) {
 			add_rfc2047(sb, line, display_name_length,
 						encoding, RFC2047_ADDRESS);
-		} else {
+			max_length =3D 76; /* per rfc2047 */
+		} else if (needs_rfc822_quoting(line, display_name_length)) {
 			struct strbuf quoted =3D STRBUF_INIT;
 			add_rfc822_quoted(&quoted, line, display_name_length);
-			add_rfc2047(sb, quoted.buf, quoted.len,
-						encoding, RFC2047_ADDRESS);
+			strbuf_add_wrapped_bytes(sb, quoted.buf, quoted.len,
+							-6, 1, max_length);
 			strbuf_release(&quoted);
+		} else {
+			strbuf_add_wrapped_bytes(sb, line, display_name_length,
+							-6, 1, max_length);
 		}
-		if (namelen - display_name_length + last_line_length(sb) > 78) {
+		if (namelen - display_name_length + last_line_length(sb) > max_lengt=
h) {
 			strbuf_addch(sb, '\n');
 			if (!isspace(name_tail[0]))
 				strbuf_addch(sb, ' ');
@@ -1336,6 +1345,7 @@ void pp_title_line(const struct pretty_print_cont=
ext *pp,
 		   const char *encoding,
 		   int need_8bit_cte)
 {
+	static const int max_length =3D 78; /* per rfc2047 */
 	struct strbuf title;
=20
 	strbuf_init(&title, 80);
@@ -1345,7 +1355,12 @@ void pp_title_line(const struct pretty_print_con=
text *pp,
 	strbuf_grow(sb, title.len + 1024);
 	if (pp->subject) {
 		strbuf_addstr(sb, pp->subject);
-		add_rfc2047(sb, title.buf, title.len, encoding, RFC2047_SUBJECT);
+		if (needs_rfc2047_encoding(title.buf, title.len, RFC2047_SUBJECT))
+			add_rfc2047(sb, title.buf, title.len,
+						encoding, RFC2047_SUBJECT);
+		else
+			strbuf_add_wrapped_bytes(sb, title.buf, title.len,
+					 -last_line_length(sb), 1, max_length);
 	} else {
 		strbuf_addbuf(sb, &title);
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 727d606..e024eb8 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -839,7 +839,7 @@ test_expect_success 'format-patch uses rfc2047-enco=
ded from-headers when necessa
 cat >expect <<'EOF'
 From: =3D?UTF-8?q?F=3DC3=3DB6o=3D20B=3D2E=3D20Bar?=3D <author@example.=
com>
 EOF
-test_expect_failure 'rfc2047-encoded from-headers leave no rfc822 spec=
ials' '
+test_expect_success 'rfc2047-encoded from-headers leave no rfc822 spec=
ials' '
 	check_author "F=C3=B6o B. Bar"
 '
=20
--=20
1.7.12
