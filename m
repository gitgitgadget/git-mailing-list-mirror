Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502548F5E
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408038; cv=none; b=cMISWzGZgaIY5CO2NzL+VaWn+PO5EBc0HY+Pl4MjB3SgrMwGVWSjAr0hzpLL4wfDwbLDyRcQ61GI1Fw3NpmGdK9h3AN1r+mjZqUHBBp2b9fG28/EVtrNYCCd9z41Qe7uB7mmH4pMBsybffBex8g2IDi5e8R5loe9O/NR7qjDNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408038; c=relaxed/simple;
	bh=8Yql5boZW7YuSQoN1QBjFPzV16ZEOGbzJd5fCfhU6Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzVwR5wRkGZsz7HvKci7EI4EBFzDvixntOZUBcBWIMFcexl01cb/mbYotT9Zwugr2Em5mfk5mJdB1Dn3qHjXiZYw6JljHjOwURsDqV5q40oqP+2YSZ+S0NViAAY4MMRDimgYIl0f9MZuiH8XNpYfZ6FnYqUjXTm4vzT93YxgzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H6Usy+9U; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H6Usy+9U"
Received: (qmail 25078 invoked by uid 109); 9 Jan 2025 07:33:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8Yql5boZW7YuSQoN1QBjFPzV16ZEOGbzJd5fCfhU6Ok=; b=H6Usy+9U+4cNyzhtaFxOib9JjOkA+npEs+C8xV7Ssh4MNC9swKpKHqm4G5QYam6BhVSKe0FRJeYTrxhQ6YBhJYSHemDNnmWGhfI9GCGqSCzZCwbX/8BkOJNbo+vcGN4trK7VOlkh78wDW758jJxM8Ph0UEpq+mMmubvkx6haiKfpXPggiY6tn12B7VMw72h6o2Z6iOFAvRKDJXOMWeO1jDGdzp9oQ+Mw/abidVTHdzylh1oV+qfDnjV1KK+CB0ejMNcqxfLhXDK4hITf3wGLSxAX/T2JGfeIFieeSkefJ/z607+oofCx88h9Venuec3H8WWiFDrzPzycjWVtpw6jUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 07:33:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19500 invoked by uid 111); 9 Jan 2025 07:33:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 02:33:54 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 02:33:54 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <20250109073354.GB2735258@coredump.intra.peff.net>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
 <20250107-b4-pks-ci-fixes-v3-2-546a0ebc8481@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-2-546a0ebc8481@pks.im>

On Tue, Jan 07, 2025 at 01:30:44PM +0100, Patrick Steinhardt wrote:

> The issue is caused by us using grep(1) to terminate the pipe on the
> first matching line in the recursing git-submodule(1) process. Standard
> streams are typically buffered though, so this condition is racy and may
> cause us to terminate the pipe after git-submodule(1) has already
> exited, and in that case we wouldn't see the expected signal.

This patch looks good to me overall, but I think there are a few small
inaccuracies in the commit message.

I don't think buffering is relevant here. Especially since in the
original test there isn't any buffering (the output comes from separate
recursive status processes, so each line gets its own write() call).

The race you're seeing is:

  1. git-submodule (or its child process) writes the first X/S line
     we're trying to match

  2. grep matches the line

  3a. grep exits, closing the pipe

  3b. git-submodule (or its children) writes the rest of its lines.

Steps 3a and 3b happen at the same time without any guarantees. If 3a
happens first, we get SIGPIPE. Otherwise, we don't (and the test fails).

And when git-submodule exits is not important. The critical timing is
when it does its final write(). If the pipe closes after that, even if
it is still running, it will not notice. (I admit that one is a
micro-nit, though).

> Fix the issue by generating a couple thousand nested submodules and
> matching on the first nested submodule. This ensures that the recursive
> git-submodule(1) process completely fills its stdout buffer, which makes
> subsequent writes block until the downstream consumer of the pipe either
> fully drains it or closes it.

One more micro-nit: "fully drains" is not accurate. If grep reads
another 4096 bytes, then that opens up 4096 more bytes in the pipe
buffer. And git-submodule can then write to it. Not important for our
case, since we "know" grep will not read more after matching, but will
just close. So it is really more like "block until the downstream
consumer either reads more or closes it".

That "know" is a little bit of an assumption. In particular, there is no
reason grep could not read into a 1MB buffer, consuming the whole input,
match within it, and only then exit. And then we'd be racy again. In
practice I'm not too worried about this. I'd be surprised by a buffer
bigger than 8k (which is what I saw when I strace'd it on my Linux
system), and your generated input is something like 160k. That should
fill even a generous pipe buffer plus grep input buffer.

> +	git init submodule &&
> +	(
> +		cd submodule &&
> +		test_commit initial &&
> +
> +		COMMIT=$(git rev-parse HEAD) &&
> +		for i in $(test_seq 2000)
> +		do
> +			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
> +			return 1
> +		done >gitmodules &&
> +		BLOB=$(git hash-object -w --stdin <gitmodules) &&
> +
> +		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
> +		for i in $(test_seq 2000)
> +		do
> +			printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
> +			return 1
> +		done >>tree &&
> +		TREE=$(git mktree <tree) &&
> +
> +		COMMIT=$(git commit-tree "$TREE") &&
> +		git reset --hard "$COMMIT"
> +	) &&

OK, so the submodule has a huge number of missing children. But that's
enough for us, because the "-" lines generated by "submodule status" are
fine. So you're able to generate the whole thing with only printf
processes running in the loops. Very clever.

> +	git init repo &&
> +	(
> +		cd repo &&
> +		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
> +		{ git submodule status --recursive 2>err; echo $?>status; } |
> +			grep -q recursive-submodule-path-1 &&
> +		test_must_be_empty err &&
> +		test_match_signal 13 "$(cat status)"
> +	)

And then adding another repo wrapping it is what makes it recursive.
Nice.

-Peff
