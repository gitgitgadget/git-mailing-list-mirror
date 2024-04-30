Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29912C472
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473716; cv=none; b=f8rhuWmY2s1Op/9VYipk4EAXde1aFMGZ6KLWppqGtPQ6id/WD40Ht8a6qld+hiB/NFotDNbxG0HLN1/waEx/I+eT6Waybv6NucbKETYRWfvHeKosNlJFfSOgYBCbsxt0q03K5bFL5vpVl5Zv5c/jlZdUwQ5p14PTrqZi71CZANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473716; c=relaxed/simple;
	bh=Tm3sWoXLOgLc4jFnHn5zTNpMf/tgBv2tP3riX6xCvRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI4jJcj3svvhURUNftyoCHB8dKo78IKoqSODkM5rvbIVv7I6lG1TjWN2VyodUwgX7gaIVMRziS0nre1Lh/a2rjIy1mnfxSX6afJwz/iIJeiVQ0/9poqF/AW4YslxrqJxdZgTv+hd3haZln25wWAk3Qy4cmN0SurlS4MEu3euxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3574 invoked by uid 109); 30 Apr 2024 10:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:41:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5694 invoked by uid 111); 30 Apr 2024 10:41:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:41:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:41:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] refs: check refnames as fully qualified when
 resolving
Message-ID: <20240430104152.GF1279403@coredump.intra.peff.net>
References: <20240429083533.GG233423@coredump.intra.peff.net>
 <ZjB5dPoEoq8D6qzJ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjB5dPoEoq8D6qzJ@tanuki>

On Tue, Apr 30, 2024 at 06:54:12AM +0200, Patrick Steinhardt wrote:

> > diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> > index 120e1557d7..5fb780cb08 100755
> > --- a/t/t1430-bad-ref-name.sh
> > +++ b/t/t1430-bad-ref-name.sh
> > @@ -400,4 +400,14 @@ test_expect_success 'update-ref refuses non-underscore outside of refs/' '
> >  	test_grep "refusing to update ref with bad name" err
> >  '
> >  
> > +test_expect_success REFFILES 'rev-parse refuses non-pseudoref outside of refs/' '
> > +	git rev-parse HEAD >.git/bad &&
> > +	test_must_fail git rev-parse --verify bad
> > +'
> > +
> > +test_expect_success REFFILES 'rev-parse recognizes non-pseudoref via worktree' '
> > +	git rev-parse HEAD >.git/bad &&
> > +	test_must_fail git rev-parse --verify main-worktree/bad
> > +'
> 
> Are these really specific to the REFFILES backend? I would expect that
> the reftable backend sohuld fail to parse those, too. The fact that we
> write into the repository directly during the test setup doesn't change
> this, because all this patch is about is that we don't want to parse
> random files in the Git repo. And that is something we should want to
> enforce for all backends.

So this is where I will show my ignorance of reftables. I assume it
still has to implement FETCH_HEAD as a file (since it holds extra data).
But does it do the same for other names outside of "refs/"? I am
assuming not in the paragraph below.

I would expect the test to succeed after my patches on any ref backend,
since we'd enforce the syntax outside of the backend-specific code. But
for a backend which does not look for the root name "foo" directly in
.git/, it is not an interesting test. The looked-for name does not
exist for it, so even if we did try the lookup, it would fail. We cannot
distinguish the two cases from the outcome we see.

So I think dropping REFFILES it would still pass, but we are not really
testing anything that interesting for reftables. That said, I would be
OK dropping the REFFILES in the name of simplicity and just documenting
it in the commit message.

-Peff
