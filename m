From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] t: redirect stderr GIT_TRACE to descriptor 4
Date: Fri, 13 Mar 2015 00:50:56 -0400
Message-ID: <20150313045056.GD18532@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:51:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHZ1-00011W-4q
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbbCMEvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:51:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:60818 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751039AbbCMEu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:50:58 -0400
Received: (qmail 30855 invoked by uid 102); 13 Mar 2015 04:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:50:58 -0500
Received: (qmail 9539 invoked by uid 107); 13 Mar 2015 04:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:51:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:50:56 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265395>

If you run a test script like:

  GIT_TRACE=1 ./t0061-run-command.sh

you may get test failures, because some tests capture and
check the stderr output from git commands (and with
GIT_TRACE set to 1, the trace output will be included
there).

When we see GIT_TRACE set like this, we print a warning to
the user. However, we can do even better than that by just
pointing it to descriptor 4, which all tests leave connected
to the test script's stderr. That's likely what the user
intended (and any scripts that do want to see GIT_TRACE
output will set GIT_TRACE themselves).

Not only does this avoid false negatives in the tests, but
it means the user will actually see trace output for git
calls that redirect their stderr (whereas before, it was
sometimes confusingly buried in a file).

Signed-off-by: Jeff King <peff@peff.net>
---
I only today figured out the GIT_TRACE=4 trick. Perhaps everybody else
did long ago, and I am just slow. :)

My first inclination was to mention it in the warning message below, but
I cannot see a downside to automatically redirecting it. Even outside of
test_expect_* we have the "4>&2" redirection, so we should hit even
badly written scripts which call git outside of that environment.

 t/test-lib.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f4ba3ff..7dd4b4d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -152,10 +152,7 @@ unset UNZIP
 
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 1|2|true)
-	echo "* warning: Some tests will not work if GIT_TRACE" \
-		"is set as to trace on STDERR ! *"
-	echo "* warning: Please set GIT_TRACE to something" \
-		"other than 1, 2 or true ! *"
+	GIT_TRACE=4
 	;;
 esac
 
-- 
2.3.2.472.geadab3c
