Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FC3BBCC
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371526; cv=none; b=Y1dNXGNtnznH8wthy1ZTn8T16WpDykwer2zNePXZEW+MD2tTm4H2HbWzvu+oXLkJcuiAiNDXp+wIBrYA/HyFbwjas4BCuVy0PsYu+FNd0xSHJf4bcjsvPd31jbJegGO4ABNVjzO15DGG5IY2RvUd2jySqiiCnWdrjQa1vGXfNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371526; c=relaxed/simple;
	bh=DpkXOEVc+icDISzvTub8IQ/jLRwitk90O8Q7vN+prw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG8ngCl4Bq+PI054v1rC3VVpTIjq9uKe7vY51rxJGYcbLTAAb+6PKaQV+FBK1xopkbTEQYzvtMNEEHLHBI/TOBu3T/NW0wNzlKxQk0vbwXl7q7EOdb6Lpy/wLIir2q1RJ/LLMUK27W6erdbp+nhrj7dO47M82VF5dYORq/GStyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18961 invoked by uid 109); 10 May 2024 20:05:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 20:05:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12326 invoked by uid 111); 10 May 2024 20:05:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 16:05:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 16:05:22 -0400
From: Jeff King <peff@peff.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
Message-ID: <20240510200522.GD1954863@coredump.intra.peff.net>
References: <20240510172243.3529851-1-emilyshaffer@google.com>
 <xmqqv83l4i86.fsf@gitster.g>
 <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
 <20240510194630.GB1954863@coredump.intra.peff.net>
 <CAJoAoZkXTo69AiowTVFvKyZBCo2B73hPp2ys+oZyOLU5qxAgFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZkXTo69AiowTVFvKyZBCo2B73hPp2ys+oZyOLU5qxAgFw@mail.gmail.com>

On Fri, May 10, 2024 at 12:49:06PM -0700, Emily Shaffer wrote:

> > We have test_match_signal(). Unfortunately it's not integrated with
> > test_expect_code(), so you have to do:
> >
> >   { thing_which_fails; OUT=$?; } &&
> >   test_match_signal 15 "$OUT"
> 
> Right, what I meant above is that `15` isn't portable, I'd have to get
> the correct int value of SIGINT/SIGSEGV from some other shell utility
> at test time.

Yes, but we already rely on it elsewhere (like t0005), and the idea of
test_match_signal is that it would convert from "standard" numbers to
something platform specific. Though aside from Windows (where the signal
number is sometimes lost entirely) we've never had to actually do such
conversion so far; "15" really is standard.

If your primary concern, though, is the trace2 output and not the exit
code of the program, then it may not be worth worrying too much about.

-Peff
