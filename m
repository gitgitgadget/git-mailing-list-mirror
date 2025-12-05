Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E5215055
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957670; cv=none; b=bpWkXe68uTSnx+QKVwvdfFjtwkZ7iJI36NsNKIjuRMIALUYRFUJ7VOB4Ze7ll2vqEnP/nyuzHi1HOY4/jBrEY/2+9uBu9alvOc13CfGz9Zaf+evdc+vFHzh8UkaJTuUJLbRAgSnvxSJUfe5xWomb0xSrftRu8VYMNDjp6O2VqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957670; c=relaxed/simple;
	bh=m2pRFSfcV8sd5J4lha3QMBpB+HUZQbe4TrfFm9j4k1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnxENNXoeA/ibqUoiPfq2uytiJIPW8LgHX4Aga/iXSpV/kPMPcCUFq0Z+VFHhYdab+jPDjmQZxkYEskzZhBKyTGlFvPEiuAegmQocAFGCwh2YhoU3GbdqUQXkVRnLbAtbr5mX1zmK422x3go4luGqy6gZ98fybsQydGF8pPyDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QBUhYqjj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QBUhYqjj"
Received: (qmail 271829 invoked by uid 109); 5 Dec 2025 18:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=m2pRFSfcV8sd5J4lha3QMBpB+HUZQbe4TrfFm9j4k1Q=; b=QBUhYqjjFtiv/dP+gAsPrgaBptrsauZDBFGXlwwa+Wzu2v3ZArwd82VuHqs5anWj3ZOotw6QFvTN3HVffHD8j5Yxpugab9bHzZlhaHOndkapjLEfdHGMmN1TaxGNRm62PJ5vUfrgztkWyeF5oDuktSsMV26Y7yODFCewhwFla3OcBvoVofLyOuKi9avtZo+LhBpnwdqB6TPatt1nonr2MnEUwErQkSZwepkmcRTLuBpertyHmtLqmLK8adY3CLAQIV+zyuThUNjdn22c+BuCyEHs0UJbHujICb8HDN077bB7oSV8kmXN1SX53LJlUWrJrVyJFFMd6IGU+kgXM3pH7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 18:01:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 339986 invoked by uid 111); 5 Dec 2025 18:01:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 13:01:08 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 13:01:06 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251205180106.GC18566@coredump.intra.peff.net>
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <20251205174854.GA18566@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205174854.GA18566@coredump.intra.peff.net>

On Fri, Dec 05, 2025 at 12:48:54PM -0500, Jeff King wrote:

> OK, so we are checking the type up front and then skipping
> parse_object() if we can. But there is already some logic inside
> parse_object() for these kinds of optimizations. If we tell it we are
> not interested in checking the hash of the objects, then it knows it can
> skip loading the blob entirely.
> 
> But it can _also_ use that flag for other things, like using the
> commit-graph rather than loading individual commit objects. So doing
> this:
>   
> diff --git a/packfile.c b/packfile.c
> index 9cc11b6dc5..01b992a4e1 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2310,7 +2310,8 @@ static int add_promisor_object(const struct object_id *oid,
>  		we_parsed_object = 0;
>  	} else {
>  		we_parsed_object = 1;
> -		obj = parse_object(pack->repo, oid);
> +		obj = parse_object_with_flags(pack->repo, oid,
> +					      PARSE_OBJECT_SKIP_HASH_CHECK);
>  	}
>  
>  	if (!obj)
> 
> drops my linux.git case down to 49s. It's skipping the blobs (with no
> need for your patch) and loading the commits out of the graph file. Note
> that you may need to "git commit-graph write --reachable" to see the
> effect (I think we do generate graphs by default in git-gc these days,
> but I'm not sure if we do so right after cloning).

Oh, and obviously it is skipping the hash computation on the objects,
too. That's probably not as important as avoiding the object loads in
the first place, but it may also be making a measurable difference on
the ones we do load (notably trees here).

-Peff
