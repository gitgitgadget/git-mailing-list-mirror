Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC49D1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 04:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfDVEsP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 00:48:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:36480 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725904AbfDVEsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 00:48:15 -0400
Received: (qmail 7244 invoked by uid 109); 22 Apr 2019 04:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 04:48:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28782 invoked by uid 111); 22 Apr 2019 04:48:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 00:48:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 00:48:12 -0400
Date:   Mon, 22 Apr 2019 00:48:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t5516: fix mismerge in 'next'
Message-ID: <20190422044812.GA28493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge of jk/fetch-reachability-error-fix conflicts with
jt/test-protocol-version, but the conflict resolution done by
b4ce8375c018 has a typo (looks like an editor mistake):

  $ git show b4ce8375c018
  [...]
   -                      test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
   -                      test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
   +                      # Some protocol versions (e.g. 2) support fetching
   +                      # unadvertised objects, so restrict this test to v0.
  -                       test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
  -                               git fetch ../testrepo/.git $SHA1_3 &&
  -                       test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
  ++                      test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
  ++                              git fetepo/.git $SHA1_3 &&
  ++                      test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
   +                              git fetch ../testrepo/.git $SHA1_1 &&

The tests don't notice the bogus command because we expect the command
to fail.

Signed-off-by: Jeff King <peff@peff.net>
---
The same problem is present in the merges to pu, which is not surprising
since the 'next' merge was probably just resolved by rerere. We'd
presumably want a fixup like this for 'next' until the next rewind, but
the more important thing is to adjust the rerere cache so the eventual
merge to 'master' is correct.

 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 09e7178987..c81ca360ac 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1242,7 +1242,7 @@ do
 			# Some protocol versions (e.g. 2) support fetching
 			# unadvertised objects, so restrict this test to v0.
 			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
-				git fetepo/.git $SHA1_3 &&
+				git fetch ../testrepo/.git $SHA1_3 &&
 			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
 				git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
-- 
2.21.0.1179.g65a7c4fda7
