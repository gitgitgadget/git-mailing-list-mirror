From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/12] pretty: support truncating in %>, %< and %><
Date: Sat, 30 Mar 2013 16:35:11 +0700
Message-ID: <1364636112-15065-12-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsDN-0004Rd-QP
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503Ab3C3JgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:36:17 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56387 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab3C3JgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:36:16 -0400
Received: by mail-pb0-f49.google.com with SMTP id um15so527719pbc.8
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CzmTM1HYoIqH8EilEOnIMfqhcoAer45g/RyHx8TwG30=;
        b=xj19eAL2V7fx8u8gG89YArtp4V4b1jlRywkmdFIj2AtZBa9wLba1Dsf5A+TLJATNH3
         +osLwcZVvec3MJqzjzQa/bfkqkNMWx4JxZKxrSeIFTI5LK/18+U2vSaaBlYOJdX9YpfJ
         vAfr/FuDjH+wj7T2dxH4UI1llUsQiSuthOJ9LuJ2rmfLWx9nVSO+LIamFI5+0UIxO1n6
         7tkCq6QWUsQSEB4Mhvu8c4ppEvTsBw1K0AclxFlGkf8DIRqUS//fHuwfavgL92IXZRph
         YPXLmI75dbIMGvtw9PGIhNQm/EF0kZRX34DuhtOcKwnGN5TcPHrjWUoGG2XY5tb4UhZB
         VGaQ==
X-Received: by 10.66.11.133 with SMTP id q5mr8775284pab.150.1364636175696;
        Sat, 30 Mar 2013 02:36:15 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id 1sm5972165pba.32.2013.03.30.02.36.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:36:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:36:21 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219580>

%>(N,trunc) truncates the right part after N columns and replace the
last two letters with "..". ltrunc does the same on the left. mtrunc
cuts the middle out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  6 +++--
 pretty.c                         | 51 ++++++++++++++++++++++++++++++++=
+++++---
 utf8.c                           | 46 ++++++++++++++++++++++++++++++++=
++++
 utf8.h                           |  2 ++
 4 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 0ab1233..f2df941 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -162,8 +162,10 @@ The placeholders are:
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option =
of
   linkgit:git-shortlog[1].
-- '%<(<N>)': make the next placeholder take at least N columns,
-  padding spaces on the right if necessary
+- '%<(<N>[,trunc|ltrunc|mtrunc])': make the next placeholder take at
+  least N columns, padding spaces on the right if necessary.
+  Optionally truncate at the beginning (ltrunc), the middle (mtrunc)
+  or the end (trunc) if the output is longer than N columns.
 - '%<|(<N>)': make the next placeholder take at least until Nth
   columns, padding spaces on the right if necessary
 - '%>(<N>)', '%>|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
diff --git a/pretty.c b/pretty.c
index 233d69c..29384b5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -767,6 +767,13 @@ enum flush_type {
 	flush_both
 };
=20
+enum trunc_type {
+	trunc_none,
+	trunc_left,
+	trunc_middle,
+	trunc_right
+};
+
 struct format_commit_context {
 	const struct commit *commit;
 	const struct pretty_print_context *pretty_ctx;
@@ -774,6 +781,7 @@ struct format_commit_context {
 	unsigned commit_message_parsed:1;
 	unsigned commit_signature_parsed:1;
 	enum flush_type flush_type;
+	enum trunc_type truncate;
 	struct {
 		char *gpg_output;
 		char good_bad;
@@ -1044,7 +1052,7 @@ static size_t parse_padding_placeholder(struct st=
rbuf *sb,
=20
 	if (*ch =3D=3D '(') {
 		const char *start =3D ch + 1;
-		const char *end =3D strchr(start, ')');
+		const char *end =3D start + strcspn(start, ",)");
 		char *next;
 		int width;
 		if (!end || end =3D=3D start)
@@ -1054,6 +1062,23 @@ static size_t parse_padding_placeholder(struct s=
trbuf *sb,
 			return 0;
 		c->padding =3D to_column ? -width : width;
 		c->flush_type =3D flush_type;
+
+		if (*end =3D=3D ',') {
+			start =3D end + 1;
+			end =3D strchr(start, ')');
+			if (!end || end =3D=3D start)
+				return 0;
+			if (!prefixcmp(start, "trunc)"))
+				c->truncate =3D trunc_right;
+			else if (!prefixcmp(start, "ltrunc)"))
+				c->truncate =3D trunc_left;
+			else if (!prefixcmp(start, "mtrunc)"))
+				c->truncate =3D trunc_middle;
+			else
+				return 0;
+		} else
+			c->truncate =3D trunc_none;
+
 		return end - placeholder + 1;
 	}
 	return 0;
@@ -1335,9 +1360,29 @@ static size_t format_and_pad_commit(struct strbu=
f *sb, /* in UTF-8 */
 		total_consumed++;
 	}
 	len =3D utf8_strnwidth(local_sb.buf, -1, 1);
-	if (len > padding)
+	if (len > padding) {
+		switch (c->truncate) {
+		case trunc_left:
+			strbuf_utf8_replace(&local_sb,
+					    0, len - (padding - 2),
+					    "..");
+			break;
+		case trunc_middle:
+			strbuf_utf8_replace(&local_sb,
+					    padding / 2 - 1,
+					    len - (padding - 2),
+					    "..");
+			break;
+		case trunc_right:
+			strbuf_utf8_replace(&local_sb,
+					    padding - 2, len - (padding - 2),
+					    "..");
+			break;
+		case trunc_none:
+			break;
+		}
 		strbuf_addstr(sb, local_sb.buf);
-	else {
+	} else {
 		int sb_len =3D sb->len, offset =3D 0;
 		if (c->flush_type =3D=3D flush_left)
 			offset =3D padding - len;
diff --git a/utf8.c b/utf8.c
index 9d98043..766df80 100644
--- a/utf8.c
+++ b/utf8.c
@@ -421,6 +421,52 @@ void strbuf_add_wrapped_bytes(struct strbuf *buf, =
const char *data, int len,
 	free(tmp);
 }
=20
+void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
+			 const char *subst)
+{
+	struct strbuf sb_dst =3D STRBUF_INIT;
+	char *src =3D sb_src->buf;
+	char *end =3D src + sb_src->len;
+	char *dst;
+	int w =3D 0, subst_len =3D 0;
+
+	if (subst)
+		subst_len =3D strlen(subst);
+	strbuf_grow(&sb_dst, sb_src->len + subst_len);
+	dst =3D sb_dst.buf;
+
+	while (src < end) {
+		char *old;
+		size_t n;
+
+		while ((n =3D display_mode_esc_sequence_len(src))) {
+			memcpy(dst, src, n);
+			src +=3D n;
+			dst +=3D n;
+		}
+
+		old =3D src;
+		n =3D utf8_width((const char**)&src, NULL);
+		if (!src) 	/* broken utf-8, do nothing */
+			return;
+		if (n && w >=3D pos && w < pos + width) {
+			if (subst) {
+				memcpy(dst, subst, subst_len);
+				dst +=3D subst_len;
+				subst =3D NULL;
+			}
+			w +=3D n;
+			continue;
+		}
+		memcpy(dst, old, src - old);
+		dst +=3D src - old;
+		w +=3D n;
+	}
+	strbuf_setlen(&sb_dst, dst - sb_dst.buf);
+	strbuf_attach(sb_src, strbuf_detach(&sb_dst, NULL),
+		      sb_dst.len, sb_dst.alloc);
+}
+
 int is_encoding_utf8(const char *name)
 {
 	if (!name)
diff --git a/utf8.h b/utf8.h
index 99db3e0..faf2f91 100644
--- a/utf8.h
+++ b/utf8.h
@@ -15,6 +15,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, in=
t len,
 			     int indent, int indent2, int width);
+void strbuf_utf8_replace(struct strbuf *sb, int pos, int width,
+			 const char *subst);
=20
 #ifndef NO_ICONV
 char *reencode_string_iconv(const char *in, size_t insz,
--=20
1.8.2.83.gc99314b
