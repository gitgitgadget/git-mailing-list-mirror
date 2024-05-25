Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3470138E
	for <git@vger.kernel.org>; Sat, 25 May 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716612877; cv=none; b=uSv5VJFWgg9+MaO0hlD+m4hRw7vVWs8xdYM7KOJC3ntVdir1KJd9I3Ap8oaRChJTvDDIA1EM1BRJ7hJi2CrRebBLWaAGfIEMS3LwMkbpTWURAY4OeK0J0A2SLzNavpP4xmrIS93oI4/viSP8i9LtHvbOx7bmGLzOgNFltYpQPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716612877; c=relaxed/simple;
	bh=SMmPa2TkZnAKPEgfI+SzsQBo24X1iXIIO/12WmwGmcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIQbZrfnz8U4CX5pomguRYQ2k5uvEG603mNLkG7Jkf1a2gqG0BPWDBaZALhzYNAnVjgQNEsmAQa6BIIaag8waR7C2QVDQJzp9qq+ze+lYzx/9fQJtqwLMMAXpWnsCW7ydc+xKyswgGgAWWh0qEt37R+glsPEWib6Cyh0oRiVfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4032 invoked by uid 109); 25 May 2024 04:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 04:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15996 invoked by uid 111); 25 May 2024 04:54:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 May 2024 00:54:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 May 2024 00:54:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
Message-ID: <20240525045434.GC1895047@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
 <xmqqjzjky6eo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzjky6eo.fsf@gitster.g>

On Thu, May 23, 2024 at 07:00:47AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do still think it
> > would be useful to be able to configure its pager separately (in my
> > case, I'd use "less -FX" rather than my default setup, which doesn't use
> > either of those options).
> 
> Even better.  Allow to optionally have the command after the option,
> e.g.,
> 
>     (1/1) Use this hunk [y,n,q,j,k,e,p,P] P<RET>
>     (1/1) Use this hunk [y,n,q,j,k,e,p,P] Pless -FX<RET>
>     (1/1) Use this hunk [y,n,q,j,k,e,p,P] Pcat<RET>
> 
> The first one feeds the default program with the hunk via pipe, the
> second one instead invokes command you specifed, "less -FX", and
> feeds the hunk to it via a pipe.  The last one emulates a plain 'p'
> behaviour.
> 
> And for usability, perhaps giving a specific command would change
> the default program a bare 'P' invokes for the rest of the session
> until another specific command overrides.  Another usability hack
> may be "[interactive] pipecommand = less -FX" configuration variable
> gives the initial default for each session.
> 
> At that point, we can explain it as
> 
>    p - print the current hunk
>    P[<program>] - pipe the current hunk to a program
> 
> or even use '|' instead of 'P'.

Ooh, I like all of that (including "|", which is what triggers the
similar feature in mutt). If interactive.pipeCommand defaults to the
usual pager, then a bare "|" would do what most people want.

-Peff
