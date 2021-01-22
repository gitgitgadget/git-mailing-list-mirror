Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E55C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9FF523B52
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbhAVX0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:26:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:35986 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbhAVXZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 18:25:45 -0500
Received: (qmail 15372 invoked by uid 109); 22 Jan 2021 23:25:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Jan 2021 23:25:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20207 invoked by uid 111); 22 Jan 2021 23:25:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 18:25:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 18:24:59 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 2/8] pack-write.c: prepare to write 'pack-*.rev' files
Message-ID: <YAtey9krU32mgEBV@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <8648c87fa71aec427dc11afcba6548fb66a1413b.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8648c87fa71aec427dc11afcba6548fb66a1413b.1610576805.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 05:28:11PM -0500, Taylor Blau wrote:

> +static void write_rev_index_positions(struct hashfile *f,
> +				      struct pack_idx_entry **objects,
> +				      uint32_t nr_objects)
> +{
> +	uint32_t *pack_order;
> +	uint32_t i;
> +
> +	ALLOC_ARRAY(pack_order, nr_objects);
> +	for (i = 0; i < nr_objects; i++)
> +		pack_order[i] = i;
> +	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);

qsort? Don't we have a perfectly good radix sort for this exact purpose? :)

I guess it is awkward to use because it hard-codes the assumption that
we are sorting revindex_entry structs, with their offsets directly
available.

We _could_ actually just generate an in-memory revindex array, and then
use that to write out the .rev file. That has the nice property that
we'd continue exercising the fallback code in the tests.

But a revindex_entry is much larger than the uint32_t's we need here. So
we'd be incurring extra memory costs during the generation, which is
probably not worth it. If we want better test coverage, we probably
should explicitly run a series of tests both with and without a .rev
file.

It's possible we'd still benefit from using a more generalized radix
sort, but it probably isn't worth the trouble. The timings from
8b8dfd5132 (pack-revindex: radix-sort the revindex, 2013-07-11) claim a
4x speedup on sorting 3M entries (the size matters because we are
comparing an O(n) sort versus an O(n log n) one). We can imagine that at
10M entries for the current kernel, it might even be 8x. But the
absolute numbers are pretty small. The radix sort takes ~150ms for
linux.git on my machine.  At 8x, that's 1.2s. For a repack of the
kernel, that is mostly a drop in the bucket. It mattered a lot more when
many processes were doing it on the fly.

> +static int pack_order_cmp(const void *va, const void *vb, void *ctx)
> +{
> +	struct pack_idx_entry **objects = ctx;
> +
> +	off_t oa = objects[*(uint32_t*)va]->offset;
> +	off_t ob = objects[*(uint32_t*)vb]->offset;

Dereferencing a pointer to index another array always makes me nervous
that we may have a bounds problem with bogus data.

In this case we know it is OK because we filled the array ourselves with
in-bound numbers in write_rev_index_positions.

> +#define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
> +#define RIDX_VERSION 1

I was surprised we didn't define these already on the reading side, but
it looks like we didn't. In patch 1, we probably should be checking
RIDX_SIGNATURE in load_revindex_from_disk(). But much more importantly,
we should be checking that we find version 1, since that's what will
make it safe to later invent a version 2.

> +static void write_rev_header(struct hashfile *f)
> +{
> +	uint32_t oid_version;
> +	switch (hash_algo_by_ptr(the_hash_algo)) {
> +	case GIT_HASH_SHA1:
> +		oid_version = 1;
> +		break;
> +	case GIT_HASH_SHA256:
> +		oid_version = 2;
> +		break;
> +	default:
> +		die("write_rev_header: unknown hash version");
> +	}

I forgot to comment on this in patch 1, but: I think the format is
really independent of the hash size. The contents are identical for a
sha-1 versus sha-256 file.

That said, I don't overly mind having a hash identifier if it might help
debug things (OTOH, how the heck do you end up with one that matches the
trailer's packfile but  _doesn't_ match the trailer's contents?).

If we do have it, should we also be checking it in the loading function?

> +const char *write_rev_file(const char *rev_name,
> +			   struct pack_idx_entry **objects,
> +			   uint32_t nr_objects,
> +			   const unsigned char *hash,
> +			   unsigned flags)
> +{
> +	struct hashfile *f;
> +	int fd;
> +
> +	if ((flags & WRITE_REV) && (flags & WRITE_REV_VERIFY))
> +		die(_("cannot both write and verify reverse index"));
> +
> +	if (flags & WRITE_REV) {
> +		if (!rev_name) {
> +			struct strbuf tmp_file = STRBUF_INIT;
> +			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
> +			rev_name = strbuf_detach(&tmp_file, NULL);
> +		} else {
> +			unlink(rev_name);
> +			fd = open(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> +			if (fd < 0)
> +				die_errno("unable to create '%s'", rev_name);
> +		}

So if the caller gave us a name, we force-overwrite it. That seemed
weird to me at first, but it makes sense; the atomic rename-into-place
writers will not be passing in the name. And this is exactly how
write_idx_file() works.

I wonder if we could factor out some of this repeated logic, but I
suspect it is mostly diminishing returns. Maybe this "open a pack file
for writing" could become a helper function, though.

> diff --git a/pack.h b/pack.h
> index 9fc0945ac9..30439e0784 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -42,6 +42,8 @@ struct pack_idx_option {
>  	/* flag bits */
>  #define WRITE_IDX_VERIFY 01 /* verify only, do not write the idx file */
>  #define WRITE_IDX_STRICT 02
> +#define WRITE_REV 04
> +#define WRITE_REV_VERIFY 010

It is a little funny that the write-rev function has both WRITE_REV and
WRITE_REV_VERIFY (which we must be sure are not both provided), but we
do not need both for the IDX.

I thought maybe the reason is that we'd pass these flags to
write_idx_file() or similar, and it would need to know whether to write
just an idx, or both. That doesn't seem to happen in this patch, but
maybe it does in a future one...

-Peff
