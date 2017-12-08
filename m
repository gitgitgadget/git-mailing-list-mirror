Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA6F20C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbdLHKr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:47:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:51994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753448AbdLHKrY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 05:47:24 -0500
Received: (qmail 1790 invoked by uid 109); 8 Dec 2017 10:47:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 10:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30982 invoked by uid 111); 8 Dec 2017 10:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 05:47:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 05:47:22 -0500
Date:   Fri, 8 Dec 2017 05:47:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171208104722.GD4939@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208104647.GA4016@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index fef9c8d272..8a21c4d8f1 100644
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
@@ -729,6 +733,8 @@ endif
 export PERL_PATH
 export PYTHON_PATH
 
+TEST_SHELL_PATH = $(SHELL_PATH)
+
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
@@ -1725,6 +1731,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
@@ -2355,6 +2362,7 @@ GIT-LDFLAGS: FORCE
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
+	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >>$@+
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
index b8dd5e79ac..1ae0fc02d0 100644
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
2.15.1.659.g8bd2eae3ea
