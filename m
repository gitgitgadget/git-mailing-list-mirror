From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/9] pretty: support truncating in %>, %< and %><
Date: Sun, 23 Sep 2012 16:10:32 +0700
Message-ID: <1348391433-11300-9-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:18:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiKO-0001dQ-8O
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab2IWJSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:18:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2IWJSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:18:04 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5429111pbb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RtLHhb8PgQM+9T0v/F73jAdO2NuBgpXVaRlCzoRcRUc=;
        b=dcqdrD+bMUuENV2qCWM6fEfmv6sz4qYXNhn69xm0u2tXSWibGhclvOEDrez5RJV4Xq
         PmEaKik5foqUZoIEvDBCW0h++qCBxIqJvm3qW6TVPCAb8zhihR55Q7Ep1xMllglp8p7q
         FUh74tDYmsZ/Al4ZZWxapuQuU03Q0v0HcIYEujiYz4ac9wfvdwmf4HskzKSHT0etCkXh
         UeLn3l2hQL6fE7HEC35QUvT+P/KQwpnDkLKwF6oF08ufNmCLV6q/lEpRN2TJ60Gv31d4
         wqm3gKVwNLkqCT8eRfzt1HmEyz3AFKJm+xruOU38xVuBbHMiuGESG/jjjTiX4kac7x4m
         IjUg==
Received: by 10.66.79.166 with SMTP id k6mr24911969pax.44.1348391884229;
        Sun, 23 Sep 2012 02:18:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id rz10sm7848877pbc.32.2012.09.23.02.18.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:18:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:11:21 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206233>

%>(N,trunc) truncates the righ part after N columns and replace the
last two letters with "..". ltrunc does the same on the left. mtrunc
cuts the middle out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  2 +-
 pretty.c                         | 51 ++++++++++++++++++++++++++++++++=
+++++---
 utf8.c                           | 46 ++++++++++++++++++++++++++++++++=
++++
 utf8.h                           |  2 ++
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 49d29ab..3f056dc 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -152,7 +152,7 @@ The placeholders are:
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option =
of
   linkgit:git-shortlog[1].
-- '%<(<N>)': make the next placeholder take at least N columns, paddin=
g spaces on the right if necessary
+- '%<(<N>[,trunc|ltrunc|mtrunc])': make the next placeholder take at l=
east N columns, padding spaces on the right if necessary
 - '%<|(<N>)': make the next placeholder take at least until Nth column=
s, padding spaces on the right if necessary
 - '%>(<N>)', '%>|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respectively=
, but padding spaces on the left
 - '%><(<N>)', '%><|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respective=
ly, but padding both sides (i.e. the text is centered)
diff --git a/pretty.c b/pretty.c
index d169673..673193e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -624,6 +624,13 @@ enum flush_type {
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
@@ -631,6 +638,7 @@ struct format_commit_context {
 	unsigned commit_message_parsed:1;
 	unsigned commit_signature_parsed:1;
 	enum flush_type flush_type;
+	enum trunc_type truncate;
 	struct {
 		char *gpg_output;
 		char good_bad;
@@ -956,7 +964,7 @@ static size_t parse_padding_placeholder(struct strb=
uf *sb,
=20
 	if (*ch =3D=3D '(') {
 		const char *start =3D ch + 1;
-		const char *end =3D strchr(start, ')');
+		const char *end =3D start + strcspn(start, ",)");
 		char *next;
 		int width;
 		if (!end || end =3D=3D start)
@@ -966,6 +974,23 @@ static size_t parse_padding_placeholder(struct str=
buf *sb,
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
@@ -1197,9 +1222,29 @@ static size_t format_and_pad_commit(struct strbu=
f *sb, /* in UTF-8 */
 	}
 	consumed =3D format_commit_one(&local_sb, placeholder, c);
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
 		int sb_len =3D sb->len, offset;
 		switch (c->flush_type) {
 		case flush_left:
diff --git a/utf8.c b/utf8.c
index 791499e..095c5ff 100644
--- a/utf8.c
+++ b/utf8.c
@@ -422,6 +422,52 @@ int strbuf_add_wrapped_bytes(struct strbuf *buf, c=
onst char *data, int len,
 	return r;
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
index 58d5b6b..0451a70 100644
--- a/utf8.h
+++ b/utf8.h
@@ -13,6 +13,8 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 int strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int=
 len,
 			     int indent, int indent2, int width);
+void strbuf_utf8_replace(struct strbuf *sb, int pos, int width,
+			 const char *subst);
=20
 #ifndef NO_ICONV
 char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)=
;
--=20
1.7.12.1.406.g6ab07c4
