Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961121494CC
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073599; cv=none; b=kpLx3mf5jXf02AOZsmwrNc9a9FLCF5B2cCntpSiewUMtXOnTcbGIqxxGfKexfvv00RPuFeyYS6rwLLKCC9mx80b7onJ2RWCun6TgB8A0+8yTFQRSHa8uES4sVF5TOwik/uvfnGDMBYKqTg7fItRzGXtKGQxxL7eXRpGatQTQQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073599; c=relaxed/simple;
	bh=yzTsgxfEurufiowPIIvhsGU45Au8DBqBTvrhUeMQWEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7uBbX1TlOhTCOc8zu/fpOhNCZH5xdQ9j+DYuO3dC7ouoA8lyXxaCjz4WeZj3xdqYzCPJ6sN/vpxXEEJ8wl1+p7J1LKwP413PvWajScICs67rg/odPffr1U67b1j5BgLZMEKNCJyy8DWgLigK5/5Ly94pDuoQRyT3Vs/R0OZtyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Cy7RdzR4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Cy7RdzR4"
Received: (qmail 181992 invoked by uid 109); 10 Oct 2025 05:19:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yzTsgxfEurufiowPIIvhsGU45Au8DBqBTvrhUeMQWEU=; b=Cy7RdzR4QP4XlSlpOY1VvESPkhrBlmmmzxR6GHlt4xZ/QCPu7dBJnfcb0vI5LRDlsBwePXnafF6595dt0U2PP1iGJtH0c6Av0i5TQh7NvI+zTGGBQGj8aijQIOM+ELUJdXdNy2sV0gRs9wIqTC2J/EokCUytSqWTpPo8AquoUERCwXg17URWt/FZtl5a6IGf4coY5/oMmEECjhZcP6CtnEAdyrkKyZUlFHnwxAs4p4ruDJObDGWsNZBFZqoRbcbju9d+izoTe+u7GOvB4/OSbBn9Jh+tXReeWZfubyblYW4Cfp40Yj9vVzJEiN0vmbtT2GBwPbgC/gu/QxUE8Rn7Tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:19:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282843 invoked by uid 111); 10 Oct 2025 05:19:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:19:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:19:55 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 02/49] builtin/repack.c: avoid "the_repository" in
 existing packs API
Message-ID: <20251010051955.GA1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <664a67c93620edf6727f0617f4dddce99901fcde.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <664a67c93620edf6727f0617f4dddce99901fcde.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:18PM -0400, Taylor Blau wrote:

>  struct existing_packs {
> +	struct repository *repo;
>  	struct string_list kept_packs;
>  	struct string_list non_kept_packs;
>  	struct string_list cruft_packs;
> @@ -265,7 +266,7 @@ static void existing_packs_release(struct existing_packs *existing)
>  static void collect_pack_filenames(struct existing_packs *existing,
>  				   const struct string_list *extra_keep)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
> +	struct packfile_store *packs = existing->repo->objects->packfiles;

I found it a little funny to pass around a repository struct as part of
existing_packs, since they're not directly related. But I think it is
mostly just a convenience to do so, and "existing_packs" is really
storing an overall context.

It could probably be scoped down to pass around an object_database
instead, or maybe even a packfile store, which somehow feels a little
more "correct" to me as context. But I have trouble imagining that being
helpful to any new code (why would it have an object_store but a not a
repo object?). And I can easily imagine having the repo available being
useful for future refactorings.

So I think what you've written here is probably a good path forward. I
wanted to outline my thinking because I suspect the same will apply to
other patches in this series (i.e., they don't always need a repo
object, but it's simplest to pass them one).

-Peff
