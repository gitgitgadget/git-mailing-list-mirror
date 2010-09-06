From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] tree-walk: actually move tree_entry_interesting() to tree-walk.c
Date: Mon,  6 Sep 2010 14:47:08 +1000
Message-ID: <1283748429-31076-4-git-send-email-pclouds@gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:47:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTcU-0001Yl-9d
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab0IFEri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:47:38 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58873 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab0IFEri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 00:47:38 -0400
Received: by pzk9 with SMTP id 9so1304132pzk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xH2XnVh6jLu4LZI5HNprWKVovCFFPX8meNJiSJPi5Ug=;
        b=hN5J91yMcUi7u5UHQ1nQFqRKpqu4FCJQZMWKAGW0rgoOTVKAI72aACEOGLnb/8DGqu
         NmYVAV7OWAjrjao8/iL1FqHGeZPQAznxaA0q+/Fhi/OswrWYAg0n8TJ7CTftrE08vHu8
         2iJYjlpx0tl05As3IyqvBHSZynbjf5wQxI5N4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dWIFPm8vczDvT3tTDTZa24WaTrWZmbVytWNB+Ikjw4dr9tNU420GxhknWS9zprP7v0
         N4Ww00kyzQlEjz/20S4JCo5MjrfwWgDIoangJJ79BwRKfl0bR3gvu6NcB9/jxJID+rGx
         gqe0TgwDfhJm3bh0sHiKapI+kPGjUtTinH+eU=
Received: by 10.114.13.2 with SMTP id 2mr3147382wam.155.1283748457421;
        Sun, 05 Sep 2010 21:47:37 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d39sm10435525wam.4.2010.09.05.21.47.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 21:47:36 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  6 Sep 2010 14:47:30 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155524>

This function can be potentially used in more places than just
tree-diff.c. This patches removes struct diff_options dependency from
the function, and moves it to tree-walk.c.

No functionality change intended.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |  121 ++-------------------------------------------------=
--------
 tree-walk.c |   25 +++++-------
 tree-walk.h |    3 +
 3 files changed, 17 insertions(+), 132 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..332f0c8 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -82,120 +82,6 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
 	return 0;
 }
=20
-/*
- * Is a tree entry interesting given the pathspec we have?
- *
- * Return:
- *  - 2 for "yes, and all subsequent entries will be"
- *  - 1 for yes
- *  - zero for no
- *  - negative for "no, and no subsequent entries will be either"
- */
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
-{
-	const char *path;
-	const unsigned char *sha1;
-	unsigned mode;
-	int i;
-	int pathlen;
-	int never_interesting =3D -1;
-
-	if (!opt->nr_paths)
-		return 1;
-
-	sha1 =3D tree_entry_extract(desc, &path, &mode);
-
-	pathlen =3D tree_entry_len(path, sha1);
-
-	for (i =3D 0; i < opt->nr_paths; i++) {
-		const char *match =3D opt->paths[i];
-		int matchlen =3D opt->pathlens[i];
-		int m =3D -1; /* signals that we haven't called strncmp() */
-
-		if (baselen >=3D matchlen) {
-			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
-				continue;
-
-			/*
-			 * If the base is a subdirectory of a path which
-			 * was specified, all of them are interesting.
-			 */
-			if (!matchlen ||
-			    base[matchlen] =3D=3D '/' ||
-			    match[matchlen - 1] =3D=3D '/')
-				return 2;
-
-			/* Just a random prefix match */
-			continue;
-		}
-
-		/* Does the base match? */
-		if (strncmp(base, match, baselen))
-			continue;
-
-		match +=3D baselen;
-		matchlen -=3D baselen;
-
-		if (never_interesting) {
-			/*
-			 * We have not seen any match that sorts later
-			 * than the current path.
-			 */
-
-			/*
-			 * Does match sort strictly earlier than path
-			 * with their common parts?
-			 */
-			m =3D strncmp(match, path,
-				    (matchlen < pathlen) ? matchlen : pathlen);
-			if (m < 0)
-				continue;
-
-			/*
-			 * If we come here even once, that means there is at
-			 * least one pathspec that would sort equal to or
-			 * later than the path we are currently looking at.
-			 * In other words, if we have never reached this point
-			 * after iterating all pathspecs, it means all
-			 * pathspecs are either outside of base, or inside the
-			 * base but sorts strictly earlier than the current
-			 * one.  In either case, they will never match the
-			 * subsequent entries.  In such a case, we initialized
-			 * the variable to -1 and that is what will be
-			 * returned, allowing the caller to terminate early.
-			 */
-			never_interesting =3D 0;
-		}
-
-		if (pathlen > matchlen)
-			continue;
-
-		if (matchlen > pathlen) {
-			if (match[pathlen] !=3D '/')
-				continue;
-			if (!S_ISDIR(mode))
-				continue;
-		}
-
-		if (m =3D=3D -1)
-			/*
-			 * we cheated and did not do strncmp(), so we do
-			 * that here.
-			 */
-			m =3D strncmp(match, path, pathlen);
-
-		/*
-		 * If common part matched earlier then it is a hit,
-		 * because we rejected the case where path is not a
-		 * leading directory and is shorter than match.
-		 */
-		if (!m)
-			return 1;
-	}
-	return never_interesting; /* No matches */
-}
-
 /* A whole sub-tree went away or appeared */
 static void show_tree(struct diff_options *opt, const char *prefix, st=
ruct tree_desc *desc, const char *base, int baselen)
 {
@@ -206,8 +92,8 @@ static void show_tree(struct diff_options *opt, cons=
t char *prefix, struct tree_
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(desc, base, baselen,
-						      opt);
+			show =3D tree_entry_interesting(&desc->entry, base, baselen,
+						      opt->paths, opt->pathlens, opt->nr_paths);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
@@ -266,7 +152,8 @@ static void skip_uninteresting(struct tree_desc *t,=
 const char *base, int basele
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(t, base, baselen, opt);
+			show =3D tree_entry_interesting(&t->entry, base, baselen,
+						      opt->paths, opt->pathlens, opt->nr_paths);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
diff --git a/tree-walk.c b/tree-walk.c
index bc83fa3..c665e35 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,7 +2,6 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "tree.h"
-#include "diff.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -466,25 +465,21 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+int tree_entry_interesting(const struct name_entry *entry, const char =
*base, int baselen,
+			   const char **paths, int *pathlens, int nr_paths)
 {
-	const char *path;
-	const unsigned char *sha1;
-	unsigned mode;
 	int i;
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!opt->nr_paths)
+	if (!nr_paths)
 		return 1;
=20
-	sha1 =3D tree_entry_extract(desc, &path, &mode);
-
-	pathlen =3D tree_entry_len(path, sha1);
+	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
-	for (i =3D 0; i < opt->nr_paths; i++) {
-		const char *match =3D opt->paths[i];
-		int matchlen =3D opt->pathlens[i];
+	for (i =3D 0; i < nr_paths; i++) {
+		const char *match =3D paths[i];
+		int matchlen =3D pathlens[i];
 		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
@@ -522,7 +517,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * Does match sort strictly earlier than path
 			 * with their common parts?
 			 */
-			m =3D strncmp(match, path,
+			m =3D strncmp(match, entry->path,
 				    (matchlen < pathlen) ? matchlen : pathlen);
 			if (m < 0)
 				continue;
@@ -549,7 +544,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 		if (matchlen > pathlen) {
 			if (match[pathlen] !=3D '/')
 				continue;
-			if (!S_ISDIR(mode))
+			if (!S_ISDIR(entry->mode))
 				continue;
 		}
=20
@@ -558,7 +553,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * we cheated and did not do strncmp(), so we do
 			 * that here.
 			 */
-			m =3D strncmp(match, path, pathlen);
+			m =3D strncmp(match, entry->path, pathlen);
=20
 		/*
 		 * If common part matched earlier then it is a hit,
diff --git a/tree-walk.h b/tree-walk.h
index 88ea7e9..b20f3c4 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -57,4 +57,7 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
+extern int tree_entry_interesting(const struct name_entry *entry, cons=
t char *base, int baselen,
+				  const char **paths, int *pathlens, int nr_paths);
+
 #endif
--=20
1.7.1.rc1.69.g24c2f7
