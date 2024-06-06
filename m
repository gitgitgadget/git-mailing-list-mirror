Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C011DA58
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657272; cv=none; b=I8RDbSEC4bzBxKFSMr1EWHapFc64OwAgX3Swz5eo6phQgPYv4PQaqri3zPTRi0CxMbsg8P+9ABIPmsDD+XCbJD2bNvUWQjTTDXvg1hEtaKB817InrpkchdOaIygq1wGhU/qHSoBANrPBq1AaGqOJU0oukk4GsPTuwUrP8B0Ksy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657272; c=relaxed/simple;
	bh=3LhPTjcn1CL222kph7L49rj6MrriqszhqCbwrM/OlU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZbZGDokZKgTQQFix+6MoBhRo8lkZEItRKEtebQfj+3ne8uhBXY+FAymUMozSu4AlHtcWhihuHffCO1n2RCfDboFVKskSgcXcw3YPSNKNfMkbkAMmZQTgSpDC7Y6npIz+XycvXnoRIyQJoqsWj0m0JAaQx6nErRaqCZ09m2jDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9888 invoked by uid 109); 6 Jun 2024 07:01:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 07:01:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6006 invoked by uid 111); 6 Jun 2024 07:01:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 03:01:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 03:01:09 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <20240606070109.GC646308@coredump.intra.peff.net>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
 <20240605100318.GA3436391@coredump.intra.peff.net>
 <xmqq1q5buxzx.fsf@gitster.g>
 <ZmFAQ1UT6ePxHtzq@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmFAQ1UT6ePxHtzq@tanuki>

On Thu, Jun 06, 2024 at 06:51:15AM +0200, Patrick Steinhardt wrote:

> > I do not mind reverting the topic out of 'next' and actually would
> > prefer replacing it with a corrected version, which would allow us
> > to merge the clean copy to the next release.
> 
> I wouldn't exactly say prematurely, given that it likely wouldn't have
> gotten a review without the merge because it was spurred by Coverity :)
> I really wish that the Coverity tooling was available to run at will and
> locally in our pipelines so that we can stop reacting to it, but instead
> address whatever it flags _before_ the code hits the target branch. But,
> well, that's not how Coverity works.

Yeah, I'd agree with the analysis here. While somebody _could_ have
found these by inspection, in practice it was the merge to next that led
me to them.

It may imply that we should be running Coverity earlier, though.

In my fork I trigger Coverity runs based on my personal integration
branch, which is based on next plus a list of non-garbage topics I'm
working on. So I get to see (and fix) my own bugs before anybody else
does. But I don't see other people's bugs until they're in next.

I could try running against "seen", but it's a minor hassle. I don't
otherwise touch that branch at all, and I certainly don't want my daily
driver built off of it. Plus it sometimes has test failures or other
hiccups, and I already get enough false positive noise from Coverity (so
even if I ran it, I'd be unlikely to spend much time digging into
failures).

So what I'd suggest is that you try setting up the Coverity workflow
yourself. There are rough instructions in the GitHub workflow file, and
I imagine you'd be able to port it to GitLab. Coverity does do SSO login
with GitHub, but I don't think it's relevant once you've got an account
there. The opaque token they give you is all you need to upload a build.

-Peff
