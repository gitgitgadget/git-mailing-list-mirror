Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D021770A
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845229; cv=none; b=sqB/KIzsBGV5GZ818n01eOWzj1heg5Q44zSyeKSgEr2ibcnr8zQRnjtHOehWg1kfvBJuX3vIjnklpj84UtY1sJD/Shlckj8PgwRnuV1mZATSmxHhkCEeQVqqpsrbugqce19yfEHYhK+2lwErxGexzUOu0cJE1dCnK34orKWdCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845229; c=relaxed/simple;
	bh=c8nj78xBjU4P2r/qXskHtsTbczArId86HsWH5Ds8pZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2s9WfPeb11pgtwuOLF3xJo4DWe5tOGf5YYrqkNhpEXZVEMauZY+L9K3hfAROgmX7ckRAl8Stucn5hkJslkzUL9Ly8a4MELuinpauYznftNKjTFCHcBRvykbGZZzD5L8GM95vYNGVY1Ahx1qIXPd7l9mgT8SoDygZDhsNErkWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PDcIiLFh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PDcIiLFh"
Received: (qmail 51960 invoked by uid 109); 23 Feb 2026 11:13:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=c8nj78xBjU4P2r/qXskHtsTbczArId86HsWH5Ds8pZk=; b=PDcIiLFh+b5tp3MbF1solvuE2gjYtbw+t03FKAh4Qgk/NT+rJXGOj2R8qShV1QPgEOjHaSD+XgnR2TdfWAVFDGYrXBzJ2ugkGpvrT3aeES4zUqEqsTzaBTSqojLoFqVw2Zoy/aAr6Hck38h0RtLcVtZOZXhX39M3E3Zem9QqrT/x9qm3B7ffTLuo2kCzJG3zrBWiROfCnFaG0BWLt76eDkXzkQ8RqVb2ypamK7zyUtAq9Nc1Jttw2ZvTLf4XNnidP2he+EGYqmKfs7BoijHxZwAnjzez4/J9Y8plkTh1WWUym6zP2yARtQJww7uJYHiBzLJ9sVMD5QTZZ+nZ6tq91g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 11:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 100128 invoked by uid 111); 23 Feb 2026 11:13:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 06:13:52 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 06:13:46 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t/helper: improve "genrandom" test helper
Message-ID: <20260223111346.GD215364@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-1-c29036832b6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223-pks-fsck-fix-v1-1-c29036832b6e@pks.im>

On Mon, Feb 23, 2026 at 10:50:40AM +0100, Patrick Steinhardt wrote:

> Fix both of these issues by using `git_parse_ulong()` to parse the
> argumemnt. This function has better error handling, and it knows to
> handle unit suffixes.

Makes sense, but...

> @@ -22,7 +23,9 @@ int cmd__genrandom(int argc, const char **argv)
>  		next = next * 11 + *c;
>  	} while (*c++);
>  
> -	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : ULONG_MAX;
> +	count = ULONG_MAX;
> +	if (argc == 3 && git_parse_ulong(argv[2], &count) < 0)
> +		return error_errno("cannot parse argument '%s'", argv[2]);

...I think the return value of git_parse_ulong() is boolean 0/1, not
0/negative.

-Peff
