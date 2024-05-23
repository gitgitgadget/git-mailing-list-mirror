Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D313D260
	for <git@vger.kernel.org>; Thu, 23 May 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457007; cv=none; b=TWHcsEEot/v+bQATN+gCf+oALBr5aKX4vxQIWvgJ7RPXxnBJgJA7CUsea2iG6qodXOiQ4+pdojIBBhz/KkfqZPHNu5P/BitZx4RgdeF/OJ+NwQJyiNhOG3aQ8u0ogWwFS2wF6PutlpYYPPAFPvED4nnV8+FtnHauqtsE9IP+X+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457007; c=relaxed/simple;
	bh=bcmsTu2L5ysp6rBWnAfc63yolTr3GG7RoEAiQlQm4DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J84XOHsyEbFiyBub2eRHzpYWECxfSLAqEoMN82GuCkvJcCiiPumsNje2GD4Vcy+p6qDzjFG+0jAPjsMxJR+5EXON60nGt2a7noQbjzFkwiSdCSyTsbZ7zAcBuogdc+hiK0v3eqJ/id9ogVtSBlJX/XTiqE4fVQCv3i/ISHkMOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31192 invoked by uid 109); 23 May 2024 09:36:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 09:36:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28628 invoked by uid 111); 23 May 2024 09:36:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 05:36:49 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 05:36:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
Message-ID: <20240523093643.GG1306938@coredump.intra.peff.net>
References: <20240510172243.3529851-1-emilyshaffer@google.com>
 <20240510194118.GA1954863@coredump.intra.peff.net>
 <CAJoAoZmdU281buNTm+K0wHMunsbzbZ6NXFdqh=PkDUwQKfpYEg@mail.gmail.com>
 <20240516071127.GA83658@coredump.intra.peff.net>
 <xmqqwmntra3f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmntra3f.fsf@gitster.g>

On Thu, May 16, 2024 at 09:32:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   - the opposite approach might be: stop using any allocating functions
> >     in the trace2 code. There's a certain simplicity there, even for
> >     non-signal functions, that we know we're just touching a few
> >     fixed-size buffers, and you can never create a weird DoS by tweaking
> >     the tracing code. But it would mean rewriting a lot of it (including
> >     json formatting stuff) without many of our usual strbuf niceties.
> >
> >     This is more or less the approach we take with error(), die(), etc,
> >     which are built on vreportf() and its fixed buffer.
> 
> Would another approach be to add various trace2 functions that use
> strbuf() allocation a way to tell if they are called from a signal
> handing codepath, and punt (by doing nothing if needed, but
> hopefully we have enough slop in the buffer to say "hey we got
> interrupted so no more detailed report for you, sorry") if that is
> the case?

We do use that "in_signal" flag in other handlers. E.g., when
run-command avoids calling free() in a signal, and the tempfile code
avoids using stdio. But in the case of these trace functions, I think
they'd all need to be rewritten to avoid strbufs. That message
formatting is the whole point, and there is no way to have a strbuf
which truncates rather than growing (though it is something we've
discussed).

So I think we either need to rip strbufs out of most of trace2, or let
these signal paths re-implement the formatting in a super-simple way.

-Peff
