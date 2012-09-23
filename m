From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/9] pretty: two phase conversion for non utf-8 commits
Date: Sun, 23 Sep 2012 16:10:30 +0700
Message-ID: <1348391433-11300-7-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiKA-0001W5-Q6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab2IWJRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:17:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2IWJRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:17:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5429111pbb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F2ZJGsWmexmSzuzDjZ7pmAPm2UBdSENl5O9NSAGLDrk=;
        b=nZoj3Qb6VJqV9BHmZInC2u9YSlBf8DvcRCZTCcIZ6LzD+8QXTRpStlSsfl12pdfBNB
         bvJ6pLuDHZ6J12UoMpEz7LbC7PqzIYJ1bXFf/tzZa9W4cxFGHFT3//dsLPyRYbzfpdMx
         tN+/lk1uOgyVm+TRa7JGvz6BcO3qjqmjl/QZznlPlIn6iJkTU96rtDKucwAMI7wOz0nD
         XfGUZuAvhe+Cwi9ei/ewbp9nBgQgbdyW0/QA1CfG+V+32Hx1v8Ln8ZpJqE6S21YrFEa/
         dUepY1UIrNa4XRcvhnvcGBHWn0YC/UFf8fRWwg5wHeWAlUD6eWttk5OOfnMcRhfDIwA8
         iY6w==
Received: by 10.68.203.164 with SMTP id kr4mr2218555pbc.46.1348391872631;
        Sun, 23 Sep 2012 02:17:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id rr6sm1251820pbc.47.2012.09.23.02.17.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:17:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:11:10 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206231>

Always assume format_commit_item() takes an utf-8 string for
simplicity. If commit message is in non-utf8, or output encoding is
not, then the commit is first converted to utf-8, processed, then
output converted to output encoding.

This of course only works with encodings that are compatible with
Unicode.

This also fixes the iso8859-1 test. It's supposed to create an
iso8859-1 commit, but the commit content in t6006-rev-list-format.sh
is in UTF-8. Split the content out in a separate file (so its encoding
won't accidentally be converted) and convert it back to iso8859-1.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c                     | 29 +++++++++++++++++++----------
 t/t6006-rev-list-format.sh   | 16 +++++-----------
 t/t6006/commit-msg.iso8859-1 |  5 +++++
 3 files changed, 29 insertions(+), 21 deletions(-)
 create mode 100644 t/t6006/commit-msg.iso8859-1

diff --git a/pretty.c b/pretty.c
index 45fe878..f3275a7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -916,7 +916,8 @@ static size_t parse_color_placeholder(struct strbuf=
 *sb,
 	return 0;
 }
=20
-static size_t format_commit_one(struct strbuf *sb, const char *placeho=
lder,
+static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
+				const char *placeholder,
 				void *context)
 {
 	struct format_commit_context *c =3D context;
@@ -1121,7 +1122,8 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
 	return 0;	/* unknown placeholder */
 }
=20
-static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
+static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
+				 const char *placeholder,
 				 void *context)
 {
 	struct format_commit_context *c =3D context;
@@ -1205,25 +1207,32 @@ void format_commit_message(const struct commit =
*commit,
 	struct format_commit_context context;
 	static const char utf8[] =3D "UTF-8";
 	const char *output_enc =3D pretty_ctx->output_encoding;
+	char *enc;
=20
 	memset(&context, 0, sizeof(context));
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
 	context.message =3D commit->buffer;
-	if (output_enc) {
-		char *enc =3D get_header(commit, "encoding");
-		if (strcmp(enc ? enc : utf8, output_enc)) {
-			context.message =3D logmsg_reencode(commit, output_enc);
-			if (!context.message)
-				context.message =3D commit->buffer;
-		}
-		free(enc);
+	enc =3D get_header(commit, "encoding");
+	if (enc && strcmp(utf8, enc)) {
+		context.message =3D reencode_string(context.message, utf8, enc);
+		if (!context.message)
+			context.message =3D commit->buffer;
 	}
+	free(enc);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
=20
+	if (output_enc && strcmp(utf8, output_enc)) {
+		char *out =3D reencode_string(sb->buf, output_enc, utf8);
+		if (out) {
+			int len =3D strlen(out);
+			strbuf_attach(sb, out, len, len + 1);
+		}
+	}
+
 	if (context.message !=3D commit->buffer)
 		free(context.message);
 	free(context.signature.gpg_output);
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f94f0c4..cd24839 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -124,27 +124,21 @@ commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 =1B[1;31;43mfoo=1B[m
 EOF
=20
-cat >commit-msg <<'EOF'
-Test printing of complex bodies
-
-This commit message is much longer than the others,
-and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
-EOF
+cat "$TEST_DIRECTORY/t6006/commit-msg.iso8859-1" >commit-msg
 test_expect_success 'setup complex body' '
 git config i18n.commitencoding iso8859-1 &&
   echo change2 >foo && git commit -a -F commit-msg
 '
=20
 test_format complex-encoding %e <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
 iso8859-1
 commit 131a310eb913d107dd3c09a65d1651175898735d
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 EOF
=20
 test_format complex-subject %s <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
 Test printing of complex bodies
 commit 131a310eb913d107dd3c09a65d1651175898735d
 changed foo
@@ -153,7 +147,7 @@ added foo
 EOF
=20
 test_format complex-body %b <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
 include an iso8859 character: =C2=A1bueno!
@@ -163,7 +157,7 @@ commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 EOF
=20
 test_expect_success '%x00 shows NUL' '
-	echo  >expect commit f58db70b055c5718631e5c61528b28b12090cdea &&
+	echo  >expect commit 1ed88da4a5b5ed8c449114ac131efc62178734c3 &&
 	echo >>expect fooQbar &&
 	git rev-list -1 --format=3Dfoo%x00bar HEAD >actual.nul &&
 	nul_to_q <actual.nul >actual &&
diff --git a/t/t6006/commit-msg.iso8859-1 b/t/t6006/commit-msg.iso8859-=
1
new file mode 100644
index 0000000..f8fe808
--- /dev/null
+++ b/t/t6006/commit-msg.iso8859-1
@@ -0,0 +1,5 @@
+Test printing of complex bodies
+
+This commit message is much longer than the others,
+and it will be encoded in iso8859-1. We should therefore
+include an iso8859 character: =A1bueno!
--=20
1.7.12.1.406.g6ab07c4
