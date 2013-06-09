From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 09/15] for-each-ref: teach verify_format() about pretty's syntax
Date: Sun,  9 Jun 2013 23:24:28 +0530
Message-ID: <1370800474-8940-10-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljrb-0006hW-PF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab3FIR5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:57:00 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55685 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3FIR45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:57 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so672918pab.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fpflC1R2+EgH0cw7u2pRZTDkpPhzGOzMOlmLV/UlHkk=;
        b=e8mZCFT5uJWIamT3p816zIlpKT30Z6eJ/He0QaMNfoNOrFYObQpbr0zr4JkP3bcqG2
         5Ck+XwFbmAGW9deO+dwCRYiLQh/lZio9F3+Q+EhPkPiYWhYwwFC5jmzik47vV8ZrJHiX
         3faUBtoiWUMOB328G/mM4/r2O6zs+YVm9j6wz3GrcGFfSfnQMWti0IodHLawua1wPMde
         KkpIYFS07FE33MkTpBUUX61xf3FQhwOWf4KJEc6R6vX5ovfekiuX7TSzYfWsTPi0aIKs
         DCbnXCL7bzxZI0hlLvUWSbgQl/WWKZZW2u7HT3L275h7ZDDS6+t7cuKrFCGcKYYO+ZKx
         SwTw==
X-Received: by 10.68.113.194 with SMTP id ja2mr6738900pbb.65.1370800617306;
        Sun, 09 Jun 2013 10:56:57 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227065>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Pretty format accepts either ' ', '+' or '-' after '%' and before the
placeholder name to modify certain behaviors. Teach verify_format()
about this so that it finds atom "upstream" in, for example,
'% (upstream)'. This is important because verify_format populates
used_atom, which get_value() and populate_value() later rely on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 15 +++++++++------
 pretty.c               |  4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8611777..39454fb 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -150,7 +150,7 @@ static int parse_atom(const char *atom, const char =
*ep)
 /*
  * In a format string, find the next occurrence of %(atom).
  */
-static const char *find_next(const char *cp)
+static const char *find_next(const char *cp, int pretty)
 {
 	while (*cp) {
 		if (*cp =3D=3D '%') {
@@ -160,6 +160,9 @@ static const char *find_next(const char *cp)
 			 */
 			if (cp[1] =3D=3D '(')
 				return cp;
+			else if (pretty && cp[1] && cp[2] =3D=3D '(' &&
+				 strchr(" +-", cp[1])) /* see format_commit_item() */
+				return cp + 1;
 			else if (cp[1] =3D=3D '%')
 				cp++; /* skip over two % */
 			/* otherwise this is a singleton, literal % */
@@ -173,10 +176,10 @@ static const char *find_next(const char *cp)
  * Make sure the format string is well formed, and parse out
  * the used atoms.
  */
-static int verify_format(const char *format)
+static int verify_format(const char *format, int pretty)
 {
 	const char *cp, *sp;
-	for (cp =3D format; *cp && (sp =3D find_next(cp)); ) {
+	for (cp =3D format; *cp && (sp =3D find_next(cp, pretty)); ) {
 		const char *ep =3D strchr(sp, ')');
 		if (!ep)
 			return error("malformed format string %s", sp);
@@ -935,7 +938,7 @@ static void show_ref(struct strbuf *sb, struct refi=
nfo *info,
 {
 	const char *cp, *sp, *ep;
=20
-	for (cp =3D format; *cp && (sp =3D find_next(cp)); cp =3D ep + 1) {
+	for (cp =3D format; *cp && (sp =3D find_next(cp, 0)); cp =3D ep + 1) =
{
 		ep =3D strchr(sp, ')');
 		if (cp < sp)
 			emit(sb, cp, sp);
@@ -1098,8 +1101,8 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 	}
 	if (format !=3D default_format && pretty)
 		die("--format and --pretty cannot be used together");
-	if ((pretty && verify_format(pretty)) ||
-	    (!pretty && verify_format(format)))
+	if ((pretty && verify_format(pretty, 1)) ||
+	    (!pretty && verify_format(format, 0)))
 		usage_with_options(for_each_ref_usage, opts);
=20
 	if (!sort)
diff --git a/pretty.c b/pretty.c
index 816aa32..28c0a72 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1439,6 +1439,10 @@ static size_t format_commit_item(struct strbuf *=
sb, /* in UTF-8 */
 		ADD_SP_BEFORE_NON_EMPTY
 	} magic =3D NO_MAGIC;
=20
+	/*
+	 * Note: any modification in what placeholder[0] contains
+	 * should be redone in builtin/for-each-ref.c:find_next().
+	 */
 	switch (placeholder[0]) {
 	case '-':
 		magic =3D DEL_LF_BEFORE_EMPTY;
--=20
1.8.3.247.g485169c
