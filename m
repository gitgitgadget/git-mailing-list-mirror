Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503801BDE6
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057469; cv=none; b=VBaSY1oGulOVBB2/x7iLjpZkfeeMD+E6wt520ISHcDpXr0fgMXUi6b49ogcy3CRBp6cFCEGizVDYMAZP4ldgnZhrXH2RjV9g1Ct2LcgxIp1TWvUYVmjWz/XG3lsxVFLlktkc9qlqcNixyvDvnpJbQsmPk5CoWf/Z6P7MqOy96/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057469; c=relaxed/simple;
	bh=cH2IUwlZBHO2a4fHxOLt/u1j8BHlLbNjVfJCzTaEIyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT2pjLg8s34pGALYCOQrv9/2SPFCyYfBHcjS2GbuHEpMg3cG2PHnwY1JnfEY18Ob1ntmFBbbGMlzqGEsRqviWo0CWn5tKTMnbUmKjzBKPjIXa/mB6dFh1XiMAKEMvEhTz13qnF+nvbRAi5DN1PEI3++XEFz4Ur+2LuN85GL810c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8743 invoked by uid 109); 19 Aug 2024 08:51:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 08:51:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17534 invoked by uid 111); 19 Aug 2024 08:51:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 04:51:10 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 04:51:05 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t7900: exercise detaching via trace2 regions
Message-ID: <20240819085105.GC2955268@coredump.intra.peff.net>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>

On Mon, Aug 19, 2024 at 09:48:02AM +0200, Patrick Steinhardt wrote:

> In t7900, we exercise the `--detach` logic by checking whether the
> command ended up writing anything to its output or not. This supposedly
> works because we close stdin, stdout and stderr when daemonizing. But
> one, it breaks on platforms where daemonize is a no-op, like Windows.
> And second, that git-maintenance(1) outputs anything at all in these
> tests is a bug in the first place that we'll fix in a subsequent commit.
> 
> Introduce a new trace2 region around the detach which allows us to more
> explicitly check whether the detaching logic was executed. This is a
> much more direct way to exercise the logic, provides a potentially
> useful signal to tracing logs and also works alright on platforms which
> do not have the ability to daemonize.

Nice, this is so much cleaner than the way the existing test worked. The
code looks good, but...

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 074eadcd1c..46a61d66fb 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -950,8 +950,9 @@ test_expect_success '--no-detach causes maintenance to not run in background' '
>  		# We have no better way to check whether or not the task ran in
>  		# the background than to verify whether it output anything. The
>  		# next testcase checks the reverse, making this somewhat safer.
> -		git maintenance run --no-detach >out 2>&1 &&
> -		test_line_count = 1 out
> +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +			git maintenance run --no-detach >out 2>&1 &&
> +		! test_region maintenance detach trace.txt
>  	)
>  '

...I think this "we have no better way..." comment is now out of date
(and can probably just be dropped).

-Peff
