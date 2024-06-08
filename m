Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2414E2FF
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717839781; cv=none; b=Sr82QYS/n7utLE3vi6qCV3uxFhYBzr2ax+56rNngiDc0EctYxKWl3sJoEhAQDLmk//2HmeHlzeYuDz5z3gNM3z6ZSISiYcXEog5b1dmwyqUxJtHOe6H0gq34XwdGY2wCHe0eCxS9KED5zQtxviBrxFqxlFB4CvNe2jHL1DPTgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717839781; c=relaxed/simple;
	bh=YUIA0fASJMCBypS/6NhHRdHFQlt5VMfLaHoStUQ3waI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plXDtlzZmNdQYMueP1uk2+CJFjOa8BehfW1MXX7CaSK/FQIg/jiFKsilKwKGIWklnZlfgjYxiUI7Aq5u7BWMkvN8xfv27vLZD0ishXAN2W7hxFTxwVDuZs3lG7R74hrRM8G2s+MK2X5hhJSwaTR0Gnxyr5Fy+rb/w0nV1VI9tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7753 invoked by uid 109); 8 Jun 2024 09:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 09:42:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28994 invoked by uid 111); 8 Jun 2024 09:42:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 05:42:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 05:42:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
Message-ID: <20240608094258.GA2659849@coredump.intra.peff.net>
References: <cover.1717712358.git.me@ttaylorr.com>
 <25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
 <xmqqa5jwg1aj.fsf@gitster.g>
 <ZmN+crXyZOze122U@nand.local>
 <xmqqo78ce86p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo78ce86p.fsf@gitster.g>

On Fri, Jun 07, 2024 at 02:47:58PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> > -		result = rename(ctx->graph_name, final_graph_name);
> >> > +		result = rename_tempfile(&graph_layer, final_graph_name);
> >>
> >> Before this rename, after the close(fd) we saw in the previous hunk,
> >> there is one early error return when we fail to rename the base
> >> graph file.  Do we need to do anything there, or an unfinished
> >> tempfile getting removed at the process termination is sufficient
> >> for cleaning up the mess?
> >
> > We could explicitly clean it up, but we'll do so implicitly upon exit,
> > so I think it's fine to leave it as-is.
> 
> I am not worried about cleaning it up.  Upon exit, the underlying
> file descriptor will be closed, but this new code never does
> fclose() on the FILE* that has a buffer around the underlying file
> descriptor.  How are we guaranteeing that we are not losing anything
> buffered but not flushed yet?

I'm not sure I understand. There is no "FILE *" at all in this patch (we
use the descriptor directly via the hashfd interface). But even if there
were, if we leave without renaming the temp file into place, then that
tempfile will be deleted. So it wouldn't matter if we flushed to it or
not, because all of those byte are destined to be thrown away.

-Peff
