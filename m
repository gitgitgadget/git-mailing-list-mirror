Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EBE202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 06:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCOGYB (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 02:24:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:52022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727151AbfCOGYB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 02:24:01 -0400
Received: (qmail 16112 invoked by uid 109); 15 Mar 2019 06:24:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 06:24:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29646 invoked by uid 111); 15 Mar 2019 06:23:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 02:23:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 02:22:44 -0400
Date:   Fri, 15 Mar 2019 02:22:44 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/2] t5310: correctly remove bitmaps for jgit test
Message-ID: <20190315062243.GA13466@sigill.intra.peff.net>
References: <20190315062133.GA13385@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190315062133.GA13385@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use "jgit gc" to generate a pack bitmap file, and then make sure our
implementation can read it. To prepare the repo before running jgit, we
try to "rm -f" any existing bitmap files. But we got the path wrong;
we're in a bare repo, so looking in ".git/" finds nothing. Our "rm"
doesn't complain because of the "-f", and when we run "rev-list" there
are two bitmap files (ours and jgit's).

Our reader implementation will ignore one of the bitmap files, but it's
likely non-deterministic which one we will use. We'd prefer the one with
the more recent timestamp (just because of the way the packed_git list
is sorted), but in most test runs they'd have identical timestamps.

So this was probably actually testing something useful about 50% of the
time, and other half just testing that we could read our own bitmaps
(which is covered elsewhere).

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup I noticed in the area; can be applied independently from
patch 2.

 t/t5310-pack-bitmaps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 82d7f7f6a5..44a038881a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -269,7 +269,7 @@ test_expect_success JGIT 'we can read jgit bitmaps' '
 	git clone --bare . compat-jgit.git &&
 	(
 		cd compat-jgit.git &&
-		rm -f .git/objects/pack/*.bitmap &&
+		rm -f objects/pack/*.bitmap &&
 		jgit gc &&
 		git rev-list --test-bitmap HEAD
 	)
-- 
2.21.0.543.g90eed137f3

