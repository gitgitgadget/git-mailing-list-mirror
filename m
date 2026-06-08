Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8817B418
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959798; cv=none; b=BSt8JV4toNrRc+3QEctYygCu+4VBBAg3xndhXOvuK8dh5dIwDEDMdLHqpV5K6IZpb7LVc2H5inVJ/KcfY4TzKjp/x7Zy7snN3PBv93fa1DRFTh1wJKavyVwpfmvOpsmFwqLSaQu0fkkellpiCmColhndamO5SyTf7Obh+4Iy4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959798; c=relaxed/simple;
	bh=8MvVx9izAg8VbjlMukVvAR85EBIiGuE72bTR582VUAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnHCeoieQnn4DV9+adjAS9x16xETrlwZjXjACMQFZkNBgBzSkf104EsGBja/clGxhvLn1CZyFHDl6tXcohDw0YFTW2Xg6Ywot/K+Yy9Eq36IO1n/LXWfLSbw/mpvWZHVWh0rUUyYxfBTaRVL4Mt3lsp0WtvdBohMC2fo/gKlaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U3A6qmTW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U3A6qmTW"
Received: (qmail 83629 invoked by uid 106); 8 Jun 2026 23:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8MvVx9izAg8VbjlMukVvAR85EBIiGuE72bTR582VUAI=; b=U3A6qmTW3jwrBJIb7CIxCl+pVODccyF+JjU+zd8pKUDveeDeKXiStOnNHYr/fovijJurT6cfLJ4E3PJsvS647RM6SJgxwnIriYbU6VLZGemldx4BUeAM1TQxeWX2ARhcUIcLwzMmjiXOCvgLvabj5p1BbHjMuhTgYy5nRgUqjp+CQeFvOAxVmFHXbvhJLLYFhJzl2xoy4ele1nQ/K/tH54dS13PGZaQ9rQIWeXegYAqLrGV+bjONjMwlv4H9Fl6DINg77UYN12yYB1Jp0Y3Sg0AII/UHiBFWrp9F+pZf1pSV1ujl0Tbj0fm2TsfPNtUBveFK5LlFVs7rHqA7jqBMAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 23:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 244359 invoked by uid 111); 8 Jun 2026 23:03:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 19:03:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 19:03:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
Message-ID: <20260608230315.GC340696@coredump.intra.peff.net>
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
 <xmqqa4t5yyee.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa4t5yyee.fsf@gitster.g>

On Mon, Jun 08, 2026 at 06:06:33AM -0700, Junio C Hamano wrote:

> On Sun, Jun 7, 2026 at 11:40, Tamir Duberstein wrote:
> > show_files() checks whether each index entry is deleted or modified
> > before show_ce() applies the pathspec. prune_index() avoids most of this
> > work for pathspecs with a common directory prefix, but a top-level name
> > or leading wildcard leaves every entry to be checked.
> > 
> > Match the pathspec before lstat() for the deleted and modified modes.
> > Keep the later match in show_ce() so --error-unmatch is satisfied only
> > by entries that are actually shown.
> 
> Adding an extra early `match_pathspec()` check before making slow
> system calls like `lstat()` makes sense, especially when most of the
> index entries need to be skipped.  But if most of them would match,
> then we would end up doing the same match_pathspec() calls twice for
> each path, and run lstat() anyway, so you may also be able to
> construct a perf test that demonstrates a case where this approach
> is not a clear win (or even degradation), perhaps?

The patchspec matching is linear in the number of pathspecs, so it's
easy to get quadratic-ish results by just asking about:

  git ls-files -- $(git ls-files)

So that probably provides an easy regression demonstration for this
patch.

I don't know how much it matters in the real world. That command is
_already_ slow, and mostly people don't care that much. Long ago I had
patches to build a trie of literal pathspecs, with the intent that
blame-tree/last-modified could use the pathspec mechanism, but
ultimately we took the code in a different direction. And nobody really
complained about it since. ;)

-Peff
