Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8910E1
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712458; cv=none; b=C5NUPrNAdYps62FOLauN8Zmjp71PUEJNBreQwZ/YKWWYEmlvyM+v6SDZN8f2+MXC8+Fj41/zq95Kvt085vRTEI0n/XLjUrPbgaTNOhxOAMeMQB7u4Eq3befJum3QZr6pe+tgiBi/bJtjdBwA/PH4BWoFg3qNAcn5pkOqapqWRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712458; c=relaxed/simple;
	bh=z/e3pppRbFdw47mKdjSfs3+idHoNhGYHV3uWSQBy8hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtT4QRusmPhIHiEndmvGifvqUe4riRJ6cydvfLdzlamvSik9xP3a1k/BcgV0rLIM4pGIVmIfm6TnQSVBhyyzOQZKz01dC//w6wuEA0KyA3hOQBDEoUkGMHU+wYABjWLG5nGNyvQzavfrrcIcJ+j/bQxzW4ZtokYqUV28nKPC+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 496 invoked by uid 109); 20 Jan 2024 01:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 01:00:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6674 invoked by uid 111); 20 Jan 2024 01:00:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 20:00:57 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 20:00:55 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "R. Diez" <rdiez-temp3@rd10.de>, git@vger.kernel.org
Subject: Re: git fsck does not check the packed-refs file
Message-ID: <20240120010055.GC117170@coredump.intra.peff.net>
References: <6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de>
 <ZakIPEytlxHGCB9Y@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZakIPEytlxHGCB9Y@tanuki>

On Thu, Jan 18, 2024 at 12:15:08PM +0100, Patrick Steinhardt wrote:

> > I am guessing that "git fsck" does not check file packed-refs at all.
> > I mean, it does not even attempt to parse it, in order to check
> > whether at least the format makes any sense. Only "git push" does it.
> 
> Indeed it doesn't. While the issue is comparatively easy to spot by
> manually inspecting the `packed-refs` file, I agree that it would be
> great if git-fsck(1) knew how to check the refdb for consistency. This
> problem is only going to get worse once the upcoming reftable backend
> lands -- it is a binary format, and just opening it with a text editor
> to check whether it looks sane-ish stops being a viable option here.

We don't check the packed-refs file explicitly, but we do open and parse
it to iterate over the refs it contains. E.g.:

  $ git init
  $ echo foo >.git/packed-refs
  $ git fsck
  Checking object directories: 100% (256/256), done.
  fatal: unexpected line in .git/packed-refs: foo

It's quite possible that the reading code could be more careful. I'd
have to see the exact corruption that "git fsck" didn't complain about
to say more.  If there's a page full of NUL bytes at the end of the
file, I wouldn't be surprised if the reading code gently ignores that,
which obviously is not ideal.

Fundamentally we cannot catch all cases here; a simple truncation, for
example, might yield a valid file that is simply missing some entries.
Unlike objects (which make promises about reachability and so on), there
is no real "consistency" for the state of the refs. But probably warning
if saw a bunch of garbage in the file is a good thing.

I also agree that a specific refdb consistency check would be valuable.
There are some things that the regular reading code will not check, but
which an fsck should (e.g., if the packed-refs file claims to have the
"sorted" trait, we should confirm that).

-Peff
