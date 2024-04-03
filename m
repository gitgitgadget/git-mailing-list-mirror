Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BB14006
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107624; cv=none; b=L2S9nXbheoNVTolP0pqN2H4NLqTSE06+LfVUrIot0Q3FDrNG3hhH0dBsPnkR2O8UcyueQ1VWCRKWvct9MefYv2Q91bmocoU2MBnOZKphza3AsbyG+Gm+qxn9j3C2Pc3nhMsoCMFHqBuxaRM1IxBrsipyj/hvHcC7OhK2qOsENps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107624; c=relaxed/simple;
	bh=2OaeueEF1+6DmdEUIcvtmA6JHZTnODg0/Y70DZXhP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+UOc77glmCVspzsiyeyi9eDdNu5PNxRSumk98pAdvz2MSdtrnpmiyzBT8zsKbuNuJ0PGCmwGMKeYMhabMQkV9HBYg41E2ndsUXuUm+qgDxk48zl5XB1C3muxZ76k+bqZUYkDHHG+IVwXevO4GoEINODL3SHUzgA9fnMKBPT/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14328 invoked by uid 109); 3 Apr 2024 01:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 01:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3517 invoked by uid 111); 3 Apr 2024 01:27:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 21:27:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 21:27:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
	"Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
Message-ID: <20240403012701.GC892394@coredump.intra.peff.net>
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
 <xmqqh6gni1ur.fsf@gitster.g>
 <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
 <xmqq7chif1pu.fsf@gitster.g>
 <20240401023225.GA2639800@coredump.intra.peff.net>
 <c13c0751-0758-e068-282e-eb43496213b8@softwolves.pp.se>
 <20240401163209.GB3120568@coredump.intra.peff.net>
 <xmqqmsqd9fse.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsqd9fse.fsf@gitster.g>

On Mon, Apr 01, 2024 at 10:03:13AM -0700, Junio C Hamano wrote:

> >> That made me realize, if "git show" runs things through a pager, wouldn't it
> >> then lose the "%s is the first %s commit\n" message printed by
> >> bisect_next_all() before calling the function to show the contents?
> >> 
> >> Is that fixable?
> >
> > Good catch. IMHO we should disable the pager entirely by sticking
> > "--no-pager" at the front of the child argv. But then, maybe somebody
> > would like the output to be paged? I wouldn't.
> 
> Hardcoded --no-pager is a good workaround.  But if the output is
> long and needs paging, wouldn't we see what was shown before we
> spawned "less" on the screen when we quit it?  Running
> 
>     $ (echo message here ; git log --help)
> 
> and then saying 'q' to exit the pager leaves me "message" after that
> command line.

That depends on your "less" options and your terminal, I think. Aren't
there some combinations where the terminal deinit sequence clears the
screen? It has been a while since I've run into that, though, so I might
be misremembering.

At any rate, my concerns are more:

  1. You wouldn't see it while the pager is active, so you are missing
     some context.

  2. If you don't use LESS=F, then it may be annoying to invoke the
     pager at all.

-Peff

> > If we really wanted to keep the pager for git-show, I guess we'd need to
> > have it print the "%s is the first %s commit" message. The only way I
> > can think to do that is to pass it as a custom --format. But then we'd
> > need to additionally specify all of the usual "medium" format as a
> > custom format, too, which is quite ugly.
> 
> ;-)  Ugly but fun.
> 
> I wonder how hard it is to add %(default-output) placeholder for the
> pretty machinery.

I have a dream that all of the pretty formats could be implemented in
terms of %-placeholders. But yeah, even without that, being able to do
"%(pretty:medium)" would be cool. "Pretty" cool, even. (Sorry, I could
not resist).

-Peff
