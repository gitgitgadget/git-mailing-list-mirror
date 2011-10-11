From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] Replace has_wildcard with PATHSPEC_NOGLOB
Date: Wed, 12 Oct 2011 09:44:39 +1100
Message-ID: <1318373083-13840-3-git-send-email-pclouds@gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl4d-0006tI-C7
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab1JKWpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:45:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35345 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab1JKWpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:45:11 -0400
Received: by mail-vx0-f174.google.com with SMTP id gb30so85726vcb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ayHE1ARQfb/cM1oQ13O6Hwp9zfTlq1uVoZgX2K39vo0=;
        b=Ku+meTtsEvTP16C46qerdbJIK4HDVD5cH64woc4UegM9GEpCby6zB0u4tWAWWG04sB
         K+SEiAFt5/VsTgkzCcttFOoixCyIqhVnAFrHXp4TrGWqnWEOwQfD8SIB+NaKtWxmRpSo
         K7vLjiTvyYZcEkEud4trQWm3ajUhczwUj7Bz4=
Received: by 10.52.90.206 with SMTP id by14mr20783221vdb.18.1318373109934;
        Tue, 11 Oct 2011 15:45:09 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id bi11sm170826vdb.13.2011.10.11.15.45.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:45:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:45:01 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183336>

Note though "noglob" magic is not implemented yet, only its definition
for internal use.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c |    2 +-
 builtin/ls-tree.c  |    4 ++--
 cache.h            |   22 ++++++++++++++++++++--
 dir.c              |   11 +++++++----
 setup.c            |   17 -----------------
 tree-walk.c        |    7 +++----
 6 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e8a800d..e687157 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -326,7 +326,7 @@ void overlay_tree_on_cache(const char *tree_name, c=
onst char *prefix)
 		matchbuf[0] =3D prefix;
 		matchbuf[1] =3D NULL;
 		init_pathspec(&pathspec, matchbuf);
-		pathspec.items[0].use_wildcard =3D 0;
+		pathspec.items[0].magic =3D PATHSPEC_NOGLOB;
 	} else
 		init_pathspec(&pathspec, NULL);
 	if (read_tree(tree, 1, &pathspec))
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6b666e1..f0fa7dd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -168,8 +168,8 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
=20
 	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
 	for (i =3D 0; i < pathspec.nr; i++)
-		pathspec.items[i].use_wildcard =3D 0;
-	pathspec.has_wildcard =3D 0;
+		pathspec.items[i].magic =3D PATHSPEC_NOGLOB;
+	pathspec.magic |=3D PATHSPEC_NOGLOB;
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/cache.h b/cache.h
index 82e12c8..fe46f1e 100644
--- a/cache.h
+++ b/cache.h
@@ -521,16 +521,34 @@ extern int index_name_is_other(const struct index=
_state *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+/*
+ * Magic pathspec
+ *
+ * NEEDSWORK: These need to be moved to dir.h or even to a new
+ * pathspec.h when we restructure get_pathspec() users to use the
+ * "struct pathspec" interface.
+ *
+ * Possible future magic semantics include stuff like:
+ *
+ *	{ PATHSPEC_NOGLOB, '!', "noglob" },
+ *	{ PATHSPEC_ICASE, '\0', "icase" },
+ *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
+ *	{ PATHSPEC_REGEXP, '\0', "regexp" },
+ *
+ */
+#define PATHSPEC_FROMTOP    (1<<0)
+#define PATHSPEC_NOGLOB     (1<<1)
+
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
-	unsigned int has_wildcard:1;
+	unsigned magic;
 	unsigned int recursive:1;
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
 		int len;
-		unsigned int use_wildcard:1;
+		unsigned magic;
 	} *items;
 };
=20
diff --git a/dir.c b/dir.c
index 08281d2..6c82615 100644
--- a/dir.c
+++ b/dir.c
@@ -230,7 +230,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
=20
-	if (item->use_wildcard && !fnmatch(match, name, 0))
+	if (!(item->magic & PATHSPEC_NOGLOB) && !fnmatch(match, name, 0))
 		return MATCHED_FNMATCH;
=20
 	return 0;
@@ -1264,19 +1264,22 @@ int init_pathspec(struct pathspec *pathspec, co=
nst char **paths)
 		p++;
 	pathspec->raw =3D paths;
 	pathspec->nr =3D p - paths;
+	pathspec->magic =3D PATHSPEC_NOGLOB;
 	if (!pathspec->nr)
 		return 0;
=20
 	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
+	memset(pathspec->items, 0, sizeof(struct pathspec_item)*pathspec->nr)=
;
 	for (i =3D 0; i < pathspec->nr; i++) {
 		struct pathspec_item *item =3D pathspec->items+i;
 		const char *path =3D paths[i];
=20
 		item->match =3D path;
 		item->len =3D strlen(path);
-		item->use_wildcard =3D !no_wildcard(path);
-		if (item->use_wildcard)
-			pathspec->has_wildcard =3D 1;
+		if (no_wildcard(path))
+			item->magic |=3D PATHSPEC_NOGLOB;
+		else
+			pathspec->magic &=3D ~PATHSPEC_NOGLOB;
 	}
=20
 	qsort(pathspec->items, pathspec->nr,
diff --git a/setup.c b/setup.c
index 08f605b..35db910 100644
--- a/setup.c
+++ b/setup.c
@@ -105,23 +105,6 @@ void verify_non_filename(const char *prefix, const=
 char *arg)
 	    "Use '--' to separate filenames from revisions", arg);
 }
=20
-/*
- * Magic pathspec
- *
- * NEEDSWORK: These need to be moved to dir.h or even to a new
- * pathspec.h when we restructure get_pathspec() users to use the
- * "struct pathspec" interface.
- *
- * Possible future magic semantics include stuff like:
- *
- *	{ PATHSPEC_NOGLOB, '!', "noglob" },
- *	{ PATHSPEC_ICASE, '\0', "icase" },
- *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
- *	{ PATHSPEC_REGEXP, '\0', "regexp" },
- *
- */
-#define PATHSPEC_FROMTOP    (1<<0)
-
 static struct pathspec_magic {
 	unsigned bit;
 	char mnemonic; /* this cannot be ':'! */
diff --git a/tree-walk.c b/tree-walk.c
index 808bb55..db07fd6 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -586,7 +586,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
 {
 	int i;
 	int pathlen, baselen =3D base->len - base_offset;
-	int never_interesting =3D ps->has_wildcard ? 0 : -1;
+	int never_interesting =3D ps->magic & PATHSPEC_NOGLOB ? -1 : 0;
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -625,7 +625,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
 					&never_interesting))
 				return 1;
=20
-			if (ps->items[i].use_wildcard) {
+			if (!(ps->items[i].magic & PATHSPEC_NOGLOB)) {
 				if (!fnmatch(match + baselen, entry->path, 0))
 					return 1;
=20
@@ -636,12 +636,11 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 				if (ps->recursive && S_ISDIR(entry->mode))
 					return 1;
 			}
-
 			continue;
 		}
=20
 match_wildcards:
-		if (!ps->items[i].use_wildcard)
+		if (ps->items[i].magic & PATHSPEC_NOGLOB)
 			continue;
=20
 		/*
--=20
1.7.3.1.256.g2539c.dirty
