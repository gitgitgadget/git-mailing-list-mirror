From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/25] pathspec: move getenv() code out of prefix_pathspec()
Date: Mon,  6 Apr 2015 20:52:32 +0700
Message-ID: <1428328354-14897-24-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:55:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Ub-0006JC-DI
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbbDFNzE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:55:04 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35294 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbDFNzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:55:03 -0400
Received: by pddn5 with SMTP id n5so45282799pdd.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zsjubunAkneYJUp6yPEDWSxI3AAFu+YiI1XIRP+LZFk=;
        b=uj0YyqCaOVCaavMVgz96Z1fDXPtjE2OZKVb6tKC+Tm24sw5sghZbevETT0OnYvexI0
         Fmd0sPgGG2Ivt94HlvYh183xY/b8sHnfmaD8B8JGv5fAk049TCasZcvf0VcMG78odANE
         Iqr+P8Jl9nkAuuyfhTVRsza3P/zS0GDgWYMWSda0ZcRO9T7cDmSNxbaJDlECP1m0T/HH
         UL+EEleiAAiXaDsGKTErSexxkCvRTkuq9hSo0O0oX8M0OQ0imPVyXuBqcm3uAAodUd5v
         886nRSWzcUf780WL5AA98WU2CuEJYxqJL2UCCnwBSYxQGDF3ocIZbzVeyBpY7QlpVcDV
         VJFg==
X-Received: by 10.68.100.161 with SMTP id ez1mr27194524pbb.81.1428328503108;
        Mon, 06 Apr 2015 06:55:03 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id qc9sm2775327pab.19.2015.04.06.06.55.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:55:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:55:14 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266868>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 55 +++++++++++++++++++++++++++---------------------------=
-
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 9304ee3..5573127 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,6 +88,13 @@ static void prefix_short_magic(struct strbuf *sb, in=
t prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
=20
+struct global_flags {
+	unsigned literal : 1;
+	unsigned glob : 1;
+	unsigned noglob : 1;
+	unsigned icase : 1;
+};
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -105,39 +112,20 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 				unsigned *p_short_magic,
 				const char **raw, unsigned flags,
 				const char *prefix, int prefixlen,
-				const char *elt)
+				const char *elt,
+				const struct global_flags *global)
 {
-	static int literal_global =3D -1;
-	static int glob_global =3D -1;
-	static int noglob_global =3D -1;
-	static int icase_global =3D -1;
 	unsigned magic =3D 0, short_magic =3D 0, global_magic =3D 0;
 	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
 	int i, pathspec_prefix =3D -1;
=20
-	if (literal_global < 0)
-		literal_global =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0=
);
-	if (literal_global)
+	if (global->literal)
 		global_magic |=3D PATHSPEC_LITERAL;
-
-	if (glob_global < 0)
-		glob_global =3D git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
-	if (glob_global)
+	if (global->glob)
 		global_magic |=3D PATHSPEC_GLOB;
-
-	if (noglob_global < 0)
-		noglob_global =3D git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, 0);
-
-	if (glob_global && noglob_global)
-		die(_("global 'glob' and 'noglob' pathspec settings are incompatible=
"));
-
-
-	if (icase_global < 0)
-		icase_global =3D git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
-	if (icase_global)
+	if (global->icase)
 		global_magic |=3D PATHSPEC_ICASE;
-
 	if ((global_magic & PATHSPEC_LITERAL) &&
 	    (global_magic & ~PATHSPEC_LITERAL))
 		die(_("global 'literal' pathspec setting is incompatible "
@@ -146,7 +134,8 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	if (flags & PATHSPEC_LITERAL_PATH)
 		global_magic =3D 0;
=20
-	if (elt[0] !=3D ':' || literal_global ||
+
+	if (elt[0] !=3D ':' || global->literal ||
 	    (flags & PATHSPEC_LITERAL_PATH)) {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
@@ -213,7 +202,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	*p_short_magic =3D short_magic;
=20
 	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
-	if (noglob_global && !(magic & PATHSPEC_GLOB))
+	if (global->noglob && !(magic & PATHSPEC_GLOB))
 		global_magic |=3D PATHSPEC_LITERAL;
=20
 	/* --glob-pathspec is overridden by :(literal) */
@@ -247,7 +236,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	 */
 	if (flags & PATHSPEC_PREFIX_ORIGIN) {
 		struct strbuf sb =3D STRBUF_INIT;
-		if (prefixlen && !literal_global) {
+		if (prefixlen && !global->literal) {
 			/* Preserve the actual prefix length of each pattern */
 			if (short_magic)
 				prefix_short_magic(&sb, prefixlen, short_magic);
@@ -365,6 +354,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	struct pathspec_item *item;
 	const char *entry =3D argv ? *argv : NULL;
 	int i, n, prefixlen, nr_exclude =3D 0;
+	struct global_flags global;
=20
 	memset(pathspec, 0, sizeof(*pathspec));
=20
@@ -401,6 +391,14 @@ void parse_pathspec(struct pathspec *pathspec,
 		return;
 	}
=20
+	memset(&global, 0, sizeof(global));
+	global.literal =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0)=
 !=3D 0;
+	global.glob    =3D git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT,    0)=
 !=3D 0;
+	global.noglob  =3D git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT,  0)=
 !=3D 0;
+	global.icase   =3D git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT,   0)=
 !=3D 0;
+	if (global.glob && global.noglob)
+		die(_("global 'glob' and 'noglob' pathspec settings are incompatible=
"));
+
 	n =3D 0;
 	while (argv[n])
 		n++;
@@ -416,7 +414,8 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 		item[i].magic =3D prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
-						prefix, prefixlen, entry);
+						prefix, prefixlen, entry,
+						&global);
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
 		    !(magic_mask & PATHSPEC_LITERAL))
 			item[i].magic |=3D PATHSPEC_LITERAL;
--=20
2.3.0.rc1.137.g477eb31
