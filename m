From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 26/31] Convert common_prefix() to use struct pathspec
Date: Sun, 13 Jan 2013 19:35:34 +0700
Message-ID: <1358080539-17436-27-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMq8-0008ML-Vl
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab3AMMip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:45 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:52189 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3AMMio (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:44 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so1431585dae.7
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bF7vL5f1HVHVmMM3ic2jniOSslGw2Cj63AFz9VrlQXk=;
        b=k0/LjDLxrkxOxikXcF1M1ddldJRkZOzkq5Ku3Psc+o/2lh+KMzY2jbHpX8nI3/t6us
         uuBuypCa2XjtEUOzbOwBPgeqwA+PdF5MTJcWo1Sw7EnC+/SS4QhuduTx0D7Scwz2GTXF
         hBxkwl9zLXasgVwPMUNLLhx2QqtprbsJGEihYw8NRddyr/dbAdAnmY5tAGmF5HqsNepx
         iex+JpOX5pwWagsoHvN4Tj7khzI4PKIKy/H4+R6F9TRs36m/LB/XdayL4zeiuqRb8G8v
         vMIkjuLfq86B8jAgnARW5DuhJTErYqpndsk++EdnGCxjVprty06Q224lGLNr7D20CCsZ
         zrgw==
X-Received: by 10.68.197.197 with SMTP id iw5mr243124914pbc.22.1358080724034;
        Sun, 13 Jan 2013 04:38:44 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id p9sm3163096pao.29.2013.01.13.04.38.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:58 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213367>

The code now takes advantage of nowildcard_len field.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c   |  2 +-
 builtin/ls-files.c |  2 +-
 dir.c              | 31 +++++++++++++++----------------
 dir.h              |  2 +-
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d79613d..2011f98 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -192,7 +192,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
 	m =3D xcalloc(1, pattern->nr);
=20
 	if (with_tree) {
-		char *max_prefix =3D common_prefix(pattern->raw);
+		char *max_prefix =3D common_prefix(pattern);
 		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
 		free(max_prefix);
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9655cc5..6c4ee40 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -542,7 +542,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		       prefix, argv);
=20
 	/* Find common prefix for all pathspec's */
-	max_prefix =3D common_prefix(pathspec.raw);
+	max_prefix =3D common_prefix(&pathspec);
 	max_prefix_len =3D max_prefix ? strlen(max_prefix) : 0;
=20
 	/* Treat unmatching pathspec elements as errors */
diff --git a/dir.c b/dir.c
index 6657b02..5d257fb 100644
--- a/dir.c
+++ b/dir.c
@@ -59,26 +59,25 @@ inline int git_fnmatch(const char *pattern, const c=
har *string,
 	return fnmatch(pattern, string, fnm_flags);
 }
=20
-static size_t common_prefix_len(const char **pathspec)
+static size_t common_prefix_len(const struct pathspec *pathspec)
 {
-	const char *n, *first;
+	int n;
 	size_t max =3D 0;
-	int literal =3D limit_pathspec_to_literal();
=20
-	if (!pathspec)
-		return max;
-
-	first =3D *pathspec;
-	while ((n =3D *pathspec++)) {
-		size_t i, len =3D 0;
-		for (i =3D 0; first =3D=3D n || i < max; i++) {
-			char c =3D n[i];
-			if (!c || c !=3D first[i] || (!literal && is_glob_special(c)))
+	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP);
+
+	for (n =3D 0; n < pathspec->nr; n++) {
+		size_t i =3D 0, len =3D 0;
+		while (i < pathspec->items[n].nowildcard_len &&
+		       (n =3D=3D 0 || i < max)) {
+			char c =3D pathspec->items[n].match[i];
+			if (c !=3D pathspec->items[0].match[i])
 				break;
 			if (c =3D=3D '/')
 				len =3D i + 1;
+			i++;
 		}
-		if (first =3D=3D n || len < max) {
+		if (n =3D=3D 0 || len < max) {
 			max =3D len;
 			if (!max)
 				break;
@@ -91,11 +90,11 @@ static size_t common_prefix_len(const char **pathsp=
ec)
  * Returns a copy of the longest leading path common among all
  * pathspecs.
  */
-char *common_prefix(const char **pathspec)
+char *common_prefix(const struct pathspec *pathspec)
 {
 	unsigned long len =3D common_prefix_len(pathspec);
=20
-	return len ? xmemdupz(*pathspec, len) : NULL;
+	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
 }
=20
 int fill_directory(struct dir_struct *dir, const struct pathspec *path=
spec)
@@ -106,7 +105,7 @@ int fill_directory(struct dir_struct *dir, const st=
ruct pathspec *pathspec)
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len =3D common_prefix_len(pathspec->raw);
+	len =3D common_prefix_len(pathspec);
=20
 	/* Read the directory and prune it */
 	read_directory(dir, pathspec->nr ? pathspec->raw[0] : "", len, pathsp=
ec);
diff --git a/dir.h b/dir.h
index 36bb4dd..ff5ada5 100644
--- a/dir.h
+++ b/dir.h
@@ -90,7 +90,7 @@ struct dir_struct {
 #define MATCHED_EXACTLY 3
 extern int simple_length(const char *match);
 extern int no_wildcard(const char *string);
-extern char *common_prefix(const char **pathspec);
+extern char *common_prefix(const struct pathspec *pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
--=20
1.8.0.rc2.23.g1fb49df
