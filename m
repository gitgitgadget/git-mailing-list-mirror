Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5223F424
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498416; cv=none; b=jl5vBpQA7ZHiN3lbaKFyG2CLICxH5NqYhS4eKbORLNtKnnwaE8V2WcXrpdmg0whST0KKfrieJs18JCwLsaaH3oN9OUn3CV430S+QAeEVi5ZUvLNq6CP9I/rV8L80kDC424TLmISFEyNB7ob6elRCQzkGDCizp8RINfvbyUmFTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498416; c=relaxed/simple;
	bh=ue6Zart/wMJHOZXIs+D+WUc2t3rgVf/J2YT1mimTc18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxoCFoLWHnsnRJRa1zEY6oYzAl8m/Wd4GgAh0sq4ie4T2flxO5h0D7rf+ok0hEOpLKdpRb2Ms1Ucy/TXHQnxOIdtdhbWxFi1e6mA4uq2JODiQeuQzKxxZulemTntBqRjbtctpNhRhz3ddpZjXIHlkb/XPr2Q6pmQ4Dn4q/I9EB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Rh6oZnBb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Rh6oZnBb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754498408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZL6A8CWNAZXZ5ghqSicNaoQqVuO25qwNcN+Rz3ZsU=;
	b=Rh6oZnBbhoO5GAYx+oPMrxlVeNoE4YpOmtNgOqM2X2eLldaBHKnhYFZjUtTpkKVOMx9TGh
	xySCK0+dVZRWXYcg4IL4+FB0ddT5xyZiobqyAFihlzc/nag3LfWORCOmmmexjFQTa2vLBX
	xwA3aMX3HSkyf4rNjAgqtyAWqk9nEzM=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] odb: store locality in object database sources
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-1-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-1-748db2eda3b5@pks.im>
Date: Wed, 06 Aug 2025 18:39:54 +0200
Message-ID: <87fre4tndx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Object database sources are classified either as:
>
>   - Local, which means that the source is the repository's primary
>     source. This is typically ".git/objects".
>
>   - Non-local, which is everything else. Most importantly this includes
>     alternates and quarantine directories.
>
> This locality is often computed ad-hoc by checking whether a given
> object source is the first one. This works, but it is quite roundabout.
>
> Refactor the code so that we store locality when creating the sources in
> the first place. This makes it both more accessible and robust.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c       | 5 +++--
>  midx.h       | 2 +-
>  odb.c        | 1 +
>  odb.h        | 8 ++++++++
>  packfile.c   | 9 ++++-----
>  repository.c | 1 +
>  6 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 7d407682e6..b9ca0915a6 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -723,7 +723,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  	return 0;
>  }
>  
> -int prepare_multi_pack_index_one(struct odb_source *source, int local)
> +int prepare_multi_pack_index_one(struct odb_source *source)
>  {
>  	struct repository *r = source->odb->repo;
>  
> @@ -734,7 +734,8 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
>  	if (source->midx)
>  		return 1;
>  
> -	source->midx = load_multi_pack_index(r, source->path, local);
> +	source->midx = load_multi_pack_index(r, source->path,
> +					     source->local);
>  
>  	return !!source->midx;
>  }
> diff --git a/midx.h b/midx.h
> index 076382de8a..28c426a823 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -122,7 +122,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
>  int midx_contains_pack(struct multi_pack_index *m,
>  		       const char *idx_or_pack_name);
>  int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
> -int prepare_multi_pack_index_one(struct odb_source *source, int local);
> +int prepare_multi_pack_index_one(struct odb_source *source);
>  
>  /*
>   * Variant of write_midx_file which writes a MIDX containing only the packs
> diff --git a/odb.c b/odb.c
> index 1f48a0448e..1761a50840 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -176,6 +176,7 @@ static int link_alt_odb_entry(struct object_database *odb,
>  
>  	CALLOC_ARRAY(alternate, 1);
>  	alternate->odb = odb;
> +	alternate->local = false;
>  	/* pathbuf.buf is already in r->objects->source_by_path */
>  	alternate->path = strbuf_detach(&pathbuf, NULL);
>  
> diff --git a/odb.h b/odb.h
> index 09177bf430..d9f4dcf79f 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -63,6 +63,14 @@ struct odb_source {
>  	 */
>  	struct multi_pack_index *midx;
>  
> +	/*
> +	 * Figure out whether this is the local alternate of the owning

Do we still use "alternate" in this context? Shouldn't it be "source"?

-- 
Cheers,
Toon
