Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2061C8DD
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233944; cv=none; b=FtPw5CGrUEW6MS43RuEHwF4XYi0Dk7Cqouvc4MsIoXzZymcAQqL7ygTIRrFU6BiRUT8k+Z9MoOgXhOvKrjCYyTePJBSLv71eMl4E4HpogOHbA4kvT/4jq2PWCzMVGIGRskAMOd8CVVbTzIfw8MEdM2nMYIlHDi+xFtH70ahSv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233944; c=relaxed/simple;
	bh=wD/A6o2XiVOIX9PdAq2Rtq8PzLJAxQsgnOTeToyEAr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDkx4hJy/Ct7p6H7Uafl6tQjkyDnKL+kkKF8WQys8qE6nQGrgH+YpwM5p89DPfg7RKsvkueWCz0nO6ZhLOEkwAiHdoxeuHYhzkJS8taTt4tMzh1UIRD/OxP05eSdif0cCTCzbacf8VNUOXKBMJZp5AAaGYjC81Jdym9W961QAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17271 invoked by uid 109); 12 Mar 2024 08:59:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 08:59:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27818 invoked by uid 111); 12 Mar 2024 08:59:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 04:59:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 04:59:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] cat-file: add %(objectmode) avoid verifying
 submodules' OIDs
Message-ID: <20240312085901.GA69635@coredump.intra.peff.net>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
 <xmqqwmq8o36j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmq8o36j.fsf@gitster.g>

On Mon, Mar 11, 2024 at 02:43:00PM -0700, Junio C Hamano wrote:

> It is somewhat unsatisfying that --batch/--batch-check lacks so
> much.  Even with %(objectmode) its nature of one-object-at-a-time
> makes querying children of a large tree a chore, when you compare it
> with something like "cat-file -p HEAD:" that allows you to grab the
> needed information for all children with a single invocation.
> 
> This is orthogonal to what the patch wants to do, which is to enrich
> the output side with more formatting, bit I wonder if we want to
> consider enriching the input side?  e.g. instead of feeding just a
> single object name from the standard input of "cat-file
> --batch/--batch-check", perhaps a syntax can say "Here I have the
> object name for a tree-ish object, but please pretend that I gave
> you all the objects contained within it", or something?

That is an interesting direction. In practice I guess you might want to
expand trees (to show their contents) or perhaps commits (to traverse
history and/or look at their trees). And we already have tools to do
that.

So for example you can already do:

  git ls-tree --format='%(objectname) %(objectmode)' HEAD

Or if you wanted to mix-and-match with other cat-file placeholders, you
can do:

  git ls-tree --format='%(objectname) %(objectmode)' HEAD |
  git cat-file --batch-check='%(objectname) %(deltabase) %(rest)'

That is a little less efficient (we look up the object twice), but once
you are working with hex object ids it is not too bad (cat-file is
heavily optimized here). Of course in the long run I think we should
move to a future where the formatting code is shared, and you can just
ask ls-tree for deltabase if you want to.

I think leaving this to specialized tools like ls-tree gives them a lot
of flexibility that a special input mode to cat-file might find awkward.
For example, recurse vs non-recursive tree listing. Or filtering with
pathspecs. And of course when you get into commits and traversal, there
are many rev-list options. :)

The strategy so far has been making sure cat-file can efficiently take
in the output of these other tools to further describe objects. But
moving towards a unified output formatting model would be even better, I
think. In the meantime, I think cat-file learning %(objectmode) makes
sense for single names (rather than listing trees), and fortunately it
uses the same (obvious) name that ls-tree does, so we won't have a
problem unifying them later.

The patch itself looked reasonable to me, modulo the comments you
already made.

-Peff
