Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC267C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8736664E4B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhBQRLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:11:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:35914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234315AbhBQRLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 12:11:43 -0500
Received: (qmail 19117 invoked by uid 109); 17 Feb 2021 17:11:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 17:11:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6240 invoked by uid 111); 17 Feb 2021 17:11:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 12:11:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 12:11:00 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 7/8] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <YC1OJDFXPnxGMHPK@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <f1c07324f62cf4d087c41165cefed98f554cfd78.1612411124.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1c07324f62cf4d087c41165cefed98f554cfd78.1612411124.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:59:21PM -0500, Taylor Blau wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index fbd7b54d70..b2ba5aa14f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1225,9 +1225,9 @@ static int want_found_object(const struct object_id *oid, int exclude,
>  		 */
>  		unsigned flags = 0;
>  		if (ignore_packed_keep_on_disk)
> -			flags |= ON_DISK_KEEP_PACKS;
> +			flags |= CACHE_ON_DISK_KEEP_PACKS;
>  		if (ignore_packed_keep_in_core)
> -			flags |= IN_CORE_KEEP_PACKS;
> +			flags |= CACHE_IN_CORE_KEEP_PACKS;

Why are we renaming the constants in this patch?

I know I'm listed as the author, but I think this came out of some
off-list back and forth between us. It seems like the existing constants
would have been fine.

> +static void maybe_invalidate_kept_pack_cache(struct repository *r,
> +					     unsigned flags)
>  {
> -	return find_one_pack_entry(r, oid, e, 0);
> +	if (!r->objects->kept_pack_cache)
> +		return;
> +	if (r->objects->kept_pack_cache->flags == flags)
> +		return;
> +	free(r->objects->kept_pack_cache->packs);
> +	FREE_AND_NULL(r->objects->kept_pack_cache);
> +}

OK, so we keep a single cache based on the flags, and then if somebody
ever asks for different flags, we throw it away. That's probably OK for
our purposes, since we wouldn't expect multiple callers within a single
process.

I wondered if it would be simpler to just keep two lists, one for
in-core keeps and one for on-disk keeps. And then just walk over each
list separately based on the query flags. That makes things more robust
_and_ I think would be less code. It does mean that a pack could appear
in both lists, though, which means we might do a lookup in it twice.
That doesn't seem all that likely, but it is working against our goal
here.

Another option is to keep 3 caches (two separate and one combined),
rather than flipping between them. I'm not sure if that would be less
code or not (it gets rid of the "invalidate" function, but you do have
to pick the right cache depending on the query flags).

Yet another option is to keep a cache of any that are marked as _either_
in core or on-disk keeps, and then decide to look up the object based on
the query flags. Then you just pay the cost to iterate over the list and
check the flags (which really is all this cache is helping with in the
first place).

I dunno. TBH, I kind of wonder if this whole patch is worth doing at
all, giving the underwhelming performance benefit (3% on the
pathological 1000-pack case). When I had timed this strategy initially,
it was more like 15%. I'm not sure where the savings went in the
interim, or if it was a timing fluke.

> +static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
> +{
> +	maybe_invalidate_kept_pack_cache(r, flags);
> +
> +	if (!r->objects->kept_pack_cache) {
> +		struct packed_git **packs = NULL;
> +		size_t nr = 0, alloc = 0;
> +		struct packed_git *p;
> +
> +		/*
> +		 * We want "all" packs here, because we need to cover ones that
> +		 * are used by a midx, as well. We need to look in every one of
> +		 * them (instead of the midx itself) to cover duplicates. It's
> +		 * possible that an object is found in two packs that the midx
> +		 * covers, one kept and one not kept, but the midx returns only
> +		 * the non-kept version.
> +		 */
> +		for (p = get_all_packs(r); p; p = p->next) {
> +			if ((p->pack_keep && (flags & CACHE_ON_DISK_KEEP_PACKS)) ||
> +			    (p->pack_keep_in_core && (flags & CACHE_IN_CORE_KEEP_PACKS))) {
> +				ALLOC_GROW(packs, nr + 1, alloc);
> +				packs[nr++] = p;
> +			}
> +		}
> +		ALLOC_GROW(packs, nr + 1, alloc);
> +		packs[nr] = NULL;
> +
> +		r->objects->kept_pack_cache = xmalloc(sizeof(*r->objects->kept_pack_cache));
> +		r->objects->kept_pack_cache->packs = packs;
> +		r->objects->kept_pack_cache->flags = flags;
> +	}

Is there any reason not to just embed the kept_pack_cache struct inside
the object_store? It's one less pointer to deal with. I wonder if this
is a holdover from an attempt to have multiple caches.

(I also think it would be reasonable if we wanted to hide the definition
of the cache struct from callers, but we don't seem do to that).

> @@ -2109,7 +2123,8 @@ int has_object_pack(const struct object_id *oid)
>  	return find_pack_entry(the_repository, oid, &e);
>  }
>  
> -int has_object_kept_pack(const struct object_id *oid, unsigned flags)
> +int has_object_kept_pack(const struct object_id *oid,
> +			 unsigned flags)
>  {
>  	struct pack_entry e;
>  	return find_kept_pack_entry(the_repository, oid, flags, &e);

This seems like a stray change.

> diff --git a/packfile.h b/packfile.h
> index 624327f64d..eb56db2a7b 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -161,10 +161,6 @@ int packed_object_info(struct repository *r,
>  void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
>  const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
>  
> -#define ON_DISK_KEEP_PACKS 1
> -#define IN_CORE_KEEP_PACKS 2
> -#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)

I notice that when the constants moved, we didn't keep an equivalent of
ALL_KEEP_PACKS. Maybe we didn't need it in the first place in patch 1?

  BTW, I absolutely hate the complication that all of this on-disk
  versus in-core keep distinction brings to this code. And I wondered
  what it was really doing for us and whether we could get rid of it.
  But I think we do need it: a common case may be to avoid using
  --honor-pack-keep (because you don't want to deal with racy .keep
  writes from incoming receive-pack processes), but use in-core ones for
  something like --stdin-packs. So we do need to respect one and not the
  other.

  I do wonder if things would be simpler if pack-objects simply kept its
  own list of "in core" packs in a separate array. But that is really
  just another form of the same problem, I guess.

-Peff
