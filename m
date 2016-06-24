Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAAA72018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbcFXToC (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:44:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:59940 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcFXToA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:44:00 -0400
Received: (qmail 31296 invoked by uid 102); 24 Jun 2016 19:44:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:44:00 -0400
Received: (qmail 22043 invoked by uid 107); 24 Jun 2016 19:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:44:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:43:58 -0400
Date:	Fri, 24 Jun 2016 15:43:58 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 1/4] tests: factor portable signal check out of t0005
Message-ID: <20160624194357.GA6441@sigill.intra.peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160624193924.GA6282@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In POSIX shells, a program which exits due to a signal
generally has an exit code of 128 plus the signal number.
However, some platforms do other things. ksh uses 256 plus
the signal number, and on Windows, all signals are just "3".

We've accounted for that in t0005, but not in other tests.
Let's pull out the logic so we can use it elsewhere.

It would be nice for debugging if this additionally printed
errors to stderr, like our other test_* helpers. But we're
going to need to use it in other places besides the innards
of a test_expect block. So let's leave it as generic as
possible.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't get into the weirdness of SIGPIPE on Windows here, but I think
this is probably a first step toward handling it better. E.g., it may be
that test_match_signal should respect 128 (or even any code) when we are
checking for SIGPIPE.

I also didn't bother with symbolic names. We could make:

  test_match_signal sigterm $?

work, but I didn't think it was worth the effort. While numbers for some
obscure signals do vary on platforms, sigpipe and sigterm are standard
enough to rely on.

 t/t0005-signals.sh      |  7 +------
 t/test-lib-functions.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index e7f27eb..2d96265 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -11,12 +11,7 @@ EOF
 
 test_expect_success 'sigchain works' '
 	{ test-sigchain >actual; ret=$?; } &&
-	case "$ret" in
-	143) true ;; # POSIX w/ SIGTERM=15
-	271) true ;; # ksh w/ SIGTERM=15
-	  3) true ;; # Windows
-	  *) false ;;
-	esac &&
+	test_match_signal 15 "$ret" &&
 	test_cmp expect actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 48884d5..51d3775 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -961,3 +961,21 @@ test_env () {
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
+	elif test "$2" = "3"; then
+		# Windows
+		return 0
+	fi
+	return 1
+}
-- 
2.9.0.215.gc5c4261

