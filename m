Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458FC2727E3
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898316; cv=none; b=D2yNC9XJDq3zs2Yi0glsF4r6RR+8EiwcOmLB8vFTEERJXwMcQ3uVvHoXP2QpMlTu2EzznOyLHfM4Erx//tRZKA9zHi1pfpkNTmLqkfyDWnuMiFXbREpNWPPtSftg1kNEPLeablfFlE9sCMgU2QwmGT2DX9YBrpvPSWHq6KjjNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898316; c=relaxed/simple;
	bh=j5A4jv9rsMETADpCHRcaEDnsHhlfQnDKkCDlZJ6O7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy5aEHjmj5TPBQSCArZzli9RCAPuBP0s0djLXhBiCouZUBmYwurJAi5osHG7+KYWiEBhTa77apwQ5Up60DY3odAJt1VhZJm6GYddOaNumKv8mSgeOmuSoD3HQ8rvJ9WFcVekUF0hVwfmn03mrqRaAduGmYDeFlkgMJrsEK4JjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=akhcP12S; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="akhcP12S"
Received: (qmail 193243 invoked by uid 109); 3 Sep 2025 11:18:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=j5A4jv9rsMETADpCHRcaEDnsHhlfQnDKkCDlZJ6O7fg=; b=akhcP12SxlEssX/XT70Wv8DpugLIntMzqsAUQdG2kScHtMye//WDbUkBvNmGLqi2ucrxPKc4Jo66osVZZrzYKfPd1em351hi8ZjuO1xKRPMeBf/rDH3fz49A4hGTEOSMB/6hMeVtJEFKfn4BBCES3N7n0V7rvS+nBqJ5yCfeTgRV9TD8DkcngygL0a0YGnln6eQ+L8KOqC2fxdhOs5g5wTvwaConoXRr3UszRry0iyqHRaKRua+vxx1fzXeIXoyHonMXcrVCzeCCxIrtr6du7xYEyLEkaqZdKdORwmYHqyrT8HOBZz9nfQWTAf5hwSPmOsej0U7WLWtH9OCMO51WUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Sep 2025 11:18:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 339321 invoked by uid 111); 3 Sep 2025 11:18:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Sep 2025 07:18:30 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Sep 2025 07:18:29 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Subject: Re: [PATCH v3] alloc: fix dangling pointer in alloc_state cleanup
Message-ID: <20250903111829.GA1877518@coredump.intra.peff.net>
References: <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
 <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>

On Fri, Aug 29, 2025 at 01:00:06PM +0000, ノウラ | Flare via GitGitGadget wrote:

> +void alloc_state_free_and_null(struct alloc_state **s_)
>  {
> +	struct alloc_state *s = *s_;
> +
> +	if (!s_ || !*s_) return;
> +

Coverity complains that there's a NULL check here for "s_", but we'll
have already dereferenced it in the initializer for "s".

I don't think any caller passes NULL, so you can't trigger a segfault in
practice. But the code is kind of misleading. Should it just be:

  if (!*s_)
	return;

? Or even just "if (!s)".

-Peff
