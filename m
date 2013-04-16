From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/13] pretty: support padding placeholders, %< %> and %><
Date: Tue, 16 Apr 2013 18:25:00 +1000
Message-ID: <1366100702-31745-12-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:27:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Ek-0007Tx-HY
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050Ab3DPI12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:27:28 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:54500 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3DPI1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:27:25 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so145691dae.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=MsECak1LRcIRGFhqBv/Oe9xTWNJYTXyTRtEf1/z2iAM=;
        b=awHb91GK6co2tvQ8bdMtzyMvISi2NU5C11xcmu+pz4KfcULmA3NfoIRIkdX3uIT022
         AAqmaniDzg/Ol40RE9qcBSgEnzs36tWl1YWLfA1uur8zUaNo7NReTQ+wmoyXJrK8p7yI
         RyeA014aGACt57UgnHFyX7A2+GQU1nglHrv31tObp5KlZx6+CwHcsJyN0rfcr4cNto2q
         hV3ui8Fr2ZhcUgYiFNsOJlssYJShNFKzJTiWWlcp3m7YVqtbhyJblUyNH1si6VRlfGMs
         ZsANNoT86gzfbVTe7tpCT/b94XoFHhwxPFsF2r+4uncrG8fVFIc40zEddHDexJV0fb/H
         5NKg==
X-Received: by 10.66.50.138 with SMTP id c10mr2214785pao.220.1366100845188;
        Tue, 16 Apr 2013 01:27:25 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id ux10sm1794405pab.1.2013.04.16.01.27.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:27:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:27:16 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221390>

Either %<, %> or %>< standing before a placeholder specifies how many
columns (at least as the placeholder can exceed it) it takes. Each
differs on how spaces are padded:

  %< pads on the right (aka left alignment)
  %> pads on the left (aka right alignment)
  %>< pads both ways equally (aka centered)

The (<N>) follows them, e.g. `%<(100)', to specify the number of
columns the next placeholder takes.

However, if '|' stands before (<N>), e.g. `%>|(100)', then the number
of columns is calculated so that it reaches the Nth column on screen.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |   8 +++
 pretty.c                         | 117 +++++++++++++++++++++++++++++++=
++++-
 t/t4205-log-pretty-formats.sh    | 126 +++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index bad627a..e2345d2 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -164,6 +164,14 @@ The placeholders are:
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option =
of
   linkgit:git-shortlog[1].
+- '%<(<N>)': make the next placeholder take at least N columns,
+  padding spaces on the right if necessary
+- '%<|(<N>)': make the next placeholder take at least until Nth
+  columns, padding spaces on the right if necessary
+- '%>(<N>)', '%>|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
+  respectively, but padding spaces on the left
+- '%><(<N>)', '%><|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
+  respectively, but padding both sides (i.e. the text is centered)
=20
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index f385176..7debfb2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -769,16 +769,25 @@ struct chunk {
 	size_t len;
 };
=20
+enum flush_type {
+	no_flush,
+	flush_right,
+	flush_left,
+	flush_both
+};
+
 struct format_commit_context {
 	const struct commit *commit;
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 	struct signature_check signature_check;
+	enum flush_type flush_type;
 	char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
 	int auto_color_next;
+	int padding;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -993,6 +1002,52 @@ static size_t parse_color(struct strbuf *sb, /* i=
n UTF-8 */
 		return 0;
 }
=20
+static size_t parse_padding_placeholder(struct strbuf *sb,
+					const char *placeholder,
+					struct format_commit_context *c)
+{
+	const char *ch =3D placeholder;
+	enum flush_type flush_type;
+	int to_column =3D 0;
+
+	switch (*ch++) {
+	case '<':
+		flush_type =3D flush_right;
+		break;
+	case '>':
+		if (*ch =3D=3D '<') {
+			flush_type =3D flush_both;
+			ch++;
+		} else
+			flush_type =3D flush_left;
+		break;
+	default:
+		return 0;
+	}
+
+	/* the next value means "wide enough to that column" */
+	if (*ch =3D=3D '|') {
+		to_column =3D 1;
+		ch++;
+	}
+
+	if (*ch =3D=3D '(') {
+		const char *start =3D ch + 1;
+		const char *end =3D strchr(start, ')');
+		char *next;
+		int width;
+		if (!end || end =3D=3D start)
+			return 0;
+		width =3D strtoul(start, &next, 10);
+		if (next =3D=3D start || width =3D=3D 0)
+			return 0;
+		c->padding =3D to_column ? -width : width;
+		c->flush_type =3D flush_type;
+		return end - placeholder + 1;
+	}
+	return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1052,6 +1107,10 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
 			return end - placeholder + 1;
 		} else
 			return 0;
+
+	case '<':
+	case '>':
+		return parse_padding_placeholder(sb, placeholder, c);
 	}
=20
 	/* these depend on the commit */
@@ -1214,6 +1273,59 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
 	return 0;	/* unknown placeholder */
 }
=20
+static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
+				    const char *placeholder,
+				    struct format_commit_context *c)
+{
+	struct strbuf local_sb =3D STRBUF_INIT;
+	int total_consumed =3D 0, len, padding =3D c->padding;
+	if (padding < 0) {
+		const char *start =3D strrchr(sb->buf, '\n');
+		int occupied;
+		if (!start)
+			start =3D sb->buf;
+		occupied =3D utf8_strnwidth(start, -1, 1);
+		padding =3D (-padding) - occupied;
+	}
+	while (1) {
+		int modifier =3D *placeholder =3D=3D 'C';
+		int consumed =3D format_commit_one(&local_sb, placeholder, c);
+		total_consumed +=3D consumed;
+
+		if (!modifier)
+			break;
+
+		placeholder +=3D consumed;
+		if (*placeholder !=3D '%')
+			break;
+		placeholder++;
+		total_consumed++;
+	}
+	len =3D utf8_strnwidth(local_sb.buf, -1, 1);
+	if (len > padding)
+		strbuf_addstr(sb, local_sb.buf);
+	else {
+		int sb_len =3D sb->len, offset =3D 0;
+		if (c->flush_type =3D=3D flush_left)
+			offset =3D padding - len;
+		else if (c->flush_type =3D=3D flush_both)
+			offset =3D (padding - len) / 2;
+		/*
+		 * we calculate padding in columns, now
+		 * convert it back to chars
+		 */
+		padding =3D padding - len + local_sb.len;
+		strbuf_grow(sb, padding);
+		strbuf_setlen(sb, sb_len + padding);
+		memset(sb->buf + sb_len, ' ', sb->len - sb_len);
+		memcpy(sb->buf + sb_len + offset, local_sb.buf,
+		       local_sb.len);
+	}
+	strbuf_release(&local_sb);
+	c->flush_type =3D no_flush;
+	return total_consumed;
+}
+
 static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 				 const char *placeholder,
 				 void *context)
@@ -1244,7 +1356,10 @@ static size_t format_commit_item(struct strbuf *=
sb, /* in UTF-8 */
 		placeholder++;
=20
 	orig_len =3D sb->len;
-	consumed =3D format_commit_one(sb, placeholder, context);
+	if (((struct format_commit_context *)context)->flush_type !=3D no_flu=
sh)
+		consumed =3D format_and_pad_commit(sb, placeholder, context);
+	else
+		consumed =3D format_commit_one(sb, placeholder, context);
 	if (magic =3D=3D NO_MAGIC)
 		return consumed;
=20
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 98a43d4..e9d7c2c 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -99,4 +99,130 @@ test_expect_failure 'NUL termination with --stat' '
 	test_i18ncmp expected actual
 '
=20
+test_expect_success 'setup more commits' '
+	test_commit "message one" one one message-one &&
+	test_commit "message two" two two message-two
+'
+
+delete_trailing_dollar() {
+	sed 's/\$$//'
+}
+
+test_expect_success 'left alignment formatting' '
+	git log --pretty=3D"format:%<(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+message two                             $
+message one                             $
+add bar                                 $
+initial                                 $
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %<|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+fa33ab1 message two                     $
+7cd6c63 message one                     $
+1711bf9 add bar                         $
+af20c06 initial                         $
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting with no padding' '
+	git log --pretty=3D"format:%<(1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF >expected &&
+message two
+message one
+add bar
+initial
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'right alignment formatting' '
+	git log --pretty=3D"format:%>(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+                             message two$
+                             message one$
+                                 add bar$
+                                 initial$
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'right alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %>|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+fa33ab1                      message two$
+7cd6c63                      message one$
+1711bf9                          add bar$
+af20c06                          initial$
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'right alignment formatting with no padding' '
+	git log --pretty=3D"format:%>(1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF >expected &&
+message two
+message one
+add bar
+initial
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'center alignment formatting' '
+	git log --pretty=3D"format:%><(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+              message two               $
+              message one               $
+                add bar                 $
+                initial                 $
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'center alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %><|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF | delete_trailing_dollar >expected &&
+fa33ab1           message two           $
+7cd6c63           message one           $
+1711bf9             add bar             $
+af20c06             initial             $
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'center alignment formatting with no padding' '
+	git log --pretty=3D"format:%><(1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF >expected &&
+message two
+message one
+add bar
+initial
+EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.2.82.gc24b958
