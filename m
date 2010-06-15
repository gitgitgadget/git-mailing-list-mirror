From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [PATCH 2/5 v2] unpack_trees: group errors by type
Date: Tue, 15 Jun 2010 14:22:53 +0200
Message-ID: <1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 14:23:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVAs-0006TW-6e
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab0FOMXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 08:23:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56983 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab0FOMXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:23:14 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCF9Xe002469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:15:09 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCNAI8021129;
	Tue, 15 Jun 2010 14:23:10 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FCNAqD028310;
	Tue, 15 Jun 2010 14:23:10 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FCNAWj028309;
	Tue, 15 Jun 2010 14:23:10 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:15:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCF9Xe002469
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
MailScanner-NULL-Check: 1277208909.94746@FWwLmd/F1X5KKI+0Rtb0lw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149174>

When an error is encountered, it calls add_rejected_file() which either
- directly displays the error message and stops if in plumbing mode
  (i.e. if show_all_errors is not initialized at 1)
- or stores it so that it will be displayed at the end with display_err=
or_msgs(),

Storing the files by error type permits to have a list of files for
which there is the same error instead of having a serie of almost
identical errors.

As each bind_overlap error combines a file and an old file, a list cann=
ot be
done, therefore, theses errors are not stored but directly displayed.

Update t3030 to expect failure for a test based on an error message.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/checkout.c         |    1 +
 builtin/merge.c            |    2 +-
 t/t3030-merge-recursive.sh |    2 +-
 tree-walk.c                |   11 +++-
 unpack-trees.c             |  119 ++++++++++++++++++++++++++++++++++++=
+++++---
 unpack-trees.h             |   31 +++++++++++-
 6 files changed, 152 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6f34566..23eae56 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -392,6 +392,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.dir =3D xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |=3D DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir =3D ".gitignore";
+		topts.show_all_errors =3D 1;
 		tree =3D parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
diff --git a/builtin/merge.c b/builtin/merge.c
index 501177f..2c2f904 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -704,7 +704,7 @@ int checkout_fast_forward(const unsigned char *head=
, const unsigned char *remote
 	opts.verbose_update =3D 1;
 	opts.merge =3D 1;
 	opts.fn =3D twoway_merge;
-
+	opts.show_all_errors =3D 1;
 	opts.msgs =3D get_porcelain_error_msgs("merge");
=20
 	trees[nr_trees] =3D parse_tree_indirect(head);
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 9929f82..7ef8dd4 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -269,7 +269,7 @@ test_expect_success 'merge-recursive result' '
=20
 '
=20
-test_expect_success 'fail if the index has unresolved entries' '
+test_expect_failure 'fail if the index has unresolved entries' '
=20
 	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
diff --git a/tree-walk.c b/tree-walk.c
index 67a9a0c..b8b7f00 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tree-walk.h"
+#include "unpack-trees.h"
 #include "tree.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
@@ -310,6 +311,7 @@ static void free_extended_entry(struct tree_desc_x =
*t)
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *i=
nfo)
 {
 	int ret =3D 0;
+	int error =3D 0;
 	struct name_entry *entry =3D xmalloc(n*sizeof(*entry));
 	int i;
 	struct tree_desc_x *tx =3D xcalloc(n, sizeof(*tx));
@@ -377,8 +379,11 @@ int traverse_trees(int n, struct tree_desc *t, str=
uct traverse_info *info)
 		if (!mask)
 			break;
 		ret =3D info->fn(n, mask, dirmask, entry, info);
-		if (ret < 0)
-			break;
+		if (ret < 0) {
+			error =3D ret;
+			if (!((struct unpack_trees_options*)(info->data))->show_all_errors)
+				break;
+		}
 		mask &=3D ret;
 		ret =3D 0;
 		for (i =3D 0; i < n; i++)
@@ -389,7 +394,7 @@ int traverse_trees(int n, struct tree_desc *t, stru=
ct traverse_info *info)
 	for (i =3D 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
-	return ret;
+	return error;
 }
=20
 static int find_tree_entry(struct tree_desc *t, const char *name, unsi=
gned char *result, unsigned *mode)
diff --git a/unpack-trees.c b/unpack-trees.c
index c29a9e0..78ecdc9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -60,6 +60,92 @@ static void add_entry(struct unpack_trees_options *o=
, struct cache_entry *ce,
 }
=20
 /*
+ * add error messages on path <path> and action <action>
+ * corresponding to the type <e> with the message <msg>
+ * indicating if it should be display in porcelain or not
+ */
+static int add_rejected_path(struct unpack_trees_options *o,
+			     enum unpack_trees_error e,
+			     const char *path,
+			     const char *action,
+			     int porcelain,
+			     const char *msg)
+{
+	struct rejected_paths_list *newentry;
+	struct rejected_paths **rp;
+	/*
+	 * simply display the given error message if in plumbing mode
+	 */
+	if (!porcelain)
+		o->show_all_errors =3D 0;
+	if (!o->show_all_errors)
+		return error(msg, path, action);
+	/*
+	 * if there is a porcelain error message defined,
+	 * the error is stored in order to be nicely displayed later
+	 */
+	if (e =3D=3D would_lose_untracked_overwritten && !strcmp(action, "rem=
oved"))
+		e =3D would_lose_untracked_removed;
+
+	rp =3D &o->unpack_rejects[e];
+
+	if (!o->unpack_rejects[e]) {
+		*rp =3D malloc(sizeof(struct rejected_paths));
+		(*rp)->list =3D NULL;
+	}
+	newentry =3D malloc(sizeof(struct rejected_paths_list));
+	newentry->path =3D (char *)path;
+	newentry->next =3D (*rp)->list;
+	(*rp)->list =3D newentry;
+	(*rp)->msg =3D msg;
+	(*rp)->action =3D (char *)action;
+	return -1;
+}
+
+/*
+ * free all the structures allocated for the error <e>
+ */
+static void free_rejected_paths(struct unpack_trees_options *o,
+				enum unpack_trees_error e)
+{
+	while (o->unpack_rejects[e]->list) {
+		struct rejected_paths_list *del =3D o->unpack_rejects[e]->list;
+		o->unpack_rejects[e]->list =3D o->unpack_rejects[e]->list->next;
+		free(del);
+	}
+	free(o->unpack_rejects[e]);
+}
+
+/*
+ * display all the error messages stored in a nice way
+ */
+static void display_error_msgs(struct unpack_trees_options *o)
+{
+	int i;
+	int something_is_displayed =3D 0;
+	for (i =3D 0; i < NB_UNPACK_TREES_ERROR; i++) {
+		if (o->unpack_rejects[i] && o->unpack_rejects[i]->list) {
+			struct rejected_paths *rp =3D o->unpack_rejects[i];
+			struct rejected_paths_list *f =3D rp->list;
+			char *action =3D rp->action;
+			struct strbuf path =3D STRBUF_INIT;
+			something_is_displayed  =3D 1;
+			for (f =3D rp->list; f; f =3D f->next)
+				strbuf_addf(&path, "\t%s\n", f->path);
+			if (i =3D=3D would_lose_untracked_overwritten ||
+			    i =3D=3D would_lose_untracked_removed)
+				error(rp->msg, action, path.buf);
+			else
+				error(rp->msg, path.buf, action);
+			strbuf_release(&path);
+			free_rejected_paths(o, i);
+		}
+	}
+	if (something_is_displayed)
+		printf("Aborting\n");
+}
+
+/*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
@@ -819,6 +905,8 @@ done:
 	return ret;
=20
 return_failed:
+	if (o->show_all_errors)
+		display_error_msgs(o);
 	mark_all_ce_unused(o->src_index);
 	ret =3D unpack_failed(o, NULL);
 	goto done;
@@ -828,7 +916,9 @@ return_failed:
=20
 static int reject_merge(struct cache_entry *ce, struct unpack_trees_op=
tions *o)
 {
-	return error(ERRORMSG(o, would_overwrite), ce->name);
+	return add_rejected_path(o, would_overwrite, ce->name, NULL,
+				 (o && (o)->msgs.would_overwrite),
+				 ERRORMSG(o, would_overwrite));
 }
=20
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -850,7 +940,7 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  */
 static int verify_uptodate_1(struct cache_entry *ce,
 				   struct unpack_trees_options *o,
-				   const char *error_msg)
+				   enum unpack_trees_error error)
 {
 	struct stat st;
=20
@@ -874,8 +964,16 @@ static int verify_uptodate_1(struct cache_entry *c=
e,
 	}
 	if (errno =3D=3D ENOENT)
 		return 0;
-	return o->gently ? -1 :
-		error(error_msg, ce->name);
+	if (error =3D=3D sparse_not_uptodate_file)
+		return o->gently ? -1 :
+			add_rejected_path(o, sparse_not_uptodate_file, ce->name, NULL,
+					  (o && (o)->msgs.sparse_not_uptodate_file),
+					  ERRORMSG(o, sparse_not_uptodate_file));
+	else
+		return o->gently ? -1 :
+			add_rejected_path(o, not_uptodate_file, ce->name, NULL,
+					  (o && (o)->msgs.not_uptodate_file),
+					  ERRORMSG(o, not_uptodate_file));
 }
=20
 static int verify_uptodate(struct cache_entry *ce,
@@ -883,13 +981,13 @@ static int verify_uptodate(struct cache_entry *ce=
,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
+	return verify_uptodate_1(ce, o, not_uptodate_file);
 }
=20
 static int verify_uptodate_sparse(struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file)=
);
+	return verify_uptodate_1(ce, o, sparse_not_uptodate_file);
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -976,7 +1074,9 @@ static int verify_clean_subdirectory(struct cache_=
entry *ce, const char *action,
 	i =3D read_directory(&d, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, not_uptodate_dir), ce->name);
+			add_rejected_path(o, not_uptodate_dir, ce->name, NULL,
+					  (o && (o)->msgs.not_uptodate_dir),
+					  ERRORMSG(o, not_uptodate_dir));
 	free(pathbuf);
 	return cnt;
 }
@@ -1058,7 +1158,10 @@ static int verify_absent_1(struct cache_entry *c=
e, const char *action,
 		}
=20
 		return o->gently ? -1 :
-			error(ERRORMSG(o, would_lose_untracked), ce->name, action);
+			add_rejected_path(o, would_lose_untracked_overwritten,
+					  ce->name, action,
+					  (o && (o)->msgs.would_lose_untracked),
+					  ERRORMSG(o, would_lose_untracked));
 	}
 	return 0;
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index ef70eab..1f8e71e 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -2,6 +2,7 @@
 #define UNPACK_TREES_H
=20
 #define MAX_UNPACK_TREES 8
+#define NB_UNPACK_TREES_ERROR 6
=20
 struct unpack_trees_options;
 struct exclude_list;
@@ -19,6 +20,27 @@ struct unpack_trees_error_msgs {
 	const char *would_lose_orphaned;
 };
=20
+struct rejected_paths_list {
+	char *path;
+	struct rejected_paths_list *next;
+};
+
+struct rejected_paths {
+	char *action;
+	const char *msg;
+	struct rejected_paths_list *list;
+};
+
+
+enum unpack_trees_error{
+	would_overwrite,
+	not_uptodate_file,
+	not_uptodate_dir,
+	would_lose_untracked_overwritten,
+	would_lose_untracked_removed,
+	sparse_not_uptodate_file
+};
+
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
@@ -33,7 +55,8 @@ struct unpack_trees_options {
 		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
-		     gently;
+		     gently,
+		     show_all_errors;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
@@ -51,6 +74,12 @@ struct unpack_trees_options {
 	struct index_state result;
=20
 	struct exclude_list *el; /* for internal use */
+
+	/*
+	 * Store error messages in an array, each case
+	 * corresponding to a error message type
+	 */
+	struct rejected_paths *unpack_rejects[NB_UNPACK_TREES_ERROR];
 };
=20
 extern int unpack_trees(unsigned n, struct tree_desc *t,
--=20
1.6.6.7.ga5fe3
