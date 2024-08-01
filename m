Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDF154BE3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491129; cv=none; b=PIPTDzoMYzoDbZkQbnIznYoHu/FYYcdBF/r6v4T3+qp6djFRJZ460gvVEcrYt2zQ+JfbeSJvcJPuSPsGs+P+I+xyiC7vRw1iw6LghJYpn+V50K/Sh3kiUh/gf2Bopk+MqHjZJY/uYvGz6Po7JV7Uh1Vtpv+6NwDD3crFmZemmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491129; c=relaxed/simple;
	bh=bpFh69uO3WpyUBeOqE2yIJvvKFYTMb5qm7O0c7ppUGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7mxW3B1DIhPkVzhlsbFyrkB2u0br+xX13xjEYNoQE5QdS0loW0Q/SrSd81yGYOiGL8tc+D/RcahTykDfyh0+ov5FdeTIsIugkWp2byKqX53tQJN7vtUNqMz0OPuSB0drn/2BjseqQ3ku8yOzufv+rabXExS3lhp4Bg3LpOdceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14659 invoked by uid 109); 1 Aug 2024 05:45:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 05:45:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27360 invoked by uid 111); 1 Aug 2024 05:45:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 01:45:28 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 01:45:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ryan Hendrickson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH v3] http: do not ignore proxy path
Message-ID: <20240801054523.GA621899@coredump.intra.peff.net>
References: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
 <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
 <xmqqle1hyzcu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle1hyzcu.fsf@gitster.g>

On Wed, Jul 31, 2024 at 03:24:01PM -0700, Junio C Hamano wrote:

> > +start_socks() {
> > +	mkfifo socks_output &&
> > +	{
> > +		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
> > +		socks_pid=$!
> > +	} &&
> > +	read line <socks_output &&
> > +	test "$line" = ready
> > +}
> > +
> > +test_expect_success PERL 'try to start SOCKS proxy' '
> > +	# The %30 tests that the correct amount of percent-encoding is applied
> > +	# to the proxy string passed to curl.
> > +	if start_socks %30.sock
> > +	then
> > +		test_set_prereq SOCKS_PROXY
> > +	fi
> > +'
> 
> Making it a regular test_expect_success would mean GIT_SKIP_TEST
> mechansim can be used to skip it, which is probably not what you
> want.  Can't this be a more common test_lazy_prereq, perhaps like
> 
> 	test_lazy_prereq SOCKS_PROXY '
> 		# useful comment about 30% here ...
> 		test_have_prereq PERL &&
> 		start_socks %30.sock
> 	'
> 
> or something?

I think Ryan picked up this approach from my earlier mail. And the
reason I suggested doing it this way is that the prereq test has an
important side effect: it creates the socket and starts the proxy
server!

I think lazy prereqs only make sense when their only output is the
yes/no of whether we match the prereq. And then we don't care when or
how often they are evaluated. I do think things would work, assuming the
proxy server then can serve multiple tests. It just feels weird, and
doing it more like the git-daemon/http tests made more sense to me
(though those ones do not even do their work inside an expect block).

If we did it in a lazy prereq I think you'd need to munge the path, as
the lazy prereq operates in a throwaway directory (so the %30.sock would
get removed before we can use it in the next test).

-Peff
