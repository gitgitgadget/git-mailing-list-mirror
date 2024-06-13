Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F431422CC
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274252; cv=none; b=SmkWsogX0n6hZ39ZckcbRxA+wZS//o/gS+U8fxSzWJQW8BVRMHAtRtf0deop7Z5si7hXM6Fy7iyBaiojB8y4/AtAzXxv2tVaDQ1Utf5GfKQ/Lb01L3V97PdwumszDF7M9uLMVbsnF8lyfXVJCR9XSXntKsJ/CUXcBAWK5WeZkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274252; c=relaxed/simple;
	bh=Dn78z5TkS7hvu2QbYB7sEOu6gbGwn9g8h+2VKZH7vhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRPHAGKpqvcm4N/ikv2mrmWfUwkUifAsZi9zDXkfv3b8w+Sg5+NH5tkSuNKeI+IuNjTMDxduXHfP98sMmUlIZqEuQZBIOooHI3GLqTg7SFFCI+Le2ApVd8o4/haXZP/VLoSNLhw9JPq9UgDKnxUf1V7VMcslgqC9gbwnOUHBST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26504 invoked by uid 109); 13 Jun 2024 10:24:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 10:24:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16004 invoked by uid 111); 13 Jun 2024 10:24:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 06:24:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 06:24:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: Re: Cannot override `remote.origin.url` with `-c` option
Message-ID: <20240613102409.GE817573@coredump.intra.peff.net>
References: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
 <20240611075137.GF3248245@coredump.intra.peff.net>
 <xmqq34pjxzva.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34pjxzva.fsf@gitster.g>

On Tue, Jun 11, 2024 at 08:28:41AM -0700, Junio C Hamano wrote:

> >   2. Is there a way to override the list?
> >
> >      Sadly, no. For some config keys, we allow a value-less boolean
> >      entry to reset the list.
> 
> Hmph, I somehow thought that a more widely used "clear" was an empty
> string, but if we can make the convention around the "I exist and I
> mean true" entries, that would be great.  It would not make much
> sense to have multi-valued Boolean variable to begin with.

No, you're right. I was just misremembering (maybe because "--no-foo" is
the command-line way to reset the "foo" list). The three instances of
config I found (merge.suppressdest, http.extraheaders, and
credential.helper) all treat the empty string that way.

The multi-valued boolean thing would cover config keys where an empty
string was semantically meaningful, but I wouldn't be surprised if we
never run across such a case. So probably using "empty string is reset"
as the convention is fine, and matches existing cases.

> > diff --git a/remote.c b/remote.c
> [...]
> 
> I was expecting (with excitement) a mess, but the above is as clean
> as we can make the idea, I would say.  Lack of documentation and
> tests do count as incompleteness though of course.

Yeah, and we should probably do the same for pushurl. And I think there
could be some cleanup of the memory ownership handling of add_url().

-Peff
