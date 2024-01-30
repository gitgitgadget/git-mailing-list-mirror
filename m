Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A598381B6
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594017; cv=none; b=tbr65AZI5lHUR5rUd70Y7sJKAD1u5pEZqIcFK2SsmP9V8u94LUBHfnvn0ChLvWcR3qT8AC1Xe3TDdH48gQfiBzuJnMHXvnUXP2ahTqS+WmOIWb53HFQgLrGuCOu3kxB6GIq/T7PYtcyIh17CRhCKjlPUJqJIaASSMB2cxC1AxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594017; c=relaxed/simple;
	bh=0Pd+CVOGGA+H3Zd7522SVPTlkaxSnm4baVYd9z8rvxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqJyra69f/wE/UwitmTFN8znCrB7ieapa5aR4bzfu9X8XtZc8Y2vnB6+ZIIGxSoJ5bFAUo7wtYuNOQAYckXU04lULBrecxE+At24z1xURyaoeQdOCeewzvvLZMm9vDRd+qONaeNxm3t0PUn7Clx7hPuG1/YF4XfX0N4HbBS3nSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8760 invoked by uid 109); 30 Jan 2024 05:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29256 invoked by uid 111); 30 Jan 2024 05:53:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:53:36 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:53:33 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] t0080: mark as leak-free
Message-ID: <20240130055333.GB166761@coredump.intra.peff.net>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
 <4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com>
 <xmqqa5onhjm4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5onhjm4.fsf@gitster.g>

On Mon, Jan 29, 2024 at 02:15:15PM -0800, Junio C Hamano wrote:

> > Let's mark it as leak-free to make sure it stays that way (and to reduce
> > noise when looking for other leak-free scripts after we fix some leaks).
> 
> For other tests in this series, that rationale is a very sensible
> thing, but does it apply to this one?
> 
> The point of the t-basic tests is to ensure the lightweight unit
> test framework that requires nothing from Git behaves (and keeps
> behaving) sensibly.  The point of running t[0-9][0-9][0-9][0-9]
> tests under leak sanitizer is to exercise production Git code to
> catch leaks in Git code.
> 
> So it is not quite clear if we even want to run this t0080 under
> leak sanitizer to begin with.  t0080 is a relatively tiny test, but
> do we even want to spend leak sanitizer cycles on it?  I dunno.

I think you are right that we do not particularly care about leaks in
the t-basic code. That is also true of other test harness code (other
unit-tests, but also stuff in t/helper). But IMHO it is less work to
just keep that code leak-free than it is to try to distinguish between
production and test code.

Right now, it is not that hard to simply leave the PASSES_SANITIZE_LEAK
flag off of t0080, and then it won't be run in the leak-checking CI job.
But I think the end-game of all of this leak-checking stuff is that
eventually _everything_ will be leak-free, and we will discard the whole
PASSES_SANITIZE_LEAK mechanism entirely. And in that end-game, it is
simpler for everything, including t-basic, to just be leak-free and
checked under the same regime.

Setting the flag now just makes sure we continue correctly on that path,
rather than getting surprised near the end of the road that t-basic has
some dumb leak. Plus it avoids the script popping up as a false positive
when checking for scripts which can be marked.

-Peff
