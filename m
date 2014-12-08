From: Jeff King <peff@peff.net>
Subject: [PATCH] t: support clang/gcc AddressSanitizer
Date: Mon, 8 Dec 2014 02:47:06 -0500
Message-ID: <20141208074706.GA19037@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 08:47:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxt2H-0002RH-N2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 08:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbaLHHrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 02:47:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:49825 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751007AbaLHHrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 02:47:08 -0500
Received: (qmail 1939 invoked by uid 102); 8 Dec 2014 07:47:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 01:47:08 -0600
Received: (qmail 21170 invoked by uid 107); 8 Dec 2014 07:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 02:47:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 02:47:06 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261001>

When git is compiled with "-fsanitize=address" (using clang
or gcc >= 4.8), all invocations of git will check for buffer
overflows. This is similar to running with valgrind, except
that it is more thorough (because of the compiler support,
function-local buffers can be checked, too) and runs much
faster (making it much less painful to run the whole test
suite with the checks turned on).

Unlike valgrind, the magic happens at compile-time, so we
don't need the same infrastructure in the test suite that we
did to support --valgrind. But there are two things we can
help with:

  1. On some platforms, the leak-detector is on by default,
     and causes every invocation of "git init" (and thus
     every test script) to fail. Since running git with
     the leak detector is pointless, let's shut it off
     automatically in the tests, unless the user has already
     configured it.

  2. When apache runs a CGI, it clears the environment of
     unknown variables. This means that the $ASAN_OPTIONS
     config doesn't make it to git-http-backend, and it
     dies due to the leak detector. Let's mark the variable
     as OK for apache to pass.

With these two changes, running

    make CC=clang CFLAGS=-fsanitize=address test

works out of the box.

Signed-off-by: Jeff King <peff@peff.net>
---
This is actually how I found the fsck bug I posted a few hours ago, but
I followed up with "./t5032-* --valgrind-only=32" because valgrind seems
to produce better output.

We could get fancier with $ASAN_OPTIONS, like appending "detect_leaks=0"
if it is already set. But I figured that people who are setting
$ASAN_OPTIONS already know what they are doing, and they can deal with
configuring the leak detector themselves.

We could also provide a "make sanitize-test" target, but given how
simple the make command above is, I don't see much point.

 t/lib-httpd/apache.conf | 1 +
 t/test-lib.sh           | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 7713dd2..03a4c2e 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -69,6 +69,7 @@ LockFile accept.lock
 PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
 PassEnv GNUPGHOME
+PassEnv ASAN_OPTIONS
 
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
diff --git a/t/test-lib.sh b/t/test-lib.sh
index cf19339..3177298 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -140,6 +140,9 @@ else
 	}
 fi
 
+: ${ASAN_OPTIONS=detect_leaks=0}
+export ASAN_OPTIONS
+
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
-- 
2.2.0.390.gf60752d
