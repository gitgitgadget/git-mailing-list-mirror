Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626D3C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE6861269
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhIXSlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhIXSlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:41:19 -0400
Received: (qmail 19110 invoked by uid 109); 24 Sep 2021 18:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11109 invoked by uid 111); 24 Sep 2021 18:39:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:39:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:39:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 09/16] refs-internal.h: reorganize DO_FOR_EACH_* flag
 documentation
Message-ID: <YU4bcPAsVa61t8Ze@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the DO_FOR_EACH_* flags is sprinkled over the
refs-internal.h file. We define the two flags in one spot, and then
describe them in more detail far away from there, in the definitions of
refs_ref_iterator_begin() and ref_iterator_advance_fn().

Let's try to organize this a bit better:

  - convert the #defines to an enum. This makes it clear that they are
    related, and that the enum shows the complete set of flags.

  - combine all descriptions for each flag in a single spot, next to the
    flag's definition

  - use the enum rather than a bare int for functions which take the
    flags. This helps readers realize which flags can be used.

  - clarify the mention of flags for ref_iterator_advance_fn(). It does
    not take flags itself, but is meant to depend on ones set up
    earlier.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c               | 10 ++++++----
 refs/refs-internal.h | 46 ++++++++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9f7c3a80..c28bd6a818 100644
--- a/refs.c
+++ b/refs.c
@@ -1413,7 +1413,8 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim, int flags)
+		const char *prefix, int trim,
+		enum do_for_each_ref_flags flags)
 {
 	struct ref_iterator *iter;
 
@@ -1479,7 +1480,8 @@ static int do_for_each_ref_helper(struct repository *r,
 }
 
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
-			   each_ref_fn fn, int trim, int flags, void *cb_data)
+			   each_ref_fn fn, int trim,
+			   enum do_for_each_ref_flags flags, void *cb_data)
 {
 	struct ref_iterator *iter;
 	struct do_for_each_ref_help hp = { fn, cb_data };
@@ -1516,7 +1518,7 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
 {
-	unsigned int flag = 0;
+	enum do_for_each_ref_flags flag = 0;
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
@@ -1528,7 +1530,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     each_ref_fn fn, void *cb_data,
 			     unsigned int broken)
 {
-	unsigned int flag = 0;
+	enum do_for_each_ref_flags flag = 0;
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7b30910974..2c4e1739f2 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -245,16 +245,30 @@ int refs_rename_ref_available(struct ref_store *refs,
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define SYMREF_MAXDEPTH 5
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
- * Only include per-worktree refs in a do_for_each_ref*() iteration.
- * Normally this will be used with a files ref_store, since that's
- * where all reference backends will presumably store their
- * per-worktree refs.
+ * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
+ * which feeds it).
  */
-#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+enum do_for_each_ref_flags {
+	/*
+	 * Include broken references in a do_for_each_ref*() iteration, which
+	 * would normally be omitted. This includes both refs that point to
+	 * missing objects (a true repository corruption), ones with illegal
+	 * names (which we prefer not to expose to callers), as well as
+	 * dangling symbolic refs (i.e., those that point to a non-existent
+	 * ref; this is not a corruption, but as they have no valid oid, we
+	 * omit them from normal iteration results).
+	 */
+	DO_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
+
+	/*
+	 * Only include per-worktree refs in a do_for_each_ref*() iteration.
+	 * Normally this will be used with a files ref_store, since that's
+	 * where all reference backends will presumably store their
+	 * per-worktree refs.
+	 */
+	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
+};
 
 /*
  * Reference iterators
@@ -357,16 +371,12 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
  * Return an iterator that goes over each reference in `refs` for
  * which the refname begins with prefix. If trim is non-zero, then
  * trim that many characters off the beginning of each refname.
- * The output is ordered by refname. The following flags are supported:
- *
- * DO_FOR_EACH_INCLUDE_BROKEN: include broken references in
- *         the iteration.
- *
- * DO_FOR_EACH_PER_WORKTREE_ONLY: only produce REF_TYPE_PER_WORKTREE refs.
+ * The output is ordered by refname.
  */
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim, int flags);
+		const char *prefix, int trim,
+		enum do_for_each_ref_flags flags);
 
 /*
  * A callback function used to instruct merge_ref_iterator how to
@@ -454,10 +464,8 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 /*
  * backend-specific implementation of ref_iterator_advance. For symrefs, the
  * function should set REF_ISSYMREF, and it should also dereference the symref
- * to provide the OID referent. If DO_FOR_EACH_INCLUDE_BROKEN is set, symrefs
- * with non-existent referents and refs pointing to non-existent object names
- * should also be returned. If DO_FOR_EACH_PER_WORKTREE_ONLY, only
- * REF_TYPE_PER_WORKTREE refs should be returned.
+ * to provide the OID referent. It should respect do_for_each_ref_flags
+ * that were passed to refs_ref_iterator_begin().
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
-- 
2.33.0.1071.gb37e412355

