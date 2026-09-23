Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826BF55295C
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182032; cv=none; b=gwbD/wZn3kckGgxJWLImFtzFSpnVJOaeYmBzPmOQiu58g2RpsnC47P2XuffoH/ADWf5RKcDquD+E9nc3lytQkaf6wXAWejlVWq76IBybXjc8LmYZiSWj7XksswYs5eYg8g5kGdn2gpNG+mCdQuFOUBOBIULidTNY8DT/9wZQRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182032; c=relaxed/simple;
	bh=/wwuCQ4R43gJ7Qr87wNcwWNisgU/R+7t2RgcoHH2wA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8MI5s1nlgZF2yPxbt61L1d+Ru+PMclF2UZN7O2ll+/fMcZIxqYRyG4EZk9XoDaHpKzpL+E+Bwxkd0yt5IVXg7Fne+dIvoB/RvYKljU99KmCQiyTdzUnF7YqX2hFCKNRyUjg0dm7oD7F9ikG23tbaAI4aiogdWgnUDmwNukVnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YrhhH7zF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YrhhH7zF"
Received: (qmail 35085 invoked by uid 106); 23 Sep 2026 16:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/wwuCQ4R43gJ7Qr87wNcwWNisgU/R+7t2RgcoHH2wA0=; b=YrhhH7zFR4SBsEaUR+SDIqI15uwgW2S9kyD2u2+zsW3kTN8D+U2SfRM2/OvYxWTjXuWPVxq2MQEgXt+Z6BjH5vYAZNl8dB8pntnZ7KXxuw/56W1panrV6+rsKmaVepVU6bGLRE5j5QZ6cM2ZhN77fte5JTqf96hWqvkbNRkXJSKCdVmf8lZeGLAJWG+peH4OixmmcFAxgzinKfE4qboXV+UP4p3pTYuqzwpwqN25YoAmLqbWjWJzWvz+Tdg3LYDf/BuX1d4kocyFD0TLl1c2WuQAiMc2S9aGhks6UUtYuniiZkXpOhMF+BZJ5N9a/cTTbXUwgAvyHMOl9ths6qU7qw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 16:47:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 181453 invoked by uid 111); 23 Sep 2026 16:47:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 12:47:01 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 12:47:00 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication
 failures
Message-ID: <20260923164700.GA28538@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>

On Tue, Sep 22, 2026 at 11:06:13PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Anonymous discovery succeeds, but the upload-pack POST requires
> authentication. Apache can return an early 401 and close the HTTP/2
> stream before libcurl finishes sending the request body. Debian 12's
> curl 7.88.1 treats that closure as a transport error instead of allowing
> an authentication retry. Curl fixed this handling in 331b89a319d0
> (http2: polish things around POST), included in 8.3.0:
> https://github.com/curl/curl/pull/11756
> 
> This did not happen before switching to Debian 12 because Debian 11
> ships with libcurl 7.74.0-1.3+deb11u16, which does not have that bug.

Thanks for finding and fixing. I saw this yesterday but hadn't had time
to dig in yet, and your explanation is very satisfying. :)

> Replacing the packaged libcurl with a modern build would defeat this
> job's purpose of testing older supported distributions. So let's simply
> exclude the flaky t5559.15 and its dependent t5559.16 on Debian 12 until
> the packaged curl carries the fix (or until the end of time, whichever
> comes first).

That should reduce the immediate CI pain, though I can think of two
downsides:

  - we're detecting based on CI job name, not on the presence of the
    known bug. So it won't help anybody running the tests themselves
    (even people on debian-12!)

  - we're relying on test numbering, which can change over time. So if
    we add new setup tests early in t5559 (actually, t5551 which it's
    based on!) these will silently go out of sync.

So an ideal solution to me would be more like t5559 checking for the
buggy version itself, setting a prereq, and then marking the tests with
!HAVE_CURL_HTTP2_BUG.

That said, I'm not sure how tricky that would be to implement. We give
the curl version with "git version --build-options", but we'd have to do
some version number comparisons. It might not be worth spending a lot of
time on this.

-Peff
