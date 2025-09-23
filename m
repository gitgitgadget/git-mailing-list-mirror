Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B511A23A9
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588864; cv=none; b=lmMAnMm4BQekXc+jYt0soBIRPaxPRtbIGecSeZAv2VhqSSorF6bd2rAAVit5296xgUmK/nbghmIDBLV0iQMOIVGHfThrIGRWXirOXGzpW8g8Qa+Pk8/6fsSZRmB33ROl7HYu82bSbwUprCPbjW/4/WPLaLtJ5ICgaca0RUGZVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588864; c=relaxed/simple;
	bh=BamXP6CapcdHcj71dznxsGVFOf9/2KW0y/vHlFEXBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTvFwD8M8pfp69f8TJeSOI9mKbv5k/3lnvIa1SHirUKdnGLlIG1zwiNRyO5idLyao51OEb21Up8QuH+sNNkhjSN8sXvcEIovUMGi+YARMHdlyHw1m217VRnDdKieV6osJ1XT/xDvcbHBVcAgG4OpOULdWwaxiRg/LSqsSIuzrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IbzoSNgN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IbzoSNgN"
Received: (qmail 164511 invoked by uid 109); 23 Sep 2025 00:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BamXP6CapcdHcj71dznxsGVFOf9/2KW0y/vHlFEXBTQ=; b=IbzoSNgNPC2P/seRDM+yjFyoFSy0zcsADAzyL3usHFP91/m8EsBK7u1AgdgLQsHu4kkjVoDS/3c1Q3XBV5akVTnNqqvqlF4nPp8UbYuyZIiOKlJoZT/Y4NEinDpjjw1EsyGG6ITp8Ia09WJ3VFNRarjXubFvwalwpGV3RyWos5z+p0aK9RhvUs2ypyB5vHtXPELa/9ed5iyvMAip1YoicsCHnvxc5zRCenIX4tXptklYpwmEDP2QSmzEPRcdSL939+N+bnSdNSWpGTwbxmLPHHhR7oGIiNftmI/N4i7YtfSHpDa6jYaIsrwtlFA4lOSR+FzbWQo4rselvWSEZY9fIQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Sep 2025 00:54:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 263481 invoked by uid 111); 23 Sep 2025 00:54:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 20:54:21 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 20:54:21 -0400
From: Jeff King <peff@peff.net>
To: Sainan <sainan@calamity.inc>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Could Git be smarter about object reuse?
Message-ID: <20250923005421.GB2271307@coredump.intra.peff.net>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc>
 <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de>
 <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc>
 <20250922200510.GC2205919@coredump.intra.peff.net>
 <ZURUr5sfXi0wsjBeXiwAxyNgalVa2ZveXDgoTcexUNOAgcP_JscHvFFDIss4stpsiB2MzUQ_Z30tFrPSgr8W8V02ecfCj4BFFwQqWwJpba4=@calamity.inc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZURUr5sfXi0wsjBeXiwAxyNgalVa2ZveXDgoTcexUNOAgcP_JscHvFFDIss4stpsiB2MzUQ_Z30tFrPSgr8W8V02ecfCj4BFFwQqWwJpba4=@calamity.inc>

On Mon, Sep 22, 2025 at 10:09:41PM +0000, Sainan wrote:

> > git repack -adb
> 
> Certainly got my fans spinning for a bit. :)
> 
> But I can indeed confirm that it does solve the issue at least when
> amending a commit (will need to do further testing and generally get a
> feel for it).
> 
> However, one issue that I'm immediately noticing is that if I do 'git
> pull', I get a new pack that is bitmap-less, once again likely
> exposing me to the same problems.

It should still work. The bitmap format is meant to degrade
progressively. So if if you have a history like this:

   ROOT--...--A--B--C
               \
		D

and we have a bitmap for commit "B", then asking about "C" will let us
traverse backwards until we hit "B", when we can fill in everything down
to the root from the bitmap. We just have to traverse C's tree (but we
can even avoid going into subtrees that are already mentioned in the
bitmap).

For D it's a little trickier. We can't use the bitmap for B, but the
idea is that we sprinkle them throughout history so that we'll
eventually hit one and stop traversing.

So the big thing for making your case work is deciding whether we should
use bitmaps at all. And if we have some already, then generally Git will
try to use them, even if it means doing some fill-in traversal (because
we really don't know how much fill-in traversal there will be ahead of
time).

-Peff
