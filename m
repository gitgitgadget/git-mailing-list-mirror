From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/45] parse_pathspec: a special flag for max_depth feature
Date: Sun,  9 Jun 2013 13:25:42 +0700
Message-ID: <1370759178-1709-10-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4d-0008Or-AU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab3FIGZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50658 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab3FIGZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:50 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so796828pdj.22
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4Zfc4TE1le1pL1Nntm18qYYRyvtzmGGE7DcpHqD/Uow=;
        b=z4tDAoLjCU92NPApMWVUcxOB4wUqwch9TOPk5lciRqhgMElLjF1ipZaqGVaaOE8t2j
         Ivro9MY8FWXpeKMt6J4jszQ28UNdYl1/rEsV3N2HGGfg+voVHEllvj2hBipQqd3/zU+D
         VAO7TwN6xOzDZyYbpjPBR7VYihe0OKJJghQApxCJ2uOh35K0hRqhm+fYoqRuU+P5EWWD
         iNPthBOI9jPnlAwuTunf4xXiPseeE3gifS8ZSk8ldFJGIDtrdb9nqyY+/lUBDwyE5KTG
         xM6fe9O/FSmsAYtN4wazsvtodsnbj/y93QwBnkzDYAbmQJiEqU5WRu2juTes2AQOu/DR
         urcQ==
X-Received: by 10.66.118.129 with SMTP id km1mr9001827pab.112.1370759150141;
        Sat, 08 Jun 2013 23:25:50 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id ov2sm5496052pbc.34.2013.06.08.23.25.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:21 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226901>

match_pathspec_depth() and tree_entry_interesting() check max_depth
field in order to support "git grep --max-depth". The feature
activation is tied to "recursive" field, which led to some unwanted
activation, e.g. 5c8eeb8 (diff-index: enable recursive pathspec
matching in unpack_trees - 2012-01-15).

This patch decouples the activation from "recursive" field, puts it in
"magic" field instead. This makes sure that only "git grep" can
activate this feature. And because parse_pathspec knows when the
feature is not used, it does not need to sort pathspec (required for
max_depth to work correctly). A small win for non-grep cases.

Even though a new magic flag is introduced, no magic syntax is. The
magic can be only enabled by parse_pathspec() caller. We might someday
want to support ":(maxdepth:10)src." It all depends on actual use
cases.

max_depth feature cannot be enabled via init_pathspec() anymore. But
that's ok because init_pathspec() is on its way to /dev/null.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 3 ++-
 diff-lib.c     | 1 -
 dir.c          | 8 ++++++--
 pathspec.c     | 8 ++++++--
 pathspec.h     | 6 +++++-
 tree-diff.c    | 1 -
 tree-walk.c    | 8 ++++++--
 7 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 1a6c028..4bc0754 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -858,7 +858,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
+		       PATHSPEC_PREFER_CWD |
+		       (opt.max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
 		       prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..4729157 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -474,7 +474,6 @@ static int diff_cache(struct rev_info *revs,
 	opts.dst_index =3D NULL;
 	opts.pathspec =3D &revs->diffopt.pathspec;
 	opts.pathspec->recursive =3D 1;
-	opts.pathspec->max_depth =3D -1;
=20
 	init_tree_desc(&t, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
diff --git a/dir.c b/dir.c
index c0b284f..cfcdda5 100644
--- a/dir.c
+++ b/dir.c
@@ -341,7 +341,9 @@ int match_pathspec_depth(const struct pathspec *ps,
 	int i, retval =3D 0;
=20
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth =3D=3D -1)
+		if (!ps->recursive ||
+		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
+		    ps->max_depth =3D=3D -1)
 			return MATCHED_RECURSIVELY;
=20
 		if (within_depth(name, namelen, 0, ps->max_depth))
@@ -358,7 +360,9 @@ int match_pathspec_depth(const struct pathspec *ps,
 		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
 			continue;
 		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
-		if (ps->recursive && ps->max_depth !=3D -1 &&
+		if (ps->recursive &&
+		    (ps->magic & PATHSPEC_MAXDEPTH) &&
+		    ps->max_depth !=3D -1 &&
 		    how && how !=3D MATCHED_FNMATCH) {
 			int len =3D ps->items[i].len;
 			if (name[len] =3D=3D '/')
diff --git a/pathspec.c b/pathspec.c
index 9e68321..a352ef1 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -267,6 +267,9 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	memset(pathspec, 0, sizeof(*pathspec));
=20
+	if (flags & PATHSPEC_MAXDEPTH_VALID)
+		pathspec->magic |=3D PATHSPEC_MAXDEPTH;
+
 	/* No arguments, no prefix -> no pathspec */
 	if (!entry && !prefix)
 		return;
@@ -322,8 +325,9 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |=3D item[i].magic;
 	}
=20
-	qsort(pathspec->items, pathspec->nr,
-	      sizeof(struct pathspec_item), pathspec_item_cmp);
+	if (pathspec->magic & PATHSPEC_MAXDEPTH)
+		qsort(pathspec->items, pathspec->nr,
+		      sizeof(struct pathspec_item), pathspec_item_cmp);
 }
=20
 /*
diff --git a/pathspec.h b/pathspec.h
index d630e8b..aa98597 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -3,7 +3,10 @@
=20
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
-#define PATHSPEC_ALL_MAGIC PATHSPEC_FROMTOP
+#define PATHSPEC_MAXDEPTH	(1<<1)
+#define PATHSPEC_ALL_MAGIC	  \
+	(PATHSPEC_FROMTOP	| \
+	 PATHSPEC_MAXDEPTH)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
@@ -27,6 +30,7 @@ struct pathspec {
 /* parse_pathspec flags */
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
+#define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
diff --git a/tree-diff.c b/tree-diff.c
index ba01563..826512e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -138,7 +138,6 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
-	opt->pathspec.max_depth =3D -1;
=20
 	strbuf_init(&base, PATH_MAX);
 	strbuf_add(&base, base_str, baselen);
diff --git a/tree-walk.c b/tree-walk.c
index 72a9613..d399ca9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -637,7 +637,9 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		entry_not_interesting : all_entries_not_interesting;
=20
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth =3D=3D -1)
+		if (!ps->recursive ||
+		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
+		    ps->max_depth =3D=3D -1)
 			return all_entries_interesting;
 		return within_depth(base->buf + base_offset, baselen,
 				    !!S_ISDIR(entry->mode),
@@ -658,7 +660,9 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 			if (!match_dir_prefix(base_str, match, matchlen))
 				goto match_wildcards;
=20
-			if (!ps->recursive || ps->max_depth =3D=3D -1)
+			if (!ps->recursive ||
+			    !(ps->magic & PATHSPEC_MAXDEPTH) ||
+			    ps->max_depth =3D=3D -1)
 				return all_entries_interesting;
=20
 			return within_depth(base_str + matchlen + 1,
--=20
1.8.2.83.gc99314b
