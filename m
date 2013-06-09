From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/45] Convert common_prefix() to use struct pathspec
Date: Sun,  9 Jun 2013 13:26:07 +0700
Message-ID: <1370759178-1709-35-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ79-0001Wm-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3FIG22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:28 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:59879 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3FIG21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:27 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2742256pdj.3
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QbP62ymdIl6GoU41UQiAF06DzaJp0KLeiUv7G/beHbw=;
        b=TNs7VxRVDvxwSlRPrI3btiJNV8dE1pG3Z2M6a/QhPfYZ9XIskHGked+UA0RwVwtXhW
         hxrPiy5f9+QL/PqNu15USxLPz91aLEe59N0it13SYqzUu+Hz8CFaeKuaY04HY3TARLce
         ifcNQnfbIFGifWyvuh4YAq7PZjHXW/esZaZjp+zwTvRglPPgE1kK7fRgEnyxcF/cdavF
         PRxVQHzKIPRE1rbE07ehkW+bW26N+av16oXG6ybs9XZInu2GggXQxD1haQ2TohhdEMM7
         C/s/GupcMuesNRxF/q9SJcNrX4ts5gTBEyOrl7m/yfbum4brrwQDunCIsIKD5v1zUaUa
         RcyA==
X-Received: by 10.66.197.227 with SMTP id ix3mr9287823pac.105.1370759306901;
        Sat, 08 Jun 2013 23:28:26 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id fn9sm10277728pab.2.2013.06.08.23.28.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:58 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226926>

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
index 2ddff4e..5b7adb0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -194,7 +194,7 @@ static int list_paths(struct string_list *list, con=
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
index 7feedba..67feda6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -544,7 +544,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
index 863ee39..9d20691 100644
--- a/dir.c
+++ b/dir.c
@@ -103,26 +103,25 @@ static int fnmatch_icase_mem(const char *pattern,=
 int patternlen,
 	return match_status;
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
+	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
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
@@ -135,11 +134,11 @@ static size_t common_prefix_len(const char **path=
spec)
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
@@ -150,7 +149,7 @@ int fill_directory(struct dir_struct *dir, const st=
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
index 076dd96..ba40e69 100644
--- a/dir.h
+++ b/dir.h
@@ -130,7 +130,7 @@ struct dir_struct {
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
1.8.2.83.gc99314b
