Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283D1D554
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868606; cv=none; b=e+B+LMCBKsr6RjXDkPnJXSJejmEGK8xAj1VTZrkbb2p8r6/4cO0JudsAvObmHMAZM84p9n9SGWEfTVD2996Jbb+eRfNLJeqGHUJpytFQ59O8rVtqx3fiV75R8pz4rO1wLN3Bq+1ZssARPxv+yJwCzrxGQ6c8vEzTOzaXsX/KccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868606; c=relaxed/simple;
	bh=sFzcpAbrYXbzPhf9tDjTymxgELlDm+IuO0twRaCa7Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr5iiYdQc0Cfr+KKie+B04r5sqc3LCdkO40C3kKW870OOSOcrEsHE+CYiqyVhsFC6SKGFcoCdsL9VAtMh3IhlkVDiWcVWDoVJL8jyJ3A90H8yr/Ttzyol0neSUzu7A8a2a1/X0dRHv4D0NI8fXT0cIO+NzPHvJB0qX6bA+TrhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26543 invoked by uid 109); 28 Aug 2024 18:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 18:10:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29911 invoked by uid 111); 28 Aug 2024 18:10:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 14:10:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 14:10:00 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] reftable: mark unused parameters in empty iterator
 functions
Message-ID: <20240828181000.GA4034725@coredump.intra.peff.net>
References: <20240828040944.GA4005021@coredump.intra.peff.net>
 <xmqq34mo1si1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34mo1si1.fsf@gitster.g>

On Wed, Aug 28, 2024 at 10:12:22AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This should go on top of ps/reftable-drop-generic. Arguably this could
> > have been done as part of the conflict resolution when merging into next
> > alongside jk/mark-unused-parameters, but at this point I think a
> > separate patch is the best way forward.
> 
> As marking with UNUSED used to be optional before -Wno-unused-param
> got removed, I agree that it is better to apply this on top to be
> explicit, rather than burying it in an evil merge with a topic that
> marked other unrelated parameters as UNUSED.

[warning: philosophical rambling ahead]

The reason I mentioned the merge here is that I think you could argue
this is a mis-merge that already happened. Forget for a moment the
recent series that makes UNUSED non-optional, and consider the merge of
jk/mark-unused-parameters and ps/reftable-drop-generic.

The former updated code in reftable/generic.c, and the latter removed
that file entirely, so there's a conflict. And it's tempting to say "ok,
we don't care about this code anymore, so take the deletion", which is
what your merge did. But the code in question was actually moved in that
series, via f2406c81b9 (reftable/generic: move generic iterator code
into iterator interface, 2024-08-22). So I think the correct resolution
for the merge is to move those updates along with the code into the new
file; otherwise we are accidentally reverting part of what
jk/mark-unused-parameters did.

That said, I think you can get pretty philosophical here. Did the
reftable topic move the code, or did it delete some old code and add
some new code that needed the same change? :)

I also think it's pretty hard to notice these kinds of resolutions in
practice. There's a conflict at the point of deletion, but there's
nothing in the merge workflow that tells you "btw, this code is now over
here, so you should port the modifications from the side branch over".

Interestingly, I think a rebase of one topic onto the other might have
made it more clear, since the code movement happened in its own step
(which would make what was going on more obvious). I guess Michael
Haggerty's "imerge" would probably show something similar (actually, I
just tried it, and it indeed hones in on f2406c81 and 4695c3f3 as the
source of the conflict).

Anyway, I am not proposing to do anything different. _If_ we considered
the merge of the two topics that is in next to be an incorrect
resolution, we could repair that when merging to master. But I think
doing so is complicated. And certainly the philosophy of "if something
is tricky, try to be as explicit as possible" seems like a good one
here.

Mostly I just found it kind of an interesting case. :)

-Peff
