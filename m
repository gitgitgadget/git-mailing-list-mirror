Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E36C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhLHCSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:18:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:46330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhLHCSy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 21:18:54 -0500
Received: (qmail 8916 invoked by uid 109); 8 Dec 2021 02:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 02:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27036 invoked by uid 111); 8 Dec 2021 02:15:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Dec 2021 21:15:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Dec 2021 21:15:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
Message-ID: <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlf0w5bbc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 07, 2021 at 01:56:07PM -0800, Junio C Hamano wrote:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +struct reftable_record {
> > +	uint8_t type;
> > +	union {
> > +		struct reftable_ref_record ref;
> > +		struct reftable_log_record log;
> > +		struct reftable_obj_record obj;
> > +		struct reftable_index_record idx;
> > +	};
> > +};
> 
> error: ISO C99 doesn't support unnamed structs/unions [-Werror=pedantic]

Hmm. It's interesting that the regular DEVELOPER=1 doesn't catch this.
It's because we don't specify -std there, and newer gcc defaults to
gnu17 (unnamed unions appeared in c11, I think). I wonder if it would be
helpful to teach config.mak.dev to pass -std=c99.

Anyway, the usual fix is to stick a "u.foo" everywhere. Patch is below
for convenience. Two things to note:

  - I used ".u.foo = {...}" as a designated initializer. I think this is
    allowed by the standard, but I don't think it's something we've used
    before. If it's a problem, it can be solved by using an extra level
    of braces (which is OK, just uglier).

  - Han-Wen, if you don't just squash in the patch below, note that it
    also has a fixup for some misleading indentation in an initializer
    in test_reftable_log_record_roundtrip(). You might want to grab that
    separately.

---
 reftable/block_test.c  | 16 ++++----
 reftable/generic.c     |  8 ++--
 reftable/iter.c        |  4 +-
 reftable/merged.c      |  4 +-
 reftable/pq_test.c     |  8 ++--
 reftable/reader.c      | 26 ++++++------
 reftable/record.c      | 10 ++---
 reftable/record.h      |  2 +-
 reftable/record_test.c | 74 +++++++++++++++++------------------
 reftable/writer.c      | 12 +++---
 10 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/reftable/block_test.c b/reftable/block_test.c
index 670329f222..fa2ee092ec 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -48,14 +48,14 @@ static void test_block_read_write(void)
 		snprintf(name, sizeof(name), "branch%02d", i);
 		memset(hash, i, sizeof(hash));
 
-		rec.ref.refname = name;
-		rec.ref.value_type = REFTABLE_REF_VAL1;
-		rec.ref.value.val1 = hash;
+		rec.u.ref.refname = name;
+		rec.u.ref.value_type = REFTABLE_REF_VAL1;
+		rec.u.ref.value.val1 = hash;
 
 		names[i] = xstrdup(name);
 		n = block_writer_add(&bw, &rec);
-		rec.ref.refname = NULL;
-		rec.ref.value_type = REFTABLE_REF_DELETION;
+		rec.u.ref.refname = NULL;
+		rec.u.ref.value_type = REFTABLE_REF_DELETION;
 		EXPECT(n == 0);
 	}
 
@@ -74,7 +74,7 @@ static void test_block_read_write(void)
 		if (r > 0) {
 			break;
 		}
-		EXPECT_STREQ(names[j], rec.ref.refname);
+		EXPECT_STREQ(names[j], rec.u.ref.refname);
 		j++;
 	}
 
@@ -92,15 +92,15 @@ static void test_block_read_write(void)
 		n = block_iter_next(&it, &rec);
 		EXPECT(n == 0);
 
-		EXPECT_STREQ(names[i], rec.ref.refname);
+		EXPECT_STREQ(names[i], rec.u.ref.refname);
 
 		want.len--;
 		n = block_reader_seek(&br, &it, &want);
 		EXPECT(n == 0);
 
 		n = block_iter_next(&it, &rec);
 		EXPECT(n == 0);
-		EXPECT_STREQ(names[10 * (i / 10)], rec.ref.refname);
+		EXPECT_STREQ(names[10 * (i / 10)], rec.u.ref.refname);
 
 		block_iter_close(&it);
 	}
diff --git a/reftable/generic.c b/reftable/generic.c
index 7f00aa9cdb..4446b8ed36 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -17,7 +17,7 @@ int reftable_table_seek_ref(struct reftable_table *tab,
 			    struct reftable_iterator *it, const char *name)
 {
 	struct reftable_record rec = { .type = BLOCK_TYPE_REF,
-				       .ref = {
+				       .u.ref = {
 					       .refname = (char *)name,
 				       } };
 	return tab->ops->seek_record(tab->table_arg, it, &rec);
@@ -27,7 +27,7 @@ int reftable_table_seek_log(struct reftable_table *tab,
 			    struct reftable_iterator *it, const char *name)
 {
 	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
-				       .log = {
+				       .u.log = {
 					       .refname = (char *)name,
 					       .update_index = ~((uint64_t)0),
 				       } };
@@ -130,7 +130,7 @@ int reftable_iterator_next_ref(struct reftable_iterator *it,
 {
 	struct reftable_record rec = { .type = BLOCK_TYPE_REF };
 	int err = iterator_next(it, &rec);
-	*ref = rec.ref;
+	*ref = rec.u.ref;
 	return err;
 }
 
@@ -139,7 +139,7 @@ int reftable_iterator_next_log(struct reftable_iterator *it,
 {
 	struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 	int err = iterator_next(it, &rec);
-	*log = rec.log;
+	*log = rec.u.log;
 	return err;
 }
 
diff --git a/reftable/iter.c b/reftable/iter.c
index fedf5d8ab0..a8d174c040 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -32,7 +32,7 @@ static int filtering_ref_iterator_next(void *iter_arg,
 				       struct reftable_record *rec)
 {
 	struct filtering_ref_iterator *fri = iter_arg;
-	struct reftable_ref_record *ref = &rec->ref;
+	struct reftable_ref_record *ref = &rec->u.ref;
 	int err = 0;
 	while (1) {
 		err = reftable_iterator_next_ref(&fri->it, ref);
@@ -127,7 +127,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 {
 	struct indexed_table_ref_iter *it = p;
-	struct reftable_ref_record *ref = &rec->ref;
+	struct reftable_ref_record *ref = &rec->u.ref;
 
 	while (1) {
 		int err = block_iter_next(&it->cur, rec);
diff --git a/reftable/merged.c b/reftable/merged.c
index e69955d7c2..e9b0edec97 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -291,7 +291,7 @@ int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.ref = {
+		.u.ref = {
 			.refname = (char *)name,
 		},
 	};
@@ -304,7 +304,7 @@ int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.log = {
+		.u.log = {
 			.refname = (char *)name,
 			.update_index = update_index,
 		}
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index 89d069d674..9f04d84fed 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -45,7 +45,7 @@ static void test_pq(void)
 		struct pq_entry e = {
 			.rec = {
 				.type = BLOCK_TYPE_REF,
-				.ref = {
+				.u.ref = {
 					.refname = names[i],
 				}
 			}
@@ -62,11 +62,11 @@ static void test_pq(void)
 
 		EXPECT(rec->type == BLOCK_TYPE_REF);
 		if (last) {
-			EXPECT(strcmp(last, rec->ref.refname) < 0);
+			EXPECT(strcmp(last, rec->u.ref.refname) < 0);
 		}
 		// this is names[i], so don't dealloc.
-		last = rec->ref.refname;
-		rec->ref.refname = NULL;
+		last = rec->u.ref.refname;
+		rec->u.ref.refname = NULL;
 		reftable_record_release(rec);
 	}
 	for (i = 0; i < N; i++) {
diff --git a/reftable/reader.c b/reftable/reader.c
index 0159f13112..ef322791fd 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -239,7 +239,7 @@ static int table_iter_next_in_block(struct table_iter *ti,
 {
 	int res = block_iter_next(&ti->bi, rec);
 	if (res == 0 && rec->type == BLOCK_TYPE_REF) {
-		rec->ref.update_index += ti->r->min_update_index;
+		rec->u.ref.update_index += ti->r->min_update_index;
 	}
 
 	return res;
@@ -485,17 +485,17 @@ static int reader_seek_indexed(struct reftable_reader *r,
 {
 	struct reftable_record want_index = {
 		.type = BLOCK_TYPE_INDEX,
-		.idx = { .last_key = STRBUF_INIT }
+		.u.idx = { .last_key = STRBUF_INIT }
 	};
 	struct reftable_record index_result = {
 		.type = BLOCK_TYPE_INDEX,
-		.idx = { .last_key = STRBUF_INIT },
+		.u.idx = { .last_key = STRBUF_INIT },
 	};
 	struct table_iter index_iter = TABLE_ITER_INIT;
 	struct table_iter next = TABLE_ITER_INIT;
 	int err = 0;
 
-	reftable_record_key(rec, &want_index.idx.last_key);
+	reftable_record_key(rec, &want_index.u.idx.last_key);
 	err = reader_start(r, &index_iter, rec->type, 1);
 	if (err < 0)
 		goto done;
@@ -507,12 +507,12 @@ static int reader_seek_indexed(struct reftable_reader *r,
 		if (err != 0)
 			goto done;
 
-		err = reader_table_iter_at(r, &next, index_result.idx.offset,
+		err = reader_table_iter_at(r, &next, index_result.u.idx.offset,
 					   0);
 		if (err != 0)
 			goto done;
 
-		err = block_iter_seek(&next.bi, &want_index.idx.last_key);
+		err = block_iter_seek(&next.bi, &want_index.u.idx.last_key);
 		if (err < 0)
 			goto done;
 
@@ -591,7 +591,7 @@ int reftable_reader_seek_ref(struct reftable_reader *r,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.ref = {
+		.u.ref = {
 			.refname = (char *)name,
 		},
 	};
@@ -604,7 +604,7 @@ int reftable_reader_seek_log_at(struct reftable_reader *r,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.log = {
+		.u.log = {
 			.refname = (char *)name,
 			.update_index = update_index,
 		}
@@ -652,15 +652,15 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 {
 	struct reftable_record want = {
 		.type = BLOCK_TYPE_OBJ,
-		.obj = {
+		.u.obj = {
 			.hash_prefix = oid,
 			.hash_prefix_len = r->object_id_len,
 		},
 	};
 	struct reftable_iterator oit = { NULL };
 	struct reftable_record got = {
 		.type = BLOCK_TYPE_OBJ,
-		.obj = { 0 },
+		.u.obj = { 0 },
 	};
 	int err = 0;
 	struct indexed_table_ref_iter *itr = NULL;
@@ -675,7 +675,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	if (err < 0)
 		goto done;
 
-	if (err > 0 || memcmp(want.obj.hash_prefix, got.obj.hash_prefix,
+	if (err > 0 || memcmp(want.u.obj.hash_prefix, got.u.obj.hash_prefix,
 			      r->object_id_len)) {
 		/* didn't find it; return empty iterator */
 		iterator_set_empty(it);
@@ -684,10 +684,10 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	}
 
 	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
-					 got.obj.offsets, got.obj.offset_len);
+					 got.u.obj.offsets, got.u.obj.offset_len);
 	if (err < 0)
 		goto done;
-	got.obj.offsets = NULL;
+	got.u.obj.offsets = NULL;
 	iterator_from_indexed_table_ref_iter(it, itr);
 
 done:
diff --git a/reftable/record.c b/reftable/record.c
index b665feb709..68fdde9d7c 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1123,13 +1123,13 @@ static void *reftable_record_data(struct reftable_record *rec)
 {
 	switch (rec->type) {
 	case BLOCK_TYPE_REF:
-		return &rec->ref;
+		return &rec->u.ref;
 	case BLOCK_TYPE_LOG:
-		return &rec->log;
+		return &rec->u.log;
 	case BLOCK_TYPE_INDEX:
-		return &rec->idx;
+		return &rec->u.idx;
 	case BLOCK_TYPE_OBJ:
-		return &rec->obj;
+		return &rec->u.obj;
 	}
 	abort();
 }
@@ -1154,7 +1154,7 @@ struct reftable_record reftable_record_for(uint8_t typ)
 {
 	struct reftable_record clean_idx = {
 		.type = BLOCK_TYPE_INDEX,
-		.idx = {
+		.u.idx = {
 			.last_key = STRBUF_INIT,
 		},
 	};
diff --git a/reftable/record.h b/reftable/record.h
index a702c67e85..1fe0c14a19 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -101,7 +101,7 @@ struct reftable_record {
 		struct reftable_log_record log;
 		struct reftable_obj_record obj;
 		struct reftable_index_record idx;
-	};
+	} u;
 };
 
 /* see struct record_vtable */
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 23abfb037b..f234a0382a 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -23,11 +23,11 @@ static void test_copy(struct reftable_record *rec)
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	switch (copy.type) {
 	case BLOCK_TYPE_REF:
-		EXPECT(reftable_ref_record_equal(&copy.ref, &rec->ref,
+		EXPECT(reftable_ref_record_equal(&copy.u.ref, &rec->u.ref,
 						 GIT_SHA1_RAWSZ));
 		break;
 	case BLOCK_TYPE_LOG:
-		EXPECT(reftable_log_record_equal(&copy.log, &rec->log,
+		EXPECT(reftable_log_record_equal(&copy.u.log, &rec->u.log,
 						 GIT_SHA1_RAWSZ));
 		break;
 	}
@@ -118,27 +118,27 @@ static void test_reftable_ref_record_roundtrip(void)
 		};
 		int n, m;
 
-		in.ref.value_type = i;
+		in.u.ref.value_type = i;
 		switch (i) {
 		case REFTABLE_REF_DELETION:
 			break;
 		case REFTABLE_REF_VAL1:
-			in.ref.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
-			set_hash(in.ref.value.val1, 1);
+			in.u.ref.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
+			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
-			in.ref.value.val2.value =
+			in.u.ref.value.val2.value =
 				reftable_malloc(GIT_SHA1_RAWSZ);
-			set_hash(in.ref.value.val2.value, 1);
-			in.ref.value.val2.target_value =
+			set_hash(in.u.ref.value.val2.value, 1);
+			in.u.ref.value.val2.target_value =
 				reftable_malloc(GIT_SHA1_RAWSZ);
-			set_hash(in.ref.value.val2.target_value, 2);
+			set_hash(in.u.ref.value.val2.target_value, 2);
 			break;
 		case REFTABLE_REF_SYMREF:
-			in.ref.value.symref = xstrdup("target");
+			in.u.ref.value.symref = xstrdup("target");
 			break;
 		}
-		in.ref.refname = xstrdup("refs/heads/master");
+		in.u.ref.refname = xstrdup("refs/heads/master");
 
 		test_copy(&in);
 
@@ -152,7 +152,7 @@ static void test_reftable_ref_record_roundtrip(void)
 		m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(reftable_ref_record_equal(&in.ref, &out.ref,
+		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
 						 GIT_SHA1_RAWSZ));
 		reftable_record_release(&in);
 
@@ -222,23 +222,23 @@ static void test_reftable_log_record_roundtrip(void)
 		/* populate out, to check for leaks. */
 		struct reftable_record out = {
 			.type = BLOCK_TYPE_LOG,
-			.log = {
+			.u.log = {
 				.refname = xstrdup("old name"),
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value = {
-				.update = {
-					.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
-					.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
-					.name = xstrdup("old name"),
-					.email = xstrdup("old@email"),
-					.message = xstrdup("old message"),
+				.value_type = REFTABLE_LOG_UPDATE,
+				.value = {
+					.update = {
+						.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
+						.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
+						.name = xstrdup("old name"),
+						.email = xstrdup("old@email"),
+						.message = xstrdup("old message"),
+					},
 				},
 			},
-			},
 		};
 		int n, m, valtype;
 
-		rec.log = in[i];
+		rec.u.log = in[i];
 
 		test_copy(&rec);
 
@@ -251,7 +251,7 @@ static void test_reftable_log_record_roundtrip(void)
 					   GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(reftable_log_record_equal(&in[i], &out.log,
+		EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
 						 GIT_SHA1_RAWSZ));
 		reftable_log_record_release(&in[i]);
 		strbuf_release(&key);
@@ -330,7 +330,7 @@ static void test_reftable_obj_record_roundtrip(void)
 		};
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_OBJ,
-			.obj = recs[i],
+			.u.obj = recs[i],
 		};
 		struct strbuf key = STRBUF_INIT;
 		struct reftable_record out = {
@@ -348,13 +348,13 @@ static void test_reftable_obj_record_roundtrip(void)
 					   GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(in.obj.hash_prefix_len == out.obj.hash_prefix_len);
-		EXPECT(in.obj.offset_len == out.obj.offset_len);
+		EXPECT(in.u.obj.hash_prefix_len == out.u.obj.hash_prefix_len);
+		EXPECT(in.u.obj.offset_len == out.u.obj.offset_len);
 
-		EXPECT(!memcmp(in.obj.hash_prefix, out.obj.hash_prefix,
-			       in.obj.hash_prefix_len));
-		EXPECT(0 == memcmp(in.obj.offsets, out.obj.offsets,
-				   sizeof(uint64_t) * in.obj.offset_len));
+		EXPECT(!memcmp(in.u.obj.hash_prefix, out.u.obj.hash_prefix,
+			       in.u.obj.hash_prefix_len));
+		EXPECT(0 == memcmp(in.u.obj.offsets, out.u.obj.offsets,
+				   sizeof(uint64_t) * in.u.obj.offset_len));
 		strbuf_release(&key);
 		reftable_record_release(&out);
 	}
@@ -364,7 +364,7 @@ static void test_reftable_index_record_roundtrip(void)
 {
 	struct reftable_record in = {
 		.type = BLOCK_TYPE_INDEX,
-		.idx = {
+		.u.idx = {
 			.offset = 42,
 			.last_key = STRBUF_INIT,
 		},
@@ -377,28 +377,28 @@ static void test_reftable_index_record_roundtrip(void)
 	struct strbuf key = STRBUF_INIT;
 	struct reftable_record out = {
 		.type = BLOCK_TYPE_INDEX,
-		.idx = { .last_key = STRBUF_INIT },
+		.u.idx = { .last_key = STRBUF_INIT },
 	};
 	int n, m;
 	uint8_t extra;
 
-	strbuf_addstr(&in.idx.last_key, "refs/heads/master");
+	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
 	reftable_record_key(&in, &key);
 	test_copy(&in);
 
-	EXPECT(0 == strbuf_cmp(&key, &in.idx.last_key));
+	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	EXPECT(n > 0);
 
 	extra = reftable_record_val_type(&in);
 	m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ);
 	EXPECT(m == n);
 
-	EXPECT(in.idx.offset == out.idx.offset);
+	EXPECT(in.u.idx.offset == out.u.idx.offset);
 
 	reftable_record_release(&out);
 	strbuf_release(&key);
-	strbuf_release(&in.idx.last_key);
+	strbuf_release(&in.u.idx.last_key);
 }
 
 int record_test_main(int argc, const char *argv[])
diff --git a/reftable/writer.c b/reftable/writer.c
index df256f3a8b..f9544c5f97 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -253,7 +253,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.ref = *ref,
+		.u.ref = *ref,
 	};
 	int err = 0;
 
@@ -263,7 +263,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	    ref->update_index > w->max_update_index)
 		return REFTABLE_API_ERROR;
 
-	rec.ref.update_index -= w->min_update_index;
+	rec.u.ref.update_index -= w->min_update_index;
 
 	err = writer_add_record(w, &rec);
 	if (err < 0)
@@ -304,7 +304,7 @@ static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.log = *log,
+		.u.log = *log,
 	};
 	if (w->block_writer &&
 	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
@@ -397,7 +397,7 @@ static int writer_finish_section(struct reftable_writer *w)
 		for (i = 0; i < idx_len; i++) {
 			struct reftable_record rec = {
 				.type = BLOCK_TYPE_INDEX,
-				.idx = idx[i],
+				.u.idx = idx[i],
 			};
 			if (block_writer_add(w->block_writer, &rec) == 0) {
 				continue;
@@ -468,7 +468,7 @@ static void write_object_record(void *void_arg, void *key)
 	struct obj_index_tree_node *entry = key;
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_OBJ,
-		.obj = {
+		.u.obj = {
 			.hash_prefix = (uint8_t *)entry->hash.buf,
 			.hash_prefix_len = arg->w->stats.object_id_len,
 			.offsets = entry->offsets,
@@ -491,7 +491,7 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err == 0)
 		goto done;
 
-	rec.obj.offset_len = 0;
+	rec.u.obj.offset_len = 0;
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 
 	/* Should be able to write into a fresh block. */
