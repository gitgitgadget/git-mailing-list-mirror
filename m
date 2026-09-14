Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2B36C0CD
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405018; cv=none; b=rOs+UkpIpRE3skw4lHY3/RU8DexJZ5AQEGqK5Cp1bcHWe8qVXkIgJADMN33r0MiXW7WVdWT7Tbk7+ia9y5EBo6XjjLkGPG+4yj1HPmuGMtb9FtuCEK8oOO9eBPIZEtuKFNTMtzqxF8QEQ4Qz8Fp4D80PPQ184rNvr9xLGsgUEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405018; c=relaxed/simple;
	bh=B8avBlnV+p70CevCP5xCy5qQwPBFw8OkPL4WYuEtU9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9vHYkvzWS3G2AMyplgfsolaBXnhCvgiiGRK/TxD7oG+kD2kdedqH6B5MnYB4QR181tlvJ8HqsIduQcfLyMcjYcWgxxsQ9fTlUw/V6qPigdovpw9XZKjYdZAnF+BUXmOAohDblbY4zMWZ89iax8NJZAbUGPCWlsVDPAbPIPWxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UrFSiviv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UrFSiviv"
Received: (qmail 5705 invoked by uid 106); 14 Sep 2026 16:56:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B8avBlnV+p70CevCP5xCy5qQwPBFw8OkPL4WYuEtU9A=; b=UrFSivivmUFKAArjVo3R9ngjgnhv4z98dbY5tEoVfZ1FXKDtS0Im1ekuds08EGTzxs02j/80u7IDGQ+ybEZ1o2QsOeTdfHak7RFAqBEvnpLDqGXFeSGWLQSr812xVoXpevP3txZIrlw4o5gOOxayHTrTMPdw2rfSSmEwh0MsKmUU/RR4O3IJK8yAWQc6MJs8/sjaZvRCABtp6DII+nPy9JjP1JmTDGHBnIXBLVb9PjamGWEmhS3LjjeHkUJBB+LRyMrkwODK5CJ/PSuLOkl5bHv5idYvJwbJcz60vIboGL7VL0g6so2vOen7o1oTYGdkRb7rwp6TTPfjm2bq1kAJEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Sep 2026 16:56:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32414 invoked by uid 1000); 14 Sep 2026 16:56:54 -0000
Date: Mon, 14 Sep 2026 12:56:54 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, git@vger.kernel.org,
  Jean Delvare <jdelvare@suse.de>,
  Usman Akinyemi <usmanakinyemi202@gmail.com>, Taylor Blau <me@ttaylorr.com>,
  Junio C Hamano <gitster@pobox.com>,
  =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 2/3] merge-ll: catch close() errors when writing
 external tempfiles
Message-ID: <20260914165654.GB32247@peff.net>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
 <20260911171139.GB1610200@coredump.intra.peff.net>
 <CABPp-BG6wYkr4wjr-iqak9fYo4+49WvjROdZ_MK5=g27WcUmMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG6wYkr4wjr-iqak9fYo4+49WvjROdZ_MK5=g27WcUmMA@mail.gmail.com>

On Fri, Sep 11, 2026 at 11:06:43AM -0700, Elijah Newren wrote:

> > -       if (write_in_full(fd, src->ptr, src->size) < 0)
> > +       if (write_in_full(fd, src->ptr, src->size) < 0 ||
> > +           close(fd) < 0)
> >                 die_errno("unable to write temp-file");
> > -       close(fd);
> >  }
> 
> I got tripped up at first on this patch; if write_in_full() < 0, then
> we won't explicitly close(), but since die will result in an implicit
> close, that's not a problem.
> 
> Instead, the only thing that changes is we also die if close() fails.

Yeah, this is a subtle mistake that we've had to fix before. Doing:

  if (write_in_full(fd, ...) || close(fd))
	return error(...);

is a hard-to-spot leak. It's not present here because we're calling
die() instead of returning, but maybe it is worth writing it out to set
a good example, like:

  if (write_in_full(...))
	die_errno("unable to write");
  if (close(...))
	die_errno("unable to close");

Since I'm re-rolling anyway.

-Peff
