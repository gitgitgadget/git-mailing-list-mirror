Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF06FC3
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497590; cv=none; b=Zam2WoMoer3MRSq3Ft3KFTEkGqmfutGlRvHKkuhRILt8O+Mc2IRjyAif7yRhETzdwGd0jQDe9a0vfVUY4xFwfvNZPpSV1QUZd3XiiFVouHW/KmMWuGPOBk+fQfro1edIQ1l7Jx76OCheBfRmzy73/fYiOocAevsCkH7BN1DsLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497590; c=relaxed/simple;
	bh=gcTTCM79ln2TpFkqoRABCtrhE7wLB8WJVUH76qUctAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAGbpjbjLcahDPlZGJZc1mO2xlB7EcmOoNNzYCtLZl86lU7qVUMDmzJZBUT4PHTv0tftHKobKGUY9OGBdCpAzSc8fGHelR3WAYqL3Ww1UCDUaWQIwPwWDFFGowWrhW79pp/LfAB6woM68DwfZTRONuYbzfZKbuG3VetgAce0kBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22003 invoked by uid 109); 4 Jun 2024 10:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:39:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18785 invoked by uid 111); 4 Jun 2024 10:39:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:39:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:39:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
Message-ID: <20240604103947.GC1781455@coredump.intra.peff.net>
References: <20240531120034.GA442032@coredump.intra.peff.net>
 <xmqqh6eehvj4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6eehvj4.fsf@gitster.g>

On Fri, May 31, 2024 at 08:05:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The "int" in question is in add_patterns_from_buffer(), so we could
> > catch it there. But by putting the checks in its two callers, we can
> > produce more useful error messages.
> 
> Nice trick.  I wondered if we want INT_MAX/2 or something even
> lower, but because once these things are read, we only parse the
> contents so allowing up to INT_MAX is fine.  It is not like we read
> this and that and concatenate them into a larger buffer.

Yeah, I think all of the individual string lengths would be fine. It
_might_ be possible to overflow an array of pointers or similar, though.
E.g., if you have "a\n" repeated INT_MAX times, then you have INT_MAX/2
entries. An array of pointers-to-structs, assuming 8-byte pointers,
would then need INT_MAX*4 bytes. And indeed, I think we stuff these into
a pattern_list which uses ints.

In practice I think the call to ALLOC_GROW() would catch that as the
overflowed value turns into a large size_t. But it probably would be
safer to use a much smaller limit.

I was hoping to avoid making up an arbitrary number. But your question
about gitattributes reminded me that we already did something similar in
3c50032ff5 (attr: ignore overly large gitattributes files, 2022-12-01).
There it's a hard-coded 100MB limit (without even a config option).

Maybe we should just do the same here?

-Peff
