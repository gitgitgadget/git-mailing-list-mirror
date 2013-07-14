From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 42/46] Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
Date: Sun, 14 Jul 2013 15:36:05 +0700
Message-ID: <1373790969-13000-43-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHr6-0003i6-D9
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab3GNIkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:40:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34945 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3GNIkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:40:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so10288726pbb.5
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u0Z78qhIQN7Ggxa7xcXWXwpR3/wtKXEzL0KtYEJdJJM=;
        b=BdiQW6QKA9r/rqoUIfWCxAa9nddVYerVPyPfYaACkQOgmrUQiiIxNvCgSb9EoHTTla
         TxhymOHbB4TEz4SfEX+9gUYl5AVXsiJsoJyW2CWrtEXflayUFBEr56++Nc7EHFuwNvUG
         F6K7zThBHz7jFj/HlkbqYyAylwDHJu/U9wB6cnI9D+Qt/Aw4u9oYTyg/uandRRCfPUlF
         wNQWAeM5rskruB8lHtiw/kuT76USH571OQjuxcvbX9nqq2wcKdOSg6tLp8kovQtVFnOQ
         s/pSufD4giPIXCz9R5rTftiHaJnvhkE0uZKRcKtaWDiydbXw/ht+bNQFfL7q1Zvvpm2p
         6qCw==
X-Received: by 10.68.40.170 with SMTP id y10mr49092792pbk.155.1373791223502;
        Sun, 14 Jul 2013 01:40:23 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id vo8sm16614833pbc.5.2013.07.14.01.40.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:40:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:35 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230354>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c      | 8 --------
 pathspec.c | 8 ++++++--
 pathspec.h | 2 --
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index bf22498..79465e7 100644
--- a/dir.c
+++ b/dir.c
@@ -1473,14 +1473,6 @@ int remove_path(const char *name)
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
index 82ede57..b2e3a87 100644
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
index 2f3532e..7ef9896 100644
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
