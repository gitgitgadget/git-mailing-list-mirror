Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5361CD3B
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346685; cv=none; b=uT1BAseB0DCH2W4mvVUUBZ+VUVyMZNcEfJ3OTzKPqXxU0kmvYU3jAQMtwk3gZco/Dk6Srj9inhv3k+UQ5EfiZ2xfgM6GXbGUmFdsWqdQyG3P6IC32rrmXXR1NveK1i5MZU/bBalAYhumr3Ab1Vkza0ZCf7Mi+CBHOyEsXOLcBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346685; c=relaxed/simple;
	bh=Ixvy1e/z9soNZGNeiQiime64tYsnghBvSVQnUIlW7C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUMQqrEPy/0SEeHo/p9UjNIzEV6TUC0XsUA2DtBd94gbTwGAxLosg5vWWrp6t0IsFyKEyKLvz2Q9Loaqic2lSS946KUIUlDAdLGm6U794gRW+veBmcqhKy1ta56RCn56l0VcSqdc4bL92OTEePrSht3mNvm5HvvvByDI1TsKxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11955 invoked by uid 109); 7 Feb 2024 22:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Feb 2024 22:58:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24327 invoked by uid 111); 7 Feb 2024 22:58:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Feb 2024 17:58:03 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Feb 2024 17:58:02 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Message-ID: <20240207225802.GA538110@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>

On Fri, Feb 02, 2024 at 04:50:26PM -0800, Josh Steadmon wrote:

> This has the additional benefit that test harnesses seeking to run all
> unit tests can find them with a simple glob of "t/unit-tests/bin/t-*",
> with no exceptions needed. This will be important in a later patch where
> we add support for running the unit tests via a test-tool subcommand.

Is this last paragraph still accurate? I think in this rebased version
of the series, we'll continue to use $(UNIT_TESTS) derived from the
source list rather than a glob in bin/.

> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -44,8 +44,7 @@ TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
>  CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
>  CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
>  UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
> -UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
> -UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
> +UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))

This drops the intermediate UNIT_TEST_PROGRAMS, which makes sense. It
was only used to keep the long lines a bit more readable. But it also
drops the $(sort) call. Do we need to keep it?

Certainly I'd think we want the contents of $(UNIT_TESTS) to be in a
deterministic order. Does the $(wildcard) function already return things
in sorted order? I can't find any mention in the documention. It seems
to do so for me in a simple test, but aae5239be2 (t/Makefile: Use $(sort
...) explicitly where needed, 2011-09-04) argues otherwise.

So I think we probably want to keep it (or possibly move it onto the
UNIT_TEST_SOURCES line, which keeps it close to the wildcard call).

-Peff
