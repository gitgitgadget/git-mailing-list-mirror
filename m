Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660A101CF
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498377; cv=none; b=LKofpxIPUIE5QWYuNGLy97BteFplpdjNj+kDQnGJIGEokCZpCLCfzFdyhyO0bgIyQrQOThh+J5/qgcZUtwzae9YEWBUkAqFZV6pVJPFF41OKlEhCrok0FPN3tNiAL9o1ndK/EJrprPQh7PmqmIM/SO6n2Tf0wr6KAkqIEAxeeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498377; c=relaxed/simple;
	bh=A7UmsnUaqFEc1QcZm4Ro9LwJ1LsqedM8NSGF3gDGD5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJAt46qGA9P0oFloTT5ebW7iSbmXYMVO5VJ8XxGIalCXLalrNlXTeQKWRSmObjxXdGnKNpxdnYiv1PvHbvUzEGbgs4/gV0jhLdxt/7Cxk+2OPdNHOdXwBku/iygTltXZco5eY/Sva6HCJj4NnDmf28yTYqo7JJPhIxJNycPr7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27639 invoked by uid 109); 29 Jan 2024 03:19:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 03:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18059 invoked by uid 111); 29 Jan 2024 03:19:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jan 2024 22:19:36 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jan 2024 22:19:33 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
Message-ID: <20240129031933.GB2433899@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129031540.GA2433764@coredump.intra.peff.net>

We decide on the set of unit tests to run by asking make to expand the
wildcard "t/unit-tests/bin/*". One unfortunate outcome of this is that
we'll run anything in that directory, even if it is leftover cruft from
a previous build. This isn't _quite_ as bad as it sounds, since in
theory the unit test executables are self-contained (so if they passed
before, they'll pass even though they now have nothing to do with the
checked out version of Git). But at the very least it's wasteful, and if
they _do_ fail it can be quite confusing to understand why they are
being run at all.

This wildcarding presumably came from our handling of the regular
shell-script tests, which match "t[0-9][0-9][0-9][0-9]-*.sh".  But the
difference there is that those are actual tracked files. So if you
checkout a different commit, they'll go away. Whereas the contents of
unit-tests/bin are ignored (so not only do they stick around, but you
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

Our new wildcard does make an assumption that unit tests are build from
C sources. It would be a bit cleaner if we consulted UNIT_TEST_PROGRAMS
from the top-level Makefile. But doing so is tricky unless we reorganize
that Makefile to split the source file lists into include-able subfiles.
That might be worth doing in general, but in the meantime, the
assumptions made by the wildcard here seems reasonable.

Signed-off-by: Jeff King <peff@peff.net>
---
I of course hit this when moving between "next" and "master" for an
up-and-coming unit-test file which sometimes failed.

 t/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index b7a6fefe28..c5c6e2ef6b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -42,7 +42,9 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
+UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
+UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%,$(UNIT_TEST_SOURCES))
+UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
-- 
2.43.0.797.g29b680fc68
