Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94CF1CCB54
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809710; cv=none; b=n5T309V5rczu4CrMwECEh8wg5dSconFwPSns7Kpio8LyrNY+yADKJPt4kwMYulXW+JWgo4OM9Gaho+KAvWLLo/llZIcFtph1bg3Kf45+elEwX5KDzVvSYuPfUxKHjbuDSGsCDejBQGULzbvXoEIb00rDqDvvEux/MAc7WBOhIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809710; c=relaxed/simple;
	bh=7i9M/6PdHa4FSQn2Z6tpQ0GsAUbKbLxXd4vW5enieQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1SeKl39SOarfW9x1V2Yl5ir8gFhK/Cu54mptJVRbiYx0Vwonwf/fwKOshUFqcHstQTSyXfQ3XJRYEdjQw8kJODUU9p4gxoivzWDyBFG0pHjY0b0PmFfwoCWAmHdrH1uH5FzYbVRruYa/UTru9YNX4SuI0IK8nRdjGzyE1akUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hFijIxx7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hFijIxx7"
Received: (qmail 27712 invoked by uid 109); 1 Oct 2024 19:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7i9M/6PdHa4FSQn2Z6tpQ0GsAUbKbLxXd4vW5enieQI=; b=hFijIxx7yNr5yMvz32if7ru7Mnid0H6hP3PRJ06xh0QwFYfMlnv/h0t6LvaFiy0zOf3q9NNhqNM9BEgnsYkG+a48LFqrjdGFcde2LRcovBieGZ0eQrCpiAbuCRn3y6aq5+hD0hEm4Y4tIC53xDY3dHlhJftF/JzKZTuxnA/F010HxZkRlQe8VU0I1NO/lrMRvB1M8DEfLdayjReNY8iRUtMbMj8MlrCwWCFGNXs9zykwXhPx4QyeGBtaQS45HAnhFkTMtUAJDKjuEjj0Sx34dFZE1maYcoTdMRZqTLASqLhQewIYyTJYRc0hVhhuBMVUkLbP1jaGJmeKfTFvbD7yJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Oct 2024 19:08:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28416 invoked by uid 111); 1 Oct 2024 19:08:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Oct 2024 15:08:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Oct 2024 15:08:23 -0400
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <20241001190823.GA2194387@coredump.intra.peff.net>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
 <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
 <xmqqjzes2s5y.fsf@gitster.g>
 <joxzwkbi4uqyb6d67e24ivfvb54ev5ciqgvuxgxh4nntonjwqa@az3xgiiqg4x7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <joxzwkbi4uqyb6d67e24ivfvb54ev5ciqgvuxgxh4nntonjwqa@az3xgiiqg4x7>

On Tue, Oct 01, 2024 at 11:53:54AM -0700, Josh Steadmon wrote:

> > > We're seeing repeated failures from this test case with ASan enabled.
> > > Unfortunately, we've only been able to reproduce this on our
> > > $DAYJOB-specific build system. I haven't been able to get it to fail
> > > using just the upstream Makefile so far. I'll keep trying to find a way
> > > to reproduce this.
> > >
> > > FWIW, we're not getting I/O errors, we see the following:
> > > fatal: update_ref failed for ref 'refs/heads/branch-20': cannot lock references
> > >
> > > We tried increasing the timeout in the test to 2 minutes (up from 10s),
> > > but it didn't fix the failures.
> > 
> > Thanks for a report, and please keep digging ;-).
> > 
> > Is your build, like Peff's, for Windows, or your variant of Linux?
> > 
> > Thanks.
> 
> It's our internal Debian-based variant of Linux. Sorry for not
> specifying earlier.

I just tried doing (on 'next', since the new test is added there):

  make SANITIZE=address,undefined CFLAGS=-O0
  cd t
  ./t0610-reftable-basics.sh --run=1-47 --stress

and got lots of failures like you describe. But in my case bumping the
timeout from 10s to 100s made that go away. So I think it was just the
sanitizers making things _really_ slow and causing legit timeouts.

Have you tried going beyond 2 minutes? That seems like a crazy amount of
time, but I guess it's possible on a really overloaded system. Of course
it's also quite possible that there are multiple issues and you are
seeing something else entirely. :)

-Peff
