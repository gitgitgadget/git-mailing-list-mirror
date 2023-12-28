Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6410947
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Na3IYDfC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C619C28CB6;
	Thu, 28 Dec 2023 12:03:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hg/IoBKGuptucGoDz7O3Z2+mzvw99qbhlegN8o
	qPpE0=; b=Na3IYDfCUCgrtFSGrWMJBkZ/stLl4/Z4xRXjWSjS76Hr9j6/YD4wHz
	0CYs3vWCTLu0zTh0UJqy6u+JekYh9SUbbRdP9d99vzWsyWPvJyoYm1A5vLQSCOO4
	bKuBGAqK0qGIjfY1Ysreil8Ogk8WnP6J+pJXmSoUi1snpIQN4//9Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE4B928CB5;
	Thu, 28 Dec 2023 12:03:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4795F28CB2;
	Thu, 28 Dec 2023 12:03:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/8] reftable/record: store "val1" hashes as static
 arrays
In-Reply-To: <46ca3a37f805cd36faa26927220c2793d4cdd561.1703743174.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 28 Dec 2023 07:27:55 +0100")
References: <cover.1703063544.git.ps@pks.im> <cover.1703743174.git.ps@pks.im>
	<46ca3a37f805cd36faa26927220c2793d4cdd561.1703743174.git.ps@pks.im>
Date: Thu, 28 Dec 2023 09:03:10 -0800
Message-ID: <xmqq1qb6i7jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBD04164-A5A2-11EE-8B03-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When reading ref records of type "val1" we store its object ID in an

I'd find it easier to follow if we had a comma before "we store",
but perhaps I am old fashioned.

> allocated array. This results in an additional allocation for every
> single ref record we read, which is rather inefficient especially when
> iterating over refs.
>
> Refactor the code to instead use a static array of `GIT_MAX_RAWSZ`

"a static" -> "an embedded", perhaps?  The struct as the whole may
or may not be static but the point of this patch is that the array
is embedded in it.

> bytes. While this means that `struct ref_record` is bigger now, we
> typically do not store all refs in an array anyway and instead only
> handle a limited number of records at the same point in time.

Nicely explained.

> Using `git show-ref --quiet` in a repository with ~350k refs this leads
> to a significant drop in allocations. Before:
>
>     HEAP SUMMARY:
>         in use at exit: 21,098 bytes in 192 blocks
>       total heap usage: 2,116,683 allocs, 2,116,491 frees, 76,098,060 bytes allocated
>
> After:
>
>     HEAP SUMMARY:
>         in use at exit: 21,098 bytes in 192 blocks
>       total heap usage: 1,419,031 allocs, 1,418,839 frees, 62,145,036 bytes allocated
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block_test.c      |  4 +---
>  reftable/merged_test.c     | 16 ++++++----------
>  reftable/readwrite_test.c  | 14 ++++----------
>  reftable/record.c          |  3 ---
>  reftable/record_test.c     |  1 -
>  reftable/reftable-record.h |  3 ++-
>  reftable/stack_test.c      |  2 --
>  7 files changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/reftable/block_test.c b/reftable/block_test.c
> index c00bbc8aed..dedb05c7d8 100644
> --- a/reftable/block_test.c
> +++ b/reftable/block_test.c
> @@ -49,13 +49,11 @@ static void test_block_read_write(void)
>  
>  	for (i = 0; i < N; i++) {
>  		char name[100];
> -		uint8_t hash[GIT_SHA1_RAWSZ];
>  		snprintf(name, sizeof(name), "branch%02d", i);
> -		memset(hash, i, sizeof(hash));
>  
>  		rec.u.ref.refname = name;
>  		rec.u.ref.value_type = REFTABLE_REF_VAL1;
> -		rec.u.ref.value.val1 = hash;
> +		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
>  
>  		names[i] = xstrdup(name);
>  		n = block_writer_add(&bw, &rec);
> diff --git a/reftable/merged_test.c b/reftable/merged_test.c
> index d08c16abef..b3927a5d73 100644
> --- a/reftable/merged_test.c
> +++ b/reftable/merged_test.c
> @@ -123,13 +123,11 @@ static void readers_destroy(struct reftable_reader **readers, size_t n)
>  
>  static void test_merged_between(void)
>  {
> -	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 0 };
> -
>  	struct reftable_ref_record r1[] = { {
>  		.refname = "b",
>  		.update_index = 1,
>  		.value_type = REFTABLE_REF_VAL1,
> -		.value.val1 = hash1,
> +		.value.val1 = { 1, 2, 3, 0 },
>  	} };
>  	struct reftable_ref_record r2[] = { {
>  		.refname = "a",
> @@ -165,26 +163,24 @@ static void test_merged_between(void)
>  
>  static void test_merged(void)
>  {
> -	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
> -	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
>  	struct reftable_ref_record r1[] = {
>  		{
>  			.refname = "a",
>  			.update_index = 1,
>  			.value_type = REFTABLE_REF_VAL1,
> -			.value.val1 = hash1,
> +			.value.val1 = { 1 },
>  		},
>  		{
>  			.refname = "b",
>  			.update_index = 1,
>  			.value_type = REFTABLE_REF_VAL1,
> -			.value.val1 = hash1,
> +			.value.val1 = { 1 },
>  		},
>  		{
>  			.refname = "c",
>  			.update_index = 1,
>  			.value_type = REFTABLE_REF_VAL1,
> -			.value.val1 = hash1,
> +			.value.val1 = { 1 },
>  		}
>  	};
>  	struct reftable_ref_record r2[] = { {
> @@ -197,13 +193,13 @@ static void test_merged(void)
>  			.refname = "c",
>  			.update_index = 3,
>  			.value_type = REFTABLE_REF_VAL1,
> -			.value.val1 = hash2,
> +			.value.val1 = { 2 },
>  		},
>  		{
>  			.refname = "d",
>  			.update_index = 3,
>  			.value_type = REFTABLE_REF_VAL1,
> -			.value.val1 = hash1,
> +			.value.val1 = { 1 },
>  		},
>  	};
>  
> diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
> index 9c16e0504e..87b238105c 100644
> --- a/reftable/readwrite_test.c
> +++ b/reftable/readwrite_test.c
> @@ -60,18 +60,15 @@ static void write_table(char ***names, struct strbuf *buf, int N,
>  	*names = reftable_calloc(sizeof(char *) * (N + 1));
>  	reftable_writer_set_limits(w, update_index, update_index);
>  	for (i = 0; i < N; i++) {
> -		uint8_t hash[GIT_SHA256_RAWSZ] = { 0 };
>  		char name[100];
>  		int n;
>  
> -		set_test_hash(hash, i);
> -
>  		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
>  
>  		ref.refname = name;
>  		ref.update_index = update_index;
>  		ref.value_type = REFTABLE_REF_VAL1;
> -		ref.value.val1 = hash;
> +		set_test_hash(ref.value.val1, i);
>  		(*names)[i] = xstrdup(name);
>  
>  		n = reftable_writer_add_ref(w, &ref);
> @@ -675,11 +672,10 @@ static void test_write_object_id_min_length(void)
>  	struct strbuf buf = STRBUF_INIT;
>  	struct reftable_writer *w =
>  		reftable_new_writer(&strbuf_add_void, &buf, &opts);
> -	uint8_t hash[GIT_SHA1_RAWSZ] = {42};
>  	struct reftable_ref_record ref = {
>  		.update_index = 1,
>  		.value_type = REFTABLE_REF_VAL1,
> -		.value.val1 = hash,
> +		.value.val1 = {42},
>  	};
>  	int err;
>  	int i;
> @@ -711,11 +707,10 @@ static void test_write_object_id_length(void)
>  	struct strbuf buf = STRBUF_INIT;
>  	struct reftable_writer *w =
>  		reftable_new_writer(&strbuf_add_void, &buf, &opts);
> -	uint8_t hash[GIT_SHA1_RAWSZ] = {42};
>  	struct reftable_ref_record ref = {
>  		.update_index = 1,
>  		.value_type = REFTABLE_REF_VAL1,
> -		.value.val1 = hash,
> +		.value.val1 = {42},
>  	};
>  	int err;
>  	int i;
> @@ -814,11 +809,10 @@ static void test_write_multiple_indices(void)
>  	writer = reftable_new_writer(&strbuf_add_void, &writer_buf, &opts);
>  	reftable_writer_set_limits(writer, 1, 1);
>  	for (i = 0; i < 100; i++) {
> -		unsigned char hash[GIT_SHA1_RAWSZ] = {i};
>  		struct reftable_ref_record ref = {
>  			.update_index = 1,
>  			.value_type = REFTABLE_REF_VAL1,
> -			.value.val1 = hash,
> +			.value.val1 = {i},
>  		};
>  
>  		strbuf_reset(&buf);
> diff --git a/reftable/record.c b/reftable/record.c
> index 5e258c734b..a67a6b4d8a 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -219,7 +219,6 @@ static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
>  	case REFTABLE_REF_DELETION:
>  		break;
>  	case REFTABLE_REF_VAL1:
> -		ref->value.val1 = reftable_malloc(hash_size);
>  		memcpy(ref->value.val1, src->value.val1, hash_size);
>  		break;
>  	case REFTABLE_REF_VAL2:
> @@ -303,7 +302,6 @@ void reftable_ref_record_release(struct reftable_ref_record *ref)
>  		reftable_free(ref->value.val2.value);
>  		break;
>  	case REFTABLE_REF_VAL1:
> -		reftable_free(ref->value.val1);
>  		break;
>  	case REFTABLE_REF_DELETION:
>  		break;
> @@ -394,7 +392,6 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
>  			return -1;
>  		}
>  
> -		r->value.val1 = reftable_malloc(hash_size);
>  		memcpy(r->value.val1, in.buf, hash_size);
>  		string_view_consume(&in, hash_size);
>  		break;
> diff --git a/reftable/record_test.c b/reftable/record_test.c
> index 70ae78feca..5c94d26e35 100644
> --- a/reftable/record_test.c
> +++ b/reftable/record_test.c
> @@ -119,7 +119,6 @@ static void test_reftable_ref_record_roundtrip(void)
>  		case REFTABLE_REF_DELETION:
>  			break;
>  		case REFTABLE_REF_VAL1:
> -			in.u.ref.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
>  			set_hash(in.u.ref.value.val1, 1);
>  			break;
>  		case REFTABLE_REF_VAL2:
> diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
> index f7eb2d6015..7f3a0df635 100644
> --- a/reftable/reftable-record.h
> +++ b/reftable/reftable-record.h
> @@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
>  #ifndef REFTABLE_RECORD_H
>  #define REFTABLE_RECORD_H
>  
> +#include "hash-ll.h"
>  #include <stdint.h>
>  
>  /*
> @@ -38,7 +39,7 @@ struct reftable_ref_record {
>  #define REFTABLE_NR_REF_VALUETYPES 4
>  	} value_type;
>  	union {
> -		uint8_t *val1; /* malloced hash. */
> +		unsigned char val1[GIT_MAX_RAWSZ];
>  		struct {
>  			uint8_t *value; /* first value, malloced hash  */
>  			uint8_t *target_value; /* second value, malloced hash */
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 14a3fc11ee..feab49d7f7 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -463,7 +463,6 @@ static void test_reftable_stack_add(void)
>  		refs[i].refname = xstrdup(buf);
>  		refs[i].update_index = i + 1;
>  		refs[i].value_type = REFTABLE_REF_VAL1;
> -		refs[i].value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
>  		set_test_hash(refs[i].value.val1, i);
>  
>  		logs[i].refname = xstrdup(buf);
> @@ -600,7 +599,6 @@ static void test_reftable_stack_tombstone(void)
>  		refs[i].update_index = i + 1;
>  		if (i % 2 == 0) {
>  			refs[i].value_type = REFTABLE_REF_VAL1;
> -			refs[i].value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
>  			set_test_hash(refs[i].value.val1, i);
>  		}
