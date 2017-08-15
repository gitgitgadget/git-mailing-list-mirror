Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4C71F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbdHOKYl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:24:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:39314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753389AbdHOKYl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:24:41 -0400
Received: (qmail 31582 invoked by uid 109); 15 Aug 2017 10:24:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 10:24:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9876 invoked by uid 111); 15 Aug 2017 10:25:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 06:25:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 06:24:39 -0400
Date:   Tue, 15 Aug 2017 06:24:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 7/8] t4205: refactor %(trailers) tests
Message-ID: <20170815102439.gillxuv56pcn3p6z@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have one test for %(trailers). In preparation
for more, let's refactor a few bits:

  - move the commit creation to its own setup step so it can
    be reused by multiple tests

  - add a trailer with whitespace continuation (to confirm
    that it is left untouched)

  - fix the sample text which claims the placeholder is %bT.
    This was switched long ago to %(trailers)

  - replace one "cat" with an "echo" when generating the
    expected output. This saves a process (and sets a better
    pattern for future tests to follow).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4205-log-pretty-formats.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 18aa1b5889..83ea85eb45 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -539,25 +539,29 @@ cat >trailers <<EOF
 Signed-off-by: A U Thor <author@example.com>
 Acked-by: A U Thor <author@example.com>
 [ v2 updated patch description ]
-Signed-off-by: A U Thor <author@example.com>
+Signed-off-by: A U Thor
+  <author@example.com>
 EOF
 
-test_expect_success 'pretty format %(trailers) shows trailers' '
+test_expect_success 'set up trailer tests' '
 	echo "Some contents" >trailerfile &&
 	git add trailerfile &&
-	git commit -F - <<-EOF &&
+	git commit -F - <<-EOF
 	trailers: this commit message has trailers
 
 	This commit is a test commit with trailers at the end. We parse this
-	message and display the trailers using %bT
+	message and display the trailers using %(trailers).
 
 	$(cat trailers)
 	EOF
-	git log --no-walk --pretty="%(trailers)" >actual &&
-	cat >expect <<-EOF &&
-	$(cat trailers)
+'
 
-	EOF
+test_expect_success 'pretty format %(trailers) shows trailers' '
+	git log --no-walk --pretty="%(trailers)" >actual &&
+	{
+		cat trailers &&
+		echo
+	} >expect &&
 	test_cmp expect actual
 '
 
-- 
2.14.1.352.ge5efb0d3f3

