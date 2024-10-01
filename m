Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F211BDABD
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823269; cv=none; b=WXXjvjMISSofJvgSxjxJI7nFQdsoVnGlSyewDROCPPpywsTEyLbzx2S56NsrLamvpjKJ//PJOWVfPyY3q0e1gHG1iGxHLbt4mA1ipui4bVdTc+IlWQqP4FyAmQRjp7lAAFtK9DcwG/ieUIWkL9ETehCdl2ye6PqINMcazqDF4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823269; c=relaxed/simple;
	bh=MT4dsVseOwLQFhlGLGx/GRlgJBnzPoVtW4Wnzdi0aPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyEdlrXZ8fahHS4ekVBph8Mc9MUq3iWDPJAqfL/71vAYmOPoeDyAojHOVYlRDrvdTtLYvcTU/aXxdfup/8C2J25r4HsbakCEaXPxhMYDzLOd7JcCPgtp/P1XcqMbEFXygQlTreB2P3vFDM4IRVaGba79JhtTLJ9PQinScy31/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iTXvmcwW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iTXvmcwW"
Received: (qmail 31214 invoked by uid 109); 1 Oct 2024 22:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MT4dsVseOwLQFhlGLGx/GRlgJBnzPoVtW4Wnzdi0aPY=; b=iTXvmcwWycVJVqw6vvW/WVK8MeqLv2bjIIqcEGarmVtYub3QukOLt3naswaIkLyAf7o63Szn9G5fF6twf0RrHjLNkjrEIObrcVl51fkqv2E+Ybey8hxCPrMVZTEVa4+GB4+LXzAHZkhw6xucGCvvogfWKUtTskr28UWW+dYr3xH1o1oGZe2Fn2xuS724P5w2ZH7W8qzcupwhvbLjCPWQNU9XJfyLkNuwttOZvZghcjKupEB6BAThsXN0C3YSRzNVHC2uIchw9c+WtYVonCQ5RIB42Wf2sS/FOyxB4qhfaKFvhoM6QnA4YbzmSzXuhrbECFOF+VXLJFHqiZRK2wmrRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Oct 2024 22:54:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30545 invoked by uid 111); 1 Oct 2024 22:54:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Oct 2024 18:54:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Oct 2024 18:54:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <20241001225425.GB2317071@coredump.intra.peff.net>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
 <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
 <Zvt6LxWm8gtJGw9S@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zvt6LxWm8gtJGw9S@pks.im>

On Tue, Oct 01, 2024 at 06:27:33AM +0200, Patrick Steinhardt wrote:

> If this is causing problems for folks I'd say we can do the below change
> for now. It's of course only a stop-gap solution until I find the time
> to debug this, which should be later this week or early next week.
> 
> Patrick
> 
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 2d951c8ceb..ad7bb39b79 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -450,7 +450,7 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
>  	)
>  '
>  
> -test_expect_success 'ref transaction: many concurrent writers' '
> +test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	(

IMHO we can live with a flaky test for a little while. It's not like
it's the only one. ;) And hopefully your digging turns up a real
solution.

It also sounds from subsequent discussion that Josh's issue was on
Linux, so it wouldn't help there.

-Peff
