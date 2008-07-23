From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 10/12] git-checkout: support --full and --path to
	manipulate sparse checkout
Date: Wed, 23 Jul 2008 21:57:44 +0700
Message-ID: <20080723145744.GA29156@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:59:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfoE-0003Lc-MJ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYGWO6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYGWO6I
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:58:08 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbYGWO6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:58:05 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=+Xi+9iMvMLgs8BIhqg0yTG81FAasZJYowxWtOUYOvWQ=;
        b=E9Fq1OgtZu6kpCecJC224k3Ly88o8sP/4pahFdAIhIJVIhAoUxC8qgF3wjuq7tvjPI
         jZiEzeIKwbYz+8KN3HxzfqQBOSIdihM7I3guVj1LaA/lB/tho7x8Ti99q5fCCWaGgE7M
         zQcVejlkHDxuL+j7OSAH/zwWgyzwZxGJ1nkSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=wR/zelYkXgH9Ig6xE9GVGSUwKpzCACZeEjYsXwHbs5bmfTaiO4r24qEtL0wEEYs7Tk
         A/tyDTQ9VErZVvXy2Uu2d0oM/EHnEfplVkIuzGHPCr6+p6+AQAQ42AhB2uX9n5nNSETi
         +yQ8qh92ML9FfKRo48NCMjtyW6uiaoA7fT5iE=
Received: by 10.110.5.14 with SMTP id 14mr93244tie.47.1216825084559;
        Wed, 23 Jul 2008 07:58:04 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id w5sm14767308tib.9.2008.07.23.07.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:58:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:57:44 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89682>

"git checkout --full" will quit sparse checkout mode while
"git checkout --sparse=3Dprefix" will turn on sparse checkout or
update sparse prefix.

twoway_merge has been updated to deal with sparse checkout update.
=46iles that are in old sparse prefix only will get removed while
files that are in new sparse prefix only will get added.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-checkout.c |   44 +++++++++++++++++++
 cache.h            |    2 +
 unpack-trees.c     |  120 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
 unpack-trees.h     |    3 +-
 4 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index eec1bde..410a53a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -160,6 +160,9 @@ struct checkout_opts {
 	char *new_branch;
 	int new_branch_log;
 	enum branch_track track;
+
+	char *sparse_prefix;
+	int no_sparse_checkout;
 };
=20
 static int reset_tree(struct tree *tree, struct checkout_opts *o, int =
worktree)
@@ -255,7 +258,25 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 		tree =3D parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
=20
+		if (opts->no_sparse_checkout)
+			topts.new_sparse_prefix =3D 1;
+
+		if (opts->sparse_prefix) {
+			char **new_sparse_prefix =3D split_prefix(opts->sparse_prefix);
+
+			if (!new_sparse_prefix) {
+				error("new sparse prefix invalid");
+				return 1;
+			}
+			topts.new_sparse_prefix =3D 1;
+			topts.unpack_data =3D new_sparse_prefix;
+		}
+
 		ret =3D unpack_trees(2, trees, &topts);
+
+		if (topts.new_sparse_prefix && topts.unpack_data)
+			free_prefix_list((char **)topts.unpack_data);
+
 		if (ret =3D=3D -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
@@ -299,6 +320,14 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 	    commit_locked_index(lock_file))
 		die("unable to write new index file");
=20
+	/*
+	 * update sparse checkout accordingly
+	 * show_local_changes will need it
+	 */
+	if (opts->no_sparse_checkout)
+		free_prefix_list(save_sparse_prefix());
+	if (opts->sparse_prefix)
+		set_sparse_prefix(opts->sparse_prefix);
 	if (!opts->force)
 		show_local_changes(&new->commit->object);
=20
@@ -409,6 +438,13 @@ static int switch_branches(struct checkout_opts *o=
pts, struct branch_info *new)
=20
 	update_refs_for_switch(opts, &old, new);
=20
+	/* now save new sparse prefix */
+	if (opts->no_sparse_checkout)
+		git_config_set("core.sparsecheckout", NULL);
+
+	if (opts->sparse_prefix)
+		git_config_set("core.sparsecheckout", opts->sparse_prefix);
+
 	ret =3D post_checkout_hook(old.commit, new->commit, 1);
 	return ret || opts->writeout_error;
 }
@@ -428,6 +464,8 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
+		OPT_STRING(0, "path", &opts.sparse_prefix, "prefixes", "update spars=
e checkout"),
+		OPT_BOOLEAN(0, "full", &opts.no_sparse_checkout, "quit sparse checko=
ut"),
 		OPT_END(),
 	};
=20
@@ -468,6 +506,9 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	if (!opts.new_branch && (opts.track !=3D git_branch_track))
 		die("git checkout: --track and --no-track require -b");
=20
+	if (opts.no_sparse_checkout && opts.sparse_prefix)
+		die("git checkout: --path and --full are incompatible");
+
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
=20
@@ -486,6 +527,9 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 			}
 		}
=20
+		if (opts.no_sparse_checkout || opts.sparse_prefix)
+			die("git checkout: updating paths is incompatible with setting spar=
se checkout");
+
 		return checkout_paths(source_tree, pathspec);
 	}
=20
diff --git a/cache.h b/cache.h
index b9a1d96..9e7f146 100644
--- a/cache.h
+++ b/cache.h
@@ -138,6 +138,8 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+#define CE_WD_REMOVE (0x400000)
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
diff --git a/unpack-trees.c b/unpack-trees.c
index 0a30d68..a88c53f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -105,13 +105,29 @@ static int check_updates(struct unpack_trees_opti=
ons *o)
 	struct index_state *index =3D &o->result;
 	int i;
 	int errs =3D 0;
+	char **old_sparse_prefix =3D NULL;
+	char **new_sparse_prefix =3D NULL;
+
+	/*
+	 * for sparse checkout update, we need to widen the prefix a bit
+	 * so that updating in new sparse prefix won't get caught by
+	 * sparse prefix checks
+	 */
+	if (o->new_sparse_prefix) {
+		old_sparse_prefix =3D save_sparse_prefix();
+		if (o->unpack_data) {
+			new_sparse_prefix =3D o->unpack_data;
+			new_sparse_prefix =3D combine_prefix_list(old_sparse_prefix, new_sp=
arse_prefix);
+			restore_sparse_prefix(new_sparse_prefix);
+		}
+	}
=20
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
 			if (outside_sparse_prefix(ce->name))
 				continue;
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WD_REMOVE))
 				total++;
 		}
=20
@@ -125,12 +141,14 @@ static int check_updates(struct unpack_trees_opti=
ons *o)
=20
 		if (outside_sparse_prefix(ce->name))
 			continue;
-		if (ce->ce_flags & CE_REMOVE) {
+		if (ce->ce_flags & (CE_REMOVE | CE_WD_REMOVE)) {
 			display_progress(progress, ++cnt);
 			if (o->update)
 				unlink_entry(ce);
-			remove_index_entry_at(&o->result, i);
-			i--;
+			if (ce->ce_flags & CE_REMOVE) {
+				remove_index_entry_at(&o->result, i);
+				i--;
+			}
 			continue;
 		}
 	}
@@ -149,6 +167,10 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 		}
 	}
 	stop_progress(&progress);
+	if (o->new_sparse_prefix) {
+		restore_sparse_prefix(old_sparse_prefix);
+		free_prefix_list(new_sparse_prefix);
+	}
 	return errs !=3D 0;
 }
=20
@@ -680,8 +702,8 @@ static int verify_absent(struct cache_entry *ce, co=
nst char *action,
 	return 0;
 }
=20
-static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
-		struct unpack_trees_options *o)
+static int merged_entry_internal(struct cache_entry *merge, struct cac=
he_entry *old,
+		struct unpack_trees_options *o, int set, int clear)
 {
 	int update =3D CE_UPDATE;
=20
@@ -708,10 +730,28 @@ static int merged_entry(struct cache_entry *merge=
, struct cache_entry *old,
 		invalidate_ce_path(merge, o);
 	}
=20
-	add_entry(o, merge, update, CE_STAGEMASK);
+	add_entry(o, merge, (update & (~clear)) | set, CE_STAGEMASK);
 	return 1;
 }
=20
+static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
+		struct unpack_trees_options *o)
+{
+	return merged_entry_internal(merge, old, o, 0, 0);
+}
+
+static int merged_entry_and_no_add(struct cache_entry *merge, struct c=
ache_entry *old,
+		struct unpack_trees_options *o)
+{
+	return merged_entry_internal(merge, old, o, 0, CE_UPDATE);
+}
+
+static int merged_entry_and_add(struct cache_entry *merge, struct cach=
e_entry *old,
+		struct unpack_trees_options *o)
+{
+	return merged_entry_internal(merge, old, o, CE_UPDATE, 0);
+}
+
 static int deleted_entry(struct cache_entry *ce, struct cache_entry *o=
ld,
 		struct unpack_trees_options *o)
 {
@@ -734,6 +774,20 @@ static int keep_entry(struct cache_entry *ce, stru=
ct unpack_trees_options *o)
 	return 1;
 }
=20
+static int keep_entry_and_add(struct cache_entry *ce, struct unpack_tr=
ees_options *o)
+{
+	add_entry(o, ce, CE_UPDATE, 0);
+	return 1;
+}
+
+static int keep_entry_and_remove(struct cache_entry *ce, struct unpack=
_trees_options *o)
+{
+	if (verify_uptodate(ce, o))
+		return -1;
+	add_entry(o, ce, CE_WD_REMOVE, 0);
+	return 1;
+}
+
 #if DBRT_DEBUG
 static void show_stage_entry(FILE *o,
 			     const char *label, const struct cache_entry *ce)
@@ -918,12 +972,31 @@ int threeway_merge(struct cache_entry **stages, s=
truct unpack_trees_options *o)
  * over a merge failure when it makes sense.  For details of the
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
+ * Two-way merge with sparse prefix update.
+ *
+ * The rules are as same as plain two-way merge, except:
+ *  1) if it's in old sparse checkout, but not the new one, mark it CE=
_WD_REMOVE
+ *  2) if it's in the new one, but not the old one, mark it CE_UPDATE
+ *  3) otherwise, let old two-way merge take it
+ *
+ *  case 1)
+ *     keep index implies CE_WD_REMOVE (remove workdir only, keep file=
 in index)
+ *     use M implies no CE_UPDATE
+ *     if index is not clean, fail
+ *
+ *  case 2)
+ *     keep index implies CE_UPDATE
+ *     use M implies CE_UPDATE
+ *     index can't be unclean, so ignore this
+ *
  */
 int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o)
 {
 	struct cache_entry *current =3D src[0];
 	struct cache_entry *oldtree =3D src[1];
 	struct cache_entry *newtree =3D src[2];
+	int remove =3D 0, add =3D 0;
+	char **new_sparse_prefix =3D (char **)o->unpack_data;
=20
 	if (o->merge_size !=3D 2)
 		return error("Cannot do a twoway merge of %d trees",
@@ -935,6 +1008,13 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 		newtree =3D NULL;
=20
 	if (current) {
+		if (o->new_sparse_prefix) {
+			remove =3D !outside_sparse_prefix(current->name) &&
+				 outside_prefix_list(new_sparse_prefix, current->name);
+			add =3D outside_sparse_prefix(current->name) &&
+			      !outside_prefix_list(new_sparse_prefix, current->name);
+		}
+
 		if ((!oldtree && !newtree) || /* 4 and 5 */
 		    (!oldtree && newtree &&
 		     same(current, newtree)) || /* 6 and 7 */
@@ -943,6 +1023,12 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 		    (oldtree && newtree &&
 		     !same(oldtree, newtree) && /* 18 and 19 */
 		     same(current, newtree))) {
+			if (o->new_sparse_prefix) {
+				if (remove)
+					return keep_entry_and_remove(current, o);
+				if (add)
+					return keep_entry_and_add(current, o);
+			}
 			return keep_entry(current, o);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
@@ -952,6 +1038,12 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 		else if (oldtree && newtree &&
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
+			if (o->new_sparse_prefix) {
+				if (remove)
+					return merged_entry_and_no_add(newtree, current, o);
+				if (add)
+					return merged_entry_and_add(newtree, current, o);
+			}
 			return merged_entry(newtree, current, o);
 		}
 		else {
@@ -965,8 +1057,20 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 			return -1;
 		}
 	}
-	else if (newtree)
+	else if (newtree) {
+		if (o->new_sparse_prefix) {
+			remove =3D !outside_sparse_prefix(newtree->name) &&
+				outside_prefix_list(new_sparse_prefix, newtree->name);
+			add =3D outside_sparse_prefix(newtree->name) &&
+				!outside_prefix_list(new_sparse_prefix, newtree->name);
+
+			if (remove)
+				return merged_entry_and_no_add(newtree, current, o);
+			if (add)
+				return merged_entry_and_add(newtree, current, o);
+		}
 		return merged_entry(newtree, current, o);
+	}
 	return deleted_entry(oldtree, current, o);
 }
=20
diff --git a/unpack-trees.h b/unpack-trees.h
index a1b46f9..5a29fc4 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -27,7 +27,8 @@ struct unpack_trees_options {
 		     aggressive:1,
 		     skip_unmerged:1,
 		     gently:1,
-		     check_index_prefix:1;
+		     check_index_prefix:1,
+		     new_sparse_prefix:1; /* unpack_data must contain new prefix */
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
--=20
1.5.5.GIT
