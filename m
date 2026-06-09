Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF017745
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963897; cv=none; b=KTtErnRtjQhQJahVM+gZioAJYapqfj6441XyQmQo1y2NfoOJWPigM5vCDznk2ICpgctolP2e4oMANR6e01ngqWp6GeKFd0z4DESUZfMLt1AfEXblGCN/pQ/jymAZ7ZrQWAXA7vTUSKyoxszzYrLfTKfPRQSj/bkFxWlqHHRAaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963897; c=relaxed/simple;
	bh=Wj9k37Pcg1v6/zxPNKgqj7AWcxsFLCjQh0STiVTQ5D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDQ69X7RFjCKPdCUvKkiLFp1hMnNcQ87/RjkWoRtVGTNcHoxtWB/AWQPcNgWv6SlnokRbXfpwvtX9lRBl/492oNlALwZolVWKXNPxkSINemDqSsLoxqm4ZBzBr1P8r9A2vy69UGciS45p9m+VQ1JDFmpXldG7X+Rst4N3lBYvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZMjmw0Od; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZMjmw0Od"
Received: (qmail 84049 invoked by uid 106); 9 Jun 2026 00:11:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Wj9k37Pcg1v6/zxPNKgqj7AWcxsFLCjQh0STiVTQ5D4=; b=ZMjmw0OdinLY+FwnPkwbveRPlFSTom63dB+AeLHZ8DLdZOnIuHuKgWK8/k9fvoET3ZeS6oALk2GoqwXed5MI8yg6iESmBMBQ61mUg/b7WQ1iXLtp/iKvJ6NDp7wTbFJqci89RLydD5k41CTND03Bpw7AKEUrvTr6YN/RRxWkBryr8LnwkGmubAQ8fSSDuzszpkfRSYaxmtHt2lA5it8BDNct4AnZRZhX74bawt1QolOUVT5E8aLgKGmXnp4u413xJR1GAuDIZXuSqzJSjK26U/77kJnl9qhH3d4BMhgYg0odoyfemzJIQZ+iUNsYG9jSMXr6acs570iqf7ShF4oPCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jun 2026 00:11:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 246200 invoked by uid 111); 9 Jun 2026 00:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 20:11:37 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 20:11:34 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260609001134.GD358144@coredump.intra.peff.net>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>

On Mon, Jun 08, 2026 at 07:36:45PM -0400, D. Ben Knoble wrote:

> I'd like to report and offer to help fix what I view as a serious performance
> bug:
> 
>     "git diff --no-ext-diff --quiet" performs about ~10x slower in a secondary
>     worktree than in the main worktree.

Hmm, I get the opposite effect: it is much faster in the worktree!

I did:

  git clone /path/to/linux.git
  git -C linux worktree add --detach ../wt
  hyperfine -L dir linux,wt 'git -C {dir} diff'

which yielded:

  Benchmark 1: git -C linux diff
    Time (mean ± σ):     188.9 ms ±   2.5 ms    [User: 166.4 ms, System: 130.7 ms]
    Range (min … max):   185.5 ms … 194.8 ms    16 runs
  
  Benchmark 2: git -C wt diff
    Time (mean ± σ):      20.0 ms ±   1.5 ms    [User: 23.4 ms, System: 103.5 ms]
    Range (min … max):    17.2 ms …  24.6 ms    132 runs
  
  Summary
    git -C wt diff ran
      9.43 ± 0.71 times faster than git -C linux diff

Running:

  perf record -g git -C wt --no-pager diff
  perf record -g git -C linux --no-pager diff
  perf diff

implies that the slow case is spending a lot more time computing sha1s.
Which implies that the entries are stat dirty. And indeed, if I run:

  git -C linux update-index --refresh

now they both take ~20ms.

I wonder if it's just a racy-git problem? Many files are written in the
same second as the index, so they end up with the same mtimes, and we
have to err on the side of checking the contents.

See Documentation/technical/racy-git.adoc for a larger discussion.

So it is not really about worktrees at all, but just "bad luck" in
generating that initial index (that goes away next time you actually
make an index update that rewrites the whole thing).

I'd have thought USE_NSEC was the default these days, but looks like it
isn't? Try building with that and I'll bet it goes away entirely.

> PS I almost CC'd Peff and Patrick, whose names stood out in "git
> shortlog builtin/{worktree,diff}* object-file* | sort -t\( -k2 -g",
> but decided they'd be their own best judge of whether they can
> understand what's going on? :)

You might be interested in "git shortlog -ns". :)

-Peff
