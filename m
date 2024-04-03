Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C543D962
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176345; cv=none; b=jxuC9kvaaBZ83n1+ApQwvWqiMCOoUQfh08T6e7qkfUorXAkEZ3uHKypiVF7H6a7bqO2VQ8LBhfZz3C0uBb0XqlGAcvHAg2xhuIZAgWw6KCm3Etpq06V5ZpSiZAROrkx0nA2aPCtnSC0kdcd4OGNiYsB/JSr5LmRQqDyE4tLGxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176345; c=relaxed/simple;
	bh=vsnG0rxsPitteS8xKe+64QK+R2yuUF9D+Ut10yDvHnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd1dOhS2Wmqr67lRmAHnAfrg5uK1jstKW/9phKSGHWl8JEJ47zB8Dr4/mTwedMUxNx3q8RcsaXsy1r91+YY9RZc6CMhPZR+B1CtW/Y1Zz6N+THNtc3BpI0MirxmKYW4dIQPM8HNzG4S6kMmydUS0Y1AAmMM6T0vJHgzC/LZHQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26670 invoked by uid 109); 3 Apr 2024 20:32:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 20:32:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11564 invoked by uid 111); 3 Apr 2024 20:32:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Apr 2024 16:32:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Apr 2024 16:32:21 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: use xsnprintf to format command
Message-ID: <20240403203221.GB1949464@coredump.intra.peff.net>
References: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>
 <20240403004751.GA892394@coredump.intra.peff.net>
 <970c27ec-c377-4034-853a-0251733ec50c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <970c27ec-c377-4034-853a-0251733ec50c@web.de>

On Wed, Apr 03, 2024 at 11:25:42AM +0200, René Scharfe wrote:

> From reading the code I assumed the static buffer is there to stay
> within some IMAP limit.  RFC 9051 mentions the distinction between
> synchronizing and non-synchronizing literals.  The latter have a maximum
> length of 4096 bytes.
> 
> But those are transferred after the command, so have no relevance for
> the command buffer size.  I see no other limits, and I don't see us
> respecting that non-synchronizing literals limit, either.  I guess that
> means messages longer than 4096 bytes could be rejected by a conforming
> IMAP server?  Hmm.

It can also just be a quoted string, which likewise has no limit defined
in that section. That's what we send for LOGIN (you have to go back to
the imap_exec() command which uses a format string). It also looks like
that would barf completely on a username or password that contains a
double-quote. Yup:

  $ git format-patch -1 --stdout |
    git -c imap.user='my"user"' -c imap.pass=foo imap-send --no-curl
  [...]
  IMAP command 'LOGIN <user> <pass>' returned response (BAD) - Invalid characters in atom
  IMAP error: LOGIN failed

> > Likewise imap-send's nfvasprintf() is basically xstrfmt(), except it
> > takes a va_list. So it would have to be replaced by strbuf_vaddf().
> 
> Looking closer I notice that the result of the single nfvasprintf() call
> is fed into the 1024 bytes buffer.  So we could replace it with
> strbuf_vaddf() or xstrvfmt() and still stay within that strange limit,
> as it's enforced later.

Oh, I forgot we had xstrvfmt(). That would obviously be the right match.

> Its own 8192 buffer shields us from huge allocations e.g. due to long
> usernames or paths, but we probably don't need this protection as such
> and "attack" would originate and be felt only locally.

Yeah, I think all of the data here is user controlled. Even if you
didn't trust the patch itself, this is all username, mailbox name, etc.

> > I wouldn't be surprised if there are other opportunities for string
> > cleanup, but I generally hoped that if we waited long enough imap-send
> > would just go away. ;) Either because we could get rid of the tool
> > entirely (though from a recent-ish search, there did not seem to be a
> > lot of good other tools) or because we'd just drop the old code and rely
> > on curl to do the heavy lifting.
> 
> Oh, my build uses curl, so my earlier test run was even worth less than
> I thought.

Heh.

-Peff
