Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402C2E888A
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315806; cv=none; b=g1oonpHqRpdY5NTK9Id4Nw8NYpGgso5oH2sXscl26d0JIHPC8cJXwRdmRdDmC67HSomHzT40C3lbXfpqx+ukacdFYkek7OjuLRjTyShoccgTdbnf/unZZnKt3z9GFj7sLYBhHwKwHBqplgSWCZyMgQ4vfO5cKfXuwP7ClsAxX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315806; c=relaxed/simple;
	bh=W/4HrZgF2UA0EN0EgnUlPXbMl7Xw5E5Yy2yRvRKMo00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FebjkODK2TiLhxRG5h6H4KIOA+AJaHJ+z8kyma/eFZkbhtM3U72f3ZVnjpTxo/mJpdG62h5ZoUOQgfNTS3Wrj1gMHfm0L5bxxLPCgOy5bLX8jNUcqi7tmVk4iez/+4tDv1GCnUANUQfbMErmYsfqsQa1qE2fw4whjc28QR5R8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0TzVapU8; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0TzVapU8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784315803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNh1fJO86N8dgot8pC3Cf+DwOCAhvaVPiXVsoQr/Cas=;
	b=0TzVapU833c5MMgrXCPpqr5lBlhBwDtMSJHtTsklNhF2fyg6UoHkhVHoH2Jgdqaxg99Ng9
	3OGdRk4mjcErsrVrzBf1DSr2S7iUvJsNAkoDT8Ow2iOQzjJ0TQsCRI9Agax8E+7EFhqWOu
	+w+PwCEHCCCEuUgp0tNgCpvBM5fTI2w=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
Date: Fri, 17 Jul 2026 21:16:34 +0200
Message-ID: <87a4rp1l65.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> The last-modified builtin expands the pathspec to a set of literal paths
> and builds a Bloom key for each. During the walk it looks those keys up
> in the commit's filter to decide whether the commit is worth diffing.
> These lookups need `bloom_filter_settings` for the key hashing.
>
> prepare_revision_walk() runs prepare_to_use_bloom_filter() to build the
> pathspec key vectors. For a pathspec that cannot be turned into a Bloom
> key, such as a top-level wildcard like "*.c", that function gives up and
> clears `bloom_filter_settings`.
>
> Restore `bloom_filter_settings` after prepare_revision_walk() so the
> per-path check keeps working for wildcard pathspecs.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/last-modified.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index e8ee610404..adc7cd8c74 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -360,6 +360,14 @@ static int last_modified_run(struct last_modified *lm)
>  
>  	prepare_revision_walk(&lm->rev);
>  
> +	/*
> +	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
> +	 * without a Bloom key. Restore it so the per-path check keeps working.
> +	 */
> +	if (!lm->rev.bloom_filter_settings)
> +		lm->rev.bloom_filter_settings =
> +			get_bloom_filter_settings(lm->rev.repo);
> +

@Peff, as far I could tell:

* This change was not needed to be able to use the Bloom filters with
  the pathspec.

* Only restoring bloom_filter_settings was needed. In your patch you're
  calling prepare_to_use_bloom_filter(), but that is being called by
  prepare_revision_walk(). Thus the restoring of the filter settings
  I've added after that function.

>  	max_count = lm->rev.max_count;
>  
>  	init_active_paths_for_commit(&lm->active_paths);
>
> -- 
> 2.53.0.1323.g189a785ab5
>

-- 
Cheers,
Toon
