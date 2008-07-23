From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 04/12] Protect index with sparse prefix
Date: Wed, 23 Jul 2008 21:56:17 +0700
Message-ID: <20080723145616.GA29090@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfme-0002Xt-5c
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbYGWO4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYGWO4i
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:56:38 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWO4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:56:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=jZ3oSUo7449UZRdPW80P9kA5vWFS6V9nFA/Vmjsv53o=;
        b=ux5JCoQB7Sv9UHJ52wTx6tXRsQT6b0TBY2qvbuCebJosHByGY4nt3Qrqlu2uMpCuei
         x4JBGDEW6z89Sgz7A0zIZK4TJMsffJZXheClcCMuVL1dfyfGiaDTaw5hwfxU/IzfqmkF
         aeWNAmahbqjFK3oOd5dHWPC1NNZGp97V2dVWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=KBkzogT0jP18r+jFhLQd+NpC0uOe9lKVyAW1QMJ100b4k42om+Pt7iiAOHnegxDQbM
         oiHPYsqUGCN5sCKcW/RA8RjettItn6FrxGjovp0LZakQwh/A3QDtOAdVXzCspK2nBeFg
         KLeQD5G/6x55Nq/PhZRgTbWhugmA8Qg5lynsM=
Received: by 10.110.5.18 with SMTP id 18mr97281tie.43.1216824996418;
        Wed, 23 Jul 2008 07:56:36 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id b4sm15417784tic.14.2008.07.23.07.56.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:56:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:56:17 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89673>

This ensures no one can write to index outside sparse prefix.
Protection is usually applied to the_index only. For more
complicated cases where temporary index is required, thorough
check will be done by check_index_prefix()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-commit.c          |   11 +++++
 builtin-ls-files.c        |    2 +
 builtin-merge-recursive.c |    4 +-
 builtin-read-tree.c       |    5 ++
 cache.h                   |    1 +
 diff-lib.c                |    3 +
 read-cache.c              |  107 +++++++++++++++++++++++++++++++++++++=
+++++++-
 unpack-trees.c            |    3 +
 unpack-trees.h            |    3 +-
 9 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 97e64de..f2d301a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -223,6 +223,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix)
 	int fd;
 	struct string_list partial;
 	const char **pathspec =3D NULL;
+	char **saved_sparse_prefix;
=20
 	if (interactive) {
 		interactive_add(argc, argv, prefix);
@@ -306,6 +307,13 @@ static char *prepare_index(int argc, const char **=
argv, const char *prefix)
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
+
+	/*
+	 * this code modifies index but won't write down anything
+	 * so it's safe to turn of sparse_prefix protection for a while
+	 */
+	saved_sparse_prefix =3D save_sparse_prefix();
+
 	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, path=
spec))
 		exit(1);
=20
@@ -313,6 +321,9 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix)
 	if (read_cache() < 0)
 		die("cannot read the index");
=20
+	/* re-enable sparse_prefix again */
+	restore_sparse_prefix(saved_sparse_prefix);
+
 	fd =3D hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e8d568e..4d18873 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -606,6 +606,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
+		/* no need to restore as ls-files never writes index */
+		save_sparse_prefix();
 		overlay_tree_on_cache(with_tree, prefix);
 	}
 	show_files(&dir, prefix);
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 43e55bf..7ce015b 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -201,8 +201,10 @@ static int git_merge_trees(int index_only,
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
 		opts.index_only =3D 1;
-	else
+	else {
 		opts.update =3D 1;
+		opts.check_index_prefix =3D 1;
+	}
 	opts.merge =3D 1;
 	opts.head_idx =3D 2;
 	opts.fn =3D threeway_merge;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 72a6de3..0883b41 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -218,6 +218,11 @@ int cmd_read_tree(int argc, const char **argv, con=
st char *unused_prefix)
 			opts.head_idx =3D 1;
 	}
=20
+	if (get_sparse_prefix()) {
+		read_cache();
+		opts.check_index_prefix =3D 1;
+	}
+
 	for (i =3D 0; i < nr_trees; i++) {
 		struct tree *tree =3D trees[i];
 		parse_tree(tree);
diff --git a/cache.h b/cache.h
index 4687096..f6bbadc 100644
--- a/cache.h
+++ b/cache.h
@@ -331,6 +331,7 @@ extern char **split_prefix(const char *env);
 extern char **combine_prefix_list(char **p1, char **p2);
 extern void free_prefix_list(char **prefix_list);
 extern int outside_prefix_list(char **iprefix, const char *prefix);
+extern int check_index_prefix(const struct index_state *index, int is_=
merge);
=20
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
diff --git a/diff-lib.c b/diff-lib.c
index e7eaff9..2908146 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,6 +73,9 @@ int run_diff_files(struct rev_info *revs, unsigned in=
t option)
 		struct cache_entry *ce =3D active_cache[i];
 		int changed;
=20
+		if (index_outside_sparse_prefix(ce->name))
+			continue;
+
 		if (DIFF_OPT_TST(&revs->diffopt, QUIET) &&
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
diff --git a/read-cache.c b/read-cache.c
index a50a851..4fea40e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,11 @@
=20
 struct index_state the_index;
=20
+static int outside_cache_prefix(const struct index_state *istate, cons=
t char *ce_name)
+{
+	return istate =3D=3D &the_index && index_outside_sparse_prefix(ce_nam=
e);
+}
+
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
 	istate->cache[nr] =3D ce;
@@ -396,6 +401,8 @@ int remove_index_entry_at(struct index_state *istat=
e, int pos)
 {
 	struct cache_entry *ce =3D istate->cache[pos];
=20
+	if (outside_cache_prefix(istate, ce->name))
+		die("%s: cannot remove from index outside %s", ce->name, get_sparse_=
prefix_str());
 	remove_name_hash(ce);
 	istate->cache_changed =3D 1;
 	istate->cache_nr--;
@@ -410,6 +417,10 @@ int remove_index_entry_at(struct index_state *ista=
te, int pos)
 int remove_file_from_index(struct index_state *istate, const char *pat=
h)
 {
 	int pos =3D index_name_pos(istate, path, strlen(path));
+
+	if (outside_cache_prefix(istate, path))
+		die("%s: cannot remove from index from outside %s", path, get_sparse=
_prefix_str());
+
 	if (pos < 0)
 		pos =3D -pos-1;
 	cache_tree_invalidate_path(istate->cache_tree, path);
@@ -809,21 +820,43 @@ static int check_file_directory_conflict(struct i=
ndex_state *istate,
 	return retval + has_dir_name(istate, ce, pos, ok_to_replace);
 }
=20
+/*
+ * ce_compare only considers stuff that will be written to a tree obje=
ct
+ * or index stages
+ *
+ * On CE_* flags CE_HASHED, CE_UNHASHED and CE_UPTODATE are out becaus=
e they
+ * are in-core only, will not be written out
+ */
+#define CE_COMPARE_MASK (CE_STATE_MASK | CE_UPTODATE)
+static int ce_compare(const struct cache_entry *ce1, const struct cach=
e_entry *ce2)
+{
+	return ce1->ce_mode =3D=3D ce2->ce_mode &&
+		((ce1->ce_flags ^ ce2->ce_flags) & ~CE_COMPARE_MASK) =3D=3D 0 &&
+		!memcmp(ce1->sha1, ce2->sha1, 20) &&
+		!strcmp(ce1->name, ce2->name);
+}
+
 static int add_index_entry_with_check(struct index_state *istate, stru=
ct cache_entry *ce, int option)
 {
 	int pos;
 	int ok_to_add =3D option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace =3D option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
+	int is_outside =3D outside_cache_prefix(istate, ce->name);
=20
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
 	pos =3D index_name_pos(istate, ce->name, ce->ce_flags);
=20
 	/* existing match? Just replace it. */
 	if (pos >=3D 0) {
+		if (is_outside && !ce_compare(istate->cache[pos], ce))
+			die("%s: cannot add to index outside %s", ce->name, get_sparse_pref=
ix_str());
 		replace_index_entry(istate, pos, ce);
 		return 0;
 	}
+
+	if (is_outside)
+		die("%s: cannot add to index outside %s", ce->name, get_sparse_prefi=
x_str());
 	pos =3D -pos-1;
=20
 	/*
@@ -858,9 +891,11 @@ int add_index_entry(struct index_state *istate, st=
ruct cache_entry *ce, int opti
 {
 	int pos;
=20
-	if (option & ADD_CACHE_JUST_APPEND)
+	if (option & ADD_CACHE_JUST_APPEND) {
+		if (outside_cache_prefix(istate, ce->name))
+			die("%s: cannot add to index outside %s", ce->name, get_sparse_pref=
ix_str());
 		pos =3D istate->cache_nr;
-	else {
+	} else {
 		int ret;
 		ret =3D add_index_entry_with_check(istate, ce, option);
 		if (ret <=3D 0)
@@ -1444,3 +1479,71 @@ int read_index_unmerged(struct index_state *ista=
te)
 	istate->cache_nr =3D dst - istate->cache;
 	return !!last;
 }
+
+int check_index_prefix(const struct index_state *index, int is_merge)
+{
+	unsigned i;
+	char **index_prefix =3D get_sparse_prefix();
+
+	if (!index_prefix)
+		return 1;
+
+	/* Check for unmerged entries first */
+	for (i =3D 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce =3D index->cache[i];
+		if (ce_stage(ce) && index_outside_sparse_prefix(ce->name))
+			return 0;
+	}
+
+	/*
+	 * if is_merge is true, caller has decided that there
+	 * could be changes outside index prefix, return now
+	 */
+	if (is_merge)
+		return 1;
+	else {
+		const struct index_state *idx[2];
+		int prefix_i[2];
+		int index_prefix_nr;
+		unsigned entry_i[2];
+
+		idx[0] =3D &the_index;
+		idx[1] =3D index;
+		prefix_i[0] =3D prefix_i[1] =3D 0;
+		entry_i[0] =3D entry_i[1] =3D 0;
+		index_prefix_nr =3D 0;
+		while (index_prefix[index_prefix_nr])
+			index_prefix_nr++;
+
+		while (entry_i[0] < idx[0]->cache_nr &&
+		       entry_i[1] < idx[1]->cache_nr) {
+			/* ignore anything inside index prefix */
+			int what_index;
+			for (what_index =3D 0; what_index < 2; what_index++) {
+				const struct index_state *idx_p =3D idx[what_index];
+				const char *prefix =3D index_prefix[prefix_i[what_index]];
+				unsigned *entry_ip =3D entry_i+what_index;
+				if (prefix_i[what_index] < index_prefix_nr &&
+				    !prefixcmp(idx_p->cache[*entry_ip]->name, prefix)) {
+					while (*entry_ip < idx_p->cache_nr &&
+					       !prefixcmp(idx_p->cache[*entry_ip]->name, prefix))
+						entry_ip[0]++;
+					prefix_i[what_index]++;
+				}
+			}
+
+			if (entry_i[0] =3D=3D idx[0]->cache_nr || entry_i[1] =3D=3D idx[1]-=
>cache_nr)
+				break;
+
+			/* does not match */
+			if (!ce_compare(idx[0]->cache[entry_i[0]], idx[1]->cache[entry_i[1]=
]))
+				return 0;
+
+			entry_i[0]++;
+			entry_i[1]++;
+		}
+
+		return entry_i[0] =3D=3D idx[0]->cache_nr &&
+			entry_i[1] =3D=3D idx[1]->cache_nr;
+	}
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index cba0aca..0a6723b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -408,6 +408,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
+	if (o->check_index_prefix && !check_index_prefix(&o->result, o->merge=
 && !o->prefix))
+		return unpack_failed(o, "Merge outside index prefix");
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
diff --git a/unpack-trees.h b/unpack-trees.h
index 94e5672..a1b46f9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -26,7 +26,8 @@ struct unpack_trees_options {
 		     verbose_update:1,
 		     aggressive:1,
 		     skip_unmerged:1,
-		     gently:1;
+		     gently:1,
+		     check_index_prefix:1;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
--=20
1.5.5.GIT
