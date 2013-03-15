From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 40/45] parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
Date: Fri, 15 Mar 2013 13:06:55 +0700
Message-ID: <1363327620-29017-41-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:29:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO8Y-0008Dr-3A
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab3COG2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:28:40 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:60572 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab3COG2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:28:39 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so2873408iak.24
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tck/TRRp26BpejmDIu/OdRBee0I6MQMspxAKiG1QHwY=;
        b=mXVaTp/sWDsuPyIB6ZJowxU1kc/FaegW50/HpaGekYZcKuaZCTlzRuNg/myHZBEJoY
         m2l1cROvmBzu1CrB4l0N3+LVeEMJG93+hvq905dc8fRzYQXQBXrNYQvuD5qIeM+3UJbd
         Ta2Cb/DDwkepDFcTCvo0mkcIFizURQKH4vOsWblOEQqk65Iw87FCPwlEZ84d1ybh+Haj
         +8Avl/RY22Rf1pqCUwKDnqTyz2Pi4Ya4poVNnuamjjkvEZbpPCXRAze0Ek32fjAjfO4G
         LxfF8bwCrx+PrADGy3rBeWKsOTKsQX7bFeizEjtxX3t0h0KqO19q/war7uY4Qi0n1uIx
         vZZQ==
X-Received: by 10.50.173.6 with SMTP id bg6mr4236983igc.102.1363328918720;
        Thu, 14 Mar 2013 23:28:38 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id qn10sm618708igc.6.2013.03.14.23.28.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:38 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:41 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218227>

The prefix length is passed from one command to another via the new
magic 'prefix'. The magic is for parse_pathspec's internal use only,
not visible to parse_pathspec's callers.

Prefix length is not preserved across commands when --literal-pathspecs
is specified (no magic is allowed, including 'prefix'). That's OK
because we all paths are literal. No magic, no special treatment
regarding prefix. (This may be no longer true if we make :(glob)
default)

Other options to preserve the prefix include saving it to env variable
or quoting. Env var way (at least _one_ env var) is not suitable
because the prefix is not the same for all pathspecs. Pathspecs
starting with "../" will eat into the prefix part.

We could also preserve 'prefix' across commands is quote the prefix
part, then dequote on receiving. But it may not be 100% accurate, we
may dequote longer than the original prefix part, for example. That
may be good or not, but it's not the purpose.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index bc27692..3291b58 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -92,9 +92,9 @@ static unsigned prefix_pathspec(struct pathspec_item =
*item,
 				const char *elt)
 {
 	unsigned magic =3D 0, short_magic =3D 0;
-	const char *copyfrom =3D elt;
+	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
-	int i;
+	int i, pathspec_prefix =3D -1;
=20
 	if (elt[0] !=3D ':') {
 		; /* nothing to do */
@@ -111,18 +111,29 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 				nextat =3D copyfrom + len + 1;
 			if (!len)
 				continue;
-			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
+			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 				if (strlen(pathspec_magic[i].name) =3D=3D len &&
 				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
 					magic |=3D pathspec_magic[i].bit;
 					break;
 				}
+				if (!prefixcmp(copyfrom, "prefix:")) {
+					char *endptr;
+					pathspec_prefix =3D strtol(copyfrom + 7,
+								 &endptr, 10);
+					if (endptr - copyfrom !=3D len)
+						die("invalid parameter for pathspec magic 'prefix'");
+					/* "i" would be wrong, but it does not matter */
+					break;
+				}
+			}
 			if (ARRAY_SIZE(pathspec_magic) <=3D i)
 				die(_("Invalid pathspec magic '%.*s' in '%s'"),
 				    (int) len, copyfrom, elt);
 		}
 		if (*copyfrom !=3D ')')
 			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
+		long_magic_end =3D copyfrom;
 		copyfrom++;
 	} else {
 		/* shorthand */
@@ -149,7 +160,14 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	magic |=3D short_magic;
 	*p_short_magic =3D short_magic;
=20
-	if (magic & PATHSPEC_FROMTOP) {
+	if (pathspec_prefix >=3D 0 &&
+	    (prefixlen || (prefix && *prefix)))
+		die("BUG: 'prefix' magic is supposed to be used at worktree's root")=
;
+
+	if (pathspec_prefix >=3D 0) {
+		match =3D xstrdup(copyfrom);
+		prefixlen =3D pathspec_prefix;
+	} else if (magic & PATHSPEC_FROMTOP) {
 		match =3D xstrdup(copyfrom);
 		prefixlen =3D 0;
 	} else {
@@ -164,7 +182,20 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	 */
 	if (flags & PATHSPEC_PREFIX_ORIGIN) {
 		struct strbuf sb =3D STRBUF_INIT;
-		strbuf_add(&sb, elt, copyfrom - elt);
+		const char *start =3D elt;
+		if (prefixlen && !limit_pathspec_to_literal()) {
+			/* Preserve the actual prefix length of each pattern */
+			if (long_magic_end) {
+				strbuf_add(&sb, start, long_magic_end - start);
+				strbuf_addf(&sb, ",prefix:%d", prefixlen);
+				start =3D long_magic_end;
+			} else {
+				if (*start =3D=3D ':')
+					start++;
+				strbuf_addf(&sb, ":(prefix:%d)", prefixlen);
+			}
+		}
+		strbuf_add(&sb, start, copyfrom - start);
 		strbuf_addstr(&sb, match);
 		item->original =3D strbuf_detach(&sb, NULL);
 	} else
--=20
1.8.0.rc0.19.g7bbb31d
