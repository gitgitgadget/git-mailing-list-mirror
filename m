Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16107194080
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072215; cv=none; b=rHNgKyND+X+rc3FcvxyqV319AsSuLIqM9dJbZeyKDpBKg79nEf2Sh8yU1vfQB71+qBCmaR4zjjIFAG4p5QF5z/tRuyXq6NLEl4xtj0jq3W7VEDZcwoSPrFdHcgf+v7jzb82wV6MZWoA85wDtIikQhKijah9Cuzz07w2lQH8Btcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072215; c=relaxed/simple;
	bh=FpMIgTUwubdA6WSDiQrYvpOSBydP5TQ6P6aAOCm1v8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNywZvPLN9HUT3GuKYsLHN9VbxizZ4dJ8bFkN3+9XI0pfOEAGWRwC7W3fd1RRyEUYkeckM/Mxv0ojwZoE0BhWu1ANfiQu04X6yUOkgkwxH3Kh4/qf7keZhEkKuLpzF++1OY4SdV0WQYEFn00968gR7crR1aDisOtle1PlrsnlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VDbhLLMz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VDbhLLMz"
Received: (qmail 9265 invoked by uid 109); 4 Mar 2025 07:10:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FpMIgTUwubdA6WSDiQrYvpOSBydP5TQ6P6aAOCm1v8c=; b=VDbhLLMzELHnFepWmTuiA7tJVwM2dFG9UBLWLaiumZfGbVdKY25AtIGJQxabhzJ9xoio22/RAYf3h8CATiifG5my0dQVN7pVV9VbJs+K3bu0v7+yfGwCiFz2yVdPDT8HZUj4gbgJYw/exDULQM6TBNeLnAF6OCh7VgR3Rv2zTqIsmZN3BXWPeP8E1jZewPMFvMMKATi5NBb2ogb4wCGOAf2G+GqX1Qrhx8J8CQd6By1Q+lHw76VA+xydLnUxm4U7G6feS9uW4jXDdgXqKj5WoMpFZim1a3g4pvFTSURgaF5d9G2i/9njIo4Ig7R1n132SBOMwo1xf2fbF3uPnoxbfA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 07:10:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22456 invoked by uid 111); 4 Mar 2025 07:10:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 02:10:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 02:10:11 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] unpack_loose_rest(): rewrite return handling for
 clarity
Message-ID: <20250304071011.GB1283943@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063421.GJ1293961@coredump.intra.peff.net>
 <Z8EFGnUmyAAJ6DUY@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8EFGnUmyAAJ6DUY@nand.local>

On Thu, Feb 27, 2025 at 07:36:42PM -0500, Taylor Blau wrote:

> On Tue, Feb 25, 2025 at 01:34:21AM -0500, Jeff King wrote:
> > This should make the logic a bit easier to follow. It does mean
> > duplicating the buf cleanup for errors, but it's a single line.
> 
> At least to my eyes, I actually prefer the state after 9/10 and would
> probably be OK to see this patch get dropped. I wish I had a compelling
> reason *why* I felt that way, but I think it may too subjective.
> 
> I don't feel strongly about it either way, though.

I also don't have a super strong feeling, though I fall on the other
side of the line (which is why I bothered sending the patch).

If we didn't do that, I think the alternative is probably a comment
like:

  if (error1)
	error(describe error1);
  else if (error2)
	error(describe error2);
  else
	return buf;

  /* if we didn't return above, we saw some error */
  free(buf);
  return NULL;

I dunno. I'd probably stick with what I send. ;)

-Peff
