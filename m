Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697D14C585
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051971; cv=none; b=NaiQIa6dG0PIOYdkFLzRu4+v9yZenEuy2taAm2N4zmCsUcwPCNEJSZAb0EQCmDd1nQ+oF4Yk21YRBHl5JnHUmHnr9a75nhY6SZPfBIroY++IeaKvgL+PgTd8BmeBcQhEOGEcO5QyjdUfKAgBvKOQnpSFj/ItnR+TAvHf5pR/QK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051971; c=relaxed/simple;
	bh=FevgYOQLAzXI6NmfEKfldJnis06b+qMVL2TnE3DB94g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqAuh4ez1RjK5Gc+YpA8AIWFTK6oGOEpQizT5hYoAGMmni2L0B499cUR/NBvcAB9g3SkFQbf3F5BrSRVGlcmo4Hk+pUJyxL/AIvuFq6i3tIrfrUpqvwydlOAyHGj8DCyt1ibSQL26dDGglvnALBXS00wnk4I7rTndpy4pEe/QN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14422 invoked by uid 109); 30 Aug 2024 21:06:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Aug 2024 21:06:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27486 invoked by uid 111); 30 Aug 2024 21:06:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Aug 2024 17:06:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Aug 2024 17:06:07 -0400
From: Jeff King <peff@peff.net>
To: Yuri Karnilaev <karnilaev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Unpredictable peak memory usage when using `git log` command
Message-ID: <20240830210607.GB1038751@coredump.intra.peff.net>
References: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>

On Fri, Aug 30, 2024 at 03:20:15PM +0300, Yuri Karnilaev wrote:

> 2. Processing commits in batches:
> ```
> /usr/bin/time -l -h -p git log --ignore-missing --pretty=format:%H%x02%P%x02%aN%x02%aE%x02%at%x00 -n 1000 --skip=1000000 --numstat > 1.txt
> ```
> [...]
> Operating System: Mac OS 14.6.1 (23G93)
> Git Version: 2.39.3 (Apple Git-146)

I sent a patch which I think should make things better for you, but I
wanted to mention two things in a more general way:

  1. You should really consider building a commit-graph file with "git
     commit-graph write --reachable". That will reduce the memory usage
     for this case, but also improve the CPU quite a bit (we won't have
     to open those million skipped commits to chase their parent
     pointers).

     I haven't kept up with the defaults for writing graph files. I
     thought gc.writeCommitGraph defaults to "true" these days, though
     that wouldn't help in a freshly cloned repository (arguably we
     should write the commit graph on clone?).

  2. Using "--skip" still has to traverse all of those intermediate
     commits. So it's effectively quadratic in the number of commits
     overall (you end up skipping the first 1000 over and over).

     It's been a while since I've had to "paginate" segments of history
     like this, but a better solution is along the lines of:

       - use "-n 1000" to get 1000 commits in each chunk

       - use "--boundary" to report the commits that were queued to be
	 traversed next but weren't shown

       - in invocations after the first one, start the traversal at
	 those boundary commits, rather than HEAD

     You'll probably need to add "%m" to your format to show the
     boundaries (or alternatively, you can do the commit selection with
     rev-list, and then output the result to "log --no-walk --stdin" to
     do the pretty-printing).

-Peff
