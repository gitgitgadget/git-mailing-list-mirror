Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BFC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EF764FA9
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBDVZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:25:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54548 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBDVZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:25:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29A0E123922;
        Thu,  4 Feb 2021 16:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=33D+ouKUfobxZJavSlc/GH3V3ig=; b=CJPbdC
        1YAU3dLR7hat4ve7iVqyKzz2pey16pBEDpY8FeRNuYlCKElAAWWZR6DqkpflEt6z
        iCsAZltDR/1TIAYWO4FIFhV+AHytal7nuKfDHUC2ZwdKC5b4lgp4b00Wh0pNb/Qt
        dpzpLEAoDyVNeRMEzV+Z8zn3aoBlpq5Nlopc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jAmL5WeKF8O4QiejXUJMkTDUVHPLaaWc
        aNvlcPHYdRP8Q5XeGl0FJlqWY1nhQPWXhNQxcExE7Ezokc4SdWSDRQu40Py0tbTM
        eXYIwVhgL29si88RND3Do+EzOoQmU1etDnJbyGD3XuDC0qccKv9ui2uSmU86Za45
        qs387Vec2AY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 221BA123921;
        Thu,  4 Feb 2021 16:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA1D012391E;
        Thu,  4 Feb 2021 16:24:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 02/17] chunk-format: create chunk format write API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <814512f216719d89f41822753d5c71df5e49385d.1611759716.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 13:24:12 -0800
In-Reply-To: <814512f216719d89f41822753d5c71df5e49385d.1611759716.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 27 Jan 2021
        15:01:41 +0000")
Message-ID: <xmqq5z375xxf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 544344BE-672F-11EB-9A5C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * When writing a chunk-based file format, collect the chunks in
> + * an array of chunk_info structs. The size stores the _expected_
> + * amount of data that will be written by write_fn.
> + */
> +struct chunk_info {
> +	uint32_t id;
> +	uint64_t size;
> +	chunk_write_fn write_fn;
> +};
> +...
> +void add_chunk(struct chunkfile *cf,
> +	       uint64_t id,
> +	       chunk_write_fn fn,
> +	       size_t size)
> +{
> +	ALLOC_GROW(cf->chunks, cf->chunks_nr + 1, cf->chunks_alloc);
> +
> +	cf->chunks[cf->chunks_nr].id = id;
> +	cf->chunks[cf->chunks_nr].write_fn = fn;
> +	cf->chunks[cf->chunks_nr].size = size;
> +	cf->chunks_nr++;
> +}

Somebody somewhere between the caller in the higher part of the
callchain (that has to work with platform native types) and the
on-disk format at the bottom of the callchain (that has to work
with fixed size data fields) needs to make sure that the size that
the higher level caller has fits on-disk data structure we define,
and the data we read from disk fits the in-core structure our caller
use on the reading side.

If there is a function at the one level closer to the disk than
"struct chunk_info" that takes a "struct chunk_info" and writes the
id and size to disk (and fills "struct chunk_info" from what is read
from the disk, on the reading side), it would be a good place to do
the size_t to uint64_t conversion.

It is OK to do the conversion-while-checking in add_chunk(), too.

But a silent type casting from size_t to uint64_t done silently by
assignment bothers me.  Also, I think you meant to make the incoming
ID uint32_t; am I missing something, or did nobody notice it in the
review of the previous round?

> +int write_chunkfile(struct chunkfile *cf, void *data)
> +{
> +	int i;
> +	size_t cur_offset = cf->f->offset + cf->f->total;

That ought to be off_t, as it is a seek position inside a file
(struct hashfile.total is already off_t).

Use csum-file.h::hashfile_total() instead, perhaps?  .offset member
is an implementation detail of the hashfile API (i.e. some leftover
bits are kept in in-core buffer, until we accumulate enough to make
it worth flushing to the disk), and by using the helper, this code
does not have to know about it.

> +	/* Add the table of contents to the current offset */
> +	cur_offset += (cf->chunks_nr + 1) * CHUNK_LOOKUP_WIDTH;

Is that 12 == sizeof(chunk_info.id) + sizeof(chunk_info.size)?
If so, this makes sense.

> +	for (i = 0; i < cf->chunks_nr; i++) {
> +		hashwrite_be32(cf->f, cf->chunks[i].id);
> +		hashwrite_be64(cf->f, cur_offset);
> +
> +		cur_offset += cf->chunks[i].size;
> +	}
> +
> +	/* Trailing entry marks the end of the chunks */
> +	hashwrite_be32(cf->f, 0);
> +	hashwrite_be64(cf->f, cur_offset);

OK.  This helper does not tell us anything about what comes in the
on-disk file before this point, but we write a table of contents
that says "chunk with this ID has this size, chunk with that ID has
that size, ...", concluded by something that looks like another
entry with chunk ID 0 that records the current offset as its size.

> +	for (i = 0; i < cf->chunks_nr; i++) {
> +		uint64_t start_offset = cf->f->total + cf->f->offset;

Likewise about the type and use of hashfile_total().

> +		int result = cf->chunks[i].write_fn(cf->f, data);
> +
> +		if (result)
> +			return result;
> +
> +		if (cf->f->total + cf->f->offset - start_offset != cf->chunks[i].size)
> +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
> +			    cf->chunks[i].size, cf->chunks[i].id,
> +			    cf->f->total + cf->f->offset - start_offset);

I won't complain, as this apparently is sufficient to abstract out
the two existing chunked format files, but it somehow feels a bit
limiting that the one that calls add_chunk() is required to know
what the size of generated data would be, way before .write_fn() is
called to produce the actual data here.

> +	}
> +
> +	return 0;
> +}
> diff --git a/chunk-format.h b/chunk-format.h
> new file mode 100644
> index 00000000000..bfaed672813
> --- /dev/null
> +++ b/chunk-format.h
> @@ -0,0 +1,20 @@
> +#ifndef CHUNK_FORMAT_H
> +#define CHUNK_FORMAT_H
> +
> +#include "git-compat-util.h"
> +
> +struct hashfile;
> +struct chunkfile;
> +
> +struct chunkfile *init_chunkfile(struct hashfile *f);
> +void free_chunkfile(struct chunkfile *cf);
> +int get_num_chunks(struct chunkfile *cf);
> +typedef int (*chunk_write_fn)(struct hashfile *f,
> +			      void *data);

Write this on a single line.

> +void add_chunk(struct chunkfile *cf,
> +	       uint64_t id,
> +	       chunk_write_fn fn,
> +	       size_t size);

Shouldn't this match the order of members in chunk_info struct?

> +int write_chunkfile(struct chunkfile *cf, void *data);
> +
> +#endif
