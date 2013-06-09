From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/45] parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
Date: Sun,  9 Jun 2013 13:26:13 +0700
Message-ID: <1370759178-1709-41-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ7p-0001vN-FP
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab3FIG3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:29:09 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42414 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab3FIG3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:29:07 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so1765230pac.40
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tu9jUh6qQkRdcg6Nw9hfcNRbURwdxIabUvg4DvLNz0w=;
        b=lZn/174HYD7E7KELsMc7L5m2AzAuKWpjBsysWMZ2TEmLyVjBX8oadFU00R5vhO9TzF
         K8qhXLxxPO+jdj4A0V/dnR6Vq/BpEJHjeXmzWQWBuQ3QPdU6KL2/6bBrYAQhsU8KCti4
         o8HfW/x1oZCuDC+SdokVpkLaJCyZjI8hzEHjNd0GnIP/6SKXdXXdEDxMmIq2e+D230md
         6/31nJNnn38pvIC60tXmCyRFt6rjYIfOdZXMxen9ROgETXKjsiJbM9QO3ZnhR1vuDHFR
         79MPrFiWdigxRYpJKsha75QKDr7ueSuUYSCU5eA+Ne6/kO3wqPji0hCgfARWTnbCJn0N
         nhfg==
X-Received: by 10.67.5.168 with SMTP id cn8mr9361178pad.119.1370759346794;
        Sat, 08 Jun 2013 23:29:06 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id ag4sm5532459pbc.20.2013.06.08.23.29.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:29:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:30:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226932>

The prefix length is passed from one command to another via the new
magic 'prefix'. The magic is for parse_pathspec's internal use only,
not visible to parse_pathspec's callers.

Prefix length is not preserved across commands when --literal-pathspecs
is specified (no magic is allowed, including 'prefix'). That's OK
because we know all paths are literal. No magic, no special treatment
regarding prefix. (This may be no longer true if we make :(glob)
default)

Other options to preserve the prefix include saving it to env variable
or quoting. Env var way (at least _one_ env var) is not suitable
because the prefix is not the same for all pathspecs. Pathspecs
starting with "../" will eat into the prefix part.

We could also preserve 'prefix' across commands by quoting the prefix
part, then dequoting on receiving. But it may not be 100% accurate, we
may dequote longer than the original prefix part, for example. That
may be good or not, but it's not the purpose.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index e2ee268..2bd400a 100644
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
@@ -112,18 +112,29 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 				nextat =3D copyfrom + len;
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
+						die(_("invalid parameter for pathspec magic 'prefix'"));
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
@@ -150,7 +161,14 @@ static unsigned prefix_pathspec(struct pathspec_it=
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
@@ -165,7 +183,20 @@ static unsigned prefix_pathspec(struct pathspec_it=
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
1.8.2.83.gc99314b
