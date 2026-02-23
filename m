Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700045695
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840014; cv=none; b=qdu7AGj0g9ufhsG62iqKJCad0CuqoJV1ekafveghweOwJOB/8H3GZNhmiZqcBDeTL44kwdHMwf5bsqKT3c6o0zVkDvfVgjPuzOyGKqvtyZUE8I3xJrS2FjObKnA8BWfagvH/uVDn+/E1V5m2kQlGXm0BVhtDAogtrLWz7nx6EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840014; c=relaxed/simple;
	bh=X6TXJhH/p18pqRhMtGaf8nL22Rp6cGS1aPlCsyvb2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh425kes/mSb6XFiZlasEp0ugzZXC/3hhw/jNfatTLjWJCs1STa4FdEaprgFQGObHvmKsa5LcKjNLoa55wcZ/frXMRDrDtoA03v2c6Cuov2N6WCgZa5is69MSClG5NFoqg96wMy45opkWRG9TUxSzx+t8NryO0dIR/byB/zMGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MVDNcWss; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MVDNcWss"
Received: (qmail 50228 invoked by uid 109); 23 Feb 2026 09:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X6TXJhH/p18pqRhMtGaf8nL22Rp6cGS1aPlCsyvb2O0=; b=MVDNcWssROghyixdpzrHIv4LZOUx3GbUuhAjGncEyuIlC00/9Qs1ZCs0ATiTGfZTo/4CAOiPmAp48p6sOrjbpg9QdC5aTMsbWJZDJC3JM3Kt1wwHEmSlbDzYWHkDU8FRgqzQ2rVfdsHtValv6PA4MnYZ2KZ9e45LO4ht9/x5HRUx2H1zBr/hnf8+pG+bIc3KIQoHuP5KU2hOc7zM0grfqkveI9HkK9ptWezcNsBjJXeYloGNkXY6o+ko3reQC9MuXHICV2NdNBoO5Um/c1YMORIQf+eiHeBbd+KC7dpc5sX1gZMUt4elmImzF+Cko8StT61/JV8ffnjz5DRx0HpOUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 09:46:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 97101 invoked by uid 111); 23 Feb 2026 09:46:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 04:46:50 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 04:46:45 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <20260223094645.GA210808@coredump.intra.peff.net>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <xmqqv7fopflu.fsf@gitster.g>
 <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
 <20260223071215.GA136463@coredump.intra.peff.net>
 <aZwTyLMWbcXWnYhQ@pks.im>
 <20260223092523.GA209277@coredump.intra.peff.net>
 <aZwfmXG113t6OsUH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZwfmXG113t6OsUH@pks.im>

On Mon, Feb 23, 2026 at 10:36:25AM +0100, Patrick Steinhardt wrote:

> On Mon, Feb 23, 2026 at 04:25:23AM -0500, Jeff King wrote:
> > On Mon, Feb 23, 2026 at 09:46:00AM +0100, Patrick Steinhardt wrote:
> > 
> > > As pointed out in [1] the root cause is actually something different,
> > > and we merely expose this now with the MRU-based iteration. But I
> > > wouldn't mind if we eventually switched back to maintaining two lists,
> > > or finding a different way for how to maintain the iteration order.
> > 
> > Maybe I don't understand what you're saying, but isn't the root cause
> > the same?
> > 
> > Code is iterating the list, and then during that iteration calls
> > find_pack_entry(). The fact that fsck only calls find_pack_entry() in
> > some subset of cases is immaterial, I'd think. The risk is always there
> > when iterating now.
> 
> It is, true. All I'm saying is that the problem runs a bit deeper, and
> that fixing the actual root cause would also fix the issue reported by
> brian.

Ah, OK, after reading your other email again, I see what you're saying.
The root cause (for you) is that it is unexpected for fsck to call
find_pack_entry() at all in this case. Which I agree is wrong, but I
just wouldn't haven't called it the "root". ;)

But I think we are both on the same page that there are two problems
worth looking at (fsck should not be looking up the object again, and we
should make iteration less susceptible to re-ordering bugs).

> So we might want to have another look at hardening packfile iteration
> either by reinstating the second list for iteration or by extending
> `repo_for_each_pack()` to also set the `skip_updating_mru` bit. Over
> time though I'd rather get rid of `repo_for_each_pack()`, and once that
> is the case and packed object iteration is neatly encapsulated in the
> backend the risk of only having the MRU will be significantly reduced.

OK. Of the two short term solutions, I prefer the double-list. IMHO
skip_updating_mru is a bit of a hack in the first place, because it
misses opportunities to update the MRU.

-Peff
