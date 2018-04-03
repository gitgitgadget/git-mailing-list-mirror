Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C1A1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 14:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeDCOCA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 10:02:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:51862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750748AbeDCOB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 10:01:59 -0400
Received: (qmail 32491 invoked by uid 109); 3 Apr 2018 14:02:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 14:02:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25642 invoked by uid 111); 3 Apr 2018 14:02:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 10:02:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 10:01:57 -0400
Date:   Tue, 3 Apr 2018 10:01:57 -0400
From:   Jeff King <peff@peff.net>
To:     Jens =?utf-8?Q?Kr=C3=BCger?= <Jens.Krueger@frm2.tum.de>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 2/2] t5561: skip tests if curl is not available
Message-ID: <20180403140157.GB30376@sigill.intra.peff.net>
References: <20180403140055.GA29556@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180403140055.GA29556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible to have libcurl installed but not the curl
command-line utility. The latter is not generally needed for
Git's http support, but we use it in t5561 for basic tests
of http-backend's functionality. Let's detect when it's
missing and skip this test.

Note that we can't mark the individual tests with the CURL
prerequisite. They're in a shared t556x_common that uses the
GET and POST functions as a level of indirection, and it's
only our implementations of those functions in t5561 that
requires curl. It's not a problem, though, as literally
every test in the script would depend on the prerequisite
anyway.

Reported-by: Jens Krüger <Jens.Krueger@frm2.tum.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5561-http-backend.sh | 6 ++++++
 t/test-lib.sh           | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 6167563986..84a955770a 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -3,6 +3,12 @@
 test_description='test git-http-backend'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
+
+if ! test_have_prereq CURL; then
+	skip_all='skipping raw http-backend tests, curl not available'
+	test_done
+fi
+
 start_httpd
 
 GET() {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7740d511d2..1aa39fe889 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1208,3 +1208,7 @@ test_lazy_prereq LONG_IS_64BIT '
 
 test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
 test_lazy_prereq TIME_T_IS_64BIT 'test-date time_t-is64bit'
+
+test_lazy_prereq CURL '
+	curl --version
+'
-- 
2.17.0.686.g08b0810b04
