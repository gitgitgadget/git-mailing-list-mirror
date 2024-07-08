Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDA433DF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429721; cv=none; b=TMOS2WS2WAraCHScWOi0zI9No28yuWDmbxBUftfFk94XSOdrkKlNkQrjU6riuYHbmLdr6NW/W+tH9AEFVan4QYtleGdCi+asXqh+rAGWtmCfVMocBMBVEArF65bRC/9ScWFW3Ff+O0SrRr2r1RQUI35mpyJdks3XUCdUJYyBPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429721; c=relaxed/simple;
	bh=htPZ4BiWb6B7EEV2qR53BwnKU/ZBEOJ1+jf4BCQO8gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om/b+5S9Qn8fOn4oDCTGp9kJHdjlrmSRYenJzxHdHF0/lVK5US3EUB5eFYU2M9+StJk+A/LEs/yCMJRRDKxnSJRf/ErMLz4+VmA2OY8v18W970FZzBrdZR5oS4NG88sN4lkPxLKjL0VVuPB1sqnF8mUINKa0j6MyRUZSPuH8dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14174 invoked by uid 109); 8 Jul 2024 09:08:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 09:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20695 invoked by uid 111); 8 Jul 2024 09:08:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 05:08:36 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 05:08:37 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240708090837.GD819809@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g>
 <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>

On Sun, Jul 07, 2024 at 11:51:15PM -0400, Eric Sunshine wrote:

> >     I did manually verify that it is OK after my fix, but do we want
> >     that to be part of the chainlint tests? Just leaving the line
> >     numbers in is a maintenance nightmare, since it depends on the order
> >     of concatenating all of the tests together (so our "expect" files
> >     would depend on all of the previous tests). But if we wanted to get
> >     fancy, we could perhaps store relative offsets in the expect file. I
> >     think it gets pretty complicated, though, since we print only
> >     problematic lines.
> 
> Given the way the Makefile currently concatenates all the self-tests,
> it would indeed be a nightmare to retain the line numbers. In the long
> run, we probably ought someday to adopt Ævar's idea of checking the
> self-test files individually[*] rather than en masse. With that
> approach, it may make sense to revisit whether or not line numbers
> should be present in the "expected" files.
> 
> [*] https://lore.kernel.org/git/CAPig+cSBjsosRqoAafYN94Cco8+7SdUt0ND_jHS+jVPoM4K0JA@mail.gmail.com/

I took a look at running each test individually. It's surprisingly quite
a bit slower! About 4s instead of 200ms. There's a bit of low-hanging
fruit to get it down to ~1.7s (which I'll include in my series). But in
the end I punted on that for now, but did add line-number checks. Each
expect file just knows its own numbers, and I use a bit of perl to
handle the running offset.

-Peff
