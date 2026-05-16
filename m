Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAC1A3154
	for <git@vger.kernel.org>; Sat, 16 May 2026 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897626; cv=none; b=C8+j2nxdyJI/A1e35Fy9M60lGNppzh2bJ1OzC5MVYserjrJC7SI7POGLDiRwWMkIX+mjBiEP6QdEhBXEFJuZtjNhX9kCaxjeyLs152EF9So+RuPribwB8CiPYFlQXrzlcQHHlDLrGRYxO7wPEX2K1IKKIropsDfB+DdOi9A2ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897626; c=relaxed/simple;
	bh=5RhIg43T1zxbaZAHuhES/S+IFnwEJvZtAhBfEznNOy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovuhDhZkJawlp7jYzV7I6MndJ9M6CP56yLoae25fxmmbHNn8MXhwdEtkDuqUXco68ngWFqQ2u+Z9NyMyV15f99B5ifob/04btmQMn7kAXTatSUbVnkIosvftKg8K365MPEQnagKfTTJukzBNLQRiUtExkYXI3k86hu1f/cMkWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KN3ZP1a0; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KN3ZP1a0"
Received: (qmail 3308 invoked by uid 106); 16 May 2026 02:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5RhIg43T1zxbaZAHuhES/S+IFnwEJvZtAhBfEznNOy4=; b=KN3ZP1a0+O7V4uFlQmw1n6Mx+QuZrZHVqwAxhEBKwZgZELG/dqucyaVQ36C5l1MTXn9ZpUCgsEjnf0lqUy5F3vnPctlvpCAyX6wWfwnyiSwrGM/JCe6UnVDbTARHgZ5g/04FoHftwRJupIB6sVHVYdCS/BpJqDMIK0i2Amjqsvok4EA76qPzHEpoLK3gDk4pCLmT+1YvvEpozr/1rWXRa9/rBJQmi3S1iKF+NMDHJJ6MGjW97V4Tt1ZggyzSpInTQUlJHkXwUWc4gY/6zaU/3tgi+W3Ulm/6ZhH4dKluv64+DiwzeOVv4jwkrfV22+IIZEBpzytam/WxAPSktf7ECg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 May 2026 02:13:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7442 invoked by uid 111); 16 May 2026 02:13:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 22:13:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 22:13:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: UBSan failing on expensive test(s)
Message-ID: <20260516021343.GA174647@coredump.intra.peff.net>
References: <871pfcdyt0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pfcdyt0.fsf@gitster.g>

On Sat, May 16, 2026 at 08:43:07AM +0900, Junio C Hamano wrote:

> This started happening on 'next' that runs EXPENSIVE tests thanks to
> Dscho's recent updates to enable them in CI.
> 
> https://github.com/git/git/actions/runs/25896439353/job/76110441841#step:10:2172
> 
> It claims that """
> 
>     commit.c:1574:6: runtime error: signed integer overflow:
>     -2147483648 - 1 cannot be represented in type 'int'
> 
> """.
> 
> Another is related in the sense that it used to be hidden behind
> EXPENSIVE prerequisite, but is probably unrelated.
> 
> https://github.com/git/git/actions/runs/25896439353/job/76110441842#step:10:156

These patches should fix both.

  [1/2]: apply: plug leak on "patch too large" error
  [2/2]: commit: handle large commit messages in utf8 verification

 apply.c  |  6 ++++--
 commit.c | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

-Peff
