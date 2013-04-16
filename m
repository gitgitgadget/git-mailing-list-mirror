From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/13] pretty: support truncating in %>, %< and %><
Date: Tue, 16 Apr 2013 18:25:01 +1000
Message-ID: <1366100702-31745-13-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Et-0007go-LR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab3DPI1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:27:38 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38770 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab3DPI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:27:37 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so223054pab.4
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=knfm5QpROsjIFV94DbrP5zVZHNavsO5KXreYJO+tpvQ=;
        b=ERF6+lsTpFKZfN+ET2Pc4uGu5affRGMYbgjO05scrqm1/dE1xOaA4gFAR2//wzmCKn
         YueZWgxpbdFLRmcVdxs/NPJ2WTJcIur7wQ4xKCKg98tLEYzra13ngXuYsJCjKDvzj7ft
         RkGQuFYE52sXzBcI6d+HStjk7Q/wWw8aX2jzMl86Mf//AfDZwJAQeJWM+OmhNx1tN3Xx
         BbmS3tVoLKLLsLji3WbWd+6uMijzpGu4YnLtZBJZsIUtVP6croOkeNWcvRkcR/PbHdeY
         eEXmCQX1+zDIRSn3wk0gbTk0VsMOjIB4ztVE4JCX2a83/egPbzgVPHxacfb9zRe0vHKh
         +Mqg==
X-Received: by 10.66.88.105 with SMTP id bf9mr2247801pab.175.1366100857096;
        Tue, 16 Apr 2013 01:27:37 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id aj2sm1237158pbc.1.2013.04.16.01.27.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:27:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:27:23 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221391>

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
index 7debfb2..a6c029c 100644
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
@@ -1302,9 +1327,29 @@ static size_t format_and_pad_commit(struct strbu=
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
index e9d7c2c..d1e9677 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -147,6 +147,45 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting with trunc' '
+	git log --pretty=3D"format:%<(10,trunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+message ..$
+message ..$
+add bar   $
+initial   $
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting with ltrunc' '
+	git log --pretty=3D"format:%<(10,ltrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+..sage two$
+..sage one$
+add bar   $
+initial   $
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting with mtrunc' '
+	git log --pretty=3D"format:%<(10,mtrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+mess.. two$
+mess.. one$
+add bar   $
+initial   $
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting' '
 	git log --pretty=3D"format:%>(40)%s" >actual &&
 	# complete the incomplete line at the end
diff --git a/utf8.c b/utf8.c
index ac630bc..0428e76 100644
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
