Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12344F5E9
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RsXFyZDH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E8121C8DDD;
	Wed, 10 Jan 2024 16:24:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VQ55qgQaNfHXXeBhQjMHw0qamSpLCCq36CD44N
	9a/Rc=; b=RsXFyZDHgXmcmXAU7W46ADh0BxGcmzzy3JJ7aMfA/CxrowU0hPqm36
	PD1FRjzwyVxgycLd3DItKT4tsLj8P5/Xj3Ad6x8qn++uSwemXcIAodqDZHaGU0+l
	7Wo1NkghuCto2L1C/pXprsP5Dqj7xf96q60KXJNwrFU7XCnve0koY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 766341C8DDC;
	Wed, 10 Jan 2024 16:24:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D53CE1C8DDB;
	Wed, 10 Jan 2024 16:24:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 4/4] reftable/blocksource: use mmap to read tables
In-Reply-To: <a23f38a80609a5c5a6931400ffd28a92b33838bb.1704714575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 8 Jan 2024 13:18:43 +0100")
References: <cover.1704714575.git.ps@pks.im>
	<a23f38a80609a5c5a6931400ffd28a92b33838bb.1704714575.git.ps@pks.im>
Date: Wed, 10 Jan 2024 13:24:24 -0800
Message-ID: <xmqq5y00anlj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A15DE464-AFFE-11EE-94AF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Using mmap comes with a significant drawback on Windows though, because
> mmapped files cannot be deleted and neither is it possible to rename
> files onto an mmapped file. But for one, the reftable library gracefully
> handles the case where auto-compaction cannot delete a still-open stack
> already and ignores any such errors. Also, `reftable_stack_clean()` will
> prune stale tables which are not referenced by "tables.list" anymore so
> that those files can eventually be pruned. And second, we never rewrite
> already-rewritten stacks, so it does not matter that we cannot rename a
> file over an mmaped file, either.

I somehow thought that we use "read into an allocated memory and
pretend as if we mapped" emulation on Windows, so all of that may be
moot.

> diff --git a/reftable/blocksource.c b/reftable/blocksource.c
> index a1ea304429..5d3f3d264c 100644
> --- a/reftable/blocksource.c
> +++ b/reftable/blocksource.c
> @@ -13,6 +13,12 @@ license that can be found in the LICENSE file or at
>  #include "reftable-blocksource.h"
>  #include "reftable-error.h"
>  
> +#if defined(NO_MMAP)
> +static int use_mmap = 0;
> +#else
> +static int use_mmap = 1;
> +#endif

Is there (do you need) some externally controllable knob that the
user can use to turn this off on a system that is compiled without
NO_MMAP?  Otherwise it is misleading to have this as a variable.

> -static void file_close(void *b)
> +static void file_close(void *v)
>  {
> -	int fd = ((struct file_block_source *)b)->fd;
> -	if (fd > 0) {
> -		close(fd);
> -		((struct file_block_source *)b)->fd = 0;
> +	struct file_block_source *b = v;
> +
> +	if (b->fd >= 0) {
> +		close(b->fd);
> +		b->fd = -1;
>  	}
>  
> +	if (use_mmap)
> +		munmap(b->data, b->size);
> +	else
> +		reftable_free(b->data);
> +	b->data = NULL;
> +
>  	reftable_free(b);
>  }

It would have been nicer to do this kind of "a void pointer is taken
and we immediately cast it to a concrete and useful type upon entry"
clean-up as a separate step that is purely clean-up, if there were
many instances.  It is the first such one in the series as far as I
remember, so it is not a huge deal.

> @@ -108,9 +119,7 @@ static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
>  {
>  	struct file_block_source *b = v;
>  	assert(off + size <= b->size);
> -	dest->data = reftable_malloc(size);
> -	if (pread_in_full(b->fd, dest->data, size, off) != size)
> -		return -1;
> +	dest->data = b->data + off;
>  	dest->len = size;
>  	return size;
>  }

So, we used to delay the allocation and reading of a block until
this function gets called.  Now, by the time the control reaches
the function, we are expected to have the data handy at b->data.
That is ensured by reftable_block_source_from_file(), I presume?

> @@ -127,8 +136,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
>  {
>  	struct stat st = { 0 };
>  	int err = 0;
> -	int fd = open(name, O_RDONLY);
> +	int fd;
>  	struct file_block_source *p = NULL;
> +
> +	fd = open(name, O_RDONLY);
>  	if (fd < 0) {
>  		if (errno == ENOENT) {
>  			return REFTABLE_NOT_EXIST_ERROR;

This is a no-op clean-up that would have been better in a separate
clean-up step.  Again, not a huge deal.

> @@ -144,7 +155,18 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
>  
>  	p = reftable_calloc(sizeof(struct file_block_source));
>  	p->size = st.st_size;
> -	p->fd = fd;
> +	if (use_mmap) {
> +		p->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +		p->fd = fd;

This is a bit unusual for our use of mmap() where the norm is to
close the file descriptor once we mapped (we only need the memory
region itself and not the originating file descriptor to unmap it).

Is there a reason why we need to keep p->fd?  Now the other side of
this if/else preallocates the whole thing and slurps everything in
core to allow the remainder of the code to mimic what happens on the
mmaped block memory (e.g., we saw how file_read_block() assumes that
b->data[0..b->size] are valid) and does not obviously need p->fd,
can we just remove .fd member from the file_block_source structure?

That way, file_close() can also lose the conditional close() call.

For that matter, do we need any codepath in this file that is
enabled by !use_mmap?  Can't we just use xmmap() and let its
"instead, we allocate, read into it and return" emulation?

Thanks.

> +	} else {
> +		p->data = xmalloc(st.st_size);
> +		if (read_in_full(fd, p->data, st.st_size) != st.st_size) {
> +			close(fd);
> +			return -1;
> +		}
> +		close(fd);
> +		p->fd = -1;
> +	}
>  
>  	assert(!bs->ops);
>  	bs->ops = &file_vtable;
