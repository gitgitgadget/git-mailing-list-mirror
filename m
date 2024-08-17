Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255713BC35
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883079; cv=none; b=K6mRxw4qaao2Pj/MqmQzK7gCxnlP9RmCQdaaEB9KxP7gCJqNgwsrPwd5ry2VueWfLWqaR2CHI3ATbkGNUv7q615w8NvGBKwF7+h9x2e+3gVqnG+T6GEisuH2A6nWyzSQX/oBsNdRVW4rjJF+pfXqYaOgNRJssq/6y9U8HVmd/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883079; c=relaxed/simple;
	bh=bx6HS0MPCl2YlgxveJahqeTPele9DDP1TRb+Aj6sqFg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhPVfIiZDvdqcDKbGv88fxidhajcVAqEcrliOjKoMQU+WQEttwjmvVLUzBCT3lRH08jZIvPhcfTn22HUzo3R+eLK6TeQMqtAXuLKEJB53e8iH0k4DosfWb3aWZkmGiNZBe1CM+I2ipbYl1e84oqnQS6oW45t4xrxApMpViIT6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24731 invoked by uid 109); 17 Aug 2024 08:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27963 invoked by uid 111); 17 Aug 2024 08:24:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:24:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:24:36 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 10/15] reftable: mark unused parameters in virtual functions
Message-ID: <20240817082436.GJ10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

The reftable code uses a lot of virtual function pointers, but many of
the concrete implementations do not need all of the parameters.

For the most part these are obviously fine to just mark as UNUSED (e.g.,
the empty_iterator functions unsurprisingly do not do anything). Here
are a few cases where I dug a little deeper (but still ended up just
marking them UNUSED):

  - the iterator exclude_patterns is best-effort and optional (though it
    would be nice to support in the long run as an optimization)

  - ignoring the ref_store in many transaction functions is unexpected,
    but works because the ref_transaction itself carries enough
    information to do what we need.

  - ignoring "err" for in some cases (e.g., transaction abort) is OK
    because we do not return any errors. It is a little odd for
    reftable_be_create_reflog(), though, since we do return errors
    there. We should perhaps be creating string error messages at this
    layer, but I've punted on that for now.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/reftable-backend.c          | 14 +++++++-------
 reftable/blocksource.c           |  8 ++++----
 reftable/generic.c               |  8 +++++---
 reftable/iter.c                  |  3 ++-
 reftable/record.c                | 31 ++++++++++++++++++-------------
 reftable/stack_test.c            |  4 ++--
 reftable/test_framework.c        |  2 +-
 reftable/writer.c                |  2 +-
 t/unit-tests/t-reftable-merged.c |  2 +-
 9 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7337d4422d..a2de39f2ca 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -614,7 +614,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_store,
 						       const char *prefix,
-						       const char **exclude_patterns,
+						       const char **exclude_patterns UNUSED,
 						       unsigned int flags)
 {
 	struct reftable_ref_iterator *main_iter, *worktree_iter;
@@ -1123,9 +1123,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_transaction_abort(struct ref_store *ref_store,
+static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
 					 struct ref_transaction *transaction,
-					 struct strbuf *err)
+					 struct strbuf *err UNUSED)
 {
 	struct reftable_transaction_data *tx_data = transaction->backend_data;
 	free_transaction_data(tx_data);
@@ -1315,7 +1315,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	return ret;
 }
 
-static int reftable_be_transaction_finish(struct ref_store *ref_store,
+static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 					  struct ref_transaction *transaction,
 					  struct strbuf *err)
 {
@@ -1726,8 +1726,8 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
-static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator,
-						 struct object_id *peeled)
+static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
+					 struct object_id *peeled UNUSED)
 {
 	BUG("reftable reflog iterator cannot be peeled");
 	return -1;
@@ -1988,7 +1988,7 @@ static int write_reflog_existence_table(struct reftable_writer *writer,
 
 static int reftable_be_create_reflog(struct ref_store *ref_store,
 				     const char *refname,
-				     struct strbuf *errmsg)
+				     struct strbuf *errmsg UNUSED)
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index eeed254ba9..abce4bb2e1 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,14 +13,14 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void strbuf_return_block(void *b, struct reftable_block *dest)
+static void strbuf_return_block(void *b UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-static void strbuf_close(void *b)
+static void strbuf_close(void *b UNUSED)
 {
 }
 
@@ -55,7 +55,7 @@ void block_source_from_strbuf(struct reftable_block_source *bs,
 	bs->arg = buf;
 }
 
-static void malloc_return_block(void *b, struct reftable_block *dest)
+static void malloc_return_block(void *b UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
@@ -85,7 +85,7 @@ static uint64_t file_size(void *b)
 	return ((struct file_block_source *)b)->size;
 }
 
-static void file_return_block(void *b, struct reftable_block *dest)
+static void file_return_block(void *b UNUSED, struct reftable_block *dest UNUSED)
 {
 }
 
diff --git a/reftable/generic.c b/reftable/generic.c
index 28ae26145e..a00725d9c4 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -201,17 +201,19 @@ int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
 	return it->ops->next(it->iter_arg, rec);
 }
 
-static int empty_iterator_seek(void *arg, struct reftable_record *want)
+static int empty_iterator_seek(void *arg UNUSED,
+			       struct reftable_record *want UNUSED)
 {
 	return 0;
 }
 
-static int empty_iterator_next(void *arg, struct reftable_record *rec)
+static int empty_iterator_next(void *arg UNUSED,
+			       struct reftable_record *rec UNUSED)
 {
 	return 1;
 }
 
-static void empty_iterator_close(void *arg)
+static void empty_iterator_close(void *arg UNUSED)
 {
 }
 
diff --git a/reftable/iter.c b/reftable/iter.c
index fddea31e51..9e8b2952fd 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -127,7 +127,8 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 	return 0;
 }
 
-static int indexed_table_ref_iter_seek(void *p, struct reftable_record *want)
+static int indexed_table_ref_iter_seek(void *p UNUSED,
+				       struct reftable_record *want UNUSED)
 {
 	BUG("seeking indexed table is not supported");
 	return -1;
diff --git a/reftable/record.c b/reftable/record.c
index a2cba5ef74..2ec0c6d346 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -516,7 +516,7 @@ static void reftable_obj_record_release(void *rec)
 	memset(obj, 0, sizeof(struct reftable_obj_record));
 }
 
-static void reftable_obj_record_print(const void *rec, int hash_size)
+static void reftable_obj_record_print(const void *rec, int hash_size UNUSED)
 {
 	const struct reftable_obj_record *obj = rec;
 	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
@@ -532,7 +532,7 @@ static void reftable_obj_record_print(const void *rec, int hash_size)
 }
 
 static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size)
+					  int hash_size UNUSED)
 {
 	struct reftable_obj_record *obj = rec;
 	const struct reftable_obj_record *src =
@@ -559,7 +559,7 @@ static uint8_t reftable_obj_record_val_type(const void *rec)
 }
 
 static int reftable_obj_record_encode(const void *rec, struct string_view s,
-				      int hash_size)
+				      int hash_size UNUSED)
 {
 	const struct reftable_obj_record *r = rec;
 	struct string_view start = s;
@@ -594,7 +594,8 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 
 static int reftable_obj_record_decode(void *rec, struct strbuf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size, struct strbuf *scratch UNUSED)
+				      int hash_size UNUSED,
+				      struct strbuf *scratch UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_obj_record *r = rec;
@@ -647,12 +648,13 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
 	return start.len - in.len;
 }
 
-static int not_a_deletion(const void *p)
+static int not_a_deletion(const void *p UNUSED)
 {
 	return 0;
 }
 
-static int reftable_obj_record_equal_void(const void *a, const void *b, int hash_size)
+static int reftable_obj_record_equal_void(const void *a, const void *b,
+					  int hash_size UNUSED)
 {
 	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
 	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
@@ -1066,7 +1068,7 @@ static void reftable_index_record_key(const void *r, struct strbuf *dest)
 }
 
 static void reftable_index_record_copy_from(void *rec, const void *src_rec,
-					    int hash_size)
+					    int hash_size UNUSED)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
@@ -1082,13 +1084,13 @@ static void reftable_index_record_release(void *rec)
 	strbuf_release(&idx->last_key);
 }
 
-static uint8_t reftable_index_record_val_type(const void *rec)
+static uint8_t reftable_index_record_val_type(const void *rec UNUSED)
 {
 	return 0;
 }
 
 static int reftable_index_record_encode(const void *rec, struct string_view out,
-					int hash_size)
+					int hash_size UNUSED)
 {
 	const struct reftable_index_record *r =
 		(const struct reftable_index_record *)rec;
@@ -1104,8 +1106,10 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
 }
 
 static int reftable_index_record_decode(void *rec, struct strbuf key,
-					uint8_t val_type, struct string_view in,
-					int hash_size, struct strbuf *scratch UNUSED)
+					uint8_t val_type UNUSED,
+					struct string_view in,
+					int hash_size UNUSED,
+					struct strbuf *scratch UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_index_record *r = rec;
@@ -1122,7 +1126,8 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	return start.len - in.len;
 }
 
-static int reftable_index_record_equal(const void *a, const void *b, int hash_size)
+static int reftable_index_record_equal(const void *a, const void *b,
+				       int hash_size UNUSED)
 {
 	struct reftable_index_record *ia = (struct reftable_index_record *) a;
 	struct reftable_index_record *ib = (struct reftable_index_record *) b;
@@ -1137,7 +1142,7 @@ static int reftable_index_record_cmp(const void *_a, const void *_b)
 	return strbuf_cmp(&a->last_key, &b->last_key);
 }
 
-static void reftable_index_record_print(const void *rec, int hash_size)
+static void reftable_index_record_print(const void *rec, int hash_size UNUSED)
 {
 	const struct reftable_index_record *idx = rec;
 	/* TODO: escape null chars? */
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index f84b92f312..1a638cd2e0 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -399,7 +399,7 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 	clear_dir(dir);
 }
 
-static int write_error(struct reftable_writer *wr, void *arg)
+static int write_error(struct reftable_writer *wr UNUSED, void *arg)
 {
 	return *((int *)arg);
 }
@@ -816,7 +816,7 @@ static void test_reflog_expire(void)
 	reftable_log_record_release(&log);
 }
 
-static int write_nothing(struct reftable_writer *wr, void *arg)
+static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
 {
 	reftable_writer_set_limits(wr, 1, 1);
 	return 0;
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
index 4066924eee..a07fec5d84 100644
--- a/reftable/test_framework.c
+++ b/reftable/test_framework.c
@@ -21,7 +21,7 @@ ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
 	return sz;
 }
 
-int noop_flush(void *arg)
+int noop_flush(void *arg UNUSED)
 {
 	return 0;
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 45b3e9ce1f..9d5e6072bc 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -544,7 +544,7 @@ static void write_object_record(void *void_arg, void *key)
 done:;
 }
 
-static void object_record_free(void *void_arg, void *key)
+static void object_record_free(void *void_arg UNUSED, void *key)
 {
 	struct obj_index_tree_node *entry = key;
 
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 2d65d5c3cb..99f8fcadfe 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -22,7 +22,7 @@ static ssize_t strbuf_add_void(void *b, const void *data, const size_t sz)
 	return sz;
 }
 
-static int noop_flush(void *arg)
+static int noop_flush(void *arg UNUSED)
 {
 	return 0;
 }
-- 
2.46.0.585.gd6679c16d8

