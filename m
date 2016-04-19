From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] t5504: drop sigpipe=ok from push tests
Date: Tue, 19 Apr 2016 18:51:25 -0400
Message-ID: <20160419225125.GE18255@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:51:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseUY-000274-70
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbcDSWv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:51:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52450 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751831AbcDSWv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:51:28 -0400
Received: (qmail 27835 invoked by uid 102); 19 Apr 2016 22:51:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:51:28 -0400
Received: (qmail 20972 invoked by uid 107); 19 Apr 2016 22:51:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:51:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 18:51:25 -0400
Content-Disposition: inline
In-Reply-To: <20160419223945.GA18055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291946>

These were added by 8bf4bec (add "ok=sigpipe" to
test_must_fail and use it to fix flaky tests, 2015-11-27)
because we would racily die via SIGPIPE when the pack was
rejected by the other side.

But since we have recently de-flaked send-pack, we should be
able to tighten up these tests (including re-adding the
expected output checks).

Signed-off-by: Jeff King <peff@peff.net>
---
Would be nice to reference HEAD^2 by name here, but of
course I don't know its final commit sha1 yet.

 t/t5504-fetch-receive-strict.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index a3e12d2..44f3d5f 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -100,11 +100,8 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
-	test_must_fail ok=sigpipe git push --porcelain dst master:refs/heads/test >act &&
-	{
-		test_cmp exp act ||
-		! test -s act
-	}
+	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_cmp exp act
 '
 
 test_expect_success 'push with transfer.fsckobjects' '
@@ -114,7 +111,8 @@ test_expect_success 'push with transfer.fsckobjects' '
 		cd dst &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail ok=sigpipe git push --porcelain dst master:refs/heads/test >act
+	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_cmp exp act
 '
 
 cat >bogus-commit <<\EOF
-- 
2.8.1.512.g4e0a533
