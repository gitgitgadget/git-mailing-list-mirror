Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205D149DFD
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345834; cv=none; b=ESVEG5liigdk3XPZto4ehTcfOisvmUa+0g75o1q3qIX/nCTMUVH/4HVcfeT8HX+EF+x050MZbbEo0CUMIZSTU3wANJjs2UooMx3lR4D+Lvp91S+LefTFhfWBr+QbORaKsaKsqLlSoN42mIkNhbgXGIY43EmbqUU97V8aYBnkUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345834; c=relaxed/simple;
	bh=y93BkbgeJ6KPZbxdOhogXe/WOMb1XmikuMJRu64OgjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW7QEvwUtPSSB1POsPA/SqgqsIGeYhCkWtkHzTGrMzXAW016blJmX1e/1k4vIpHuwHZBKkgZD2w3Kyno3ZjWn/93rmwFKqk7QIK6wGfADRsSCoxJOb9L0jqJXX9FEI35czVLJNtKz8TItOPwTBdDcJoDSfCJJTDonK/jEffoGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11797 invoked by uid 109); 7 Feb 2024 22:43:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Feb 2024 22:43:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24200 invoked by uid 111); 7 Feb 2024 22:43:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Feb 2024 17:43:51 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Feb 2024 17:43:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 6/6] t/Makefile: run unit tests alongside shell
 tests
Message-ID: <20240207224350.GA537799@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <cd7467a7bd51fbc01c999ee1bd7688770b1d11e5.1706921262.git.steadmon@google.com>
 <xmqqzfwc6lle.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfwc6lle.fsf@gitster.g>

On Wed, Feb 07, 2024 at 12:55:09PM -0800, Junio C Hamano wrote:

> > +# A simple wrapper to run shell tests via TEST_SHELL_PATH,
> > +# or exec unit tests directly.
> > +
> > +case "$1" in
> > +*.sh)
> > +	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
> > +	;;
> > +*)
> > +	exec "$@"
> > +	;;
> > +esac
> 
> Hmph.  This penalizes the non-unit tests by doing an extra "exec",
> once per program?

It does, but IMHO that is not likely to be a problem. It's once per
top-level script (so ~1000), and each of those scripts spawns hundreds
or thousands of sub-commands. I didn't do any measurements, though.

You can extend "prove" with extra perl modules so that it makes the
distinction internally without the extra shell invocation. But when I
tried to do it, I found it rather baroque and complicated (I can't
remember if I succeeded but found it too gross, or just gave up halfway
through trying).

> Of course we cannot run two $(PROVE) invocations serially, one for
> doing $(T) and the other for doing $(UNIT_TESTS)?

Not if they share the same command-line options. If you use something
like "--state=slow,save", then the first run will write the list of all
tests to ".prove", and then the second will run every test mentioned in
.prove (in addition to the unit-tests provided on the command-line).

You should be able to work around it by passing "--statefile". I _think_
it might be OK to just do that unconditionally. Something like:

  prove --exec $(TEST_SHELL_PATH $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
  prove --statefile=.prove-unit-tests $(GIT_PROVE_OPTS) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)

and then it's just a noop if GIT_PROVE_OPTS doesn't use --state. But I
haven't played with it myself.

-Peff
