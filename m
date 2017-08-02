Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49E120899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbdHBWYy (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:24:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751174AbdHBWYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:24:53 -0400
Received: (qmail 3438 invoked by uid 109); 2 Aug 2017 22:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14060 invoked by uid 111); 2 Aug 2017 22:25:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:25:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:24:51 -0400
Date:   Wed, 2 Aug 2017 18:24:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t6018: flesh out empty input/output rev-list tests
Message-ID: <20170802222451.pyh5o6irnbli7mhx@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 751a2ac6e (rev-list --exclude: tests, 2013-11-01), we
added a few tests for handling "empty" inputs with rev-list
(i.e., where the user gave us some pattern but it turned out
not to queue any objects for traversal), all of which were
marked as failing.

In preparation for working on this area of the code, let's
give each test a more descriptive name. Let's also include
one more case which we should cover: feeding a --glob
pattern that doesn't match anything.

We can also drop the explanatory comment; we'll be
converting these to expect_success in the next few patches,
so the discussion isn't necessary.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6018-rev-list-glob.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 381f35ed1..f8367b829 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -255,27 +255,19 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
 	compare rev-list "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
-
-# "git rev-list<ENTER>" is likely to be a bug in the calling script and may
-# deserve an error message, but do cases where set of refs programmatically
-# given using globbing and/or --stdin need to fail with the same error, or
-# are we better off reporting a success with no output?  The following few
-# tests document the current behaviour to remind us that we might want to
-# think about this issue.
-
-test_expect_failure 'rev-list may want to succeed with empty output on no input (1)' '
+test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
 	>expect &&
 	git rev-list --stdin <expect >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-list may want to succeed with empty output on no input (2)' '
+test_expect_failure 'rev-list should succeed with empty output with all refs excluded' '
 	>expect &&
 	git rev-list --exclude=* --all >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-list may want to succeed with empty output on no input (3)' '
+test_expect_failure 'rev-list should succeed with empty output with empty --all' '
 	(
 		test_create_repo empty &&
 		cd empty &&
@@ -285,6 +277,12 @@ test_expect_failure 'rev-list may want to succeed with empty output on no input
 	)
 '
 
+test_expect_failure 'rev-list should succeed with empty output with empty glob' '
+	>expect &&
+	git rev-list --glob=does-not-match-anything >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 
 	compare shortlog "subspace/one subspace/two" --branches=subspace &&
-- 
2.14.0.rc1.586.g00244b0b6

