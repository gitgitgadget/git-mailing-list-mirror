Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DBB37E310
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774912552; cv=none; b=fcpAEDzRZdpjVE4L8Hm7EXm+6ysvc1QSAWbDRIhMSa8vxfo+X8VDaguZbzIj6Huad0btyxjkxXJk23WzNH0nsjniVI5wZHctVlLrxe02lRPajPog5s2no0Q6IVMrbV+SiKqbyaESWMM1ze9IGzHKzduDRW86PG6tXgokWDtdPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774912552; c=relaxed/simple;
	bh=Xwrp6DW+27yBAY0WMSSe9CUS2hYQwMlrGzkmwS0M2J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX6LrK9qaiL+dAzZttqi0Pg+zXaEbT4FboL9S0qvIFnZrZh6jokTY2wivtutStB2LOKPJrvGBP8SimESdT5Po2SItU/ew//MGS4HCRHiye22kMhoYFrtnqk3+WFbFnkHMrdqfUFXbwDVmEHFsuz3v0ZyU08R1Za0vV+9jBUb/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ExMDQQCT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ExMDQQCT"
Received: (qmail 199445 invoked by uid 106); 30 Mar 2026 23:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Xwrp6DW+27yBAY0WMSSe9CUS2hYQwMlrGzkmwS0M2J0=; b=ExMDQQCTRc+MnR19aEzU1uFX8KHbqNkrd3Iq2hgKSWhHDFiSawXoetwiBnERG9CjsMT6ZH4AdSuKInAQKAACsDwSfgzVo2xgagKJ5eKjPecks7b26ea4AOfoC3pE1CNmeW17xFfiLASBlD3cOfBD+mOHtKfwxFax3xywSCdUv0OjbK5Hk/8Np9jkVTv70zbByq4EQz060zl4EZtrdS+KSlNSvZpycf5fhJuKCTUxHJrDjda2+DMYdyNo5bRu2rwUjAMdF4Vjk/JO/AfQx0ECr7LeiZPbsrPzZz0rcO9+ybvxSluVc8g2LcmMZqEJT+ijLIpOuFoh64ELPDDm4AWtpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Mar 2026 23:15:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 306714 invoked by uid 111); 30 Mar 2026 23:15:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2026 19:15:47 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Mar 2026 19:15:47 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/16] midx: introduce `--checksum-only` for incremental
 MIDX writes
Message-ID: <20260330231547.GE41843@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <41cb5471bb96d38a1b9ae75d022e2c5356318939.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41cb5471bb96d38a1b9ae75d022e2c5356318939.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:03PM -0400, Taylor Blau wrote:

> When writing an incremental MIDX layer, the MIDX machinery writes the
> new layer into the multi-pack-index.d directory and then updates the
> multi-pack-index-chain file to include the freshly written layer.
> 
> Future callers however may not wish to immediately update the MIDX chain
> itself, preferring instead to write out new layer(s) themselves before
> atomically updating the chain. Concretely, the new incremental
> MIDX-based repacking strategy will want to do exactly this (that is,
> assemble the new MIDX chain itself before writing a new chain file and
> atomically linking it into place).
> 
> Introduce a `--checksum-only` flag that:
> 
>  * writes the new MIDX layer into the multi-pack-index.d directory
> 
>  * prints its checksum
> 
>  * does not update the multi-pack-index-chain file.

Your goal makes sense, but that is not at all what I would have expected
a "--checksum-only" option to do. From the name I expected it to just
compute or verify checksums and not write anything to disk. I dunno.
Maybe it should be "--no-write-chain-file" or something?

This is perhaps on the border of bike-shedding, and maybe the fact that
it is an option of "multi-pack-index write" would be enough to clarify.

> @@ -221,6 +233,9 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
>  			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
>  		OPT_BIT(0, "incremental", &opts.flags,
>  			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
> +		OPT_BIT(0, "checksum-only", &opts.flags,
> +			N_("write a MIDX layer without updating the MIDX chain"),
> +			MIDX_WRITE_CHECKSUM_ONLY),
>  		OPT_END(),
>  	};
>  
> @@ -239,6 +254,15 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
>  	if (argc != 2)
>  		usage_with_options(builtin_multi_pack_index_compact_usage,
>  				   options);
> +
> +	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
> +	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
> +		error(_("cannot use %s without %s"),
> +		      "--checksum-only", "--incremental");
> +		usage_with_options(builtin_multi_pack_index_compact_usage,
> +				   options);
> +	}
> +

OK. It's sad that we have to duplicate these bits between the write and
compact operations, but I'm not sure how much sense it would make to
factor out common options (both how much work it is, and how much
duplication we could actually drop in practice).

>  	source = handle_object_dir_option(the_repository);
>  
>  	FREE_AND_NULL(options);
> diff --git a/midx-write.c b/midx-write.c
> index 9f7d2bbf4cb..2c6905173ba 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1600,11 +1600,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	}
>  
>  	if (ctx.incremental) {
> -		struct strbuf lock_name = STRBUF_INIT;
> +		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
> +			struct strbuf lock_name = STRBUF_INIT;
>  
> -		get_midx_chain_filename(opts->source, &lock_name);
> -		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
> -		strbuf_release(&lock_name);
> +			get_midx_chain_filename(opts->source, &lock_name);
> +			hold_lock_file_for_update(&lk, lock_name.buf,
> +						  LOCK_DIE_ON_ERROR);
> +			strbuf_release(&lock_name);
> +		}

OK, we skip the chain-file write here (or least the start of it).

> @@ -1725,14 +1728,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	}
>  	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
>  
> +	if (opts->flags & MIDX_WRITE_CHECKSUM_ONLY)
> +		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));

And then output the hash here instead.

Just thinking on the name I suggested, it implies the action from the
first hunk above, but not this one (whereas your name sort of does the
opposite). I don't think there is any reason to have _two_ options,
since you'd always want to do them together (or not at all). I still
like my suggestion better. ;)


>  	if (ctx.incremental) {
> -		FILE *chainf = fdopen_lock_file(&lk, "w");
>  		struct strbuf final_midx_name = STRBUF_INIT;
>  		struct multi_pack_index *m = ctx.base_midx;
>  
> -		if (!chainf) {
> -			error_errno(_("unable to open multi-pack-index chain file"));
> -			goto cleanup;
> +		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
> +			FILE *chainf = fdopen_lock_file(&lk, "w");
> +			if (!chainf) {
> +				error_errno(_("unable to open multi-pack-index chain file"));
> +				goto cleanup;
> +			}
>  		}

OK, and this is the actual write which is skipped. I guess this could
also be conditional on is_lock_file_locked(&lk), assuming we initialize
it with LOCK_INIT. In some ways that seems easier to analyze to me,
since you don't have to realize that "lk" is only active when
CHECKSUM_ONLY is not set. But I don't think there's another reason we'd
choose not to take a lock file, so I think it may be six of one and half
a dozen of the other.

> @@ -1793,8 +1801,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  			}
>  		}
>  
> -		for (uint32_t i = 0; i < keep_hashes_nr; i++)
> -			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
> +		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY))
> +			for (uint32_t i = 0; i < keep_hashes_nr; i++)
> +				fprintf(get_lock_file_fp(&lk), "%s\n",
> +					keep_hashes.v[i]);
>  	} else {
>  		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
>  			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
> @@ -1804,10 +1814,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	if (ctx.m || ctx.base_midx)
>  		odb_close(ctx.repo->objects);
>  
> -	if (commit_lock_file(&lk) < 0)
> -		die_errno(_("could not write multi-pack-index"));
> +	if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
> +		if (commit_lock_file(&lk) < 0)
> +			die_errno(_("could not write multi-pack-index"));
>  
> -	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
> +		clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
> +	}
>  	result = 0;

Ditto on these conditionals.

I'm out of time to keep reviewing, so I'll stop here for now. I'll try
to continue with the rest late tonight or tomorrow.

-Peff
