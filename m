From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] t5504: handle expected output from SIGPIPE death
Date: Wed, 24 Feb 2016 02:48:36 -0500
Message-ID: <20160224074836.GD9481@sigill.intra.peff.net>
References: <20160224073603.GA9163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:48:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYUBf-0003Db-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757794AbcBXHsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:48:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:48086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757607AbcBXHsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:48:39 -0500
Received: (qmail 20834 invoked by uid 102); 24 Feb 2016 07:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:48:39 -0500
Received: (qmail 5293 invoked by uid 107); 24 Feb 2016 07:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:48:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:48:36 -0500
Content-Disposition: inline
In-Reply-To: <20160224073603.GA9163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287181>

Commit 8bf4bec (add "ok=sigpipe" to test_must_fail and use
it to fix flaky tests, 2015-11-27) taught t5504 to handle
"git push" racily exiting with SIGPIPE rather than failing.

However, one of the tests checks the output of the command,
as well. In the SIGPIPE case, we will not have produced any
output. If we want the test to be truly non-flaky, we have
to accept either output.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not sure we're really accomplishing anything with this test_cmp
anymore. We'll complain only if we get _some_ output, and it's not the
expected output. I'm not sure if that's actually useful.

It looks like 8bf4bec just dropped the test_cmp completely in one of the
cases. So an alternative here would be to do the same.

We _could_ also tighten this, to make sure the output matches the exit
code we got (right now we can get code=128 with blank output and not
complain, even though that's clearly bogus). But we'd have to abandon
test_must_fail and do things manually.

 t/t5504-fetch-receive-strict.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 89224ed..a3e12d2 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -101,7 +101,10 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config transfer.fsckobjects false
 	) &&
 	test_must_fail ok=sigpipe git push --porcelain dst master:refs/heads/test >act &&
-	test_cmp exp act
+	{
+		test_cmp exp act ||
+		! test -s act
+	}
 '
 
 test_expect_success 'push with transfer.fsckobjects' '
-- 
2.7.2.645.g4e1306c
