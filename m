From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 04/11] tree-walk.c: do not leak internal structure in tree_entry_len()
Date: Mon, 24 Oct 2011 17:36:09 +1100
Message-ID: <1319438176-7304-5-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEBU-0000js-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab1JXGiw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:38:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55823 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1JXGiv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:38:51 -0400
Received: by yxl42 with SMTP id 42so2864889yxl.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sXH2MNdE9ymVbyGf8coMY6ufkhsJWt/rwoXS+RLM7pU=;
        b=fsZc4DQg7c3JnmqePdHi0oXV9sTI54L0eR32YcGpGPz55GVcjkXrhPiSYMeXWBqsZE
         D8HY6Wo97dhZ0FL3kQVoIuvXzuymP9ZDOg0h6W5VARN/MdajMRJ3GZfj1KnjmQW6Obs5
         QiZacacvY8Yu6R63kypuNfXNv7z/zAYX2zDNM=
Received: by 10.236.200.131 with SMTP id z3mr17196341yhn.129.1319438330710;
        Sun, 23 Oct 2011 23:38:50 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id s42sm31224052yhs.0.2011.10.23.23.38.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:38:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:37:01 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184157>

tree_entry_len() does not simply take two random arguments and return
a tree length. The two pointers must point to a tree item structure,
or struct name_entry. Passing random pointers will return incorrect
value.

=46orce callers to pass struct name_entry instead of two pointers (with
hope that they don't manually construct struct name_entry themselves)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c         |    2 +-
 builtin/pack-objects.c |    2 +-
 tree-diff.c            |    6 +++---
 tree-walk.c            |   16 ++++++++--------
 tree-walk.h            |    6 +++---
 tree.c                 |    2 +-
 unpack-trees.c         |    6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7d0779f..2cd0612 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -547,7 +547,7 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
 	int old_baselen =3D base->len;
=20
 	while (tree_entry(tree, &entry)) {
-		int te_len =3D tree_entry_len(entry.path, entry.sha1);
+		int te_len =3D tree_entry_len(&entry);
=20
 		if (match !=3D 2) {
 			match =3D tree_entry_interesting(&entry, base, tn_len, pathspec);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2b18de5..864154b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -975,7 +975,7 @@ static void add_pbase_object(struct tree_desc *tree=
,
 	while (tree_entry(tree,&entry)) {
 		if (S_ISGITLINK(entry.mode))
 			continue;
-		cmp =3D tree_entry_len(entry.path, entry.sha1) !=3D cmplen ? 1 :
+		cmp =3D tree_entry_len(&entry) !=3D cmplen ? 1 :
 		      memcmp(name, entry.path, cmplen);
 		if (cmp > 0)
 			continue;
diff --git a/tree-diff.c b/tree-diff.c
index b3cc2e4..6782484 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -21,8 +21,8 @@ static int compare_tree_entry(struct tree_desc *t1, s=
truct tree_desc *t2,
 	sha1 =3D tree_entry_extract(t1, &path1, &mode1);
 	sha2 =3D tree_entry_extract(t2, &path2, &mode2);
=20
-	pathlen1 =3D tree_entry_len(path1, sha1);
-	pathlen2 =3D tree_entry_len(path2, sha2);
+	pathlen1 =3D tree_entry_len(&t1->entry);
+	pathlen2 =3D tree_entry_len(&t2->entry);
 	cmp =3D base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mo=
de2);
 	if (cmp < 0) {
 		show_entry(opt, "-", t1, base);
@@ -85,7 +85,7 @@ static void show_entry(struct diff_options *opt, cons=
t char *prefix,
 	unsigned mode;
 	const char *path;
 	const unsigned char *sha1 =3D tree_entry_extract(desc, &path, &mode);
-	int pathlen =3D tree_entry_len(path, sha1);
+	int pathlen =3D tree_entry_len(&desc->entry);
 	int old_baselen =3D base->len;
=20
 	strbuf_add(base, path, pathlen);
diff --git a/tree-walk.c b/tree-walk.c
index 418107e..f5d19f9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -116,7 +116,7 @@ void setup_traverse_info(struct traverse_info *info=
, const char *base)
=20
 char *make_traverse_path(char *path, const struct traverse_info *info,=
 const struct name_entry *n)
 {
-	int len =3D tree_entry_len(n->path, n->sha1);
+	int len =3D tree_entry_len(n);
 	int pathlen =3D info->pathlen;
=20
 	path[pathlen + len] =3D 0;
@@ -126,7 +126,7 @@ char *make_traverse_path(char *path, const struct t=
raverse_info *info, const str
 			break;
 		path[--pathlen] =3D '/';
 		n =3D &info->name;
-		len =3D tree_entry_len(n->path, n->sha1);
+		len =3D tree_entry_len(n);
 		info =3D info->prev;
 		pathlen -=3D len;
 	}
@@ -253,7 +253,7 @@ static void extended_entry_extract(struct tree_desc=
_x *t,
 	 * The caller wants "first" from this tree, or nothing.
 	 */
 	path =3D a->path;
-	len =3D tree_entry_len(a->path, a->sha1);
+	len =3D tree_entry_len(a);
 	switch (check_entry_match(first, first_len, path, len)) {
 	case -1:
 		entry_clear(a);
@@ -271,7 +271,7 @@ static void extended_entry_extract(struct tree_desc=
_x *t,
 	while (probe.size) {
 		entry_extract(&probe, a);
 		path =3D a->path;
-		len =3D tree_entry_len(a->path, a->sha1);
+		len =3D tree_entry_len(a);
 		switch (check_entry_match(first, first_len, path, len)) {
 		case -1:
 			entry_clear(a);
@@ -362,7 +362,7 @@ int traverse_trees(int n, struct tree_desc *t, stru=
ct traverse_info *info)
 			e =3D entry + i;
 			if (!e->path)
 				continue;
-			len =3D tree_entry_len(e->path, e->sha1);
+			len =3D tree_entry_len(e);
 			if (!first) {
 				first =3D e->path;
 				first_len =3D len;
@@ -381,7 +381,7 @@ int traverse_trees(int n, struct tree_desc *t, stru=
ct traverse_info *info)
 				/* Cull the ones that are not the earliest */
 				if (!e->path)
 					continue;
-				len =3D tree_entry_len(e->path, e->sha1);
+				len =3D tree_entry_len(e);
 				if (name_compare(e->path, len, first, first_len))
 					entry_clear(e);
 			}
@@ -434,8 +434,8 @@ static int find_tree_entry(struct tree_desc *t, con=
st char *name, unsigned char
 		int entrylen, cmp;
=20
 		sha1 =3D tree_entry_extract(t, &entry, mode);
+		entrylen =3D tree_entry_len(&t->entry);
 		update_tree_entry(t);
-		entrylen =3D tree_entry_len(entry, sha1);
 		if (entrylen > namelen)
 			continue;
 		cmp =3D memcmp(name, entry, entrylen);
@@ -596,7 +596,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
 				      ps->max_depth);
 	}
=20
-	pathlen =3D tree_entry_len(entry->path, entry->sha1);
+	pathlen =3D tree_entry_len(entry);
=20
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
 		const struct pathspec_item *item =3D ps->items+i;
diff --git a/tree-walk.h b/tree-walk.h
index 0089581..884d01a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -20,9 +20,9 @@ static inline const unsigned char *tree_entry_extract=
(struct tree_desc *desc, co
 	return desc->entry.sha1;
 }
=20
-static inline int tree_entry_len(const char *name, const unsigned char=
 *sha1)
+static inline int tree_entry_len(const struct name_entry *ne)
 {
-	return (const char *)sha1 - name - 1;
+	return (const char *)ne->sha1 - ne->path - 1;
 }
=20
 void update_tree_entry(struct tree_desc *);
@@ -58,7 +58,7 @@ extern void setup_traverse_info(struct traverse_info =
*info, const char *base);
=20
 static inline int traverse_path_len(const struct traverse_info *info, =
const struct name_entry *n)
 {
-	return info->pathlen + tree_entry_len(n->path, n->sha1);
+	return info->pathlen + tree_entry_len(n);
 }
=20
 extern int tree_entry_interesting(const struct name_entry *, struct st=
rbuf *, int, const struct pathspec *ps);
diff --git a/tree.c b/tree.c
index 698ecf7..e622198 100644
--- a/tree.c
+++ b/tree.c
@@ -99,7 +99,7 @@ static int read_tree_1(struct tree *tree, struct strb=
uf *base,
 		else
 			continue;
=20
-		len =3D tree_entry_len(entry.path, entry.sha1);
+		len =3D tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
 		retval =3D read_tree_1(lookup_tree(sha1),
diff --git a/unpack-trees.c b/unpack-trees.c
index 8282f5e..7c9ecf6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -446,7 +446,7 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
 	newinfo.prev =3D info;
 	newinfo.pathspec =3D info->pathspec;
 	newinfo.name =3D *p;
-	newinfo.pathlen +=3D tree_entry_len(p->path, p->sha1) + 1;
+	newinfo.pathlen +=3D tree_entry_len(p) + 1;
 	newinfo.conflicts |=3D df_conflicts;
=20
 	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
@@ -495,7 +495,7 @@ static int do_compare_entry(const struct cache_entr=
y *ce, const struct traverse_
 	ce_len -=3D pathlen;
 	ce_name =3D ce->name + pathlen;
=20
-	len =3D tree_entry_len(n->path, n->sha1);
+	len =3D tree_entry_len(n);
 	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mod=
e);
 }
=20
@@ -626,7 +626,7 @@ static int find_cache_pos(struct traverse_info *inf=
o,
 	struct unpack_trees_options *o =3D info->data;
 	struct index_state *index =3D o->src_index;
 	int pfxlen =3D info->pathlen;
-	int p_len =3D tree_entry_len(p->path, p->sha1);
+	int p_len =3D tree_entry_len(p);
=20
 	for (pos =3D o->cache_bottom; pos < index->cache_nr; pos++) {
 		struct cache_entry *ce =3D index->cache[pos];
--=20
1.7.3.1.256.g2539c.dirty
