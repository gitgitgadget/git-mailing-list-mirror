Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505B19994F
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754764; cv=none; b=WMURprFR/c5pTlxLj2YNF+Epq7bB+5HX+5LWX2n4KBFditHkE63g1c7EwlnCLHfRKMYc86Aqxz19JazF1+NBU8Jfeu0yP8Z1eYFgpappJIJVBNArRnMtB3EfnOwaK8g++T5rYGvZ16dYK9Fwv/gOX4Mp2nyDFFQXcx21dhPtLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754764; c=relaxed/simple;
	bh=spCLpMnuLg9FzXPnW44+oc85p0DIh8eNMKmviAz5kCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE6V99YxrOZFAGkglvO9m52Ep0ggY6vBGvPEQHe257JvrZY4QNDkxshqliP24CeFdkPIJ9FCsnUnh9XfZB3AZrcSwZpFnaN4aExXzX2ib2TZ5dgZsSqGs9GPUEt0W3tPyU1XAdsxN5Yx6bEA+iPcO9gXmiQuUHJ23iQFgpWcEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d0Aj1eVY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d0Aj1eVY"
Received: (qmail 27720 invoked by uid 109); 4 Apr 2025 08:19:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=spCLpMnuLg9FzXPnW44+oc85p0DIh8eNMKmviAz5kCI=; b=d0Aj1eVY5UmEqMqFgRUmK62mXlpwGJJ1u67/fNoOgmxwuIrbRPeQKtT33eeosfYjYUi7dOy7BId+GAg8hWyPGcv5mbKHpHHHfmSuqBvoZ045Yi3L3e+I01eIoQ5lhMnUxhc63picUTo/ZJDFi0z2DN7nBm+4iwuQA/Q0B5brrTExC0IEOQ1xL2+xPp3nQX79omriQEMnuYjjAKzD3vRxe/L1+T8u71SI31twVBtvI1Yi+wwhBuI6HHgH1HQGvPHg+VB6Axpu96h4LfRrmJx5syExENbPSPiRU8PfH62q6Vzq2LiBLBjmCUwjygEZVo+9XVzRbY4QKmbJAjaxSKVzzA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Apr 2025 08:19:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1760 invoked by uid 111); 4 Apr 2025 08:19:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Apr 2025 04:19:11 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Apr 2025 04:19:11 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] approxidate: make "specials" respect fixed
 day-of-month
Message-ID: <20250404081911.GA762635@coredump.intra.peff.net>
References: <20250318180201.3653-1-taahol@utu.fi>
 <20250318180201.3653-2-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318180201.3653-2-taahol@utu.fi>

On Tue, Mar 18, 2025 at 08:02:00PM +0200, Tuomas Ahola wrote:

> The behaviour of noon and tea depends on the current time even when
> the date is given.  In other words, "last Friday tea" is dated to
> Thursday if the command is run before 17 pm.

Knowing what approxidate's code is like, I'm not too surprised we'd have
corner cases like this. ;)

> This can be fixed by checking whether tm->tm_mday already holds a
> determined value and tested by setting current time before 12 or 17 pm
> for noon and tea respectively.

That makes sense for "last Friday tea", but should "tea last Friday" or
"noon last Friday" work, too? I suspect it plays quite badly with
approxidate's left-to-right parsing, so it might not be worth crossing
that bridge.

> --- a/date.c
> +++ b/date.c
> @@ -1133,7 +1133,7 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
>  static void date_time(struct tm *tm, struct tm *now, int hour)
>  {
>  	if (tm->tm_hour < hour)
> -		update_tm(tm, now, 24*60*60);
> +		update_tm(tm, now, tm->tm_mday < 0 ? 24*60*60 : 0);
>  	tm->tm_hour = hour;
>  	tm->tm_min = 0;
>  	tm->tm_sec = 0;

My reading of that conditional is "if the time computed so far is before
the specified hour, then go back a day to yesterday's version of it". So
"noon" would be yesterday's noon if it is only 11am.

But if we already have a date, I'd think we would skip that logic
entirely. I.e., do we need to call update_tm() at all? Certainly in your
patch we'd pass 0, which would mean no adjustment. Do we need any other
parts of update_tm()? It looks like it fills the month, day, and year
from the "now" struct if they aren't already set, but presumably they'd
all be set together (and if they're not, then that raises even more
questions about whether just checking tm_mday is correct in your patch).

So it seems like:

  /*
   * If we do not yet have a specified day, we'll use the most recent
   * version of "hour" relative to now. But that may be yesterday.
  */
  if (tm->tm_mday < 0 && tm->tm_hour < hour)
	update_tm(tm, now, 24*60*60);

would be equivalent and is IMHO a bit easier to understand.

> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 53ced36df4..5db4b23e0b 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -180,7 +180,10 @@ check_approxidate '3:00' '2009-08-30 03:00:00'
>  check_approxidate '15:00' '2009-08-30 15:00:00'
>  check_approxidate 'noon today' '2009-08-30 12:00:00'
>  check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
> -check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
> +(
> +	GIT_TEST_DATE_NOW=$(($GIT_TEST_DATE_NOW-12*60*60)); export GIT_TEST_DATE_NOW
> +	check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
> +)
>  check_approxidate '10am noon' '2009-08-29 12:00:00'

I'm glad there's a test, but two comments. One, wouldn't we still want
to keep the existing test to make sure that we continue to do the right
thing when the "now" hour is after noon?

And two, I'm pretty sure this sub-shell will confuse the test harness,
because you're running test_expect_success inside it. So any variable
updates won't be seen by the parent shell, and I wouldn't be surprised
if attempts to exit from "-i", etc, are broken.

Hmm, yeah, running the test yields this output:

  ok 110 - parse approxidate (noon yesterday)
  ok 111 - parse approxidate (January 5th noon pm)
  ok 111 - parse approxidate (10am noon)
  ok 112 - parse approxidate (last tuesday)

because the update of the test counter is lost in the sub-shell.

I don't think there's a trivial solution. You can't do a one-shot
variable-set like:

  TEST_DATE_NOW=... check_approxidate ...

because the behavior of that construct varies between shells. So you
have to either add support for an extra parameter to check_approxidate,
or just save and restore like:

  old_date=$GIT_TEST_DATE_NOW
  GIT_TEST_DATE_NOW=$((GIT_TEST_DATE_NOW-12*60*60))
  check_approxidate ...
  GIT_TEST_DATE_NOW=$old_date

It would be nice to add a comment there, too, on what the 12-hour
parameter means and what we expect. Maybe something like:

  # The "now" date is usually at 1900 in the evening. Roll it back to
  # the morning so that it is before the hour of named times like
  # "noon" and "tea".

-Peff
