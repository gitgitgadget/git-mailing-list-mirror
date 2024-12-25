Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E020DF4
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735151923; cv=none; b=m5TbfM4cKjpyZuNDxBae9fpaDR0tYpg6/ihTHCrSsem6XZ3eeQHRb3z+JMgMYm6XkCBMueSkj1y7KeNI1QCcj90k7kfoFqIXFKkViUqy3Ln24UZ+qt/+oi72BpPMVNymoO9ytwIdwgvfbCTPXcImhz9Zppoz2VznY4YA1GO2kb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735151923; c=relaxed/simple;
	bh=POxh7E39/LDi1Tp+15CooUllriNWR/Mbl/mkcGGu+14=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mhTKntdzdcxTpgGvP8zzbEeu1GKk2yPP99kM8ehtmCnFhhzCvAYUa0WdCqQ0MyxUH+MPGIzImyHDrpMHZN/hZpJdfCSeguKqa9lAmqs9Zj2N9gGBcS7jHfhZ7EuNILb86bdv09BHPT2qjskrOX3EJ0IE4mtpwG5lfCyIYJatuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SaKPdCFN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SaKPdCFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735151910; x=1735756710; i=l.s.r@web.de;
	bh=ryuBBxTbqkiOMgkYoj+AfwZwHHZ0ZoGzfZyy0KsurDY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SaKPdCFNQcEpS1yIB87yE7kNXRcoENJfTewm3o8n2pL985HcAwDxGzZE6kD2w02t
	 v/ZUz3COxVAyZYziLTfIXWlCXe1FDQA7AO2XhYDzE/83xcowDthXJDORD4VOuwzfL
	 2CEFG6FxNCfuPGUtQjw1th+nOFf9FNG/kw3gt+whbnMB+zMVOXisaR1ItlWkdQ7t7
	 4JBGahZD9UWj/ufjyMWl5G7LPA1DUaNrzG1CcwV80snEAdmyh5u2x3QUOT7W19ukz
	 NWyU+gN3GJZg4vewVSL6fpnDP0emEL1xDN8l28gC92gZrQQZ4syuf4gGaI8XGE8cM
	 YLzjJye2bnlBUPKO1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1tetvm1nfY-00xDtm; Wed, 25
 Dec 2024 19:38:30 +0100
Message-ID: <9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de>
Date: Wed, 25 Dec 2024 19:38:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] reftable: avoid leaks on realloc error
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Language: en-US
In-Reply-To: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BC8gZ3xBUQAb3cdWLBF/IWhfTEy8wPIs+5Hn6YedHjtG6Txrz6S
 JyfY4Jd0eexOxWuPmkCa9/6maPXhybhJVUnwXcYbV4zh40Bzqlpgn0i/LE3sQVmT5HJ1GoX
 oq35Ow9KKEErxqrUwlhEI9RPLu/9w4rGGXAtn2BJgYrN/XgYEJ3J0WW1iwwxR5QgmTd3/FP
 kkTyYZ/Ty1e2gbZPD0EdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SD43NyU05CY=;yCtXbLYgVGSdIDjAXeRsMpwiyw9
 xmfac0yjJCf0Vvss9ClW4xM/g4edf6boXP3JJ3XlirOgP5hSzR37E+E3hYxJoPWbmPqDAwPeX
 ywHRZUtiPRAil0Gmq3W6KJ6zsrisUiXR0wA3SerxtMfGibDcU2cEkHAon75SXl8qwziRAFW7u
 4rjazh9hfIKYn5VX/bNO+C4RTffoWKuxZK/8HUKfNZoR+cNd0ZrBCP1enid6WQza6502IHs3x
 E2g6SZpcyXR9wMbfea7t/LNBrZApDOMkXyrcs2guW/o0P+D9q/fhRNDoAKu4wdBvQQ8QDBU9y
 TQtBN89NvywrGfTXx74aqKLp3bNMLcPYbLK7nt08LKKcbwyhhx1KxBryNf0HTgMqb3w0Bed48
 gJ0A3EUDAs1qMx3ybg3vi3aGq0oEi5ViAMb4+pxuGdP34NTK7z+Ib809l4zIRvYI9H3Or2d2M
 okzfYKbcPw7T7BthSZ/njbdfueNn7awG7zNe8lw6/UzzyzYNDAiLcmFUX3QrnkF30OtCF0QHg
 4DF93YPjCQNjZrru07ve/v0UWxyXAVvbMw/0HylBFVwAlxn9R+1bCJieRv3lgCReuAFS8mUIZ
 9If7dDCHg1Zb7a+/r9O3gIQxqBZPurNtL377EL6yLbw/4TK3RzjMIsR57d9lawS82BZ8GLUSK
 03mSzEUKU9KEjUVz5oTiKFrExa8AyvHoaE6/fbok+15mjOHXYPd1mfw3OYqp9a3gQ9gufYyjR
 ElulnORxQ6B+ZlC5kpRAEFiMSzIjiHpi3h0becM1424jUXJIs77FNPDSx8yGGd82T1n6yqVHt
 y8rCX0Rbs6vK9fQSRveSibtMhVVGOVsmHvkZ7+waceFUu4/5ADY4fZqLVWPUrLQJqKxbtuqDm
 nw6IQkSTtEwyXwTfjuSJZ3uP6jcunedOd1gErBNdxsuVw+8joo9VUdLJvRAS7WWxV+qnC4PZE
 6xApXOTySYQ8wPyJ4cxc4LGHJmmh+iqGEbet6QirU0nVs6C12RyfieoOsT71HFDgk5z2gyasI
 y21ZmXYWJm9CugBGMpBTgrLS9fsZ9jpeD6OkDBzYBdeKTKGTa/2qVjDhPkfSE8KkmUui8nzSi
 J6XBz79PY=

When realloc(3) fails, it returns NULL and keeps the original allocation
intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
the allocation count variable in that case, simultaneously leaking the
original allocation and misrepresenting the number of storable items.

parse_names() and reftable_buf_add() avoid leaking by restoring the
original pointer value on failure, but all other callers seem to be OK
with losing the old allocation.  Add a new variant of the macro,
REFTABLE_ALLOC_GROW_OR_NULL, which plugs the leak and zeros the
allocation counter.  Use it for those callers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 reftable/basics.h | 10 ++++++++++
 reftable/block.c  | 10 ++++++----
 reftable/pq.c     |  2 +-
 reftable/record.c | 12 ++++++------
 reftable/stack.c  |  8 +++++---
 reftable/writer.c |  5 +++--
 6 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 36beda2c25..259f4c274c 100644
=2D-- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -129,6 +129,16 @@ char *reftable_strdup(const char *str);
 			REFTABLE_REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
+
+#define REFTABLE_ALLOC_GROW_OR_NULL(x, nr, alloc) do { \
+	void *reftable_alloc_grow_or_null_orig_ptr =3D (x); \
+	REFTABLE_ALLOC_GROW((x), (nr), (alloc)); \
+	if (!(x)) { \
+		reftable_free(reftable_alloc_grow_or_null_orig_ptr); \
+		alloc =3D 0; \
+	} \
+} while (0)
+
 #define REFTABLE_FREE_AND_NULL(p) do { reftable_free(p); (p) =3D NULL; } =
while (0)

 #ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
diff --git a/reftable/block.c b/reftable/block.c
index 0198078485..9858bbc7c5 100644
=2D-- a/reftable/block.c
+++ b/reftable/block.c
@@ -53,7 +53,8 @@ static int block_writer_register_restart(struct block_wr=
iter *w, int n,
 	if (2 + 3 * rlen + n > w->block_size - w->next)
 		return -1;
 	if (is_restart) {
-		REFTABLE_ALLOC_GROW(w->restarts, w->restart_len + 1, w->restart_cap);
+		REFTABLE_ALLOC_GROW_OR_NULL(w->restarts, w->restart_len + 1,
+					    w->restart_cap);
 		if (!w->restarts)
 			return REFTABLE_OUT_OF_MEMORY_ERROR;
 		w->restarts[w->restart_len++] =3D w->next;
@@ -176,7 +177,8 @@ int block_writer_finish(struct block_writer *w)
 		 * is guaranteed to return `Z_STREAM_END`.
 		 */
 		compressed_len =3D deflateBound(w->zstream, src_len);
-		REFTABLE_ALLOC_GROW(w->compressed, compressed_len, w->compressed_cap);
+		REFTABLE_ALLOC_GROW_OR_NULL(w->compressed, compressed_len,
+					    w->compressed_cap);
 		if (!w->compressed) {
 			ret =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 			return ret;
@@ -235,8 +237,8 @@ int block_reader_init(struct block_reader *br, struct =
reftable_block *block,
 		uLong src_len =3D block->len - block_header_skip;

 		/* Log blocks specify the *uncompressed* size in their header. */
-		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
-				    br->uncompressed_cap);
+		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, sz,
+					    br->uncompressed_cap);
 		if (!br->uncompressed_data) {
 			err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto done;
diff --git a/reftable/pq.c b/reftable/pq.c
index 6ee1164dd3..5591e875e1 100644
=2D-- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -49,7 +49,7 @@ int merged_iter_pqueue_add(struct merged_iter_pqueue *pq=
, const struct pq_entry
 {
 	size_t i =3D 0;

-	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(pq->heap, pq->len + 1, pq->cap);
 	if (!pq->heap)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	pq->heap[pq->len++] =3D *e;
diff --git a/reftable/record.c b/reftable/record.c
index fb5652ed57..04429d23fe 100644
=2D-- a/reftable/record.c
+++ b/reftable/record.c
@@ -246,8 +246,8 @@ static int reftable_ref_record_copy_from(void *rec, co=
nst void *src_rec,
 	if (src->refname) {
 		size_t refname_len =3D strlen(src->refname);

-		REFTABLE_ALLOC_GROW(ref->refname, refname_len + 1,
-				    ref->refname_cap);
+		REFTABLE_ALLOC_GROW_OR_NULL(ref->refname, refname_len + 1,
+					    ref->refname_cap);
 		if (!ref->refname) {
 			err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto out;
@@ -385,7 +385,7 @@ static int reftable_ref_record_decode(void *rec, struc=
t reftable_buf key,
 	SWAP(r->refname, refname);
 	SWAP(r->refname_cap, refname_cap);

-	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(r->refname, key.len + 1, r->refname_cap);
 	if (!r->refname) {
 		err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
@@ -839,7 +839,7 @@ static int reftable_log_record_decode(void *rec, struc=
t reftable_buf key,
 	if (key.len <=3D 9 || key.buf[key.len - 9] !=3D 0)
 		return REFTABLE_FORMAT_ERROR;

-	REFTABLE_ALLOC_GROW(r->refname, key.len - 8, r->refname_cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(r->refname, key.len - 8, r->refname_cap);
 	if (!r->refname) {
 		err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
@@ -947,8 +947,8 @@ static int reftable_log_record_decode(void *rec, struc=
t reftable_buf key,
 	}
 	string_view_consume(&in, n);

-	REFTABLE_ALLOC_GROW(r->value.update.message, scratch->len + 1,
-			    r->value.update.message_cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(r->value.update.message, scratch->len + 1,
+				    r->value.update.message_cap);
 	if (!r->value.update.message) {
 		err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
diff --git a/reftable/stack.c b/reftable/stack.c
index 634f0c5425..531660a49f 100644
=2D-- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -317,7 +317,9 @@ static int reftable_stack_reload_once(struct reftable_=
stack *st,
 				 * thus need to keep them alive here, which we
 				 * do by bumping their refcount.
 				 */
-				REFTABLE_ALLOC_GROW(reused, reused_len + 1, reused_alloc);
+				REFTABLE_ALLOC_GROW_OR_NULL(reused,
+							    reused_len + 1,
+							    reused_alloc);
 				if (!reused) {
 					err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 					goto done;
@@ -949,8 +951,8 @@ int reftable_addition_add(struct reftable_addition *ad=
d,
 	if (err < 0)
 		goto done;

-	REFTABLE_ALLOC_GROW(add->new_tables, add->new_tables_len + 1,
-			    add->new_tables_cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(add->new_tables, add->new_tables_len + 1,
+				    add->new_tables_cap);
 	if (!add->new_tables) {
 		err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
diff --git a/reftable/writer.c b/reftable/writer.c
index 624e90fb53..740c98038e 100644
=2D-- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -254,7 +254,8 @@ static int writer_index_hash(struct reftable_writer *w=
, struct reftable_buf *has
 	if (key->offset_len > 0 && key->offsets[key->offset_len - 1] =3D=3D off)
 		return 0;

-	REFTABLE_ALLOC_GROW(key->offsets, key->offset_len + 1, key->offset_cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(key->offsets, key->offset_len + 1,
+				    key->offset_cap);
 	if (!key->offsets)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	key->offsets[key->offset_len++] =3D off;
@@ -820,7 +821,7 @@ static int writer_flush_nonempty_block(struct reftable=
_writer *w)
 	 * Note that this also applies when flushing index blocks, in which
 	 * case we will end up with a multi-level index.
 	 */
-	REFTABLE_ALLOC_GROW(w->index, w->index_len + 1, w->index_cap);
+	REFTABLE_ALLOC_GROW_OR_NULL(w->index, w->index_len + 1, w->index_cap);
 	if (!w->index)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;

=2D-
2.47.1
