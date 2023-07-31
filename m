Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25239C04A94
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGaWpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGaWpG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:45:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C387212C
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:44:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 357F61A79D3;
        Mon, 31 Jul 2023 18:44:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=7XgWc/rUEn8Iuw3rqB4v9e+w/
        +0XXm+Et+8pRtlortw=; b=n9k4jm2n44UY+rPNCM3AmrFPGHJfTWlaBWxTsfVYF
        iVTuP4JwYLB246FR1cXT4Sb04eMW1I73TBrvdvKI87XtlBroAho0gYW5wdALGUts
        VoWU0UPbvXJ7g4GZ9yT22ewu7p+yUpjm9hGlEBG9YrO17UV4Ygoy3XjmQM58/36u
        gQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A7371A79D2;
        Mon, 31 Jul 2023 18:44:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DECA1A79CF;
        Mon, 31 Jul 2023 18:44:27 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] checkout: allow "checkout -m path" to unmerge removed paths
Date:   Mon, 31 Jul 2023 15:44:09 -0700
Message-ID: <20230731224409.4181277-8-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CE0932A6-2FF3-11EE-80E6-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout -m -- path" uses the unmerge_marked_index() API, whose
implementation is incapable of unresolving a path that was resolved
as removed.  Extend the unmerge_index() API function so that we can
mark the ce_flags member of the cache entries we add to the index as
unmerged, and replace use of unmerge_marked_index() with it.

Now, together with its unmerge_index_entry_at() helper function,
unmerge_marked_index() function is no longer called by anybody, and
can safely be removed.

This makes two known test failures in t2070 and t7201 to succeed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c     |  6 ++--
 builtin/update-index.c |  2 +-
 rerere.c               |  2 +-
 resolve-undo.c         | 75 +++---------------------------------------
 resolve-undo.h         |  6 ++--
 t/t2070-restore.sh     |  2 +-
 t/t7201-co.sh          |  2 +-
 7 files changed, 13 insertions(+), 82 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b8dfba57c6..98fcf1220a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -566,6 +566,8 @@ static int checkout_paths(const struct checkout_opts =
*opts,
=20
 	if (opts->source_tree)
 		read_tree_some(opts->source_tree, &opts->pathspec);
+	if (opts->merge)
+		unmerge_index(&the_index, &opts->pathspec, CE_MATCHED);
=20
 	ps_matched =3D xcalloc(opts->pathspec.nr, 1);
=20
@@ -589,10 +591,6 @@ static int checkout_paths(const struct checkout_opts=
 *opts,
 	}
 	free(ps_matched);
=20
-	/* "checkout -m path" to recreate conflicted state */
-	if (opts->merge)
-		unmerge_marked_index(&the_index);
-
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < the_index.cache_nr; pos++) {
 		const struct cache_entry *ce =3D the_index.cache[pos];
diff --git a/builtin/update-index.c b/builtin/update-index.c
index def7f98504..69fe9c8fcb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -646,7 +646,7 @@ static int unresolve_one(const char *path)
 	item =3D string_list_lookup(the_index.resolve_undo, path);
 	if (!item)
 		return res; /* no resolve-undo record for the path */
-	res =3D unmerge_index_entry(&the_index, path, item->util);
+	res =3D unmerge_index_entry(&the_index, path, item->util, 0);
 	FREE_AND_NULL(item->util);
 	return res;
 }
diff --git a/rerere.c b/rerere.c
index e968d413d6..b525dd9230 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1112,7 +1112,7 @@ int rerere_forget(struct repository *r, struct path=
spec *pathspec)
 	 * recover the original conflicted state and then
 	 * find the conflicted paths.
 	 */
-	unmerge_index(r->index, pathspec);
+	unmerge_index(r->index, pathspec, 0);
 	find_conflict(r, &conflict);
 	for (i =3D 0; i < conflict.nr; i++) {
 		struct string_list_item *it =3D &conflict.items[i];
diff --git a/resolve-undo.c b/resolve-undo.c
index 3b0244e210..8e5a8072ed 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -115,75 +115,8 @@ void resolve_undo_clear_index(struct index_state *is=
tate)
 	istate->cache_changed |=3D RESOLVE_UNDO_CHANGED;
 }
=20
-int unmerge_index_entry_at(struct index_state *istate, int pos)
-{
-	const struct cache_entry *ce;
-	struct string_list_item *item;
-	struct resolve_undo_info *ru;
-	int i, err =3D 0, matched;
-	char *name;
-
-	if (!istate->resolve_undo)
-		return pos;
-
-	ce =3D istate->cache[pos];
-	if (ce_stage(ce)) {
-		/* already unmerged */
-		while ((pos < istate->cache_nr) &&
-		       ! strcmp(istate->cache[pos]->name, ce->name))
-			pos++;
-		return pos - 1; /* return the last entry processed */
-	}
-	item =3D string_list_lookup(istate->resolve_undo, ce->name);
-	if (!item)
-		return pos;
-	ru =3D item->util;
-	if (!ru)
-		return pos;
-	matched =3D ce->ce_flags & CE_MATCHED;
-	name =3D xstrdup(ce->name);
-	remove_index_entry_at(istate, pos);
-	for (i =3D 0; i < 3; i++) {
-		struct cache_entry *nce;
-		if (!ru->mode[i])
-			continue;
-		nce =3D make_cache_entry(istate,
-				       ru->mode[i],
-				       &ru->oid[i],
-				       name, i + 1, 0);
-		if (matched)
-			nce->ce_flags |=3D CE_MATCHED;
-		if (add_index_entry(istate, nce, ADD_CACHE_OK_TO_ADD)) {
-			err =3D 1;
-			error("cannot unmerge '%s'", name);
-		}
-	}
-	free(name);
-	if (err)
-		return pos;
-	free(ru);
-	item->util =3D NULL;
-	return unmerge_index_entry_at(istate, pos);
-}
-
-void unmerge_marked_index(struct index_state *istate)
-{
-	int i;
-
-	if (!istate->resolve_undo)
-		return;
-
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
-	for (i =3D 0; i < istate->cache_nr; i++) {
-		const struct cache_entry *ce =3D istate->cache[i];
-		if (ce->ce_flags & CE_MATCHED)
-			i =3D unmerge_index_entry_at(istate, i);
-	}
-}
-
 int unmerge_index_entry(struct index_state *istate, const char *path,
-			struct resolve_undo_info *ru)
+			struct resolve_undo_info *ru, unsigned ce_flags)
 {
 	int i =3D index_name_pos(istate, path, strlen(path));
=20
@@ -206,13 +139,15 @@ int unmerge_index_entry(struct index_state *istate,=
 const char *path,
 			continue;
 		ce =3D make_cache_entry(istate, ru->mode[i], &ru->oid[i],
 				      path, i + 1, 0);
+		ce->ce_flags |=3D ce_flags;
 		if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD))
 			return error("cannot unmerge '%s'", path);
 	}
 	return 0;
 }
=20
-void unmerge_index(struct index_state *istate, const struct pathspec *pa=
thspec)
+void unmerge_index(struct index_state *istate, const struct pathspec *pa=
thspec,
+		   unsigned ce_flags)
 {
 	struct string_list_item *item;
=20
@@ -231,7 +166,7 @@ void unmerge_index(struct index_state *istate, const =
struct pathspec *pathspec)
 				    item->string, strlen(item->string),
 				    0, NULL, 0))
 			continue;
-		unmerge_index_entry(istate, path, ru);
+		unmerge_index_entry(istate, path, ru, ce_flags);
 		free(ru);
 		item->util =3D NULL;
 	}
diff --git a/resolve-undo.h b/resolve-undo.h
index 1ae321c88b..f3f8462751 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -17,9 +17,7 @@ void record_resolve_undo(struct index_state *, struct c=
ache_entry *);
 void resolve_undo_write(struct strbuf *, struct string_list *);
 struct string_list *resolve_undo_read(const char *, unsigned long);
 void resolve_undo_clear_index(struct index_state *);
-int unmerge_index_entry_at(struct index_state *, int);
-int unmerge_index_entry(struct index_state *, const char *, struct resol=
ve_undo_info *);
-void unmerge_index(struct index_state *, const struct pathspec *);
-void unmerge_marked_index(struct index_state *);
+int unmerge_index_entry(struct index_state *, const char *, struct resol=
ve_undo_info *, unsigned);
+void unmerge_index(struct index_state *, const struct pathspec *, unsign=
ed);
=20
 #endif
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index d97ecc2483..16d6348b69 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -180,7 +180,7 @@ test_expect_success 'restore --merge to unresolve aft=
er (mistaken) resolution' '
 	test_cmp expect file
 '
=20
-test_expect_failure 'restore --merge to unresolve after (mistaken) resol=
ution' '
+test_expect_success 'restore --merge to unresolve after (mistaken) resol=
ution' '
 	O=3D$(echo original | git hash-object -w --stdin) &&
 	A=3D$(echo ourside | git hash-object -w --stdin) &&
 	B=3D$(echo theirside | git hash-object -w --stdin) &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 4b07a26c14..df582295df 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -543,7 +543,7 @@ test_expect_success 'checkout -m works after (mistake=
n) resolution' '
 	test_cmp merged file
 '
=20
-test_expect_failure 'checkout -m works after (mistaken) resolution to re=
move' '
+test_expect_success 'checkout -m works after (mistaken) resolution to re=
move' '
 	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	cat sample >fild &&
--=20
2.41.0-478-gee48e70a82

