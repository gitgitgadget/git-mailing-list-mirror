Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1F186A
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735935853; cv=none; b=UdPNegpt0kz7z/xNkh7uzKZQ7sKqDUAgp8E4eAZDBvSB8HeaaL2B5hkbjEoDFjDKc5vQ1dRk51Dy4dC1wtGo+IcT+36Aqlbh2VaVuFNltKswyVGq6ftyso9/3GQpC8vflWpGkwdejf8+NhZcqTcGKiVOJzDLiGEilfHcDe19FDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735935853; c=relaxed/simple;
	bh=x2+WJlhMtrdY7PvWZTkyhv5WuCiY0xjThzUa0DpTu70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flKjNAubS4s/If8gRJTYBWVcWb5RyNTLVLJ/tqcp+q4sF4UnNg3YXnGIo91/TeTX8dReSzLpCXi5NlXPLLnewTClrNPt4o3aD+6whvBBFxEEmfrfS71LHkVIJnGB0eUqvYVz1nD5KZcLJrdHgyO1BbXf0/JgKpRdcGweHm1d3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EWmbUdcc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EWmbUdcc"
Received: (qmail 19028 invoked by uid 109); 3 Jan 2025 20:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=x2+WJlhMtrdY7PvWZTkyhv5WuCiY0xjThzUa0DpTu70=; b=EWmbUdccY6/sPT4zmPUjiZQro4zJFI74rMowYqc71Rh7V3CTE0bfBiV4xD2cqu53k2fn0PzVNbKm8p+J5Ho85xUtwIOXqePYsTHUsJFsWgkzKPf1PTeZoRoAfY9G5cGli72+xZi3dBFHXLoHj4fdrRLHW9motNcGotgOSZDIW+qgNVlAZqCe26nDIXJhn2qx9dTGpEiZIJ9wuf/XedGdA4fBwYu+R39O+5gwh1gFAVg09g3AubA1r4kW9xxr1l7LE+olpOukzn/B4OVrJmQx5/5Sql/MA3TA2NjNxio90TVEOvYAofsKv1MsAA37xi0xCGy2s4ti+dAuB3HrhvDp5w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 20:24:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4856 invoked by uid 111); 3 Jan 2025 20:24:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 15:24:10 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 15:24:10 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] test-lib: simplify leak-log checking
Message-ID: <20250103202410.GC3212696@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101201721.GD3305462@coredump.intra.peff.net>
 <Z3fSmSYoWs-a6afW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3fSmSYoWs-a6afW@pks.im>

On Fri, Jan 03, 2025 at 01:05:45PM +0100, Patrick Steinhardt wrote:

> On Wed, Jan 01, 2025 at 03:17:21PM -0500, Jeff King wrote:
> > @@ -1181,8 +1170,14 @@ test_atexit_handler () {
> >  }
> >  
> >  check_test_results_san_file_empty_ () {
> > -	test -z "$TEST_RESULTS_SAN_FILE" ||
> > -	test "$(nr_san_dir_leaks_)" = 0
> > +	test -z "$TEST_RESULTS_SAN_FILE" && return 0
> > +
> > +	# stderr piped to /dev/null because the directory may have
> > +	# been "rmdir"'d already.
> > +	! find "$TEST_RESULTS_SAN_DIR" \
> > +		-type f \
> > +		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> > +	xargs grep -qv "Unable to get registers from thread"
> 
> Can't we use `-exec grep -qv "Unable to get registers from thread" {}
> \+` instead of using xargs? Or is that unportable? Might make it a bit
> easier to reason about the `!` in the presence of a pipe.

I don't think that saves us from negating, though. The "grep" will tell
us if it matched any "real" lines, but we want to report that we found
no real lines.

Plus I don't think "find" propagates the exit code from -exec anyway. I
think you can check the exit status with more find logic, so you'd then
use a conditional -print for each file like:

  find ... \
    -exec grep -qv "Unable to get registers from thread" \{} \; \
    -print

and you have to check whether the output is empty. The easiest way to do
that is with another grep! Which also needs negated. ;)

I think if we really want to drop the negation, we'd be best to flip the
function's return, like:

  have_leaks() {
	# not leak-checking
	test -z "$TEST_RESULTS_SAN_FILE" && return 1

	find "$TEST_RESULTS_SAN_DIR" \
		-type f \
		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
	xargs grep ^DEDUP_TOKEN |
	grep -qv sanitizer::GetThreadStackTopAndBottom
  }

And then you could switch the initial "grep" to -exec if you want, but
there's no negation to get rid of, so it is only a preference of -exec
versus xargs.

-Peff
