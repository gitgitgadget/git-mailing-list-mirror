Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6AC76C85
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550563; cv=none; b=d3orUyyFtCWMB/gMJskIFpF37jp/4z7Apg6FoxWt1VKWT/8x06ilD44DmMzb92SQSgyQB1IuqEpj6bUKMmZw479kOQehrQurxxbaRKI0w+UdtYgM62cUrylKXbKssOuYj5hdXAzwQXcOBkCsmPbmTF+6Jso0kaDtE1T/+0aCaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550563; c=relaxed/simple;
	bh=FGwujbpNLJpbXo+1gaST8P67ddTJSxJ5JNZe5EZUlt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjCISw+Ur+ggdq9xad7xYgcyB+/0v2MLen1KNOdt1PJvMAwasKbxQa2RdPn7IFW1+xbxK/I+knvke2LjaBX51WZNA1O2dOssDwYnrAW282QlELPZyj12qP0LGC+4zLP+GlYAAYrgml7hxVt64RBzSjfY9USZsk4Y3HvC8oHpSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32689 invoked by uid 109); 29 Jan 2024 17:49:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 17:49:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23462 invoked by uid 111); 29 Jan 2024 17:49:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jan 2024 12:49:19 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jan 2024 12:49:18 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
Message-ID: <20240129174918.GA3765717@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031933.GB2433899@coredump.intra.peff.net>
 <ZbeLcrjIYd4d7PaB@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZbeLcrjIYd4d7PaB@tanuki>

On Mon, Jan 29, 2024 at 12:26:42PM +0100, Patrick Steinhardt wrote:

> > -UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
> > +UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
> > +UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%,$(UNIT_TEST_SOURCES))
> > +UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
> 
> Wouldn't we have to honor `$X` on Windows systems so that the unit tests
> have the expected ".exe" suffix here?

Hmm, good point. It seems like the answer should obviously be "yes", but
Windows CI seemed to pass all the same (and I checked that it indeed ran
the unit tests). Do we only get the $X suffix for MSVC builds or
something? Looks like maybe cygwin, as well.

I imagine the solution is just:

diff --git a/t/Makefile b/t/Makefile
index c5c6e2ef6b..9b9b30f559 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -43,7 +43,7 @@ TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
-UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%,$(UNIT_TEST_SOURCES))
+UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
 UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)

but it looks like we might need to include config.mak.uname, as well. It
would be nice to identify a build that actually needs it so I can
confirm that the fix works.

-Peff
