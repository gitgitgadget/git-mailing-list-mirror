Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437821BDC8
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379206; cv=none; b=tpKiolVLpPBO5Er0I4xwpxN08ild9fegoAsQECwjGERu24Drw/i+NmqUV+T0TkOy7ETTfFsia6IkiCVXXBu1fBcbxCFjrJWVfS8Ij8i39pvdZR0m7J8sZhPsf5QJkByFV/hj9BAe05vhkJznMMUtBb9KP2+gf+tyiWNNs41I7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379206; c=relaxed/simple;
	bh=HgFkQqzYirsB/hMEyc+45P2jHpqZO+KzP0+lRJ0QWac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOLR+cp+iYk5OZ9JVIETCM52wnPGMx4VMnf6mSx66jJQzFjP4FNsRwN1SRF+Uq33KqE5QcuXG8kBrzN9rPqOgG3dCm/NAlc4HwEcPTZ9k5z+uCq7gs94uZXiDJd4rJlZ2pS1BhhRrgF7nH0iBZpw2CuKvaA6ADZA6sIzRATk0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19627 invoked by uid 109); 10 May 2024 22:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 22:13:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14080 invoked by uid 111); 10 May 2024 22:13:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 18:13:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 18:13:23 -0400
From: Jeff King <peff@peff.net>
To: ryenus <ryenus@gmail.com>
Cc: Bo Anderson <mail@boanderson.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: Error: failed to store: -25299
Message-ID: <20240510221323.GA1971112@coredump.intra.peff.net>
References: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>

On Fri, May 10, 2024 at 03:52:25PM +0800, ryenus wrote:

> Command I run: `parallel git -C {} fetch ::: repo1 repo2 rep3`, which is
> to fetch multiple repositories in parallel using GNU parallel.
> 
> This worked pretty well for me in the past, however with git version
> 2.45, maybe 2.44 as well, it would randomly emit below error:
> 
> > failed to store: -25299

There's some related discussion over in:

  https://lore.kernel.org/git/pull.1729.git.1715328467099.gitgitgadget@gmail.com/

But most curious to me is:

> But if I do this without GNU parallel, or `parallel -j1` with only
> one worker, things work just fine.
> And when I switched back to git 2.43.2, I don't see such error either.

I would have assumed this was an issue going back to 2011, since each of
those fetches is going to try storing the successful credential. But if
older-but-recent versions of Git did not have the problem, it could be
that we are being more aggressive about invoking storage for some
reason. Can you bisect?

The obvious recent changes to the credential code were brian's
capability/state series, but those are not yet in a released version
(and from a quick scan I did not see anything that would obviously
change things there).

-Peff
