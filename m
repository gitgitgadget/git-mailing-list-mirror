Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213C13D53A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505089; cv=none; b=Y5c/y26IfwsJo0twdoW5aFM5N4O0zGoYe1P3t/tOK7cXCPjg5H7gEBzHI0FHBUaA1e2R151CHsbBWlUq5PE3QJ79Z04cIw0Y8p2+dRnP2dz3yMnoDWA359G8ghb9nKgQKgjAR3dKUbyGlB56Bqe8otoWa8Z7ly1Wj6VBIqsqXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505089; c=relaxed/simple;
	bh=S5KQLIuGrhYXJWTqm/OM3tHzAccfz2ZcUFMesq8Q1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5+4nhZcECT9dFkWbKkgyek1V8Al3p4+2YHgDAVfoUPh97eRYP0ckYDEN4OEtFmctb9t+90XgakdwTDhiYS8Upsvc5DPKTjmwlLaULKiPp13YcMlTfEodEj7dNPf5LC664VLQmk7XQt21ZeeEXm1sZw0CHe932iZkB5xKOfnHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18757 invoked by uid 109); 1 Aug 2024 09:38:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 09:38:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30190 invoked by uid 111); 1 Aug 2024 09:38:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 05:38:10 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 05:38:05 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/19] midx: teach `nth_midxed_object_oid()` about
 incremental MIDXs
Message-ID: <20240801093805.GE1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <ec57ff434900f2b95e31fbdf854b5ebbf46b5c78.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec57ff434900f2b95e31fbdf854b5ebbf46b5c78.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:10PM -0400, Taylor Blau wrote:

> The function `nth_midxed_object_oid()` returns the object ID for a given
> object position in the MIDX lexicographic order.
> 
> Teach this function to instead operate over the concatenated
> lexicographic order defined in an earlier step so that it is able to be
> used with incremental MIDXs.
> 
> To do this, we need to both (a) adjust the bounds check for the given
> 'n', as well as record the MIDX-local position after chasing the
> `->base_midx` pointer to find the MIDX which contains that object.

Yep, this makes sense. The hard thing about reviewing this, I think, is
that each individual step like this is going to make sense, but I'll
have very little clue what spots (if any) were missed.

To some degree I think the proof will be in the pudding. If you missed
any helpers, then the end result is going to crash and burn quite badly
when used with a chained midx, and we'd see it in the test suite. And
the nice thing is that most of this is abstracted inside these helpers,
so we know the set of tricky places is generally limited to the helpers,
and not arbitrary bits of midx code.

-Peff
