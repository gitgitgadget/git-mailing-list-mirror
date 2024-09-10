Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCE136358
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950015; cv=none; b=i4z/hFLMGOnk8fHLxU4cpUExreC8npwtZIFsHS2VaRG7Qfel0dAvPr5aDDSljxa8UNiO/lHyQclqABbIyWzzxsv1lm0zMbLw6p6EpDPhuQ74kumFFnKZ0KCeEbPYSJUM9Fa3En411m+aPBawd+i3LCwkvLBvMdWYSMX7xaYZkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950015; c=relaxed/simple;
	bh=Ae9M6a9BDYkCcDJESvQAwOsez6mMOM5Mr30/w6kAKqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6CdrKBg968MZJg1Zn2mP5Wjo1VXq2mwUNlcM9pFSRbVyQir2YCMu2JecuL4YA2dZUYcTaENclfAhjU39ddiPA+tlyXWk8K+fZjUVR0IVL2nDcJFpk1zD2IGluc29binobgpcMks4bojfEEqaCCLf9NZgX0UtWYaFiIqwVS3B6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3260 invoked by uid 109); 10 Sep 2024 06:33:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 06:33:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29077 invoked by uid 111); 10 Sep 2024 06:33:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 02:33:32 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 02:33:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 6/9] ref-filter: fix leak of %(trailers) "argbuf"
Message-ID: <20240910063332.GC1459778@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231828.GF921834@coredump.intra.peff.net>
 <Zt_ifxQq-6wNaQ3J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt_ifxQq-6wNaQ3J@pks.im>

On Tue, Sep 10, 2024 at 08:09:03AM +0200, Patrick Steinhardt wrote:

> > But I think a less-subtle solution, and what this patch does, is to
> > switch to a duplicating string_list. That makes it self-contained, and
> > lets us free argbuf immediately. It may involve a few extra allocations,
> > but this parsing is something that happens once per program, not once
> > per output ref.
> 
> Sensible. I found that in many cases, the `nodup` variants of string
> lists bring more pain than real benefit.

I have found that, too. :) I've argued in the past for getting rid of it
(and especially not propagating its world-view to other data structures
like strmap, and so on). But Elijah presented some pretty compelling
numbers that it does help for some of the large merge-ort strmaps.

So I've softened my argument to asking people to use it judiciously. ;)

> > This clears up one case that LSan finds in t6300, but there are more.
> 
> Yeah, there are a bunch of memory leaks around atom parsing in general
> exposed by t6300. Thanks for plugging some of them!

Well, you're really going to like the rest of the series, then!

-Peff
