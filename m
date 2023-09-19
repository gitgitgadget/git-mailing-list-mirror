Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED3CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 22:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjISWP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjISWPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 18:15:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ADFF1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:15:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EADA2DDA0;
        Tue, 19 Sep 2023 18:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Zt/m0BENZGMv+1Z5WiPsS+YoglNZIBIQODFlzX
        9mbrM=; b=NYYuxQfLStBnscMxFPYNYE4SQHTecheTxnmEG3pZnlSYl+lQ7Jrz+Z
        aPnQ/cJoM21f8xHcVl5OFW/+pygs3RRG22Wd8SZBvOc0zzjUXegoxedJVX/S2EAH
        YmAx2w+dIeX/yruKRkRmhCLk/IxOihoxEMH1jhOlbAiqEZ2q/MwmQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57ABD2DD9F;
        Tue, 19 Sep 2023 18:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF7D52DD9E;
        Tue, 19 Sep 2023 18:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] bulk-checkin: Only accept blobs
In-Reply-To: <87fs39vppo.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 19 Sep 2023 16:05:23 -0500")
References: <87fs39vppo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Tue, 19 Sep 2023 15:15:33 -0700
Message-ID: <xmqqttrperne.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E04A652-573A-11EE-8DFF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Subject: Re: [PATCH] bulk-checkin: Only accept blobs

s/Only/only/;

> As the code is written today bulk_checkin only accepts blobs.  When
> dealing with multiple hash algorithms it is necessary to distinguish
> between blobs and object types that have embedded oids.  For object
> that embed oids a completely new object needs to be generated to
> compute the compatibility hash on.  For blobs however all that is
> needed is to compute the compatibility hash on the same blob as the
> storage hash.

All of the above is understandable, but ...

> As the code will need the compatiblity hash from a bulk checkin, remove
> support for a bulk checkin of anything except blobs.

... I am not sure what the first half of this sentence is saying.
Do you mean something like:

    The function takes "enum object_type" and pretends that it could
    stream trees and commits, if we wanted to interoperate with
    multiple hash algorithms, there are a lot more information than
    just the contents and object type needed.  A tree object needs
    "compatibility hash" (i.e. the hash computed for the other hash
    functions) for objects the tree contains, a commit object
    likewise needs "compatibility hash" for its tree and its parent
    commits.  IOW, the existing interface into the functions this
    patch touches is way too narrow to be useful for object types
    other than blobs.

perhaps?  I agree with the conclusion that the functions on the
callchain involved in the bulk-checkin feature can safely be
limited to handle blobs in the current code (and I have my reasons
to think why it is not regressing the interface), but it makes me
feel uneasy that I am not quite sure what your reasoning is.

>
> Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> Apologies to anyone who has seen this before.  The last time I sent
> this patch out it seems to have disappeared into a black hole so
> I am trying again.

I do not know if vger is dropping your messages, but I haven't seen
this on https://lore.kernel.org/git/ archive, so I'll quote from the
message I am responding to everything without omitting anything, to
let others who may find out about this patch via my response.

Thanks.


>  bulk-checkin.c | 35 +++++++++++++++++------------------
>  bulk-checkin.h |  6 +++---
>  object-file.c  | 12 ++++++------
>  3 files changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 73bff3a23d27..223562b4e748 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -155,10 +155,10 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
>   * status before calling us just in case we ask it to call us again
>   * with a new pack.
>   */
> -static int stream_to_pack(struct bulk_checkin_packfile *state,
> -			  git_hash_ctx *ctx, off_t *already_hashed_to,
> -			  int fd, size_t size, enum object_type type,
> -			  const char *path, unsigned flags)
> +static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
> +			       git_hash_ctx *ctx, off_t *already_hashed_to,
> +			       int fd, size_t size, const char *path,
> +			       unsigned flags)
>  {
>  	git_zstream s;
>  	unsigned char ibuf[16384];
> @@ -170,7 +170,7 @@ static int stream_to_pack(struct bulk_checkin_packfile *state,
>  
>  	git_deflate_init(&s, pack_compression_level);
>  
> -	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
> +	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
>  	s.next_out = obuf + hdrlen;
>  	s.avail_out = sizeof(obuf) - hdrlen;
>  
> @@ -247,11 +247,10 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
>  		die_errno("unable to write pack header");
>  }
>  
> -static int deflate_to_pack(struct bulk_checkin_packfile *state,
> -			   struct object_id *result_oid,
> -			   int fd, size_t size,
> -			   enum object_type type, const char *path,
> -			   unsigned flags)
> +static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
> +				struct object_id *result_oid,
> +				int fd, size_t size,
> +				const char *path, unsigned flags)
>  {
>  	off_t seekback, already_hashed_to;
>  	git_hash_ctx ctx;
> @@ -265,7 +264,7 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
>  		return error("cannot find the current offset");
>  
>  	header_len = format_object_header((char *)obuf, sizeof(obuf),
> -					  type, size);
> +					  OBJ_BLOB, size);
>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, obuf, header_len);
>  
> @@ -282,8 +281,8 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
>  			idx->offset = state->offset;
>  			crc32_begin(state->f);
>  		}
> -		if (!stream_to_pack(state, &ctx, &already_hashed_to,
> -				    fd, size, type, path, flags))
> +		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
> +					 fd, size, path, flags))
>  			break;
>  		/*
>  		 * Writing this object to the current pack will make
> @@ -350,12 +349,12 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
>  	}
>  }
>  
> -int index_bulk_checkin(struct object_id *oid,
> -		       int fd, size_t size, enum object_type type,
> -		       const char *path, unsigned flags)
> +int index_blob_bulk_checkin(struct object_id *oid,
> +			    int fd, size_t size,
> +			    const char *path, unsigned flags)
>  {
> -	int status = deflate_to_pack(&bulk_checkin_packfile, oid, fd, size, type,
> -				     path, flags);
> +	int status = deflate_blob_to_pack(&bulk_checkin_packfile, oid, fd, size,
> +					  path, flags);
>  	if (!odb_transaction_nesting)
>  		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
>  	return status;
> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index 48fe9a6e9171..aa7286a7b3e1 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -9,9 +9,9 @@
>  void prepare_loose_object_bulk_checkin(void);
>  void fsync_loose_object_bulk_checkin(int fd, const char *filename);
>  
> -int index_bulk_checkin(struct object_id *oid,
> -		       int fd, size_t size, enum object_type type,
> -		       const char *path, unsigned flags);
> +int index_blob_bulk_checkin(struct object_id *oid,
> +			    int fd, size_t size,
> +			    const char *path, unsigned flags);
>  
>  /*
>   * Tell the object database to optimize for adding
> diff --git a/object-file.c b/object-file.c
> index 7dc0c4bfbba8..7c7afe579364 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2446,11 +2446,11 @@ static int index_core(struct index_state *istate,
>   * binary blobs, they generally do not want to get any conversion, and
>   * callers should avoid this code path when filters are requested.
>   */
> -static int index_stream(struct object_id *oid, int fd, size_t size,
> -			enum object_type type, const char *path,
> -			unsigned flags)
> +static int index_blob_stream(struct object_id *oid, int fd, size_t size,
> +			     const char *path,
> +			     unsigned flags)
>  {
> -	return index_bulk_checkin(oid, fd, size, type, path, flags);
> +	return index_blob_bulk_checkin(oid, fd, size, path, flags);
>  }
>  
>  int index_fd(struct index_state *istate, struct object_id *oid,
> @@ -2472,8 +2472,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>  				 type, path, flags);
>  	else
> -		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
> -				   flags);
> +		ret = index_blob_stream(oid, fd, xsize_t(st->st_size), path,
> +					flags);
>  	close(fd);
>  	return ret;
>  }
