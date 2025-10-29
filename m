Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5B2C234F
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749749; cv=none; b=KafmzWRMrJjtcuP3jGSrRjXAedfZaYprKS9uQS+MEk2NIFZLqkhHOeVKlg6WXPrjJ5gsJqDLyOgHaLVGyn+ocqefOqO7lnFJ7HR9+Ti8cdh+Did5PN+mIMi2OTGls4nXQaH7mltpkaguoMnJsvPuHxaxJ4VpgMsSVhNowuIkenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749749; c=relaxed/simple;
	bh=xtjoAMeh3L1qBzbKQUeu9+mnrBn99AGnOsi/7PUaXTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cXtJL3KKlNbBBs0NkDY7qMS42MiOJzoFzNdlPZXdMjNYDs1+dt8vD3u0QuipMwFrW9HD8hEzIVo05uChTB7j9KooXbV5Tc7ZNQu8JbBqFartEH7+BjxPFexcoIy+9fXFrTTPK/nA0FenOWWrphME40NXEMG8+2G3zJVIGU6jhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nPesjYTr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nPesjYTr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761749742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRZ/2eOu7E/D163Kg7O+0r3Emb4c62fZf7Rfx3BJQ9E=;
	b=nPesjYTr4Gzru1Fxeg9EaZArLJNTW24XEqgiAiEhY8lbs3AG6yMwKNBrwoxs1pfYVr0NVh
	Ij7G/e/Rkb/OPldIScb7OAZLY0wORtF6uAX1GgG51jnYPDqZzF7HghZa4Gr0UwX9ZViwAM
	3LJ9UctAxcac0eyUfTie6pV8qQgJfeI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept
 or nonlocal objects
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
Date: Wed, 29 Oct 2025 15:55:17 +0100
Message-ID: <875xbxrc4q.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The function `has_sha1_pack_kept_or_nonlocal()` takes an object ID and
> then searches through packed objects to figure out whether the object
> exists in a kept or non-local pack. As a performance optimization we
> remember the packfile that contains a given object ID so that the next
> call to the function first checks that same packfile again.
>
> The way this is written is rather hard to follow though, as the caching
> mechanism is intertwined with the loop that iterates through the packs.
> Consequently, we need to do some gymnastics to re-start the iteration if
> the cached pack does not contain the objects.

Okay, this took me while, but yes this function was really hard to
understand. Thanks for simplifying.

Naive question, what's the point of keeping a "last_found"? We have one
global "last_found" for the last time this function was called, and we
have no control which OIDs get passed to this function. Why look into
"last_found" first?

> Refactor this so that we check the cached packfile at the beginning. We
> don't have to re-verify whether the packfile meets the properties as we
> have already verified those when storing the pack in `last_found` in the
> first place. So all we need to do is to use `find_pack_entry_one()` to
> check whether the pack contains the object ID, and to skip the cached
> pack in the loop so that we don't search it twice.
>
> This refactoring significantly simplifies the logic and makes it much
> easier to follow.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5348aebbe9f..861fef3f38a 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4388,27 +4388,27 @@ static void add_unreachable_loose_objects(struct rev_info *revs)
>  
>  static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
>  	static struct packed_git *last_found = (void *)1;
>  	struct packed_git *p;
>  
> -	p = (last_found != (void *)1) ? last_found :
> -					packfile_store_get_packs(packs);
> +	if (last_found != (void *)1 && find_pack_entry_one(oid, last_found))
> +		return 1;
>  
> -	while (p) {
> -		if ((!p->pack_local || p->pack_keep ||
> -				p->pack_keep_in_core) &&
> -			find_pack_entry_one(oid, p)) {
> +	repo_for_each_pack(the_repository, p) {
> +		if ((!p->pack_local || p->pack_keep || p->pack_keep_in_core) &&
> +		    find_pack_entry_one(oid, p)) {
>  			last_found = p;
>  			return 1;
>  		}
> -		if (p == last_found)
> -			p = packfile_store_get_packs(packs);
> -		else
> -			p = p->next;
> -		if (p == last_found)
> -			p = p->next;
> +
> +		/*
> +		 * We have already checked `last_found`, so there is no need to
> +		 * re-check here.
> +		 */

I had to reason with myself why you need to extra `(void *)1` check,
maybe you can extend the comment a bit:

		/*
		 * When `last_found` was set to something else then
		 * `(void *)1` we have already checked it,
		 * so there is no need to re-check here.
		 */

> +		if (p == last_found && last_found != (void *)1)
> +			continue;

-- 
Cheers,
Toon
