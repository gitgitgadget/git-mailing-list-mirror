Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F01C280
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23488 invoked by uid 109); 16 Jan 2024 15:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jan 2024 15:14:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29211 invoked by uid 111); 16 Jan 2024 15:14:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jan 2024 10:14:47 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jan 2024 10:14:47 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] reftable/stack: refactor reloading to use file
 descriptor
Message-ID: <20240116151447.GD2119690@coredump.intra.peff.net>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
 <36b9f6b6240686cc5b0a761b889614fc31f01d34.1704966670.git.ps@pks.im>
 <20240114101424.GA1196682@coredump.intra.peff.net>
 <ZaUC-WevQqOj31u9@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaUC-WevQqOj31u9@tanuki>

On Mon, Jan 15, 2024 at 11:03:37AM +0100, Patrick Steinhardt wrote:

> > which means we'll feed a negative value to stat_validity_update(). I
> > think this may be OK, because I'd imagine the only sensible thing to do
> > is call stat_validity_clear() instead. And using a negative fd means
> > fstat() will fail, which will cause stat_validity_update() to clear the
> > validity struct anyway. But I thought it was worth double-checking.
> 
> Good catch, and thanks a lot for double-checking. I was briefly
> wondering whether this behaviour is actually specified by POSIX. In any
> case, fstat(3P) explicitly documents `EBADF` as:
> 
>   The fildes argument is not a valid file descriptor.
> 
> That makes me think that this code is indeed POSIX-compliant, as
> implementations are expected to handle invalid file descriptors via this
> error code.
> 
> So overall this works as intended, even though I would not consider it
> to be the cleanest way to handle this. Unless you or others think that
> this should be refactored I'll leave it as-is for now though.

Thanks for confirming. I think we can leave your patch as-is. If
anything, I would say that stat_validity_update() should check for "fd <
0" itself. Not because I think fstat() is unlikely to behave differently
on some platform, but simply because it more clearly documents the
expectation.

-Peff
