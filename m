Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9D129E98
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472593; cv=none; b=pgW5jWyOtbFnqVHwypsagikwe6OD7dO+yCqlwk2mpJYdrV5kqDic/Hq2PedhLy2yijJT9pktAbfenBbOZStSGirNlIEl4skPATRdDYkjRlE94L8fI01n5m2Sh5opNmrQ/pgFpikH+c9vuCTkxmKgy+3ZzqFnTrfBkvzlMvl8+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472593; c=relaxed/simple;
	bh=svlxB3oQtP86MtaNS5dMDtNvgUYYFNs9JtUQCHCumfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrrhtOj4st5nwd64b3m/VpUXc+GoctCOUQeSiMRiIe/ozJ2EiKZx6vcrHDhCaGJkWLZgemsk5ZAbOfcUapoFNfH1uUQ38cCjncnYSgt0udjat7HR1ivQDmBahRR2oA6SszV0EX3KUuL2SxcncJQ6zvM0A4lZCrQQhTz4bH2m/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3162 invoked by uid 109); 30 Apr 2024 10:23:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:23:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5500 invoked by uid 111); 30 Apr 2024 10:23:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:23:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:23:10 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <20240430102310.GC1279403@coredump.intra.peff.net>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>
 <ZjCd_drNT6kyjNa6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjCd_drNT6kyjNa6@tanuki>

On Tue, Apr 30, 2024 at 09:30:05AM +0200, Patrick Steinhardt wrote:

> So the reason why pseudorefs exist is that some refs behave like a ref
> sometimes, but not always. And in my book that really only applies to
> MERGE_HEAD and FETCH_HEAD, because those contain additional metadata
> that makes them not-a-ref. And for those I very much see that they
> should not ever be a symref.
> 
> But everyhing else living in the root of the ref hierarchy is not
> special in any way, at least not in my opinion. We have never enforced
> that those cannot be symrefs, and it makes our terminology needlessly
> confusing.
> 
> I think I'm going to reroll this patch series and go down the nuclear
> path that I've hinted at in the cover letter:
> 
>   - Pseudo refs can only be either FETCH_HEAD or MERGE_HEAD.
> 
>   - Refs starting with "refs/" are just plain normal refs.
> 
>   - Refs living in the root of the ref hierarchy need to conform to a
>     set of strict rules, as Peff is starting to enforce in a separate
>     patch series. These are just normal refs, as well, even though we
>     may call them "root ref" in our tooling as they live in the root of
>     the ref hierarchy.
> 
> I just don't think that the current state makes sense to anybody. It's
> majorly confusing -- I've spent the last 8 months working in our refs
> code almost exclusively and still forget what's what. How are our users
> expected to understand this?

Yes, I very much agree with your final paragraph. I have been working on
Git for 18 years, and am learning new things about pseudo and special
refs in this thread. ;) (Admittedly, I think that distinction is new in
the past few months).

I think the "everything is a ref, even at the root" is the simplest
thing for users. And the only rules they need to know are the syntactic
ones: names start with "refs/" or are all-caps and underscore. But I do
not see the value in them caring that HEAD can be a symref or that
MERGE_HEAD cannot (nor the value in the code making such a distinction).

My series does not enforce the "_HEAD" suffix (plus special cases) as a
syntactic rule, but we could do that easily on top. That would help
protect case-insensitive filesystems from the same shenanigans that my
series aims for (e.g., "CONFIG" on such a system will still look at the
"config" file).

It is unfortunate to me that we even need to call out FETCH_HEAD and
MERGE_HEAD. I know they are special within Git, and probably ref
backends need to be aware (because they have to be able to carry extra
data). But from a user's perspective they resolve in the normal way
(unless you are trying to look at them in their special non-ref way).
I guess the user must care that they will always be in the filesystem in
order to access them in that special way, though.

> > Are there any practical implications of the changes in this patch for users
> > running commands like "git log FETCH_HEAD" (I can't think of any off the top
> > of my head but it would be good to have some reassurance on that point in
> > the commit message)
> 
> Not really, no. We have never been doing a good job at enforcing the
> difference between pseudo refs or normal refs anyway. Pseudo refs can be
> symrefs just fine, and our tooling won't complain. The only exception
> where I want us to become stricter is in how we enforce the syntax rules
> for root refs (which is handled by Peff in a separate patch series), and
> that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
> They should still resolve when you ask git-rev-parse(1), but when you
> iterate through refs they should not be surfaced as they _aren't_ refs.

I actually would not even mind if they are surfaced when iterating with
--include-root-refs. But then I am a little skeptical of the purpose of
that feature in the first place. After all, the reason code shoves stuff
into .git/FOO_HEAD is precisely because we don't want other stuff
iterating over them, using them for reachability, and so on. That is why
"--all" does not include them, for example.

But I did not follow the development of the feature, so maybe I am
missing some cool use case.

-Peff
