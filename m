From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] t5541: move run_with_cmdline_limit to test-lib.sh
Date: Fri, 13 Mar 2015 00:53:07 -0400
Message-ID: <20150313045307.GF18532@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHb1-00030x-6D
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbCMExK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:53:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60824 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751221AbbCMExK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:53:10 -0400
Received: (qmail 30995 invoked by uid 102); 13 Mar 2015 04:53:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:53:10 -0500
Received: (qmail 9574 invoked by uid 107); 13 Mar 2015 04:53:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:53:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:53:07 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265397>

We use this to test http pushing with a restricted
commandline. Other scripts (like t5551, which does http
fetching) will want to use it, too.

Signed-off-by: Jeff King <peff@peff.net>
---
As we discussed a while ago, this is the exact same code that
run_with_limited_stack uses in t7004. However, I think they are
conceptually two different things, and I could imagine a platform where
they have distinct implementations. So I did not refactor t7004 to make
use of this.

 t/t5541-http-push-smart.sh | 6 ------
 t/test-lib.sh              | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d2c681e..1ecb588 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -324,12 +324,6 @@ test_expect_success 'push into half-auth-complete requires password' '
 	test_cmp expect actual
 '
 
-run_with_limited_cmdline () {
-	(ulimit -s 128 && "$@")
-}
-
-test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
-
 test_expect_success CMDLINE_LIMIT 'push 2000 tags over http' '
 	sha1=$(git rev-parse HEAD) &&
 	test_seq 2000 |
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7dd4b4d..9914d3e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1062,3 +1062,9 @@ test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v
 	test $? -ne 127
 '
+
+run_with_limited_cmdline () {
+	(ulimit -s 128 && "$@")
+}
+
+test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
-- 
2.3.2.472.geadab3c
