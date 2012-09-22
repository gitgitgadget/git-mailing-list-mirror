From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] pretty: support padding placeholders, %< %> and %<>
Date: Sat, 22 Sep 2012 11:22:19 +0700
Message-ID: <1348287739-12128-7-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHFB-0003Pi-IH
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab2IVEWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab2IVEWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3905556pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YAPzut4KWmMOZ0JV7SL97k4yTBUnc2b0ZgQZT73bMrg=;
        b=JPE/0/V5wdAcX5Wt2pOjbXLpfH0XKeVitiW4n1Pl/ImbE/89sxyyFsTQHt/jJIKukC
         H+Qoecu/U3LSepXUzrUnJqtvLZ5g6iwAE6fCEKcMA3B56rCuuCyDT2kvxAR+BZpuVIOD
         y1QUVHo0kL1W6rmI1NGU0DseTSjih7MvbAbfBbq8+MwGmKqCiMAQGpy3tSEjzRiTAnaN
         k/a7XujQ9+Qfh4YjcKPQRWZPIQkJisSLDbyd4e59Tdone3ZiYfavvSM1Dzdv9HdCWe1I
         jtULjHRrf5poRYdmyj4PeTxRQ//pembayGg2H5iODZq6EHClWZhBUf+t/FpRxnLRoGoi
         GarA==
Received: by 10.68.189.70 with SMTP id gg6mr20624617pbc.125.1348287764432;
        Fri, 21 Sep 2012 21:22:44 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id kt1sm6095350pbc.45.2012.09.21.21.22.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:55 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206183>

Either %<, %> or %<> standing before a placeholder specifies how many
columns (at least as the placeholder can exceed it) it takes. Each
differs on how spaces are padded:

  %< pads on the right (aka left alignment)
  %> pads on the left (aka right alignment)
  %<> pads both ways equally (aka centered)

The (<N>) follows them, e.g. `%<(100)', to specify the number of
columns the next placeholder takes.

However, if '|' stands before (<N>), e.g. `%>|(100)', then the number
of columns is calculated so that it reaches the Nth column on screen.

TODO: %>> allows the next placeholder to eat the trailing spaces in
resulting string if it exceeds its allocated space. Maybe useful in
combination with %<(100)%s%>(40)%d, where spaces are wasted sometimes.

TODO: maybe support modifier '!' in addition to '|' above to cut
exceeding part in the next placeholder.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |   4 ++
 pretty.c                         | 106 +++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 8304325..7710ea8 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -149,6 +149,10 @@ The placeholders are:
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option =
of
   linkgit:git-shortlog[1].
+- '%<(<N>)': make the next placeholder take at least N columns, paddin=
g spaces on the right if necessary
+- '%<|(<N>)': make the next placeholder take at least until Nth column=
s, padding spaces on the right if necessary
+- '%>(<N>)', '%>|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respectively=
, but padding spaces on the left
+- '%<>(<N>)', '%<>|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respective=
ly, but padding both sides (i.e. the text is centered)
=20
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 45fe878..6662f52 100644
--- a/pretty.c
+++ b/pretty.c
@@ -617,12 +617,20 @@ struct chunk {
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
 	unsigned commit_signature_parsed:1;
+	enum flush_type flush_type;
 	struct {
 		char *gpg_output;
 		char good_bad;
@@ -631,6 +639,7 @@ struct format_commit_context {
 	char *message;
 	size_t width, indent1, indent2;
 	unsigned use_color;
+	int padding;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -916,6 +925,52 @@ static size_t parse_color_placeholder(struct strbu=
f *sb,
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
+		if (*ch =3D=3D '>') {
+			flush_type =3D flush_both;
+			ch++;
+		} else
+			flush_type =3D flush_right;
+		break;
+	case '>':
+		flush_type =3D flush_left;
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
 static size_t format_commit_one(struct strbuf *sb, const char *placeho=
lder,
 				void *context)
 {
@@ -966,6 +1021,10 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
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
@@ -1125,6 +1184,7 @@ static size_t format_commit_item(struct strbuf *s=
b, const char *placeholder,
 				 void *context)
 {
 	struct format_commit_context *c =3D context;
+	struct strbuf local_sb =3D STRBUF_INIT;
 	int consumed;
 	size_t orig_len;
 	enum {
@@ -1151,7 +1211,51 @@ static size_t format_commit_item(struct strbuf *=
sb, const char *placeholder,
 		placeholder++;
=20
 	orig_len =3D sb->len;
-	consumed =3D format_commit_one(sb, placeholder, context);
+	if (c->flush_type !=3D no_flush) {
+		int len, padding =3D c->padding;
+		if (padding < 0) {
+			const char *start =3D strrchr(sb->buf, '\n');
+			int occupied;
+			if (!start)
+				start =3D sb->buf;
+			occupied =3D utf8_strnwidth(start, -1, 1);
+			padding =3D (-padding) - occupied;
+		}
+		consumed =3D format_commit_one(&local_sb, placeholder, context);
+		len =3D utf8_strnwidth(local_sb.buf, -1, 1);
+		if (len >=3D padding)
+			/* Maybe we can trim the exceeded part */
+			strbuf_addstr(sb, local_sb.buf);
+		else {
+			int sb_len =3D sb->len, offset;
+			switch (c->flush_type) {
+			case flush_left:
+				offset =3D padding - len;
+				break;
+			case flush_right:
+				offset =3D 0;
+				break;
+			case flush_both:
+				offset =3D (padding - len) / 2;
+				break;
+			case no_flush: /* to make gcc happy */
+				break;
+			}
+			/*
+			 * we calculate padding in columns, now
+			 * convert it back to chars
+			 */
+			padding =3D padding - len + local_sb.len;
+			strbuf_grow(sb, padding);
+			strbuf_setlen(sb, sb_len + padding);
+			memset(sb->buf + sb_len, ' ', sb->len - sb_len);
+			memcpy(sb->buf + sb_len + offset, local_sb.buf,
+			       local_sb.len);
+		}
+		strbuf_release(&local_sb);
+		c->flush_type =3D no_flush;
+	} else
+		consumed =3D format_commit_one(sb, placeholder, context);
 	if (c->use_color)
 		c->use_color--;
 	if (magic =3D=3D NO_MAGIC)
--=20
1.7.12.1.384.g7b808e7
