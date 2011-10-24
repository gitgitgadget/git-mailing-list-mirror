From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 05/11] symbolize return values of tree_entry_interesting()
Date: Mon, 24 Oct 2011 17:36:10 +1100
Message-ID: <1319438176-7304-6-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEBg-0000q0-86
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab1JXGjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59080 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1JXGjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:01 -0400
Received: by mail-yw0-f46.google.com with SMTP id 3so1171021ywm.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ieBZl30OIfB8NN2f6t54TP29qYkgPOripTWxi3Dtxmg=;
        b=o845ZzOQU28j1hZVfZIYaH8MeiLlps2b7GTaVyfK/vrUcUL7JdeNv1rdrQ+q+8Wgid
         LClhXlObEAV3RgvN7JzPYAnzbU33JLa++utSApIDbsBt4STh4d0rrIlfBPalzm7/FzP8
         +DAjB+O6agTLcr79ijnSaRgzjQAkrPDNhC6lo=
Received: by 10.236.177.100 with SMTP id c64mr32672418yhm.109.1319438341245;
        Sun, 23 Oct 2011 23:39:01 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id c8sm31177442yhm.14.2011.10.23.23.38.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:37:17 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184158>

This helps extending the value later on for "interesting, but cannot
decide if the entry truely matches yet" (ie. prefix matches)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |    9 +++++----
 list-objects.c |    9 +++++----
 tree-diff.c    |   13 +++++++------
 tree-walk.c    |   45 +++++++++++++++++++++------------------------
 tree-walk.h    |   12 +++++++++++-
 tree.c         |    9 +++++----
 6 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2cd0612..2fc51fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -542,18 +542,19 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
 static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len)
 {
-	int hit =3D 0, match =3D 0;
+	int hit =3D 0;
+	enum interesting match =3D entry_not_interesting;
 	struct name_entry entry;
 	int old_baselen =3D base->len;
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(&entry);
=20
-		if (match !=3D 2) {
+		if (match !=3D all_entries_interesting) {
 			match =3D tree_entry_interesting(&entry, base, tn_len, pathspec);
-			if (match < 0)
+			if (match =3D=3D all_entries_not_interesting)
 				break;
-			if (match =3D=3D 0)
+			if (match =3D=3D entry_not_interesting)
 				continue;
 		}
=20
diff --git a/list-objects.c b/list-objects.c
index 39d80c0..3dd4a96 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -71,7 +71,8 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
-	int match =3D revs->diffopt.pathspec.nr =3D=3D 0 ? 2 : 0;
+	enum interesting match =3D revs->diffopt.pathspec.nr =3D=3D 0 ?
+		all_entries_interesting: entry_not_interesting;
 	int baselen =3D base->len;
=20
 	if (!revs->tree_objects)
@@ -97,12 +98,12 @@ static void process_tree(struct rev_info *revs,
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
-		if (match !=3D 2) {
+		if (match !=3D all_entries_interesting) {
 			match =3D tree_entry_interesting(&entry, base, 0,
 						       &revs->diffopt.pathspec);
-			if (match < 0)
+			if (match =3D=3D all_entries_not_interesting)
 				break;
-			if (match =3D=3D 0)
+			if (match =3D=3D entry_not_interesting)
 				continue;
 		}
=20
diff --git a/tree-diff.c b/tree-diff.c
index 6782484..25cc981 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -64,14 +64,14 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2,
 static void show_tree(struct diff_options *opt, const char *prefix,
 		      struct tree_desc *desc, struct strbuf *base)
 {
-	int match =3D 0;
+	enum interesting match =3D entry_not_interesting;
 	for (; desc->size; update_tree_entry(desc)) {
-		if (match !=3D 2) {
+		if (match !=3D all_entries_interesting) {
 			match =3D tree_entry_interesting(&desc->entry, base, 0,
 						       &opt->pathspec);
-			if (match < 0)
+			if (match =3D=3D all_entries_not_interesting)
 				break;
-			if (match =3D=3D 0)
+			if (match =3D=3D entry_not_interesting)
 				continue;
 		}
 		show_entry(opt, prefix, desc, base);
@@ -114,12 +114,13 @@ static void show_entry(struct diff_options *opt, =
const char *prefix,
 }
=20
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
-			       struct diff_options *opt, int *match)
+			       struct diff_options *opt,
+			       enum interesting *match)
 {
 	while (t->size) {
 		*match =3D tree_entry_interesting(&t->entry, base, 0, &opt->pathspec=
);
 		if (*match) {
-			if (*match < 0)
+			if (*match =3D=3D all_entries_not_interesting)
 				t->size =3D 0;
 			break;
 		}
diff --git a/tree-walk.c b/tree-walk.c
index f5d19f9..fc03262 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -573,27 +573,23 @@ static int match_dir_prefix(const char *base,
  *
  * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
  * or base[baselen-1] =3D=3D '/' (i.e. with trailing slash).
- *
- * Return:
- *  - 2 for "yes, and all subsequent entries will be"
- *  - 1 for yes
- *  - zero for no
- *  - negative for "no, and no subsequent entries will be either"
  */
-int tree_entry_interesting(const struct name_entry *entry,
-			   struct strbuf *base, int base_offset,
-			   const struct pathspec *ps)
+enum interesting tree_entry_interesting(const struct name_entry *entry=
,
+					struct strbuf *base, int base_offset,
+					const struct pathspec *ps)
 {
 	int i;
 	int pathlen, baselen =3D base->len - base_offset;
-	int never_interesting =3D ps->has_wildcard ? 0 : -1;
+	int never_interesting =3D ps->has_wildcard ?
+		entry_not_interesting : all_entries_not_interesting;
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
-			return 2;
-		return !!within_depth(base->buf + base_offset, baselen,
-				      !!S_ISDIR(entry->mode),
-				      ps->max_depth);
+			return all_entries_interesting;
+		return within_depth(base->buf + base_offset, baselen,
+				    !!S_ISDIR(entry->mode),
+				    ps->max_depth) ?
+			entry_interesting : entry_not_interesting;
 	}
=20
 	pathlen =3D tree_entry_len(entry);
@@ -610,12 +606,13 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 				goto match_wildcards;
=20
 			if (!ps->recursive || ps->max_depth =3D=3D -1)
-				return 2;
+				return all_entries_interesting;
=20
-			return !!within_depth(base_str + matchlen + 1,
-					      baselen - matchlen - 1,
-					      !!S_ISDIR(entry->mode),
-					      ps->max_depth);
+			return within_depth(base_str + matchlen + 1,
+					    baselen - matchlen - 1,
+					    !!S_ISDIR(entry->mode),
+					    ps->max_depth) ?
+				entry_interesting : entry_not_interesting;
 		}
=20
 		/* Either there must be no base, or the base must match. */
@@ -623,18 +620,18 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
-				return 1;
+				return entry_interesting;
=20
 			if (ps->items[i].use_wildcard) {
 				if (!fnmatch(match + baselen, entry->path, 0))
-					return 1;
+					return entry_interesting;
=20
 				/*
 				 * Match all directories. We'll try to
 				 * match files later on.
 				 */
 				if (ps->recursive && S_ISDIR(entry->mode))
-					return 1;
+					return entry_interesting;
 			}
=20
 			continue;
@@ -653,7 +650,7 @@ match_wildcards:
=20
 		if (!fnmatch(match, base->buf + base_offset, 0)) {
 			strbuf_setlen(base, base_offset + baselen);
-			return 1;
+			return entry_interesting;
 		}
 		strbuf_setlen(base, base_offset + baselen);
=20
@@ -662,7 +659,7 @@ match_wildcards:
 		 * later on.
 		 */
 		if (ps->recursive && S_ISDIR(entry->mode))
-			return 1;
+			return entry_interesting;
 	}
 	return never_interesting; /* No matches */
 }
diff --git a/tree-walk.h b/tree-walk.h
index 884d01a..2bf0db9 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -61,6 +61,16 @@ static inline int traverse_path_len(const struct tra=
verse_info *info, const stru
 	return info->pathlen + tree_entry_len(n);
 }
=20
-extern int tree_entry_interesting(const struct name_entry *, struct st=
rbuf *, int, const struct pathspec *ps);
+/* in general, positive means "kind of interesting" */
+enum interesting {
+	all_entries_not_interesting =3D -1, /* no, and no subsequent entries =
will be either */
+	entry_not_interesting =3D 0,
+	entry_interesting =3D 1,
+	all_entries_interesting =3D 2 /* yes, and all subsequent entries will=
 be */
+};
+
+extern enum interesting tree_entry_interesting(const struct name_entry=
 *,
+					       struct strbuf *, int,
+					       const struct pathspec *ps);
=20
 #endif
diff --git a/tree.c b/tree.c
index e622198..676e9f7 100644
--- a/tree.c
+++ b/tree.c
@@ -52,7 +52,8 @@ static int read_tree_1(struct tree *tree, struct strb=
uf *base,
 	struct tree_desc desc;
 	struct name_entry entry;
 	unsigned char sha1[20];
-	int len, retval =3D 0, oldlen =3D base->len;
+	int len, oldlen =3D base->len;
+	enum interesting retval =3D entry_not_interesting;
=20
 	if (parse_tree(tree))
 		return -1;
@@ -60,11 +61,11 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
-		if (retval !=3D 2) {
+		if (retval !=3D all_entries_interesting) {
 			retval =3D tree_entry_interesting(&entry, base, 0, pathspec);
-			if (retval < 0)
+			if (retval =3D=3D all_entries_not_interesting)
 				break;
-			if (retval =3D=3D 0)
+			if (retval =3D=3D entry_not_interesting)
 				continue;
 		}
=20
--=20
1.7.3.1.256.g2539c.dirty
