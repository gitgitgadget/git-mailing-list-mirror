Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E1479894
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254483; cv=none; b=qYYwXHMTjYeEYs4oCFaOr5bRytFIuLBJ/ya7Ij+3Pl/x+XDUgl+BI7ZeM60BufkFTe/tnVCPKlsDgWbpM2AK+dPdY6pJvqF9CN2t2f+/TlQiW+yZThwRFOLLtYFSfUHCB8dq8QzuU1WYTp/0D8nz35P0fGC+izBFTEM3a2s8RTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254483; c=relaxed/simple;
	bh=tuTUCzutvBEi3g5ezLoopRJgJ2Ali8zOSVjQ+P1uqDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4KDH6hgCMeX6WdpwCPWJ8uXj9WxTOfLPtMNLCCkuk85j/83GE/BaWb/8V4gZ4Nv6kvZesXJamaujp/oIOWJ5ey42Z8qVTBmWF5hrrbnl1qSMIMZgmgSQuaFZDpuxU8UAdVQ/B76qZge8LXhCRfdQhAR9RIl+OxFLnWS1ed7r3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XAmAKq1x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XAmAKq1x"
Received: (qmail 7555 invoked by uid 106); 1 Sep 2026 09:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tuTUCzutvBEi3g5ezLoopRJgJ2Ali8zOSVjQ+P1uqDU=; b=XAmAKq1xodH3W5yZcmIQkJHTXnyjpL/XUuWtF9jbeyRzsPVvCJAiElPON7u2dnapvr3o5pZvVo5OyaGsJBiDhhE3ZEIg0n1Bo2lbc0UzIL/dmgnxlCuY+kmZS4pzYKdI56DN/s8BVd0nkW19iHqSYp4eqBrABON8OUcNYEuDA1IHy9aHEThsQV1QBjWuWtRTY0auJkGy1rV5JvH9tcIT2fwv25DtyvD1nI5HSu54wYyv0M2sQ+DTRrX3H1F79sKN9lZ44gFmFsc8J2T78cX36gWIpSSj+V9cIBNWhdeJrjrK/cJKDGMteZdDkUzwhAs5pNbTGeEUGiyAZrbvvmnWHA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 09:21:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35448 invoked by uid 111); 1 Sep 2026 09:21:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 05:21:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 05:21:20 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Nicolas Le Cam <niko.lecam@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: hang on to "freed" argv elements
Message-ID: <20260901092120.GA2979683@coredump.intra.peff.net>
References: <20260830215555.2660035-1-niko.lecam@gmail.com>
 <20260901062815.GC1075462@coredump.intra.peff.net>
 <apaSDqIEyc82Q_zE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apaSDqIEyc82Q_zE@pks.im>

On Tue, Sep 01, 2026 at 10:51:26AM +0200, Patrick Steinhardt wrote:

> > This fixes the prefix case above (which is now tested in t3903), and
> > should fix any other stray cases. Though I could not find any; we use
> > OPT_STRING only in the prefix diff options, and very few revision opts
> > store strings. Those that do (like --format and --encoding) already make
> > a copy of the string. They do not need for us to hold on to the memory
> > longer, but it does not hurt them if we do.
> 
> So the fix could've been as trivial as you mention above, where we
> simply perform a copy of the string for "--src-prefix", and everything
> else works just fine?

Well, and --dst-prefix, and also any other cases that get added later.
And keep in mind that --src-prefix and --dst-prefix are not even in the
revision code, but in the diff code. So we'd be creating a very subtle
requirement for somewhat far-away code to adhere to.

> In any case though, your approach is more defensive and makes it way
> harder for such use-after-free bugs to be introduced going forward, so
> I'm in line with the proposed patch.

Yeah, defensive is exactly what I was going for.

> > +static void mark_argv_for_free(struct rev_info *revs, const char *str)
> > +{
> > +	if (!str)
> > +		return;
> > +	strvec_push_nodup(&revs->argv_to_free, (char *)str);
> > +}
> 
> Hm. Doesn't this mean that we take ownership of the string and then
> eventually try to release it when releasing the vector? I wonder whether
> this could introduce subtle lifetime issues where the caller passes a
> non-heap-allocated string.

Yes, that's exactly the point. We are replacing a call to free() with
one that passes ownership to a strvec which later frees it. If somebody
is passing a non-heap string along with free_removed_argv_elements, then
everything was already broken.

> I don't think it's that bad when seeing where we use these. But I feel
> like hiding this fact by marking the parameter as `const` is a bit of a
> weird design choice. I'd much rather prefer we force this onto the
> callers so that they are aware of this, but I haven't seen the end
> result of that. So maybe it's just too ugly.

You can see the effect already in the diff. In the preimage all of the
callers had to cast away const-ness in order to pass the string to
free(). We could keep doing that here, but since this function has
exactly one purpose (to free the string we pass it) it seems like a nice
syntactic convenience to push the cast in here.

Though you may want to look at the "2/1" I sent, which pushes the check
for free_removed_argv_elements into this function. And then the cast and
that check are side-by-side.

-Peff
