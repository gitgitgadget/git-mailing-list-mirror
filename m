Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CBFC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D062343E
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbhATTvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:51:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:33266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392592AbhATTp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:45:29 -0500
Received: (qmail 28673 invoked by uid 109); 20 Jan 2021 19:44:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 19:44:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25367 invoked by uid 111); 20 Jan 2021 19:44:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 14:44:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 14:44:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH] refs: switch peel_ref() to peel_iterated_oid()
Message-ID: <YAiIK+/hSRxaUx/K@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has been bugging me for years, and came up again in:

  https://lore.kernel.org/git/YAhXw9Gvn5Pyvacq@coredump.intra.peff.net/

so I decided to finally do something about it. There's a minor textual
conflict with the caller being touched in that thread, but it's easy to
resolve. So I think it's OK to consider the two independent.

The commit message turned out rather long. I hope that doesn't scare
anybody away, but I wanted to cover all of the bases.

-- >8 --
Subject: refs: switch peel_ref() to peel_iterated_oid()

The peel_ref() interface is confusing and error-prone:

  - it's typically used by ref iteration callbacks that have both a
    refname and oid. But since they pass only the refname, we may load
    the ref value from the filesystem again. This is inefficient, but
    also means we are open to a race if somebody simultaneously updates
    the ref. E.g., this:

      int some_ref_cb(const char *refname, const struct object_id *oid, ...)
      {
              if (!peel_ref(refname, &peeled))
                      printf("%s peels to %s",
                             oid_to_hex(oid), oid_to_hex(&peeled);
      }

    could print nonsense. It is correct to say "refname peels to..."
    (you may see the "before" value or the "after" value, either of
    which is consistent), but mentioning both oids may be mixing
    before/after values.

    Worse, whether this is possible depends on whether the optimization
    to read from the current iterator value kicks in. So it is actually
    not possible with:

      for_each_ref(some_ref_cb);

    but it _is_ possible with:

      head_ref(some_ref_cb);

    which does not use the iterator mechanism (though in practice, HEAD
    should never peel to anything, so this may not be triggerable).

  - it must take a fully-qualified refname for the read_ref_full() code
    path to work. Yet we routinely pass it partial refnames from
    callbacks to for_each_tag_ref(), etc. This happens to work when
    iterating because there we do not call read_ref_full() at all, and
    only use the passed refname to check if it is the same as the
    iterator. But the requirements for the function parameters are quite
    unclear.

Instead of taking a refname, let's instead take an oid. That fixes both
problems. It's a little funny for a "ref" function not to involve refs
at all. The key thing is that it's optimizing under the hood based on
having access to the ref iterator. So let's change the name to make it
clear why you'd want this function versus just peel_object().

There are two other directions I considered but rejected:

  - we could pass the peel information into the each_ref_fn callback.
    However, we don't know if the caller actually wants it or not. For
    packed-refs, providing it is essentially free. But for loose refs,
    we actually have to peel the object, which would be wasteful in most
    cases. We could likewise pass in a flag to the callback indicating
    whether the peeled information is known, but that complicates those
    callbacks, as they then have to decide whether to manually peel
    themselves. Plus it requires changing the interface of every
    callback, whether they care about peeling or not, and there are many
    of them.

  - we could make a function to return the peeled value of the current
    iterated ref (computing it if necessary), and BUG() otherwise. I.e.:

      int peel_current_iterated_ref(struct object_id *out);

    Each of the current callers is an each_ref_fn callback, so they'd
    mostly be happy. But:

      - we use those callbacks with functions like head_ref(), which do
        not use the iteration code. So we'd need to handle the fallback
        case there, anyway.

      - it's possible that a caller would want to call into generic code
        that sometimes is used during iteration and sometimes not. This
        encapsulates the logic to do the fast thing when possible, and
        fallback when necessary.

The implementation is mostly obvious, but I want to call out a few
things in the patch:

  - the test-tool coverage for peel_ref() is now meaningless, as it all
    collapses to a single peel_object() call (arguably they were pretty
    uninteresting before; the tricky part of that function is the
    fast-path we see during iteration, but these calls didn't trigger
    that). I've just dropped it entirely, though note that some other
    tests relied on the tags we created; I've moved that creation to the
    tests where it matters.

  - we no longer need to take a ref_store parameter, since we'd never
    look up a ref now. We do still rely on a global "current iterator"
    variable which _could_ be kept per-ref-store. But in practice this
    is only useful if there are multiple recursive iterations, at which
    point the more appropriate solution is probably a stack of
    iterators. No caller used the actual ref-store parameter anyway
    (they all call the wrapper that passes the_repository).

  - the original only kicked in the optimization when the "refname"
    pointer matched (i.e., not string comparison). We do likewise with
    the "oid" parameter here, but fall back to doing an actual oideq()
    call. This in theory lets us kick in the optimization more often,
    though in practice no current caller cares. It should never be
    wrong, though (peeling is a property of an object, so two refs
    pointing to the same object would peel identically).

  - the original took care not to touch the peeled out-parameter unless
    we found something to put in it. But no caller cares about this, and
    anyway, it is enforced by peel_object() itself (and even in the
    optimized iterator case, that's where we eventually end up). We can
    shorten the code and avoid an extra copy by just passing the
    out-parameter through the stack.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c             |  2 +-
 builtin/gc.c                   |  2 +-
 builtin/pack-objects.c         |  4 ++--
 builtin/show-ref.c             |  2 +-
 commit-graph.c                 |  2 +-
 ls-refs.c                      |  2 +-
 refs.c                         | 29 ++++++-----------------------
 refs.h                         | 20 ++++++++++----------
 t/helper/test-ref-store.c      | 13 -------------
 t/t1405-main-ref-store.sh      |  8 +-------
 t/t1406-submodule-ref-store.sh | 10 ++--------
 upload-pack.c                  |  2 +-
 12 files changed, 27 insertions(+), 69 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7668591d57..40482d8e9f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -194,7 +194,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	}
 
 	/* Is it annotated? */
-	if (!peel_ref(path, &peeled)) {
+	if (!peel_iterated_oid(oid, &peeled)) {
 		is_annotated = !oideq(oid, &peeled);
 	} else {
 		oidcpy(&peeled, oid);
diff --git a/builtin/gc.c b/builtin/gc.c
index b315b2ad58..01e8dc9f70 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -769,7 +769,7 @@ static int dfs_on_ref(const char *refname,
 	struct commit_list *stack = NULL;
 	struct commit *commit;
 
-	if (!peel_ref(refname, &peeled))
+	if (!peel_iterated_oid(oid, &peeled))
 		oid = &peeled;
 	if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a00358f34..bd18139d7e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -629,7 +629,7 @@ static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 
 	if (entry)
 		entry->tagged = 1;
-	if (!peel_ref(path, &peeled)) {
+	if (!peel_iterated_oid(oid, &peeled)) {
 		entry = packlist_find(&to_pack, &peeled);
 		if (entry)
 			entry->tagged = 1;
@@ -2808,7 +2808,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 	struct object_id peeled;
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
-	    !peel_ref(path, &peeled)    && /* peelable? */
+	    !peel_iterated_oid(oid, &peeled)    && /* peelable? */
 	    obj_is_packed(&peeled)) /* object packed? */
 		add_tag_chain(oid);
 	return 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index ae60b4acf2..7f8a5332f8 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -40,7 +40,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 	if (!deref_tags)
 		return;
 
-	if (!peel_ref(refname, &peeled)) {
+	if (!peel_iterated_oid(oid, &peeled)) {
 		hex = find_unique_abbrev(&peeled, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index e9124d4a41..15c10fcc5a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1458,7 +1458,7 @@ static int add_ref_to_set(const char *refname,
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	if (!peel_ref(refname, &peeled))
+	if (!peel_iterated_oid(oid, &peeled))
 		oid = &peeled;
 	if (oid_object_info(the_repository, oid, NULL) == OBJ_COMMIT)
 		oidset_insert(data->commits, oid);
diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..7b9ae6498b 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -63,7 +63,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 	if (data->peel) {
 		struct object_id peeled;
-		if (!peel_ref(refname, &peeled))
+		if (!peel_iterated_oid(oid, &peeled))
 			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
 	}
 
diff --git a/refs.c b/refs.c
index 13dc2c3291..8a4780c201 100644
--- a/refs.c
+++ b/refs.c
@@ -1898,31 +1898,14 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
-int refs_peel_ref(struct ref_store *refs, const char *refname,
-		  struct object_id *oid)
+int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 {
-	int flag;
-	struct object_id base;
-
-	if (current_ref_iter && current_ref_iter->refname == refname) {
-		struct object_id peeled;
-
-		if (ref_iterator_peel(current_ref_iter, &peeled))
-			return -1;
-		oidcpy(oid, &peeled);
-		return 0;
-	}
+	if (current_ref_iter &&
+	    (current_ref_iter->oid == base ||
+	     oideq(current_ref_iter->oid, base)))
+		return ref_iterator_peel(current_ref_iter, peeled);
 
-	if (refs_read_ref_full(refs, refname,
-			       RESOLVE_REF_READING, &base, &flag))
-		return -1;
-
-	return peel_object(&base, oid);
-}
-
-int peel_ref(const char *refname, struct object_id *oid)
-{
-	return refs_peel_ref(get_main_ref_store(the_repository), refname, oid);
+	return peel_object(base, peeled);
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index ff05d2e9fe..71d56cb4b2 100644
--- a/refs.h
+++ b/refs.h
@@ -118,16 +118,16 @@ int is_branch(const char *refname);
 int refs_init_db(struct strbuf *err);
 
 /*
- * If refname is a non-symbolic reference that refers to a tag object,
- * and the tag can be (recursively) dereferenced to a non-tag object,
- * store the object ID of the referred-to object to oid and return 0.
- * If any of these conditions are not met, return a non-zero value.
- * Symbolic references are considered unpeelable, even if they
- * ultimately resolve to a peelable tag.
- */
-int refs_peel_ref(struct ref_store *refs, const char *refname,
-		  struct object_id *oid);
-int peel_ref(const char *refname, struct object_id *oid);
+ * Return the peeled value of the oid currently being iterated via
+ * for_each_ref(), etc. This is equivalent to calling:
+ *
+ *   peel_object(oid, &peeled);
+ *
+ * with the "oid" value given to the each_ref_fn callback, except
+ * that some ref storage may be able to answer the query without
+ * actually loading the object in memory.
+ */
+int peel_iterated_oid(const struct object_id *base, struct object_id *peeled);
 
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 759e69dc54..bba5f841c6 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -72,18 +72,6 @@ static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 	return refs_pack_refs(refs, flags);
 }
 
-static int cmd_peel_ref(struct ref_store *refs, const char **argv)
-{
-	const char *refname = notnull(*argv++, "refname");
-	struct object_id oid;
-	int ret;
-
-	ret = refs_peel_ref(refs, refname, &oid);
-	if (!ret)
-		puts(oid_to_hex(&oid));
-	return ret;
-}
-
 static int cmd_create_symref(struct ref_store *refs, const char **argv)
 {
 	const char *refname = notnull(*argv++, "refname");
@@ -255,7 +243,6 @@ struct command {
 
 static struct command commands[] = {
 	{ "pack-refs", cmd_pack_refs },
-	{ "peel-ref", cmd_peel_ref },
 	{ "create-symref", cmd_create_symref },
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 74af927fba..5f69ef8519 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -14,13 +14,6 @@ test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	N=`find .git/refs -type f | wc -l`
 '
 
-test_expect_success 'peel_ref(new-tag)' '
-	git rev-parse HEAD >expected &&
-	git tag -a -m new-tag new-tag HEAD &&
-	$RUN peel-ref refs/tags/new-tag >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success 'create_symref(FOO, refs/heads/master)' '
 	$RUN create-symref FOO refs/heads/master nothing &&
 	echo refs/heads/master >expected &&
@@ -29,6 +22,7 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 '
 
 test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
+	git tag -a -m new-tag new-tag HEAD &&
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
 	m=$(git rev-parse master) &&
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 36b7ef5046..110ac40a98 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -11,21 +11,15 @@ test_expect_success 'setup' '
 	(
 		cd sub &&
 		test_commit first &&
-		git checkout -b new-master
+		git checkout -b new-master &&
+		git tag -a -m new-tag new-tag HEAD
 	)
 '
 
 test_expect_success 'pack_refs() not allowed' '
 	test_must_fail $RUN pack-refs 3
 '
 
-test_expect_success 'peel_ref(new-tag)' '
-	git -C sub rev-parse HEAD >expected &&
-	git -C sub tag -a -m new-tag new-tag HEAD &&
-	$RUN peel-ref refs/tags/new-tag >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success 'create_symref() not allowed' '
 	test_must_fail $RUN create-symref FOO refs/heads/master nothing
 '
diff --git a/upload-pack.c b/upload-pack.c
index 3b66bf92ba..4ab55ce2b5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1232,7 +1232,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_ref(refname, &peeled))
+	if (!peel_iterated_oid(oid, &peeled))
 		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
-- 
2.30.0.661.gdf8f046147
