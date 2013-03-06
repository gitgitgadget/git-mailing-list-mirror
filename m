From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] format-patch: RFC 2047 says multi-octet character may not be split
Date: Wed,  6 Mar 2013 15:08:26 +0400
Message-ID: <1362568106-30741-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Komissarov <dak@mnsspb.ru>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 12:09:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDCDk-0003cM-0t
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 12:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab3CFLIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 06:08:50 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:55258 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757107Ab3CFLIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 06:08:49 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1UDCDD-0005vR-DH; Wed, 06 Mar 2013 15:08:43 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1UDCDA-00080o-EM; Wed, 06 Mar 2013 15:08:40 +0400
X-Mailer: git-send-email 1.8.2.rc2.353.gd2380b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217515>

Intro
-----

In 'Subject:' characters are encoded in Q encoding, as per RFC 2047, e.=
g.

    f=C3=B6=C3=B6

becomes

    =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB6?=3D

=2E Long encoded lines must be wrapped to be no longer than 76 bytes.

Also RFC 2047, section 5 (3) says:

    Each 'encoded-word' MUST represent an integral number of
    characters.  A multi-octet character may not be split across
    adjacent 'encoded- word's.

that means that for

    Subject: .... f=C3=B6=C3=B6 bar

encoding

    Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
     =3D?UTF-8?q?=3D20bar?=3D

is correct, and

    Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3?=3D      <-- NOTE =C3=
=B6 is broken here
     =3D?UTF-8?q?=3DB6=3D20bar?=3D

is not, because "=C3=B6" character UTF-8 encoding C3 B6 is split here a=
cross
adjacent encoded words.

~~~~

As it is now, format-patch does not respect "multi-octet charactes may
not be split" rule, and so sending patches with non-english subject has
issues:

    The problematic case shows in mail readers as ".... f=C3=B6?? bar".

Solution
--------

I introduce mbs_chrlen() function to compute character length in bytes
for multi-byte text according to encoding, and use it appropriately in
add_rfc2047() in pretty.

So far it works correctly only for UTF-8 encoding, because we have
infrastructure for it in place already, but other encoding could be
supported too in the future with the help of iconv. For now they all, e=
xcept
UTF-8, are treated as being one-byte encodings, which was format-patch
current behaviour, with appropriate TODO put in mbs_chrlen().

Not sure whether mbs_chrlen() is a good name, but otherwise my
understanding is that the patch is ok to go in.

Thanks.

Cc: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 pretty.c                | 27 +++++++++++++++++++--------
 t/t4014-format-patch.sh | 27 ++++++++++++++-------------
 utf8.c                  | 39 +++++++++++++++++++++++++++++++++++++++
 utf8.h                  |  2 ++
 4 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/pretty.c b/pretty.c
index b57adef..c9c7ff5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -345,7 +345,7 @@ static int needs_rfc2047_encoding(const char *line,=
 int len,
 	return 0;
 }
=20
-static void add_rfc2047(struct strbuf *sb, const char *line, int len,
+static void add_rfc2047(struct strbuf *sb, const char *line, size_t le=
n,
 		       const char *encoding, enum rfc2047_type type)
 {
 	static const int max_encoded_length =3D 76; /* per rfc2047 */
@@ -355,9 +355,18 @@ static void add_rfc2047(struct strbuf *sb, const c=
har *line, int len,
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
-	for (i =3D 0; i < len; i++) {
-		unsigned ch =3D line[i] & 0xFF;
-		int is_special =3D is_rfc2047_special(ch, type);
+
+	while (len) {
+		/*
+		 * RFC 2047, section 5 (3):
+		 *
+		 * Each 'encoded-word' MUST represent an integral number of
+		 * characters.  A multi-octet character may not be split across
+		 * adjacent 'encoded- word's.
+		 */
+		const unsigned char *p =3D (const unsigned char *)line;
+		int chrlen =3D mbs_chrlen(&line, &len, encoding);
+		int is_special =3D (chrlen > 1) || is_rfc2047_special(*p, type);
=20
 		/*
 		 * According to RFC 2047, we could encode the special character
@@ -367,16 +376,18 @@ static void add_rfc2047(struct strbuf *sb, const =
char *line, int len,
 		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
 		 */
=20
-		if (line_len + 2 + (is_special ? 3 : 1) > max_encoded_length) {
+		if (line_len + 2 + (is_special ? 3*chrlen : 1) > max_encoded_length)=
 {
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
 			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
 		}
=20
 		if (is_special) {
-			strbuf_addf(sb, "=3D%02X", ch);
-			line_len +=3D 3;
+			for (i =3D 0; i < chrlen; i++) {
+				strbuf_addf(sb, "=3D%02X", p[i]);
+				line_len +=3D 3;
+			}
 		} else {
-			strbuf_addch(sb, ch);
+			strbuf_addch(sb, *p);
 			line_len++;
 		}
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 78633cb..b993dae 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -837,25 +837,26 @@ Subject: [PATCH] =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB=
6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar?=3D
 EOF
 test_expect_success 'format-patch wraps extremely long subject (rfc204=
7)' '
 	rm -rf patches/ &&
diff --git a/utf8.c b/utf8.c
index 8f6e84b..7911b58 100644
--- a/utf8.c
+++ b/utf8.c
@@ -531,3 +531,42 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 	return out;
 }
 #endif
+
+/*
+ * Returns first character length in bytes for multi-byte `text` accor=
ding to
+ * `encoding`.
+ *
+ * - The `text` pointer is updated to point at the next character.
+ * - When `remainder_p` is not NULL, on entry `*remainder_p` is how mu=
ch bytes
+ *   we can consume from text, and on exit `*remainder_p` is reduced b=
y returned
+ *   character length. Otherwise `text` is treated as limited by NUL.
+ */
+int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding)
+{
+	int chrlen;
+	const char *p =3D *text;
+	size_t r =3D (remainder_p ? *remainder_p : INT_MAX);
+
+	if (r < 1)
+		return 0;
+
+	if (is_encoding_utf8(encoding)) {
+		pick_one_utf8_char(&p, &r);
+
+		chrlen =3D p ? (p - *text)
+			   : 1 /* not valid UTF-8 -> raw byte sequence */;
+	}
+	else {
+		/* TODO use iconv to decode one char and obtain its chrlen
+		 *
+		 * for now, let's treat encodings !=3D UTF-8 as one-byte
+		 */
+		chrlen =3D 1;
+	}
+
+	*text +=3D chrlen;
+	if (remainder_p)
+		*remainder_p -=3D chrlen;
+
+	return chrlen;
+}
diff --git a/utf8.h b/utf8.h
index 501b2bd..1f8ecad 100644
--- a/utf8.h
+++ b/utf8.h
@@ -22,4 +22,6 @@ char *reencode_string(const char *in, const char *out=
_encoding, const char *in_e
 #define reencode_string(a,b,c) NULL
 #endif
=20
+int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding);
+
 #endif
--=20
1.8.2.rc2.353.gd2380b4
