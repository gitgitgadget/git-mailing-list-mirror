Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D267BB00
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538637; cv=none; b=FTxXEGJQRUsU2fHioNLvFJSQZl/o1LL5oXNl+SaNds7fG2sP8BaJu5qiu4tYRtjoycTfAv+KnqFkBsj5TW7h7GOU9nrw7RmiGObmvMJv9Z8lrDvTanYCTabYYSR4c60g2i/x37NVe65VQ9tF5/PsbJS0QQFFhIKcXynIZAw4EyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538637; c=relaxed/simple;
	bh=k16oBuOCHrAgO7ArjYH5JOj1zUkhvXUhZJrnfvTgoQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZPXhHIFe+SslJtfguvome9gPypdLt2mux50PBy4dQtMc5KCfYhKu83O8xPuXNvLuiyUqF5YvWqaE9rgroSXDOcG9tH1DD4k6AfsfuX7ycNVY/NMbo+KOq3Ps4uYYu71hxr85NVQ8Y8VYlv8YNIGmqMyC883OhEFmP2T8a4DFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7807 invoked by uid 109); 21 Feb 2024 18:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Feb 2024 18:03:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6506 invoked by uid 111); 21 Feb 2024 18:03:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Feb 2024 13:03:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Feb 2024 13:03:54 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,
	Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Emily Shaffer <nasamuffin@google.com>,
	Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
Message-ID: <20240221180354.GE634809@coredump.intra.peff.net>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
 <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>
 <20240220025722.GE2713741@coredump.intra.peff.net>
 <70a81f5a-32d8-4517-83ea-8019be5f97d5@gmail.com>
 <ZdSYxF3Hd6Zqt3Wd@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdSYxF3Hd6Zqt3Wd@tanuki>

On Tue, Feb 20, 2024 at 01:19:16PM +0100, Patrick Steinhardt wrote:

> While we're already at it throwing ideas around, I also have to wonder
> whether this would be a long-term solution towards computer-friendly
> errors. One of the problems we quite frequently hit in Gitaly is that we
> are forced to parse error messages in order to figure out why exactly
> something has failed. Needless to say, this is quite fragile and also
> feels very wrong.
> 
> Now if we had a more structured way to pass errors around this might
> also enable us to convey more meaning to the caller of Git commands. In
> a hypothetical world where all errors were using an explicit error type,
> then this error type could eventually become richer and contain more
> information that is relevant to the calling script. And if such rich
> error information was available, then it would not be that far fetched
> to ask Git to emit errors in a computer-parsable format like for example
> JSON.

I think what I'm proposing (and if I understand correctly what Phillip
was thinking) is somewhat orthogonal. I agree that structured errors are
nice for computers to read. But it does open up a pretty big can of
worms regarding classifying each error, especially as root causes are
often multi-level.

For example, imagine that the caller asks to resolve a ref. We might get
a syscall error opening the loose ref. Or we might get one opening the
packed-refs file (in a reftable world, you might imagine errors opening
various other files). What is the structured error? Obviously it is "we
can't resolve that ref" at some level. But the caller might want to know
about the failed open (whether it is just ENOENT, or if we ran into
EPERM or even EIO).

Or looking at higher levels; if I ask for the merge base between A and
B, but one of those can't be resolved, how do we communicate that error?
It is some sort of "cannot resolve" error, but it needs to be
parameterized to know which is which.

All of those questions can be answered, of course, but now we are
developing a micro-format that lets us describe all errors in a
standardized way. And I think that is going to put a burden on the code
which is generating the errors (and potentially on the consumers, too,
if they have to decipher the structure to figure out what they want).

Whereas what I was really advocating for is punting on the structured
thing entirely. We keep our unstructured string errors for the most
part, but we simply let the caller pass in a context that tells us what
to do with them. That lets us keep providing specific error messages
from low-level functions without printing to stderr or exiting, which
higher-level code (especially lib-ified code) would not want.

I think it could also be the first building block for making more
structured errors (since those low-level callers are free to provide
lots of details), but it doesn't have to be.

-Peff
