Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6D1A3A8A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233434; cv=none; b=tf+G3vlLyOTYX9YqLGxepTRQHvYOe056ur39yaWNaTjD7hTOLJbaQJy4NAKdd2rD1Kj0tI6HVhzio8m7KYFfZOECxZumsUTQDuVE5gIkch45y0MKu75/ldNyXvfoZKN+xQLzby3OsiLM+HY6dVtbIPJB4owvP1MNXNfFzZG8nG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233434; c=relaxed/simple;
	bh=Mmh30TqqyzWZyjBfWEsKKDZB1KofLEggPi618SMV3Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFBIvYIHL4SZRORDW3e1LDVQc23l8Ag0+ptJnhXF3+45iPF9aY7cOhNwtTAKC9n75PWK6tyb+NQzZCYkMKcXDmWswce36XOKCaHckmnMjbjEKQQI/TF8b5T02oq1+xeHSu3fpbzuBDvrn1k51F2bsARdzxVyNlBdooOSZ9h4zbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UnEHlCta; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UnEHlCta"
Received: (qmail 20974 invoked by uid 109); 17 Mar 2025 17:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Mmh30TqqyzWZyjBfWEsKKDZB1KofLEggPi618SMV3Tg=; b=UnEHlCtaqmhvsPDX0rOj1AfZdYc+ASsgcv5F5kTQgXem+fo116V0L/P0n/p29BCmSVQmJvIL6tcfp2jPQfhLE4i7cOSBh/v/5f+1hi6ItyQdZ2JWktXk2wDL+6vF413hqcSXDZ8Yhk5PJWbODMh+vfu32f4xCgPADzBkfbMlumIpwfJTh6Tgek47GAQFK+ZVSenMPRs0EWtX1KpPRHtNRFVdqNopoCBvVbtVZ2fF6GhkttresPoBXCJbcYSGnC/Ub1yBFn/3hslCxI5O7hDOlNYQkg+yVBgpbFEauhybWz3YrA8DU64MS5ObWr3nR0aqOA+tN5AU3iPANeDOn9Gdow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Mar 2025 17:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27754 invoked by uid 111); 17 Mar 2025 17:43:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 13:43:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 13:43:43 -0400
From: Jeff King <peff@peff.net>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: path-restricted log vs. subtree merges
Message-ID: <20250317174343.GA704253@coredump.intra.peff.net>
References: <Z9WSbUQw4VBQiOqi@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9WSbUQw4VBQiOqi@ugly>

On Sat, Mar 15, 2025 at 03:45:01PM +0100, Oswald Buddenhagen wrote:

> in my quest to prepare for hacking git-gui, i ran
> 
>   cd .../git/git-gui
>   git log .
> 
> the result is ... unhelpful. apart from a few commits that were done
> directly in the git repo, there are only merges. notably, there is no
> trace of the commits that are being merged (and the way gitk presents
> this partial log is even more unhelpful).
> 
> i'm speculating that this is the result of git log not handling the
> subtree merges in any way, with somewhat predictable consequences.

Yes, the merged-in paths and the paths in the original commits are
different. So the merge will update path "git-gui/git-gui.sh", etc, but
the individual commits are touching "git-gui.sh" at the root of the tree
(in the git-gui repository).

Leaving aside for a moment how --follow and other tooling could help,
the workaround in this case is:

  git log -- git-gui/ git-gui.sh lib/

You need to ask for the paths you care about at the root-level (since
that's what the individual commits from the git-gui repo will have). But
you also need to include git-gui/; otherwise history simplification will
not go down the side branches from the git-gui repo (you can also use
--full-history, but that would include a lot of irrelevant stuff). And
you need to use "--" before the paths, since the rev/path dwim logic
will only treat an argument as a path if it is present in the working
tree (which the latter two paths are not).

-Peff
