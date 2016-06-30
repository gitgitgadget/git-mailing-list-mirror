Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0EBD1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcF3IQ1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:16:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:38217 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750990AbcF3IQX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:16:23 -0400
Received: (qmail 28223 invoked by uid 102); 30 Jun 2016 08:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 04:16:25 -0400
Received: (qmail 6295 invoked by uid 107); 30 Jun 2016 08:16:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 04:16:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 04:16:18 -0400
Date:	Thu, 30 Jun 2016 04:16:18 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
Message-ID: <20160630081618.GA26059@sigill.intra.peff.net>
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
 <20160629014342.GA28661@sigill.intra.peff.net>
 <57735F90.1010907@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57735F90.1010907@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 07:41:36AM +0200, Johannes Sixt wrote:

> Am 29.06.2016 um 03:43 schrieb Jeff King:
> > Another is to just put the posix/ksh schemes into the helper function,
> > and let Windows people sort it out later if they want to.
> 
> Let's do this.

OK, here's a replacement for the first patch in test-match-signal (the
others do not need touched at all). It punts on Windows entirely.

It does retain the existing check for "3" in t0005 (though I note in
04422c7 you skipped the next test entirely in MINGW, and a similar
argument could perhaps apply here).

I suspect that supporting Windows in test_match_sigpipe would require
at least:

  - checking for code 3 to cover cases where we raise (either because of
    check_pipe(), or because we are doing the pop-and-raise thing in our
    cleanup handlers)

  - checking for 128 when we want sigpipe, in case we get EPIPE and it
    caused a die().

  - figuring out what the heck happens when you "kill -15" a git process
    and mapping that

But those are all just guesses (and we'd probably want to hide them
behind "if test_have_prerequisite MINGW" to avoid making the tests less
robust elsewhere).

This patch should change nothing at all for Windows, so at least we are
not making things worse.

-- >8 --
Subject: [PATCH] tests: factor portable signal check out of t0005

In POSIX shells, a program which exits due to a signal
generally has an exit code of 128 plus the signal number.
However, ksh uses 256 plus the signal number.  We've
accounted for that in t0005, but not in other tests.  Let's
pull out the logic so we can use it elsewhere.

It would be nice for debugging if this additionally printed
errors to stderr, like our other test_* helpers. But we're
going to need to use it in other places besides the innards
of a test_expect block. So let's leave it as generic as
possible.

Note that we also leave the magic "3" for Windows out of the
generic helper. This is an artifact of the way we use
raise() to kill ourselves in test-sigchain.c, and will not
necessarily apply to all programs. So it's better to keep it
out of the helper, to reduce the chance of confusing it with
a real call to exit(3).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0005-signals.sh      | 13 +++++++------
 t/test-lib-functions.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index e7f27eb..95f8c05 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -11,12 +11,13 @@ EOF
 
 test_expect_success 'sigchain works' '
 	{ test-sigchain >actual; ret=$?; } &&
-	case "$ret" in
-	143) true ;; # POSIX w/ SIGTERM=15
-	271) true ;; # ksh w/ SIGTERM=15
-	  3) true ;; # Windows
-	  *) false ;;
-	esac &&
+	{
+		# Signal death by raise() on Windows acts like exit(3),
+		# regardless of the signal number. So we must allow that
+		# as well as the normal signal check.
+		test_match_signal 15 "$ret" ||
+		test "$ret" = 3
+	} &&
 	test_cmp expect actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 48884d5..15ef3f8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -961,3 +961,18 @@ test_env () {
 		done
 	)
 }
+
+# Returns true if the numeric exit code in "$2" represents the expected signal
+# in "$1". Signals should be given numerically.
+test_match_signal () {
+	if test "$2" = "$((128 + $1))"
+	then
+		# POSIX
+		return 0
+	elif test "$2" = "$((256 + $1))"
+	then
+		# ksh
+		return 0
+	fi
+	return 1
+}
-- 
2.9.0.317.g65b4e7c

