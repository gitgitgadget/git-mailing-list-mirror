From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests
 with TAP
Date: Thu, 14 Oct 2010 13:23:02 -0400
Message-ID: <20101014172301.GA2770@sigill.intra.peff.net>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 19:22:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6RVq-0005PY-9L
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 19:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab0JNRWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 13:22:37 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43387 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab0JNRWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 13:22:36 -0400
Received: (qmail 9803 invoked by uid 111); 14 Oct 2010 17:22:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 17:22:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Oct 2010 13:23:02 -0400
Content-Disposition: inline
In-Reply-To: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159060>

On Thu, Oct 14, 2010 at 10:53:36AM +0200, Michael J Gruber wrote:

> +prove: pre-clean
> +	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> +	$(MAKE) clean
> +

I like the idea. I think the prove output is a little nicer for things
like -j16, but it's a pain to construct the command line (especially as
I use --root in GIT_TEST_OPTS to get a significant speedup).

I wonder if anybody is really interested in switching between the
"prove" and regular test targets, though. I would think you either like
to use prove or not. So perhaps it makes more sense to put a
configurable switch for the default target, like the patch below. Then
you can just "make test" (or "make" in the test directory) as usual.

diff --git a/t/Makefile b/t/Makefile
index c7baefb..2b4d4ac 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -11,6 +11,8 @@ SHELL_PATH ?= $(SHELL)
 PERL_PATH ?= /usr/bin/perl
 TAR ?= $(TAR)
 RM ?= rm -f
+PROVE ?= prove
+DEFAULT_TEST_TARGET ?= test
 
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -18,9 +20,15 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
-all: pre-clean
+all: $(DEFAULT_TEST_TARGET)
+
+test: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
 
+prove: pre-clean
+	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	$(MAKE) clean
+
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
