Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0432F74D
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078118; cv=none; b=FUg7wILz7rDdOhJ60aJRcNY4jjNhAMxAgHfxdNcvWwDkfV512qPfy3Eeign/4Kl5sDst9kHw2ltRl3bpjHwph2vcdNOUsNqcSpEAEnD8aQIvV19V3wBWYUjiYrXwwZQ3QzMp7Ni2iFvgYb0qPmtAse+UzufCcJLGyP1kJ508W8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078118; c=relaxed/simple;
	bh=szT2AeyYNHFwf2djyxI/CmpS7Ylf3HZKV6KA4MrkhtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD9m1uyvlPP44ir+EkAzraDvJFwC7H3wCjNu/MOzapnh5RWLp50j/lwaFuLE1q4rrRUPQLtdb5QZeiV7rs+kP2J81uYA8fJpk3dAw/iu7hAPcjQvyUDJq+417r84ubwfa7hXWC/5hOlgpU6JgYA/JLOeCTIqi8Q3JEbrefuGwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JFGqwObC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JFGqwObC"
Received: (qmail 217371 invoked by uid 109); 5 Sep 2025 13:15:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=szT2AeyYNHFwf2djyxI/CmpS7Ylf3HZKV6KA4MrkhtY=; b=JFGqwObCS4ri+Ns8BWJF8GFsUQfskwIIOix+xoRYf82wHOMnrw3HlmRCZUo+DUYffHZm2e6CWVhg51J+Fa+BFZLDwdVNgz4+CmKxK+DwEbFZR9geMpj3kQx4Sh4o58L3wIRmLjbKSTpo8asbp0qvMCAk31RmRMOt4byBheD3pOsfBGseVjae0x3eZrJK497PSAd1WeVA19tARmv48fKK31oEWkOZlc1wVzjD83BoqgAjPXrHmuDjmjvHcX+p3QR8kYRcZqG8ATwwuF5njWbBjlGD6H8S5OVvm65DsUYHsKcqHvq4pIkbRmWHDhH+9/PITDjJKG4L9jqMevgxsO0lgA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Sep 2025 13:15:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 374621 invoked by uid 111); 5 Sep 2025 13:15:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Sep 2025 09:15:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Sep 2025 09:15:13 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
Message-ID: <20250905131513.GB596956@coredump.intra.peff.net>
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net>
 <xmqqjz2d7t2q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz2d7t2q.fsf@gitster.g>

On Thu, Sep 04, 2025 at 03:26:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's probably not worth going back and forth on this too much, but I
> > thought the happy medium was:
> >
> >   if (!s)
> > 	return;
> >
> > That is, it is perfectly reasonable and friendly for it to be a noop to
> > free-and-null a NULL value (either never initialized, or already freed).
> > The overkill was worrying about whether somebody passed in a NULL
> > double-pointer. I.e., doing:
> >
> >   alloc_state_free_and_null(&foo);
> >
> > is reasonable and should be idempotent
> 
> ... when foo == NULL, e.g., after alloc_state_free_and_null(&foo)
> has just successfully returned?

Exactly.

> I can by that argument with the reasoning in the updated log message
> below.  Does it good to everybody?

Yep, it looks good to me.

-Peff
