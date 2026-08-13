Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DD480DD2
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637446; cv=none; b=iaBbcGl226LvpjVbH8sYPlfqTvzuzBu/PsKBLmTVHLtOV+KZtpRgU8qcml4A9pmiiQbz/BVKVmW8PJ16XWjcDdUom8KFcCQ7iR4O2LMc7CXVbYIvHhbR61NFdNuv9AG9H11TxZAWcd7VaUdkPnixjbJCQmKjbI51w7ILTcXGlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637446; c=relaxed/simple;
	bh=fIi+fSRGdyg3NHbm4aYmTaLeQnpCucOXfpDFxP4KbTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSMdgNlnV0YcJ34FvtjeNPASAKwsYijueHUNyXpQc59yQ/h/mQWyPVCV9Gqd+l+q990rxX7HByu/fECi31UWs2sFkUBsPjp9RGVT78sr41hOB9MDog11K99n76qpxmHhefr4JhpdsaSqIN1TZo+U3vZ35k9l7LY0NlCjhXK9w24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YhyI+tEZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YhyI+tEZ"
Received: (qmail 52075 invoked by uid 106); 13 Aug 2026 16:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fIi+fSRGdyg3NHbm4aYmTaLeQnpCucOXfpDFxP4KbTs=; b=YhyI+tEZa4X/f6s1h2SZrSuC1iDoc+n0KitPXgEBtPEsJGqRqNQt/fi89m77EK+g5ccGZU/jZrgXAm3jAXtw+OL4zoLCPfWq04LPpIfZzaxVMtF7diSjF4yhoblfC5oeeDXSuxJcTquFQUjctAidlBK5u7PUdKwmwZGK/aJYZk76u2Ga5vpVYifDsGaquJ0mnCxADnjocxBFDRKBJuoR4+URhhPia/ZqUgErxHMczN3wkvO9k+bQMv51+VQSXCqhMhlacmC7zwoShbnuq+zCx8rNhINqWJvwDhr1cCt66ws32EQrhTAkPg+e8oGeiMNt4FgwALBGGtnNk2twSsa0bQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2026 16:10:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 43383 invoked by uid 111); 13 Aug 2026 16:10:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2026 12:10:36 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Aug 2026 12:10:36 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <20260813161036.GA1386479@coredump.intra.peff.net>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <xmqqfr0jw20t.fsf@gitster.g>
 <20260812212955.GA152730@coredump.intra.peff.net>
 <ed5c651f-648f-f58c-bbd3-3db295515913@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed5c651f-648f-f58c-bbd3-3db295515913@gmx.de>

On Thu, Aug 13, 2026 at 10:25:25AM +0200, Johannes Schindelin wrote:

> > > > +test_perf "abbreviate with 10,000 packs" '
> > > > +	git rev-parse --short HEAD
> > > > +'
> > 
> > ...I wonder what value this is adding. It shows the same slowdown as the
> > existing test you can see in the context (and whose results I showed
> > above).
> 
> I do think that there is value in adding this. It not only directly
> reflects what GIT_PS1 runs, but it also exercises a subtly different path:
> `--short` has to look for the unique abbreviation, whereas `--verify` can
> stop as soon as it found the OID already.

Yes, though the regression your patch fixes is about creating the
initial pack list, so it happens whether we open each pack or not.

We do test multiple cases earlier in the file where we look at each
object (both a stock rev-list, and one where we abbreviate, looking for
perf problems in the shortening code itself). But we only do that for
1/50/1000 packs, not the big 10,000 pack case.

I dunno. It probably is not hurting much to have some redundancy in the
tests because this one in particular is not too expensive to run. So I
am OK either way.

-Peff
