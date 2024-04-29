Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655BEED4
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377329; cv=none; b=S3+/7Qu4940UN9TZP24VPlhJ3Y10LYv8ovv55XXrkkNTvZouMZnYK2MhvGOsGkyNnoiO9Mnur9LfosIHv+gldg8FB3PrI+1TsSBEWOdKMm2F6u2pWYc8LAU+BxlOuJNIHkYds0RTQ1HkcC3CGLEjy9W++l32kNTr2x5F4YkI8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377329; c=relaxed/simple;
	bh=OzT0Q9APVGDhtLByHuzwloRwhHiBmtTCM+ZwzR73b/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNbkPrEv3d8kHk3JIk2FZWNoF5Y80GRp2CBSjuR0zty3KdC6s0C3T7Iug7GNQI980aPMBmyqjxAeWkruotX+hme7lR1umKEPk8091FY2EKbQNSdFql6YVimYSfcHF9oLd+Uj+ZC8xL6IjmK3C7BryQV9G7zOtSsW/hwUcMZ0hHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19699 invoked by uid 109); 29 Apr 2024 07:55:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 07:55:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26624 invoked by uid 111); 29 Apr 2024 07:55:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 03:55:29 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 03:55:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <20240429075524.GA3908618@coredump.intra.peff.net>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com>
 <xmqq1q6rc44n.fsf@gitster.g>
 <20240426211529.GD13703@coredump.intra.peff.net>
 <Zi9GIN1KrfIEjwRz@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zi9GIN1KrfIEjwRz@tanuki>

On Mon, Apr 29, 2024 at 09:02:56AM +0200, Patrick Steinhardt wrote:

> > IMHO these should _all_ be forbidden, because we only want to allow the
> > more limited pseudoref names everywhere (and never mischievous ones like
> > "config" or whatever). And once we are doing that, then show-ref has no
> > need to check the format. It can just call read_ref() and it either gets
> > an answer or doesn't.
> > 
> > I don't know if that is a #leftoverbit though. It perhaps more
> > complicated than that.
> 
> Yeah, this is something that I've repeatedly stumbled over myself. If I
> remember correctly, the plan was to clean up and consolidate all these
> different functions we have for checking ref names such that they become
> easier to use and hopefully lead to more consistent behaviour.

I think the code changes here aren't too bad (modulo some
head-scratching I had to do around per-worktree refs). I'll post a
series in a moment (split off from here since we're far off topic from
the original thread).

> In any case, I very much agree that git-update-ref(1) should refuse to
> write refs with names that are known-bad. There should probably be an
> escape hatch though that at least allows you to _delete_ those, or
> otherwise there is no way to remove such a ref in the reftable repo.
> Well, except for meddling with the binary format, but I doubt that
> anybody would really want to do that.

Yeah, ironically deleting is the one thing you cannot do with them even
right now. ;) That is because the supposedly-looser refname_is_safe() is
actually tighter.

It would be tough to loosen it safely, since you don't want to allow
deleting arbitrary files in .git. Or worse, escaping .git via clever
paths, symlinks, etc. So I think at most you'd want some kind of "trust
me, for this command don't bother with ref format checks" flag.

Or alternatively, refname_is_safe() should become a per-backend thing.
And then reftables can say "everything is safe", because the ref names
are never used as paths (I think, anyway; I didn't follow all of the
discussion around per-worktree refs, pseudorefs, etc).

-Peff
