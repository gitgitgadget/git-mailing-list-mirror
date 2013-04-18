From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 08/13] pretty: two phase conversion for non utf-8 commits
Date: Fri, 19 Apr 2013 09:08:47 +1000
Message-ID: <1366326532-28517-9-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:10:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxxt-0007rp-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967341Ab3DRXKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:10:00 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:47670 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967289Ab3DRXJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:09:59 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so1847432pdi.15
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=b0QRidKlHnDZwF5VfrgB0hyMHaj1LKI5vBnah0wrq3I=;
        b=VxXYwX7nTQs36yJH4VVODq/6/wB8QbLBn7+xxJ79kvBuA3jJ+qZolUemuvBJeJYXst
         7JsA6jlTyxJ90oscYX16k6QLl6Yt88FleSXvyVCcua/47pyMy4IIjwmMO2/yhuDJ+Hco
         c/wPbh+3ZA9cMRpPdsbYcXrwzK3ZWiSkLQVlsFEDzELtFFYWCI+eGiYxQZCJxMZIb/JS
         p3z/dywZIlMopZ8tpC7Whj90CxIbevgjfbWYife8cmDTYCx9F0gSwbLA02nBMnMGHJYc
         A/LVteNXT8i4JofM3vW9HEKh0JDB8lZYytMzBvVdln2ZTIf4KWeRcE7sLCZG5S+iggRK
         +0xg==
X-Received: by 10.68.195.131 with SMTP id ie3mr15441587pbc.114.1366326598848;
        Thu, 18 Apr 2013 16:09:58 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id bs3sm11168384pbb.36.2013.04.18.16.09.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:09:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:09:48 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221710>

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
index e0f93ba..5947275 100644
--- a/pretty.c
+++ b/pretty.c
@@ -954,7 +954,8 @@ static int format_reflog_person(struct strbuf *sb,
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
@@ -1193,7 +1194,8 @@ static size_t format_commit_one(struct strbuf *sb=
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
@@ -1273,6 +1275,7 @@ void format_commit_message(const struct commit *c=
ommit,
 {
 	struct format_commit_context context;
 	const char *output_enc =3D pretty_ctx->output_encoding;
+	const char *utf8 =3D "UTF-8";
=20
 	memset(&context, 0, sizeof(context));
 	context.commit =3D commit;
@@ -1285,6 +1288,23 @@ void format_commit_message(const struct commit *=
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
+		char *out =3D reencode_string_len(sb->buf, sb->len,
+						output_enc, utf8, &outsz);
+		if (out)
+			strbuf_attach(sb, out, outsz, outsz + 1);
+	}
+
 	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
 	free(context.signature_check.gpg_output);
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
1.8.2.82.gc24b958
