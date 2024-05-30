Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA183207
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052386; cv=none; b=DHQQje+Z5JJO8ALzRI4/e2De0IHePpcvU7VrFXJzCv3DD/+XDfSDrhPCcCGXmHZ5thFhA7Zo5SuagF5Mnq/KRdeDw/GATmgqQ1u3sKup1AA5E5VKoyRpCS5FEEA99D5oI/raOmr8sIkrqUhy+dntPCmHPjtQNHlP+h1XMEGNGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052386; c=relaxed/simple;
	bh=0GJ/w8Rj+q0DEVaI7vSkRbSQ1bfHRTygUcru+oNKs4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLPnGZPGrLwofEF58ayruNbvbB1U11GWMwr5GOW329mFdlPTb6EnRgaqE8wbjhl/7VLrXsC1lVB0qYp9HUMKbNDejOagXE7l26U6n8FmAlSYFZ20PjQNY0jxl0fCseeS6Uc1uXw4TZGr6N7zOOsnUUHUl9OdTNdKx8JvXY1vKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16854 invoked by uid 109); 30 May 2024 06:59:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:59:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27767 invoked by uid 111); 30 May 2024 06:59:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:59:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:59:43 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] midx-write.c: pass `start_pack` to
 `compute_sorted_entries()`
Message-ID: <20240530065943.GA1949834@coredump.intra.peff.net>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
 <e81296f8ccf8b47758d0ec4fbb04f0f2b356b490.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e81296f8ccf8b47758d0ec4fbb04f0f2b356b490.1717023301.git.me@ttaylorr.com>

On Wed, May 29, 2024 at 06:55:28PM -0400, Taylor Blau wrote:

> The function `compute_sorted_entries()` is broadly responsible for
> building an array of the objects to be written into a MIDX based on the
> provided list of packs.
> 
> If we have loaded an existing MIDX, however, we may not use all of its
> packs, despite loading them into the ctx->info array.
> 
> The existing implementation simply skips past the first
> ctx->m->num_packs (if ctx->m is non-NULL, indicating that we loaded an
> existing MIDX). This is because we read objects in packs from an
> existing MIDX via the MIDX itself, rather than from the pack-level
> fanout to guarantee a de-duplicated result (see: a40498a1265 (midx: use
> existing midx when writing new one, 2018-07-12)).

Hmm, if the last patch had not removed the separate array/nr pair for
packs, then you could just pass (array + start_pack, nr - start_pack). :)

But I think it is probably reasonable to keep the notion of "here are
all the packs" and "you are skipping some of them" clear through the
call stack anyway. Especially if the notion of start_pack gets more
complicated:

> Future changes (outside the scope of this patch series) to the MIDX code
> will require us to skip *at most* that number[^1].

So this patch seems fine to me.

-Peff
