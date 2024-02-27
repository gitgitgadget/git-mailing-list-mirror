Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F255E57
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021256; cv=none; b=IV3Q2g7nSKjtjWNN4Q135P//MpoF96QL3DZwtBmxv4p1TP/GqkAjm3xn4KAQZuDwfcTk2BcsyTbcrqeZ7KcQmNFryNQM6ji9h94ZqtThucb1pvBCJkBQVJKAAyZLnSTM97GNZ73T6WuYKFGZomFSfZLlNaI+DWyHj1YwPxO3hK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021256; c=relaxed/simple;
	bh=06l/tvZlOiAosimjjQeqA1NZSDoPdX24QP9WuceLP9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxF28OrKvVj0nEmVD/j2/AtJxnYISVTeuUdA2WxrVbSUr2fPDdo7xfrPttZ8S/F/6jKsZONnk59Vkz+yaG/KyC6wLhJN4lRQr3IwSc5EG+z6ah5tl/Eel93956u0urHRVGO8lk8aPOci+co7uNnvMYxyQK6pz8djk8+tqrerm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11101 invoked by uid 109); 27 Feb 2024 08:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 08:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7309 invoked by uid 111); 27 Feb 2024 08:07:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 03:07:37 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 03:07:32 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty
 reflog
Message-ID: <20240227080732.GG3263678@coredump.intra.peff.net>
References: <20240226100010.GA1214708@coredump.intra.peff.net>
 <20240226100803.GC2685600@coredump.intra.peff.net>
 <20240226101027.GA2685773@coredump.intra.peff.net>
 <xmqqh6hvcf3n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6hvcf3n.fsf@gitster.g>

On Mon, Feb 26, 2024 at 09:25:32AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That's one of the reasons I split this out from patch 2; we can see
> > exactly what must be done to make each case work. And in fact I had
> > originally started to write a patch that simply changed t1508 to expect
> > failure. I could still be persuaded to go that way if anybody feels
> > strongly.
> 
> I do not feel strongly either way myself.  It just is interesting
> that the older end of the history is with @{20.years.ago} special
> case that is only for time-based query, while the newer end of the
> history is with @{0} special case.

I laid out my thinking on the 20.years.ago special case in another
reply, but I wanted to say one more thing. The special case here in
patch 3 is making @{0} work for the empty reflog, but there is no
matching special case for time-based timestamps. If you have an empty
reflog and ask for @{20.years.ago}, you will get the usual "nope, the
reflog is empty" response (as opposed to having a non-empty reflog that
cuts off before 20 years ago).

Obviously we could make that work, but I think the point is that "@{0}"
is special magic for "the current value" in a way that a timestamp isn't
really.

-Peff
