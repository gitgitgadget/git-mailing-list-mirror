From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/12] pretty: support padding placeholders, %< %> and %><
Date: Sat, 30 Mar 2013 16:35:10 +0700
Message-ID: <1364636112-15065-11-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsDI-0004Iy-Mq
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab3C3JgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:36:11 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:34731 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465Ab3C3JgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:36:10 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so482659dan.35
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1uzIM6yj+5TuRz9V7wApcxVSdk2OQO4tNvwAQxRcXcw=;
        b=0OnZAPcYT3rsKSkCt39m9IjZDYOn1+OxrNubqwxM0zArUlmTBAnKaI/18bFG/BIr1k
         pZWg88j7whigNWvFxFOAywZjjB7vBa2XDrby9zd+ijjwd9906AH46BYtt97o5t4z2q4E
         klXnBz4LB8nRZ2dmxFBaEFLiD4ZntRmjthPI+/pleqK5nXPAYM0W+GNYlUxtmCtCPh6h
         OiA3PlVeepmMHE8gfRywQiDFROXxWo+bBq0+dU5iHschG4lEwLdM2mTOGJ1XafoiTtPc
         wm5vEVQ32VsZ/Lm5raamfeGmbJ9V2sJmPe3J8yBrEdLAF4pFkI+biMAJMljnNPAN/NAn
         p1ZA==
X-Received: by 10.68.196.225 with SMTP id ip1mr7900930pbc.72.1364636169913;
        Sat, 30 Mar 2013 02:36:09 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id qd8sm5976484pbc.29.2013.03.30.02.36.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:36:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:36:14 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219579>

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
+++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 8734224..0ab1233 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -162,6 +162,14 @@ The placeholders are:
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
index c333fd6..233d69c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -760,12 +760,20 @@ struct chunk {
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
@@ -775,6 +783,7 @@ struct format_commit_context {
 	char *commit_encoding;
 	size_t width, indent1, indent2;
 	int auto_color;
+	int padding;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -1004,6 +1013,52 @@ static int format_reflog_person(struct strbuf *s=
b,
 	return format_person_part(sb, part, ident, strlen(ident), dmode);
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
@@ -1090,6 +1145,10 @@ static size_t format_commit_one(struct strbuf *s=
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
@@ -1247,6 +1306,59 @@ static size_t format_commit_one(struct strbuf *s=
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
@@ -1277,7 +1389,10 @@ static size_t format_commit_item(struct strbuf *=
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
--=20
1.8.2.83.gc99314b
