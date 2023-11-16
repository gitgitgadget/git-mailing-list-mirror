Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32093196
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 12:02:47 -0800 (PST)
Received: (qmail 25932 invoked by uid 109); 16 Nov 2023 20:02:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Nov 2023 20:02:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18275 invoked by uid 111); 16 Nov 2023 20:02:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Nov 2023 15:02:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Nov 2023 15:02:42 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid running the test suite _twice_
Message-ID: <20231116200242.GA1146561@coredump.intra.peff.net>
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
 <20231113184909.GB3838361@coredump.intra.peff.net>
 <ZVU4EVcj0MDrSNcG@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVU4EVcj0MDrSNcG@google.com>

On Wed, Nov 15, 2023 at 01:28:49PM -0800, Josh Steadmon wrote:

> The first part is easy, but I don't see a good way to get both shell
> tests and unit tests executing under the same `prove` process. For shell
> tests, we pass `--exec '$(TEST_SHELL_PATH_SQ)'` to prove, meaning that
> we use the specified shell as an interpreter for the test files. That
> will not work for unit test executables.

Yes, it's unfortunate that you can't set the "exec" flag per-script
(especially because without --exec it will auto-detect the right thing,
but then of course it won't use TEST_SHELL_PATH). But we can intercept
and do it ourselves, like:

diff --git a/t/Makefile b/t/Makefile
index 225aaf78ed..0b7c028eea 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -61,7 +61,7 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove ***"; TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(CHAINLINTSUPPRESS) $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
new file mode 100755
index 0000000000..69944029c8
--- /dev/null
+++ b/t/run-test.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+case "$1" in
+*.sh)
+	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
+	;;
+*)
+	exec "$@"
+	;;
+esac

You can actually do this inside the prove script using their plugin
interface, but the necessary bits are somewhat arcane.

> We could bundle all the unit tests into a single shell script, but then
> we lose parallelization and add hoops to jump through to determine what
> breaks. Or we could autogenerate a corresponding shell script to run
> each individual unit test, but that seems gross. Of course, these are
> hypothetical concerns for now, since we only have a single unit test at
> the moment.

We can't just stick them all in a single script; there must be exactly
one "plan" line in the TAP output from a given source. I had imagined
just manually adding a thin wrapper for each ("t9970-unit-strbuf" or
something). But it would also be easy to autogenerate them while
compiling. (Although all of that is moot with the wrapper I showed
above).

> There's also the issue that the shell test arguments we pass on from
> prove would be shared with the unit tests. That's fine for now, as
> t-strbuf doesn't accept any runtime arguments, but it's possible that
> either the framework or individual unit tests might grow to need
> arguments, and it might not be convenient to stay compatible with the
> shell tests.

Sharing the options between the two seems like a benefit to me. I'd
think that "-v" and "-i" would be useful, at least. Options which don't
apply (e.g., "--root") could be quietly ignored.

-Peff
