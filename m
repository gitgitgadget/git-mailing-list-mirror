From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH] git-for-each-ref: move GPG sigs off %(body) to %(signature).
Date: Tue, 30 Aug 2011 10:57:21 +0200
Message-ID: <1314694641-24148-1-git-send-email-mgorny@gentoo.org>
References: <20110829213757.GB14299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 10:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyK7O-00062Q-9u
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 10:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1H3I4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 04:56:20 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:38283 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab1H3I4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 04:56:19 -0400
Received: from localhost.localdomain (unknown [81.219.203.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 895D51B4160;
	Tue, 30 Aug 2011 08:56:17 +0000 (UTC)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <20110829213757.GB14299@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180396>

When grabbing a %(body) or %(contents) off a tag, one doesn't really
expect to get the GPG signature as well (as it's basically useless
without the complete signed text). Thus, strip it off those two tags,
and make available via %(signature) if anyone needs it.

Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
---
 Documentation/git-for-each-ref.txt |    3 ++-
 builtin/for-each-ref.c             |   35 ++++++++++++++++++++++++++++=
+------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 152e695..7145c46 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -103,7 +103,8 @@ and `date` to extract the named component.
=20
 The first line of the message in a commit and tag object is
 `subject`, the remaining lines are `body`.  The whole message
-is `contents`.
+is `contents`.  If the message is GPG-signed, the signature is
+`signature`.
=20
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89e75c6..fa5c292 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -10,6 +10,9 @@
 #include "parse-options.h"
 #include "remote.h"
=20
+/* Used to strip signature off body */
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----\n"
+
 /* Quoting styles */
 #define QUOTE_NONE 0
 #define QUOTE_SHELL 1
@@ -69,6 +72,7 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "signature" },
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
@@ -458,7 +462,7 @@ static void grab_person(const char *who, struct ato=
m_value *val, int deref, stru
 	}
 }
=20
-static void find_subpos(const char *buf, unsigned long sz, const char =
**sub, const char **body)
+static void find_subpos(const char *buf, unsigned long sz, const char =
**sub, const char **body, const char **sig)
 {
 	while (*buf) {
 		const char *eol =3D strchr(buf, '\n');
@@ -478,18 +482,34 @@ static void find_subpos(const char *buf, unsigned=
 long sz, const char **sub, con
 	buf =3D strchr(buf, '\n');
 	if (!buf) {
 		*body =3D "";
+		*sig =3D *body;
 		return; /* no body */
 	}
 	while (*buf =3D=3D '\n')
 		buf++; /* skip blank between subject and body */
 	*body =3D buf;
+	*sig =3D *body;
+
+	/* look for GPG signature */
+	while (*buf) {
+		const char *eol =3D strchr(buf, '\n');
+		if (!eol) {
+			*sig =3D buf + strlen(buf);
+			return;
+		}
+		if (!strncmp(eol + 1, PGP_SIGNATURE, ARRAY_SIZE(PGP_SIGNATURE)-1)) {
+			*sig =3D eol + 1;
+			break; /* found end of body */
+		}
+		buf =3D eol + 1;
+	}
 }
=20
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, =
struct object *obj, void *buf, unsigned long sz)
 {
 	int i;
-	const char *subpos =3D NULL, *bodypos =3D NULL;
+	const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
=20
 	for (i =3D 0; i < used_atom_cnt; i++) {
 		const char *name =3D used_atom[i];
@@ -500,19 +520,22 @@ static void grab_sub_body_contents(struct atom_va=
lue *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "contents"))
+		    strcmp(name, "contents") &&
+		    strcmp(name, "signature"))
 			continue;
 		if (!subpos)
-			find_subpos(buf, sz, &subpos, &bodypos);
+			find_subpos(buf, sz, &subpos, &bodypos, &sigpos);
 		if (!subpos)
 			return;
=20
 		if (!strcmp(name, "subject"))
 			v->s =3D copy_line(subpos);
 		else if (!strcmp(name, "body"))
-			v->s =3D xstrdup(bodypos);
+			v->s =3D xstrndup(bodypos, sigpos - bodypos);
 		else if (!strcmp(name, "contents"))
-			v->s =3D xstrdup(subpos);
+			v->s =3D xstrndup(subpos, sigpos - subpos);
+		else if (!strcmp(name, "signature"))
+			v->s =3D xstrdup(sigpos);
 	}
 }
=20
--=20
1.7.6.1
