Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B96C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbiHSKIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348305AbiHSKIk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5E71726
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:38 -0700 (PDT)
Received: (qmail 17666 invoked by uid 109); 19 Aug 2022 10:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 928 invoked by uid 111); 19 Aug 2022 10:08:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/11] refs: mark unused virtual method parameters
Message-ID: <Yv9hJXCU+M/lATSv@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refs code uses various polymorphic types (e.g., loose vs packed
ref_stores, abstracted iterators). Not every virtual function or
callback needs all of its parameters. Let's mark the unused ones to
quiet -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c  | 10 +++++-----
 refs/iterator.c       |  6 +++---
 refs/packed-backend.c | 14 ++++++++------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 972701ce00..13bfdb7701 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2202,8 +2202,8 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
-				      struct object_id *peeled)
+static int files_reflog_iterator_peel(struct ref_iterator *UNUSED(ref_iterator),
+				      struct object_id *UNUSED(peeled))
 {
 	BUG("ref_iterator_peel() called for reflog_iterator");
 }
@@ -2257,7 +2257,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 static enum iterator_selection reflog_iterator_select(
 	struct ref_iterator *iter_worktree,
 	struct ref_iterator *iter_common,
-	void *cb_data)
+	void *UNUSED(cb_data))
 {
 	if (iter_worktree) {
 		/*
@@ -2985,7 +2985,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 static int files_transaction_abort(struct ref_store *ref_store,
 				   struct ref_transaction *transaction,
-				   struct strbuf *err)
+				   struct strbuf *UNUSED(err))
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 0, "ref_transaction_abort");
@@ -3261,7 +3261,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	return -1;
 }
 
-static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
+static int files_init_db(struct ref_store *ref_store, struct strbuf *UNUSED(err))
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
diff --git a/refs/iterator.c b/refs/iterator.c
index b2e56bae1c..e34921db72 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -51,8 +51,8 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator_abort(ref_iterator);
 }
 
-static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static int empty_ref_iterator_peel(struct ref_iterator *UNUSED(ref_iterator),
+				   struct object_id *UNUSED(peeled))
 {
 	BUG("peel called for empty iterator");
 }
@@ -238,7 +238,7 @@ struct ref_iterator *merge_ref_iterator_begin(
  */
 static enum iterator_selection overlay_iterator_select(
 		struct ref_iterator *front, struct ref_iterator *back,
-		void *cb_data)
+		void *UNUSED(cb_data))
 {
 	int cmp;
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97b6837767..a45bb686f0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -726,7 +726,7 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 }
 
 static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
-			       struct object_id *oid, struct strbuf *referent,
+			       struct object_id *oid, struct strbuf *UNUSED(referent),
 			       unsigned int *type, int *failure_errno)
 {
 	struct packed_ref_store *refs =
@@ -1078,7 +1078,8 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 static const char PACKED_REFS_HEADER[] =
 	"# pack-refs with: peeled fully-peeled sorted \n";
 
-static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
+static int packed_init_db(struct ref_store *UNUSED(ref_store),
+			  struct strbuf *UNUSED(err))
 {
 	/* Nothing to do. */
 	return 0;
@@ -1473,7 +1474,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 
 static int packed_transaction_abort(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
-				    struct strbuf *err)
+				    struct strbuf *UNUSED(err))
 {
 	struct packed_ref_store *refs = packed_downcast(
 			ref_store,
@@ -1512,7 +1513,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	return ret;
 }
 
-static int packed_initial_transaction_commit(struct ref_store *ref_store,
+static int packed_initial_transaction_commit(struct ref_store *UNUSED(ref_store),
 					    struct ref_transaction *transaction,
 					    struct strbuf *err)
 {
@@ -1568,7 +1569,8 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 	return ret;
 }
 
-static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int packed_pack_refs(struct ref_store *UNUSED(ref_store),
+			    unsigned int UNUSED(flags))
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
@@ -1578,7 +1580,7 @@ static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	return 0;
 }
 
-static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
+static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *UNUSED(ref_store))
 {
 	return empty_ref_iterator_begin();
 }
-- 
2.37.2.928.g0821088f4a

