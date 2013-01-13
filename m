From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 09/10] pathspec: support icase in match_pathspec_depth and tree_entry_interesting
Date: Sun, 13 Jan 2013 19:49:38 +0700
Message-ID: <1358081379-17752-10-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN1Z-0001TP-OB
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab3AMMub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:50:31 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:45477 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab3AMMua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:50:30 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so1702595pbc.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ghFeMWahPecjpoz5VBlZ/rwos1YsF4YNXUNux6AdwAg=;
        b=RnJrGX0dthQKOV+mgOu4fABljtoCh68d3DWTUNb2V4z/LuxczHMVzYxhm9GYcfGwFj
         nxg1WrseKj1JLKcpqEcbgUcRuG3NP4qlZ1YROTJdYmz2RjJPKbSkcdkDHKB6yjpKZ46Y
         M3IhjsNRd8s0UOl93oqvitbFx7FNM42sAjBqOReQt/okacSDXK12Bm5IpqXCMAekuqeL
         DoBLS/zkW1PymlDde1040tRR7AOz1I0/WpqY6AA+C6yxHdNIct1vH9FTJTj6cLW+m2jl
         lRPIREhkm3A1/NuT1XawSH0eAge3Saq4lPuli+5bxKdVPVtC56p3FdLpl+Oly8j96r98
         J38A==
X-Received: by 10.68.135.99 with SMTP id pr3mr247936060pbb.151.1358081429659;
        Sun, 13 Jan 2013 04:50:29 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id bi8sm6775088pab.15.2013.01.13.04.50.26
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:50:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:44 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213382>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     | 17 +++++++++++++++++
 dir.c       | 18 +++++++++++-------
 tree-walk.c | 30 +++++++++++++++++++-----------
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index c3b5585..216f87c 100644
--- a/cache.h
+++ b/cache.h
@@ -522,6 +522,23 @@ extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
 extern int limit_pathspec_to_literal(void);
+static inline int ps_strncmp(const struct pathspec_item *item,
+			     const char *s1, const char *s2, size_t n)
+{
+	if (item->magic & PATHSPEC_ICASE)
+		return strncasecmp(s1, s2, n);
+	else
+		return strncmp(s1, s2, n);
+}
+
+static inline int ps_strcmp(const struct pathspec_item *item,
+			    const char *s1, const char *s2)
+{
+	if (item->magic & PATHSPEC_ICASE)
+		return strcasecmp(s1, s2);
+	else
+		return strcmp(s1, s2);
+}
=20
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
diff --git a/dir.c b/dir.c
index d0e7ca8..e9edb65 100644
--- a/dir.c
+++ b/dir.c
@@ -42,7 +42,7 @@ inline int git_fnmatch(const struct pathspec_item *it=
em,
 		       int prefix)
 {
 	if (prefix > 0) {
-		if (strncmp(pattern, string, prefix))
+		if (ps_strncmp(item, pattern, string, prefix))
 			return FNM_NOMATCH;
 		pattern +=3D prefix;
 		string +=3D prefix;
@@ -51,14 +51,16 @@ inline int git_fnmatch(const struct pathspec_item *=
item,
 		int pattern_len =3D strlen(++pattern);
 		int string_len =3D strlen(string);
 		return string_len < pattern_len ||
-		       strcmp(pattern,
-			      string + string_len - pattern_len);
+			ps_strcmp(item, pattern,
+				  string + string_len - pattern_len);
 	}
 	if (item->magic & PATHSPEC_GLOB)
-		return wildmatch(pattern, string, 0);
+		return wildmatch(pattern, string,
+				 item->magic & PATHSPEC_ICASE ? FNM_CASEFOLD : 0);
 	else
 		/* wildmatch has not learned no FNM_PATHNAME mode yet */
-		return fnmatch(pattern, string, 0);
+		return fnmatch(pattern, string,
+			       item->magic & PATHSPEC_ICASE ? FNM_CASEFOLD : 0);
 }
=20
 static size_t common_prefix_len(const struct pathspec *pathspec)
@@ -162,7 +164,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	if (!*match)
 		return MATCHED_RECURSIVELY;
=20
-	if (matchlen <=3D namelen && !strncmp(match, name, matchlen)) {
+	if (matchlen <=3D namelen && !ps_strncmp(item, match, name, matchlen)=
) {
 		if (matchlen =3D=3D namelen)
 			return MATCHED_EXACTLY;
=20
@@ -192,10 +194,12 @@ int match_pathspec_depth(const struct pathspec *p=
s,
 {
 	int i, retval =3D 0;
=20
+	/* BUG: we should not match icase on the prefix part */
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB);
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
diff --git a/tree-walk.c b/tree-walk.c
index 1679ce7..3d9c2ba 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -488,7 +488,8 @@ int get_tree_entry(const unsigned char *tree_sha1, =
const char *name, unsigned ch
 	return retval;
 }
=20
-static int match_entry(const struct name_entry *entry, int pathlen,
+static int match_entry(const struct pathspec_item *item,
+		       const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
 		       enum interesting *never_interesting)
 {
@@ -504,8 +505,8 @@ static int match_entry(const struct name_entry *ent=
ry, int pathlen,
 		 * Does match sort strictly earlier than path
 		 * with their common parts?
 		 */
-		m =3D strncmp(match, entry->path,
-			    (matchlen < pathlen) ? matchlen : pathlen);
+		m =3D ps_strncmp(item, match, entry->path,
+			       (matchlen < pathlen) ? matchlen : pathlen);
 		if (m < 0)
 			return 0;
=20
@@ -540,7 +541,7 @@ static int match_entry(const struct name_entry *ent=
ry, int pathlen,
 		 * we cheated and did not do strncmp(), so we do
 		 * that here.
 		 */
-		m =3D strncmp(match, entry->path, pathlen);
+		m =3D ps_strncmp(item, match, entry->path, pathlen);
=20
 	/*
 	 * If common part matched earlier then it is a hit,
@@ -553,10 +554,11 @@ static int match_entry(const struct name_entry *e=
ntry, int pathlen,
 	return 0;
 }
=20
-static int match_dir_prefix(const char *base,
+static int match_dir_prefix(const struct pathspec_item *item,
+			    const char *base,
 			    const char *match, int matchlen)
 {
-	if (strncmp(base, match, matchlen))
+	if (ps_strncmp(item, base, match, matchlen))
 		return 0;
=20
 	/*
@@ -593,7 +595,7 @@ static int match_wildcard_base(const struct pathspe=
c_item *item,
 		 */
 		if (baselen >=3D matchlen) {
 			*matched =3D matchlen;
-			return !strncmp(base, match, matchlen);
+			return !ps_strncmp(item, base, match, matchlen);
 		}
=20
 		dirlen =3D matchlen;
@@ -606,7 +608,7 @@ static int match_wildcard_base(const struct pathspe=
c_item *item,
 		 * base ends with '/' so we are sure it really matches
 		 * directory
 		 */
-		if (strncmp(base, match, baselen))
+		if (ps_strncmp(item, base, match, baselen))
 			return 0;
 		*matched =3D baselen;
 	} else
@@ -635,10 +637,16 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
+	/*
+	 * BUG: we should not match icase on the prefix part. The
+	 * prefix length is in 'ps'. Although using it won't be easy
+	 * as the pattern is cut into pieces...
+	 */
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB);
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -659,7 +667,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
=20
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
-			if (!match_dir_prefix(base_str, match, matchlen))
+			if (!match_dir_prefix(item, base_str, match, matchlen))
 				goto match_wildcards;
=20
 			if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -674,7 +682,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
=20
 		/* Either there must be no base, or the base must match. */
 		if (baselen =3D=3D 0 || !strncmp(base_str, match, baselen)) {
-			if (match_entry(entry, pathlen,
+			if (match_entry(item, entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
 				return entry_interesting;
--=20
1.8.0.rc2.23.g1fb49df
