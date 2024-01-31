Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE338DF5
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733356; cv=none; b=YZ6O/FfjzbtndSyADqSZY+bUPrDwgRNAT6k3lwX12AnFeKCUZFKuwFAyJujCv4QfpiCDjYNiSH5ZQj6F4YDmXRlMT2DcooMP0+hZ+vP2lmMIzCaQHqFB0T9H/9PyvQGNe7F3VvG+FQ/prOrds04+U+gAK5Ne3Gjdu18nxu4RWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733356; c=relaxed/simple;
	bh=v6wHjAsl5Zo4Jzs1bZTrG1htUXarNJJdQpY92dHMc9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wjvsf4GId5eeKAmCDmc4wCyVUW0EB4RvxyLHAZV9wwEDJz068/eoA2Ho7rX0rxFiMzp4N/T5hPDuXK06spP+Xo+xoai3zygCqQumf5QfIcjQU2tSrz09a09CgQWG/vKXMbthLQU7yLQjSt/cbk8AFOzV7oRmhQIXVL8mBsXUbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LdLhuFR/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdLhuFR/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FD1A1EAD1B;
	Wed, 31 Jan 2024 15:35:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v6wHjAsl5Zo4Jzs1bZTrG1htUXarNJJdQpY92d
	HMc9A=; b=LdLhuFR/mIPKkAnJfYv3uEHg49Y2opkTdz2CtZ0u12hi1RwkYDPYLK
	PWqXTVhTKGTD7cvGDcdKedAxIFK3EvPIAyGCz6zKEY5oRx1YoEtcBU0WU9CJ+dMg
	ZRDnJjs1FmQXCp6zbnxqE4MsirMgeDXozJeHwRL13FBn2I7kdzjTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47BF21EAD1A;
	Wed, 31 Jan 2024 15:35:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A22661EAD19;
	Wed, 31 Jan 2024 15:35:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] reftable: introduce macros to grow arrays
In-Reply-To: <0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 31 Jan 2024 09:01:03 +0100")
References: <cover.1706687982.git.ps@pks.im>
	<0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
Date: Wed, 31 Jan 2024 12:35:51 -0800
Message-ID: <xmqqmssl44wo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53A233EE-C078-11EE-B1CD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> patterns in the reftable library. For In most cases, we end up only having a
> single item in the array, so the initial capacity that our global growth
> factor uses (which is 24), significantly overallocates in a lot of code
> paths. 

You need to know not just that you very often initially have only
one but you rarely grow it beyond 3, or something like that to
explain "significantly overallocates", though.

> This effect is indeed measurable:

And measuring is very good, but I somehow expected that you would
measure not the time (if you often under-allocate and end up
reallocating too many times, it might consume more time, though) but
the peak memory usage.  I cannot quite tell what to think of that 2%
time difference.

> Convert the reftable library to use these new macros.

In any case, the conversion shortens the code and is a good thing.
I wish we had a way to tell these macros that we are actually using
the same single allocator (which we are doing in our code when
linking the reftable thing to us anyway), which would have made this
even simpler because you did not have to introduce separate macros..

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/basics.c      |  8 ++------
>  reftable/basics.h      | 11 +++++++++++
>  reftable/block.c       |  7 +------
>  reftable/merged_test.c | 20 ++++++--------------
>  reftable/pq.c          |  8 ++------
>  reftable/stack.c       | 29 ++++++++++++-----------------
>  reftable/writer.c      | 14 ++------------
>  7 files changed, 36 insertions(+), 61 deletions(-)
>
> diff --git a/reftable/basics.c b/reftable/basics.c
> index f761e48028..af9004cec2 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -89,17 +89,13 @@ void parse_names(char *buf, int size, char ***namesp)
>  			next = end;
>  		}
>  		if (p < next) {
> -			if (names_len == names_cap) {
> -				names_cap = 2 * names_cap + 1;
> -				names = reftable_realloc(
> -					names, names_cap * sizeof(*names));
> -			}
> +			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
>  			names[names_len++] = xstrdup(p);
>  		}
>  		p = next + 1;
>  	}
>  
> -	names = reftable_realloc(names, (names_len + 1) * sizeof(*names));
> +	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
>  	names[names_len] = NULL;
>  	*namesp = names;
>  }
> diff --git a/reftable/basics.h b/reftable/basics.h
> index 096b36862b..2f855cd724 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -53,6 +53,17 @@ void *reftable_realloc(void *p, size_t sz);
>  void reftable_free(void *p);
>  void *reftable_calloc(size_t sz);
>  
> +#define REFTABLE_REALLOC_ARRAY(x, alloc) (x) = reftable_realloc((x), st_mult(sizeof(*(x)), (alloc)))
> +#define REFTABLE_ALLOC_GROW(x, nr, alloc) \
> +	do { \
> +		if ((nr) > alloc) { \
> +			alloc = 2 * (alloc) + 1; \
> +			if (alloc < (nr)) \
> +				alloc = (nr); \
> +			REFTABLE_REALLOC_ARRAY(x, alloc); \
> +		} \
> +	} while (0)
> +
>  /* Find the longest shared prefix size of `a` and `b` */
>  struct strbuf;
>  int common_prefix_size(struct strbuf *a, struct strbuf *b);
> diff --git a/reftable/block.c b/reftable/block.c
> index 1df3d8a0f0..6952d0facf 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -51,12 +51,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
>  	if (2 + 3 * rlen + n > w->block_size - w->next)
>  		return -1;
>  	if (is_restart) {
> -		if (w->restart_len == w->restart_cap) {
> -			w->restart_cap = w->restart_cap * 2 + 1;
> -			w->restarts = reftable_realloc(
> -				w->restarts, sizeof(uint32_t) * w->restart_cap);
> -		}
> -
> +		REFTABLE_ALLOC_GROW(w->restarts, w->restart_len + 1, w->restart_cap);
>  		w->restarts[w->restart_len++] = w->next;
>  	}
>  
> diff --git a/reftable/merged_test.c b/reftable/merged_test.c
> index 46908f738f..e05351e035 100644
> --- a/reftable/merged_test.c
> +++ b/reftable/merged_test.c
> @@ -231,14 +231,10 @@ static void test_merged(void)
>  	while (len < 100) { /* cap loops/recursion. */
>  		struct reftable_ref_record ref = { NULL };
>  		int err = reftable_iterator_next_ref(&it, &ref);
> -		if (err > 0) {
> +		if (err > 0)
>  			break;
> -		}
> -		if (len == cap) {
> -			cap = 2 * cap + 1;
> -			out = reftable_realloc(
> -				out, sizeof(struct reftable_ref_record) * cap);
> -		}
> +
> +		REFTABLE_ALLOC_GROW(out, len + 1, cap);
>  		out[len++] = ref;
>  	}
>  	reftable_iterator_destroy(&it);
> @@ -368,14 +364,10 @@ static void test_merged_logs(void)
>  	while (len < 100) { /* cap loops/recursion. */
>  		struct reftable_log_record log = { NULL };
>  		int err = reftable_iterator_next_log(&it, &log);
> -		if (err > 0) {
> +		if (err > 0)
>  			break;
> -		}
> -		if (len == cap) {
> -			cap = 2 * cap + 1;
> -			out = reftable_realloc(
> -				out, sizeof(struct reftable_log_record) * cap);
> -		}
> +
> +		REFTABLE_ALLOC_GROW(out, len + 1, cap);
>  		out[len++] = log;
>  	}
>  	reftable_iterator_destroy(&it);
> diff --git a/reftable/pq.c b/reftable/pq.c
> index dcefeb793a..2461daf5ff 100644
> --- a/reftable/pq.c
> +++ b/reftable/pq.c
> @@ -75,13 +75,9 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
>  {
>  	int i = 0;
>  
> -	if (pq->len == pq->cap) {
> -		pq->cap = 2 * pq->cap + 1;
> -		pq->heap = reftable_realloc(pq->heap,
> -					    pq->cap * sizeof(struct pq_entry));
> -	}
> -
> +	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
>  	pq->heap[pq->len++] = *e;
> +
>  	i = pq->len - 1;
>  	while (i > 0) {
>  		int j = (i - 1) / 2;
> diff --git a/reftable/stack.c b/reftable/stack.c
> index bf3869ce70..1dfab99e96 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -551,7 +551,7 @@ struct reftable_addition {
>  	struct reftable_stack *stack;
>  
>  	char **new_tables;
> -	int new_tables_len;
> +	size_t new_tables_len, new_tables_cap;
>  	uint64_t next_update_index;
>  };
>  
> @@ -602,8 +602,9 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  
>  static void reftable_addition_close(struct reftable_addition *add)
>  {
> -	int i = 0;
>  	struct strbuf nm = STRBUF_INIT;
> +	size_t i;
> +
>  	for (i = 0; i < add->new_tables_len; i++) {
>  		stack_filename(&nm, add->stack, add->new_tables[i]);
>  		unlink(nm.buf);
> @@ -613,6 +614,7 @@ static void reftable_addition_close(struct reftable_addition *add)
>  	reftable_free(add->new_tables);
>  	add->new_tables = NULL;
>  	add->new_tables_len = 0;
> +	add->new_tables_cap = 0;
>  
>  	delete_tempfile(&add->lock_file);
>  	strbuf_release(&nm);
> @@ -631,8 +633,8 @@ int reftable_addition_commit(struct reftable_addition *add)
>  {
>  	struct strbuf table_list = STRBUF_INIT;
>  	int lock_file_fd = get_tempfile_fd(add->lock_file);
> -	int i = 0;
>  	int err = 0;
> +	size_t i;
>  
>  	if (add->new_tables_len == 0)
>  		goto done;
> @@ -660,12 +662,12 @@ int reftable_addition_commit(struct reftable_addition *add)
>  	}
>  
>  	/* success, no more state to clean up. */
> -	for (i = 0; i < add->new_tables_len; i++) {
> +	for (i = 0; i < add->new_tables_len; i++)
>  		reftable_free(add->new_tables[i]);
> -	}
>  	reftable_free(add->new_tables);
>  	add->new_tables = NULL;
>  	add->new_tables_len = 0;
> +	add->new_tables_cap = 0;
>  
>  	err = reftable_stack_reload_maybe_reuse(add->stack, 1);
>  	if (err)
> @@ -792,11 +794,9 @@ int reftable_addition_add(struct reftable_addition *add,
>  		goto done;
>  	}
>  
> -	add->new_tables = reftable_realloc(add->new_tables,
> -					   sizeof(*add->new_tables) *
> -						   (add->new_tables_len + 1));
> -	add->new_tables[add->new_tables_len] = strbuf_detach(&next_name, NULL);
> -	add->new_tables_len++;
> +	REFTABLE_ALLOC_GROW(add->new_tables, add->new_tables_len + 1,
> +			    add->new_tables_cap);
> +	add->new_tables[add->new_tables_len++] = strbuf_detach(&next_name, NULL);
>  done:
>  	if (tab_fd > 0) {
>  		close(tab_fd);
> @@ -1367,17 +1367,12 @@ static int stack_check_addition(struct reftable_stack *st,
>  	while (1) {
>  		struct reftable_ref_record ref = { NULL };
>  		err = reftable_iterator_next_ref(&it, &ref);
> -		if (err > 0) {
> +		if (err > 0)
>  			break;
> -		}
>  		if (err < 0)
>  			goto done;
>  
> -		if (len >= cap) {
> -			cap = 2 * cap + 1;
> -			refs = reftable_realloc(refs, cap * sizeof(refs[0]));
> -		}
> -
> +		REFTABLE_ALLOC_GROW(refs, len + 1, cap);
>  		refs[len++] = ref;
>  	}
>  
> diff --git a/reftable/writer.c b/reftable/writer.c
> index ee4590e20f..4483bb21c3 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -200,12 +200,7 @@ static void writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
>  		return;
>  	}
>  
> -	if (key->offset_len == key->offset_cap) {
> -		key->offset_cap = 2 * key->offset_cap + 1;
> -		key->offsets = reftable_realloc(
> -			key->offsets, sizeof(uint64_t) * key->offset_cap);
> -	}
> -
> +	REFTABLE_ALLOC_GROW(key->offsets, key->offset_len + 1, key->offset_cap);
>  	key->offsets[key->offset_len++] = off;
>  }
>  
> @@ -674,12 +669,7 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
>  	if (err < 0)
>  		return err;
>  
> -	if (w->index_cap == w->index_len) {
> -		w->index_cap = 2 * w->index_cap + 1;
> -		w->index = reftable_realloc(
> -			w->index,
> -			sizeof(struct reftable_index_record) * w->index_cap);
> -	}
> +	REFTABLE_ALLOC_GROW(w->index, w->index_len + 1, w->index_cap);
>  
>  	ir.offset = w->next;
>  	strbuf_reset(&ir.last_key);
