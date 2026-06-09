Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E0199D8
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001682; cv=none; b=cA45XZExZfj+11yvMM729FS9+fWLtceA8zjb1hFpLNqqCWcHPXyWvFit9zKGsc5f7GPc3k5n+Y/QOTaywvPiPQnnNe5vLZAdoSQcHzrPQPu5auVUm5qfwJi2KhAdq8sCY7zk+gBrvOV5C2bawNfh78kMBSk3iunJAXrCxuhzxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001682; c=relaxed/simple;
	bh=8DnpJTz4iz80PHqaPbaQsJS9tKrN6N2H0AYbObUpYyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9IrA/Yi9f/9rHU/onPoMs3t0JzdFnHKx70vdOd7hre10vrFxHAZJV/1MGVPnudafuOg5gfJxAImRVkL+K0WJeNg7EJU5SiDnV4Biz6Vecw9LbHAElsBy1hWIAbOeXBYOadoDaIsy9LyR6W2sCUnkpe7jwCthBNFpiBzquXrssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Jubf8lPZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Jubf8lPZ"
Received: (qmail 87073 invoked by uid 106); 9 Jun 2026 10:41:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8DnpJTz4iz80PHqaPbaQsJS9tKrN6N2H0AYbObUpYyc=; b=Jubf8lPZXYfmF5DqriajNruYwI29npRXKuc12kPlMTvAViqZyQsOVQMKuzIHe2nr0j8CIDmTfqsIngglp3Ab7qsLGj9FNmooOCyFzq0vaxZIIrFJeZqf0zJMcXCb1oTQvwX5tkHKMOGsvULNJK4OOCO4Gx6Vxf6OA55d7aOlOC67N9NBHRp0JwRO0J48mOs02+vZdPN1+dlwNCbgrVVeO1xgsSeW3uCHoKNcJnswJdYjvIAEstqg2J1CU0MzMf7KRch/ppGy9bZ0klbCJKzPdP1e4UBwq68wBcSjm1L2U8uE5e90QHZvZvoIF3BW74tZcLdYN2FWrjxCiowysoX0hQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jun 2026 10:41:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 262023 invoked by uid 111); 9 Jun 2026 10:41:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jun 2026 06:41:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jun 2026 06:41:19 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
Message-ID: <20260609104119.GA1509396@coredump.intra.peff.net>
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>

On Mon, Jun 08, 2026 at 07:37:15PM -0700, Tamir Duberstein wrote:

> +		/*
> +		 * match_pathspec() is linear in pathspec.nr, so prefilter only
> +		 * the single-pathspec case. Only entries shown by show_ce()
> +		 * satisfy --error-unmatch.
> +		 */
> +		if (pathspec.nr == 1 &&
> +		    !match_pathspec(repo->index, &pathspec, fullname.buf,
> +				    fullname.len, max_prefix_len, NULL,
> +				    S_ISDIR(ce->ce_mode) ||
> +				    S_ISGITLINK(ce->ce_mode)))
> +			continue;

This feels...kind of arbitrary, no? Surely it's also faster with
pathspec.nr == 2, and so on up to some nr closer to the size of the
total index. It feels weird to be making an arbitrary cutoff based on
pathspec performance in calling code like this.

It is not wrong, per se, as you are optimizing your case without trying
to hurt any others. But what do we do when somebody profiles it and
comes along trying to bump the number to 2, or 10?

I dunno.

-Peff
