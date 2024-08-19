Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CA15B972
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057387; cv=none; b=kMY5UdUCiftzC3nmixa16D/96iMHlemPUUTFn9TXmc4t1knBkf6Hc+TKdz+YXxRcxJU7Bit5O2+V6KL1t4Flk+dK9H16yqzkS0yGZI4mVUJB/oiOwd6Ts7J9lEZLNAv+tcCQEC278eFPuod5xnk8GxSHe4hMdjBwWfrBvtKsRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057387; c=relaxed/simple;
	bh=eRq/4KFc6rdA5btvqbVV5LoHfs3JuLaszLeBngHjypg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MriVsqnCsCIKkuA4khGa/rCahyjdjxTfhv6aOqIPVvQYPe3ZhHQiDO2Ae+G+vZHiQxhw8s1VkJlzWJ5yKq7e1FAI9hXwbcykRNTULogagTGXGsb7J+XyV9a4g/A3I4S2SoclsWNQms8i6iqvchS9p2AN4UtEF/tdKhNRkZGCDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8727 invoked by uid 109); 19 Aug 2024 08:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 08:49:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17502 invoked by uid 111); 19 Aug 2024 08:49:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 04:49:48 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 04:49:43 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t7900: fix flaky test due to leaking background job
Message-ID: <20240819084943.GB2955268@coredump.intra.peff.net>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <4805bb6f6c2c96a2c40d1d8359b63b8c7045e0b6.1724053639.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4805bb6f6c2c96a2c40d1d8359b63b8c7045e0b6.1724053639.git.ps@pks.im>

On Mon, Aug 19, 2024 at 09:47:59AM +0200, Patrick Steinhardt wrote:

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 06ab43cfb5..074eadcd1c 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -967,8 +967,13 @@ test_expect_success '--detach causes maintenance to run in background' '
>  		git config set maintenance.loose-objects.auto 1 &&
>  		git config set maintenance.incremental-repack.enabled true &&
>  
> -		git maintenance run --detach >out 2>&1 &&
> -		test_must_be_empty out
> +		# The extra file descriptor gets inherited to the child
> +		# process, and by reading stdout we thus essentially wait for
> +		# that descriptor to get closed, which indicates that the child
> +		# is done, too.
> +		output=$(git maintenance run --detach 2>&1 9>&1) &&
> +		printf "%s" "$output" >output &&
> +		test_must_be_empty output
>  	)
>  '

This looks correct, but should we be doing it for all of the "git
maintenance" runs in that script? They're all going to kick off detached
gc jobs, I think.

-Peff
