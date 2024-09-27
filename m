Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF202C9A
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727410519; cv=none; b=qkSqLddb2/9p9isXbK8HvfH0wYhQNjUEv3bEpj9OGajB64gyqp/dMwAz5VhCLz6LIx0rcwDWvufUEnN6Fqu+zYSFFC7qga6NEIOaAvV/C5p0z9WtF3528ZQyMS++RJs2eEzJWkdsi9vOmQ4DDU5fIzdGdTgmkzGFSUwk868+DAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727410519; c=relaxed/simple;
	bh=cT17gy6qRMlK9bJJDZG7vcGpAlTT0pEnUDyXvVVFIcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYc99A0RyUsact9cMfiUF6QkKKkCq3GVDdgs0SwAmpGIiii0JpZNtSBx89nG/sDMrfO5R/c6Evox+UwK6HfzbV3q9qtM0uJMjaXf7S4dFnsy4XD/OvOIorcv8Q4VMtMlOxDzk2IogL4iAy9R28w4b/B9Xz7xydzrVB5neDeH+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4956 invoked by uid 109); 27 Sep 2024 04:15:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 04:15:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9320 invoked by uid 111); 27 Sep 2024 04:15:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Sep 2024 00:15:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Sep 2024 00:15:16 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: "Stephen P. Smith" <ishchis2@gmail.com>, git@vger.kernel.org
Subject: Re: Can a note be pushed to origin?
Message-ID: <20240927041516.GA568026@coredump.intra.peff.net>
References: <20240925122515.14015-1-ishchis2@gmail.com>
 <6b69af87-9002-46a7-a5f3-3fa1fb7ba9df@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b69af87-9002-46a7-a5f3-3fa1fb7ba9df@app.fastmail.com>

On Wed, Sep 25, 2024 at 05:29:30PM +0200, Kristoffer Haugsbakk wrote:

> That will refuse to update if your own notes ever diverge from the
> remote.  If you want to always overwrite your local notes with the
> remote ones:

There are some specialized strategies for merging notes (e.g., taking
the union of lines). See the "merge" subcommand in git-notes(1).

I don't recall ever really using it myself, and I don't think there's
really any porcelain support, so you're on your own to invoke the merge.
But I guess the use case would be something like:

  # fetch their notes into a holding spot
  git config remote.origin.fetch refs/notes/commits:refs/notes/origin/commits

  # and then after every fetch, you merge if necessary. By default we're
  # merging into our own "refs/notes/commits". And it should be OK to
  # use the short "origin/commits" here, since notes-refs have their own
  # special lookup rules. Though using the fully qualified refname is
  # probably reasonable, too.
  git fetch
  git notes merge -s union origin/commits

-Peff
