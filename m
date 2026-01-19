Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6522D7B5
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800774; cv=none; b=szC3NfKv4mkWdZx5Cr0M31dio4C6fNeU4FgpFW8aAp35WPR8vsGjLA2eGwKtue8r3lqN9ZW7Mdytcm8PSWVDYgkaVfX76YM917Db1+Oi3/dA8uSfIxbtX3eMhlYYvEC3EJFSAWUBxpS0WI/dTr72QCmrA8F2XpXM02mizhvq/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800774; c=relaxed/simple;
	bh=8Jp9ZRI/63pjCgSEP2iZaicHVx4V5hTMQzuR42aDGDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyuCFCLKP/0aU8mDcaa1F3RUUEOwDFti45ZBhzFnrhITpnfLR8Q1AA72cDOvQwJLKIyPrs6LymD7J6RPy741s9h1vZwUsgpetJTni85kHCzDUH3BAcRIN1Q1X/kpTLZtQ2eWsGozIVpIH4U4PDO5GBiszLi0bX+CCjGCpDj8fGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ap1hrUQo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ap1hrUQo"
Received: (qmail 94570 invoked by uid 109); 19 Jan 2026 05:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8Jp9ZRI/63pjCgSEP2iZaicHVx4V5hTMQzuR42aDGDs=; b=Ap1hrUQose87KILUHBCWzykcEZqAHYTtN7o4IUVmY/9I17mFrxlAOaYA/iEqGCSdUrNfx4vq3dGv7bpDg/zdRBH8Wgsy30+9lHU0u8Oseh3l0Ut9ToAho8uwAzMML5tMcNGpm3GodDcLwlVV2L9EeMFqvzEhO923wFwtF1WsGF3hWbRteFqVMAEI8lWF4DrLBymik+5lGB9aQ4X2TMv1ZH8LPsyw4AWpiQpsakcxJxDG/yHEYhBy0r8Cb7m23iNDdSaT/lyhwR1LrNTwklJRM+6bZJQs9L5UCDM1TkzUrdswh4Fnb6mt11v4DuhFEJ8d9k/v/8PAZZ2EUTjidjFS0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:32:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153997 invoked by uid 111); 19 Jan 2026 05:32:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:32:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:32:51 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: amisha <amishhhaaaa@gmail.com>, git@vger.kernel.org, stolee@gmail.com,
	newren@gmail.com
Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
Message-ID: <20260119053251.GA1991605@coredump.intra.peff.net>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260116165003.95314-1-amishhhaaaa@gmail.com>
 <xmqqqzrp74q3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzrp74q3.fsf@gitster.g>

On Fri, Jan 16, 2026 at 11:11:16AM -0800, Junio C Hamano wrote:

> > Improve O(n^2) complexity to O(n log n) while building a sorted
> > 'string_list' by constructing it unsorted then sorting it
> > followed by removing duplicates.
> 
> By the way, do we have t/perf/ that substanticates the performance
> claim here (in other words, how much improvement are we expecting in
> practice)?

IMHO it is not that big a deal to demonstrate the perf improvement in
the test suite.

Probably you could feed a very long list of unique names to "git
sparse-checkout add --stdin" to trigger it. But a list long enough to
cause annoying quadratic behavior is getting far enough from the real
world that I'm not sure it is worth adding to the (already expensive)
perf suite.

And swapping append+sort for sorted insertion is a common and simple
improvement.  We probably don't need to prove its performance at all,
but if we do, a one-off hyperfine output in the commit message would be
enough.

-Peff
