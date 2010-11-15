From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/10] unpack-trees: fix sparse checkout's "unable to match directories" fault
Date: Mon, 15 Nov 2010 17:36:44 +0700
Message-ID: <1289817410-32470-5-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:39:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwT6-0001wr-HY
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079Ab0KOKjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:39:16 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35059 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0KOKjP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:39:15 -0500
Received: by pva4 with SMTP id 4so922891pva.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SBdSHSMuR6DnjJQJ693kM/JosOOR3ITupJ6+YM70qpw=;
        b=cvuxEUx4KJK9m3VBtcfDp4bdq3yhNcUjZLc9tr/Td8j5KnUoA4iNpNRGAZ80Qi93k+
         KEHwWGbHKy4483b9ZFReroPQTDcAI1oFyCtbWn6P2pFObWjP64b3Bia+kMjKtecKzf3d
         77/T3KlH2fJ2vrWNHXXGHSJiuns9qSMVKtY18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kKWNmCbhzmSbvNWKvYGMMwnkDEhojY7Xv5vSl0fRjgYY34sbAj8w0Bog6AYHOZ3Cp4
         B+wCI01hahAIGz54ROoQepuav0xrHQzhtYyhhbSXvWfgoCsFE2vqsJ1Wn3cThIWS4oQE
         5LVZCynm7H5+TR7edHJCfZKNciiDurF19wvMI=
Received: by 10.142.82.4 with SMTP id f4mr2526341wfb.293.1289817555415;
        Mon, 15 Nov 2010 02:39:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id y42sm8575666wfd.10.2010.11.15.02.39.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:39:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:37:58 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161481>

excluded_from_list() is designed to be work with a directory
structure, where there are files and directories. Index however is a
list of files, no directories, not really fit in excluded_from_list()
design.

Commit c84de70 (excluded_1(): support exclude files in index -
2009-08-20) helped make it work somewhat. Although the lack of proper
dtype means pattern "blah" won't match entries "blah/..." in the index.

clear_ce_flags() is now used to match the index against sparse
patterns. It does generate directories for excluded_from_list() so the
"blah" case should now work.

Also revert c84de70 because it is no longer needed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-read-tree.txt      |    7 -------
 dir.c                                |    6 ------
 t/t1011-read-tree-sparse-checkout.sh |   14 +++++++++++---
 unpack-trees.c                       |   33 ++++++++++++++++++--------=
-------
 4 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index e88e9c2..634423a 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -416,13 +416,6 @@ turn `core.sparseCheckout` on in order to have spa=
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
diff --git a/dir.c b/dir.c
index d1e5e5e..2b38f94 100644
--- a/dir.c
+++ b/dir.c
@@ -359,12 +359,6 @@ int excluded_from_list(const char *pathname,
 			int to_exclude =3D x->to_exclude;
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
-				if (!dtype) {
-					if (!prefixcmp(pathname, exclude))
-						return to_exclude;
-					else
-						continue;
-				}
 				if (*dtype =3D=3D DT_UNKNOWN)
 					*dtype =3D get_dtype(NULL, pathname, pathlen);
 				if (*dtype !=3D DT_DIR)
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 9a07de1..50f7dfe 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -91,12 +91,20 @@ test_expect_success 'match directories with trailin=
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
index 6c266ef..f005454 100644
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
@@ -926,14 +917,19 @@ static void set_new_skip_worktree_1(struct unpack=
_trees_options *o)
 {
 	int i;
=20
+	/* Mark everything out (except staged entries) */
 	for (i =3D 0;i < o->src_index->cache_nr;i++) {
 		struct cache_entry *ce =3D o->src_index->cache[i];
 		ce->ce_flags &=3D ~CE_ADDED;
-		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+		if (!ce_stage(ce))
 			ce->ce_flags |=3D CE_NEW_SKIP_WORKTREE;
 		else
 			ce->ce_flags &=3D ~CE_NEW_SKIP_WORKTREE;
 	}
+
+	/* Then mark some of them in again according to o->el */
+	clear_ce_flags(o->src_index->cache, o->src_index->cache_nr,
+		       0, CE_NEW_SKIP_WORKTREE, o);
 }
=20
 static int verify_absent(struct cache_entry *, enum unpack_trees_error=
_types, struct unpack_trees_options *);
@@ -943,19 +939,26 @@ static int set_new_skip_worktree_2(struct unpack_=
trees_options *o)
=20
 	/*
 	 * CE_ADDED marks new index entries. These have not been processed
-	 * by set_new_skip_worktree_1() so we do it here.
+	 * by set_new_skip_worktree_1() so we do it here. Mark every new
+	 * entries out.
 	 */
 	for (i =3D 0;i < o->result.cache_nr;i++) {
 		struct cache_entry *ce =3D o->result.cache[i];
+		if (ce->ce_flags & CE_ADDED)
+			ce->ce_flags |=3D CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE;
+	}
+
+	/* Then mark some of them in again */
+	clear_ce_flags(o->result.cache, o->result.cache_nr, CE_ADDED,
+		       CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE, o);
+
+	for (i =3D 0;i < o->result.cache_nr;i++) {
+		struct cache_entry *ce =3D o->result.cache[i];
=20
 		if (!(ce->ce_flags & CE_ADDED))
 			continue;
=20
 		ce->ce_flags &=3D ~CE_ADDED;
-		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
-			ce->ce_flags |=3D CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE;
-		else
-			ce->ce_flags &=3D ~(CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
=20
 		/* Left-over checks from merged_entry when old =3D=3D NULL */
 		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
--=20
1.7.3.2.210.g045198
