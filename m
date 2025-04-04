Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAB190462
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756052; cv=none; b=UWJm5+Ka85F0lYZw28qK80eIkIjaeRlP1CJ1i9fAzMM65s647s6BpEoyFize8Tt1pKVwxhivcS6dtq6NrGIneje4wOxkaWkYXdh2blHgzpr4VCBIPbERZ7VumQh0/dO35x++m1jYimO7JuFiNKLUcpwvi9JFWNlbhgWSM39xyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756052; c=relaxed/simple;
	bh=oxsIcrpmYt0aovVeHfRi+bqVYDY7NaOw6oHD9YzXHYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oApxg4ppsUFZHEwCkJAlXb5+qza4rYlQzVyPgdn6Rza1WnjxDjp6byi8UxIeGtDGrcIOdkU0piDxzdH3wDP3MtY2iDMMH4ysvNsseITxvN+20WY4As+nh3D604t5NddpHSAeXk/RveS+gFSTZm4zRud7COiQt2NY0lDXKZaMeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LwDHjEfm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LwDHjEfm"
Received: (qmail 27851 invoked by uid 109); 4 Apr 2025 08:40:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oxsIcrpmYt0aovVeHfRi+bqVYDY7NaOw6oHD9YzXHYI=; b=LwDHjEfmG2g12ZlFzPT7VZXJHMtuYeCGkfpu4F9iEN63kHfGbwb4ftiKkSCjRGp8vM3A/nFrvOfLmmwBdEefyhlvD9js9MnjDSy3AOm8odkR6whjehoLiEOqCdZjXNsoSwDCdQnjsVxnkeklHNmAAtfeX7H2FmITBRJr+Zm/NB0wzWAbpwSzum0bh1TMuAin5wqk3WjSVndqD8V9zGxBqqYzS0tzSY0bu1BrivRr1pJKzHt2lIdqFifPIhbpVLc9igofQPOEdRohsr5PSWgCYPdUkroypPEZVH7Yo6dCtMh3dRNIg0/Hbjeare2dPPIfkJYnhPZvafrUb1MT7n3gTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Apr 2025 08:40:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2007 invoked by uid 111); 4 Apr 2025 08:40:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Apr 2025 04:40:48 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Apr 2025 04:40:48 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] approxidate: overwrite tm_mday for `now` and
 `yesterday`
Message-ID: <20250404084048.GB762635@coredump.intra.peff.net>
References: <20250318180201.3653-1-taahol@utu.fi>
 <20250318180201.3653-3-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318180201.3653-3-taahol@utu.fi>

On Tue, Mar 18, 2025 at 08:02:01PM +0200, Tuomas Ahola wrote:

> Date specifications now (or today) and yesterday should refer to
> actual current or previous day.  Especially "noon today" or "noon
> yesterday" should override the usual logic of using the first previous
> noon depending on the current time.

OK. So if I understand the issue correctly, it is that saying "noon"
sets the day field of the "struct tm", and then "today" or "yesterday"
won't override that, because update_tm() tries not to touch those fields
if they're already set.

This presumably works for "10am yesterday" because "10am" just sets the
time, and never the date (though I didn't check).

> diff --git a/date.c b/date.c
> index 482a2f8c99..2a8a942d64 100644
> --- a/date.c
> +++ b/date.c
> @@ -1121,12 +1121,14 @@ static void pending_number(struct tm *tm, int *num)
>  static void date_now(struct tm *tm, struct tm *now, int *num)
>  {
>  	*num = 0;
> +	tm->tm_mday = -1;
>  	update_tm(tm, now, 0);
>  }

So OK, this approach makes sense: throw out the old date we computed so
that update_tm() can use today's.

But is resetting tm_mday enough? If we previously set tm_mon, then
update_tm() won't override that, but it would need to follow along with
tm_mday, wouldn't it?

So if it is the morning of April 2nd, that will work fine, since
yesterday and today have the same month. And it seems to (this is with
your patch):

  $ GIT_TEST_DATE_NOW=$(date --date='2025-04-02 11:00' +%s) \
    t/helper/test-tool date approxidate 'noon today'
  noon today -> 2025-04-02 16:00:00 +0000

but if we try the same thing on the 1st:

  $ GIT_TEST_DATE_NOW=$(date --date='2025-04-01 11:00' +%s) \
    t/helper/test-tool date approxidate 'noon today'
  noon today -> 2025-03-01 16:00:00 +0000

Oops, we went back a month. And presumably the same thing would happen
with the year on Jan 1st.

Interestingly, since we are passing "0" to update_tm() as its
adjustment, I think this might be easier to read as just:

  tm->tm_mday = now->tm_mday;
  tm->tm_mon = now->tm_mon;
  tm->tm_year = now->tm_year;

But it's possible that the round-trip through mktime() and localtime_r()
in update_tm() has some value (I wonder what would happen at 2:30am on a
day when DST springs forward from 2am to 3am).

>  static void date_yesterday(struct tm *tm, struct tm *now, int *num)
>  {
>  	*num = 0;
> +	tm->tm_mday = -1;
>  	update_tm(tm, now, 24*60*60);
>  }

OK, same here, except obviously we _do_ need to call update_tm() for its
adjustment.

> @@ -1204,6 +1206,7 @@ static const struct special {
>  	{ "AM", date_am },
>  	{ "never", date_never },
>  	{ "now", date_now },
> +	{ "today", date_now },
>  	{ NULL }
>  };

So before we did not understand "today" at all, but just ignored it.
Which worked because we try to make everything relative to "now" by
default anyway. Adding it as you do here makes sense, since now we are
using its ability to "override" the date set by things like "noon".

It is a little weird that "now" and "today" share the same
implementation. So notably, "noon now" does not override the time
(ignoring "noon" completely). But that is already the case before your
patch (and I think is just one of those approxidate "if it hurts, don't
do it" quirks).

> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -178,10 +178,10 @@ check_approxidate '6am yesterday' '2009-08-29 06:00:00'
>  check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
>  check_approxidate '3:00' '2009-08-30 03:00:00'
>  check_approxidate '15:00' '2009-08-30 15:00:00'
> -check_approxidate 'noon today' '2009-08-30 12:00:00'
> -check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
>  (
>  	GIT_TEST_DATE_NOW=$(($GIT_TEST_DATE_NOW-12*60*60)); export GIT_TEST_DATE_NOW
> +	check_approxidate 'noon today' '2009-08-30 12:00:00'
> +	check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
>  	check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
>  )

Same comments on the tests as in patch 1. I think we'd want to add,
rather than replace, and put these in the same save/restore block rather
than using a subshell.

-Peff
