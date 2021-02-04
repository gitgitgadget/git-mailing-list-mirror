Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD84C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CBD64E0F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhBDXlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 18:41:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52852 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhBDXk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 18:40:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4CDD1246E5;
        Thu,  4 Feb 2021 18:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYvv2n5HDy5pq5qMuS36My4Kah8=; b=F3+jp2
        G8msnBMBeqWWJDyRknhMbUcQ6C/4QkyqBO5PK7hnfYPji6GfA/G+jvsN5PQneLQS
        b8nHd+af7y7PIs9WpHpG36LO0jJtta7h2+DP8ON4C8W8LfuYMSy08PIOYxWLqT7H
        6cz9Qx7t+WWpgnurungTMF39tz2YFMzJS52NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OIbteZm7fIV/unu0OCPh4UYBwjieEcu5
        a35UpcOX3DXA+bbgK7y96P/mghbN8VqYQxiQsblXy18wPNrnhzrGJ42E0qqylJUy
        uBqZzAcX7fV0atOHPPtPmo+2lyZz7QOpa9lSJMXg9TCLiimGKzlaoOn7wZFAMjms
        2SBuogUb8m4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C73B1246E4;
        Thu,  4 Feb 2021 18:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C53591246E2;
        Thu,  4 Feb 2021 18:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 12/17] chunk-format: create read chunk API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 15:40:03 -0800
In-Reply-To: <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 27 Jan 2021
        15:01:51 +0000")
Message-ID: <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F24A6EA-6742-11EB-AB56-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> We are re-using the anonymous 'struct chunkfile' data, as it is internal
> to the chunk-format API. This gives it essentially two modes: write and
> read. If the same struct instance was used for both reads and writes,
> then there would be failures.

Writing it here won't help future developers very much.  I think
that belongs to API/function doc for init_chunkfile().

> diff --git a/chunk-format.c b/chunk-format.c
> index ab914c55856..74501084cf8 100644
> --- a/chunk-format.c
> +++ b/chunk-format.c
> @@ -12,6 +12,8 @@ struct chunk_info {
>  	uint32_t id;
>  	uint64_t size;
>  	chunk_write_fn write_fn;
> +
> +	const void *start;
>  };
>  
>  struct chunkfile {
> @@ -89,3 +91,81 @@ int write_chunkfile(struct chunkfile *cf, void *data)
>  
>  	return 0;
>  }
> +
> +int read_table_of_contents(struct chunkfile *cf,
> +			   const unsigned char *mfile,
> +			   size_t mfile_size,
> +			   uint64_t toc_offset,
> +			   int toc_length)

It's a bit of mystery, having seen how the table-of-contents is laid
out by reading the writing side of the code, how toc_offset and
toc_length are discovered by the caller.  IIRC, the size to cover
everything from the beginning of the file to the end of the
table-of-contents was recorded as the length of a non-existent chunk
with id 0, but we need to be able to somehow find it to use that as
a way to get to the (end of) table-of-contents from the beginning of
the file.   I guess we'll learn enough when we get to read the code
that calls this function.

> +{
> +	uint32_t chunk_id;
> +	const unsigned char *table_of_contents = mfile + toc_offset;
> +
> +	ALLOC_GROW(cf->chunks, toc_length, cf->chunks_alloc);
> +
> +	while (toc_length--) {
> +		uint64_t chunk_offset, next_chunk_offset;
> +
> +		chunk_id = get_be32(table_of_contents);
> +		chunk_offset = get_be64(table_of_contents + 4);
> +
> +		if (!chunk_id) {
> +			error(_("terminating chunk id appears earlier than expected"));
> +			return 1;
> +		}
> +
> +		table_of_contents += CHUNK_LOOKUP_WIDTH;
> +		next_chunk_offset = get_be64(table_of_contents + 4);
> +
> +		if (next_chunk_offset < chunk_offset ||
> +		    next_chunk_offset > mfile_size - the_hash_algo->rawsz) {

The chunks have to be recorded in toc in the order they appear, and
there must be enough room to store the hashfile trailer checksum
after the last chunk.  OK.

> +			error(_("improper chunk offset(s) %"PRIx64" and %"PRIx64""),
> +			      chunk_offset, next_chunk_offset);
> +			return -1;
> +		}
> +
> +		cf->chunks[cf->chunks_nr].id = chunk_id;
> +		cf->chunks[cf->chunks_nr].start = mfile + chunk_offset;
> +		cf->chunks[cf->chunks_nr].size = next_chunk_offset - chunk_offset;
> +		cf->chunks_nr++;
> +	}
> +
> +	chunk_id = get_be32(table_of_contents);
> +	if (chunk_id) {
> +		error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
> +		return -1;
> +	}

Shouldn't we be validating the size component associated with this
"id=0" fake chunk that appears at the end as well?  IIRC, the size
field should be pointing at the byte immediately after the TOC entry
for the last true chunk, immediately before this zero chunk id?

> +int pair_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       const unsigned char **p)
> +{
> +	int i;
> +
> +	for (i = 0; i < cf->chunks_nr; i++) {
> +		if (cf->chunks[i].id == chunk_id) {
> +			*p = cf->chunks[i].start;
> +			return 0;
> +		}

OK, the assumption here is that there will be at most one chunk that
has the chunk_id we seek to find (or putting it differently, second
and subsequent chunks with the same ID are ignored).  We may want to
write it down somewhere.

> +	}
> +
> +	return CHUNK_NOT_FOUND;
> +}
> +
> +int read_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       chunk_read_fn fn,
> +	       void *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < cf->chunks_nr; i++) {
> +		if (cf->chunks[i].id == chunk_id)
> +			return fn(cf->chunks[i].start, cf->chunks[i].size, data);

It is curious why pair_chunk() exists in the first place.  With
something like this:

        int pair_chunk_fn(const unsigned char *chunk_start,
                          size_t chunk_size,
                          void *data)
        {
                const unsigned char **p = data;
                *p = chunk_start;
                return 0;
        }

instead of

	const unsigned char *location;

	pair_chunk(cf, chunk_id, &location);

we can write

	const unsigned char *location;

	read_chunk(cf, chunk_id, pair_chunk_fn, &location);

no?  That would allow us to reorganize the in-core TOC more easily
if it turns out to be necessary in the future.

> diff --git a/chunk-format.h b/chunk-format.h
> index bfaed672813..b62c9bf8ba1 100644
> --- a/chunk-format.h
> +++ b/chunk-format.h
> @@ -17,4 +17,37 @@ void add_chunk(struct chunkfile *cf,
>  	       size_t size);
>  int write_chunkfile(struct chunkfile *cf, void *data);
>  
> +int read_table_of_contents(struct chunkfile *cf,
> +			   const unsigned char *mfile,
> +			   size_t mfile_size,
> +			   uint64_t toc_offset,
> +			   int toc_length);
> +
> +#define CHUNK_NOT_FOUND (-2)
> +
> +/*
> + * Find 'chunk_id' in the given chunkfile and assign the
> + * given pointer to the position in the mmap'd file where
> + * that chunk begins.
> + *
> + * Returns CHUNK_NOT_FOUND if the chunk does not exist.
> + */
> +int pair_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       const unsigned char **p);
> +
> +typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
> +			     size_t chunk_size, void *data);

Is the assumption throughout the chunked file API that reading is
actually not done as a "seek+read+process", but as a normal memory
access over mmapped region?  The reason I ask is because the answer
affects the choice of the right type for the offset.  The function
signature of read_table_of_contents() uses size_t to represent the
length of the entire mmapped region that holds the data from the
file, and that is better than off_t, especially if size_t were
smaller than off_t (i.e. we may not be able to mmap a huge size that
filesystem can handle and let us access with seek+read).

But the assumption that the whole mfile can be mmapped in as a whole
is only in read_table_of_contents(), and users of read_chunk() API
can be oblivious, I think---IOW, we could "page in" the chunk's data
in read_chunk() while the callback function works on it in-core, and
then discard it, if we wanted to change the implementation [*].

	Side note: for that to work, the API must say that the
	callback function MUST NOT assume that the memory region
	starting at chunk_start it is given will stay in memory
	after it returns.  Otherwise, we cannot "page in" and "page
	out".

I am not advocating that we should not assume the entire file can be
mapped in.  I would however advocate to be explicit in documenting
what the users of API can and cannot do (e.g. if we want the "read"
callbacks to take advantage of the fact that mfile will stay mapped
until the chunkfile is discarded, we should say so, so that they will
not make unnecessary copies out of the mmapped region).

> +/*
> + * Find 'chunk_id' in the given chunkfile and call the
> + * given chunk_read_fn method with the information for
> + * that chunk.
> + *
> + * Returns CHUNK_NOT_FOUND if the chunk does not exist.
> + */
> +int read_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       chunk_read_fn fn,
> +	       void *data);

Did I miss an update to free_chunkfile() to release resources used
to read this file?  For some reason, unlike the writing side, the
reading side of this API feels a bit incomplete to me.

Thanks.
