Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAACC84FDA
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578579; cv=none; b=Yz6oV3lQRINGtmzUjlwqPTYu/ihCv/HiEeFSoHg5t/2VbXHIkH/VVbqHn8wfvAGkx1w1KvunOl204EgmrUmcF2CHpx5VQiTiyHBQWz4/bM9DZ8YBm4XD/WIUjd/kBsQUyIEnAdyvdJOGYKRjhcPoeJwXGwNtOCKGy0leOO8HN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578579; c=relaxed/simple;
	bh=j1Y3Iu+tkBcBOlyuGpfAnFmYztQBdnN+OjG6emyYEVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI9tNdSj23Q4O0FTE18FyNv1uFo2C5htwpHrkk64K0CeC02qrGCLblQ6aP4ll9r53g2bmGNCrNekYrvgD9k0uBfI9lZnIpyRPn76ZLegcFbYd6YW7NqOMYjtomXX2VbCJxaKWMVQVyq/yWt8nutquH7u9ICpCJ7KtPoKA+L/KW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24771 invoked by uid 109); 5 Jun 2024 09:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 09:09:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28121 invoked by uid 111); 5 Jun 2024 09:09:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 05:09:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 05:09:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
Message-ID: <20240605090935.GF2345232@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikyo207f.fsf@gitster.g>

On Tue, Jun 04, 2024 at 08:32:04AM -0700, Junio C Hamano wrote:

> The default that colors the output is something we might later
> regret.  Those who want colored output can always use the
> interactive.diffFilter configuration, but I am not sure if going
> the other direction to strip coloring is just as easy.  But other
> than that, I think we are at an OK place to stop.

I don't think diffFilter is a great solution there. In my experience,
that is augmenting the existing coloring done by "diff --color" itself
(and of course many people do not use a separate filter in the first
place, and just see the normal color output). So there's not an easy way
to add the color back to a stripped version.

The interactive-patch code is literally holding the two color/non-color
variants in memory, splitting the hunks based on line counts, and then
showing you one and applying the other. Even if you wanted to run "git
diff --color" yourself in the "|" command, it would be a lot of work to
pick out the hunk of interest.

Given that the main use case for "|" is for human viewing through a
pager, I think the colorful, filtered version meant for users is the
best default. And then the "bare" version can come from an alternate
command or a knob.

Just to note some prior art, mutt's "<pipe-message>" faces a similar
problem. You might want the raw message (if you're going to poke at
headers, MIME parts, etc yourself) or you may want a decoded one (if you
just care about body text and don't want to deal with base64, qp, etc,
yourself). They provide a stateful config knob, but then you end up with
horrible macros that toggle the knob, like:

  :set pipe_decode=yes<enter><pipe-message>my-script<enter>:set pipe_decode=no<enter>

I think having two separate commands for the two modes would be less
confusing.

-Peff
