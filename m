Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58588231CA3
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759875; cv=none; b=CDWwvu/AGCxz8KXFY3Kvs77ENDsGCQxJfPAs7kzSUp+vZ0k6ZlehMlRLPC0ORA/TU33bjnTRQnGwyepdyoUtS2z3I1lpTR378HlX+2J6iXe22zqi+KpqYR4tc1uvynQeIiBsvdDU+Ovoj81idMhl7kmsGN25a1KJs2YTWEekym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759875; c=relaxed/simple;
	bh=zElNPmiGCSPRQgLOIr16OyX6R0uqRmDNv8ci3GxvtaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoVVmIscnMwFBMgV3XKbAvpo3ILInAS0I8gIqIG75ZJ2QXSqdAjY93hMOAfVyCV9SXuShIOpcZQ3MwZeh0xK+nO3HfJiGaLQdBy+GJSQHJFJQUvm0P893zb9XuJS8bsvM9a++XBM95y7/nx7EAW/6Nvk7+zPL4lg246casCMjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S8G2rzUz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S8G2rzUz"
Received: (qmail 13716 invoked by uid 109); 13 Jan 2025 09:17:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zElNPmiGCSPRQgLOIr16OyX6R0uqRmDNv8ci3GxvtaY=; b=S8G2rzUzxulY6OsXqspQMMnDG4XKHAKoGN+r0cIBmZhlRZMPL4rwZX36VM2w/PdwdrqfmyxJzSECwVotGZU1umx10Bz/B9sHgdylBFYNwWtgkoMZDTYEMSNyujGuQHgejslbhaVhCLS/ygMrTrurBX6EBk7kqFut3sbsOxSZbMG58hCR12AUcKwkphR+xB8ExEEHi3jajDVl7sIM8/K9AGemTth7jovdnxktzqEjSQtzaPFrud3XlZlSb4T6B6O0DjkJ45j1cEiLI1lUEGou3BWoxWnekubiugW8QkPa7J1lprf3s2T6cZZ3JThlNovxi/BfjNnX+5FY9q0L0hFLUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jan 2025 09:17:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19903 invoked by uid 111); 13 Jan 2025 09:17:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2025 04:17:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Jan 2025 04:17:50 -0500
From: Jeff King <peff@peff.net>
To: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] fix(gc): make --prune=now compatible with
 --expire-to
Message-ID: <20250113091750.GA794747@coredump.intra.peff.net>
References: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
 <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
 <579757957d21faaa8dd9228a191d82f663e93c03.1735611513.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <579757957d21faaa8dd9228a191d82f663e93c03.1735611513.git.gitgitgadget@gmail.com>

On Tue, Dec 31, 2024 at 02:18:33AM +0000, ZheNing Hu via GitGitGadget wrote:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 77904694c9f..8656e1caff0 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -433,7 +433,8 @@ static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
>  static void add_repack_all_option(struct gc_config *cfg,
>  				  struct string_list *keep_pack)
>  {
> -	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
> +	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
> +		&& !(cfg->cruft_packs && cfg->repack_expire_to))
>  		strvec_push(&repack, "-a");

I expected to see a mention of repack_expire_to here, but not
cfg->cruft_packs. These two are AND-ed together so we are only disabling
"repack -a" when both options ("--expire-to" and "--cruft") are passed.
Can we --expire-to without cruft? I.e., what should happen with:

  git gc --expire-to=some-path --prune=now --no-cruft

Looking at the underlying git-repack, it seems that we only respect
--expire-to at all when used with "--cruft", and don't otherwise
consider it. Which is what the manpage says ("Only useful with --cruft
-d").

But if we look at this proposed patch for example:

  https://lore.kernel.org/git/48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com/

then it is expanding how --expire-to is used during the pruning step.
OTOH, I think the way your patch 1 is structured means that we'd always
pass --expire-to to git-repack anyway, and I _think_ even with the patch
linked above that "repack -a -d --expire-to=whatever" would do the right
thing.

In which case the problem really is the combination of cruft packs and
expire-to. Just cruft packs by themselves do not need to override using
"-a" for "--prune=now" because we know that any such cruft pack would be
empty.

So I think this logic is correct. Taylor might have more thoughts,
though (and ideas on whether he intends to revisit that earlier patch).

I do think this change should probably be done as part of patch 1,
rather than introducing a buggy state and then fixing it in patch 2.

-Peff
