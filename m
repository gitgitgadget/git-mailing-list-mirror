Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D24477E7
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808579; cv=none; b=SicP4pBeWtffHdWbWnTnPfiUq21uxNQ99HrhkT9rZ1bopAY3bIY9IZ4t1JU5BJRHZy00ToM4lM4JFwf77DESL/fFhZknT+ODpU0c7x1Ava+2i/oBNH4CXaFkGrfdYvhfEdphjc0RuHh89V46kTj77lijMe+hzhnq7syQLdlLvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808579; c=relaxed/simple;
	bh=qPMhEbztxCxKCtzgoZVhlXg2pgwgFQCkN8+Szxuss0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIDuguMQY15xnkCoGVvvDr8NfwKE6D1ymhFWZrIUpBUHqvlT85PChMfjG2B7aa3GvTV/o3nOD57PtnpovP6Ntd3Vos+1x0jSBE7o56Ps6rxgyZWSh65fH1aGMxOtJCIujz1i6+bufpiKU236N6P1IBmI3PB341VxrojilqCWoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S1n5k6OI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S1n5k6OI"
Received: (qmail 7962 invoked by uid 106); 30 Sep 2026 22:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qPMhEbztxCxKCtzgoZVhlXg2pgwgFQCkN8+Szxuss0A=; b=S1n5k6OID24x7YqXd6EQUt1v6I1xzywZW4XvUBuMEKSsJAUfasszJSl5k4jqTwUU6h4RIAchzFsDYXNufKOdK/N8O02lq+4dLpzXfu/b6dfY9uDZWMYqAzX04nI6WkNTqPwI7pbuuFhmpgUWfv1O/LZjH0wMFq0SE80fP5pgGhz26oloR9bVOfeztF4woJKjRacduOzyYAklk/H//YEdWO79tMhDddbOv6u6xBJ8f75o+8OHU0OvkJL+6WFXmigOqC0mypY1KLCE+xAtr5PIuOwnE8Nyc4kwaksGYQLwc8KDY+tGUrvXWussnJd4+V7eEi1W0jdct8GK3ELUiLJshw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 22:49:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20079 invoked by uid 111); 30 Sep 2026 22:49:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 18:49:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 18:49:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] xdiff: NUL-terminate buffers read by read_mmfile()
Message-ID: <20260930224935.GB765052@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065504.GE1697497@coredump.intra.peff.net>
 <ar0rp1cSIKuCMZyQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar0rp1cSIKuCMZyQ@pks.im>

On Wed, Sep 30, 2026 at 05:32:55PM +0200, Patrick Steinhardt wrote:

> > This one is obviously optional, which is why I put it last.
> 
> Hm, I'm somewhat indifferent here. It always feels a bit weird to be
> this defensive because "programming errors", as the next question then
> is "but what about all the other errors where we're not defensive?" But
> the xdiff code is complex enough with a bunch of pointer arithmetics, so
> maybe it's not even that bad of an idea.
> 
> That being said, I feel like a better course of action could be to use a
> fuzzer for this code, because as far as I'm aware we have none yet, and
> that would potentially shake out a bunch of bugs. But that still doesn't
> really help us to catch platform-specific bugs due to different integer
> sizes.

I look at it as: why not do both?

Mostly the lack of extra NUL surprised me, as we routinely add one in
most other places (and it has prevented some memory bugs in the past).

> The counterargument is that before your 3/5 we used to use xmallocz, so
> you're essentially just reinstating the previous safety guards.

Yes, though I did confirm that those guards were doing nothing. This is
less about protecting the new ll_ext_merge() caller and more about all
of the _other_ callers of read_mmfile().

But yeah, it is obviously a lot easier to explain if this patch comes
first. I just wasn't sure if we'd want to drop it or not (though yeah,
we probably should explain in the earlier patch that the lack of NUL
termination is OK).

I'll re-roll with this patch earlier in the series.

> > diff --git a/xdiff-interface.c b/xdiff-interface.c
> > index bc340d5a8a..b3e9f1952b 100644
> > --- a/xdiff-interface.c
> > +++ b/xdiff-interface.c
> > @@ -166,7 +166,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
> >  	if (!(f = fopen(filename, "rb")))
> >  		return error_errno("Could not open %s", filename);
> >  	sz = xsize_t(st.st_size);
> > -	ptr->ptr = xmalloc(sz ? sz : 1);
> > +	ptr->ptr = xmallocz(sz);
> 
> I was staring at this code a while before I noticed the added `z` at the
> end of this function.

Heh, fair. I'll say something more explicit in the commit message when
re-rolling.

-Peff
