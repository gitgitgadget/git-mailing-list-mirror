Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EF1D6DB5
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622979; cv=none; b=EXLhr9W0XF0FHpr32E7Ajs2A7ou7zybCOGED09KAiJnqZqnXH58UNPEvIcHcqFlLAodiPoljFPGSk41wnYHe571EbaA9cpl/oJJ/SCGHICjYDGcqiM5QWZvflKilRpMKPjapVZDlO5jtu1JfEdLvo5a+dnoFnIPgdTPENYmYcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622979; c=relaxed/simple;
	bh=QKgzjV0VIDYCNQBNTli0JgVWqjITdxx9oGh9dolNcnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK2Kp5AamZgfnMMljtsQMHOJay/GsZCuiTXmSmO0T7XO3BF/nHGFsfVuX9ONs7gdPd1mEFLn0ndKwMC1Z3bj2Egd2iu1mCApNuSE2KghhhxO3044lzksbjp5N5ibM5LNzlDoHsXpIzGkmyIPNQMAHBmO1+Htbb+8vliFveY+d+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FOYMJo0i; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FOYMJo0i"
Received: (qmail 30615 invoked by uid 109); 19 Aug 2025 17:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QKgzjV0VIDYCNQBNTli0JgVWqjITdxx9oGh9dolNcnk=; b=FOYMJo0isV7xgZmlL2h1qkAq0PlGI+iEqHf7pKEdN66OF8rqTvSjs31t3y2xOJHCfTPfJBnA7Dho/sRLQBXTzWo+ECwD9EN7CPQvWV9LixjdDYi0uGZ9jbhviMdkK+xO5iZEXJmjttpeN/rcS7APmgbXbISw0CH3sijG3N61d9i0NCCm5lRbpR+fJUz2TBwlusq/7p8DHKLGHN32Io/sn+KvEuoHB/EEOt1ywu5Zr4JlvNPklbWvwVeQDOmGOT4CuWQRHu3nUDfS+EE2GBryOjaQvUOP/YkHFL3t3HzzsxuhUkAfvSenDQez+meCBcAy5UjdvT4qD++iNz9gR7UEbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 17:02:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 44730 invoked by uid 111); 19 Aug 2025 17:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 13:02:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 13:02:55 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] describe: pass commit to describe_commit()
Message-ID: <20250819170255.GB1050577@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210417.GE1024556@coredump.intra.peff.net>
 <aKQwRaX94uwTwiQP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKQwRaX94uwTwiQP@pks.im>

On Tue, Aug 19, 2025 at 10:05:25AM +0200, Patrick Steinhardt wrote:

> On Mon, Aug 18, 2025 at 05:04:17PM -0400, Jeff King wrote:
> > There's a call in describe_commit() to lookup_commit_reference(), but we
> > don't check the return value. If it returns NULL, we'll segfault as we
> > immediately dereference the result.
> > 
> > In practice this can never happen, since all callers pass an oid which
> > came from a "struct commit" already. So we can make this more obvious
> > by just taking that commit struct in the first place.
> 
> I was wondering a bit about commit-graphs. We had the case in the past
> where it was possible to look up commits via the graph even though they
> don't exist in the ODB. So we might actually end up with a missing
> object if `GIT_COMMIT_GRAPH_PARANOIA=false`, which is the default value.
> But that might be fine? No idea without digging further.

I don't think existence matters here. Any call to parse_object() will
call lookup_object() and find the same commit struct we already had, and
then exit immediately because its "parsed" flag is set. So we'd never
get a NULL return from lookup_commit_reference().

> In any case, the refactoring makes sense regardless from my point of
> view.

But yeah. Even if I am wrong above, this would fix it. ;)

-Peff
