Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047EC47420
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC2820936
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="H9rExSqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgI2QNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbgI2QNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:30 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B0CC0613D1
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IOuufPBiiGRPbThdGEaT/5mWRYmqBzXAcHmDm7As7vs=; b=H9rExSquY+eEuojEiTY0FghEZO
        qguzpAABYghSlLvtvy/FV5XLqmdTY3ZFbddD8wnrdvMEj3slpcU/8//R7z9ffSwygQZ2Fv7VLVbET
        jHQRWt0sxmapdbYyYvHtltJ2dxXoOHnNey4udBEkYjIclmW8JX2fupAvMbWxexAyD3DI=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx7-0004AY-CQ; Tue, 29 Sep 2020 15:54:05 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 1/7] refs: store owning repository for object lookup
Date:   Tue, 29 Sep 2020 16:53:44 +0100
Message-Id: <20200929155350.49066-2-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling ref_resolves_to_object we want to be able to pass the
correct repository.  This is intended to allow correct handling of
promisors and alternates inside submodules.

This change continues to pass the_repository around, even in the case
where a submodule is being used.  It shouldn't change any behaviour by
itself.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 refs.c                | 21 +++++++++++++--------
 refs/debug.c          |  3 ++-
 refs/files-backend.c  | 22 +++++++++++++---------
 refs/iterator.c       | 11 ++++++++---
 refs/packed-backend.c | 10 +++++++---
 refs/packed-backend.h |  3 ++-
 refs/ref-cache.c      |  3 ++-
 refs/refs-internal.h  | 14 +++++++++++---
 8 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index fa01153151..e62da6f2de 100644
--- a/refs.c
+++ b/refs.c
@@ -254,13 +254,14 @@ int refname_is_safe(const char *refname)
  * be resolved to an object in the database. If the referred-to object
  * does not exist, emit a warning and return false.
  */
-int ref_resolves_to_object(const char *refname,
+int ref_resolves_to_object(struct repository *repo,
+			   const char *refname,
 			   const struct object_id *oid,
 			   unsigned int flags)
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!has_object_file(oid)) {
+	if (!repo_has_object_file(repo, oid)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
@@ -1751,7 +1752,8 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
  * Create, record, and return a ref_store instance for the specified
  * gitdir.
  */
-static struct ref_store *ref_store_init(const char *gitdir,
+static struct ref_store *ref_store_init(struct repository *repo,
+					const char *gitdir,
 					unsigned int flags)
 {
 	const char *be_name = "files";
@@ -1761,7 +1763,7 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
-	refs = be->init(gitdir, flags);
+	refs = be->init(repo, gitdir, flags);
 	return refs;
 }
 
@@ -1773,7 +1775,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
@@ -1829,7 +1831,8 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf,
+	refs = ref_store_init(the_repository,
+			      submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1855,10 +1858,12 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 		return refs;
 
 	if (wt->id)
-		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
+		refs = ref_store_init(the_repository,
+				      git_common_path("worktrees/%s", wt->id),
 				      REF_STORE_ALL_CAPS);
 	else
-		refs = ref_store_init(get_git_common_dir(),
+		refs = ref_store_init(the_repository,
+				      get_git_common_dir(),
 				      REF_STORE_ALL_CAPS);
 
 	if (refs)
diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6a..6525142cc4 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -230,7 +230,8 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
 	struct ref_iterator *res =
 		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
 	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
-	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
+	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable,
+			       ref_store->repo, 1);
 	diter->iter = res;
 	trace_printf_key(&trace_refs, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
 	return &diter->base;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04e85e7002..2ddb680c5c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -79,13 +79,15 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *gitdir,
+static struct ref_store *files_ref_store_create(struct repository *repo,
+						const char *gitdir,
 						unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
+	ref_store->repo = repo;
 	ref_store->gitdir = xstrdup(gitdir);
 	base_ref_store_init(ref_store, &refs_be_files);
 	refs->store_flags = flags;
@@ -93,7 +95,7 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
-	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
+	refs->packed_ref_store = packed_ref_store_create(repo, sb.buf, flags);
 	strbuf_release(&sb);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
@@ -745,7 +747,8 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->iter0->refname,
+		    !ref_resolves_to_object(ref_iterator->repo,
+					    iter->iter0->refname,
 					    iter->iter0->oid,
 					    iter->iter0->flags))
 			continue;
@@ -846,7 +849,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
-			       overlay_iter->ordered);
+			       ref_store->repo, overlay_iter->ordered);
 	iter->iter0 = overlay_iter;
 	iter->flags = flags;
 
@@ -1115,7 +1118,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
 /*
  * Return true if the specified reference should be packed.
  */
-static int should_pack_ref(const char *refname,
+static int should_pack_ref(struct repository* repo, const char *refname,
 			   const struct object_id *oid, unsigned int ref_flags,
 			   unsigned int pack_flags)
 {
@@ -1132,7 +1135,7 @@ static int should_pack_ref(const char *refname,
 		return 0;
 
 	/* Do not pack broken refs: */
-	if (!ref_resolves_to_object(refname, oid, ref_flags))
+	if (!ref_resolves_to_object(repo, refname, oid, ref_flags))
 		return 0;
 
 	return 1;
@@ -1162,8 +1165,8 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * in the packed ref cache. If the reference should be
 		 * pruned, also add it to refs_to_prune.
 		 */
-		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
-				     flags))
+		if (!should_pack_ref(ref_store->repo, iter->refname, iter->oid,
+				     iter->flags, flags))
 			continue;
 
 		/*
@@ -2155,7 +2158,8 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 
-	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable,
+			       ref_store->repo, 0);
 	iter->dir_iterator = diter;
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
diff --git a/refs/iterator.c b/refs/iterator.c
index 629e00a122..a68dd452b6 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -26,9 +26,11 @@ int ref_iterator_abort(struct ref_iterator *ref_iterator)
 
 void base_ref_iterator_init(struct ref_iterator *iter,
 			    struct ref_iterator_vtable *vtable,
+			    struct repository *repo,
 			    int ordered)
 {
 	iter->vtable = vtable;
+	iter->repo = repo;
 	iter->ordered = !!ordered;
 	iter->refname = NULL;
 	iter->oid = NULL;
@@ -74,7 +76,8 @@ struct ref_iterator *empty_ref_iterator_begin(void)
 	struct empty_ref_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 
-	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable,
+			       NULL, 1);
 	return ref_iterator;
 }
 
@@ -222,7 +225,8 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 * references through only if they exist in both iterators.
 	 */
 
-	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable, ordered);
+	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable,
+			       iter0->repo, ordered);
 	iter->iter0 = iter0;
 	iter->iter1 = iter1;
 	iter->select = select;
@@ -396,7 +400,8 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 
-	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable, iter0->ordered);
+	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable,
+			       iter0->repo, iter0->ordered);
 
 	iter->iter0 = iter0;
 	iter->prefix = xstrdup(prefix);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b912f2505f..9743ee0155 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -193,13 +193,15 @@ static int release_snapshot(struct snapshot *snapshot)
 	}
 }
 
-struct ref_store *packed_ref_store_create(const char *path,
+struct ref_store *packed_ref_store_create(struct repository *repo,
+					  const char *path,
 					  unsigned int store_flags)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 
 	base_ref_store_init(ref_store, &refs_be_packed);
+	ref_store->repo = repo;
 	ref_store->gitdir = xstrdup(path);
 	refs->store_flags = store_flags;
 
@@ -864,7 +866,8 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
+		    !ref_resolves_to_object(ref_iterator->repo,
+					    iter->base.refname, &iter->oid,
 					    iter->flags))
 			continue;
 
@@ -943,7 +946,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
-	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable,
+			       ref_store->repo, 1);
 
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index a01a0aff9c..942c908771 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -12,7 +12,8 @@ struct ref_transaction;
  * even among packed refs.
  */
 
-struct ref_store *packed_ref_store_create(const char *path,
+struct ref_store *packed_ref_store_create(struct repository *repo,
+					  const char *path,
 					  unsigned int store_flags);
 
 /*
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index b7052f72e2..974d37ee79 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -532,7 +532,8 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
-	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable,
+			       cache->ref_store->repo, 1);
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 
 	iter->levels_nr = 1;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c93..9e9b2e8c76 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -65,7 +65,8 @@ int refname_is_safe(const char *refname);
  * oid and flags, can be resolved to an object in the database. If the
  * referred-to object does not exist, emit a warning and return false.
  */
-int ref_resolves_to_object(const char *refname,
+int ref_resolves_to_object(struct repository *repo,
+			   const char *refname,
 			   const struct object_id *oid,
 			   unsigned int flags);
 
@@ -299,6 +300,8 @@ int refs_rename_ref_available(struct ref_store *refs,
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
 
+	struct repository *repo;
+
 	/*
 	 * Does this `ref_iterator` iterate over references in order
 	 * by refname?
@@ -432,6 +435,7 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
  */
 void base_ref_iterator_init(struct ref_iterator *iter,
 			    struct ref_iterator_vtable *vtable,
+			    struct repository* repo,
 			    int ordered);
 
 /*
@@ -518,11 +522,12 @@ struct ref_store;
 				 REF_STORE_MAIN)
 
 /*
- * Initialize the ref_store for the specified gitdir. These functions
+ * Initialize the ref_store for the specified repository. These functions
  * should call base_ref_store_init() to initialize the shared part of
  * the ref_store and to record the ref_store for later lookup.
  */
-typedef struct ref_store *ref_store_init_fn(const char *gitdir,
+typedef struct ref_store *ref_store_init_fn(struct repository* repo,
+					    char const *gitdir,
 					    unsigned int flags);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
@@ -680,6 +685,9 @@ struct ref_store {
 	/* The backend describing this ref_store's storage scheme: */
 	const struct ref_storage_be *be;
 
+	/* The repository that this ref_store is for: */
+	struct repository* repo;
+
 	/* The gitdir that this ref_store applies to: */
 	char *gitdir;
 };
-- 
2.26.2

