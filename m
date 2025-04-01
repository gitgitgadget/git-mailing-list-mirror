Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924C202965
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509837; cv=none; b=KCH40V59z41HP3/i3aj3Ae6AEIMi0f4nt5FQC/YgNJg+tsak62KKZcqJ8OTpK5PuO7S2Vk6yVecfWBo9Mt0o4PXryxbPW82Hy692VccU9xQ0Jote9bBI/XTUBsJ0vSUf70Y/5YXbVZAsXK9zd0BqbLauXqxrkyS5YSXBkNOMtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509837; c=relaxed/simple;
	bh=72m2G+IPDYbNyZ5uTyzLinIleK5AS7FpT0upJvwGzas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXRXeaX9PHtYItNBK4fKfp7wfh6mkrSEqLv3iPx9sBDmNBpEDR8lxWn/66f+7ASNqse015F5Pfe2Os70OJ/twAHHCJURTPhWYQUIalozyGRTswqhNqnoSxNLbzWOL1RHnGMoTJwD8meW3OCN4DFc9LdcSOATSKvA5ZyLfMd1Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=v0nXTIcf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="v0nXTIcf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743509833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQyvZl5GPcVG/n1iuJBMvj0M3sI44m3KRatohjEghis=;
	b=v0nXTIcfs7Lixb46gBWv+5TKotB6h7WrFQu6XghhtpUgOjfKHG+Qzx2rBPeKwBRQ0aodch
	ThmKqNSArrqxklmolnQ/xK2xHpaZ+knE3YgdUpC3MxTRssRyqcXViAPATWEHaxmbY/BLjL
	ccMvdU/NS/JzqD1/OfoiPEzFMFFmvss=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] pack-bitmap: allow passing payloads to
 `show_reachable_fn()`
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-6-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-6-4bbc7085d7c5@pks.im>
Date: Tue, 01 Apr 2025 14:17:03 +0200
Message-ID: <87h638f54w.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `show_reachable_fn` callback is used by a couple of functions to
> present reachable objects to the caller. The function does not provide a
> way for the caller to pass a payload though, which is functionality that
> we'll require in a subsequent commit.
>
> Change the callback type to accept a payload and adapt all callsites
> accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c |  3 ++-
>  builtin/rev-list.c     |  3 ++-
>  pack-bitmap.c          | 15 ++++++++-------
>  pack-bitmap.h          |  3 ++-
>  reachable.c            |  3 ++-
>  5 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a7e4bb79049..38784613fc0 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1736,7 +1736,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
>  static int add_object_entry_from_bitmap(const struct object_id *oid,
>  					enum object_type type,
>  					int flags UNUSED, uint32_t name_hash,
> -					struct packed_git *pack, off_t offset)
> +					struct packed_git *pack, off_t offset,
> +					void *payload UNUSED)
>  {
>  	display_progress(progress_state, ++nr_seen);
>  
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index bb26bee0d45..1100dd2abe7 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -429,7 +429,8 @@ static int show_object_fast(
>  	int exclude UNUSED,
>  	uint32_t name_hash UNUSED,
>  	struct packed_git *found_pack UNUSED,
> -	off_t found_offset UNUSED)
> +	off_t found_offset UNUSED,
> +	void *payload UNUSED)
>  {
>  	fprintf(stdout, "%s\n", oid_to_hex(oid));
>  	return 1;
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6f7fd94c36f..d192fb87da9 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1625,7 +1625,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
>  		    (obj->type == OBJ_TAG && !revs->tag_objects))
>  			continue;
>  
> -		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
> +		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0, NULL);
>  	}
>  }
>  
> @@ -1663,7 +1663,8 @@ static void init_type_iterator(struct ewah_or_iterator *it,
>  static void show_objects_for_type(
>  	struct bitmap_index *bitmap_git,
>  	enum object_type object_type,
> -	show_reachable_fn show_reach)
> +	show_reachable_fn show_reach,

What would you think about adding the `_fn` to `show_reach`? Because the
function is passed on to `show_objects_for_type()`, I think it improves
the readability if it's called `show_reach_fn` or somethin?g

-- 
Toon
