Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DA17BD9
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719804060; cv=none; b=iJtZGcYpTGpKgpRXEx/oqI0MIpCjqCI8jNgXEsQMcLSL8KWJS/9z4iibPKg9rAGF5dQOodc3rVkSYuwLZvm+2v15yl6+fQmTCbDgy08barxKstEMs5D/+dJ8tvuztM1ilG1Q7aOzfidbsLO5EYcw8ZeVyCU7oefT2EN7nwM7dJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719804060; c=relaxed/simple;
	bh=TbTUIXuV5Sc3ICLfHA6PXrkjejBBLRlM2LpTUiICNqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZRw8F8g0SWJvT4LaIxn3IOalmqcEyVqja8kru6qwk2YopuzHSThqcc2vuLGiajGh6SY5GP/Ik1cO100YCMpLCmO51spizgT3ECrGsbc1O+2DJUqC0lzTZnbPqe9ugOYcd1osoqqIDLg0gKIE/bZBslAEV+iE5/gmpk0Y3EXDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16865 invoked by uid 109); 1 Jul 2024 03:20:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 03:20:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8352 invoked by uid 111); 1 Jul 2024 03:20:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Jun 2024 23:20:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Jun 2024 23:20:47 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
Message-ID: <20240701032047.GA610406@coredump.intra.peff.net>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>

On Sat, Jun 29, 2024 at 05:35:31PM +0200, René Scharfe wrote:

> Provide the expected output of "test-tool example-tap" verbatim instead
> of as a here-doc, to avoid distractions due to quoting, variables
> containing quotes and indentation.

I'm not really opposed to this patch, but I wondered...

>  test_expect_success 'TAP output from unit tests' '
> -	cat >expect <<-EOF &&
> -	ok 1 - passing test
> -	ok 2 - passing test and assertion return 1

If you could take the test input on stdin, like so:

  test_expect_success 'TAP output from unit tests' - <<-\EOT
	cat >expect <<-\EOF
	ok 1 - passing test
	ok 2 - passing test and assertion return 1
	[...]
	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:64
	#    left: 'a'
	#   right: '\012'
	[...]
	EOF
  EOT

would that be preferable to moving it to its own file? I kind of like
keeping everything in the test scripts themselves so related changes can
happen side-by-side, though I admit in this case it is intimately tied
to the separate test-example-tap.c source anyway.

But I do have such an "EOT" patch which I've been meaning to send out,
since it makes many of these quoting annoyances go away (though of
course it leaves the indentation).

-Peff
