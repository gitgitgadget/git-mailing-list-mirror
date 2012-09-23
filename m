From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/9] pretty: support padding placeholders, %< %> and %><
Date: Sun, 23 Sep 2012 16:10:31 +0700
Message-ID: <1348391433-11300-8-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiKG-0001Xm-Br
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab2IWJR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:17:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab2IWJR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:17:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5429111pbb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lE9CqA9O7Td7R1luThcMjiKkJec2z4LFkjKR23zc/L0=;
        b=gDqNAc5J4d/eBkZq6DfxC7RArLN/kyPkCPJjMIJJvNzPKCosmmo20VFSWAQGcea+RG
         VL83tgUxmEH6hMtaRLgBIC2aLkvp3Sa7QxHWfajuuxkJS0L07ehTGSTRfCG2bMNbgZJB
         g9vEUh/enEax3ObuKPk0bsK1OiBgPv+iDRmmUGBdTXkL4Pk5+Oe097n7qB+B6Ch4eDIM
         S3do/Vu/tTd58jAxmxN3dp3EBX9AIopvG33JirWhLmtsBpRkvIp21u73qkXmG1QRGouy
         XpZgJCoBVUK8gKiejG6Hau8jpuHpQFjjq8jxJoZpwpwXushvTK6RTyB0lXxWUqLo7ffp
         JxxA==
Received: by 10.68.135.196 with SMTP id pu4mr28579983pbb.11.1348391878427;
        Sun, 23 Sep 2012 02:17:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id sr3sm7850237pbc.44.2012.09.23.02.17.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:17:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:11:15 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206232>

Either %<, %> or %<> standing before a placeholder specifies how many
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
 Documentation/pretty-formats.txt |   4 ++
 pretty.c                         | 113 +++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index c706556..49d29ab 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -152,6 +152,10 @@ The placeholders are:
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
+- '%><(<N>)', '%><|(<N>)': similar to '%<(<N<)', '%<|(<N<)' respective=
ly, but padding both sides (i.e. the text is centered)
=20
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index f3275a7..d169673 100644
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
@@ -967,6 +1022,10 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
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
@@ -1122,6 +1181,55 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
 	return 0;	/* unknown placeholder */
 }
=20
+static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
+				    const char *placeholder,
+				    struct format_commit_context *c)
+{
+	struct strbuf local_sb =3D STRBUF_INIT;
+	int consumed, len, padding =3D c->padding;
+	if (padding < 0) {
+		const char *start =3D strrchr(sb->buf, '\n');
+		int occupied;
+		if (!start)
+			start =3D sb->buf;
+		occupied =3D utf8_strnwidth(start, -1, 1);
+		padding =3D (-padding) - occupied;
+	}
+	consumed =3D format_commit_one(&local_sb, placeholder, c);
+	len =3D utf8_strnwidth(local_sb.buf, -1, 1);
+	if (len > padding)
+		strbuf_addstr(sb, local_sb.buf);
+	else {
+		int sb_len =3D sb->len, offset;
+		switch (c->flush_type) {
+		case flush_left:
+			offset =3D padding - len;
+			break;
+		case flush_right:
+			offset =3D 0;
+			break;
+		case flush_both:
+			offset =3D (padding - len) / 2;
+			break;
+		case no_flush: /* to make gcc happy */
+			break;
+		}
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
+	return consumed;
+}
+
 static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 				 const char *placeholder,
 				 void *context)
@@ -1153,7 +1261,10 @@ static size_t format_commit_item(struct strbuf *=
sb, /* in UTF-8 */
 		placeholder++;
=20
 	orig_len =3D sb->len;
-	consumed =3D format_commit_one(sb, placeholder, context);
+	if (c->flush_type !=3D no_flush)
+		consumed =3D format_and_pad_commit(sb, placeholder, context);
+	else
+		consumed =3D format_commit_one(sb, placeholder, context);
 	if (c->use_color)
 		c->use_color--;
 	if (magic =3D=3D NO_MAGIC)
--=20
1.7.12.1.406.g6ab07c4
