From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 7/8] Support sparse checkout in unpack_trees() and read-tree
Date: Tue, 11 Aug 2009 22:44:05 +0700
Message-ID: <1250005446-12047-8-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatXH-0007BD-LM
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbZHKPo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbZHKPo4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZHKPoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:54 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TIDF9iiTEELmhhBA6udYdkR4Jm2GGr+yXpNzFmNH7Vo=;
        b=lYfejMvSji7BVnElbv5i/2YoNaGWXABB3Rx6rF7FQF0b43AiUgxYzcJVxAPlLExq9+
         HNXLmp/O8zNT0JUPQclfoKZ5WrpI8qvSjmUix+eVErCnIHN7rpmqkuhcD5KNe3Rt0lXB
         +ao82nhhuLGwdZt7tqHUdDFSRlF0WolsYRBgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K9SE5N2hWaAwHE9RBTddbyN3HY9U95Maw9szUGspef0GdJOq2OhLZIQ1Ajtis5sAce
         ARm1BJ8f9D9gyQQWG1hPvfC4DWsB3Y10PGmQThIQfNvQRqdo07VwdKIcn5ieN+Vvug40
         vCW3Hi0uVO0N6bJLbVSeE+7JMy+0e3tnwD0qI=
Received: by 10.140.136.19 with SMTP id j19mr1526809rvd.268.1250005496279;
        Tue, 11 Aug 2009 08:44:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id b39sm3752300rvf.53.2009.08.11.08.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:50 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125581>

This patch makes unpack_trees() look at .git/info/sparse [1] to
determine which files should stay in working directory, after
merging, by:

 - setting CE_VALID properly so that other operations correctly ignore
   missing files
 - driving check_updates() to add/remove files in accordance to
   CE_VALID

The feature is disabled by default. Use "read-tree --sparse" to enable =
it.

[1] .git/info/sparse has the same syntax as .git/info/exclude. Files
that match the patterns will be set as CE_VALID.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-read-tree.c         |    4 +-
 cache.h                     |    3 +
 t/t1009-read-tree-sparse.sh |   47 ++++++++++++++++++++
 unpack-trees.c              |   98 +++++++++++++++++++++++++++++++++++=
+++++++-
 unpack-trees.h              |    3 +
 5 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100755 t/t1009-read-tree-sparse.sh

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..888f136 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -31,7 +31,7 @@ static int list_tree(unsigned char *sha1)
 }
=20
 static const char * const read_tree_usage[] =3D {
-	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]]  [--index-=
output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--sparse]=
 [--index-output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
 	NULL
 };
=20
@@ -98,6 +98,8 @@ int cmd_read_tree(int argc, const char **argv, const =
char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT_SET_INT(0, "sparse", &opts.apply_sparse,
+			    "apply sparse checkout filter", 1),
 		OPT_END()
 	};
=20
diff --git a/cache.h b/cache.h
index 1a2a3c9..dfad54a 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/t/t1009-read-tree-sparse.sh b/t/t1009-read-tree-sparse.sh
new file mode 100755
index 0000000..f70852c
--- /dev/null
+++ b/t/t1009-read-tree-sparse.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	mkdir two &&
+	test_commit two two/two.t two.t
+'
+
+test_expect_success 'read-tree without .git/info/sparse' '
+	git read-tree --sparse -m -u HEAD &&
+	test -f one.t &&
+	test -f two/two.t
+'
+
+test_expect_success 'read-tree with empty .git/info/sparse' '
+	echo > .git/info/sparse &&
+	git read-tree --sparse -m -u HEAD &&
+	test -f one.t &&
+	test -f two/two.t
+'
+
+test_expect_success 'read-tree --sparse' '
+	echo "one.t" > .git/info/sparse &&
+	git read-tree --sparse -m -u HEAD &&
+	test ! -f one.t &&
+	test -f two/two.t
+'
+
+test_expect_success 'read-tree --sparse foo where foo is "directory"' =
'
+	echo "two" > .git/info/sparse &&
+	git read-tree --sparse -m -u HEAD &&
+	test -f one.t &&
+	test -f two/two.t
+'
+
+test_expect_success 'read-tree --sparse foo/' '
+	echo "two/" > .git/info/sparse &&
+	git read-tree --sparse -m -u HEAD &&
+	test -f one.t &&
+	test ! -f two/two.t
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 02ea236..d18d333 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -32,6 +32,12 @@ static struct unpack_trees_error_msgs unpack_plumbin=
g_errors =3D {
=20
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+
+	/* sparse_not_uptodate_file */
+	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+
+	/* would_lose_orphaned */
+	"Working tree file '%s' would be %s by sparse checkout update.",
 };
=20
 #define ERRORMSG(o,fld) \
@@ -78,7 +84,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
 				total++;
 		}
=20
@@ -92,6 +98,13 @@ static int check_updates(struct unpack_trees_options=
 *o)
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
@@ -118,6 +131,74 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion, struct unpack_trees_options *o);
+static int apply_sparse_checkout(struct unpack_trees_options *o)
+{
+	struct index_state *index =3D &o->result;
+	struct exclude_list el;
+	int i, ret =3D 0;
+
+	memset(&el, 0, sizeof(el));
+	if (add_excludes_from_file_to_list(git_path("info/sparse"), "", 0, NU=
LL, &el, 0) < 0)
+		return 0;
+
+	for (i =3D 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce =3D index->cache[i];
+		const char *basename;
+		int was_valid =3D ce->ce_flags & CE_VALID;
+
+		if (ce_stage(ce))
+			continue;
+
+		basename =3D strrchr(ce->name, '/');
+		basename =3D basename ? basename+1 : ce->name;
+		if (excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, &el=
) > 0)
+			ce->ce_flags |=3D CE_VALID;
+		else
+			ce->ce_flags &=3D ~CE_VALID;
+
+		/*
+		 * We only care about files getting into the checkout area
+		 * If merge strategies want to remove some, go ahead
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+
+		if (!was_valid && (ce->ce_flags & CE_VALID)) {
+			/*
+			 * If CE_UPDATE is set, verify_uptodate() must be called already
+			 * also stat info may have lost after merged_entry() so calling
+			 * verify_uptodate() again may fail
+			 */
+			if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o)) {
+				ret =3D -1;
+				break;
+			}
+			ce->ce_flags |=3D CE_WT_REMOVE;
+		}
+		if (was_valid && !(ce->ce_flags & CE_VALID)) {
+			if (verify_absent_sparse(ce, "overwritten", o)) {
+				ret =3D -1;
+				break;
+			}
+			ce->ce_flags |=3D CE_UPDATE;
+		}
+
+		/* merge strategies may set CE_UPDATE outside checkout area */
+		if (ce->ce_flags & CE_VALID)
+			ce->ce_flags &=3D ~CE_UPDATE;
+
+	}
+
+	for (i =3D 0;i < el.nr;i++)
+		free(el.excludes[i]);
+	if (el.excludes)
+		free(el.excludes);
+
+	return ret;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -416,6 +497,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
+	if (o->apply_sparse && apply_sparse_checkout(o))
+		return unpack_failed(o, NULL);
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -481,6 +565,12 @@ static int verify_uptodate(struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce,
+				  struct unpack_trees_options *o)
+{
+	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file)=
);
+}
+
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
 {
 	if (ce)
@@ -674,6 +764,12 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
 }
=20
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_orphaned=
));
+}
+
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
 {
diff --git a/unpack-trees.h b/unpack-trees.h
index d19df44..a09077b 100644
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
 struct unpack_trees_options {
@@ -28,6 +30,7 @@ struct unpack_trees_options {
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
+		     apply_sparse,
 		     gently;
 	const char *prefix;
 	int pos;
--=20
1.6.3.GIT
