Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193912C48A
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952691; cv=none; b=H+ZRn23s6kjsdfKl8isw/wn6EbIwxrqAs59zblM/BixOp8JowJ5NN85chfZeBxvgUD0GbTVWpu8e0FVm303p/WrXtR3Hz2C2H2KydcxGT4Z7W/k4WZyf8arZK4Lr0Jb1/41J8/g+xqmgwM5uSaGBfA0RZ7m714d5llPAnjsxXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952691; c=relaxed/simple;
	bh=Of8Oljs5qLe7nq9llDe5gaFR/Fjk0eEwvZfJvjesfFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTwq9YzffD2c61tV/wmYpm1xz/kQ0xIdHwIk2OT5SUpSAGxRhoCK8O423KCy1kHL6Fng6C1mWovAwVa/G3+6c5GNeH0U5Ech5Teg6xaNl7QU2xsP5l2v2I92y7O5REhLyN5RtqVdcQ/xEYJb2f178cj6crXxZ9IJpn3ZBzC1Tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26489 invoked by uid 109); 21 Jun 2024 06:51:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Jun 2024 06:51:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6610 invoked by uid 111); 21 Jun 2024 06:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Jun 2024 02:51:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Jun 2024 02:51:27 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pager: die when paging to non-existing command
Message-ID: <20240621065127.GC2105230@coredump.intra.peff.net>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <xmqqsex7tp0c.fsf@gitster.g>
 <ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org>
 <xmqqplsbqm2l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqplsbqm2l.fsf@gitster.g>

On Thu, Jun 20, 2024 at 03:35:46PM -0700, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 20.06.24 um 21:04 schrieb Junio C Hamano:
> >> Just in case there is a reason why we should instead silently return
> >> on MinGW, I'll Cc the author of bfdd9ffd, though.
> >
> > I don't think there is a reason. IIRC, originally on Windows, failing to
> > start a pager would still let Git operate normally, just without paged
> > output. I might have regarded this as better than to fail the operation.
> 
> The "better keep going than to fail" is what Rubén finds worse, so
> both sides are quite understandable.
> 
> It is unlikely that real-world users are taking advantage of the
> fact.  If they do not want their invocation of Git command paged,
> "GIT_PAGER=cat git foo" is just as easy as "GIT_PAGER=no git foo",
> and if it was done by mistake to configure a non-working pager
> (e.g., configure core.pager to the program xyzzy and then
> uninstalling xyzzy without realizing you still have users), fixing
> it would be a one-time operation either way (you update core.pager
> or you reinstall xyzzy), so I would say that it is better to make
> the failure more stand out.

The compelling thing to me is that just about every other failure mode
of the pager will result in a SIGPIPE, so the "be nice with a
non-working pager" trick really only applies to the very narrow case of
execve() failing.

I did assume that a bogus option like:

  # oops, there is no -l option!
  GIT_PAGER='less -l' git log

would be a plausible such misconfiguration, but to my surprise "less"
prints "hey, there is no -l option" and then pages anyway. How helpful. :)

But something like:

  # oops, there is no -X option!
  GIT_PAGER='cat -X' git log

yields just:

  cat: invalid option -- 'X'
  Try 'cat --help' for more information.

with no other output. It's a little confusing if you don't realize that
"cat" is the pager. We obviously don't want to complain about SIGPIPE,
because it's common for the user to simply exit the pager without
reading all of the possible data. It might be nice if we printed some
message when the pager exits non-zero, but I'd worry there might be
false positives, depending on the behavior of various pagers.

-Peff
