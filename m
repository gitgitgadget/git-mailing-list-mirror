From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] t: translate SIGINT to an exit
Date: Fri, 13 Mar 2015 00:48:48 -0400
Message-ID: <20150313044848.GC18532@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:49:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHWw-0007LO-3P
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbbCMEsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:48:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:60815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750783AbbCMEsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:48:51 -0400
Received: (qmail 30705 invoked by uid 102); 13 Mar 2015 04:48:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:48:51 -0500
Received: (qmail 9516 invoked by uid 107); 13 Mar 2015 04:49:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:49:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:48:48 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265394>

Right now if a test script receives SIGINT (e.g., because a
test was hanging and the user hit ^C), the shell exits
immediately. This can be annoying if the test script did any
global setup, like starting apache or git-daemon, as it will
not have an opportunity to clean up after itself. A
subsequent run of the test won't be able to start its own
daemon, and will either fail or skip the tests.

Instead, let's trap SIGINT to make sure we do a clean
shutdown, and just chain it to a normal exit (which will
trigger any cleanup).

Signed-off-by: Jeff King <peff@peff.net>
---
Possibly we should catch other signals here, too, but SIGINT is the one
that has been biting me over the years (I would sometimes have a stray
apache process hanging around, and I only recently figured out what
caused it).

I think "trap ... INT" is the most portable way to say this. I would
have thought numbers were more portable, but they are actually an XSI
add-on. Likewise, "SIGINT" is allowed in POSIX but not required. "INT"
is part of POSIX.

This is the cleanest way I could come up with to implement this. We
could also just include "INT" on the same line as the die, but:

  1. Then every script which sets a handler (like lib-httpd.sh) would
     need to be modified to munge the INT trap, too.

  2. It double-calls die, then. We die from the INT handler, which
     triggers the EXIT handler. I guess we could clear the handler
     inside die() if we needed to.

So I'd rather go this route, unless there turns out to be a weird
portability problem.

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c096778..f4ba3ff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -299,6 +299,7 @@ die () {
 
 GIT_EXIT_OK=
 trap 'die' EXIT
+trap 'exit $?' INT
 
 # The user-facing functions are loaded from a separate file so that
 # test_perf subshells can have them too
-- 
2.3.2.472.geadab3c
