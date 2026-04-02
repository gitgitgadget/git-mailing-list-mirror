Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FD227B94
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 03:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102150; cv=none; b=AjvXWioy/Oi9sQkjk7ObQ7EYogd4bJOAYS2HR8mhrjtJ8r2ZwBRAnqySnKJP71GvlueiRU70tYsrZAr3l/GIs4NPDHppL9QGVsotwPAOE7iXghTMBOYgYvGSblFvsXMhvY00NOH/7JSIJcQedM49vDZblTiU8u9llrtyiUSvgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102150; c=relaxed/simple;
	bh=sfeiwYugoEnTx0x2v5UFqPOSWogw1KcuSXxWw+khF+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWFr1nmLHEUeyOXDvZI4S9IcrQoGTIWo5k56zSxA2n6/wMLXkEzklbcG21LEwQY39aqhjLVwLS4pgNFZInfNHGdwkHw7OZo2mi8n+/6zQfuFtwl5NWJWdAW34ygZ8+ZWWVPM+ownF2WU9DaMNOkh8mnMPwCSZg9XZszD2UtZOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dPS1l1W/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dPS1l1W/"
Received: (qmail 218567 invoked by uid 106); 2 Apr 2026 03:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sfeiwYugoEnTx0x2v5UFqPOSWogw1KcuSXxWw+khF+4=; b=dPS1l1W/s0HrM9WKlOUL4T0AW8+lwBLXhFzjTIm5pj7isnZZjSn0Ymasoxx5vMVxxN87/P6u1zE1ln0gXuD9GvpzsYHw8E+FOP+WRtVs2U9T6cqT1p0WR68Z8MjeLsBxyBIEAz00GKF///2a3b0c8sixl71D2oO//BbrNp2RqQKSCNPS99SvtxB2FODxtwma3CAS1K9djLzjjc9xUhqHQeGj4uwKUSo/nyWX8KMnHJS8967npNETFUlgD3f3RXfcOvOqncWs8XjsxK01YuAhhNDj/PQe6fj6ngmnP5lKxxAb0JtTQp4TigKlg9HVDRMulQhVHrA39KhoKwpQ5QkETA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 03:55:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349472 invoked by uid 111); 2 Apr 2026 03:55:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2026 23:55:47 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Apr 2026 23:55:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 09/12] pkt-line: make packet_reader.line non-const
Message-ID: <20260402035546.GB3492642@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235136.GI2328529@coredump.intra.peff.net>
 <xmqq4iluuxxg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iluuxxg.fsf@gitster.g>

On Wed, Apr 01, 2026 at 03:18:35PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The "line" member of a packet_reader struct is marked as const. This
> > kind of makes sense, because it's not its own allocated buffer that
> > should be freed, and we often use const to indicate that.
> 
> This is interesting.  Once we go down this path, will we rethink the
> use of "const" as "not ours" hint (which I always found confusing)?

Maybe. It is already a weak signal, so I consider it more of a hint than
a rule. I think it probably applies more consistently to the return
value of functions (most things returning "char *" probably are passing
back ownership).

-Peff
