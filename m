Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156D32FA10
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308543; cv=none; b=P7QTOaTv3WdWGYVoOXHPg69W4CdPTiER2Dq2bMqwWjJMovbMg6zpmTMWXZ4EaJdPkvRZRLAXp1LDZf2bJghUUzgN6CB6C6Q5MBgAW7DG0fIVHX+Cu8CGfmFVQmTTjPucjwShLZ4p3z3Pn+8FDwmcLuFIhKt6/pdfoYQMY3cjyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308543; c=relaxed/simple;
	bh=rkHt2+pPz7LshKFW4Y0SiB7z8o+suuxYHAQMDI36ZOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs4k4dSLsGCMGo7bAYee6Djgd+Iiy568FFGanJXg0AxDcjQb56M9nc4HxdUj75fZ6jljFH3pXmOIQ3XLr5OlCa0jM/BTR69EU7p8iYQwd3IIpHnXEtovX0q0ch6d2UBEUNRP7EkA1iXSsuZJd8+r4bfoAaGHFmX1nV8s7MvSdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Glf+d63N; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Glf+d63N"
Date: Mon, 27 Apr 2026 18:48:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1777308538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAOLnNl/UkosHei9teHKUx4cppbvztPBcApFqul1O/g=;
	b=Glf+d63NW73wj1aujoK7QbTd3P31MIjWBnQ8y8ApcNqaOud0VcjmLMDyZMPxnx7KFxR60s
	JUAdpCEDISb5wK0qwW+ZpouRVdjP5HFCRF4w00MGKfAuDGlOq3oEwBYuEoUZLNugPdh1Du
	T4nDa6HY0/lwV61zIfDevCLQMzv3iBwbeaYepjOq3RyYOUSbTtXO/Ph9+jFDp74Px2DIN+
	yBjkLzX6vpzDIDMC+Xihoo3Ef1NY7jJ4CGOXlQYrMozTvXwKaxrnSGeX2Qv+vbSC6BmOPe
	V/iVxd8F0wkUET6ShtGyWyUoy0M5qRP+MWRf42Z8ekvuMKfGz94XpiT99exgFQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Mirko Faina <mroik@delayed.space>, 
	Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 1/2] revision.c: implement -b-reverse=before for walks
Message-ID: <ae-J4ooz2PJ8bZAq@exploit>
References: <cover.1776984666.git.mroik@delayed.space>
 <cover.1777249165.git.mroik@delayed.space>
 <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
 <xmqq8qa852b5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qa852b5.fsf@gitster.g>
X-Spamd-Bar: -

On Mon, Apr 27, 2026 at 03:45:34PM +0900, Junio C Hamano wrote:
> > In a revision walk `--reverse` can only be applied after any commit
> > limiting option. This makes getting a limited amount of commits from the
> > tail impossible. E.g.
> >
> >     git log --reverse --max-count=3
> 
> Can we rephrase "from the tail" somehow to reduce ambiguity?
> 
> Normally we generate a list of commits from newer to older, and you
> are saying that it is not possible to take the oldest three commits
> and show them from older to newer (i.e., in reverse).  But that, to
> some readers, is showing commits from the beginning end, not from
> the tail end.
> 
> Perhaps "... limited number of oldest commits impossible"?

Yes, will rephrase.

> > Teach `get_revision()` to accpet an argument `(after|before)` from the
> > CLI, and apply the reversal before or after the commit limiting options
> > based on this argument.
> 
> I think "after" and "before" comes from "Do other things (including
> count limiting) and then apply reverse after all that" and would be
> very much understandable to those who know how the machinery works,
> but should mere mortals need to know the machinery only to use "git
> log"?

No, they shouldn't, but...

> To put it another way, do you tnink experienced Git users who
> haven't seen the actual implementation of revision traversal can
> immediately answer this question:
> 
>     Now we have --reverse=after and --reverse=before to let you take
>     a limited history from both ends when used with --max-count.
>     Which between after and before do you think corresponds to the
>     traditional --reverse that allowed you to only see the newest
>     part of the history?

...while users might not have read the implementation (and they
shouldn't need to to use log) the order in which the class of options is
applied is already documented in the man pages, so having that knowledge
after and before do make sense despite not having seen the
implementation.

But...

> I doubt that the population to answer correctly would not exceed a
> half by large margin (if it is 50% then it means nobody understood
> the difference correctly and they just flipped a coin).
> 
> I wonder --reverse=oldest and --reverse=newest is easier to teach
> and explain?  I dunno.

...you're right, it is not immediately apparent, but neither are oldest
and newest. Unfortunately I don't think there's any name we can choose
that would make it so without having to read the caveats in the man
pages.

Since many have expressed that this issue is not really about reverse
but about max-count, like you initially assesed, then we should move
towards making changes to the max-count option.

The proposed --max-count-oldest doesn't seem right to me as
max-count-oldest is not about keeping the oldest commits (even tho
that's what we want to achieve when we interact with reverse) but about
when we want to apply max-count. Since [1],

> It might be that the right way to look at this new feature is not that
> "we are changing where reverse is applied", but "count limit is applied
> much later than usual"

maybe --max-count-later as in max count is being applied later than
usual? (either way the users will still need to reach for the man pages
for clarifications).

[1] https://lore.kernel.org/git/xmqqv7dlr4yz.fsf@gitster.g/
