Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E941B0F19
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393513; cv=none; b=RO3Hw7hRIscPVTX8426W2cYZkAW4eFZ42+PYo2Sofl8RACwWYtACa5FLgB25tM1IMY1FCidtbIyD1/b4LW+CSdpANDe/Igyrfhq50eLpA08KrMOh/bxdm3781Qo1txMggTvyQARTdb2WEguPYQOGZWgJ7NZ7w+fidrVpUXqkQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393513; c=relaxed/simple;
	bh=BO7ijhS612lHWc8hQFNRhxGUgA8OuXoncwXlBBFevEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MLjyejQnDZLc9u8hMct5xBGE9JGGKuRgXhop1Wh/IYWJ1wcsmoZinmOECYyR1RgIagjjk0Jl7SHJMvxQNqh7Nk+yJ5jLiHEbrEXg23/VrWyh8NVWHoFHqM8W9r1IOKESTI/uo19JlpTIgJywjZakRE7CDdUTjwu/1YCqLURAiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ArtTcFOB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ArtTcFOB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768393502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2N78OXvMYOh9wJvE5H96uQ/CQe/kYH722iMJpaskTpY=;
	b=ArtTcFOB/SllAoh+3ZZ68Xl3epuT6V3jkQGTW+8/N2ak+FMJ/k4pvWx6F6diNCUvvEPkee
	f7uqq1q+meVbfH0bflVb3w7pyXdHLUI3nNxGsCZKI49qmYkntcDHLBy84Fd9o30OplFuLw
	cQHxOKTa2XRB4tDUsoojsCBt+vcIPik=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/5] repack-geometry: extract function to compute
 repacking split
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-2-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
 <20260105-pks-geometric-repack-with-promisors-v1-2-c4660573437e@pks.im>
Date: Wed, 14 Jan 2026 13:24:53 +0100
Message-ID: <87qzrsjsa2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> We're about to add a second caller that wants to compute the repacking
> split for a set of packfiles. Split out the function that computes this
> split to prepare for that.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repack-geometry.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/repack-geometry.c b/repack-geometry.c
> index b3e32cd07e..17e6652a91 100644
> --- a/repack-geometry.c
> +++ b/repack-geometry.c
> @@ -78,33 +78,32 @@ void pack_geometry_init(struct pack_geometry *geometry,
>  	strbuf_release(&buf);
>  }
>  
> -void pack_geometry_split(struct pack_geometry *geometry)
> +static uint32_t compute_pack_geometry_split(struct packed_git **pack, size_t pack_nr,
> +					    int split_factor)
>  {
>  	uint32_t i;
>  	uint32_t split;
>  	off_t total_size = 0;
>  
> -	if (!geometry->pack_nr) {
> -		geometry->split = geometry->pack_nr;
> -		return;
> -	}
> +	if (!pack_nr)
> +		return 0;

Thanks for making this easier to read now. Took me a while to realize
they behave identical.


-- 
Cheers,
Toon
