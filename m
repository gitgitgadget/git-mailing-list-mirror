From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] t5551: make EXPENSIVE test cheaper
Date: Fri, 13 Mar 2015 00:57:05 -0400
Message-ID: <20150313045705.GA18807@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:57:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHer-0006mH-3Y
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbbCME5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:57:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:60827 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750973AbbCME5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:57:07 -0400
Received: (qmail 31163 invoked by uid 102); 13 Mar 2015 04:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:57:07 -0500
Received: (qmail 9604 invoked by uid 107); 13 Mar 2015 04:57:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:57:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:57:05 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265398>

We create 50,000 tags to check that we don't overflow the
command-line of fetch-pack. But by using run_with_cmdline_limit,
we can get the same effect with a much smaller number of
tags. This makes the test fast enough that we can drop the
EXPENSIVE prereq, which means people will actually run it.

It was not documented to do so, but this test was also the
only test of a clone-over-http that requires multiple POSTs
during the conversation. We can continue to test that by
dropping http.postbuffer to its minimum size, and checking
that we get two POSTs.

Signed-off-by: Jeff King <peff@peff.net>
---
This is still a slightly expensive test, but it's on par with what the
push test does, so hopefully it's OK. And it bothers me that we didn't
exercise the multiple-POST code at all in the test suite, as I assume
basically nobody runs the tests with "--long".

I don't think we can shrink it any more. We enforce a hard minimum of
LARGE_PACKET_MAX on http.postbuffer, and that assumption runs through
the code. Lots of things break if you try to circumvent it, and I didn't
bother digging further.

 t/t5551-http-fetch-smart.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index b970773..df47851 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -224,10 +224,10 @@ test_expect_success 'transfer.hiderefs works over smart-http' '
 	git -C hidden.git rev-parse --verify b
 '
 
-test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
+test_expect_success 'create 2,000 tags in the repo' '
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	for i in `test_seq 50000`
+	for i in $(test_seq 2000)
 	do
 		echo "commit refs/heads/too-many-refs"
 		echo "mark :$i"
@@ -248,13 +248,22 @@ test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	)
 '
 
-test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command line overflow' '
-	git clone $HTTPD_URL/smart/repo.git too-many-refs &&
+test_expect_success CMDLINE_LIMIT \
+	'clone the 2,000 tag repo to check OS command line overflow' '
+	run_with_limited_cmdline git clone $HTTPD_URL/smart/repo.git too-many-refs &&
 	(
 		cd too-many-refs &&
-		test $(git for-each-ref refs/tags | wc -l) = 50000
+		git for-each-ref refs/tags >actual &&
+		test_line_count = 2000 actual
 	)
 '
 
+test_expect_success 'large fetch-pack requests can be split across POSTs' '
+	GIT_CURL_VERBOSE=1 git -c http.postbuffer=65536 \
+		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
+	grep "^> POST" err >posts &&
+	test_line_count = 2 posts
+'
+
 stop_httpd
 test_done
-- 
2.3.2.472.geadab3c
