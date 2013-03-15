From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 34/45] Convert common_prefix() to use struct pathspec
Date: Fri, 15 Mar 2013 13:06:49 +0700
Message-ID: <1363327620-29017-35-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7t-0007UZ-7j
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab3COG16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:58 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:58446 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3COG16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:58 -0400
Received: by mail-ie0-f180.google.com with SMTP id bn7so3915750ieb.39
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=O7/JILcmeoiYac1JtmL0zwRqjj2VsAPhiQ7IMTqAgrw=;
        b=r4ETsADh/c666GRujTiQnmGkP1cmGu5tg5ZjJCEBuRZGvwyU8So/fq4Dbcgi61C2AA
         PHF/sk07EqNM/SbwolJKKF1G1+7LN7RSlk+2QRMmvOJ/A9kOMvahdIUfKj6aDY7bKH3G
         ZUS54paGRTjYZRGJeWJWOMc7/WTAhTSrhjmRJ+qrAVwv3ecbVZJ3yJmHs4vDso268F7y
         9YwhahFaKPDQ1KFh/d42J26BfP2W3fl4ckGCnZ51HpN+sCT2nK4RmvYIPkFKiV3VN6uX
         WH/f03uQgx59rYSM4ciDolDedTvK0djc+KX1XKvdIuQQrCqw6JJA/05GwLW6z5ITEEVy
         2O9g==
X-Received: by 10.50.57.168 with SMTP id j8mr410378igq.51.1363328877657;
        Thu, 14 Mar 2013 23:27:57 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ur12sm739313igb.8.2013.03.14.23.27.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:00 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218221>

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
index b5a92fa..1c4b73a 100644
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
index 37f0392..f211539 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -551,7 +551,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
index 20e6a3e..a646e55 100644
--- a/dir.c
+++ b/dir.c
@@ -60,26 +60,25 @@ inline int git_fnmatch(const char *pattern, const c=
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
@@ -92,11 +91,11 @@ static size_t common_prefix_len(const char **pathsp=
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
@@ -107,7 +106,7 @@ int fill_directory(struct dir_struct *dir, const st=
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
index 70fdc98..d3f76df 100644
--- a/dir.h
+++ b/dir.h
@@ -127,7 +127,7 @@ struct dir_struct {
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
1.8.0.rc0.19.g7bbb31d
