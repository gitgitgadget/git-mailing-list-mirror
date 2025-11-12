Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20474283FC8
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931360; cv=none; b=iN6oBZuZeQn0mi32dx14HbYKiBKv6dwmranJUt07+UZy9yedDhPPkN1wDDcEv8G9ZGw6SpY8nRSjI75l8wf2Q8rsTy/PwbWccH9b6n8n4CiRhwxwmIupLl8EBrjdWOpWoWNByUv6v14rK6s4gFQo1J2cLt6mUD57Gmz3eQZDxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931360; c=relaxed/simple;
	bh=rLITcCeTIikRbwSIwhmf9TjCQX83Kh9l/kyztDhJb4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD2oogkZojzJnmZ1Hh4Q8YmN1E1KByZAfxdlcHzA7vD4SSH2iyBFSWXlJdcJRJ2ONL/njv8MocEpJynwb6jpxwrYDljvkfAU/UmXzPwPyv7E2MMKmj49uKJB9/b5yHwjDcImuE0G1ooKXVTUveQS6GgqIrn2sX3mSQadV9fdlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IToG3UoI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IToG3UoI"
Received: (qmail 494842 invoked by uid 109); 12 Nov 2025 07:09:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=rLITcCeTIikRbwSIwhmf9TjCQX83Kh9l/kyztDhJb4Y=; b=IToG3UoI1txq3yTrgbsaU3wv9SVENLQe6X13wXWy/olMG6rWTkRtgW+ust2U4IXgMFnVjmQRRJA+HawVh/Wov/lzVEGeyEsxwyww31jyq8PArUzudsicDAs/PB5ltgBHnjgzsGXb4u3tHTpRS/fZ1wPOwqEygdU4Ne6rwuH5FW7Zo1xuGU+dWhnCOyPq0veMdSJ7qrLBor0JgjjjmwWQA6gAT8uPlMh+O67Z7OF3CP2UxnYRgTEGzu5hcEU5B7JQyS08uIAJLoyxuxQghxMckOPFqoDLpOzk61MnbVXxs9aLa11nYDbTGKlCdTEp9Fe3TNIkvnLmv/lhn+/gxbz7kQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 07:09:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 785771 invoked by uid 111); 12 Nov 2025 07:09:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 02:09:08 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 02:09:07 -0500
From: Jeff King <peff@peff.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Ben Stav <benstav@miggo.io>
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
Message-ID: <20251112070907.GA431661@coredump.intra.peff.net>
References: <20251111223647.GA4055973@coredump.intra.peff.net>
 <F6B66286-64B0-47AB-A31D-50A253F001D5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F6B66286-64B0-47AB-A31D-50A253F001D5@gmail.com>

On Tue, Nov 11, 2025 at 08:30:58PM -0500, Ben Knoble wrote:

> My knowledge on memory models is a bit weak and I didn’t check
> directly, but are we implicitly assuming that we are less likely to
> run out of heap memory in such an evil case? In effect I suppose we’re
> turning a stack overflow segfault into an OOM error?

Yes, I think you could think of it that way. But there are two reasons
to prefer heap:

  1. The heap limits are _way_ bigger. The stack size on Linux is
     usually 8MB, and that is considered large. It's much smaller on
     other platforms (and especially if you have multiple threads).

  2. In C, you don't have many options for detecting the case of running
     out of stack, let alone recovering from it. Whereas you can check
     for heap allocation failures. We don't tend to do anything besides
     die() in git, but it's still nicer to have a controlled die than a
     segfault.

So switching out stack recursion to spending heap memory essentially
makes the problem go away, or at least turns it into one of the zillion
other ways that you can convince Git to allocate a bunch of heap memory. ;)

> The memory use has to go somewhere ;) presuming there’s no good way to
> only keep the relevant entries in memory, since I can of course find a
> large example that also uses each intermediate macro, so the code
> would need to get a lot smarter to collapse equivalence classes, prune
> unused paths, etc., which seems like a poor investment for what AFAICT
> is a little-used feature*.

We have a hard limit of 100MB on attributes files, which is mostly a
made-up number (it was the size that GitHub had been limiting for all
blobs for years, so we knew nobody would complain about instituting it).
From the research in 3c50032ff5 (attr: ignore overly large gitattributes
files, 2022-12-01), it would probably be fine to drop it by a factor of
10 or more.

Though I think you might be able to chain macros across files (so
".gitattributes" introduces macro "foo", and the "sub/.gitattributes"
introduces "bar" which resolves to "foo", and so on). In which case your
total size is larger, and only eventually limited by how deep a tree
we'll accept (another place where we recurse, but there is a
configurable depth limit).

So for the most part Git's protection against these sort of resource
consumption attacks is: die if the process wants too many resources, and
people who try to tickle those limits are only hurting their own repos.
It does put people who host arbitrary Git repos on the hook for managing
resources at the OS level (so greedy and malicious processes are killed
rather than bringing down the rest of the system).

-Peff
