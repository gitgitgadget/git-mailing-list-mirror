From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] unpack_trees(): add support for sparse checkout
Date: Sun, 30 Nov 2008 17:54:34 +0700
Message-ID: <1228042478-1886-5-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <1228042478-1886-3-git-send-email-pclouds@gmail.com>
 <1228042478-1886-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jyw-0005ev-0o
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbYK3Kzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbYK3Kzd
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:33 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:31243 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYK3Kzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:31 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2162618wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qYci+YJHEk9Jez5Jx0eiOjnW6LI77CP+IXj903CZqgw=;
        b=JycduFRAzlBNWNu2QP/tjT/hC6uV7MUw/ft8EZmG0maQHiTi2iDWl/z8CZuDHMeaW9
         HFukNQ+hnnHJJYIfsvT3r4CgUKgs9to3D/CkJbhItvTPykAHQbOqAsqX4vJz53fn1w3D
         GlD/E5pGCT5hDF5SPau8KqgPV5B/hnFzcJm/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=esbnnFEthpipdo3qRrAlGKBfqSHq51atVjsU1h27K/vXSmx4z7TyXLIkYyBcTTz50Y
         c9IR6UncxwRKo1CabFhu5r9k6b2clzfljr33j4CwmFSt0fSgFr46/aFG9R9SGsbXlAss
         rgocz2AM/CvsRFOjZekwIwGDwzpCresDICqrw=
Received: by 10.142.52.9 with SMTP id z9mr4041263wfz.327.1228042530587;
        Sun, 30 Nov 2008 02:55:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id 30sm3867508wfd.24.2008.11.30.02.55.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:55:13 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101965>

This patch teaches unpack_trees() to checkout/remove entries
on working directories appropriately when sparse checkout area is
changed. There are three kind of changes:

 - new_narrow_path: reset workdir to a completely new checkout area
 - add_narrow_path: keep current areas and add more entries
 - remove_narrow_path: remove some entries from current areas

When unpack_trees() is called without any of those options, changes in
no-checkout entries will not get checked out on working directory. New
files still appear on working directory though. That will be handled
later by core.defaultsparse

CE_WD_REMOVE is introduced to remove entries from working directories,
but still keep them in index

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |    3 +
 unpack-trees.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 unpack-trees.h |    6 +++
 3 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 321fc54..b13df06 100644
--- a/cache.h
+++ b/cache.h
@@ -173,6 +173,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/unpack-trees.c b/unpack-trees.c
index 7d99051..a2794b8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -31,6 +31,12 @@ static struct unpack_trees_error_msgs unpack_plumbin=
g_errors =3D {
=20
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+
+	/* sparse_not_uptodate_file */
+	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+
+	/* would_lose_orphaned */
+	"Orphaned working tree file '%s' would be %s by sparse checkout updat=
e.",
 };
=20
 #define ERRORMSG(o,fld) \
@@ -96,7 +102,7 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
 				total++;
 		}
=20
@@ -108,6 +114,13 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -133,6 +146,82 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion, struct unpack_trees_options *o);
+static int apply_narrow_spec(struct unpack_trees_options *o)
+{
+	struct index_state *index =3D &o->result;
+	int i, len, namelen;
+	int header =3D 0;
+	char *special_files[] =3D { ".gitignore", GITATTRIBUTES_FILE, NULL };
+	char **special_file;
+
+	for (i =3D 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce =3D index->cache[i];
+		int was_checkout =3D ce_checkout(ce);
+
+		if (ce_stage(ce))
+			continue;
+
+		/* Special case: .gitignore and .gitattributes should stay */
+		for (special_file =3D special_files; *special_file; special_file++) =
{
+			len =3D strlen(*special_file);
+			namelen =3D ce_namelen(ce);
+			if ((namelen =3D=3D len ||
+			     (namelen > len && ce->name[namelen-len-1] =3D=3D '/')) &&
+			    !strcmp(ce->name+namelen-len, *special_file))
+				break;
+		}
+		if (*special_file)
+			continue;
+
+		if (o->new_narrow_path | o->add_narrow_path | o->remove_narrow_path)=
 {
+			int match =3D match_narrow_spec(o->narrow_spec, ce->name);
+			if (o->new_narrow_path) {
+				if (match)
+					ce_mark_checkout(ce);
+				else
+					ce_mark_no_checkout(ce);
+			}
+			if (o->add_narrow_path && match)
+				ce_mark_checkout(ce);
+			if (o->remove_narrow_path && match)
+				ce_mark_no_checkout(ce);
+		}
+
+		/* Update worktree, add/remove entries if needed */
+
+		/*
+		 * We only care about files getting into the checkout area
+		 * If merge strategies want to remove some, go ahead
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+
+		if (was_checkout && ce_no_checkout(ce)) {
+			/*
+			 * If CE_UPDATE is set, verify_uptodate() must be called already
+			 * also stat info may have lost after merged_entry() so calling
+			 * verify_uptodate() again may fail
+			 */
+			if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+				return -1;
+			ce->ce_flags |=3D CE_WT_REMOVE;
+		}
+		if (!was_checkout && ce_checkout(ce)) {
+			if (verify_absent_sparse(ce, "overwritten", o))
+				return -1;
+			ce->ce_flags |=3D CE_UPDATE;
+		}
+
+		/* merge strategies may set CE_UPDATE outside checkout area */
+		if (ce_no_checkout(ce))
+			ce->ce_flags &=3D ~CE_UPDATE;
+
+	}
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -416,6 +505,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
+	if (apply_narrow_spec(o))
+		return unpack_failed(o, NULL);
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -445,8 +537,9 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
+static int verify_uptodate_generic(struct cache_entry *ce,
+				   struct unpack_trees_options *o,
+				   const char *error_msg)
 {
 	struct stat st;
=20
@@ -471,7 +564,18 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno =3D=3D ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, not_uptodate_file), ce->name);
+		error(error_msg, ce->name);
+}
+
+static int verify_uptodate(struct cache_entry *ce,
+			   struct unpack_trees_options *o)
+{
+	return verify_uptodate_generic(ce, o, ERRORMSG(o, not_uptodate_file))=
;
+}
+static int verify_uptodate_sparse(struct cache_entry *ce,
+				  struct unpack_trees_options *o)
+{
+	return verify_uptodate_generic(ce, o, ERRORMSG(o, sparse_not_uptodate=
_file));
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -583,8 +687,9 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent(struct cache_entry *ce, const char *action,
-			 struct unpack_trees_options *o)
+static int verify_absent_generic(struct cache_entry *ce, const char *a=
ction,
+				 struct unpack_trees_options *o,
+				 const char *error_msg)
 {
 	struct stat st;
=20
@@ -662,6 +767,16 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	}
 	return 0;
 }
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_generic(ce, action, o, ERRORMSG(o, would_lose_un=
tracked));
+}
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_generic(ce, action, o, ERRORMSG(o, would_lose_or=
phaned));
+}
=20
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
@@ -684,6 +799,8 @@ static int merged_entry(struct cache_entry *merge, =
struct cache_entry *old,
 				return -1;
 			invalidate_ce_path(old, o);
 		}
+		if (ce_no_checkout(old))
+			update |=3D CE_NO_CHECKOUT;
 	}
 	else {
 		if (verify_absent(merge, "overwritten", o))
@@ -1182,6 +1299,8 @@ int oneway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
 				update |=3D CE_UPDATE;
 		}
+		if (ce_no_checkout(old))
+			update |=3D CE_NO_CHECKOUT;
 		add_entry(o, old, update, 0);
 		return 0;
 	}
diff --git a/unpack-trees.h b/unpack-trees.h
index 86f0989..7e9febd 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -14,6 +14,8 @@ struct unpack_trees_error_msgs {
 	const char *not_uptodate_dir;
 	const char *would_lose_untracked;
 	const char *bind_overlap;
+	const char *sparse_not_uptodate_file;
+	const char *would_lose_orphaned;
 };
=20
 struct narrow_spec {
@@ -46,6 +48,9 @@ struct unpack_trees_options {
 		     prune_unmerged:1,
 		     has_unmerged:1,
 		     initial_checkout:1,
+		     new_narrow_path:1,
+		     add_narrow_path:2,
+		     remove_narrow_path:2,
 		     gently:1;
 	const char *prefix;
 	int pos;
@@ -57,6 +62,7 @@ struct unpack_trees_options {
 	int merge_size;
=20
 	struct cache_entry *df_conflict_entry;
+	struct narrow_spec *narrow_spec;
 	void *unpack_data;
=20
 	struct index_state *dst_index;
--=20
1.6.0.3.890.g95457
