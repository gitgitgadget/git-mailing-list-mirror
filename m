Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9526C3BD
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347627; cv=none; b=bhmA6tdsPBAP4Zx4eWGcrj5mt7m/N9OymLWpO3ayjyUosg+4t0Snb8oYNk03KgVGwxV6ohYGCX2IWezh2t8x+G+c50EJBXVyfa4xQzMqhTI99nPkFPoabrLt/304jbZArPt92WZTXktDt/k4Ln+YTAdyqAWdyl7CPJYTlgl+wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347627; c=relaxed/simple;
	bh=+suqqgxSf2Lf4AJBwFg5a3peABzTy5Pko6dgztLLlfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFJknZLZ5fJwGz1GCJzTmoszt3ynSuNCcGG1ulJ39HsLeWKVRodyETCJJ4WhVDXDGIf1oShgenGle4vQoEj/szvNx3YBC3XXhkkO4AbQJJRD4MrovUggy1CoN9BABpWSxRCiSdFKvwUq0ET/ReCiNQs36FvoUX3nfrjfahXONcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I8Vw+Gr6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I8Vw+Gr6"
Received: (qmail 90123 invoked by uid 106); 12 Mar 2026 20:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+suqqgxSf2Lf4AJBwFg5a3peABzTy5Pko6dgztLLlfI=; b=I8Vw+Gr6nW8VuWrURY1OaIooQInLn9TcObpbcojzuIt6YuoLPC+6XY99ScdbR1KnRYQPhbQcEZnPqUW0uMP9gBFKO4AiAK9Gu74Wd7sASIlzspr3CRuA01wh66TNkZ9QbCqvQeHTb+7RU13lh9TKxft6BAcw2ALkDGyZW4aol9vzNSUEXm/+noTQTS9RTK4WBKCBal9dBN0wIvAaA925ffAVZGeo9vWSDctVIMbD5fdX4su3ypxqGiPByABMepGIWeIi8yEB/c6yLj/X41P8/m5GcUXNit6QsgMDJJBToLoE0uvSzn8S5CHMiXauFHa0riBQtmQE+3AuYHQDTNA3fg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Mar 2026 20:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 510733 invoked by uid 111); 12 Mar 2026 20:33:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 16:33:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 16:33:37 -0400
From: Jeff King <peff@peff.net>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
	christian.couder@gmail.com, karthik.188@gmail.com
Subject: Re: [PATCH] t0410: modernize delete_object helper
Message-ID: <20260312203337.GA2552877@coredump.intra.peff.net>
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>

On Thu, Mar 12, 2026 at 06:20:30PM +0530, Siddharth Shrimali wrote:

>  delete_object () {
> -	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
> +	repo=$1
> +	obj=$2
> +	path="$repo/.git/objects/$(test_oid_to_path $obj)" &&
> +	test_path_is_file "$path" &&
> +	rm "$path"
>  }

It might worth marking these new variables with "local". They are not
used elsewhere by the script currently, but they are common enough names
that a collision in the future doesn't seem that unlikely.

-Peff
