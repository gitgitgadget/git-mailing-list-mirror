From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Support pathspec magic :(exclude) and its short form :-
Date: Wed, 20 Nov 2013 08:41:31 +0700
Message-ID: <1384911691-11664-1-git-send-email-pclouds@gmail.com>
References: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, toralf.foerster@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 02:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViwnZ-0004XP-1q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 02:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab3KTBll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Nov 2013 20:41:41 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50484 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab3KTBlk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 20:41:40 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so4509402pbc.10
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 17:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8sABx1bAY+pgx7rEEQpnhv55/OXbdo7pNxJPb/nnrYA=;
        b=dERQYGGxXANhct5EWW3v44LXsXbIEXsYpO727m5fJSURfqF2K5upGnuzlrTRJ9w3qy
         H2vlNx0x/oAq5A2kBuqAxBG8HaKzfUSROpZ7yocCSwBOuwK03t4/yJdTPP7bJsLXr/Iw
         DschUCuMElfM4QmenaC4MBv/LFfT1feu8o19O4aRbUt3OxD/YXM9PmdlPpmjznrliy9+
         gUBWpJKWOIXqwutMs/+4MHQuWYS3cgFEX4bGvOIAHtAUfXldagHu44wereIn5L5UuFhj
         KCkNGO3DjDMjIZQgdAvudLNbVax/JVX3ttY4T0USKt2gv64zq4v1qCq0pR+ksSWWIFqB
         2pOA==
X-Received: by 10.68.133.198 with SMTP id pe6mr29226375pbb.10.1384911699737;
        Tue, 19 Nov 2013 17:41:39 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id xv2sm33605692pbb.39.2013.11.19.17.41.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 17:41:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Nov 2013 08:41:32 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238062>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is yet another stab at the negative pathspec thing. It's not
 ready yet (there are a few XXXs) but I could use some feedback
 regarding the interface, or the behavior. It looks better this time
 now that pathspec magic is supported (or maybe I'm just biased).

 For :(glob) or :(icase) you're more likely to enable it for all
 pathspec, i.e. --glob-pathspecs. But I expect :(exclude) to be typed
 more often (it does not make sense to add --exclude-pathspecs to
 exclude everything), which is why I add the short form for it.

 We don't have many options that say "negative" in short form.
 Either '!', '-' or '~'. '!' is already used for bash history expansion=
=2E
 ~ looks more like $HOME expansion. Which left me '-'.

 Documentation/glossary-content.txt |  5 ++++
 builtin/add.c                      |  5 +++-
 dir.c                              | 50 ++++++++++++++++++++++++++++++=
+-----
 pathspec.c                         |  9 ++++++-
 pathspec.h                         |  4 ++-
 tree-walk.c                        | 52 ++++++++++++++++++++++++++++++=
+++++---
 6 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index e470661..f7d7d8c 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -377,6 +377,11 @@ full pathname may have special meaning:
  - Other consecutive asterisks are considered invalid.
 +
 Glob magic is incompatible with literal magic.
+
+exclude `-`;;
+	After a path matches any non-exclude pathspec, it will be run
+	through all exclude pathspec. If it matches, the path is
+	ignored.
 --
 +
 Currently only the slash `/` is recognized as the "magic signature",
diff --git a/builtin/add.c b/builtin/add.c
index 226f758..0df73ae 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -540,10 +540,13 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_LITERAL |
 			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE);
+			       PATHSPEC_ICASE |
+			       PATHSPEC_EXCLUDE);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
+			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
+				continue;
 			if (!seen[i] &&
 			    ((pathspec.items[i].magic &
 			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
diff --git a/dir.c b/dir.c
index 23b6de4..e2df82f 100644
--- a/dir.c
+++ b/dir.c
@@ -126,10 +126,13 @@ static size_t common_prefix_len(const struct path=
spec *pathspec)
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE);
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
 		size_t i =3D 0, len =3D 0, item_len;
+		if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
+			continue;
 		if (pathspec->items[n].magic & PATHSPEC_ICASE)
 			item_len =3D pathspec->items[n].prefix;
 		else
@@ -279,9 +282,10 @@ static int match_pathspec_item(const struct pathsp=
ec_item *item, int prefix,
  * pathspec did not match any names, which could indicate that the
  * user mistyped the nth pathspec.
  */
-int match_pathspec_depth(const struct pathspec *ps,
-			 const char *name, int namelen,
-			 int prefix, char *seen)
+static int match_pathspec_depth_1(const struct pathspec *ps,
+				  const char *name, int namelen,
+				  int prefix, char *seen,
+				  int exclude)
 {
 	int i, retval =3D 0;
=20
@@ -290,7 +294,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE);
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -309,6 +314,11 @@ int match_pathspec_depth(const struct pathspec *ps=
,
=20
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
 		int how;
+
+		if ((!exclude &&   ps->items[i].magic & PATHSPEC_EXCLUDE) ||
+		    ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)))
+			continue;
+
 		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
 			continue;
 		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
@@ -327,6 +337,16 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 		if (how) {
 			if (retval < how)
 				retval =3D how;
+			/*
+			 * seen[i] is used for detecting unused
+			 * pathspec. For excluded pathspec, it's less
+			 * obvious if seen[] should be set if the
+			 * pathspec matches.
+			 *
+			 * XXX: perhaps we should also set seen[] for
+			 * exclude patterns and stop e.g. "git add"
+			 * from complaining?
+			 */
 			if (seen && seen[i] < how)
 				seen[i] =3D how;
 		}
@@ -334,6 +354,18 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 	return retval;
 }
=20
+int match_pathspec_depth(const struct pathspec *ps,
+			 const char *name, int namelen,
+			 int prefix, char *seen)
+{
+	int positive, negative;
+	positive =3D match_pathspec_depth_1(ps, name, namelen, prefix, seen, =
0);
+	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
+		return positive;
+	negative =3D match_pathspec_depth_1(ps, name, namelen, prefix, seen, =
1);
+	return negative ? 0 : positive;
+}
+
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
@@ -1375,11 +1407,17 @@ int read_directory(struct dir_struct *dir, cons=
t char *path, int len, const stru
 			       PATHSPEC_MAXDEPTH |
 			       PATHSPEC_LITERAL |
 			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE);
+			       PATHSPEC_ICASE |
+			       PATHSPEC_EXCLUDE);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
+	/*
+	 * XXX: exclude patterns are treated like positive ones in
+	 * create_simplify! This is not wrong, but may make path
+	 * filtering less efficient.
+	 */
 	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
diff --git a/pathspec.c b/pathspec.c
index 4cf2bd3..a021959 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -71,6 +71,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_LITERAL,   0, "literal" },
 	{ PATHSPEC_GLOB,   '\0', "glob" },
 	{ PATHSPEC_ICASE,  '\0', "icase" },
+	{ PATHSPEC_EXCLUDE, '-', "exclude" },
 };
=20
 /*
@@ -355,7 +356,7 @@ void parse_pathspec(struct pathspec *pathspec,
 {
 	struct pathspec_item *item;
 	const char *entry =3D argv ? *argv : NULL;
-	int i, n, prefixlen;
+	int i, n, prefixlen, nr_exclude =3D 0;
=20
 	memset(pathspec, 0, sizeof(*pathspec));
=20
@@ -412,6 +413,8 @@ void parse_pathspec(struct pathspec *pathspec,
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
 		    !(magic_mask & PATHSPEC_LITERAL))
 			item[i].magic |=3D PATHSPEC_LITERAL;
+		if (item[i].magic & PATHSPEC_EXCLUDE)
+			nr_exclude++;
 		if (item[i].magic & magic_mask)
 			unsupported_magic(entry,
 					  item[i].magic & magic_mask,
@@ -427,6 +430,10 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |=3D item[i].magic;
 	}
=20
+	if (nr_exclude =3D=3D n)
+		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
+		      "Perhaps you forgot to add either ':/' or '.' ?"));
+
=20
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
diff --git a/pathspec.h b/pathspec.h
index a75e924..0c11262 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -7,12 +7,14 @@
 #define PATHSPEC_LITERAL	(1<<2)
 #define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ICASE		(1<<4)
+#define PATHSPEC_EXCLUDE	(1<<5)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
 	 PATHSPEC_GLOB		| \
-	 PATHSPEC_ICASE)
+	 PATHSPEC_ICASE		| \
+	 PATHSPEC_EXCLUDE)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONES=
TAR */
=20
diff --git a/tree-walk.c b/tree-walk.c
index 5ece8c3..9011f87 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -662,9 +662,10 @@ static int match_wildcard_base(const struct pathsp=
ec_item *item,
  * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
  * or base[baselen-1] =3D=3D '/' (i.e. with trailing slash).
  */
-enum interesting tree_entry_interesting(const struct name_entry *entry=
,
-					struct strbuf *base, int base_offset,
-					const struct pathspec *ps)
+static enum interesting tree_entry_interesting_1(const struct name_ent=
ry *entry,
+						 struct strbuf *base, int base_offset,
+						 const struct pathspec *ps,
+						 int exclude)
 {
 	int i;
 	int pathlen, baselen =3D base->len - base_offset;
@@ -676,7 +677,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE);
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -697,6 +699,10 @@ enum interesting tree_entry_interesting(const stru=
ct name_entry *entry,
 		const char *base_str =3D base->buf + base_offset;
 		int matchlen =3D item->len, matched =3D 0;
=20
+		if ((!exclude &&   item->magic & PATHSPEC_EXCLUDE) ||
+		    ( exclude && !(item->magic & PATHSPEC_EXCLUDE)))
+			continue;
+
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(item, base_str, match, matchlen))
@@ -782,3 +788,41 @@ match_wildcards:
 	}
 	return never_interesting; /* No matches */
 }
+
+enum interesting tree_entry_interesting(const struct name_entry *entry=
,
+					struct strbuf *base, int base_offset,
+					const struct pathspec *ps)
+{
+	enum interesting positive, negative;
+	positive =3D tree_entry_interesting_1(entry, base, base_offset, ps, 0=
);
+
+	/*
+	 *   #  | positive | negative | result
+	 * -----+----------+----------+-------
+	 * 1..4 |   -1     |    *     |  -1
+	 * 5..8 |    0     |    *     |   0
+	 *   9  |    1     |   -1     |   1
+	 *  10  |    1     |    0     |   1
+	 *  11  |    1     |    1     |   0
+	 *  12  |    1     |    2     |   0
+	 *  13  |    2     |   -1     |   2
+	 *  14  |    2     |    0     |   2
+	 *  15  |    2     |    1     |   0
+	 *  16  |    2     |    2     |  -1
+	 */
+
+	if (!(ps->magic & PATHSPEC_EXCLUDE) ||
+	    positive <=3D entry_not_interesting) /* #1..#8 */
+		return positive;
+
+	negative =3D tree_entry_interesting_1(entry, base, base_offset, ps, 1=
);
+
+	if (negative <=3D entry_not_interesting)	 /* #9, #10, #13, #14 */
+		return positive;
+	if ((positive =3D=3D entry_interesting &&
+	     negative >=3D entry_interesting) || /* #11, #12 */
+	    (positive =3D=3D all_entries_interesting &&
+	     negative =3D=3D entry_interesting)) /* #15 */
+		return entry_not_interesting;
+	return all_entries_not_interesting; /* #16 */
+}
--=20
1.8.2.82.gc24b958
