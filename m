Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED72BD029
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524519; cv=none; b=MP7R+K8V6bBkRjnInOnguhWd6JSM+uH+PlM9dcc3kULnubG+cm83iAq4aSTipoQkrEngOaqCTRJEn+lSO8Kzs7k1wsvZhi65DcqxI0EacSJKdqEzl4UEqkhBJxm19ysUiMgmV1Tk5IUqsXNSUWzP32kG7xQ40upILJNCBvheSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524519; c=relaxed/simple;
	bh=3iJHTtWhuz8HztFKuGXTaOIFAWRiqez6ldTkEOLosQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R97bvxoVP6Y9DdO3sa/BeHYBOIhSdDhCuuQoKRsSyzNR34JvYY+hjtIrjdvoPZ2Husaws0OZUwpkJYADyc/BK9IdyMChrGyRt7KgiPRcfjU1LcVwNtQOubfCgk6CXyDNsOlRAdGyHgpJnhylcAn9w/gAJZN7ZTzqmM1zQMTWjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RzvqpcNT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RzvqpcNT"
Received: (qmail 226804 invoked by uid 109); 15 Oct 2025 10:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3iJHTtWhuz8HztFKuGXTaOIFAWRiqez6ldTkEOLosQ0=; b=RzvqpcNTW2QWeZfizzvizP2jUydyQVnApKuVteHuNA+3G+KR+V0Dwps6KoaQTWKaJSAzWdFi+sZKPgxPHMHjv8+Z/47EQBEVbiStsD0KiyzddhGMbF9ZuoEs0aozHy+QoKTgbiPJm2viJNlTn/YwsZCRp7a1ecH7qOlS/UG/R9Uty2kvEBhRFdJDbAlvXS2V+0BDaDkF83NIz9BNAIme7t++/LSzyVoLRgnv2BvERaMRE7q8Cj9AJRa+1XTWj2rS/2PJT7tJOJvs39Ck1536bRpLGB6tsOz03yLx0frCMhj/gy8XKVahWM4rlhAVjNFDSd242INnZtWV5o+1FM4a0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 10:35:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 363072 invoked by uid 111); 15 Oct 2025 10:35:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 06:35:17 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 06:35:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 43/49] repack: extract `write_pack_opts_is_local()`
Message-ID: <20251015103516.GE2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:10:08PM -0400, Taylor Blau wrote:

> Similar to the previous commit, the functions `write_cruft_pack()` and
> `write_filtered_pack()` both compute a "local" variable via the exact
> same mechanism:
> 
>     const char *scratch;
>     int local = skip_prefix(opts->destination, opts->packdir, &scratch);
> 
> Not only does this cause us to repeat the same pair of lines, it also
> introduces an unnecessary "scratch" variable that is common between both
> functions.

Hmm. If we are not looking at "scratch", then does that mean
skip_prefix() is the wrong function to use? I.e., should this just be:

  int local = starts_with(opts->destinations, opts->packdir);

?

It may still be worth pulling into a separate function to encapsulate
the policy logic, but that function could be using starts_with() itself.

-Peff
