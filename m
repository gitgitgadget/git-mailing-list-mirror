From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 05/10] pathspec: prepare for :(glob)path syntax
Date: Sun, 13 Jan 2013 19:49:34 +0700
Message-ID: <1358081379-17752-6-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN1A-00015g-Nm
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab3AMMuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:50:07 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49406 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab3AMMuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:50:05 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1758062pad.25
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=231JroXvbeNHgKOQOxaLu4vQA9qlmdMgaj5FdAl+NjM=;
        b=kconXwwssAtDu15Bv+SsD5bRjMA//CNCjmkMsL9ZvnUi8b4Wu4NcYx+480RCuUw95A
         QASGSzruHSMhmSShDbobqNFjThWjdy5BSyAJXdjU5RQRZEMweSyp1CLw8491QfdPeZfe
         qUM3X/8hghGuTlxKFeCMQm4Srehd6NA+JVEBuHW8hNQ8O0X59pJawNv1H66niNZ5VCa5
         IUgmXJ5c6huCRWTfS+LqYW9qkCUKTILlqAILYYyHhLyYLvQupDy3ubCmUFtsCGTOgewz
         tPJA8q/edoOMhLjd3z560ubNEVplz5/IrbqpsAFjcqEHDNI5TH3T9ym4M4G719WuALwv
         nAEA==
X-Received: by 10.68.247.39 with SMTP id yb7mr248885172pbc.15.1358081405189;
        Sun, 13 Jan 2013 04:50:05 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id s7sm6779288paz.7.2013.01.13.04.50.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:50:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:14 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213377>

:(glob)path differs from path that it uses wildmatch with
=46NM_PATHNAME while plain "path" uses fnmatch without FNM_PATHNAME.

git_fnmatch() was probably ill-designed. It was intended to cover
other use of fnmatch besides pathspec. But so far it's only used by
pathspec code.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c |  9 +++++++--
 cache.h       |  1 +
 dir.c         | 34 ++++++++++++++++++++++------------
 dir.h         |  8 +++-----
 setup.c       |  1 +
 tree-walk.c   | 11 ++++++-----
 6 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d09a07a..1b99e2b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -416,11 +416,16 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		/*
 		 * file_exists() assumes exact match
 		 */
-		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+		GUARD_PATHSPEC(&pathspec,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
-			if (!seen[i] && !file_exists(path)) {
+			if (!seen[i] &&
+			    ((pathspec.items[i].magic & PATHSPEC_GLOB) ||
+			     !file_exists(path))) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
 					if (is_path_excluded(&check, path, -1, &dtype))
diff --git a/cache.h b/cache.h
index fb54876..9c27f18 100644
--- a/cache.h
+++ b/cache.h
@@ -479,6 +479,7 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP    (1<<0)
 #define PATHSPEC_LITERAL    (1<<1)
+#define PATHSPEC_GLOB       (1<<2)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
diff --git a/dir.c b/dir.c
index 63d07cd..760b776 100644
--- a/dir.c
+++ b/dir.c
@@ -37,26 +37,28 @@ int fnmatch_icase(const char *pattern, const char *=
string, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
 }
=20
-inline int git_fnmatch(const char *pattern, const char *string,
-		       int flags, int prefix)
+inline int git_fnmatch(const struct pathspec_item *item,
+		       const char *pattern, const char *string,
+		       int prefix)
 {
-	int fnm_flags =3D 0;
-	if (flags & GFNM_PATHNAME)
-		fnm_flags |=3D FNM_PATHNAME;
 	if (prefix > 0) {
 		if (strncmp(pattern, string, prefix))
 			return FNM_NOMATCH;
 		pattern +=3D prefix;
 		string +=3D prefix;
 	}
-	if (flags & GFNM_ONESTAR) {
+	if (item->flags & PATHSPEC_ONESTAR) {
 		int pattern_len =3D strlen(++pattern);
 		int string_len =3D strlen(string);
 		return string_len < pattern_len ||
 		       strcmp(pattern,
 			      string + string_len - pattern_len);
 	}
-	return fnmatch(pattern, string, fnm_flags);
+	if (item->magic & PATHSPEC_GLOB)
+		return wildmatch(pattern, string, 0);
+	else
+		/* wildmatch has not learned no FNM_PATHNAME mode yet */
+		return fnmatch(pattern, string, 0);
 }
=20
 static size_t common_prefix_len(const struct pathspec *pathspec)
@@ -64,7 +66,10 @@ static size_t common_prefix_len(const struct pathspe=
c *pathspec)
 	int n;
 	size_t max =3D 0;
=20
-	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+	GUARD_PATHSPEC(pathspec,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
 		size_t i =3D 0, len =3D 0;
@@ -159,8 +164,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	}
=20
 	if (item->nowildcard_len < item->len &&
-	    !git_fnmatch(match, name,
-			 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+	    !git_fnmatch(item, match, name,
 			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
=20
@@ -181,7 +185,10 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 {
 	int i, retval =3D 0;
=20
-	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+	GUARD_PATHSPEC(ps,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB);
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -1230,7 +1237,10 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	 * Check out create_simplify()
 	 */
 	if (pathspec)
-		GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+		GUARD_PATHSPEC(pathspec,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
diff --git a/dir.h b/dir.h
index a03af80..b6da4b7 100644
--- a/dir.h
+++ b/dir.h
@@ -168,10 +168,8 @@ extern int fnmatch_icase(const char *pattern, cons=
t char *string, int flags);
 /*
  * The prefix part of pattern must not contains wildcards.
  */
-#define GFNM_PATHNAME 1		/* similar to FNM_PATHNAME */
-#define GFNM_ONESTAR  2		/* there is only _one_ wildcard, a star */
-
-extern int git_fnmatch(const char *pattern, const char *string,
-		       int flags, int prefix);
+extern int git_fnmatch(const struct pathspec_item *item,
+		       const char *pattern, const char *string,
+		       int prefix);
=20
 #endif
diff --git a/setup.c b/setup.c
index c4af05e..b3e146d 100644
--- a/setup.c
+++ b/setup.c
@@ -170,6 +170,7 @@ static struct pathspec_magic {
 } pathspec_magic[] =3D {
 	{ PATHSPEC_FROMTOP, '/', "top" },
 	{ PATHSPEC_LITERAL,   0, "literal" },
+	{ PATHSPEC_GLOB,   '\0', "glob" },
 };
=20
 /*
diff --git a/tree-walk.c b/tree-walk.c
index d4ed51f..1679ce7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -635,7 +635,10 @@ enum interesting tree_entry_interesting(const stru=
ct name_entry *entry,
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
-	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+	GUARD_PATHSPEC(ps,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB);
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -677,8 +680,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 				return entry_interesting;
=20
 			if (item->nowildcard_len < item->len) {
-				if (!git_fnmatch(match + baselen, entry->path,
-						 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+				if (!git_fnmatch(item, match + baselen, entry->path,
 						 item->nowildcard_len - baselen))
 					return entry_interesting;
=20
@@ -719,8 +721,7 @@ match_wildcards:
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!git_fnmatch(match, base->buf + base_offset,
-				 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+		if (!git_fnmatch(item, match, base->buf + base_offset,
 				 item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
--=20
1.8.0.rc2.23.g1fb49df
