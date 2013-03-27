From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] checkout: avoid unnecessary match_pathspec calls
Date: Wed, 27 Mar 2013 12:58:21 +0700
Message-ID: <1364363901-17815-1-git-send-email-pclouds@gmail.com>
References: <7vr4j3zbrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 06:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKjNz-00069I-9v
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 06:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab3C0F6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 01:58:31 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:61722 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3C0F6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 01:58:30 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so2469281dae.37
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GUgnjpoIDdXwV+mGKT5WCk7Q98hr3P0MOhnHPu8WX7g=;
        b=N4XmkgokCUlBdbKXaA4lknslbn3IDwkffxC40nPjZdQEcmVknGcvpbWAJlon0GMi3y
         RZRXIzuBiwH7ysfUrfZN9GvTMk2lbQA0vDqVNhATw+vnyuuP82aSzbpOHFFX/oObPRE2
         0GosnKWeQgp60q+RyR9CEo9pRODEUs0nSteCnne1M979nULh8dtybRN4r1iAbIWoTQSA
         ZZAfiBg8yMu/Jnd1Fuxm13u7yhC0sxu3StXE0Mz1y06TcQIGGuaISF2X/1t3VYTXV+MF
         G2jgdOjDgLeSiVHVg3PNu+MqWJOrkqitoOmJ4mB9dXh6X2QcKDx0wvzl+0xz9Q0pjM2o
         y3NQ==
X-Received: by 10.68.242.65 with SMTP id wo1mr27290885pbc.62.1364363909932;
        Tue, 26 Mar 2013 22:58:29 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id tm1sm20240627pbc.11.2013.03.26.22.58.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 22:58:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Mar 2013 12:58:22 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <7vr4j3zbrz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219240>

In checkout_paths() we do this

 - for all updated items, call match_pathspec
 - for all items, call match_pathspec (inside unmerge_cache)
 - for all items, call match_pathspec (for showing "path .. is unmerged=
)
 - for updated items, call match_pathspec and update paths

That's a lot of duplicate match_pathspec(s) and the function is not
exactly cheap to be called so many times, especially on large indexes.
This patch makes it call match_pathspec once per updated index entry,
save the result in ce_flags and reuse the results in the following
loops.

The changes in 0a1283b (checkout $tree $path: do not clobber local
changes in $path not in $tree - 2011-09-30) limit the affected paths
to ones we read from $tree. We do not do anything to other modified
entries in this case, so the "for all items" above could be modified
to "for all updated items". But..

The command's behavior now is modified slightly: unmerged entries that
match $path, but not updated by $tree, are now NOT touched.  Although
this should be considered a bug fix, not a regression. A new test is
added for this change.

And while at there, free ps_matched after use.

The following command is tested on webkit, 215k entries. The pattern
is chosen mainly to make match_pathspec sweat:

git checkout -- "*[a-zA-Z]*[a-zA-Z]*[a-zA-Z]*"

        before      after
real    0m3.493s    0m2.737s
user    0m2.239s    0m1.586s
sys     0m1.252s    0m1.151s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Changes from v2: a new test and some note about matching twice in
 "checkout $tree $path", once in read_tree_some and once checkout_paths=
=2E
 We may be able avoid match_pathspec entirely in this case when
 tree_entry_interesting learns to fill ps_matched.

 builtin/checkout.c        | 43 ++++++++++++++++++++++++++++++++++++---=
----
 cache.h                   |  1 +
 resolve-undo.c            | 19 ++++++++++++++++++-
 resolve-undo.h            |  1 +
 t/t2022-checkout-paths.sh | 21 +++++++++++++++++++++
 5 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..f8033f4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -271,24 +271,55 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
 		;
 	ps_matched =3D xcalloc(1, pos);
=20
+	/*
+	 * Make sure all pathspecs participated in locating the paths
+	 * to be checked out.
+	 */
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
+		ce->ce_flags &=3D ~CE_MATCHED;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
+			/*
+			 * "git checkout tree-ish -- path", but this entry
+			 * is in the original index; it will not be checked
+			 * out to the working tree and it does not matter
+			 * if pathspec matched this entry.  We will not do
+			 * anything to this entry at all.
+			 */
 			continue;
-		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
+		/*
+		 * Either this entry came from the tree-ish we are
+		 * checking the paths out of, or we are checking out
+		 * of the index.
+		 *
+		 * If it comes from the tree-ish, we already know it
+		 * matches the pathspec and could just stamp
+		 * CE_MATCHED to it from update_some(). But we still
+		 * need ps_matched and read_tree_recursive (and
+		 * eventually tree_entry_interesting) cannot fill
+		 * ps_matched yet. Once it can, we can avoid calling
+		 * match_pathspec() for _all_ entries when
+		 * opts->source_tree !=3D NULL.
+		 */
+		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce),
+				   0, ps_matched))
+			ce->ce_flags |=3D CE_MATCHED;
 	}
=20
-	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
+	if (report_path_error(ps_matched, opts->pathspec, opts->prefix)) {
+		free(ps_matched);
 		return 1;
+	}
+	free(ps_matched);
=20
 	/* "checkout -m path" to recreate conflicted state */
 	if (opts->merge)
-		unmerge_cache(opts->pathspec);
+		unmerge_marked_index(&the_index);
=20
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
+		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -313,9 +344,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	state.refresh_cache =3D 1;
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
-			continue;
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
+		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state, NULL);
 				continue;
diff --git a/cache.h b/cache.h
index c56315c..04e6090 100644
--- a/cache.h
+++ b/cache.h
@@ -161,6 +161,7 @@ struct cache_entry {
=20
 #define CE_UNPACKED          (1 << 24)
 #define CE_NEW_SKIP_WORKTREE (1 << 25)
+#define CE_MATCHED           (1 << 26)
=20
 /*
  * Extended on-disk flags
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..639eb9c 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -118,7 +118,7 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 	struct cache_entry *ce;
 	struct string_list_item *item;
 	struct resolve_undo_info *ru;
-	int i, err =3D 0;
+	int i, err =3D 0, matched;
=20
 	if (!istate->resolve_undo)
 		return pos;
@@ -137,6 +137,7 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 	ru =3D item->util;
 	if (!ru)
 		return pos;
+	matched =3D ce->ce_flags & CE_MATCHED;
 	remove_index_entry_at(istate, pos);
 	for (i =3D 0; i < 3; i++) {
 		struct cache_entry *nce;
@@ -144,6 +145,8 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 			continue;
 		nce =3D make_cache_entry(ru->mode[i], ru->sha1[i],
 				       ce->name, i + 1, 0);
+		if (matched)
+			nce->ce_flags |=3D CE_MATCHED;
 		if (add_index_entry(istate, nce, ADD_CACHE_OK_TO_ADD)) {
 			err =3D 1;
 			error("cannot unmerge '%s'", ce->name);
@@ -156,6 +159,20 @@ int unmerge_index_entry_at(struct index_state *ist=
ate, int pos)
 	return unmerge_index_entry_at(istate, pos);
 }
=20
+void unmerge_marked_index(struct index_state *istate)
+{
+	int i;
+
+	if (!istate->resolve_undo)
+		return;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce =3D istate->cache[i];
+		if (ce->ce_flags & CE_MATCHED)
+			i =3D unmerge_index_entry_at(istate, i);
+	}
+}
+
 void unmerge_index(struct index_state *istate, const char **pathspec)
 {
 	int i;
diff --git a/resolve-undo.h b/resolve-undo.h
index 8458769..7a30206 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -12,5 +12,6 @@ extern struct string_list *resolve_undo_read(const ch=
ar *, unsigned long);
 extern void resolve_undo_clear_index(struct index_state *);
 extern int unmerge_index_entry_at(struct index_state *, int);
 extern void unmerge_index(struct index_state *, const char **);
+extern void unmerge_marked_index(struct index_state *);
=20
 #endif
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index 56090d2..5e01d58 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -39,4 +39,25 @@ test_expect_success 'checking out paths out of a tre=
e does not clobber unrelated
 	test_cmp expect.next2 dir/next2
 '
=20
+test_expect_success 'do not touch unmerged entries matching $path but =
not in $tree' '
+	git checkout next &&
+	git reset --hard &&
+
+	cat dir/common >expect.common &&
+	EMPTY_SHA1=3De69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+	git rm dir/next0 &&
+	cat >expect.next0<<EOF &&
+100644 $EMPTY_SHA1 1	dir/next0
+100644 $EMPTY_SHA1 2	dir/next0
+EOF
+	git update-index --index-info < expect.next0 &&
+
+	git checkout master dir &&
+
+	test_cmp expect.common dir/common &&
+	test_path_is_file dir/master &&
+	git diff --exit-code master dir/master &&
+	git ls-files -s dir/next0 >actual.next0
+'
+
 test_done
--=20
1.8.2.82.gc24b958
