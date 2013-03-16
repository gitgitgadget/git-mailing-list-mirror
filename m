From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/12] pretty: support %>> that steal trailing spaces
Date: Sat, 16 Mar 2013 09:24:43 +0700
Message-ID: <1363400683-14813-13-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgpP-0003Lm-3X
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab3CPC0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:26:06 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62193 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab3CPC0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:26:05 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so4595486pbc.36
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Pov4ZoFZD8tAQrW5RZU63DH98M425876TgyJ6VBdGAg=;
        b=EH5udxKq/8hik2nJA1g3Iw2FeGFbkUDjy1EbwicVrR6yniVQEoISRnI7RfD/YiSB8h
         ndZhMnjc/b8axut4IS5gu+uXUbmdqwRBpECbOYSG9LW1fueRP3qS86sWF7dlRlvBm669
         h2SCsjeghr5fx04vRE2sKOfvT1ZogeReZ6reBe1vOvvnCXb96TOihoKOYPz0PQHEuOnB
         4xqCx1iuZDT1QYv+MTpqef4x/07sdo06oL/fxhDPqkzBNoD3GzWLZU9DCZFN/JWUxfIT
         /gxBWsV5OcDtW/C7Mz92L3ngDaf9g1Lk6JKe6N+DXh2MeiWn2z2/PyWiTAoVxknxlPeO
         DcmA==
X-Received: by 10.68.221.68 with SMTP id qc4mr21463176pbc.152.1363400765015;
        Fri, 15 Mar 2013 19:26:05 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id na4sm11520112pbc.8.2013.03.15.19.26.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:26:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218281>

This is pretty useful in `%<(100)%s%Cred%>(20)% an' where %s does not
use up all 100 columns and %an needs more than 20 columns. By
replacing %>(20) with %>>(20), %an can steal spaces from %s.

%>> understands escape sequences, so %Cred does not stop it from
stealing spaces in %<(100).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  5 ++++-
 pretty.c                         | 34 ++++++++++++++++++++++++++++++++=
++
 utf8.c                           |  2 +-
 utf8.h                           |  1 +
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 17f82f4..036c14a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -170,7 +170,10 @@ The placeholders are:
   columns, padding spaces on the right if necessary
 - '%>(<N>)', '%>|(<N>)': similar to '%<(<N<)', '%<|(<N<)'
   respectively, but padding spaces on the left
-- '%><(<N>)', '%><|(<N>)': similar to '%<(<N<)', '%<|(<N<)'
+- '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N<)', '%>|(<N<)'
+  respectively, except that if the next placeholder takes more spaces
+  than given and there are spaces on its left, use those spaces
+- '%><(<N>)', '%><|(<N>)': similar to '% <(<N<)', '%<|(<N<)'
   respectively, but padding both sides (i.e. the text is centered)
=20
 NOTE: Some placeholders may depend on other options given to the
diff --git a/pretty.c b/pretty.c
index 29384b5..892274d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -764,6 +764,7 @@ enum flush_type {
 	no_flush,
 	flush_right,
 	flush_left,
+	flush_left_and_steal,
 	flush_both
 };
=20
@@ -1037,6 +1038,9 @@ static size_t parse_padding_placeholder(struct st=
rbuf *sb,
 		if (*ch =3D=3D '<') {
 			flush_type =3D flush_both;
 			ch++;
+		} else if (*ch =3D=3D '>') {
+			flush_type =3D flush_left_and_steal;
+			ch++;
 		} else
 			flush_type =3D flush_left;
 		break;
@@ -1360,6 +1364,36 @@ static size_t format_and_pad_commit(struct strbu=
f *sb, /* in UTF-8 */
 		total_consumed++;
 	}
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
diff --git a/utf8.c b/utf8.c
index 766df80..414ae49 100644
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
index faf2f91..e913edb 100644
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
1.8.2.83.gc99314b
