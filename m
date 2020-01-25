Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5682BC2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320C62073B
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgAYAG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:06:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:44242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729367AbgAYAG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:06:26 -0500
Received: (qmail 9172 invoked by uid 109); 25 Jan 2020 00:06:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 00:06:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12314 invoked by uid 111); 25 Jan 2020 00:13:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 19:13:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 19:06:24 -0500
From:   Jeff King <peff@peff.net>
To:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/3] t1400: avoid "test" string comparisons
Message-ID: <20200125000624.GA567109@coredump.intra.peff.net>
References: <20200125000542.GA566779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125000542.GA566779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the shell "test" here is inflexible, because we can't easily swap
it out for an i18n-aware version like we can with test_cmp and
test_i18ncmp. And it's not even saving us any processes, since we have
to use "cat" to get the output. So let's switch to using test_cmp, which
has the added bonus that it will produce better output if there's a
failure.

Note that not all of the changed outputs here are candidates for
translation, but I've converted all of them for consistency and to
benefit from the better output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1400-update-ref.sh | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b815cdd1b8..a86dd2fbd9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -361,55 +361,67 @@ ld="Thu, 26 May 2005 18:43:00 -0500"
 test_expect_success 'Query "master@{May 25 2005}" (before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
-	test $C = $(cat o) &&
-	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+	echo "$C" >expect &&
+	test_cmp expect o &&
+	echo "warning: Log for '\''master'\'' only goes back to $ed." >expect &&
+	test_cmp expect e
 '
 test_expect_success 'Query master@{2005-05-25} (before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify master@{2005-05-25} >o 2>e &&
-	test $C = $(cat o) &&
-	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+	echo "$C" >expect &&
+	test_cmp expect o &&
+	echo "warning: Log for '\''master'\'' only goes back to $ed." >expect &&
+	test_cmp expect e
 '
 test_expect_success 'Query "master@{May 26 2005 23:31:59}" (1 second before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
-	test $C = $(cat o) &&
-	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+	echo "$C" >expect &&
+	test_cmp expect o &&
+	echo "warning: Log for '\''master'\'' only goes back to $ed." >expect &&
+	test_cmp expect e
 '
 test_expect_success 'Query "master@{May 26 2005 23:32:00}" (exactly history start)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
-	test $C = $(cat o) &&
+	echo "$C" >expect &&
+	test_cmp expect o &&
 	test_must_be_empty e
 '
 test_expect_success 'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
-	test $A = $(cat o) &&
+	echo "$A" >expect &&
+	test_cmp expect o &&
 	test_must_be_empty e
 '
 test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
-	test $B = $(cat o) &&
+	echo "$B" >expect &&
+	test_cmp expect o &&
 	test_i18ngrep -F "warning: log for ref $m has gap after $gd" e
 '
 test_expect_success 'Query "master@{2005-05-26 23:38:00}" (middle of history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
-	test $Z = $(cat o) &&
+	echo "$Z" >expect &&
+	test_cmp expect o &&
 	test_must_be_empty e
 '
 test_expect_success 'Query "master@{2005-05-26 23:43:00}" (exact end of history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
-	test $E = $(cat o) &&
+	echo "$E" >expect &&
+	test_cmp expect o &&
 	test_must_be_empty e
 '
 test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
-	test $D = $(cat o) &&
+	echo "$D" >expect &&
+	test_cmp expect o &&
 	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
 '
 
-- 
2.25.0.421.gb74d19af79

