Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7481A7042
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989383; cv=none; b=KeIBfXW+3a17mlpx+nbT+vV2B9nQl3YCpUGCTKJlDLGWnWNOesXXwKFE28VS9yvoWQr0pCXKo7foZLXo0cu8+9pP+DiXe6C8FNNYddov3eONZkHnNj1V9px5TJGpWW1ymq7X9Ccu0cJdvKJ1Acobe3KZLAWxHcF9wOI1GhFzZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989383; c=relaxed/simple;
	bh=sotE86omX0LwFQHBvGPKAbbEHbzrX4vdMnnFK7ZFrT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYWQyuR50khnKUOfSnkw5hQdDZiwmRRkLaBwd9w4Fa3dF+Zb1oTAAJHdyVyJGgGajhdPz2O2Hy1Y2N/LhGyuPt/s1ZejrMC8qxVVxbOABmS8LndlACS7wA/0wwqkvFjnwFSxRnWhg5g3mC5hswPiC8PZC4FTz1h7KQ1rsIvBmNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QJQ7/pwG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QJQ7/pwG"
Received: (qmail 19284 invoked by uid 109); 3 Oct 2024 21:02:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sotE86omX0LwFQHBvGPKAbbEHbzrX4vdMnnFK7ZFrT8=; b=QJQ7/pwGOCXS9W0FTCKDSP7W0YcUvmVMhwSbCr96WyPXwBQCfDMXpfODqhea8ghzQpts+wOkgvqQyDQN/mdurUvn/0cCeeL+NUBlCvBXq8yS86ukJNX1ojb7SFPeXHGvOBldYVwwa1TBbMo8LwFYvofiFppvVTFZfGyq+vRSR07DmPleq3O/TDe2C880xxafOpJ9S2zLDKXTNn7twuiLYzVQZH57KhlCvHJNCdyHytpHx/GWXto3mkECWQjT5btw4DP9zCnfN0YZHi8M3wpH1SXJQmi/J1RtDrt0b58Nk/1N23QGKy6M1WGmF380RSRovlqEiC7fcCxTplKiDdDZ+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:02:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21696 invoked by uid 111); 3 Oct 2024 21:02:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:02:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:02:57 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH] line-log: protect inner strbuf from free
Message-ID: <20241003210257.GA11180@coredump.intra.peff.net>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <20241002235639.GB3455554@coredump.intra.peff.net>
 <1fc0d162-9814-4d94-ac67-2ea8e40495f4@gmail.com>
 <20241003061136.GA351404@coredump.intra.peff.net>
 <cf5fea7a-c711-4d35-9c6e-fe96778a3f85@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf5fea7a-c711-4d35-9c6e-fe96778a3f85@gmail.com>

On Thu, Oct 03, 2024 at 08:23:22AM -0400, Derrick Stolee wrote:

> > The whole thing feels a bit over-engineered with the callback. The graph
> > code is the only one that needs anything beyond a static string. And the
> > way --line-prefix interacts with it is odd, since some callers override
> > the callback (e.g., "range-diff --line-prefix=foo" is accepted, but
> > doesn't do anything). I don't think there's a bug anybody cares about,
> > but, well...it's not how I would have written it. ;)
> 
> Thanks for exploring this with the diff you sent. It's subtle, but you
> did a good job of recognizing that when the callback is used without
> a 'graph' value, it returns opt->line_prefix.
> 
> > +	if (!graph)
> > +		return opt->line_prefix;
> 
> I was wondering why there was no need to edit graph_setup_line_prefix()
> in your diff, and this explains why. Your change is simple enough to
> handle that change while being robust to a future assignment of the
> callback data.

Yeah. I actually ended up pulling that into its own patch because it's
sufficiently subtle. I'll send that along in a minute.

-Peff
