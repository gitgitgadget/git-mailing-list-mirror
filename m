Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03290202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbdJSVDE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:03:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:58276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753500AbdJSVDE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:03:04 -0400
Received: (qmail 4273 invoked by uid 109); 19 Oct 2017 21:03:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:03:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12428 invoked by uid 111); 19 Oct 2017 21:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:03:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:03:02 -0400
Date:   Thu, 19 Oct 2017 17:03:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 1/3] test-lib: silence "-x" cleanup under bash
Message-ID: <20171019210301.drphcjxx6koxtyf5@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the test suite's "-x" option is used with bash, we end
up seeing cleanup cruft in the output:

  $ bash t0001-init.sh -x
  [...]
  ++ diff -u expected actual
  + test_eval_ret_=0
  + want_trace
  + test t = t
  + test t = t
  + set +x
  ok 42 - re-init from a linked worktree

This ranges from mildly annoying (for a successful test) to
downright confusing (when we say "last command exited with
error", but it's really 5 commands back).

We normally are able to suppress this cleanup. As the
in-code comment explains, we can't convince the shell not to
print it, but we can redirect its stderr elsewhere.

But since d88785e424 (test-lib: set BASH_XTRACEFD
automatically, 2016-05-11), that doesn't hold for bash. It
sends the "set -x" output directly to descriptor 4, not to
stderr.

We can fix this by also redirecting descriptor 4, and
paying close attention to which commands redirect and
which do not (see the updated comment).

Two alternatives I considered and rejected:

  - unsetting and setting BASH_XTRACEFD; doing so closes the
    descriptor, which we must avoid

  - we could keep everything in a single block as before,
    redirect 4>/dev/null there, but retain 5>&4 as a copy.
    And then selectively restore 4>&5 for commands which
    should be allowed to trace. This would work, but the
    descriptor swapping seems unnecessarily confusing.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9b61f16f7a..3399fc3c88 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -600,26 +600,40 @@ test_eval_inner_ () {
 }
 
 test_eval_ () {
-	# We run this block with stderr redirected to avoid extra cruft
-	# during a "-x" trace. Once in "set -x" mode, we cannot prevent
+	# If "-x" tracing is in effect, then we want to avoid polluting stderr
+	# with non-test commands. But once in "set -x" mode, we cannot prevent
 	# the shell from printing the "set +x" to turn it off (nor the saving
 	# of $? before that). But we can make sure that the output goes to
 	# /dev/null.
 	#
-	# The test itself is run with stderr put back to &4 (so either to
-	# /dev/null, or to the original stderr if --verbose was used).
+	# There are a few subtleties here:
+	#
+	#   - we have to redirect descriptor 4 in addition to 2, to cover
+	#     BASH_XTRACEFD
+	#
+	#   - the actual eval has to come before the redirection block (since
+	#     it needs to see descriptor 4 to set up its stderr)
+	#
+	#   - likewise, any error message we print must be outside the block to
+	#     access descriptor 4
+	#
+	#   - checking $? has to come immediately after the eval, but it must
+	#     be _inside_ the block to avoid polluting the "set -x" output
+	#
+
+	test_eval_inner_ "$@" </dev/null >&3 2>&4
 	{
-		test_eval_inner_ "$@" </dev/null >&3 2>&4
 		test_eval_ret_=$?
 		if want_trace
 		then
 			set +x
-			if test "$test_eval_ret_" != 0
-			then
-				say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
-			fi
 		fi
-	} 2>/dev/null
+	} 2>/dev/null 4>&2
+
+	if test "$test_eval_ret_" != 0 && want_trace
+	then
+		say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
+	fi
 	return $test_eval_ret_
 }
 
-- 
2.15.0.rc1.560.g5f0609e481

