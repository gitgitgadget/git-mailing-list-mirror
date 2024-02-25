Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B531B949
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894848; cv=none; b=ahKjYXSTyYbEkKTrOHJJq5HIvGIHL6ClmZgiqH8c/kb8z19BTkm4D+eTg8AaMp4U90yIggM5kqguj2cLCJBT+JJ5eW5kkEzQ/4Rd6luDj+ov+qArFZB5eJ8VEaA5rHy8I9AL0Bq7p1SrWRAIjDW7wvZykjN/frcnXkDj5AJvSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894848; c=relaxed/simple;
	bh=UFoWkZAG6y1gVwueAVEMrQTBRkuTTRYQR8E+ldRY3p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqZA1JZODK3FHoV4ZY38hdbwMMnJCIXXbtDTpxHdIjOWrMgWVJGBvU+vDyfMW/JbEQuKVDkrXwTl+Kok7eJZARyp+fKSMhUXojfcxLxZnu3Q1D/HVGB3CJZ6dRhGt7xMzV+wKGiaT9Uuf0PXfzn9WcSjad4RQherUwZJQGqLqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12475 invoked by uid 109); 25 Feb 2024 21:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 25 Feb 2024 21:00:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28324 invoked by uid 111); 25 Feb 2024 21:00:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Feb 2024 16:00:41 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 25 Feb 2024 16:00:38 -0500
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] t-ctype: allow NUL anywhere in the specification
 string
Message-ID: <20240225210038.GA3368483@coredump.intra.peff.net>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-2-l.s.r@web.de>
 <CAPig+cTvs7Ckg=k1T+N3N=yT840xM2DYf3LV9NZhii8+c1nkbw@mail.gmail.com>
 <5dea0535-4b21-483a-a10a-bfa8e9e85650@web.de>
 <CAPig+cThAYjf4DU40dY9jCnjL0FsVpYFhcsj9YdvW2Q=c=ZDBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cThAYjf4DU40dY9jCnjL0FsVpYFhcsj9YdvW2Q=c=ZDBg@mail.gmail.com>

On Sun, Feb 25, 2024 at 01:41:30PM -0500, Eric Sunshine wrote:

> On Sun, Feb 25, 2024 at 1:28 PM René Scharfe <l.s.r@web.de> wrote:
> > Am 25.02.24 um 19:05 schrieb Eric Sunshine:
> > > On Sun, Feb 25, 2024 at 6:27 AM René Scharfe <l.s.r@web.de> wrote:
> > >> Getting the string size using sizeof only works in a macro and with a
> > >> string constant, but that's exactly what we have and I don't see it
> > >> changing anytime soon.
> > >>
> > >>  /* Macro to test a character type */
> > >>  #define TEST_CTYPE_FUNC(func, string) \
> > >
> > > Taking into consideration the commit message warning about string
> > > constants, would it make sense to update the comment to mention that
> > > limitation?
> > >
> > >     /* Test a character type. (Only use with string constants.) */
> > >     #define TEST_CTYPE_FUNC(func, string) \
> > >>  static void test_ctype_##func(void) { \
> > >>         for (int i = 0; i < 256; i++) { \
> > >> +               int expect = !!memchr(string, i, sizeof(string) - 1); \
> >
> > I think the temptation to pass a string pointer is low -- if only
> > because there aren't any in this file.  But adding such a warning
> > can't hurt, so yeah, why not?
> 
> The patch just posted[1] by SZEDER reminded me that, on this project,
> we assume that the compiler is smart enough to replace
> `strlen("string-literal")` with the constant `15`, so rather than
> worrying about updating comment to mention the sizeof() limitation,
> you could perhaps just use `strlen(string)` instead of
> `sizeof(string)-1`?

That would defeat the advertised purpose that we can handle embedded
NULs, though. Whereas with sizeof(), I think a literal like "foo\0bar"
would still have length 8.

-Peff
