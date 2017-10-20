Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18047202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 22:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdJTWxn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 18:53:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:59502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752334AbdJTWxm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 18:53:42 -0400
Received: (qmail 26985 invoked by uid 109); 20 Oct 2017 22:53:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 22:53:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20769 invoked by uid 111); 20 Oct 2017 22:53:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 18:53:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 18:53:40 -0400
Date:   Fri, 20 Oct 2017 18:53:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 05:01:40PM -0400, Jeff King wrote:

> I sometimes run git's test suite as part of an automated testing
> process. I was hoping to add "-x" support to get more details when a
> test fails (since failures are sometimes hard to reproduce). But I hit a
> few small snags:
> 
>   - you have to run with bash, since BASH_XTRACEFD is required to avoid
>     failures in some tests when we capture the stderr of shell functions
>     or subshells (which get polluted with the "set -x" outupt). This
>     requirement isn't a big deal for me, but it showed some other
>     issues.

Actually, this did lead me to one more fix.

I was building with SHELL_PATH=/bin/bash to make BASH_XTRACEFD work. But
that impacts not only the test scripts, but also the build itself.
I'd prefer to test something closer to my normal builds (which use
bin/sh). This patch lets me do:

  make \
    TEST_SHELL_PATH=/bin/bash \
    GIT_TEST_OPTS="--verbose-log -x" \
    test

to run the whole test suite using /bin/sh for the build, for getting the
benefits of bash's "-x" tracing.

-- >8 --
Subject: [PATCH] t/Makefile: introduce TEST_SHELL_PATH

You may want to run the test suite with a different shell
than you use to build Git. For instance, you may build with
SHELL_PATH=/bin/sh (because it's faster, or it's what you
expect to exist on systems where the build will be used) but
want to run the test suite with bash (e.g., since that
allows using "-x" reliably across the whole test suite).
There's currently no good way to do this.

You might think that doing two separate make invocations,
like:

  make &&
  make -C t SHELL_PATH=/bin/bash

would work. And it _almost_ does. The second make will see
our bash SHELL_PATH, and we'll use that to run the
individual test scripts (or tell prove to use it to do so).
So far so good.

But this breaks down when "--tee" or "--verbose-log" is
used. Those options cause the test script to actually
re-exec itself using $SHELL_PATH. But wait, wouldn't our
second make invocation have set SHELL_PATH correctly in the
environment?

Yes, but test-lib.sh sources GIT-BUILD-OPTIONS, which we
built during the first "make". And that overrides the
environment, giving us the original SHELL_PATH again.

Let's introduce a new variable that lets you specify a
specific shell to be run for the test scripts. Note that we
have to touch both the main and t/ Makefiles, since we have
to record it in GIT-BUILD-OPTIONS in one, and use it in the
latter.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile      | 8 ++++++++
 t/Makefile    | 6 ++++--
 t/test-lib.sh | 2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index cd75985991..9baa3c4b50 100644
--- a/Makefile
+++ b/Makefile
@@ -425,6 +425,10 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# Define TEST_SHELL_PATH if you want to use a shell besides SHELL_PATH for
+# running the test scripts (e.g., bash has better support for "set -x"
+# tracing).
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -727,6 +731,8 @@ endif
 export PERL_PATH
 export PYTHON_PATH
 
+TEST_SHELL_PATH = $(SHELL_PATH)
+
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
@@ -1721,6 +1727,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
@@ -2350,6 +2357,7 @@ GIT-LDFLAGS: FORCE
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
+	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >$@+
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@+
 	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@+
 	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@+
diff --git a/t/Makefile b/t/Makefile
index 1bb06c36f2..96317a35f4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,6 +8,7 @@
 
 #GIT_TEST_OPTS = --verbose --debug
 SHELL_PATH ?= $(SHELL)
+TEST_SHELL_PATH ?= $(SHELL_PATH)
 PERL_PATH ?= /usr/bin/perl
 TAR ?= $(TAR)
 RM ?= rm -f
@@ -23,6 +24,7 @@ endif
 
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 
@@ -42,11 +44,11 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean $(TEST_LINT)
-	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove ***"; $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
-	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 14fac6d6f2..e373ad1e12 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,7 +80,7 @@ done,*)
 	# from any previous runs.
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
-	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
+	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
 	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$BASE.exit")" = 0
 	exit
-- 
2.15.0.rc2.500.g047c67c30e

