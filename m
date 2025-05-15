Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946F4B1E44
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339479; cv=none; b=sAG3zNwd6F86oq0nXJs8KGjzAYt2arfHbcfZ7pByBHdKENkeAsJFtuwutsFFFsYoO26vAsUnVTyzJD59tg8tICniyYNNAtv0MUBQ6Xxhc/GNBPIEoUzXPNHWxJYLfRtDjjnP/Cl/KoktXaOb5FZ8F4uql+4CESUHZzOJ6vkWCqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339479; c=relaxed/simple;
	bh=z+hiHl5OzrQZJheeYe9p/YWVIAgS8k85zpz5gdX+nl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNZlqeZFRyFNyAaIi30lYCzRf/ty4uIntEGrtcM6x14UiD+dJAD5Cr2powOk1LRYNx34+r5Up9o+bcSgTKnGltdQIcsLFLOjt495B08/mXHtuAA9QCn+fe+ZAWo5A82Sn8Xm8WOnZdfjigwO5Pe7XeSKvgJsDkzCy9rIlKtrS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U2ZuErx0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U2ZuErx0"
Received: (qmail 691 invoked by uid 109); 15 May 2025 20:04:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=z+hiHl5OzrQZJheeYe9p/YWVIAgS8k85zpz5gdX+nl8=; b=U2ZuErx0O/XyVZ63x7Ob1zOU5uLDABHm+XaihGuy+uRuTgze9pMQTYqTr4k1b510IaA6cyGt3yYy8MW3iAlRDwiMGzc+yk1MuxrjX67B1/dbgDAuev9WATuj1LRYXGsYtidDM24ZUYWGRDX3CNpwOf5mx81zHgDAGuyoAmmKgdovRkoAMhVN/mlDydL9nzRQPXZyRB9Bm+sWtYwUHXa9lzKuMx9LNaZqFF8fDr4xa7IhxoI/1/NZtiLIaZ7SOxHtaHT+jYFYIiW2Z/1C4fxgWF551pKQrYWaOX4UBSidyPI+L9k9Q5JqdeXi1ZybD1PVWgmPm8VaUj524OH7O8ci1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:04:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30582 invoked by uid 111); 15 May 2025 20:04:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:04:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:04:35 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/11] has_dir_name(): make code more obvious
Message-ID: <20250515200435.GF3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <80422a5770ded04993c73c657b363ddad45e2f4a.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80422a5770ded04993c73c657b363ddad45e2f4a.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:43PM +0000, Johannes Schindelin via GitGitGadget wrote:

> One thing that might be non-obvious to readers (or to analyzers like
> CodeQL) is that the function essentially does nothing when the Git index
> is empty, and in particular that it does not look at the value of
> `len_eq_last` (which would be uninitialized at that point).
> 
> Let's make this much easier to understand, by returning early if the Git
> index is empty, and by avoiding empty `else` blocks.

OK, so we return early, skipping not only what's in the conditional
that you're touching here, but also the "for(;;)" loop below.

And in that one, we'll look for the next slash (and break if none).
We'll check the name up to that stage via index_name_stage_pos(). And
obviously that will not find a match if there are no index entries. So
we'd do nothing and loop again, looking for the next slash, until we
eventually hit the end.

So yeah, I agree if there are no index entries we can bail immediately.

> This commit changes indentation and is hence best viewed using
> `--ignore-space-change`.

Yeah. I was puzzled at first by the amount of dropped code, but they are
all comments that say "fall through to the code below".

So I think the change here is correct. We are losing some comments that
could be helpful, but I'm not familiar enough with those code to say
whether they would be. Just reading what you've left makes sense to me
on its own.

-Peff
