Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465D368D78
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404841; cv=none; b=mQKpv+4jGqo6PF+9REuAy2uUVMge2Ult+aMe8EYJHv5UgM3yxozt9lSzONvddsuHv9Awffi/LOASJjbkUv6UR3ZnUGwm3bwUWHcZmNeyRHyG22dKNI4k7cqc3NmR3TwbSyW5lwA2smRKRe06KpLpCRMYDBRTSzDmBywT2XzmD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404841; c=relaxed/simple;
	bh=NY2wSWZnjttFVYfKrfBHXvJ5JA2Nnf/nH4gYMgc5+EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU7r2uFHis2DvkBtY9dr/MhekeLteqkBnwtr1fT8FOXKZHYkIVVAR+kmDavNR2tWWmHg944tg8s5KQlQrIAWr9s5jq7H1q76eytukuQUtLK+bBGSHVQGmUT9mKqX1y9rjUK5J3wNYro6NeTi53h+1YVVP3NkPxJuTxEvhR1jvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NRMoM8ML; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NRMoM8ML"
Received: (qmail 5670 invoked by uid 106); 14 Sep 2026 16:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NY2wSWZnjttFVYfKrfBHXvJ5JA2Nnf/nH4gYMgc5+EY=; b=NRMoM8MLHk7PzlFbTWqbEoozs+CXhHt0vVAw+JAF5uMrv7gp2MeK2f2x/aQAQSSqAJS+iaTEm95Pkky3F4ENnCjDKNSZbjYsd7BR3F0TOqscf9rwqKZ9iEl91xJ+LmRYc5+gOZh7VixRFuNWCjkfuAWuNzwxjuAh17X4UALfLeoYhGeCHEwKSYlVUmzUe6NjVVudSY71+9hGvU6SD8os4h2WEHZnCpu85o08/Ae5ixawUYzQ4ZX/JPZZikEHJuXD3FJPf6JUalvPQSd3KD8MmPp36cC5THFO5eIQrwILNXAd/02QkztWp5k/KR0tkzU3bBVIcJsXAspT/l4jow6inw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Sep 2026 16:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32376 invoked by uid 1000); 14 Sep 2026 16:53:51 -0000
Date: Mon, 14 Sep 2026 12:53:50 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, git@vger.kernel.org,
  Jean Delvare <jdelvare@suse.de>,
  Usman Akinyemi <usmanakinyemi202@gmail.com>, Taylor Blau <me@ttaylorr.com>,
  Junio C Hamano <gitster@pobox.com>,
  =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/3] merge-ll: use strbuf to read back external merge
 result
Message-ID: <20260914165350.GA32247@peff.net>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
 <20260911171124.GA1610200@coredump.intra.peff.net>
 <CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com>

On Fri, Sep 11, 2026 at 11:06:33AM -0700, Elijah Newren wrote:

> > -       result->size = st.st_size;
> > -       result->ptr = xmallocz(result->size);
> > -       if (read_in_full(fd, result->ptr, result->size) != result->size) {
> > -               FREE_AND_NULL(result->ptr);
> > -               result->size = 0;
> > +
> > +       if (strbuf_read_file(&result_buf, temp[1], 0) >= 0) {
> > +               result->size = result_buf.len;
> > +               result->ptr = strbuf_detach(&result_buf, NULL);
> 
> I know the type mismatch is pre-existing, but the order makes the new
> behavior different. On LLP64, assuming the usual wraparound, a result
> of LONG_MAX + 101  narrows to the negative value  LONG_MIN + 100 .
> 
> The old code narrows before  xmallocz() , so it requests an impossibly
> large allocation and dies. The new code allocates the actual buffer
> first, then records a negative size; callers converting that size back
> to size_t could read past the allocation.

Hmm, yeah. I noticed the possible truncation, but reasoned that it was
roughly the same before and after (the only difference being that we
know would actually have the full buffer, just a truncated size). But
you're right that negative values introduce their own distinct type of
confusion.

> Would a simple fail-fast make sense?
> 
> if (result_buf.len > LONG_MAX)
>         die(_("external merge result is too large"));

Yeah. I think we should be doing that even with the current code, as
it's possible for us to silently truncate a merge result (e.g., wrapping
beyond 4GB goes back to 0).

There's a similar case in read_mmfile(). There we actually bother to use
xsize_t() to catch _some_ problems, but of course we are using "long"
and not "size_t" in the mmfile, so it's still subject to truncation.

We can't just use read_mmfile() here, because there is an artificial
distinction between mmfile_t and mmbuffer_t, even though they hold the
exact same members (IIRC, one is for "output"). But possibly we can use
it and just assign the members, which is no worse than what we have to
do with the strbuf.

I'll plan to add a check like the one above here and in read_mmfile(),
and then look at re-working this cleanup to use that function. I'll
probably also peel this off of the other patches. It's really two
separate topics: this file-read cleanup, and the tempfile-deletion
improvement that started the thread.

-Peff
