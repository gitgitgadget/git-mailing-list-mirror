Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83855E4C
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524725; cv=none; b=WSof9w0hxvWj8zunL1boDenkkvfD4IP+4Yyo5PYeu2HnfQs5sA4wi9XoZlMyJOIVqIKRpOywzUdP7hbQsD59oMU4ht+osPct1kEYyT+JaaVYnlLOH6zomDhFANGXQIdC4yuipdqPmiYILJ6Mlz337ZiDdaTwG0KnapSxqwN6N3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524725; c=relaxed/simple;
	bh=TqLHxihZIBdo7ILUzezqLcnv714VxysMQOuGRra1i4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmWUDpQPt5nJKbxJaWd3qZ7hmF+541u5AEIQwWq3tilyFE/c54lQ8qzIg7wbBSj5meQscIzoyRYVgziSFvEsKyz3dqVzWNccaOafuDlpzSfpUIMPeQL2Tze5QLpUgzV+szqnjKqdYp1paiNlfzbCgGAbybGqwLk7lEnEtFFCbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25591 invoked by uid 109); 9 Jul 2024 11:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jul 2024 11:32:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32684 invoked by uid 111); 9 Jul 2024 11:32:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 07:32:01 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 07:32:01 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t-strvec: use test_msg()
Message-ID: <20240709113201.GA994226@coredump.intra.peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>

On Fri, Jul 05, 2024 at 07:03:36PM +0200, René Scharfe wrote:

> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
> index d4615ab06d..236203af61 100644
> --- a/t/unit-tests/t-strvec.c
> +++ b/t/unit-tests/t-strvec.c
> @@ -17,12 +17,12 @@ static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
>  			break;
> 
>  		if (!check_uint(vec->nr, >, nr) ||
> -		    !check_uint(vec->alloc, >, nr) ||
> -		    !check_str(vec->v[nr], str)) {
> -			struct strbuf msg = STRBUF_INIT;
> -			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
> -			test_assert(loc, msg.buf, 0);
> -			strbuf_release(&msg);
> +		    !check_uint(vec->alloc, >, nr)) {
> +			va_end(ap);
> +			return;
> +		}
> +		if (!check_str(vec->v[nr], str)) {
> +			test_msg("     nr: %"PRIuMAX, (uintmax_t)nr);
>  			va_end(ap);
>  			return;
>  		}

The "loc" parameter to the function is now unused. Should it be removed,
or is it a bug that we are no longer reporting the caller's location?
Should we be using check_str_loc() in the post-image?

-Peff
