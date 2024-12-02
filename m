Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BAA94A
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173397; cv=none; b=Y3m5/wqq+vzeDI1vH1hb+KEuFW+UHFpiBxJyy9AnoJHaMod9F9oPYAXxlh6BtFHLk0wLLriU9uO34rlN6zFZ0GQwYdje3hG0iNvvFZFOWOaKHqd6fhyhqT3v/pkziHLGkKrTDBccPZuy78CNJOXoy6SHBrM6q0Zh+Ff0wOPRzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173397; c=relaxed/simple;
	bh=MUX8O3bdZCc9IHyWTKtYHD7lqTLgLmvGxrLQPkPzLcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO6zcZ58dddhUUIbflYUD6eLjxVLOmvM25+DS3/CO9mLn24epo3a0hFSimIN/qbZeB5LdPaphqoXGJoqv282+YK7Z/+wgi179qSiBYSQGbmLwA4NJ9dnvo7B16J3dlbhZ2rsr8Hdo0s7Z69vU4tJOPfbnhuP+sh/gvhj7ZTV/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SjwiVdxe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SjwiVdxe"
Received: (qmail 16752 invoked by uid 109); 2 Dec 2024 21:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=MUX8O3bdZCc9IHyWTKtYHD7lqTLgLmvGxrLQPkPzLcQ=; b=SjwiVdxeDmVZBiIJLO54zKHVHYobTs1qgb0YCZZDhtG7luGNPPQ+IZxxkh2ylhqOj42UgBX5vZ5H1PWtjXNK4pZLcLwzI30XjcBFgtZm20ZEDd87uNbcqAEwO6yuZMwG0pOZgq/YqAphC7x/hhSynGNj18h93NPGbHFEYpB/w2ZVpy8gelJNgvXjEOqqbiLg8Ry9rYeS3kLsReeGQeRkbM3w7DsNSTdYG4BDkzuuxhV3MzYBkoHg4RS/iXAfRvx8Khrxt7XJRyRyq08myhI+xkG5NGk/YzGpaeNZqvbioFGiHfrzZUdMg6GZaTrgiCO8tEKs4urXiWqKeR1zGP3u9Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 21:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26402 invoked by uid 111); 2 Dec 2024 21:03:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 16:03:13 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 16:03:13 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
Message-ID: <20241202210313.GF776185@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202070714.3028549-5-gitster@pobox.com>

On Mon, Dec 02, 2024 at 04:07:14PM +0900, Junio C Hamano wrote:

> Even though the plumbing level allows you to create refs/tags/HEAD
> and refs/heads/HEAD, doing so makes it confusing within the context
> of the UI Git Porcelain commands provides.  Just like we prevent a
> branch from getting called "HEAD" at the Porcelain layer (i.e. "git
> branch" command), teach "git tag" to refuse to create a tag "HEAD".

This looks good and mostly as expected. I do think Rubén's suggestion to
add an explicit deletion test might be worth having to future-proof
things.

> @@ -91,6 +91,12 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
>  	test_must_fail git reflog exists refs/tags/mytag
>  '
>  
> +test_expect_success 'HEAD is forbidden as a tagname' '
> +	test_when_finished "git tag -d HEAD || :" &&
> +	test_must_fail git tag HEAD &&
> +	test_must_fail git tag -a -m "useless" HEAD
> +'

The test_when_finished surprised me a little, just because we would not
expect anything to have been created. I don't think we usually bother
with cleaning up failure modes, as it is a losing battle (if the test
did not succeed you are only guessing at what mess may have been left
behind). But I don't think it's hurting anything, beyond a few wasted
cycles to run what should be a noop.

-Peff
