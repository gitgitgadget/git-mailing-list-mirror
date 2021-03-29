Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C4C433E3
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C2961968
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhC2MBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:01:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:35422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhC2MBA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:01:00 -0400
Received: (qmail 10506 invoked by uid 109); 29 Mar 2021 12:01:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 12:01:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13089 invoked by uid 111); 29 Mar 2021 12:00:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 08:00:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 08:00:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 08/16] midx: allow marking a pack as preferred
Message-ID: <YGHBe1ZB/iCRpqgD@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <30194a6786bec51e0f41de0e6c855dc2297806c6.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30194a6786bec51e0f41de0e6c855dc2297806c6.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:07PM -0500, Taylor Blau wrote:

> To encourage the pack selection process to prefer one pack over another
> (the pack to be preferred is the one a caller would like to later use as
> a reuse pack), introduce the concept of a "preferred pack". When
> provided, the MIDX code will always prefer an object found in a
> preferred pack over any other.
> 
> No format changes are required to store the preferred pack, since it
> will be able to be inferred with a corresponding MIDX bitmap, by looking
> up the pack associated with the object in the first bit position (this
> ordering is described in detail in a subsequent commit).

I think in the long run we may want to add a midx chunk that gives the
order of the packs (and likewise allow the caller of "midx write" to
specify the exact order), since that may allow correlating locality
between history and object order within the .rev/.bitmap files.

But I think this is a nice stopping point for this series, since we're
not having to introduce any new on-disk formats to do it, and it seems
to give pretty good results in practice. I guess we'll have to support
--preferred-pack forever, but that's OK. Even if we do eventually
support arbitrary orderings, it's just a simple subset of that
functionality.

>  static int cmd_multi_pack_index_write(int argc, const char **argv)
>  {
> -	struct option *options = common_opts;
> +	struct option *options;
> +	static struct option builtin_multi_pack_index_write_options[] = {
> +		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
> +			   N_("preferred-pack"),
> +			   N_("pack for reuse when computing a multi-pack bitmap")),
> +		OPT_END(),
> +	};
> +
> +	options = parse_options_dup(builtin_multi_pack_index_write_options);
> +	options = add_common_options(options);
>  
>  	trace2_cmd_mode(argv[0]);
>  
> @@ -74,7 +85,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  		usage_with_options(builtin_multi_pack_index_write_usage,
>  				   options);
>  
> -	return write_midx_file(opts.object_dir, opts.flags);
> +	return write_midx_file(opts.object_dir, opts.preferred_pack,
> +			       opts.flags);
>  }

This has the same leak of "options" that I mentioned in the earlier
patch.

> diff --git a/midx.c b/midx.c
> index 971faa8cfc..46f55ff6cf 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -431,6 +431,24 @@ static int pack_info_compare(const void *_a, const void *_b)
>  	return strcmp(a->pack_name, b->pack_name);
>  }
>  
> +static int lookup_idx_or_pack_name(struct pack_info *info,
> +				   uint32_t nr,
> +				   const char *pack_name)
> +{
> +	uint32_t lo = 0, hi = nr;
> +	while (lo < hi) {
> +		uint32_t mi = lo + (hi - lo) / 2;
> +		int cmp = cmp_idx_or_pack_name(pack_name, info[mi].pack_name);
> +		if (cmp < 0)
> +			hi = mi;
> +		else if (cmp > 0)
> +			lo = mi + 1;
> +		else
> +			return mi;
> +	}
> +	return -1;
> +}

Could this just be replaced with bsearch() in the caller?

> +test_expect_success 'midx picks objects from preferred pack' '
> +	test_when_finished rm -rf preferred.git &&
> +	git init --bare preferred.git &&
> +	(
> +		cd preferred.git &&
> +
> +		a=$(echo "a" | git hash-object -w --stdin) &&
> +		b=$(echo "b" | git hash-object -w --stdin) &&
> +		c=$(echo "c" | git hash-object -w --stdin) &&
> +
> +		# Set up two packs, duplicating the object "B" at different
> +		# offsets.
> +		git pack-objects objects/pack/test-AB <<-EOF &&
> +		$a
> +		$b
> +		EOF
> +		bc=$(git pack-objects objects/pack/test-BC <<-EOF
> +		$b
> +		$c
> +		EOF
> +		) &&

I don't think pack-objects guarantees that the pack ordering matches the
input it received. compute_write_order() uses a variety of heuristics to
reorder things. I think this will work in practice with the current
code, because the objects have the same type, there are no deltas, and
the fallback ordering is input-order (or traversal order, if --revs is
used).

So it's probably OK in practice, though if we wanted to be paranoid we
could check that show-index produces different results for the $b entry
of both packs. That said...

> +		git multi-pack-index --object-dir=objects \
> +			write --preferred-pack=test-BC-$bc.idx 2>err &&
> +		test_must_be_empty err &&
> +
> +		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
> +			cut -d" " -f1) &&
> +		midx_expect_object_offset $b $ofs objects
> +	)

...what we really care about is that the object came from BC. And we are
just using the offset as a proxy for that. But doesn't "test-tool
read-midx" give us the actual pack name? We could just be checking that.

I also wondered if we should confirm that without the --preferred-pack
option, we choose the other pack. I think it will always be true because
the default order is to sort them lexically. A comment to that effect
might be worth it (near the "set up two packs" comment).

-Peff
