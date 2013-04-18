From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 12/13] pretty: support truncating in %>, %< and %><
Date: Fri, 19 Apr 2013 09:08:51 +1000
Message-ID: <1366326532-28517-13-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxyM-0008HX-KX
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967333Ab3DRXK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:10:29 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56022 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966999Ab3DRXK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:10:28 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1884938pab.38
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+PScoQi1DZmz1qpQlVFVkvKLLK2KR408Oyu7j4XDMfM=;
        b=yRX5htBrHf9T7TNdj8l7I6Ti+8BIWFhpZYHqLC8E7HTilQQrtfyzvwFRGXyk0fqPIu
         XFJh821Y9DXr99x5M5O0LBV5HpMaa3MU6qLPAmVl6Z/iJHG0AQkT3hy8nDcSUfaKZ3rF
         EL5NeQu+J4SdrUk/bM03gWdKaQnNPcUcRX7UR9fkDOVfIrFfZGTY7VJagvKZtxsQNiy+
         YRXeQan+4VGqJ8g+m6RGPRNiqKJThJ8HXS83KZQEa/WHE1LzVJlnzYsactHM7n27KON8
         yV1XW8zsmbfDSHLep0vD0Y9aLEhVq7ehkwBMgHnLM8XC7TBMYoqs10NDq0qGGfe5vKkA
         oxkg==
X-Received: by 10.66.245.105 with SMTP id xn9mr2598607pac.35.1366326627598;
        Thu, 18 Apr 2013 16:10:27 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id ra9sm12358694pab.16.2013.04.18.16.10.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:10:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:10:17 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221714>

%>(N,trunc) truncates the right part after N columns and replace the
last two letters with "..". ltrunc does the same on the left. mtrunc
cuts the middle out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  7 ++++--
 pretty.c                         | 51 ++++++++++++++++++++++++++++++++=
+++++---
 t/t4205-log-pretty-formats.sh    | 39 ++++++++++++++++++++++++++++++
 utf8.c                           | 46 ++++++++++++++++++++++++++++++++=
++++
 utf8.h                           |  2 ++
 5 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index e2345d2..d3450bf 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -164,8 +164,11 @@ The placeholders are:
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
+  Note that truncating only works correctly with N >=3D 2.
 - '%<|(<N>)': make the next placeholder take at least until Nth
   columns, padding spaces on the right if necessary
 - '%>(<N>)', '%>|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
diff --git a/pretty.c b/pretty.c
index b50ebf5..f7c6442 100644
--- a/pretty.c
+++ b/pretty.c
@@ -776,6 +776,13 @@ enum flush_type {
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
@@ -783,6 +790,7 @@ struct format_commit_context {
 	unsigned commit_message_parsed:1;
 	struct signature_check signature_check;
 	enum flush_type flush_type;
+	enum trunc_type truncate;
 	char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
@@ -1033,7 +1041,7 @@ static size_t parse_padding_placeholder(struct st=
rbuf *sb,
=20
 	if (*ch =3D=3D '(') {
 		const char *start =3D ch + 1;
-		const char *end =3D strchr(start, ')');
+		const char *end =3D start + strcspn(start, ",)");
 		char *next;
 		int width;
 		if (!end || end =3D=3D start)
@@ -1043,6 +1051,23 @@ static size_t parse_padding_placeholder(struct s=
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
@@ -1309,9 +1334,29 @@ static size_t format_and_pad_commit(struct strbu=
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
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 88f2427..b8685b9 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -143,6 +143,45 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting with trunc' '
+	git log --pretty=3D"format:%<(10,trunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+message ..
+message ..
+add bar  Z
+initial  Z
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting with ltrunc' '
+	git log --pretty=3D"format:%<(10,ltrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+..sage two
+..sage one
+add bar  Z
+initial  Z
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting with mtrunc' '
+	git log --pretty=3D"format:%<(10,mtrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+mess.. two
+mess.. one
+add bar  Z
+initial  Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting' '
 	git log --pretty=3D"format:%>(40)%s" >actual &&
 	# complete the incomplete line at the end
diff --git a/utf8.c b/utf8.c
index 7c342ff..197414a 100644
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
index a43ef9a..edde8ee 100644
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
1.8.2.82.gc24b958
