Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A63B782
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707877; cv=none; b=vEw3DxPIInKjp6WFFzwb2y/0RypqkqCLY4PYkH/ju58yCr+Dn1/zb7Yiv9pDRGf5ladXL2DJmuB1UfgVbAiw0sdw3NlItSdkhtYy48WDDFuRlnJeXy0eCoinPzIaGWpx9oJafzBJXqO2FJMf4OHGysLRbtKzDNBaUrXr4znsfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707877; c=relaxed/simple;
	bh=PzzXkxdcR7U0UJIwX0A22VqoT0lycD17MVRg0KK0xbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exnu0msKhSvNe4Ebp8cj+M4eil0K2y/weNhnyp77vVbbUrx6pvnsg6D9Gs95DX7jxVQY6gU9WhzWdauxsZvBTWabKBqIig8k+Nq+ys5crt00tdS3D9btaRPX8tET4Twlj3qD6EbUyASIghVVwYX0g1ccDWo+eLPy8LsTCzwS/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ml08Gdse; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ml08Gdse"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E47CC1D84E;
	Mon, 26 Aug 2024 17:31:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PzzXkxdcR7U0UJIwX0A22VqoT0lycD17MVRg0K
	K0xbM=; b=Ml08GdseSrgUeSmgbGFZbnp+WYinMOEEkqbnN2Ro5q7Hbgu9xSdd5y
	3Jwa5pkSt6L7qz0c1c1iGsJ3IIhNpm8TMNE7kbDeXjjlt/lsosR6GfxlgArP9ws+
	3Xbqriy+Ee3tJvxzrsundRn98atkViCZqhqiwODeaZEfumy7clJjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DCE161D84D;
	Mon, 26 Aug 2024 17:31:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42D801D84C;
	Mon, 26 Aug 2024 17:31:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 05/10] cat-file: use delta_base_cache entries directly
In-Reply-To: <20240823224630.1180772-6-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:25 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-6-e@80x24.org>
Date: Mon, 26 Aug 2024 14:31:09 -0700
Message-ID: <xmqqjzg3geea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 839977BA-63F2-11EF-9C06-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Eric Wong <e@80x24.org> writes:

> For objects already in the delta_base_cache, we can safely use
> one entry at-a-time directly to avoid the malloc+memcpy+free
> overhead.  For a 1MB delta base object, this eliminates the
> speed penalty of duplicating large objects into memory and
> speeds up those 1MB delta base cached content retrievals by
> roughly 30%.
>
> While only 2-7% of objects are delta bases in repos I've looked
> at, this avoids up to 96MB of duplicated memory in the worst
> case with the default git config.
>
> The new delta_base_cache_lock is a simple single-threaded
> assertion to ensure cat-file (and similar) is the exclusive user
> of the delta_base_cache.  In other words, we cannot have diff
> or similar commands using two or more entries directly from the
> delta base cache.  The new lock has nothing to do with parallel
> access via multiple threads at the moment.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/cat-file.c | 16 +++++++++++++++-
>  object-file.c      |  5 +++++
>  object-store-ll.h  |  8 ++++++++
>  packfile.c         | 33 ++++++++++++++++++++++++++++++---
>  packfile.h         |  4 ++++
>  5 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index bc4bb89610..8debcdca3e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -386,7 +386,20 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  
>  	if (data->content) {
>  		batch_write(opt, data->content, data->size);
> -		FREE_AND_NULL(data->content);
> +		switch (data->info.whence) {
> +		case OI_CACHED:
> +			/*
> +			 * only blame uses OI_CACHED atm, so it's unlikely
> +			 * we'll ever hit this path
> +			 */
> +			BUG("TODO OI_CACHED support not done");
> +		case OI_LOOSE:
> +		case OI_PACKED:
> +			FREE_AND_NULL(data->content);
> +			break;
> +		case OI_DBCACHED:
> +			unlock_delta_base_cache();
> +		}
>  	} else if (data->type == OBJ_BLOB) {
>  		if (opt->buffer_output)
>  			fflush(stdout);
> @@ -815,6 +828,7 @@ static int batch_objects(struct batch_options *opt)
>  			data.info.sizep = &data.size;
>  			data.info.contentp = &data.content;
>  			data.info.content_limit = big_file_threshold;
> +			data.info.direct_cache = 1;
>  		}
>  	}
>  
> diff --git a/object-file.c b/object-file.c
> index 1cc29c3c58..19100e823d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1586,6 +1586,11 @@ static int do_oid_object_info_extended(struct repository *r,
>  			oidclr(oi->delta_base_oid, the_repository->hash_algo);
>  		if (oi->type_name)
>  			strbuf_addstr(oi->type_name, type_name(co->type));
> +		/*
> +		 * Currently `blame' is the only command which creates
> +		 * OI_CACHED, and direct_cache is only used by `cat-file'.
> +		 */
> +		assert(!oi->direct_cache);

If "git cat-file" ever gets enhanced to also use
pretend_object_file(), this assumption gets violated.  

What happens then?  Would we return inconsistent answer to the
caller that may result in garbage output, breaking the downstream
process somehow?  If so, I'd prefer to see this guarded more
explicitly with "if (...)  BUG()" than assert() here.

>  		if (oi->contentp)
>  			*oi->contentp = xmemdupz(co->buf, co->size);

Regardless of the answer of the question above about assert(),
shouldn't the step [02/10] of this series also have been made to pay
attention to oi->content_limit mechanism?  It looks inconsistent.

> diff --git a/object-store-ll.h b/object-store-ll.h
> index b71a15f590..669bb93784 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -298,6 +298,14 @@ struct object_info {
>  		OI_PACKED,
>  		OI_DBCACHED
>  	} whence;
> +
> +	/*
> +	 * Set if caller is able to use OI_DBCACHED entries without copying.
> +	 * This only applies to OI_DBCACHED entries at the moment,
> +	 * not OI_CACHED or any other type of entry.
> +	 */
> +	unsigned direct_cache:1;

This is a "response" from the API to the caller, but "Set if ..."
sounds as if you are telling the caller what to do.  Would the
caller set this bit when making a request to say "I am cat-file and
I use entry before making any other requests to the object layer so
I am sure object layer will not evict the entry I am using"?  No,
that is not a "response".

You seem to set this bit in batch_objects(), so it does sound like
that the bit is expected to be set by the caller to tell the API
something.  If that is the case, then (1) move it to "request" part
of the object_info structure, and (2) define what it means to be
"able to use ... without copying".  Mechanically, it may mean
"contentp directly points into the delta base cache", but what
implication does it have to callers?  If the caller obtains such a
pointer in .contentp, what is required for its access pattern to
make accessing the pointer safe?  The caller cannot use the pointed
memory after it accesses another object?  What is the definition of
"access" in the context of this discussion?  Does "checking for
existence of an object" count as an access?

> +static void lock_delta_base_cache(void)
> +{
> +	delta_base_cache_lock++;
> +	assert(delta_base_cache_lock == 1);
> +}
> +
> +void unlock_delta_base_cache(void)
> +{
> +	delta_base_cache_lock--;
> +	assert(delta_base_cache_lock == 0);
> +}

I view assert() validating precondition for the control flow to pass
the point in the code path, so the above looks somewhat surprising.

Shouldn't we instead checking the current value first and then only
if the caller is _allowed_ to lock/unlock from that state (i.e. the
lock is not held/the lock is held), increment/decrement the variable?

> +			/* ignore content_limit if avoiding copy from cache */
> +			if (oi->direct_cache) {
> +				lock_delta_base_cache();
> +				*oi->contentp = ent->data;
> +			} else if (!oi->content_limit ||
> +					ent->size <= oi->content_limit) {
>  				*oi->contentp = xmemdupz(ent->data, ent->size);

This somehow looks making the memory ownership rules confusing.

How does the caller know when it can free(oi->contentp) after a call
returns?  If it sets direct_cache and got a non-NULL *oi->contentp
back, is it always pointing at a borrowed piece memory, so that it
does not have to worry about freeing, but if it didn't set
direct_cache, it can be holding an allocated piece of memory and you
are responsible for freeing it?

The following is a tangent that is not necessary to be addressed in
this series, but since I've spent time to think about it already,
let me record it as #leftoverbits here.

Whatever the answers to the earlier questions on the comment on the
direct_cache member are, I wonder if the access pattern of the
caller that satisfies such requirement allows a lot simpler
solution.  Would it give us similar performance boost by (morally)
reverting 85fe35ab (cache_or_unpack_entry: drop keep_cache
parameter, 2016-08-22) to resurrect the "pass ownership of a delta
base cache entry to the caller" feature?  We give the content to the
caller of object_info, and evict the cached delta base.  Ideally, we
shouldn't have to ask the caller to do anything special, other than
just setting contentp to non-NULL (and optionally setting
content_limit), and the choice of copying or passing the ownership
should be made in the object access layer, which knows how big the
object is (e.g., small things may be easier to recreate), how deep
the delta chain the entry in the delta base cache is (e.g., a delta
base object that is simply deflated can be recreated cheaply, while
one based on top of 100-delta deep chain is very expensive to
recreate), etc.

