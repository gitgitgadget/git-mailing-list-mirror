From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/15] for-each-ref: teach verify_format() about pretty's syntax
Date: Tue,  9 Jul 2013 16:02:20 +0530
Message-ID: <1373365946-9230-10-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHm-00074w-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab3GIKgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:39 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55562 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab3GIKgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:36 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so5382546pbb.22
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lcJH9bvScKypeilmXpYE9PdJlfq2QkVPjskignV4w0I=;
        b=OAMNUqyKx7hcMtBQs+mE7WapJy+Aa3ch708OXKZJIK/Qrr0oekBC66S6rZi7HqIWM7
         CcTXeDujOAmFTG7Jno+RoLlWacaIY9w0QTabYU7jE0HcykZG6snBFJ/2rK3xmavqdN4s
         nJqHzchLFi+nQcR7YE50sJCj8cZVREeOTlRe0824cRw5cLtoJ4mDsT1PJyttC0sji9gg
         DlMIiCNLlLrvnNofutHS0+5N5qi6IU7RObcvIBmDt6aQOPaOCOt0EQ379EVWK4u+EH0G
         wo1T1NI4EzbWHKY1YxavOSeGIyKG2Ksl/ZK2QNoK9NrM5MdsILwHntUGeDixS/F8voFk
         EwZA==
X-Received: by 10.66.157.68 with SMTP id wk4mr27792191pab.17.1373366195803;
        Tue, 09 Jul 2013 03:36:35 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229937>

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
1.8.3.2.736.g869de25
