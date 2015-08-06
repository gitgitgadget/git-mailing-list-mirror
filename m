From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] test-lib: turn off "-x" tracing during chain-lint check
Date: Thu, 6 Aug 2015 01:31:47 -0400
Message-ID: <20150806053146.GA32703@sigill.intra.peff.net>
References: <20150806052940.GA32445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:32:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNDmV-0006bD-Ph
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 07:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbHFFbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 01:31:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:41428 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750715AbbHFFbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 01:31:51 -0400
Received: (qmail 21679 invoked by uid 102); 6 Aug 2015 05:31:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 00:31:51 -0500
Received: (qmail 2855 invoked by uid 107); 6 Aug 2015 05:32:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 01:32:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2015 01:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20150806052940.GA32445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275413>

Now that GIT_TEST_CHAIN_LINT is on by default, running:

    ./t0000-basic.sh -x --verbose-only=1

starts with:

    expecting success:
            find .git/objects -type f -print >should-be-empty &&
            test_line_count = 0 should-be-empty

    + exit 117
    error: last command exited with $?=117
    + find .git/objects -type f -print
    + test_line_count = 0 should-be-empty
    + test 3 != 3
    + wc -l
    + test 0 = 0
    ok 1 - .git/objects should be empty after git init in an empty repo

This is confusing, as the "exit 117" line and the error line
(which is printed in red, no less!) are not part of the test
at all, but are rather in the separate chain-lint test_eval.
Let's unset the "trace" variable when eval-ing the chain
lint check, which avoids this.

Note that we cannot just do a one-shot variable like:

    trace= test_eval ...

as the behavior of one-shot variables for function calls
is not portable.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cea6cda..374bfcb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -571,12 +571,17 @@ test_run_ () {
 	expecting_failure=$2
 
 	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
+		# turn off tracing for this test-eval, as it simply creates
+		# confusing noise in the "-x" output
+		trace_tmp=$trace
+		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
 		test_eval_ "(exit 117) && $1"
 		if test "$?" != 117; then
 			error "bug in the test script: broken &&-chain: $1"
 		fi
+		trace=$trace_tmp
 	fi
 
 	setup_malloc_check
-- 
2.5.0.148.g63828c1
