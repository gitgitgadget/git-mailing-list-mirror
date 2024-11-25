Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938F17D378
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540650; cv=none; b=HLqRJU6S5UMeSNEH/RTZRJmvFNvKC06BoJKzzAdNbJG39TQL/gMHTO8Q85bg4k6JXo6KN080Yf1lG11Dsw5/lF6TQdWT62ZVzoBNGJimTJ0QY4tCG59lelAzoux67VO3bRrfTssx8gSHcCqF+9Z4Z1FXgeLt3DIwXQAsQa+wk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540650; c=relaxed/simple;
	bh=gaGgBruWmjXDqX69FCV2VLBk9GJ0raILj0Gy9DxIzX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR+WPWRoawxIBd5og+GjanhOgAMj1a/VkpqYjVC+hg1NdJJiVb5PNcZscZb2pFtD/QmaQNhJvJEhmDssXWL4Md20SBkExmEO85l1GQ73PTo0i8bEGclAaslD+La2Q2eVcOs0AspIxMyyV/zt8VXKXQWa7LkwbjHxi+OCCxlZSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NhBFHLsu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NhBFHLsu"
Received: (qmail 11689 invoked by uid 109); 25 Nov 2024 13:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gaGgBruWmjXDqX69FCV2VLBk9GJ0raILj0Gy9DxIzX4=; b=NhBFHLsu1ZtNlGOmk+SZLq/8BQ/EGib2/4nlxOIRMj2+wbMf0cykep31DYN1E4TQY5CxSMM2NjfqIa8D6xqvQgCNL5johGB4qg9dhmKBpRMD108bUp3vRLNTKXW1JOHME6zKnr0sdHDRH/6u4g1GR/Yd1IQbhlqyaX+ya9ebKMpBC/4oM547R0CjzproVO1grqbQUypgOQRbjtEH274RgqxMX1I6QXvx4BuceC4m1U3/rEl5kczo+hr0pZ5E/Weub7sQ9tfju8AARVDR8GZnxjoXuaTjFCOwkoZQvpGDZTUGXpulUid9wswPAIervVe2Jfr0zXF1YfxHZ6zgRMf05Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Nov 2024 13:17:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10574 invoked by uid 111); 25 Nov 2024 13:17:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2024 08:17:22 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Nov 2024 08:17:22 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 07/27] bisect: fix various cases where we leak commit
 list items
Message-ID: <20241125131722.GA1613472@coredump.intra.peff.net>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
 <20241120-b4-pks-leak-fixes-pt10-v3-7-d67f08f45c74@pks.im>
 <20241125112746.GA1069812@coredump.intra.peff.net>
 <Z0RvxAkmfZhgo_LJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0RvxAkmfZhgo_LJ@pks.im>

On Mon, Nov 25, 2024 at 01:38:28PM +0100, Patrick Steinhardt wrote:

> > But we never updated commit_list. What if the first entry in the list is
> > UNINTERESTING? We'll have freed it, but *commit_list will still point to
> > it, and your free_commit_list() will be a double-free.
> > 
> > And for that matter, I am confused about what should be in commit_list
> > after the reverse anyway. Even if we didn't free that first entry, it
> > will now be the final entry in the reversed list. So wouldn't
> > *commit_list always be pointing to a single node?
> > 
> > Should the code be freeing "list" and not "*commit_list"? Should the
> > reversal be assigning "*commit_list = last" (in which case do we still
> > need "list" at all)?
> 
> Mh. By now I wonder whether this code can be hit in the first place. Is
> there ever a case where `do_find_bisection()` returns `NULL`? Replacing
> the whole branch with `BUG()` doesn't make even a single test case fail.

Hrm, I thought you were fixing a case that was triggered by the
leak-checker here. But I guess there were several hunks in the patch, so
maybe you added this one based on inspection of the code and it was
never important.

Just skimming over do_find_bisection(), it will always return something
unless it is fed a NULL list in the first place. So a NULL "best"
implies a NULL "list". Which implies there is nothing to free, because
every item from commit_list was either UNINTERESTING and freed earlier,
or made it into "list".

So could the "else" added by your patch just go away entirely?

That would also explain why you couldn't trigger this in practice; one
imagines that the bisect code may avoid getting this far in the first
place with an empty list. But you can do:

  git rev-list --bisect  ;# no revisions!

to get there. I wondered if:

  git rev-list --bisect ^HEAD

might give us the double-free, but that ends up with an empty
commit-list in the first place.

> Anyway. I'm not familiar enough with the code in question to tell, and
> it's clear that `*commit_list = best;` will leak `*commit_list` if it is
> not free'd beforehand. So I think freeing `list` is the right thing to
> do. Do you want to send a follow-up patch or shall I do this?

I'm not that familiar with it either. But it does look like the intent
was that commit_list would get cannibalized into "list" (freeing
anything that didn't make it), and then we'd work with "list" from
there. And when we _do_ have anything in the list, then we either return
it (if FIND_BISECTION_ALL is set) or free the non-best entries. But all
of that is handled in the "if (best)" block.

So I think the code was non-leaky before your patch, and you'd just want
to revert that hunk.

I'd be just as happy for you to send it. :)

-Peff
