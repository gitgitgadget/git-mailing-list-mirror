Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08219F48D
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754125709; cv=none; b=mawbvG2Ul5c7myqEAHAuZnTvNv+UXUphSdE1Vh51owtdCetxQBDE8WIWovbM91dADSvKnysbLLLHnLKfZEIGZhbR0/sqDpauy9zy6950JH5Axg+YgkBtF9gsoLfDOsXkt8TiWZpQ7QDRMH6Z3TYqEBtpaWarOXUUag/0yW3q7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754125709; c=relaxed/simple;
	bh=92GbJc9bbcG3v9orCReyuAM5sOqc8y+l+7qsY+BmnGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrelNyPGI+fSQak3IE8Uf6f/upeBgTCE9iZjPUJftnWZPNJ65hqcC4bgCMevCyvgELN079RXBoEMVuxsR22ki25IqqHtL/tRgS0HDnnAVBjFVOa7iRlGsiANAjniqXx5BcIrz/1MthgKEL5/MARxnTPG9TCFnjjDVHMmRBXnMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fNK3ApEk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fNK3ApEk"
Received: (qmail 8887 invoked by uid 109); 2 Aug 2025 09:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=92GbJc9bbcG3v9orCReyuAM5sOqc8y+l+7qsY+BmnGQ=; b=fNK3ApEkjNfIqg0wWHDZy3bildOGi14/c74Y1cpDOajqX07wSJU5cMpZF/vMffZxieOKA3yUkN0qaysPip9mjJF1JcTN+ViX8wZYnGpHBaPMWRV8BiI8L45Z9sgsnsKEefeF7e7Ig4utvESmld3RsGiHoIF/G5Oxa1i3Uw3SUGgBcKIT6nIgC+QvqpY3Lu3xue3egUJ8ken7bsmLT6nhjU7pFvMC+U9QkWuoaSc1o53c6sgiPor8Cr8BjnkgPwJdTGZQY22Tcm4ZwtLdxZbPUb6Lyz/r0QV6kjEW70u6wbJXSxw0gLQtXYxk4yKuXXuClPS5rvs9lZ5jbgMLclM9Hg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 09:08:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11181 invoked by uid 111); 2 Aug 2025 09:08:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 05:08:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 05:08:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] do not overuse strbuf_split*()
Message-ID: <20250802090825.GE3711639@coredump.intra.peff.net>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:54:22PM -0700, Junio C Hamano wrote:

> strbuf is a very good data structure to work with string data
> without having to worry about running past the end of the string.
> 
> But an array of strbuf is often a wrong data structure.  You rarely
> have need to be able to edit multiple strings represented by such an
> array simultaneously.  And strbuf_split*() that produces result in
> such a shape is a misdesigned API function.

Yeah, I agree it's a bad API, and I'd be happy if we could eventually
get rid of it.

Conversion to string_list mostly makes sense (though I especially like
the case in sub-process.c where we can just parse with skip_prefix()).

I looked over the patches and didn't see anything objectionable. But I
tried to think of subtle incompatibilities we might run into:

  1. I saw the different handling of "max" you had to deal with in one
     patch. Yuck. It might be worth tweaking string_list_split() to
     count "pieces" (which is how every other split function I've seen,
     like the one in perl, works). But that can be done later (and is
     tricky to do safely, since we wouldn't be changing the function
     signature).

  2. Is the handling of repeated delimiters the same? E.g., if I split
     on "/" and we see "foo//bar", do both split implementations yield
     the same output. I could see either of ("foo", "", "bar") and
     ("foo", "bar") being produced.

And...

> The most common use case of strbuf_split*() family of functions
> seems to be to trim away the whitespaces around each piece of split
> string.  With modern string_list_split*(), it is often no longer
> necessary.

Some of these sites do strbuf_rtrim() on the split pieces. But
STRING_LIST_SPLIT_TRIM does both left and right. Is this OK? I think so
because in both cases we are already splitting on space, so we wouldn't
expect left-hand spaces (of course you could have a stray tab or
something, but I suspect the new code matches the intent more closely).

-Peff
