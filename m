Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7328F4
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719804709; cv=none; b=J2yuj8UdhfsBOTMpuezExxeAcwEbmv11Tq29bduSQ+ba9XXQcEqjqizTPmfofvOxVUC/rCb8n6Mn+lVblHJfsODOg8KOzLc3whOH+a6dybgrQ6kPTqCie7OK3CMAJlxIJWJZnhBF9eIaB8l7QU3IU+txE2x61bID8PHyiJpOLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719804709; c=relaxed/simple;
	bh=lrZAZbSTZ0b+vU6AJg4poEZRpoyHmpuEQMqF4+9xWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNSfHOv77R3cAJxTLEP3+2jUUSQo+rxkTnjb5MP+E4nQzQ+ItH6y94MBhV1Yzidyj5oau/+J7/IiWANrBeY9FOSDXUntjMIBQbBjg7rMPTYtyagS9NZPOLGMto8FCJ0uUtET6Bj9kOFZu24GIp1GTBKn20dzjPmYt9AQTtQz3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16880 invoked by uid 109); 1 Jul 2024 03:31:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 03:31:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8403 invoked by uid 111); 1 Jul 2024 03:31:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Jun 2024 23:31:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Jun 2024 23:31:45 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org
Subject: Re: Confusing treatment of "head" in worktree on case-insensitive FS
Message-ID: <20240701033145.GB610406@coredump.intra.peff.net>
References: <A72DCB1B-8D81-4DD7-93AD-BF37E88E9D63@jvns.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A72DCB1B-8D81-4DD7-93AD-BF37E88E9D63@jvns.ca>

On Sat, Jun 29, 2024 at 10:39:29AM -0400, Julia Evans wrote:

> When I run `git rev-parse head` inside a worktree on a case insensitive filesystem,
> the result is different from `git rev-parse HEAD`.

This is a known issue in general. It can get even more confusing when
you pack refs, since we do case-sensitive matches within the packed-refs
file, and then the filesystem gives us case-insensitive matching for
loose refs.

I don't know of a good short-term solution, but the long-term one is for
us to eventually move to ref storage that doesn't rely on the filesystem
(like the recent reftables work).

With the current tip of 'master', you can do:

  git init --ref-format=reftable

I think initial support there shipped in v2.45.0, and I think things
should mostly work. But I won't be too surprised if you find a corner
case or rough edge somewhere. Bug reports welcome. ;)

> Steps to reproduce, on a case insensitive filesystem:
> 
> $ git init
> $ git commit --allow-empty -m'test'
> $ git worktree add /tmp/myworktree
> $ cd /tmp/myworktree
> $ git commit --allow-empty -m'test'
> $ git rev-parse head
> adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
> $ git rev-parse hEAd
> adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
> $ git rev-parse HEAD
> fbb28196d08d74aa61f65e5cee3cb11cc24c338a

I admit this is an unexpected case, as I'd expect both on-disk files to
be spelled "HEAD". I didn't dig into the details, though, so it's
possible there's something we could be doing differently or better. But
I do think it's mostly the tip of the iceberg for case-insensitivity
issues with refs.

-Peff
