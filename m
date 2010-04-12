From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: add some script lint checks
Date: Mon, 12 Apr 2010 02:52:34 -0400
Message-ID: <20100412065234.GA12462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 08:53:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1DW7-0003uZ-SJ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 08:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab0DLGxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 02:53:01 -0400
Received: from peff.net ([208.65.91.99]:34155 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab0DLGxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 02:53:00 -0400
Received: (qmail 15702 invoked by uid 107); 12 Apr 2010 06:53:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Apr 2010 02:53:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Apr 2010 02:52:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144708>

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
The dup half is based on Johannes' earlier patch.

Obviously this can help submitters avoid dumb mistakes, so I plan to
turn it on for myself.  As maintainer, Junio, you might want to run at
least with TEST_LINT = test-lint-duplicate, since you can then catch
duplicates introduced by merges and fix them up as part of the merge.

 t/Makefile |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 25c559b..40ae67c 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -16,7 +16,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
-all: pre-clean
+all: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
 $(T):
@@ -30,6 +30,18 @@ clean:
 	$(RM) t????/cvsroot/CVSROOT/?*
 	$(RM) -r valgrind/bin
 
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
1.7.1.rc1.245.g808fe
