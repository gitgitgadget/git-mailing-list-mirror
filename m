Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2742E1F0E
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732163; cv=none; b=QR1uu/GVCGSOSS9FTxNrIGS2bRZ4mw6nm390EPO82e6UKlyOGlF9djUT+d8ztEQpJLvUSvrHedpajcasLcYBtG37juE6LNc0ZDKl1+oNzNdZmbTW7PSXeAvEGXm8fIGVE4lOvwlEnT/Xpu4zt0+noevaC7+D7O4vwSHGhF+u/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732163; c=relaxed/simple;
	bh=RUvVwWMRpQPKPopUeEPhzYKPy+FiQiDpFcXfXiK2J0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TB/374XZ/eNzBvIygocv2M4cZfkaPPEa7/CBjT2Rvn8ft6RPIPRxqXXI4axZBUOGsuZ1tHJrqWEftYeWV7msJYreWuP+RQs3+M2i7UC+giGfz/x00cjw8EMqQagMRslqiQj/6qHmVU4qyRInV2XhYzoMk5UKzKWA0Dv1hAhq1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=zVSr0gX8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="zVSr0gX8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767732144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P97qFEPlZ5iXO3e9+FmEDyOq3Io53HF+MUE1fmLce/s=;
	b=zVSr0gX8CHrj7rAO1qFyxDs6KB8kJx1Iyjm1jz5AFRNzs0PQpyZRFfqT0rlczx0q7AmBce
	ZrEJMemLudCHRwijyrw9g9YBw6PPA8GcgvzXWzr/lEzgaI9a/YfGhOx4z1sjdlaCGCbc+5
	tPiLjIgDoLwTCAQ3U635w88vYc/A/jw=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 03/10] packfile: refactor kept-pack cache to work
 with packfile stores
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-3-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
 <20251218-b4-pks-pack-store-via-source-v2-3-62849007ce21@pks.im>
Date: Tue, 06 Jan 2026 21:42:09 +0100
Message-ID: <87jyxupj6m.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The kept pack cache is a cache of packfiles that are marked as kept
> either via an accompanying ".kept" file or via an in-memory flag. The
> cache can be retrieved via `kept_pack_cache()`, where one needs to pass
> in a repository.
>
> Ultimately though the kept-pack cache is a property of the packfile
> store, and this causes problems in a subsequent commit where we want to
> move down the packfile store to be a per-object-source entity.
>
> Prepare for this and refactor the kept-pack cache to work on top of a
> packfile store instead. While at it, rename both the function and flags
> specific to the kept-pack cache so that they can be properly attributed
> to the respective subsystems.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c | 12 ++++++------
>  packfile.c             | 37 ++++++++++++++++++++-----------------
>  packfile.h             | 25 +++++++++++++++++--------
>  reachable.c            |  2 +-
>  revision.c             |  8 ++++----
>  5 files changed, 48 insertions(+), 36 deletions(-)
>
> [snip]
>
> diff --git a/packfile.h b/packfile.h
> index 33cc1c1654..410f85f03d 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -90,9 +90,10 @@ struct packfile_store {
>  	 * is an on-disk ".keep" file or because they are marked as "kept" in
>  	 * memory.
>  	 *
> -	 * Should not be accessed directly, but via `kept_pack_cache()`. The
> -	 * list of packs gets invalidated when the stored flags and the flags
> -	 * passed to `kept_pack_cache()` mismatch.
> +	 * Should not be accessed directly, but via
> +	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
> +	 * invalidated when the stored flags and the flags passed to
> +	 * `packfile_store_get_kept_pack_cache()` mismatch.
>  	 */
>  	struct {
>  		struct packed_git **packs;
> @@ -210,6 +211,19 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
>  int packfile_store_freshen_object(struct packfile_store *store,
>  				  const struct object_id *oid);
>  
> +enum kept_pack_type {
> +	KEPT_PACK_ON_DISK = (1 << 0),
> +	KEPT_PACK_IN_CORE = (1 << 1),
> +};

Thanks for making it more clear this is used as a bitfield. I also
appreciate the rename.

> +
> +/*
> + * Retrieve the cache of kept packs from the given packfile store. Accepts a
> + * combination of `kept_pack_type` flags. The cache is computed on demand and
> + * will be recomputed whenever the flags change.
> + */

Also this comments helps, thanks.

> +struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
> +						       unsigned flags);
> +
>  struct pack_window {
>  	struct pack_window *next;
>  	unsigned char *base;

-- 
Cheers,
Toon
