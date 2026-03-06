Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F336C0D6
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814070; cv=none; b=Pv5ykokptR0VWHiFFeidlKjHKFDBAJBjZTR2WRlA+BBAk90w1qe8mx/70eGNWy73UM5tuBiSwC9QGqDBI4qfoN7UuORFBu0mQbnbH+sXBGBxuFqs1pBfi9iHXTGsuvA6IPxxW2XzxirxEaedbS9jbGE8A9X/jlrlIaapeJaGWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814070; c=relaxed/simple;
	bh=eKJ7saYJoMVzypRpAHFfnCV385/5zS8Na+AcJNamlOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOVDTfSaOJjOiEtEmVviSvClFOvOZEoh3j5dIVhF1E2KlLhFeiKUz3+ywqNCEYt5HodfFnOCuBoxFBl4SOhvXWECRg1WoK+bMW0R357NqR9NNFAUaRUPiJ9EUMaDI99BPTekUM+qQLqWvp6c2Zvvubgllw7LwLQnaXJEtn+3JC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gq4JHfab; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gq4JHfab"
Received: (qmail 10729 invoked by uid 106); 6 Mar 2026 16:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eKJ7saYJoMVzypRpAHFfnCV385/5zS8Na+AcJNamlOU=; b=gq4JHfababcKx7e1AXHarSjWIMZto7wViNxZv+pGsbEnVdG6CecCMMB47Lyyd+8dDItIrY7M7VqIKX/mT9B1KF1L0UH3AzNZwCQaTxFwgQxiDC31Rzn/za6Qb+G3LQwjMcDRoYYvlYVp2Nz2VUMoeHV9YcZFYCODDFBiVM4mpUVTKqVrqBG3nNZg+LF8gdjAW8BYvwCVePRXV5wdrsjwNWZXDrlQLOwUjopwESc7jyQAVM56SGry/gkcCfaRD3jK9lDX7CYqp2H/AvuYfaxnbK7Jt1env/eAze8xat5SAb87ARcWtwz2uEWaKU3tVF71snBBKVDJnHpLG8WkYKFHiQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Mar 2026 16:21:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 405578 invoked by uid 111); 6 Mar 2026 16:21:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Mar 2026 11:21:07 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Mar 2026 11:21:06 -0500
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
Message-ID: <20260306162106.GA3483423@coredump.intra.peff.net>
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
 <20260305220214.GB736322@coredump.intra.peff.net>
 <20260305230315.GA2354983@coredump.intra.peff.net>
 <9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>

On Fri, Mar 06, 2026 at 04:37:49AM +0000, Ramsay Jones wrote:

> Many moons ago, when the cygwin build routinely set NO_MMAP I had an
> valgrind build of git fail with a 'double free' caused by a call to
> git_munmap() for a pointer that had already been git_munmap-ed!
> 
> In addition, the failure was not reproducible (or at least I could not
> find such a test). This was at a time when the testsuite took 4+ hours
> to run for a regular build, let alone a valgrind build. So, to try and
> pin down the failure, I created a debug version of the mmap compat
> functions, which I ran with for several weeks, without failing ... :(
> 
> It just so happens that about this time I was also testing running the
> cygwin build without NO_MMAP set. This was a success, so I dropped
> the NO_MMAP investigation, never having found the cause of the failure!

Interesting. I guess a double-free via munmap() is probably a
harmless-ish noop, rather than a heap corruption. I could believe we
have such a bug somewhere, and it may even be racy (e.g., if it requires
reprepare_packed_git(), or maybe even has to do with stat freshness when
diff.c tries to reuse working tree files).

We've been testing ASan builds with NO_MMAP for a few months now, so
it's possible that might help flush it out. Though if you ran into it in
2012, it's possible it has since been unknowingly fixed. ;)

> Subject: [PATCH] mmap.c: log mmap() blocks to avoid double-delete bug
> [...]
> In order to guard the implementation from such a calling sequence,
> we keep a list of mmap-block descriptors, which we then consult to
> determine the validity of the input pointer to munmap(). This then
> allows 'git_munmap()' to return -1 on error, as required, with
> errno set to EINVAL.

Gross. :)

This is a clever workaround, but I think we should consider it a bug if
we are calling munmap() twice and fix that.

-Peff
