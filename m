Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991EC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3162207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393589AbgAPSeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:34:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:38118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387537AbgAPSeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 13:34:25 -0500
Received: (qmail 31733 invoked by uid 109); 16 Jan 2020 18:34:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Jan 2020 18:34:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8578 invoked by uid 111); 16 Jan 2020 18:40:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2020 13:40:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jan 2020 13:34:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] t4018: drop "debugging" cat from hunk-header tests
Message-ID: <20200116183423.GA3011203@coredump.intra.peff.net>
References: <20200116175138.GA691238@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200116175138.GA691238@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We run a series of hunk-header tests in a loop, and each one does this:

  test_when_finished 'cat actual' &&      # for debugging only

This is pretty pointless. When the test succeeds, we waste time running
a useless cat process. If you're debugging a failure with "-i", then we
won't run the when-finished part at all. So it helps only if you're
running with something like "--verbose-log".

Since we expect the tests to succeed most of the time, a better way to
do this would be a helper that checks the output and dumps "actual" only
when it fails. But it's probably not even worth the effort, as anyone
debugging a failure could just run with "-i" and investigate the
"actual" file themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
Just noticed this when working with t4018 on an unrelated problem.

I could be convinced otherwise on the final paragraph, but I think it
would only be worth it if we added a general test_grep() helper and used
it in more places.

 t/t4018-diff-funcname.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index c0f4839543..02255a08bf 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -106,7 +106,6 @@ do
 		result=success
 	fi
 	test_expect_$result "hunk header: $i" "
-		test_when_finished 'cat actual' &&	# for debugging only
 		git diff -U1 $i >actual &&
 		grep '@@ .* @@.*RIGHT' actual
 	"
-- 
2.25.0.318.gee4019ba55
