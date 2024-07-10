Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A55A32
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571861; cv=none; b=ZWdpwYrheo3qR8+vmWEcr45F/mIHISjGwwii/Cjuzof3wpDvE05m9KhC21TRxY4el74ANQX8pcehblHc9NgCOqPlyZ+Plpt09LKvV0uY83OyMfp1iX/Qq6o2b/N+l8iir73mukVWz4pIPdXV09UCTMn/t3WKAMWILWO3lMYi91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571861; c=relaxed/simple;
	bh=cCeuI4g7spfD5yxWEos1NZn1H07d/jULDUp2YTGo+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMoxJ6rYyE2ZIaO/c+b6gQ/Rz7ryAaMhckGZJ7kCfQ+GDLyGA9Wj+WtvcPqAzoqY2P/5TSdCGoysR5cWUcmOj8iod8GfAxJ5xNzWUPWM+BLMqTZyUU1a9qHGK1n9CPKbLkJ3ASIBdNY/kY2blaKTXqDu1SKauHUq1VuGC/iJ9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31082 invoked by uid 109); 10 Jul 2024 00:37:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 00:37:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6632 invoked by uid 111); 10 Jul 2024 00:37:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 20:37:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 20:37:37 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240710003737.GA1526498@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g>
 <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
 <20240708090837.GD819809@coredump.intra.peff.net>
 <CAPig+cRzJXPa07wBXibCjfZ_uYtbAnRnOsXFrbMbCqRfwSxszg@mail.gmail.com>
 <CAPig+cTUsLHnCKcVMGTGUFXX85bDgMOAuvb6uXmDqpB3XswHcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTUsLHnCKcVMGTGUFXX85bDgMOAuvb6uXmDqpB3XswHcQ@mail.gmail.com>

On Mon, Jul 08, 2024 at 04:17:46PM -0400, Eric Sunshine wrote:

> By the way, regarding your 4s instead of 200ms result, I don't think
> that is necessarily reflective of what can be achieved. In particular,
> to properly measure the effect, you also need to remove all the
> threading support from chainlint.pl since using "ithreads" adds a
> not-insignificant amount of time to script startup, especially on
> Windows, but even on Unix it is quite noticeable.

Yes, that is the low-hanging fruit I found. ;) Just adding:

  $jobs = @scripts if @scripts < $jobs;

cuts the time to run all scripts individually from ~4s to ~1.7s.

Removing the threading entirely goes to ~1.1s. I hadn't tried that until
now, but it is probably worth doing for the case of $jobs == 1.

-Peff
