From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 5/7] diff-lib, read-tree, unpack-trees: mark cache_entry pointers const
Date: Sun,  2 Jun 2013 17:46:55 +0200
Message-ID: <1370188017-24672-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 02 17:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjAVJ-00070x-Iu
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 17:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab3FBPrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 11:47:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:58127 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab3FBPrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 11:47:06 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEE4A.dip0.t-ipconnect.de [87.155.238.74])
	by india601.server4you.de (Postfix) with ESMTPSA id BCA514D3;
	Sun,  2 Jun 2013 17:47:03 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226165>

Add const to struct cache_entry pointers throughout the tree which are
only used for reading.  This allows callers to pass in const pointers.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/read-tree.c |  2 +-
 diff-lib.c          | 23 +++++++-------
 unpack-trees.c      | 91 +++++++++++++++++++++++++++++----------------=
--------
 3 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 042ac1b..b847486 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -66,7 +66,7 @@ static int exclude_per_directory_cb(const struct opti=
on *opt, const char *arg,
 	return 0;
 }
=20
-static void debug_stage(const char *label, struct cache_entry *ce,
+static void debug_stage(const char *label, const struct cache_entry *c=
e,
 			struct unpack_trees_options *o)
 {
 	printf("%s ", label);
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..83d0cb8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -64,8 +64,9 @@ static int check_removed(const struct cache_entry *ce=
, struct stat *st)
  * commits, untracked content and/or modified content).
  */
 static int match_stat_with_submodule(struct diff_options *diffopt,
-				      struct cache_entry *ce, struct stat *st,
-				      unsigned ce_option, unsigned *dirty_submodule)
+				     const struct cache_entry *ce,
+				     struct stat *st, unsigned ce_option,
+				     unsigned *dirty_submodule)
 {
 	int changed =3D ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
@@ -237,7 +238,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 /* A file entry went away or appeared */
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
-				 struct cache_entry *ce,
+				 const struct cache_entry *ce,
 				 const unsigned char *sha1, int sha1_valid,
 				 unsigned int mode,
 				 unsigned dirty_submodule)
@@ -246,7 +247,7 @@ static void diff_index_show_file(struct rev_info *r=
evs,
 		       sha1, sha1_valid, ce->name, dirty_submodule);
 }
=20
-static int get_stat_data(struct cache_entry *ce,
+static int get_stat_data(const struct cache_entry *ce,
 			 const unsigned char **sha1p,
 			 unsigned int *modep,
 			 int cached, int match_missing,
@@ -283,7 +284,7 @@ static int get_stat_data(struct cache_entry *ce,
 }
=20
 static void show_new_file(struct rev_info *revs,
-			  struct cache_entry *new,
+			  const struct cache_entry *new,
 			  int cached, int match_missing)
 {
 	const unsigned char *sha1;
@@ -302,8 +303,8 @@ static void show_new_file(struct rev_info *revs,
 }
=20
 static int show_modified(struct rev_info *revs,
-			 struct cache_entry *old,
-			 struct cache_entry *new,
+			 const struct cache_entry *old,
+			 const struct cache_entry *new,
 			 int report_missing,
 			 int cached, int match_missing)
 {
@@ -362,8 +363,8 @@ static int show_modified(struct rev_info *revs,
  * give you the position and number of entries in the index).
  */
 static void do_oneway_diff(struct unpack_trees_options *o,
-	struct cache_entry *idx,
-	struct cache_entry *tree)
+			   const struct cache_entry *idx,
+			   const struct cache_entry *tree)
 {
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
@@ -425,8 +426,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
  */
 static int oneway_diff(struct cache_entry **src, struct unpack_trees_o=
ptions *o)
 {
-	struct cache_entry *idx =3D src[0];
-	struct cache_entry *tree =3D src[1];
+	const struct cache_entry *idx =3D src[0];
+	const struct cache_entry *tree =3D src[1];
 	struct rev_info *revs =3D o->unpack_data;
=20
 	/*
diff --git a/unpack-trees.c b/unpack-trees.c
index 2fecef8..c5a40df 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -241,8 +241,11 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
-static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
-static int verify_absent_sparse(struct cache_entry *ce, enum unpack_tr=
ees_error_types, struct unpack_trees_options *o);
+static int verify_uptodate_sparse(const struct cache_entry *ce,
+				  struct unpack_trees_options *o);
+static int verify_absent_sparse(const struct cache_entry *ce,
+				enum unpack_trees_error_types,
+				struct unpack_trees_options *o);
=20
 static int apply_sparse_checkout(struct cache_entry *ce, struct unpack=
_trees_options *o)
 {
@@ -326,7 +329,7 @@ static void mark_all_ce_unused(struct index_state *=
index)
 		index->cache[i]->ce_flags &=3D ~(CE_UNPACKED | CE_ADDED | CE_NEW_SKI=
P_WORKTREE);
 }
=20
-static int locate_in_src_index(struct cache_entry *ce,
+static int locate_in_src_index(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
 	struct index_state *index =3D o->src_index;
@@ -1001,7 +1004,9 @@ static void mark_new_skip_worktree(struct exclude=
_list *el,
 		       select_flag, skip_wt_flag, el);
 }
=20
-static int verify_absent(struct cache_entry *, enum unpack_trees_error=
_types, struct unpack_trees_options *);
+static int verify_absent(const struct cache_entry *,
+			 enum unpack_trees_error_types,
+			 struct unpack_trees_options *);
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to ma=
nipulate the
  * resulting index, -2 on failure to reflect the changes to the work t=
ree.
@@ -1171,12 +1176,13 @@ return_failed:
=20
 /* Here come the merge functions */
=20
-static int reject_merge(struct cache_entry *ce, struct unpack_trees_op=
tions *o)
+static int reject_merge(const struct cache_entry *ce,
+			struct unpack_trees_options *o)
 {
 	return add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
 }
=20
-static int same(struct cache_entry *a, struct cache_entry *b)
+static int same(const struct cache_entry *a, const struct cache_entry =
*b)
 {
 	if (!!a !=3D !!b)
 		return 0;
@@ -1193,9 +1199,9 @@ static int same(struct cache_entry *a, struct cac=
he_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate_1(struct cache_entry *ce,
-				   struct unpack_trees_options *o,
-				   enum unpack_trees_error_types error_type)
+static int verify_uptodate_1(const struct cache_entry *ce,
+			     struct unpack_trees_options *o,
+			     enum unpack_trees_error_types error_type)
 {
 	struct stat st;
=20
@@ -1234,7 +1240,7 @@ static int verify_uptodate_1(struct cache_entry *=
ce,
 		add_rejected_path(o, error_type, ce->name);
 }
=20
-static int verify_uptodate(struct cache_entry *ce,
+static int verify_uptodate(const struct cache_entry *ce,
 			   struct unpack_trees_options *o)
 {
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE)=
)
@@ -1242,13 +1248,14 @@ static int verify_uptodate(struct cache_entry *=
ce,
 	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
 }
=20
-static int verify_uptodate_sparse(struct cache_entry *ce,
+static int verify_uptodate_sparse(const struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
=20
-static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
+static void invalidate_ce_path(const struct cache_entry *ce,
+			       struct unpack_trees_options *o)
 {
 	if (ce)
 		cache_tree_invalidate_path(o->src_index->cache_tree, ce->name);
@@ -1261,16 +1268,16 @@ static void invalidate_ce_path(struct cache_ent=
ry *ce, struct unpack_trees_optio
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(struct cache_entry *ce,
-				      enum unpack_trees_error_types error_type,
-				      struct unpack_trees_options *o)
+static int verify_clean_submodule(const struct cache_entry *ce,
+				  enum unpack_trees_error_types error_type,
+				  struct unpack_trees_options *o)
 {
 	return 0;
 }
=20
-static int verify_clean_subdirectory(struct cache_entry *ce,
-				      enum unpack_trees_error_types error_type,
-				      struct unpack_trees_options *o)
+static int verify_clean_subdirectory(const struct cache_entry *ce,
+				     enum unpack_trees_error_types error_type,
+				     struct unpack_trees_options *o)
 {
 	/*
 	 * we are about to extract "ce->name"; we would not want to lose
@@ -1356,7 +1363,7 @@ static int icase_exists(struct unpack_trees_optio=
ns *o, const char *name, int le
 }
=20
 static int check_ok_to_remove(const char *name, int len, int dtype,
-			      struct cache_entry *ce, struct stat *st,
+			      const struct cache_entry *ce, struct stat *st,
 			      enum unpack_trees_error_types error_type,
 			      struct unpack_trees_options *o)
 {
@@ -1411,9 +1418,9 @@ static int check_ok_to_remove(const char *name, i=
nt len, int dtype,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent_1(struct cache_entry *ce,
-				 enum unpack_trees_error_types error_type,
-				 struct unpack_trees_options *o)
+static int verify_absent_1(const struct cache_entry *ce,
+			   enum unpack_trees_error_types error_type,
+			   struct unpack_trees_options *o)
 {
 	int len;
 	struct stat st;
@@ -1446,7 +1453,7 @@ static int verify_absent_1(struct cache_entry *ce=
,
 	}
 }
=20
-static int verify_absent(struct cache_entry *ce,
+static int verify_absent(const struct cache_entry *ce,
 			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
 {
@@ -1455,9 +1462,9 @@ static int verify_absent(struct cache_entry *ce,
 	return verify_absent_1(ce, error_type, o);
 }
=20
-static int verify_absent_sparse(struct cache_entry *ce,
-			 enum unpack_trees_error_types error_type,
-			 struct unpack_trees_options *o)
+static int verify_absent_sparse(const struct cache_entry *ce,
+				enum unpack_trees_error_types error_type,
+				struct unpack_trees_options *o)
 {
 	enum unpack_trees_error_types orphaned_error =3D error_type;
 	if (orphaned_error =3D=3D ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN)
@@ -1467,7 +1474,7 @@ static int verify_absent_sparse(struct cache_entr=
y *ce,
 }
=20
 static int merged_entry(const struct cache_entry *ce,
-			struct cache_entry *old,
+			const struct cache_entry *old,
 			struct unpack_trees_options *o)
 {
 	int update =3D CE_UPDATE;
@@ -1527,8 +1534,9 @@ static int merged_entry(const struct cache_entry =
*ce,
 	return 1;
 }
=20
-static int deleted_entry(struct cache_entry *ce, struct cache_entry *o=
ld,
-		struct unpack_trees_options *o)
+static int deleted_entry(const struct cache_entry *ce,
+			 const struct cache_entry *old,
+			 struct unpack_trees_options *o)
 {
 	/* Did it exist in the index? */
 	if (!old) {
@@ -1543,7 +1551,8 @@ static int deleted_entry(struct cache_entry *ce, =
struct cache_entry *old,
 	return 1;
 }
=20
-static int keep_entry(struct cache_entry *ce, struct unpack_trees_opti=
ons *o)
+static int keep_entry(const struct cache_entry *ce,
+		      struct unpack_trees_options *o)
 {
 	add_entry(o, ce, 0, 0);
 	return 1;
@@ -1567,9 +1576,9 @@ static void show_stage_entry(FILE *o,
=20
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o)
 {
-	struct cache_entry *index;
-	struct cache_entry *head;
-	struct cache_entry *remote =3D stages[o->head_idx + 1];
+	const struct cache_entry *index;
+	const struct cache_entry *head;
+	const struct cache_entry *remote =3D stages[o->head_idx + 1];
 	int count;
 	int head_match =3D 0;
 	int remote_match =3D 0;
@@ -1654,7 +1663,7 @@ int threeway_merge(struct cache_entry **stages, s=
truct unpack_trees_options *o)
 	if (o->aggressive) {
 		int head_deleted =3D !head;
 		int remote_deleted =3D !remote;
-		struct cache_entry *ce =3D NULL;
+		const struct cache_entry *ce =3D NULL;
=20
 		if (index)
 			ce =3D index;
@@ -1739,9 +1748,9 @@ int threeway_merge(struct cache_entry **stages, s=
truct unpack_trees_options *o)
  */
 int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o)
 {
-	struct cache_entry *current =3D src[0];
-	struct cache_entry *oldtree =3D src[1];
-	struct cache_entry *newtree =3D src[2];
+	const struct cache_entry *current =3D src[0];
+	const struct cache_entry *oldtree =3D src[1];
+	const struct cache_entry *newtree =3D src[2];
=20
 	if (o->merge_size !=3D 2)
 		return error("Cannot do a twoway merge of %d trees",
@@ -1806,8 +1815,8 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 int bind_merge(struct cache_entry **src,
 		struct unpack_trees_options *o)
 {
-	struct cache_entry *old =3D src[0];
-	struct cache_entry *a =3D src[1];
+	const struct cache_entry *old =3D src[0];
+	const struct cache_entry *a =3D src[1];
=20
 	if (o->merge_size !=3D 1)
 		return error("Cannot do a bind merge of %d trees",
@@ -1829,8 +1838,8 @@ int bind_merge(struct cache_entry **src,
  */
 int oneway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o)
 {
-	struct cache_entry *old =3D src[0];
-	struct cache_entry *a =3D src[1];
+	const struct cache_entry *old =3D src[0];
+	const struct cache_entry *a =3D src[1];
=20
 	if (o->merge_size !=3D 1)
 		return error("Cannot do a oneway merge of %d trees",
--=20
1.8.3
