Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C03986C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6y7yPUn"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA953A87
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:18:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D29871C2F46;
	Wed, 18 Oct 2023 19:18:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZWtmytRTSRA301VtaegVJr3MIoOawgT+7Qi3b0
	mvBM4=; b=I6y7yPUnGR/Yppfbi62FUovWmQgU+3EKOLrHc+Yr2Cu9RlLTzarFps
	kI8lfuQY/GV4gI5Bv3LSum1qY44EmvNFNpYP+FViwhEh+MYchfX0F9p98KbyQOp5
	nHIEsaEX+USaz6AM2j+aKemGp6+bI48yfhIZ7F9X2H+Z7+q92wIn0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C94F91C2F45;
	Wed, 18 Oct 2023 19:18:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3314B1C2F44;
	Wed, 18 Oct 2023 19:18:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 08/10] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
In-Reply-To: <8667b763652ffa71b52b7bd78821e46a6e5fe5a9.1697648864.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 18 Oct 2023 13:08:11 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
	<cover.1697648864.git.me@ttaylorr.com>
	<8667b763652ffa71b52b7bd78821e46a6e5fe5a9.1697648864.git.me@ttaylorr.com>
Date: Wed, 18 Oct 2023 16:18:23 -0700
Message-ID: <xmqq34y7plj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A33A9B4E-6E0C-11EE-A9BB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Now that we have factored out many of the common routines necessary to
> index a new object into a pack created by the bulk-checkin machinery, we
> can introduce a variant of `index_blob_bulk_checkin()` that acts on
> blobs whose contents we can fit in memory.

Hmph.

Doesn't the duplication between the main loop of the new
deflate_obj_contents_to_pack() with existing deflate_blob_to_pack()
bother you?

A similar duplication in the previous round resulted in a nice
refactoring of patches 5 and 6 in this round.  Compared to that,
the differences in the set-up code between the two functions may be
much larger, but subtle and unnecessary differences between the code
that was copied and pasted (e.g., we do not check the errors from
the seek_to method here, but the original does) is a sign that over
time a fix to one will need to be carried over to the other, adding
unnecessary maintenance burden, isn't it?

> +static int deflate_obj_contents_to_pack_incore(struct bulk_checkin_packfile *state,
> +					       git_hash_ctx *ctx,
> +					       struct hashfile_checkpoint *checkpoint,
> +					       struct object_id *result_oid,
> +					       const void *buf, size_t size,
> +					       enum object_type type,
> +					       const char *path, unsigned flags)
> +{
> +	struct pack_idx_entry *idx = NULL;
> +	off_t already_hashed_to = 0;
> +	struct bulk_checkin_source source = {
> +		.type = SOURCE_INCORE,
> +		.buf = buf,
> +		.size = size,
> +		.read = 0,
> +		.path = path,
> +	};
> +
> +	/* Note: idx is non-NULL when we are writing */
> +	if (flags & HASH_WRITE_OBJECT)
> +		CALLOC_ARRAY(idx, 1);
> +
> +	while (1) {
> +		prepare_checkpoint(state, checkpoint, idx, flags);
> +
> +		if (!stream_obj_to_pack(state, ctx, &already_hashed_to, &source,
> +					type, flags))
> +			break;
> +		truncate_checkpoint(state, checkpoint, idx);
> +		bulk_checkin_source_seek_to(&source, 0);
> +	}
> +
> +	finalize_checkpoint(state, ctx, checkpoint, idx, result_oid);
> +
> +	return 0;
> +}
> +
> +static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
> +				       struct object_id *result_oid,
> +				       const void *buf, size_t size,
> +				       const char *path, unsigned flags)
> +{
> +	git_hash_ctx ctx;
> +	struct hashfile_checkpoint checkpoint = {0};
> +
> +	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BLOB,
> +				  size);
> +
> +	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
> +						   result_oid, buf, size,
> +						   OBJ_BLOB, path, flags);
> +}
> +
>  static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
>  				struct object_id *result_oid,
>  				int fd, size_t size,
> @@ -456,6 +509,17 @@ int index_blob_bulk_checkin(struct object_id *oid,
>  	return status;
>  }
>  
> +int index_blob_bulk_checkin_incore(struct object_id *oid,
> +				   const void *buf, size_t size,
> +				   const char *path, unsigned flags)
> +{
> +	int status = deflate_blob_to_pack_incore(&bulk_checkin_packfile, oid,
> +						 buf, size, path, flags);
> +	if (!odb_transaction_nesting)
> +		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
> +	return status;
> +}
> +
>  void begin_odb_transaction(void)
>  {
>  	odb_transaction_nesting += 1;
> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index aa7286a7b3..1b91daeaee 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -13,6 +13,10 @@ int index_blob_bulk_checkin(struct object_id *oid,
>  			    int fd, size_t size,
>  			    const char *path, unsigned flags);
>  
> +int index_blob_bulk_checkin_incore(struct object_id *oid,
> +				   const void *buf, size_t size,
> +				   const char *path, unsigned flags);
> +
>  /*
>   * Tell the object database to optimize for adding
>   * multiple objects. end_odb_transaction must be called
