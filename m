Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339473E8C54
	for <git@vger.kernel.org>; Fri,  8 May 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249046; cv=none; b=GN7fVpgsZhR73XcEhLTfw7oWyvqCxApIKL8l9rahL9zw74KGtlsl+u+Fjny7lLTBF4o3xEg0TO+GQOING+nuABHQKJuA1omK0WG0KkMSge6ixL9dINUB+uoq9SB1jea6RJ60MTKCukzrN4CkowPETxPr2an88DKqbdCSkobtiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249046; c=relaxed/simple;
	bh=gkiUrwTL0pZ80oWkWTNIYDoiRexLFbErKonXy8FR0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C10bOceIZH3YdSVb8r6sc88CqYbE0CNBB36KCE7fXw/O2eio7VqVVBkGDolOKGfYoDVuX+kPCs2Pnt9RbUWDmNWNxGIxxXANvcNUpTeW6YFsr1HkdjRUKlX9cOpntd48B92iT7hAQqXr9j58WFyTYrL/AqHu7TmWsVKpJxNK5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FuzO8sYo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FuzO8sYo"
Received: (qmail 63040 invoked by uid 106); 8 May 2026 14:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gkiUrwTL0pZ80oWkWTNIYDoiRexLFbErKonXy8FR0LU=; b=FuzO8sYolQ4SasZCkgIA3Aai2TAOwJE68c59CeLjG2vyPIBzZvCVWiu9nYsdM5br4/qhj8U+GODdZF7bWU0uqJi1BuvuIS/lSqK1qKZAXBTFv/VHwZPykMr6RpoN0z84nmAdO+qDxSu7GkZsGjYl+o5BpYoOfyZDLUtu21MLAffMn0y1SRNuf6nt3+kGEzThO81j9LBvoX5YVhzU08h+GSsVRHkq2oX4sHsQMf8JSeQWmWmZCjUtCaLwHts7UbPmIeowvbPADYeTYxAVbtxm+5iUrfuKlQlAgH+weCFzKfmkfpFeZa6jAWeaed5JW+ZxG8SP/aEO527+t3R53SLN0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 May 2026 14:03:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 123625 invoked by uid 111); 8 May 2026 14:03:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2026 10:03:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 8 May 2026 10:03:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] t5551: "GIT_TEST_LONG=Yes make test" is broken
Message-ID: <20260508140355.GA709299@coredump.intra.peff.net>
References: <xmqqqznmeaco.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqznmeaco.fsf@gitster.g>

On Fri, May 08, 2026 at 02:31:03PM +0900, Junio C Hamano wrote:

> The "test_expect_success 'tag following always works over v0 http'"
> test in t5551 fails when it tries to run "git init tags", but this
> happens only when EXPENSIVE test is allowed to run.  
> 
> This is because the step tries to create a repository with "git init
> tags" but the EXPENSIVE test that runs way before it creates and
> leaves around a temporary file "tags".  Have the EXPENSIVE test
> clean it up after itself.

I wondered how and when this broke, but it looks like it has been since
2024 when the later v0 test was added. And it looks like I am the
culprit for both the EXPENSIVE test adding the "tags" file and the v0
test assuming the path is available. :)

Anyway, this seems like the obviously correct solution.

-Peff
