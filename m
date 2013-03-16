From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/12] pretty: two phase conversion for non utf-8 commits
Date: Sat, 16 Mar 2013 09:24:39 +0700
Message-ID: <1363400683-14813-9-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:32:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgvO-0001W0-Kn
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab3CPCcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:32:20 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39480 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab3CPCcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:32:19 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so4566680pbb.32
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=S88JcDAOoTmK2ht/RSdi1jfgRVt86JIILF2pCTT9oDw=;
        b=w4stXcGXHbug7uf6w1DLMGOKldspR4d/H9/LuJL6w498fl4hta+SWNWkfc2XBr/adH
         XiJ7itrcqPWU6YNHdz4eCeBsM4i4QEFgv8fNZmHsRNwMOPnrFC8IPeUNLbUToqGfUo9D
         n0fcqsuILD6ISM3x5ubgOdGATr4bOLrddHqNei3LDilt0pdIjgbMM9kIUkKfYXT8x+Jo
         WAONIu7KetNzMEOotMW2ztIafgM7zFfpnTqMtGgBhYXbSrEGxPu7zcDyI7RgBiIe2DtE
         H4BqalM3BQ2RREZy/denrTnaVIsnBENoDUA2FnFuSAe29EFwKcMNsgFOKxQIS3HOhtDy
         6x4g==
X-Received: by 10.68.129.197 with SMTP id ny5mr21449192pbb.110.1363400740687;
        Fri, 15 Mar 2013 19:25:40 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id y13sm11524156pbv.0.2013.03.15.19.25.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:25:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:35 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218283>

Always assume format_commit_item() takes an utf-8 string for string
handling simplicity (we can handle utf-8 strings, but can't with other
encodings).

If commit message is in non-utf8, or output encoding is not, then the
commit is first converted to utf-8, processed, then output converted
to output encoding. This of course only works with encodings that are
compatible with Unicode.

This also fixes the iso8859-1 test in t6006. It's supposed to create
an iso8859-1 commit, but the commit content in t6006 is in UTF-8.
t6006 is now converted back in UTF-8 (the downside is we can't put
utf-8 strings there anymore).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c                   | 24 ++++++++++++++++++++++--
 t/t6006-rev-list-format.sh | 12 ++++++------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/pretty.c b/pretty.c
index 092dd1d..3f4809a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1003,7 +1003,8 @@ static int format_reflog_person(struct strbuf *sb=
,
 	return format_person_part(sb, part, ident, strlen(ident), dmode);
 }
=20
-static size_t format_commit_one(struct strbuf *sb, const char *placeho=
lder,
+static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
+				const char *placeholder,
 				void *context)
 {
 	struct format_commit_context *c =3D context;
@@ -1235,7 +1236,8 @@ static size_t format_commit_one(struct strbuf *sb=
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
 	int consumed;
@@ -1315,6 +1317,7 @@ void format_commit_message(const struct commit *c=
ommit,
 {
 	struct format_commit_context context;
 	const char *output_enc =3D pretty_ctx->output_encoding;
+	const char *utf8 =3D "UTF-8";
=20
 	memset(&context, 0, sizeof(context));
 	context.commit =3D commit;
@@ -1327,6 +1330,23 @@ void format_commit_message(const struct commit *=
commit,
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
=20
+	if (output_enc) {
+		if (same_encoding(utf8, output_enc))
+			output_enc =3D NULL;
+	} else {
+		if (context.commit_encoding &&
+		    !same_encoding(context.commit_encoding, utf8))
+			output_enc =3D context.commit_encoding;
+	}
+
+	if (output_enc) {
+		int outsz;
+		char *out =3D reencode_string(sb->buf, sb->len,
+					    output_enc, utf8, &outsz);
+		if (out)
+			strbuf_attach(sb, out, outsz, outsz + 1);
+	}
+
 	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
 	free(context.signature.gpg_output);
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 3fc3b74..0393c9f 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -184,7 +184,7 @@ Test printing of complex bodies
=20
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+include an iso8859 character: =A1bueno!
 EOF
 test_expect_success 'setup complex body' '
 git config i18n.commitencoding iso8859-1 &&
@@ -192,14 +192,14 @@ git config i18n.commitencoding iso8859-1 &&
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
@@ -208,17 +208,17 @@ added foo
 EOF
=20
 test_format complex-body %b <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+include an iso8859 character: =A1bueno!
=20
 commit 131a310eb913d107dd3c09a65d1651175898735d
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 EOF
=20
 test_expect_success '%x00 shows NUL' '
-	echo  >expect commit f58db70b055c5718631e5c61528b28b12090cdea &&
+	echo  >expect commit 1ed88da4a5b5ed8c449114ac131efc62178734c3 &&
 	echo >>expect fooQbar &&
 	git rev-list -1 --format=3Dfoo%x00bar HEAD >actual.nul &&
 	nul_to_q <actual.nul >actual &&
--=20
1.8.2.83.gc99314b
