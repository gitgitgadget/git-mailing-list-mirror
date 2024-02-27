Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5F56440
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021105; cv=none; b=VbkYCsH5FbNX3fYGflc6pZyN0aQM6WrM7VvtVoh1amXeOafFMMKjG/J+9VjYAcaVRHHNVbXsYyLFFzL6tE2t8hFSH/kA3XmInTsGTGMQTOeTJJLgI4uzn1wJMU5KGHkMROY3T6zvOTLApZdEy4H20f/1oJlcCSt7Pj7z/SKr7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021105; c=relaxed/simple;
	bh=Z3nEpSlO3S974d1uI3t52dRi4m+6NNtEJmvRnJ9gwww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiqHUGWcpm0kajw6cSbH9Vez5Y71TRWCtlO0Wssbizf33hVJSWsf5ofjHYqPBn5eB2IKiQYwRVUkEEXYtyTFwWq9ZJOMCOFwE2+bQ6+uI/y4Izko7WPk8xy3IINUfcVygdDw188rG5QFc1Y+qu/HQ7FJYfr8JAydM//9j8yH2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11069 invoked by uid 109); 27 Feb 2024 08:05:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 08:05:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7286 invoked by uid 111); 27 Feb 2024 08:05:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 03:05:06 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 03:05:01 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty
 reflog
Message-ID: <20240227080501.GF3263678@coredump.intra.peff.net>
References: <20240226100010.GA1214708@coredump.intra.peff.net>
 <20240226100803.GC2685600@coredump.intra.peff.net>
 <xmqqmsrncf3r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsrncf3r.fsf@gitster.g>

On Mon, Feb 26, 2024 at 09:25:28AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  	if (!cb.reccnt) {
> > +		if (cnt == 0) {
> 
> Style "if (!cnt)" ?  In this particular case I do not think it
> actually is an improvement, though, simply because zero is really
> special in this logic.

Yeah, I didn't really choose "== 0" as a conscious decision. But I do
tend to write "!cnt" when available, so I think I sub-consciously chose
this as a better description of the intent.

> 
> > +			/*
> > +			 * The caller asked for ref@{0}, and we had no entries.
> > +			 * It's a bit subtle, but in practice all callers have
> > +			 * prepped the "oid" field with the current value of
> > +			 * the ref, which is the most reasonable fallback.
> > +			 *
> > +			 * We'll put dummy values into the out-parameters (so
> > +			 * they're not just uninitialized garbage), and the
> > +			 * caller can take our return value as a hint that
> > +			 * we did not find any such reflog.
> > +			 */
> > +			set_read_ref_cutoffs(&cb, 0, 0, "empty reflog");
> > +			return 1;
> > +		}
> 
> The dummy value I 100% agree with ;-).
> 
> You mentioned the convenience special case for time-based reflog
> query for a time older than (e.g. @{20.years.ago}) the reflog
> itself, and perhaps this one should be treated as its counterpart,
> that is only useful for count-based access.

I think the true counterpart to that would be extending what's added by
patch 2 to get_oid_basic() to stop checking that we hit the count
exactly.

Let me try to lay out my thinking. If you _do_ have a reflog and the
request (whether time or count-based) goes too far back, read_ref_at()
will give you the oldest entry and return "1". And then in
get_oid_basic():

  - if it was a time based cutoff (like @{20.years.ago}), we will issue
    a warning ("log only goes back to 2024-01-01") but return the value
    anyway.

  - before this series, if it is a count based cutoff (like @{9999}), we
    fail and say "there are only have N entries".

  - after this series, we special case asking for @{9999} when there are
    9998 entries by returning the "old" oid but not issuing any warning
    (we do not need to, because we found the right answer for what it
    would have been had that old entry not been pruned).

  - what we _could_ do (but this series does not), and what would be the
    true counterpart to the @{20.years.ago} case, is to allow @{9999}
    for a reflog with only 20 entries, returning the old value from 20
    (or the new value if it was a creation!?) and issuing a warning
    saying "well, it only went back 20, but here you go".

I'm not so sure about that last one. It is pretty subjective, but
somehow asking for timestamps feels more "fuzzy" to me, and Git
returning a fuzzy answer is OK. Whereas asking for item 9999 in a list
with 20 items and getting back an answer feels more absolutely wrong. I
could be persuaded if there were a concrete use case, but I can't really
think of one. It seems more likely to confuse and hinder a user than to
help them.

-Peff
