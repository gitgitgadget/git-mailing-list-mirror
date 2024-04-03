Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7B1553B8
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172926; cv=none; b=ECLFpEp6qdy4bJ5vER5PDZVhC4zYYOz7ztLoivni8SfPqhDdgb9ndCkr9LOCZ9cyjxKKzb39j3fLjKpe+J4EI/KrlyE8t1WTdoBGUFSxfoyw8+8/TGzLfMbm7iR7jYf20Wj0oiNr5T882V3eIb7gsVR7Cr170Zf/W1E+9u/RT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172926; c=relaxed/simple;
	bh=+GJsjX3Qyf67nmxGFr5K3Pu5sU1Y/YLh/+4P5vL9pxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUbgDj45Qns1Q5SsDM6ly97pBtqf+PAk6aS2OTD7thNGAMifipeJJA6k0lP0YB7pW3cpbcgl6zoBbL5q/K3PMi4gLxuNUPHSyOWhsDrT5Tsorw/yS//Kecu2nmpjuvlaSOo3sjU1vv2/3iPtbE7sEXbbFLmbVhabTsPhrzA6b1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KdRlC2NC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KdRlC2NC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E91FF1ED267;
	Wed,  3 Apr 2024 15:35:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+GJsjX3Qyf67nmxGFr5K3Pu5sU1Y/YLh/+4P5v
	L9pxQ=; b=KdRlC2NCZ+XMZeFlS+gMQMb46UBWNArl1demVn9EyuMwQYZcdfwe7p
	l+xIeua9msf/ixApyzqmRzNTPrWAs5KJ/vAe3UdC35icNJI5ESEydrLPfgfY7PpZ
	Zy/Lhp16D2+IAQQE8uD6CH/NJlcv9g+bzt8v1iCmDBM+YCcJb0pto=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E04E21ED266;
	Wed,  3 Apr 2024 15:35:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 362771ED263;
	Wed,  3 Apr 2024 15:35:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] reftable/block: reuse zstream when writing log blocks
In-Reply-To: <86dab54dfe4501dfa5e50e5a01513c890b62bb4d.1712078736.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 2 Apr 2024 19:30:16 +0200")
References: <cover.1712078736.git.ps@pks.im>
	<86dab54dfe4501dfa5e50e5a01513c890b62bb4d.1712078736.git.ps@pks.im>
Date: Wed, 03 Apr 2024 12:35:22 -0700
Message-ID: <xmqqplv65jet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 50575E9E-F1F1-11EE-BB59-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> @@ -139,39 +143,60 @@ int block_writer_finish(struct block_writer *w)
>  	w->next += 2;
>  	put_be24(w->buf + 1 + w->header_off, w->next);
>  
> +	/*
> +	 * Log records are stored zlib-compressed. Note that the compression
> +	 * also spans over the restart points we have just written.
> +	 */
>  	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
>  		int block_header_skip = 4 + w->header_off;
> +		uLongf src_len = w->next - block_header_skip, compressed_len;
> +		unsigned char *compressed;
> +		int ret;
> +
> +		ret = deflateReset(w->zstream);
> +		if (ret != Z_OK)
> +			return REFTABLE_ZLIB_ERROR;
> +
> +		/*
> +		 * Precompute the upper bound of how many bytes the compressed
> +		 * data may end up with. Combined with `Z_FINISH`, `deflate()`
> +		 * is guaranteed to return `Z_STREAM_END`.
> +		 */
> +		compressed_len = deflateBound(w->zstream, src_len);
> +		REFTABLE_ALLOC_ARRAY(compressed, compressed_len);

OK.

> +		w->zstream->next_out = compressed;
> +		w->zstream->avail_out = compressed_len;
> +		w->zstream->next_in = w->buf + block_header_skip;
> +		w->zstream->avail_in = src_len;
> +
> +		/*
> +		 * We want to perform all decompression in a single
> +		 * step, which is why we can pass Z_FINISH here. Note
> +		 * that both `Z_OK` and `Z_BUF_ERROR` indicate that we
> +		 * need to retry according to documentation.
> +		 *
> +		 * If the call fails we retry with a bigger output
> +		 * buffer.
> +		 */

I am not sure where the retry is happening, though.

block_writer_finish() is called by writer_flush_nonempty_block()
which returns a negative return to its caller, which is
writer_flush_block().  writer_flush_block() in turn returns a
negative return to its callers from writer_add_record(),
write_finish_section(), and write_object_record().  Nobody seems to
react to REFTABLE_ZLIB_ERROR (other than the reftable/error.c that
stringifies the error for messages).

But we have asked deflateBound() so if we did not get Z_STREAM_END,
wouldn't it mean some data corruption that retrying would not help?

> +		ret = deflate(w->zstream, Z_FINISH);
> +		if (ret != Z_STREAM_END) {
>  			reftable_free(compressed);
> -			break;
> +			return REFTABLE_ZLIB_ERROR;
>  		}
> +
> +		/*
> +		 * Overwrite the uncompressed data we have already written and
> +		 * adjust the `next` pointer to point right after the
> +		 * compressed data.
> +		 */
> +		memcpy(w->buf + block_header_skip, compressed,
> +		       w->zstream->total_out);
> +		w->next = w->zstream->total_out + block_header_skip;
> +
> +		reftable_free(compressed);
>  	}
> +
>  	return w->next;
>  }

OK.

> @@ -425,6 +450,8 @@ int block_reader_seek(struct block_reader *br, struct block_iter *it,
>  
>  void block_writer_release(struct block_writer *bw)
>  {
> +	deflateEnd(bw->zstream);
> +	FREE_AND_NULL(bw->zstream);
>  	FREE_AND_NULL(bw->restarts);
>  	strbuf_release(&bw->last_key);
>  	/* the block is not owned. */
> diff --git a/reftable/block.h b/reftable/block.h
> index 47acc62c0a..1375957fc8 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -18,6 +18,7 @@ license that can be found in the LICENSE file or at
>   * allocation overhead.
>   */
>  struct block_writer {
> +	z_stream *zstream;
>  	uint8_t *buf;
>  	uint32_t block_size;
>  
> diff --git a/reftable/writer.c b/reftable/writer.c
> index d347ec4cc6..51e663bb19 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -153,6 +153,10 @@ void reftable_writer_free(struct reftable_writer *w)
>  {
>  	if (!w)
>  		return;
> +	if (w->block_writer) {
> +		block_writer_release(w->block_writer);
> +		w->block_writer = NULL;
> +	}

This smells like an orthogonal fix to an unrelated resource leakage?

>  	reftable_free(w->block);
>  	reftable_free(w);
>  }

Thanks.
