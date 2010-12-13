From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] t800?-blame.sh: retitle uniquely
Date: Mon, 13 Dec 2010 12:22:38 -0500
Message-ID: <20101213172238.GA16136@sigill.intra.peff.net>
References: <4D05F1EA.9000403@viscovery.net>
 <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net>
 <20101213170734.GA24736@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 18:22:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSC6v-0006ut-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 18:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab0LMRWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 12:22:42 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56133 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab0LMRWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 12:22:41 -0500
Received: (qmail 9141 invoked by uid 111); 13 Dec 2010 17:22:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 13 Dec 2010 17:22:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Dec 2010 12:22:38 -0500
Content-Disposition: inline
In-Reply-To: <20101213170734.GA24736@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163568>

On Mon, Dec 13, 2010 at 12:07:34PM -0500, Jeff King wrote:

> Speaking of minor test issues, we should probably also do this:
> 
> -- >8 --
> Subject: [PATCH] tests: flip executable bit on t9158

BTW, I will plug my test-lint patch once again, which caught both this
and the duplicate test number mentioned earlier.

-- >8 --
Subject: [PATCH] tests: add some script lint checks

There are some common but minor errors we tend to make in
writing test scripts:

  1. Scripts are left non-executable. This is not usually
     noticed immediately because "make test" does not need
     the bit, but it is a matter of git policy to make them
     executable (and is a slight convenience when running
     individual scripts).

  2. Two scripts are allocated the same number. Usually this
     happens on separate branches, and the problem only
     comes about during a merge. But since there is no
     textual conflict, the merger would have to be very
     observant to notice.

     This is also a minor error, but can make GIT_SKIP_TESTS
     ambiguous.

This patch introduces a "test-lint" target which checks
both. It is not invoked by default. You can invoke it as
"make test-lint", or you can make it a prerequisite of
running the tests by specifying "TEST_LINT = test-lint" in
your config.mak or on the command line.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/Makefile |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 73c6ec4..47cbeb6 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -23,10 +23,10 @@ TGITWEB = $(wildcard t95[0-9][0-9]-*.sh)
 
 all: $(DEFAULT_TEST_TARGET)
 
-test: pre-clean
+test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
-prove: pre-clean
+prove: pre-clean $(TEST_LINT)
 	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean
 
@@ -41,6 +41,18 @@ clean:
 	$(RM) -r valgrind/bin
 	$(RM) .prove
 
+test-lint: test-lint-duplicates test-lint-executable
+
+test-lint-duplicates:
+	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
+		test -z "$$dups" || { \
+		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
+
+test-lint-executable:
+	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
+		test -z "$$bad" || { \
+		echo >&2 "non-executable tests:" $$bad; exit 1; }
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
-- 
1.7.3.3.784.gccc31.dirty
