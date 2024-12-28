Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9834594D
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735379233; cv=none; b=bvJ9LcfvXpRxVGcu7HzJzty2MQzZp8whAMN1YkAoo5ibdYaskTaDNwcDjgzUFfdmxrcjyjdB/w6GUJkJxYVIeEJ4AJvvZpHGeXH6Aw1HUfNXaCDKa/Hov5fVaif0x3mUBtSKR+a6EDaBKFChvwCqBoFAOmQmowkZhPvIY2C1bPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735379233; c=relaxed/simple;
	bh=m39T0hgHpPxdxPW/AwfbmUse/iN+S1VV2c9z99gWSwc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KmotdAyecVIV1geEC96rE3ehZ/merkRXFyPn4jljxoTWrR8zSRUYX+FZTO+MyBHAVGPaAz4GVR19COcZ+YX4NMLu5qJiSZtASJBtsSX6TPe7ICQVJICouOkECmuIrD6HXilbveJps/oVnhCG29KsUoExpx+dkytzv87RvIzAGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YPbEx2Pi; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YPbEx2Pi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735379226; x=1735984026; i=l.s.r@web.de;
	bh=LIv5TvXjvG5dfdh+vX8re0Uwr7Vtc3hrVWgAxRhxb+Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YPbEx2PiOYD3M+nITpJ88b8PXrD78sgyJKeSqpNYXA48zRCwOx/ussFiO/jzP8a0
	 dcpbNlzCBlZ5AagP5mmxYQIInKaRCwsfxWUGqRf1bOdYCyswBoS6gW5m77Hwy1gnu
	 vMFtTGA54p6nlRUohuC1OKUqirYvjuBe6tRGT7LS/qXqEC31spBwtwPloQQaorw1J
	 P2k5sgdHJsZMqKxW4Kg+EqoYMCeXjNyKpK9icn09GfxQTta97Fn3DBMISGICw6qg8
	 zPR1EoMGAYK3clYbrARzXS3Z/ivF6fDtyNEI8nwP5rSaDQmXNcald0Rlc5JKSbr2X
	 /eXYCV2NwYrf9FybFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1u2k653hGa-00bAsM; Sat, 28
 Dec 2024 10:47:05 +0100
Message-ID: <2f12efca-8b38-446a-a4a6-f80898275acc@web.de>
Date: Sat, 28 Dec 2024 10:47:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/4] reftable: avoid leaks on realloc error
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Language: en-US
In-Reply-To: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U41/IJkQcYe0zYw/xawCFVbiIDB7aLzq8LI9wd6S/Kzbz8beCmF
 FhoBJxnoxtUfPN9BcN0klIN+T+BmXc/2XOrFS26rwkjVM+KOcHx0rX/88m7/kcS1dmYukiO
 Cy12S9JjJ1qOV5Gwku1TZckGbur0bIn+EZpDX9RKw/Qjg2TCWSTUblgzw+5BUKs/0ah1X1v
 eGIZ0MeeB19YH3Ot1tuYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dCf+VxDGJek=;GJVRk5Jcg9Ws/9Z6lC3lTH7xjU1
 1G8dEzTZ6TyUL6lYkepQnWweFkjPh4QC3v4XIUo6ohrgJ3ZhhLa0i9nxbRwBIlWDwUSGwebVO
 MK08KoS7OuXI36v3FpfCmTkZUY6mt59KPpUDpukdT2SHk4mRVvRzykwQSvQgG53Sft2Wpm0BB
 XioSAdN53Pn0TqhH/LEFjMoejf0wvqbpeMEARcnvoSzIoFOVMtSahUkm6JDbhjCZ5ij+xbRNh
 U1n3yS9ez0sUWFxVUhLIzpJGvRu3lUN0UGwYJDkHy2efUIZ4lcEaLfihwpQdVdN0Jwe9J4eCA
 yn8s184lUl6RbxVGKE+Hf/vAX4RJjaeHI6/wIgOYss1KOj1/46leuBvF/bFZZhJTXYpKB8ovv
 syeKvQU52n4ttsluD/pVRWmqU0GubPvY0pe72F4gr9y6rsrbc9YsLDO8ykza9I+fJtq7bQRhI
 1zxDu6SfHDTmZNxfDiUxfww/srG7g81E8Ry2AKPXY5YYLiIodtH3UcoRcua96Ky+kaz5z1UpP
 uO/easfKxfR413O1eJwuXek3FSeSL2HMVnMY3YKhzz+xj3Z65gmYhEtOjCA3FTdMunXM0diE6
 3ZQxkE3DG/kSpylxHo7XSMM5zChjMh9Oest37Kc5U2ME9pbCzduCn6BYAmmZP9fgNggpYyZxz
 USrQh3sV8A5RpuQg81l0RUm1mQQBlzAurolLG1aQZpCEY7su18EjalKQAqODFe6rdBUFubz/e
 RbXHDJ0QuAz5ANmV/RxcmKLlq9oZJXsTTgG50chr6jw/YBlzUbbL9NO+2RuP0Tl5LLvOq3sHB
 nxHwLOt2lZawshVTE05lIekspc8Gjz5vxbfXtYwh7tV1NYkQrUUFqc357w2U9iDRjcz4A4Wkl
 ja10oVipnmVKMn7WFQnHXoeLSCB/tf2V3sNmUGhki1NlBIkYZKOI53pFtCPssq4H65t6JiSqd
 W4U8mEZJ7Jz9ZeqGMStj1PTsscokTJzwJsEt3NpM7JzwPC3huR7cBmQT0ejOwP98j/7WhdkMv
 w7jS9i5giv/hjqfzGcwccZmlfY/XcEj742okrhfzagz2nhsZ35GPkfa8i1uBvXw24U5lnVbtz
 0XSRMx3b0=

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
 reftable/basics.h                | 10 ++++++++++
 reftable/block.c                 | 10 ++++++----
 reftable/pq.c                    |  2 +-
 reftable/record.c                | 12 ++++++------
 reftable/stack.c                 |  8 +++++---
 reftable/writer.c                |  5 +++--
 t/unit-tests/t-reftable-basics.c | 30 ++++++++++++++++++++++++++++++
 7 files changed, 61 insertions(+), 16 deletions(-)

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

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-ba=
sics.c
index 65d50df091..5bf79c9976 100644
=2D-- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -20,6 +20,11 @@ static int integer_needle_lesseq(size_t i, void *_args)
 	return args->needle <=3D args->haystack[i];
 }

+static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
+{
+	return NULL;
+}
+
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	if_test ("binary search with binsearch works") {
@@ -141,5 +146,30 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUS=
ED)
 		check_int(in, =3D=3D, out);
 	}

+	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
+		int *arr =3D NULL;
+		size_t alloc =3D 0, old_alloc;
+
+		REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
+		check(arr !=3D NULL);
+		check_uint(alloc, >=3D, 1);
+		arr[0] =3D 42;
+
+		old_alloc =3D alloc;
+		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
+		check(arr !=3D NULL);
+		check_uint(alloc, >, old_alloc);
+		arr[alloc - 1] =3D 42;
+
+		old_alloc =3D alloc;
+		reftable_set_alloc(malloc, realloc_stub, free);
+		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
+		check(arr =3D=3D NULL);
+		check_uint(alloc, =3D=3D, 0);
+		reftable_set_alloc(malloc, realloc, free);
+
+		reftable_free(arr);
+	}
+
 	return test_done();
 }
=2D-
2.47.1
