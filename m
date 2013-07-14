From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/46] parse_pathspec: add special flag for max_depth feature
Date: Sun, 14 Jul 2013 15:35:32 +0700
Message-ID: <1373790969-13000-10-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHo2-0001b3-7x
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3GNIhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:15 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50909 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:13 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so9875193pdj.22
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=y0RXRL49YyAwA/F+r6xNkYqpCjLFbPn4lqTRaHVXAGU=;
        b=t8MRmHvnI8iFFe+3YuxO3Qayn7lSeIKdLvLSuQ3lJi2CxR7rBpJEwwR7/mSWD2rpX3
         OsUfym8Yyt/G6jMO/awa+2osRM6ecHltl1IMfm4Ix5yMt9QhOv8AL9zlFaxEf7Ep1rir
         O6yVqxtAFiw0BwYWWYpPeV3RLKDHCY8vWgfFkdq4cDM+RucJe8dTiDs+97xbILSnJ4rK
         bMXJrSFDjyXSMtf+5wSGFilEgViIn/dmMqgoV2jkk4Zd0NVolhE2MMw3iBQeLaD6cWw0
         8qSN3lHNRLiyYQ7xC/c2skTBKKivlfaffaRqT5C82hFamsWIIOQJ5INlKCH/2wEvCiaj
         NqzQ==
X-Received: by 10.66.155.163 with SMTP id vx3mr39361644pab.67.1373791032608;
        Sun, 14 Jul 2013 01:37:12 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id iq6sm54582055pbc.1.2013.07.14.01.37.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230321>

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
index b6f4b21..d4e17f7 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -476,7 +476,6 @@ static int diff_cache(struct rev_info *revs,
 	opts.dst_index =3D NULL;
 	opts.pathspec =3D &revs->diffopt.pathspec;
 	opts.pathspec->recursive =3D 1;
-	opts.pathspec->max_depth =3D -1;
=20
 	init_tree_desc(&t, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
diff --git a/dir.c b/dir.c
index 308028e..e28bc0d 100644
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
index 6d99a3d..06778fc 100644
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
