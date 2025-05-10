Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7D7263E
	for <git@vger.kernel.org>; Sat, 10 May 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746912807; cv=none; b=rnyunjm22PmkeFi88IH3LnM8JjpkijMeSPmF1X2vFG9E1Jd252KEQLJjB1RAkArbQ2QISPa/11gNP7RsrrYJ81t9cilUbg0zkx7Eh/U+Zhg/J8k5yyV6Lg+p1VWhCrdcMvSjca8MUmBQLSwGBHmyKikglXD2oVjVsJBPLFJx+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746912807; c=relaxed/simple;
	bh=Uhh9K9/BV3gvrUUFqg+/Lrige8TIyVmMc+06KCNgmPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQg7jLZ7RfYmm0E2gjcNmu/tsMvLRMs0c8p9YX3JZKVB5u4I8Ic/zMNXq5S2sWyysaZ39z28o8XEqUuebJKM7Sfbz0xIN/MGNHu3/HM836ZuyPrXxjbr3v/GdQ4sr6KdoQA9ZqcO8lPow2zA36lgcFzaT3zElji0zszGAa6n+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ggkg4k0K; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ggkg4k0K"
Received: (qmail 16524 invoked by uid 109); 10 May 2025 21:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uhh9K9/BV3gvrUUFqg+/Lrige8TIyVmMc+06KCNgmPA=; b=Ggkg4k0Kn2zz+kvFMQ2rg4ftkN3c7+DuQBSq6VX3KUMG4r2lcMpqNyVwGsk3l/W06ifcekJ1k/1NhVvUSgpi5aURbvlyfyzIl4bwEWaGTJ4kVHb7XPJYcvmmFNqasMJL2HS2nOoqrO31qlvByy2q0JwP3pv8fLfEf+Pg5F2a0M5xUWGodouej8riYBQJq5nxRutDcdRPduemQ5FS+UQammWSYGIJv3RadaWDAIwuHWUIQ659gieBr65hroFUY4Xs6YoViAzLH1Zl1qLLt+QDCyNcDBqMlhpmYB0+dDM2tkXqhL0ZTYOgrm5xrcGJ6EIn/SfjBPZn4lGRCxwM2LelxQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 May 2025 21:33:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16480 invoked by uid 111); 10 May 2025 21:33:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 10 May 2025 17:33:26 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 10 May 2025 17:33:24 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <20250510213324.GB1139735@coredump.intra.peff.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-5-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508234458.3665894-5-sandals@crustytoothpaste.net>

On Thu, May 08, 2025 at 11:44:57PM +0000, brian m. carlson wrote:

> +static int do_import_stash(struct repository *r, const char *rev)
> [...]
> +	struct oid_array items = OID_ARRAY_INIT;
> +	int i;
> [...]
> +	/*
> +	 * Walk the commit history, finding each stash entry, and load data into
> +	 * the array.
> +	 */
> +	for (i = 0;; i++) {
> +		struct object_id tree, oid;
> +		char revision[GIT_MAX_HEXSZ + 1];
> +
> +		oid_to_hex_r(revision, &chain);
> +
> +		if (get_oidf(&tree, "%s:", revision) ||
> +		    !oideq(&tree, r->hash_algo->empty_tree)) {
> +			res = error(_("%s is not a valid exported stash commit"), revision);
> +			goto out;
> +		}
> +		if (get_oidf(&chain, "%s^1", revision) ||
> +		    get_oidf(&oid, "%s^2", revision))
> +			break;
> +		oid_array_append(&items, &oid);
> +	}
> +
> +	/*
> +	 * Now, walk each entry, adding it to the stash as a normal stash
> +	 * commit.
> +	 */
> +	for (i = items.nr - 1; i >= 0; i--) {

Coverity complains about possible integer overflow here. It's an
interesting case. items.nr is a size_t, coming from the oid_array, and
so it's unsigned. You use a signed int to iterate, which is needed to
catch walking past the zero. But in that initial assignment, the
subtraction of 1 is done on an unsigned value. If items.nr is zero, then
it wraps around to a big (usually 64-bit) number, which is then
truncated and forced into a signed 32-bit int.

I _think_ that usually works out, because the overflowed size_t is going
to be all-bits-1, and then the truncation to int is also all-bits-1,
which taken as a signed value is -1.

Probably there's some light violation of the standard there, but I think
it should be OK. But I thought I'd mention it in case I'm missing
something.

-Peff

PS Sorry for the flurry of emails on a v5; this hit jch, so it got
   sucked into my usual testing / analysis flow.
