Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86712E47
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105275; cv=none; b=qow95agHOD//2iijYlBXBEWra2KfPDJOO7gsbN3RIwG5V51tdC4r7oeH85JtFTtLwpab+xnImT5Qkznn8t/7o2zuF552t304aHXGW2S6l2rLleD8ZLw20Rqd/hTKU11MoLjaz7zM9mW/gN+3kfN2vQvuE7ivlntlqhnbgkchPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105275; c=relaxed/simple;
	bh=dmfVreHENl76xdBFw2AIFfKzNND4GkaxMO0z0IokX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZMWkxnES/OQQEotYR5U1mrnYT6Qjf1pvdEl6xODmxPQy2k5ABFEfoWhjXEZZf3+3Er+U7RfgD2rCEb/OFOlv++62sf1dCWtXfvVIU7wqRkY7DTq2lQpWZRT1Yzb2qFiacj4r9OkIMPsH17H6nsX9MOCOHGNGPqTjjGFVJHtt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12241 invoked by uid 109); 3 Apr 2024 00:47:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 00:47:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3328 invoked by uid 111); 3 Apr 2024 00:47:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 20:47:54 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 20:47:51 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: use xsnprintf to format command
Message-ID: <20240403004751.GA892394@coredump.intra.peff.net>
References: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>

On Tue, Apr 02, 2024 at 04:51:05PM +0200, René Scharfe wrote:

> nfsnprintf() wraps vsnprintf(3) and reports attempts to use too small a
> buffer using BUG(), just like xsnprintf().
> 
> It has an extra check that makes sure the buffer size (converted to int)
> is positive.  vsnprintf(3) is supposed to handle a buffer size of zero
> or bigger than INT_MAX just fine, so this extra comparison doesn't make
> us any safer.  If a platform has a broken implementation, we'd need to
> work around it in our compat code.
> 
> Call xsnprintf() instead to reduce code duplication and make the caller
> slightly more readable by using this more common helper.

I think this is an improvement, and since the original also called BUG()
we are not making anything worse. But I think the original was actually
in error to do so, since it depends on user data. E.g., setting
imap.user to the output of $(perl -e 'print "a" x 1024"') results in:

  BUG: imap-send.c:511: buffer too small. Please report a bug.
  error: git-imap-send died of signal 6

Now obviously that's a dumb username, but this is the buffer used for
all IMAP commands. So conceivably long folder names, etc, do the same
thing. It's probably not a big deal in practice, but conceptually this
probably ought to be xstrfmt() and not xsnprintf().

Likewise imap-send's nfvasprintf() is basically xstrfmt(), except it
takes a va_list. So it would have to be replaced by strbuf_vaddf().

I wouldn't be surprised if there are other opportunities for string
cleanup, but I generally hoped that if we waited long enough imap-send
would just go away. ;) Either because we could get rid of the tool
entirely (though from a recent-ish search, there did not seem to be a
lot of good other tools) or because we'd just drop the old code and rely
on curl to do the heavy lifting.

All that said, I think your patch makes the world slightly better, so
I'm not opposed in the meantime.

-Peff
