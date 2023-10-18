Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA191FC5
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HSmvXtFE"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78CAB
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:18:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AFFE930490;
	Tue, 17 Oct 2023 22:18:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TrXkZM70Ce80XdfXxjFHmqVPGuUmxyL7mlJZgy
	Xo4H0=; b=HSmvXtFELKTwfTL0GFGxzz3P82V+tvB/VOkZY1oJqIdyMo5uI3k7fH
	n8cW1TtM/JUvg3R5HW7WBMLlt4jtXgLo0yxbqzXmJvrByexTWd6uBPEeJt+XWwva
	i62XaSiJ+MXuqsOq/c10HwWmkvyNEd1jJQQ3NSefwZQdmZNLV29EE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A9D953048F;
	Tue, 17 Oct 2023 22:18:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A2C83048E;
	Tue, 17 Oct 2023 22:18:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/7] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
In-Reply-To: <239bf39bfb21ef621a15839bade34446dcbc3103.1697560266.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 17 Oct 2023 12:31:26 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
	<cover.1697560266.git.me@ttaylorr.com>
	<239bf39bfb21ef621a15839bade34446dcbc3103.1697560266.git.me@ttaylorr.com>
Date: Tue, 17 Oct 2023 19:18:04 -0700
Message-ID: <xmqq5y34wu5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 92CFA00C-6D5C-11EE-8BAE-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Taylor Blau <me@ttaylorr.com> writes:

>  bulk-checkin.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
>  bulk-checkin.h |   4 ++
>  2 files changed, 122 insertions(+)

Unlike the previous four, which were very clear refactoring to
create reusable helper functions, this step leaves a bad aftertaste
after reading twice, and I think what is disturbing is that many new
lines are pretty much literally copied from stream_blob_to_pack().

I wonder if we can introduce an "input" source abstraction, that
replaces "fd" and "size" (and "path" for error reporting) parameters
to the stream_blob_to_pack(), so that the bulk of the implementation
of stream_blob_to_pack() can call its .read() method to read bytes
up to "size" from such an abstracted interface?  That would be a
good sized first half of this change.  Then in the second half, you
can add another "input" source that works with in-core "buf" and
"size", whose .read() method will merely be a memcpy().

That way, we will have two functions, one for stream_obj_to_pack()
that reads from an open file descriptor, and the other for
stream_obj_to_pack_incore() that reads from an in-core buffer,
sharing the bulk of the implementation that is extracted from the
current code, which hopefully be easier to audit.

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index f4914fb6d1..25cd1ffa25 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -140,6 +140,69 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
>  	return 0;
>  }
>  
> +static int stream_obj_to_pack_incore(struct bulk_checkin_packfile *state,
> +				     git_hash_ctx *ctx,
> +				     off_t *already_hashed_to,
> +				     const void *buf, size_t size,
> +				     enum object_type type,
> +				     const char *path, unsigned flags)
> +{
> +	git_zstream s;
> +	unsigned char obuf[16384];
> +	unsigned hdrlen;
> +	int status = Z_OK;
> +	int write_object = (flags & HASH_WRITE_OBJECT);
> +
> +	git_deflate_init(&s, pack_compression_level);
> +
> +	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
> +	s.next_out = obuf + hdrlen;
> +	s.avail_out = sizeof(obuf) - hdrlen;
> +
> +	if (*already_hashed_to < size) {
> +		size_t hsize = size - *already_hashed_to;
> +		if (hsize) {
> +			the_hash_algo->update_fn(ctx, buf, hsize);
> +		}
> +		*already_hashed_to = size;
> +	}
> +	s.next_in = (void *)buf;
> +	s.avail_in = size;
> +
> +	while (status != Z_STREAM_END) {
> +		status = git_deflate(&s, Z_FINISH);
> +		if (!s.avail_out || status == Z_STREAM_END) {
> +			if (write_object) {
> +				size_t written = s.next_out - obuf;
> +
> +				/* would we bust the size limit? */
> +				if (state->nr_written &&
> +				    pack_size_limit_cfg &&
> +				    pack_size_limit_cfg < state->offset + written) {
> +					git_deflate_abort(&s);
> +					return -1;
> +				}
> +
> +				hashwrite(state->f, obuf, written);
> +				state->offset += written;
> +			}
> +			s.next_out = obuf;
> +			s.avail_out = sizeof(obuf);
> +		}
> +
> +		switch (status) {
> +		case Z_OK:
> +		case Z_BUF_ERROR:
> +		case Z_STREAM_END:
> +			continue;
> +		default:
> +			die("unexpected deflate failure: %d", status);
> +		}
> +	}
> +	git_deflate_end(&s);
> +	return 0;
> +}
> +
>  /*
>   * Read the contents from fd for size bytes, streaming it to the
>   * packfile in state while updating the hash in ctx. Signal a failure
> @@ -316,6 +379,50 @@ static void finalize_checkpoint(struct bulk_checkin_packfile *state,
>  	}
>  }
>  
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
> +
> +	/* Note: idx is non-NULL when we are writing */
> +	if (flags & HASH_WRITE_OBJECT)
> +		CALLOC_ARRAY(idx, 1);
> +
> +	while (1) {
> +		prepare_checkpoint(state, checkpoint, idx, flags);
> +		if (!stream_obj_to_pack_incore(state, ctx, &already_hashed_to,
> +					       buf, size, type, path, flags))
> +			break;
> +		truncate_checkpoint(state, checkpoint, idx);
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
> @@ -396,6 +503,17 @@ int index_blob_bulk_checkin(struct object_id *oid,
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
