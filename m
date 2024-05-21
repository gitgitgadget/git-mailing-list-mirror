Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D37F
	for <git@vger.kernel.org>; Tue, 21 May 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275284; cv=none; b=An4nglVoT/oTGGbXllfNIVD68ARr/8ogJvWgOL7b9GKVHHet4GEql8RanPlMulQtvRiCu3MImdlsNDWfyhgnMi1RVpI8rED5VacPod5z5hBVlLa0MCThOzCERLclDTV4g87iY8ueaRrpZsvBdHjR641Cjbd6cOL2DzmifgMRaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275284; c=relaxed/simple;
	bh=W6FSvvJAnJgFMR/fLo1xTzh/Da66qSmfZYPIqduRqV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZj9xn6tlTz4aMzt9CBJFmq2etsZ2uqLRwsG7t/dsuBDR2KsfjrYR4e8fV8kxeZCKFAx9LgIF4XEKZebPsMHnjJgX3nnw/bB/6h0ARrD6kipfzFaj5vqZAAtaf+DsBPpE+YpB/DESReAfpOeozv3SyXXccyd5Rp9/VivurJP49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21310 invoked by uid 109); 21 May 2024 07:07:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 May 2024 07:07:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6403 invoked by uid 111); 21 May 2024 07:07:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 May 2024 03:07:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 May 2024 03:07:52 -0400
From: Jeff King <peff@peff.net>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
Message-ID: <20240521070752.GA616202@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>

On Mon, May 20, 2024 at 09:45:51PM +0200, Dragan Simic wrote:

> > Another, ulteriour, motive here behind this suggestion is to
> > encourage users to work with smaller hunks.  Being able to scroll
> > around and view lines on demand (i.e. use of pager) is one thing.
> > Being able to view all relevant lines at once (i.e. not wasting
> > vertical screen real estate and making things fit on one screen) is
> > very different and much nicer.
> 
> There's another thing to consider, which makes the introduction of
> "P" as the new option even more desirable.  Let me explain.
> 
> With the upcoming changes to the way less(1) as the pager works,
> which was already discussed at length and even required new features
> to be implemented in less(1), [1] displaying anything through less(1)
> will not leave an accessible scrollback in the terminal emulator.
> Only one screen worth of text will be displayed, even after quitting
> less(1).  That's what we have to do, to fix age-old issues with the
> pager-generated scrollback that easily gets corrupted and actually
> becomes misleading.

This feature can be annoying even with current versions of less,
depending on your $LESS variable. If you don't set "F" you'll get a
pager for short inputs, and if you don't set "X" then even small hunks
are cleared from the screen while we ask about them.

So this definitely needs to be configurable, and I'd be tempted to say
it should be off by default, just because we don't know how the user's
pager will behave when invoked for multiple short snippets like this (it
might not even be "less", after all).

I don't think setting pager.add is enough here. You'd also need to set
pager.checkout, pager.reset, and so on, since their interactive modes
all invoke the same code. We'd presumably want a single config option
(and possibly even one that could be set to a distinct pager command for
this context, rather than the usual one).

-Peff
