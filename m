Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00911F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfGSV4W (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:56:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:40688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfGSV4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:56:21 -0400
Received: (qmail 8719 invoked by uid 109); 19 Jul 2019 21:56:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jul 2019 21:56:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29222 invoked by uid 111); 19 Jul 2019 21:57:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jul 2019 17:57:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jul 2019 17:56:20 -0400
Date:   Fri, 19 Jul 2019 17:56:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3 5/6] t5703: use test_commit_bulk
Message-ID: <20190719215619.GE32188@sigill.intra.peff.net>
References: <20190719215417.GA31841@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719215417.GA31841@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two loops that create 33 commits each using test_commit. Using
test_commit_bulk speeds this up from:

  Benchmark #1: ./t5703-upload-pack-ref-in-want.sh --root=/var/ram/git-tests
    Time (mean ± σ):      2.142 s ±  0.161 s    [User: 1.136 s, System: 0.974 s]
    Range (min … max):    1.903 s …  2.401 s    10 runs

to:

  Benchmark #1: ./t5703-upload-pack-ref-in-want.sh --root=/var/ram/git-tests
    Time (mean ± σ):      1.440 s ±  0.114 s    [User: 737.7 ms, System: 615.4 ms]
    Range (min … max):    1.230 s …  1.604 s    10 runs

for an average savings of almost 33%.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 0951d1bbdc..de4b6106ef 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -176,7 +176,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
 		cd "$LOCAL_PRISTINE" &&
 		git checkout -b side &&
-		for i in $(test_seq 1 33); do test_commit s$i; done &&
+		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
 		git checkout master &&
@@ -287,7 +287,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		git clone "file://$REPO" "$LOCAL_PRISTINE" &&
 		cd "$LOCAL_PRISTINE" &&
 		git checkout -b side &&
-		for i in $(test_seq 1 33); do test_commit s$i; done &&
+		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
 		git checkout master &&
-- 
2.22.0.993.gcc1030c86b

