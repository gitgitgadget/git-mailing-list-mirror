From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/45] Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
Date: Sun,  9 Jun 2013 13:26:14 +0700
Message-ID: <1370759178-1709-42-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ7y-000200-BF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab3FIG3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:29:18 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:50863 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab3FIG3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:29:18 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so6168490pbc.32
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QTz86bcJlNauw1neco8H4JeonkQymlU9QLvhCjjSbvI=;
        b=h9VmzNn6Kef3fvjQn3qJXoTaahzQMb8PvC7/5l8pu4C/pGP29JpZzUCmyE1+KPoo2Y
         pF2pH7SwAjdljDayabOA420a4S+yg6/PYo3zgQ/qB6BnjpWKClrEy2h95g4kz4PBXN4o
         wnhuLgUn5NNhg3aN5KYn50FyWxX4P0Lycos18GOXmn+tHwdFz3IDGpIi+xUbRV6pCbvr
         JpDZpJY6GyhvNTY1IXYespl6DcXnBXdEMEjLyF0Nyoroj57W4dXGywPer6hKfCAYg2MO
         MR9k4fKVxTZjWExcqNwWLXvUic6+gAdS5/Psj28GW1EnkTHE0sbcvkddzzgm+gqYl/a1
         mpDQ==
X-Received: by 10.66.245.49 with SMTP id xl17mr9324429pac.101.1370759357557;
        Sat, 08 Jun 2013 23:29:17 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id dr6sm10249571pac.11.2013.06.08.23.29.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:29:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:30:44 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226933>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c      | 8 --------
 pathspec.c | 8 ++++++--
 pathspec.h | 2 --
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index 1098133..76a2e1a 100644
--- a/dir.c
+++ b/dir.c
@@ -1475,14 +1475,6 @@ int remove_path(const char *name)
 	return 0;
 }
=20
-int limit_pathspec_to_literal(void)
-{
-	static int flag =3D -1;
-	if (flag < 0)
-		flag =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0);
-	return flag;
-}
-
 /*
  * Frees memory within dir which was allocated for exclude lists and
  * the exclude_stack.  Does not free dir itself.
diff --git a/pathspec.c b/pathspec.c
index 2bd400a..69adaba 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -91,11 +91,15 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				const char *prefix, int prefixlen,
 				const char *elt)
 {
+	static int literal_global =3D -1;
 	unsigned magic =3D 0, short_magic =3D 0;
 	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
 	int i, pathspec_prefix =3D -1;
=20
+	if (literal_global < 0)
+		literal_global =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0=
);
+
 	if (elt[0] !=3D ':') {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
@@ -184,7 +188,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	if (flags & PATHSPEC_PREFIX_ORIGIN) {
 		struct strbuf sb =3D STRBUF_INIT;
 		const char *start =3D elt;
-		if (prefixlen && !limit_pathspec_to_literal()) {
+		if (prefixlen && !literal_global) {
 			/* Preserve the actual prefix length of each pattern */
 			if (long_magic_end) {
 				strbuf_add(&sb, start, long_magic_end - start);
@@ -232,7 +236,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				     elt, ce_len, ce->name);
 		}
=20
-	if (limit_pathspec_to_literal())
+	if (literal_global)
 		item->nowildcard_len =3D item->len;
 	else {
 		item->nowildcard_len =3D simple_length(item->match);
diff --git a/pathspec.h b/pathspec.h
index bbcfa74..4ebaadc 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -61,8 +61,6 @@ extern void parse_pathspec(struct pathspec *pathspec,
 extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
=20
-extern int limit_pathspec_to_literal(void);
-
 extern char *find_pathspecs_matching_against_index(const struct pathsp=
ec *pathspec);
 extern void add_pathspec_matches_against_index(const struct pathspec *=
pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
--=20
1.8.2.83.gc99314b
