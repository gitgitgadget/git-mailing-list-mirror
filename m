Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B632B13F
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961119; cv=none; b=fG8riF81JA1AkxG4+54/JwmxqEm0l/kNJZsocLEtN5be4KuP45noEJamYdzbtTQukS/p93mNHNd5pAuX8YhLNyZaaF4eLYJqzckn3w1Kzigoj2XEp1fgXLyQVE6rCVmVQFByK6EDlqnNKRNPqdI2T39AR4liDV4DO8vG3Lz1MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961119; c=relaxed/simple;
	bh=Xr1+SW/XnnyOkwpJF/fLVzwwwa9nLe1mj2OHXOaF/6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz6Ng2k67sgvEfeLGGyRyhFt3FXWwDhT7iq3KcEA6IpN0/efbznlll2+TrHrDW1jOvKohHZ2l2cmuSGd8tEvF/fUw/5Y+3Bv68N7GONAY+pLyd+tM/x3u3/F9zt2PSWzcGKCQdSA95MTyjTHzoc8N9Y5GuX2X7qleB7F8T2Pg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TBGjkstB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TBGjkstB"
Received: (qmail 83713 invoked by uid 106); 8 Jun 2026 23:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Xr1+SW/XnnyOkwpJF/fLVzwwwa9nLe1mj2OHXOaF/6k=; b=TBGjkstByJsZ+Wy0PBBNdDGeokpC2GJy+hNzje2b525EnpW29GwZaMzZvfVrv4gn9FJiKxYG0wwdZD5h+ZXnkaCUMMI4Y6RB0g1iVoIaGu56ojiPIohE6anq8yqUDe+mo3RamV3I4psnl7sbc+no1naMBTzCZPrfxV3UnOk7RqresZW3SaUhBU5+4Gqsc45DaNZeFBtAE5/LPLvPJysZkTcQ6xGD+L6fdEYwk32WugBfAe0Qbfya1D+2idyDKUCFUlEJJjikE0AGcs3PmvrKhnhrsTPXZ7Tpg4O0QtKSVSz5FEBtb7Vq0lQzqIdFkz42TtIrC320Kj7/kNDGokGzRw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 23:25:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 244879 invoked by uid 111); 8 Jun 2026 23:25:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 19:25:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 19:25:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
Message-ID: <20260608232516.GA357822@coredump.intra.peff.net>
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
 <xmqqa4t5yyee.fsf@gitster.g>
 <20260608230315.GC340696@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608230315.GC340696@coredump.intra.peff.net>

On Mon, Jun 08, 2026 at 07:03:15PM -0400, Jeff King wrote:

> > Adding an extra early `match_pathspec()` check before making slow
> > system calls like `lstat()` makes sense, especially when most of the
> > index entries need to be skipped.  But if most of them would match,
> > then we would end up doing the same match_pathspec() calls twice for
> > each path, and run lstat() anyway, so you may also be able to
> > construct a perf test that demonstrates a case where this approach
> > is not a clear win (or even degradation), perhaps?
> 
> The patchspec matching is linear in the number of pathspecs, so it's
> easy to get quadratic-ish results by just asking about:
> 
>   git ls-files -- $(git ls-files)
> 
> So that probably provides an easy regression demonstration for this
> patch.

Ah, yeah, it is easy to demonstrate. Making a repo of size $n like this:

  n=10000
  git init
  for i in $(seq $n); do
    echo $i >file$i
  done
  git add .
  git commit -m foo

If we then run:

  time git ls-files -- $(git ls-files) >/dev/null

then n=1000 takes ~15ms for me, but n=10000 takes ~800ms. So that shows
the slowdown of the existing pathspec code as the number of pathspecs
grows.

With this patch, starting with n=10000 and adding in "-m" (which
triggers the code in this patch), like:

  time git ls-files -m -- $(git ls-files) >/dev/null

the time goes from ~15ms (without the patch) to ~800ms with it. Which
makes sense. Nothing is modified, so the current code which puts the
lstat() check first eliminates each entry before we even consider
pathspecs. So it doesn't hit the slow case at all.

But after the patch, we do a preliminary pathspec match and
pay the cost.

So it really is a question of how many items are actually modified, the
cost of lstat(), and the cost of pathspec matching (which varies with
the size of the pathspec).

But like I said, this is kind of a silly case. If it actually starts to
matter in the real world, I think it may be more productive to make the
pathspec code scale better.

-Peff
