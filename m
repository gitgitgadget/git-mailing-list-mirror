Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7D85274
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911216; cv=none; b=ZS+c+p4AgKt1FJOqGDnAVXi9CKJQlnVlS3YoOYH3GQq0mn8w5btMT3BgRfSU3o2kPzTtNralEbySdz73Q8qJRu2RsmdgzT0fhtfZAmgFoUzeMKpSlAadZS9eGCqni1k+c47OIpOaDhOTxuFCMacBbPDAa01RKzpAdMSeZJvVzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911216; c=relaxed/simple;
	bh=oRuoRYAXMQ4JL8K2V1UySMqM4DSy+SInOhsUAOsikQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw3wRofdkhbPdjguW4RzwxcSOO7IPHs//y41eyZgZxHEjxK16IwmAVvpTisYXgXdIH7xoBQpXOdUdQttf8qfm9n0kP3ISd+2vVygI2aS9tnmV/eOVLMY+Hqom8fA1RJwxI0DdmifTigyN18q1WkbmlbjONjvf4TkidXJFwc7u4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7998 invoked by uid 109); 23 Apr 2024 22:26:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Apr 2024 22:26:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5319 invoked by uid 111); 23 Apr 2024 22:26:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Apr 2024 18:26:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Apr 2024 18:26:52 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] don't report vsnprintf(3) error as bug
Message-ID: <20240423222652.GD1172807@coredump.intra.peff.net>
References: <ea752a2b-9b74-4a59-a037-4782abf7161e@web.de>
 <xmqqa5lm1pr5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa5lm1pr5.fsf@gitster.g>

On Sun, Apr 21, 2024 at 12:26:22PM -0700, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > strbuf_addf() has been reporting a negative return value of vsnprintf(3)
> > as a bug since f141bd804d (Handle broken vsnprintf implementations in
> > strbuf, 2007-11-13).  Other functions copied that behavior:
> >
> > 7b03c89ebd (add xsnprintf helper function, 2015-09-24)
> > 5ef264dbdb (strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`, 2019-02-25)
> > 8d25663d70 (mem-pool: add mem_pool_strfmt(), 2024-02-25)
> >
> > However, vsnprintf(3) can legitimately return a negative value if the
> > formatted output would be longer than INT_MAX.  Stop accusing it of
> > being broken and just report the fact that formatting failed.
> 
> """ ... function returns the number of characters that would have
> been written had n been sufficiently large, not counting the
> terminating null character, or a negative value if an encoding error
> occurred. Thus, the null-terminated output has been completely
> written if and only if the returned value is nonnegative and less
> than n.""" is what I read in some versions of ISO/IEC 9899.  It is
> curious that it does not say anything about the consequence of a
> parameter error arising from int (the type snprintf family of
> functions returns) being narrower than size_t (the type of the
> parameter n), but your point still stands that vsnprintf() can
> legitimately fail, and it is not a programming error.

POSIX does say:

       The snprintf() function shall fail if:

       EOVERFLOW
              The value of n is greater than {INT_MAX}.

But mostly the INT_MAX thing is simply the one thing we've seen in
practice. I wouldn't be surprised if there are other conditions that can
trigger an error return from vsnprintf. E.g., POSIX says:

  If a conversion specification does not match one of the above forms,
  the behavior is undefined.

Of course "undefined" is much worse than returning -1, but it seems like
a reasonable thing for an implementation to choose to do (either that or
just output the character literally).

We should be immune-ish to such an issue by virtue of -Wformat (we're
only allowed to pass literal strings, and they must all be understood by
the compiler). Of course that's platform-specific and we only check
-Werror on some platforms. So gcc allows "%b", but it may be meaningless
on AIX, and who knows what their libc will do. ;)

That case kind of _is_ a BUG() situation. But I don't think it's worth
trying to differentiate that. Switching all of these to die() makes the
most sense (i.e., I like René's patch).

-Peff
