Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD908BE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368351; cv=none; b=fIMIR4rO3c+kLFU2BUN7vGa1aIVppMkyf9JNOVwN8UKeQbqZdA/6Ypgtr81n1XnSpnq3bjWmx4UHkLRY49Saek92mRayTEGo+yUPHPzfbyNqvIs56q+PnVJ6jsxJQL3AR1/82fCx8F+eqlc+qghR69CTuCxuSKSbrKuVeWB7OOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368351; c=relaxed/simple;
	bh=D42LY27vlRSLV+t15ut4qMS8EUgtqrFBsSePEYAP/kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbyc3J9wRJNA3Wb6OC0n6Lo0J/8BEuAH/ed3mpgby3jw0u+X9kBb11AllV9AlsmSNQj3QGP8ugO6qebqMsJpKAuHC13OO6WqieCmZdU2lirmBlvgzLnCJ/oYMajy3fEDhe0/qHKepBT/G/fPgSFW7TK6GfALOZdcBkUR2ZKxaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17104 invoked by uid 109); 29 Apr 2024 05:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 05:25:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25533 invoked by uid 111); 29 Apr 2024 05:25:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 01:25:45 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 01:25:40 -0400
From: Jeff King <peff@peff.net>
To: Thomas Desveaux <desveaux.thomas@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org
Subject: Re: Git Bug Report: git credential 'url' parsing clear other fields
Message-ID: <20240429052540.GA2892856@coredump.intra.peff.net>
References: <CACPMLSqTA6pY3hiawhTAmhfvWME8NRUehauy6g-oUaHjordWqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPMLSqTA6pY3hiawhTAmhfvWME8NRUehauy6g-oUaHjordWqA@mail.gmail.com>

On Fri, Apr 26, 2024 at 09:27:03PM +0200, Thomas Desveaux wrote:

> input:
> ```
> username=user
> password=s3cret
> url=https://example.com/repository.git
> ```
> 
> This next input works as intended.
> input:
> ```
> url=https://example.com/repository.git
> username=user
> password=s3cret
> ```
> [...]
> `username` and `password` are correctly parsed and stored in the struct.
> `url` parsing then clear the fields.

Thanks for a clear report and example.

However, what you're seeing is the intended behavior. When the "url"
feature was added, it came with these docs in git-credential.txt:

  When this special attribute is read by `git credential`, the value is
  parsed as a URL and treated as if its constituent parts were read
  (e.g., `url=https://example.com` would behave as if `protocol=https`
  and `host=example.com` had been provided). This can help callers avoid
  parsing URLs themselves.  Note that any components which are missing
  from the URL (e.g., there is no username in the example above) will be
  set to empty; if you want to provide a URL and override some
  attributes, provide the URL attribute first, followed by any
  overrides.

That last "Note that..." part was lost in 1aed817f99 (credential:
document protocol updates, 2020-05-06). Between digging around in the
thread[1] and my recollection, I think the point was that we might drop
the "override" behavior as a defense-in-depth against injection attacks
(like "path=evil/\nhost=github.com"). I.e., make it an error to specify
"host=" more than once. But we didn't actually make that code change
yet.

However, even if we did so, I think we'd keep the "clear" half of the
behavior (we parsed a URL with no password in it, so the result is a
credential with no password in it). In which case your first example
still wouldn't behave as you expected.

So I think 1aed817f99 may have gone a bit too far and caused the
documentation to be misleading. It should probably keep the "any
components which are missing will be set to empty" part.

-Peff

[1] https://lore.kernel.org/git/20200505013908.4596-1-carenas@gmail.com/

