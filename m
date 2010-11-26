From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] unpack-trees: fix sparse checkout's "unable to match directories"
Date: Sat, 27 Nov 2010 01:17:46 +0700
Message-ID: <1290795467-7570-5-git-send-email-pclouds@gmail.com>
References: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 26 19:19:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM2tc-0003TJ-Ky
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab0KZSTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 13:19:34 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:54970 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZSTd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:19:33 -0500
Received: by pzk26 with SMTP id 26so481191pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2+X2XoR9hJtklvjS2OjxL4YZ4U+krVocv++C3oa0vgA=;
        b=pGC+dauJGFGIqZxCBRcHkiOZBVQhmjWvixYS8BzyzNHgBewFP5n03fEVpjHLVZUgFA
         VZzGOIBH2MrT4D58DUfnV7mJ/SO04btFZnJ2AoMTYrKdqNUuCZaeBjAutqOnyXBvPZT9
         JV5op2gD5iE7bLoY57So2hv6qD6IvYjeq1eus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xee8sPnxVsJLSQbEdO/hq2KpTBkTIrvC8pPjECDeCPctw/0Y68+uAFiU1SKMoGECij
         FQshTAzEhY7Av77P5nL5VfykjJ2rzRUsmhTgi9KRa6sIiW5cHSwl8bMDKotyoA2PIprB
         KCMzgz0g7NhMI4Dy6nLPs6dAkgOp5AlUTN2Oo=
Received: by 10.142.229.21 with SMTP id b21mr2745322wfh.261.1290795573279;
        Fri, 26 Nov 2010 10:19:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id x18sm2858350wfa.23.2010.11.26.10.19.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 10:19:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 01:18:30 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162269>

Matching index entries against an excludes file currently has two
problems.

=46irst, there's no function to do it.  Code paths (like sparse
checkout) that wanted to try it would iterate over index entries and
for each index entry pass that path to excluded_from_list().  But that
is not how excluded_from_list() works; one is supposed to feed in each
ancester of a path before a given path to find out if it was excluded
because of some parent or grandparent matching a

  bigsubdirectory/

pattern despite the path not matching any .gitignore pattern directly.

Second, it's inefficient.  The excludes mechanism is supposed to let
us block off vast swaths of the filesystem as uninteresting; separately
checking every index entry doesn't fit that model.

Introduce a new function to take care of both these problems.  This
traverses the index in depth-first order (well, that's what order the
index is in) to mark un-excluded entries.

Maybe some day the in-core index format will be restructured to make
this sort of operation easier.  Or maybe we will want to try some
binary search based thing.  The interface is simple enough to allow
all those things.  Example:

  clear_ce_flags(the_index.cache, the_index.cache_nr,
                 CE_CANDIDATE, CE_CLEARME, exclude_list);

would clear the CE_CLEARME flag on all index entries with
CE_CANDIDATE flag and not matched by exclude_list.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-read-tree.txt      |    7 --
 t/t1011-read-tree-sparse-checkout.sh |   14 +++-
 unpack-trees.c                       |  154 ++++++++++++++++++++++++++=
+++++--
 3 files changed, 155 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 2e78da4..f6037c4 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -412,13 +412,6 @@ turn `core.sparseCheckout` on in order to have spa=
rse checkout
 support.
=20
=20
-BUGS
-----
-In order to match a directory with $GIT_DIR/info/sparse-checkout,
-trailing slash must be used. The form without trailing slash, while
-works with .gitignore, does not work with sparse checkout.
-
-
 SEE ALSO
 --------
 linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 8008fa2..67d9217 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -94,12 +94,20 @@ test_expect_success 'match directories with trailin=
g slash' '
 	test -f sub/added
 '
=20
-test_expect_failure 'match directories without trailing slash' '
-	echo init.t >.git/info/sparse-checkout &&
+test_expect_success 'match directories without trailing slash' '
 	echo sub >>.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
-	test_cmp expected.swt result &&
+	test_cmp expected.swt-noinit result &&
+	test ! -f init.t &&
+	test -f sub/added
+'
+
+test_expect_success 'match directory pattern' '
+	echo "s?b" >>.git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t >result &&
+	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
 	test -f sub/added
 '
diff --git a/unpack-trees.c b/unpack-trees.c
index a6518db..06de723 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -245,15 +245,6 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
 static int verify_absent_sparse(struct cache_entry *ce, enum unpack_tr=
ees_error_types, struct unpack_trees_options *o);
=20
-static int will_have_skip_worktree(const struct cache_entry *ce, struc=
t unpack_trees_options *o)
-{
-	const char *basename;
-
-	basename =3D strrchr(ce->name, '/');
-	basename =3D basename ? basename+1 : ce->name;
-	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o=
->el) <=3D 0;
-}
-
 static int apply_sparse_checkout(struct cache_entry *ce, struct unpack=
_trees_options *o)
 {
 	int was_skip_worktree =3D ce_skip_worktree(ce);
@@ -834,6 +825,138 @@ static int unpack_callback(int n, unsigned long m=
ask, unsigned long dirmask, str
 	return mask;
 }
=20
+/* Whole directory matching */
+static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
+			      char *prefix, int prefix_len,
+			      char *basename,
+			      int select_mask, int clear_mask,
+			      struct exclude_list *el)
+{
+	struct cache_entry **cache_end =3D cache + nr;
+	int dtype =3D DT_DIR;
+	int ret =3D excluded_from_list(prefix, prefix_len, basename, &dtype, =
el);
+
+	prefix[prefix_len++] =3D '/';
+
+	/* included, no clearing for any entries under this directory */
+	if (!ret) {
+		for (; cache !=3D cache_end; cache++) {
+			struct cache_entry *ce =3D *cache;
+			if (strncmp(ce->name, prefix, prefix_len))
+				break;
+		}
+		return nr - (cache_end - cache);
+	}
+
+	/* excluded, clear all selected entries under this directory. */
+	if (ret =3D=3D 1) {
+		for (; cache !=3D cache_end; cache++) {
+			struct cache_entry *ce =3D *cache;
+			if (select_mask && !(ce->ce_flags & select_mask))
+				continue;
+			if (strncmp(ce->name, prefix, prefix_len))
+				break;
+			ce->ce_flags &=3D ~clear_mask;
+		}
+		return nr - (cache_end - cache);
+	}
+
+	return 0;
+}
+
+/*
+ * Traverse the index, find every entry that matches according to
+ * o->el. Do "ce_flags &=3D ~clear_mask" on those entries. Return the
+ * number of traversed entries.
+ *
+ * If select_mask is non-zero, only entries whose ce_flags has on of
+ * those bits enabled are traversed.
+ *
+ * cache	: pointer to an index entry
+ * prefix_len	: an offset to its path
+ *
+ * The current path ("prefix") including the trailing '/' is
+ *   cache[0]->name[0..(prefix_len-1)]
+ * Top level path has prefix_len zero.
+ */
+static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+			    char *prefix, int prefix_len,
+			    int select_mask, int clear_mask,
+			    struct exclude_list *el)
+{
+	struct cache_entry **cache_end =3D cache + nr;
+
+	/*
+	 * Process all entries that have the given prefix and meet
+	 * select_mask condition
+	 */
+	while(cache !=3D cache_end) {
+		struct cache_entry *ce =3D *cache;
+		const char *name, *slash;
+		int len, dtype;
+
+		if (select_mask && !(ce->ce_flags & select_mask)) {
+			cache++;
+			continue;
+		}
+
+		if (prefix_len && strncmp(ce->name, prefix, prefix_len))
+			break;
+
+		name =3D ce->name + prefix_len;
+		slash =3D strchr(name, '/');
+
+		/* If it's a directory, try whole directory match first */
+		if (slash) {
+			len =3D slash - name;
+			int processed;
+
+			memcpy(prefix + prefix_len, name, len);
+
+			/*
+			 * terminate the string (no trailing slash),
+			 * clear_c_f_dir needs it
+			 */
+			prefix[prefix_len + len] =3D '\0';
+			processed =3D clear_ce_flags_dir(cache, cache_end - cache,
+						       prefix, prefix_len + len,
+						       prefix + prefix_len,
+						       select_mask, clear_mask,
+						       el);
+
+			/* clear_c_f_dir eats a whole dir already? */
+			if (processed) {
+				cache +=3D processed;
+				continue;
+			}
+
+			prefix[prefix_len + len++] =3D '/';
+			cache +=3D clear_ce_flags_1(cache, cache_end - cache,
+						  prefix, prefix_len + len,
+						  select_mask, clear_mask, el);
+			continue;
+		}
+
+		/* Non-directory */
+		dtype =3D ce_to_dtype(ce);
+		if (excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, el) >=
 0)
+			ce->ce_flags &=3D ~clear_mask;
+		cache++;
+	}
+	return nr - (cache_end - cache);
+}
+
+static int clear_ce_flags(struct cache_entry **cache, int nr,
+			    int select_mask, int clear_mask,
+			    struct exclude_list *el)
+{
+	char prefix[PATH_MAX];
+	return clear_ce_flags_1(cache, nr,
+				prefix, 0,
+				select_mask, clear_mask,
+				el);
+}
+
 /*
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-ch=
eckout
  */
@@ -843,17 +966,28 @@ static void mark_new_skip_worktree(struct exclude=
_list *el,
 {
 	int i;
=20
+	/*
+	 * 1. Pretend the narrowest worktree: only unmerged entries
+	 * are checked out
+	 */
 	for (i =3D 0; i < the_index->cache_nr; i++) {
 		struct cache_entry *ce =3D the_index->cache[i];
=20
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
=20
-		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+		if (!ce_stage(ce))
 			ce->ce_flags |=3D skip_wt_flag;
 		else
 			ce->ce_flags &=3D ~skip_wt_flag;
 	}
+
+	/*
+	 * 2. Widen worktree according to sparse-checkout file.
+	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
+	 */
+	clear_ce_flags(the_index->cache, the_index->cache_nr,
+		       select_flag, skip_wt_flag, el);
 }
=20
 static int verify_absent(struct cache_entry *, enum unpack_trees_error=
_types, struct unpack_trees_options *);
--=20
1.7.3.2.316.gda8b3
