Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867573B4E9F
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951283; cv=none; b=tUlHwkrUsGBshf/dj6rCAdb0HKTbUTO/CfnLYt8TsPojXm7zyVWqnAlWoYzj37/NlHgnN2QDyWq+iLIMvGYlot7OjCjEmdNmYOovzTJU8FZOWZG1j+TW9PwxaLVf763BcMunY5WGdjciIA6GmAd9pLF51yQ40JWoxu6rlwtM+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951283; c=relaxed/simple;
	bh=sV8Kj+jZEIrgcfgJHpEWfC5VWAVKnpjUWfRnfce76Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ8JY0/uj6NDYy5JKy6zcVVnvXwYW64oAMzItHK86J2ZYmP+g2BIhyxuJl6yDn9GvG7xC95locLDzpGSQ1spNkusam/3ruujxDIJkiIwawww3yYAlKoVhEobj7nl52RpIreOS4gxT7Jx0kzSj6TCSH4pWgay2U1oTYoG/ikDKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q+8Oi+cY; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q+8Oi+cY"
Received: (qmail 73152 invoked by uid 106); 17 Aug 2026 07:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sV8Kj+jZEIrgcfgJHpEWfC5VWAVKnpjUWfRnfce76Ls=; b=Q+8Oi+cYc41fevXjxZR8iUCxHsq9ZESfDVbQDQTm187lItLOqX+y/vllQn3lqfSbSwSgtTNKeXLlgmmAS4k5x9LhbB/C8Uzcct5vUHpJIowNkgqoDGvl8F9lVZezYiZnA/c7mSxUAAf2sEJnOd4YRzLJKbUqyJwIpvkzHxfAm4BSpnTat7b7fFjLnFCUNW/32tHfescXNMIz2Jp6ItDnJBTLPL01D1flGw7HHWBCV9CoiSSsWmz+1skCLBf4TTNHJVLm+kz0xNnBwaItbc9e51NYOH5SrxVa+XUHIAJ/8mtQoX65X6XkCJdcC9ks1xQO0qWSgUKgtFY12n5GHdSHwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2026 07:21:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14968 invoked by uid 111); 17 Aug 2026 07:21:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2026 03:21:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Aug 2026 03:21:13 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <20260817072113.GA690018@coredump.intra.peff.net>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
 <20260813161525.GB1386479@coredump.intra.peff.net>
 <an7IhgES-reCzQMr@pks.im>
 <20260814165546.GA2563235@coredump.intra.peff.net>
 <aoKZvxE8oP5B6O_4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoKZvxE8oP5B6O_4@pks.im>

On Mon, Aug 17, 2026 at 07:18:55AM +0200, Patrick Steinhardt wrote:

> > The map protects more than just adding to the list; it avoids all of
> > add_packed_git(), which allocates and does a bunch of stat() calls.  So
> > it couldn't just be a check in packfile_list_append(), but would have to
> > be a separate existence check well before that.
> > 
> > That's not impossible, but it would be a lot easier to see what
> > generalized pattern would be most useful if there were more than one
> > caller of packfile_list_append(). ;)
> 
> We only have a single caller that appends, but we have some more that
> use `packfile_list_prepend()`. And there we basically have the same
> problem.

Ah, indeed. I see prepend calls sprinkled in some rather hot code paths,
including the MRU adjustment from find_pack_entry(). That is a possible
candidate for Dscho's clone slowdown[1].

But I don't think would not want to pay the cost for a hash de-dup
there. We are not adding a new pack at all, but just adjusting the
placement, and that should be a quick O(1) if we are using a
doubly-linked list.

It's harder to construct a synthetic test for prepending because of pack
locality. If two subsequent requests both try to move pack A to the
front of the list, the second prepend()'s removal operation will find
the pack at the front in essentially constant time.

But we can spread the history across packs like this (I recommend
running on a ram disk, otherwise the checkpoint sync() makes it take
forever):

  git init
  for i in $(seq 10000); do
    echo "commit refs/heads/foo"
    echo "committer <none@example.com> $i +0000"
    echo "data <<EOF"
    echo "commit message $i"
    echo "EOF"
    echo
    echo checkpoint
  done |
  git -c fastimport.unpackLimit=0 fast-import

And then timing "git rev-list --count foo" is interesting as the number
of packs grows:

  -   500:   18ms
  -  1000:   34ms
  -  2000:  103ms
  -  4000:  374ms
  -  8000: 1648ms
  - 16000: 6351ms

You can see the quadratic growth taking over around 2000 packs. But I'm
not sure that is proving anything about list management. Lookup across
packs is linear, so this situation is inherently quadratic. I think you
could probably make an argument that the list management follows exactly
the same quadratic patterns, and thus the MRU optimizes the removal from
the prepend, too.

Still, it seems prudent for these MRU updates to use a constant-time
movement within the list, rather than an explicit duplicate check and
removal.

-Peff
