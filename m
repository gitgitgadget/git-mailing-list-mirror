Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B939220248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfDESE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:04:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:48662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:04:58 -0400
Received: (qmail 11000 invoked by uid 109); 5 Apr 2019 18:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28116 invoked by uid 111); 5 Apr 2019 18:05:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:05:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:04:56 -0400
Date:   Fri, 5 Apr 2019 14:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/13] t5319: fix bogus cat-file argument
Message-ID: <20190405180456.GC32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no such argument as "--unsorted"; it's spelled "--unordered".
But our test failed to notice that cat-file didn't run at all because:

  1. It lost the exit code of git on the left-hand side of a pipe.

  2. It was comparing two runs of the broken invocation with and without
     a particular config variable (and indeed, both cases produced no
     output!).

Let's fix the option, but also tweak the helper function to check the
exit code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5319-multi-pack-index.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 70926b5bc0..42f4d6cd01 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -86,13 +86,14 @@ test_expect_success 'write midx with one v1 pack' '
 '
 
 midx_git_two_modes () {
+	git -c core.multiPackIndex=false $1 >expect &&
+	git -c core.multiPackIndex=true $1 >actual &&
 	if [ "$2" = "sorted" ]
 	then
-		git -c core.multiPackIndex=false $1 | sort >expect &&
-		git -c core.multiPackIndex=true $1 | sort >actual
-	else
-		git -c core.multiPackIndex=false $1 >expect &&
-		git -c core.multiPackIndex=true $1 >actual
+		sort <expect >expect.sorted &&
+		mv expect.sorted expect &&
+		sort <actual >actual.sorted &&
+		mv actual.sorted actual
 	fi &&
 	test_cmp expect actual
 }
@@ -104,7 +105,7 @@ compare_results_with_midx () {
 		midx_git_two_modes "log --raw" &&
 		midx_git_two_modes "count-objects --verbose" &&
 		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check" &&
-		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check --unsorted" sorted
+		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check --unordered" sorted
 	'
 }
 
-- 
2.21.0.729.g7d31bf3764

