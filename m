Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93855A3D
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453041; cv=none; b=AFzctaFEwcPsKSeZzqeyRJbUvEF9TJ9X72gHhTG7P0QM/YlfUgjJ4RRSvzOmdyH51fyXhOX5jU/9QS+kf81au7nVinOnjXHbxlcbcgEAUcIvvL0ZbKwMpHXPkDa5S00tv0sxACrSMhR8eIAERvUv+j6adb+42hGhQ9TRJqCmkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453041; c=relaxed/simple;
	bh=YSYRXrx9pYVtfJzidI7zZZAb8JGmTGujQ8u9+q/mhT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVuAHzij6Vo2m/2nPeOjmEASdE/4zo+bMabg1aMWp8FOZxjEyftqgCKXCyTUUmmqdReC8mecg4bCL0fohsqCkBKgrDegljGq7sjKuLKOEVD9wl9UbNrLRrmwmik8ui1c4AqPIVyfPTUJVlRJMNrnqPW7gt746vDST+O62hqlJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8097 invoked by uid 109); 7 Apr 2024 01:23:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:23:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11530 invoked by uid 111); 7 Apr 2024 01:24:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:24:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:23:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] CodingGuidelines: quote assigned value with "local" and
 "export"
Message-ID: <20240407012357.GB1085004@coredump.intra.peff.net>
References: <cover.1712235356.git.ps@pks.im>
 <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
 <xmqqmsq7yezc.fsf@gitster.g>
 <xmqqbk6nyej1.fsf_-_@gitster.g>
 <20240405174859.GE2529133@coredump.intra.peff.net>
 <xmqqr0fjtxei.fsf@gitster.g>
 <xmqq4jcftn82.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jcftn82.fsf@gitster.g>

On Fri, Apr 05, 2024 at 04:15:57PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> I think that is a good rule for "local", but I thought we did not allow
> >> "export foo=bar" at all, and required:
> >>
> >>   foo=bar
> >>   export foo
> >>
> >> If that was only because of this bug, it would be nice to loosen the
> >> rules a bit.
> >
> > That rule in Documentation/CodingGuidelines predates the discovery
> > of this bug.  I have this vague feeling that it was for the shell on
> > old Solaris, which would not matter to us anymore, but I do not
> > remember.
> 
> Heh, I do not even see any such rule in the guidelines.  What
> enforces it is actually in t/check-non-portable-shell.pl script.  It
> came from 9968ffff (test-lint: detect 'export FOO=bar', 2013-07-08),
> which in turn comes from https://lore.kernel.org/git/201307081121.22769.tboegi@web.de/

Yeah, I noticed it was not in CodingGuidelines, but did not even realize
it was in the linter. Thanks for digging up the link, though sadly it
does not say which shell had a problem. I could very well believe there
is no such modern shell, but I don't know how to test that without a
weather balloon patch.

> We make multiple uses of it in ci/*.sh but the environments ci/
> scripts are used in are rather sterile, so they do not quite count
> as a proof that the problematic shells no longer exist.
> 
> We may instead want to add a separate rule e.g.,
> 
> 	/\blocal\s+[a-zA-z0-9_]*=\$/ and err q(quote "$val" in 'local var=$val');
> 
> to the check script.

Yeah. I think matching \$ is probably enough to catch most relevant
cases without complaining about the innocuous:

  local foo=bar

It would miss:

  local foo="bar/$1"

I guess "=[^"]*\$" would be a bit more aggressive.

-Peff
