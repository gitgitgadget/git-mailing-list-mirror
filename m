Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406F15C0
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712458057; cv=none; b=ZsWaxd7sL7UY4ISgSbxjy2DXDqpN/toCG4FpgPCVcT+MCLd0lKRdBsX39g5MOu0pIWChY24ICHqLd1bwX47xSVOBAC9EixJWQy0HaAb2iQ4nCFIbNCzC3Lemb6mI9Dxqq9RV8+JteFAdoMfTdBHG7GDV8di4LwfdNmQ2ncRZksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712458057; c=relaxed/simple;
	bh=ExFSQyZhvznM/u5Df3EePkb8B0QL49Ek/MTx26VPVko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odtZt8LY0PcD53UJ05PmTvG4pgC+gIrwSO6rOgDCgGWOH+k5odpenhH8MDt11pw2Jra5X23T/MQ8O9xK5x6K+ZZEmtPHwXzWbhVOWi9blNI0ScGCuc0qlYa+yBiXfFRWyjABBRgmNdK8aM2895vr49RbQNhUnnqBeT88rRHjN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9071 invoked by uid 109); 7 Apr 2024 02:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 02:47:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12184 invoked by uid 111); 7 Apr 2024 02:47:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 22:47:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 22:47:33 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH 06/11] config: use git_config_string() in easy cases
Message-ID: <20240407024733.GB1585186@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
 <20240407010228.GF868358@coredump.intra.peff.net>
 <CAPig+cST40pM5PdGA==o8aGFwv8kStzzC8=28NULUtV8OFJmLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cST40pM5PdGA==o8aGFwv8kStzzC8=28NULUtV8OFJmLg@mail.gmail.com>

On Sat, Apr 06, 2024 at 10:05:00PM -0400, Eric Sunshine wrote:

> On Sat, Apr 6, 2024 at 9:02 PM Jeff King <peff@peff.net> wrote:
> > config: use git_config_string() in easy cases
> 
> Did you instead mean?
> 
>     config: use git_config_string_dup() in easy cases

Oops, yes.

> > (like the one above), we can easily convert them to use a variant of the
> > helper that frees the existing value before writing over it. That works
> > because free(NULL) is a noop. What we can't change, though, is cases
> > where the pointer is initialized to a string literal, like:
> 
> Fun historical (historic?) fact: On NeXTSTEP operating system,
> free(NULL) and realloc(NULL,n) would crash the program, so getting
> non-native (open-source) code to run correctly often involved more
> than a little effort..

I'm happy that's no longer something we need to worry about. ;) IIRC we
had some discussion long ago about whether free(NULL) needed to be
protected, and came to the conclusion that it's OK everywhere.

(There's a discussion in a nearby thread about a possible git_free()
wrapper. The point there is errno handling, but of course it could also
cover this case for us if we found a modern platform where it was a
problem).

-Peff
