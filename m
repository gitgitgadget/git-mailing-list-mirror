Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871870810
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567961; cv=none; b=o5PQJiUxAa1BK+4wyplhyZ7KLRkNvIDJOuLL+HXnKD7NGxieOVLfre4HJnKDZbYYHMkge9dEP7UTlOxQLDs47ssCNAeslNUsnewl03+NMFnT0yNhkdkb61F8UkDs0k/oVjiXEkSIMKvNrBoX+iWW/NIa+AFnny/kgr8HkTZmRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567961; c=relaxed/simple;
	bh=GPsckhy7i6Q24D1KhFm7CwGoKK3nytUZMydUUnC08aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBb4hfgbhyilUq+oZ9862kwoWEfbabkunLkMwyq96Nlw+Rg68Z0VFl+uX9uew9nPty0vgb5t3Cn2nxdzT2kqcUikkA/DUMp1g5VwBmio6ES/SEfae+CuLq2mh2SZZikC0rbsnz3mMjIcY0sJBKS0KjFTHEYrXd+4Ts7jmZbuibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CQoLn6/9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CQoLn6/9"
Received: (qmail 161861 invoked by uid 109); 22 Sep 2025 19:05:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GPsckhy7i6Q24D1KhFm7CwGoKK3nytUZMydUUnC08aw=; b=CQoLn6/9X7pXaR/Ns4MhI8We78hlQarwFQbDO0p4d/ZlyVab7fOpbjEcIsSmlTBs1xRV0AEVhGmAehZuInvtSX/fIf2Vu7ZN3Zgpd13vMwVIoyawyGzQR5Yo2+zGtePCd26ml8YFG8JCdew8MX0FuhfhmEq4rzKdvxoz/8K2lufubw0L6CVHTsVEYWu5GkgBEe2VxIgJ7b4lwRubTIJv5+a0kIZE5yrAu0Q9lir3w2t5pNcwGV/o4yZCIgNAZ4KKdIzgk49aF2Aqcn66Ofj3iuyHNr26icL1ZpnQ6lHn4n7OVTOHw+zXZJvcQJEBjJRqvrPlieCXpVwMBE9ovuJ63g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 19:05:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 258764 invoked by uid 111); 22 Sep 2025 19:05:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 15:05:56 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 15:05:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
Message-ID: <20250922190555.GA2205919@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
 <20250919224027.GA594545@coredump.intra.peff.net>
 <xmqq1pnywkwv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pnywkwv.fsf@gitster.g>

On Mon, Sep 22, 2025 at 08:45:36AM -0700, Junio C Hamano wrote:

> "git stash show" gives a "git diff --stat stash~ stash" (i.e. the
> worktree relative to then-current-HEAD in diffstat format), and "git
> stash show --" (no other arguments) gives us "git diff -p" for the
> same, it seems; this is with or without your patch.

Oof, that is certainly unexpected. Ironically I had done all of the
manual testing with "-p --", because the point of this topic was looking
at how we passed arguments to setup_revisions(). And then I simplified
it when I added the test, because it seemed that the "-p" would just be
noise there.

So it is surprising that the test passes, but you explained that clearly
below.

> We may care "--" by itself does not change the output, but it has
> already been giving different output without your patch.

I think the difference is probably a bug, but one that is out of scope
for what this patch is trying to fix. So even if we wanted to fix it,
I'd prefer not to deal with it here.

> I do not think we want to drop this test (we do want the "handles
> without leaking" part of the test), but we should not expect the
> output from these commands match.

Yeah, I had originally written just:

  test_expect_success 'stash show -- does not leak' '
	git stash show --
  '

but it felt funny, since the test is doing nothing in a build without
SANITIZE=leak. If we are OK with that funniness, I can switch back to
that.

> I only discovered this while merging this and another topic that
> happen to touch the same t3903 into 'seen'.

I'm glad you did. I would rather find out about it now while it is fresh
in my mind, then 3 years from now when we all wonder what the heck is
going on.

> * I personally find the traditional behaviour nonsense and it may be
> coming from the crappy command line parsing we have had forever, but
> I am sure people who wrote
> 
>     git stash show --
>     git stash show --end-of-options
> 
> out of "principle" in their scripts, and assumed that the patch
> output is the norm for the command even though it should have been
> giving diffstat, would be unhappy if we suddenly made them behave
> exactly like "git stash show" (nothing else on the command line).

Yeah, I agree with both points (that the current behavior is nonsense,
but people may accidentally have been relying on it). I wouldn't feel
_too_ bad about saying "you were relying on nonsense, and we have fixed
the bug" in this case. But I think it should be a separate topic (and
possibly one that makes "git stash show -- foo" do something sensible).

-Peff
