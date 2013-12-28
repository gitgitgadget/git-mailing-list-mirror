From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t0000: set TEST_OUTPUT_DIRECTORY for sub-tests
Date: Sat, 28 Dec 2013 04:29:15 -0500
Message-ID: <20131228092915.GA21109@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 28 10:29:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqCv-0007sk-MD
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab3L1J3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:29:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:51489 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752549Ab3L1J3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:29:17 -0500
Received: (qmail 874 invoked by uid 102); 28 Dec 2013 09:29:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 03:29:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 04:29:15 -0500
Content-Disposition: inline
In-Reply-To: <20131228092731.GA26337@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239762>

Once upon a time, the test-lib library would create trash
directories in the current working directory, unless we were
explicitly told to put it elsewhere via --root. As a result,
t0000 created the sub-test trash directories inside its own
trash directory.

However, we noticed that this did not cover all cases, since
we would need to respect $TEST_OUTPUT_DIRECTORY even if
--root is not given (or is relative). Commit 38b074d fixed
this to consistently use the full path.

As a result, t0000's sub-tests are now created in git's
original test output directory rather than in our trash
directory. Furthermore, since some of the sub-tests simulate
failures, the trash directories do not get cleaned up, and
the cruft is left in the t/ directory.

We could fix this by passing a new "--root=$TRASH_DIRECTORY"
option to the sub-test. However, we do not want the sub-tests
to write anything at all to git's directory (e.g., they
should not be writing to t/test-results, either, although
this is already handled by separate code).  So the best
solution is to simply reset $TEST_OUTPUT_DIRECTORY entirely
in the sub-test, which covers this case, as well as any
future ones.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 10be52b..bc4e3e2 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -71,6 +71,8 @@ run_sub_test_lib_test () {
 		cat >>"$name.sh" &&
 		chmod +x "$name.sh" &&
 		export TEST_DIRECTORY &&
+		TEST_OUTPUT_DIRECTORY=$(pwd) &&
+		export TEST_OUTPUT_DIRECTORY &&
 		./"$name.sh" "$@" >out 2>err
 	)
 }
-- 
1.8.5.1.399.g900e7cd
