Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D51EB2C
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528649; cv=none; b=s1imuVJNTg/x2vJF/v5k9uhc4rg2WCEt+9ff4HzjuBc3vUL7FppLi2GDYGqSKcFKFTykZ4I7l6QIs7ObBd7sYnoZV0UrnkK+vxkFr8r2uWf74WDzdCd0V+5vbw3EmKqYgE5G3Tyu2G4bWo3RbyvYenyNQZ9SfZWpxJnMkdUNUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528649; c=relaxed/simple;
	bh=b9XBOj5KZOOpQpZhbDAGwB0VzC4m1e7Hn1Co8C+nqLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9EjHruOJeALBkwYxNnxPYMD26y/OlpPfg/igkuj2HkOL5AlNlzeHd4WM6ZmQ8pvRrs7DGkISPEQxHXzlhjJc5yLi7HE+Pxuz5uUUjp2Z9dKwzbu7xhdQPQixQ2MYDBxLLFAK5Qp6du6DW7avIo9NTIl+z4mMvF3hOhKVz9WKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21666 invoked by uid 109); 27 Mar 2024 08:37:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 08:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24417 invoked by uid 111); 27 Mar 2024 08:37:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 04:37:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 04:37:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] midx-write.c: use `--stdin-packs` when repacking
Message-ID: <20240327083725.GC830163@coredump.intra.peff.net>
References: <cover.1711387439.git.me@ttaylorr.com>
 <736be63234baf7fc6df8259d9bb7298858b2bc74.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <736be63234baf7fc6df8259d9bb7298858b2bc74.1711387439.git.me@ttaylorr.com>

On Mon, Mar 25, 2024 at 01:24:50PM -0400, Taylor Blau wrote:

> Though correct, this typically yields a poorly structured pack, since
> providing the objects list over stdin does not give pack-objects a
> chance to discover the namehash values for each object, leading to
> sub-optimal delta selection.
> 
> We can use `--stdin-packs` instead, which has a couple of benefits:
> 
>   - it does a supplemental walk over objects in the supplied list of
>     packs to discover their namehash, leading to higher-quality delta
>     selection
> 
>   - it requires us to list far less data over stdin; instead of listing
>     each object in the resulting pack, we need only list the
>     constituent packs from which those objects were selected in the MIDX

Yeah, using --stdin-packs makes much more sense to me. I have to admit
that I do not really see the point "multi-pack-index repack" in the
first place. You'd presumably be better off with geometric repacking,
and I think "repack --geometric --write-midx" will do things in the
right order (new pack, then write midx, then delete redundant packs).

I guess "multi-pack-index repack" came before geometric repacking, and
is maybe redundant-ish now? If that's the case, then I guess I don't
care that much about optimizing its packs. ;) But we can't really delete
it without a deprecation period, so making it more sensible in the
meantime is reasonable to me.

-Peff
