Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55F374D4
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593240; cv=none; b=YT3q7RmGVL7v4772kyHjpV4QBsAqPu8J5ATtdPGqt1gDh+GSpRlp2ajLxrthmFcvyFARL/nWeNTEzbxXppG/LlrGzjPj0YLNwLaWUjImyir9Hx9SjjppT6Rr0zTKKt2OjqhMRZo7u0EhMkIgcHVFYu2Dfcy0joU5qHZdxs61FwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593240; c=relaxed/simple;
	bh=Gt/7mSiy/bb4uRKVhFS909cgVKtsDUvlaSF/HBGFzY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoBvr9IdNR0NDcnyGnd7E5YQUbB7f9qH7GXJkskImxrvtcsP6oigoh+lgAgiw3FoHnTMkOWgSNK2dcWxwT5uCRkqzUAUON0yf8Yt4y08XM/LJWDyrylbjsDCTBwXJri3ENGrXCch6inZ2+xfehDzA5iFJv7EW2fUv0REp7RKvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8694 invoked by uid 109); 30 Jan 2024 05:40:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:40:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29151 invoked by uid 111); 30 Jan 2024 05:40:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:40:39 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:40:37 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 3/3] t/Makefile: get UNIT_TESTS list from C sources
Message-ID: <20240130054037.GC166699@coredump.intra.peff.net>
References: <20240130053714.GA165967@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130053714.GA165967@coredump.intra.peff.net>

We decide on the set of unit tests to run by asking make to expand the
wildcard "t/unit-tests/bin/*". One unfortunate outcome of this is that
we'll run anything in that directory, even if it is leftover cruft from
a previous build. This isn't _quite_ as bad as it sounds, since in
theory the unit tests executables are self-contained (so if they passed
before, they'll pass even though they now have nothing to do with the
checked out version of Git). But at the very least it's wasteful, and if
they _do_ fail it can be quite confusing to understand why they are
being run at all.

This wildcarding presumably came from our handling of the regular
shell-script tests, which use $(wildcard t[0-9][0-9][0-9][0-9]-*.sh).
But the difference there is that those are actual tracked files. So if
you checkout a different commit, they'll go away. Whereas the contents
of unit-tests/bin are ignored (so not only do they stick around, but you
are not even warned of the stale files via "git status").

This patch fixes the situation by looking for the actual unit-test
source files and then massaging those names into the final executable
names. This has two additional benefits:

  1. It will notice if we failed to build one or more unit-tests for
     some reason (wheras the current code just runs whatever made it to
     the bin/ directory).

  2. The wildcard should avoid other build cruft, like the pdb files we
     worked around in 0df903d402 (unit-tests: do not mistake `.pdb`
     files for being executable, 2023-09-25).

Our new wildcard does make an assumption that unit tests are built from
C sources. It would be a bit cleaner if we consulted UNIT_TEST_PROGRAMS
from the top-level Makefile. But doing so is tricky unless we reorganize
that Makefile to split the source file lists into include-able subfiles.
That might be worth doing in general, but in the meantime, the
assumptions made by the wildcard here seems reasonable.

Note that we do need to include config.mak.uname either way, though, as
we need the value of $(X) to compute the correct executable names (which
would be true even if we had acess to the top-level's UNIT_TEST_PROGRAMS
variable).

Signed-off-by: Jeff King <peff@peff.net>
---
This is actually pretty easy to test on Linux if you just set "X"
yourself.  I confirmed that it is needed for "make X=.exe unit-tests" to
work, and that fudging an "X = .exe" line into config.mak.uname, as
would happen on real platforms works with the extra include.

 t/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index b7a6fefe28..281f4c3534 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -6,6 +6,7 @@ include ../shared.mak
 # Copyright (c) 2005 Junio C Hamano
 #
 
+-include ../config.mak.uname
 -include ../config.mak.autogen
 -include ../config.mak
 
@@ -42,7 +43,9 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
+UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
+UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
+UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
-- 
2.43.0.797.g29b680fc68
