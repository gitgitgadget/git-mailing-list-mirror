From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] test-lib: disable trace when test is not verbose
Date: Thu, 6 Aug 2015 01:33:57 -0400
Message-ID: <20150806053356.GB32703@sigill.intra.peff.net>
References: <20150806052940.GA32445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:34:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNDod-0007qF-SL
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 07:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbbHFFeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 01:34:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:41432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752810AbbHFFeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 01:34:01 -0400
Received: (qmail 21819 invoked by uid 102); 6 Aug 2015 05:34:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 00:34:01 -0500
Received: (qmail 2872 invoked by uid 107); 6 Aug 2015 05:34:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 01:34:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2015 01:33:57 -0400
Content-Disposition: inline
In-Reply-To: <20150806052940.GA32445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275414>

The "-x" test-script option turns on the shell's "-x"
tracing, which can help show why a particular test is
failing. Unfortunately, this can create false negatives in
some tests if they invoke a shell function with its stderr
redirected. t5512.10 is such a test, as it does:

    test_must_fail git ls-remote refs*master >actual 2>&1 &&
    test_cmp exp actual

The "actual" file gets the "-x" trace for the test_must_fail
function, which prevents it from matching the expected
output.

There's no way to avoid this without managing the
trace flag inside each sub-function, which isn't really a
workable solution. But unless you specifically care about
t5512.10, we can work around it by enabling tracing only for
the specific tests we want.

You can already do:

    ./t5512-ls-remote.sh -x --verbose-only=16

to see the trace only for a specific test. But that doesn't
_disable_ the tracing in the other tests; it just sends it
to /dev/null. However, there's no point in generating a
trace that the user won't see, so we can simply disable
tracing whenever it doesn't have a matching verbose flag.

The normal case of just "./t5512-ls-remote.sh -x" stays the
same, as "-x" already implies "--verbose" (and
"--verbose-only" overrides "--verbose", which is why this
works at all). And for our test, we need only check
$verbose, as maybe_setup_verbose will have already
set that flag based on the $verbose_only list).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 374bfcb..16c4d7b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -531,6 +531,10 @@ maybe_setup_valgrind () {
 	fi
 }
 
+want_trace () {
+	test "$trace" = t && test "$verbose" = t
+}
+
 # This is a separate function because some tests use
 # "return" to end a test_expect_success block early
 # (and we want to make sure we run any cleanup like
@@ -538,7 +542,7 @@ maybe_setup_valgrind () {
 test_eval_inner_ () {
 	# Do not add anything extra (including LF) after '$*'
 	eval "
-		test \"$trace\" = t && set -x
+		want_trace && set -x
 		$*"
 }
 
@@ -554,7 +558,7 @@ test_eval_ () {
 	{
 		test_eval_inner_ "$@" </dev/null >&3 2>&4
 		test_eval_ret_=$?
-		if test "$trace" = t
+		if want_trace
 		then
 			set +x
 			if test "$test_eval_ret_" != 0
-- 
2.5.0.148.g63828c1
