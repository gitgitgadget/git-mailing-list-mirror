From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/15] for-each-ref: teach verify_format() about pretty's syntax
Date: Tue,  4 Jun 2013 18:05:31 +0530
Message-ID: <1370349337-20938-10-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRv-0007Oz-6b
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab3FDMeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:34:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53250 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab3FDMeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so311704pad.19
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JUIEcza6gvnPNTjRBDCMPwRa5jiAW0QEDjCM763j0xQ=;
        b=sueUecIp/NX1crjiJwCyl4jRZkwrSS4mA5h9cxwGyN12b8DVdE8hnmokUaMn2jDd19
         AskNAvBP4Dgv76RAZplMd22XZsUTWcQ058LEdaA30UWJW3qzJB6uq76URzIDE72OBRhP
         9vVOcXNiZTk0eKBtfQBCEBTQwmHVrZ+QZ+E7k48MIZGn8p7/pgfqhpH1GJHgTe/WuNI8
         9ryx7J/GlbW2+pYJy15oJ6PobIs1mgALKCshjHhWuefrhowUNCNbgw+1955S65xbEyWw
         v2uHyNh+ELk+JsYsEkco14T8TKArpoH9ie87yOCCnX9wlv6WkFjQz0jgjUcZOrkg0WZT
         r4rw==
X-Received: by 10.68.191.36 with SMTP id gv4mr28692605pbc.67.1370349255919;
        Tue, 04 Jun 2013 05:34:15 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226357>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Pretty format accepts either ' ', '+' or '-' after '%' and before the
placeholder name to modify certain behaviors. Teach verify_format()
about this so that it finds atom "upstream" in, for example,
'% (upstream)'. This is important because verify_format populates
used_atom, which get_value() and populate_value() later rely on.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 15 +++++++++------
 pretty.c               |  4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 576a882..f8a3880 100644
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
@@ -1093,8 +1096,8 @@ int cmd_for_each_ref(int argc, const char **argv,=
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
1.8.3.GIT
