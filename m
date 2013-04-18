From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 11/13] pretty: support padding placeholders, %< %> and %><
Date: Fri, 19 Apr 2013 09:08:50 +1000
Message-ID: <1366326532-28517-12-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxyH-0008Dh-3L
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967285Ab3DRXKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:10:22 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:39483 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966999Ab3DRXKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:10:21 -0400
Received: by mail-da0-f41.google.com with SMTP id p8so1494587dan.28
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=8Emss/sRB33Li7jCRKGasSUIrne1X7XeAJ+eIbrjC3c=;
        b=SMzvRgkhI2ocK7dzFWDL627iunZcQ8N12N/rwl0JBKe0fS6SrdpcH6f2CjQlt/moid
         BT22Q5ngipp2lvY/+OwJkz9nB1sXd56xcuHxG0bNZLj33bTmRyQUxjYPmBsDU9zFgqps
         +NqJaUh2zo1xm13g8Y7rJZQtaq9IZjtrhqBV3A1d21LQs/b1nl9ABwTABzOrgVOujxOW
         Vkseb66xAI7DtsD8V2SqXm4KFryFEexLPr3a7GlAGfm3fij948f/182Cw1C59yPw81Tw
         qErrkQusl0hQRX64NEFZvxPVnRlOeQwecHWhd/0ABDrV3kS9sHwjaHlcVXdDtV3ia14R
         KxGQ==
X-Received: by 10.66.102.33 with SMTP id fl1mr15447356pab.52.1366326620500;
        Thu, 18 Apr 2013 16:10:20 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id g8sm12389951pae.7.2013.04.18.16.10.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:10:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:10:10 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221713>

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
+++++-
 t/t4205-log-pretty-formats.sh    | 122 +++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 246 insertions(+), 1 deletion(-)

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
index 3612f82..b50ebf5 100644
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
 	int auto_color;
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
@@ -1057,6 +1112,10 @@ static size_t format_commit_one(struct strbuf *s=
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
@@ -1221,6 +1280,59 @@ static size_t format_commit_one(struct strbuf *s=
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
@@ -1251,7 +1363,10 @@ static size_t format_commit_item(struct strbuf *=
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
index 98a43d4..88f2427 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -99,4 +99,126 @@ test_expect_failure 'NUL termination with --stat' '
 	test_i18ncmp expected actual
 '
=20
+test_expect_success 'setup more commits' '
+	test_commit "message one" one one message-one &&
+	test_commit "message two" two two message-two
+'
+
+test_expect_success 'left alignment formatting' '
+	git log --pretty=3D"format:%<(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+message two                            Z
+message one                            Z
+add bar                                Z
+initial                                Z
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'left alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %<|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+fa33ab1 message two                    Z
+7cd6c63 message one                    Z
+1711bf9 add bar                        Z
+af20c06 initial                        Z
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
+	qz_to_tab_space <<\EOF >expected &&
+Z                            message two
+Z                            message one
+Z                                add bar
+Z                                initial
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'right alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %>|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+fa33ab1                      message two
+7cd6c63                      message one
+1711bf9                          add bar
+af20c06                          initial
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
+	qz_to_tab_space <<\EOF >expected &&
+Z             message two              Z
+Z             message one              Z
+Z               add bar                Z
+Z               initial                Z
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'center alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %><|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<\EOF >expected &&
+fa33ab1           message two          Z
+7cd6c63           message one          Z
+1711bf9             add bar            Z
+af20c06             initial            Z
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
