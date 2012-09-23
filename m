From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] pretty: support %>> that steal trailing spaces
Date: Sun, 23 Sep 2012 16:10:33 +0700
Message-ID: <1348391433-11300-10-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiKW-0001jJ-6F
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab2IWJSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:18:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab2IWJSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:18:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5429111pbb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BqXghPzAgrHvC9sF+47/AhwLhRvK88MBkkmOzschADg=;
        b=y2670rcAEpUW5l1CaN/r+pvnkCkiICs+PRvbe+6mjTKDGa12xAUb4nRO7NaJOry11g
         rQsfVmE3kpJExcgNj8eesbIdewc1W/VQ90N5w5J16Y2AMQvsNRwZjgldpbj5LdWMie1X
         KXD5kK3Ucqbk1EKDik7bH6oDVsFcKqzifViY2iWJ3lnfUWK5PPj9xS8rwLMaJb+UT3Nh
         YLg4+MDaGTbe8PkSdXHq3ttIW6O7flCKipWVoZqHTsRAe9ci7Vow32Z7aLqO4xrQpWiY
         osEPRaoYohvLwXrnV23GoRS1x7IJMn0p69RpcViQr5uQyEA1QHAUUGE21aIx4eKUUU//
         y/DQ==
Received: by 10.68.129.131 with SMTP id nw3mr28487435pbb.43.1348391894118;
        Sun, 23 Sep 2012 02:18:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id b6sm6917447paz.9.2012.09.23.02.18.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:18:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:11:27 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206234>

This is pretty useful in `%<(100)%s%Cred%>(20)% an' where %s does not
use up all 100 columns and %an needs more than 20 columns. By
replacing %>(20) with %>>(20), %an can steal spaces from %s.

%>> understands escape sequences, so %Cred does not stop it from
stealing spaces in %<(100).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  4 +++-
 pretty.c                         | 35 ++++++++++++++++++++++++++++++++=
+++
 utf8.c                           |  2 +-
 utf8.h                           |  1 +
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 3f056dc..e752da0 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -155,7 +155,9 @@ The placeholders are:
 - '%<(<N>[,trunc|ltrunc|mtrunc])': make the next placeholder take at l=
east N columns, padding spaces on the right if necessary
 - '%<|(<N>)': make the next placeholder take at least until Nth column=
s, padding spaces on the right if necessary
 - '%>(<N>)', '%>|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respectively=
, but padding spaces on the left
-- '%><(<N>)', '%><|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respective=
ly, but padding both sides (i.e. the text is centered)
+- '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N<)', '%>|(<N<)' respective=
ly, except that if the next placeholder takes more spaces than given an=
d there are spaces on its left, use those spaces
+- '%><(<N>)', '%><|(<N>)': similar to '%
+<(<N<)', '%<|(<N<)' respectively, but padding both sides (i.e. the tex=
t is centered)
=20
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 673193e..deeacf2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -621,6 +621,7 @@ enum flush_type {
 	no_flush,
 	flush_right,
 	flush_left,
+	flush_left_and_steal,
 	flush_both
 };
=20
@@ -949,6 +950,9 @@ static size_t parse_padding_placeholder(struct strb=
uf *sb,
 		if (*ch =3D=3D '<') {
 			flush_type =3D flush_both;
 			ch++;
+		} else if (*ch =3D=3D '>') {
+			flush_type =3D flush_left_and_steal;
+			ch++;
 		} else
 			flush_type =3D flush_left;
 		break;
@@ -1222,6 +1226,36 @@ static size_t format_and_pad_commit(struct strbu=
f *sb, /* in UTF-8 */
 	}
 	consumed =3D format_commit_one(&local_sb, placeholder, c);
 	len =3D utf8_strnwidth(local_sb.buf, -1, 1);
+
+	if (c->flush_type =3D=3D flush_left_and_steal) {
+		const char *ch =3D sb->buf + sb->len - 1;
+		while (len > padding && ch > sb->buf) {
+			const char *p;
+			if (*ch =3D=3D ' ') {
+				ch--;
+				padding++;
+				continue;
+			}
+			/* check for trailing ansi sequences */
+			if (*ch !=3D 'm')
+				break;
+			p =3D ch - 1;
+			while (ch - p < 10 && *p !=3D '\033')
+				p--;
+			if (*p !=3D '\033' ||
+			    ch + 1 - p !=3D display_mode_esc_sequence_len(p))
+				break;
+			/*
+			 * got a good ansi sequence, put it back to
+			 * local_sb as we're cutting sb
+			 */
+			strbuf_insert(&local_sb, 0, p, ch + 1 - p);
+			ch =3D p - 1;
+		}
+		strbuf_setlen(sb, ch + 1 - sb->buf);
+		c->flush_type =3D flush_left;
+	}
+
 	if (len > padding) {
 		switch (c->truncate) {
 		case trunc_left:
@@ -1256,6 +1290,7 @@ static size_t format_and_pad_commit(struct strbuf=
 *sb, /* in UTF-8 */
 		case flush_both:
 			offset =3D (padding - len) / 2;
 			break;
+		case flush_left_and_steal:
 		case no_flush: /* to make gcc happy */
 			break;
 		}
diff --git a/utf8.c b/utf8.c
index 095c5ff..6af288d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,7 +9,7 @@ struct interval {
   int last;
 };
=20
-static size_t display_mode_esc_sequence_len(const char *s)
+size_t display_mode_esc_sequence_len(const char *s)
 {
 	const char *p =3D s;
 	if (*p++ !=3D '\033')
diff --git a/utf8.h b/utf8.h
index 0451a70..758a1ed 100644
--- a/utf8.h
+++ b/utf8.h
@@ -3,6 +3,7 @@
=20
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
=20
+size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, int len, int skip_ansi);
 int utf8_strwidth(const char *string);
--=20
1.7.12.1.406.g6ab07c4
