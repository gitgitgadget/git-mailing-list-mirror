Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49ADD20899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbdHBW0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:26:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:56282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751058AbdHBW0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:26:08 -0400
Received: (qmail 3573 invoked by uid 109); 2 Aug 2017 22:26:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:26:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14128 invoked by uid 111); 2 Aug 2017 22:26:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:26:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:26:06 -0400
Date:   Wed, 2 Aug 2017 18:26:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] rev-list: don't show usage when we see empty ref patterns
Message-ID: <20170802222606.lbibwzygs5mr2xv5@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user gives us no starting point for a traversal, we
want to complain with our normal usage message. But if they
tried to do so with "--all" or "--glob", but that happened
not to match any refs, the usage message isn't helpful. We
should just give them the empty output they asked for
instead.

Signed-off-by: Jeff King <peff@peff.net>
---
This will have a minor textual conflict with my reflog series, which
touches the same conditional.

 builtin/rev-list.c       | 3 ++-
 t/t6018-rev-list-glob.sh | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 95d84d5cd..1e9cc5948 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -350,7 +350,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if ((!revs.commits &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
-	      !revs.pending.nr)) ||
+	      !revs.pending.nr) &&
+	     !revs.rev_input_given) ||
 	    revs.diff)
 		usage(rev_list_usage);
 
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index f8367b829..d3453c583 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -261,13 +261,13 @@ test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-list should succeed with empty output with all refs excluded' '
+test_expect_success 'rev-list should succeed with empty output with all refs excluded' '
 	>expect &&
 	git rev-list --exclude=* --all >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-list should succeed with empty output with empty --all' '
+test_expect_success 'rev-list should succeed with empty output with empty --all' '
 	(
 		test_create_repo empty &&
 		cd empty &&
@@ -277,7 +277,7 @@ test_expect_failure 'rev-list should succeed with empty output with empty --all'
 	)
 '
 
-test_expect_failure 'rev-list should succeed with empty output with empty glob' '
+test_expect_success 'rev-list should succeed with empty output with empty glob' '
 	>expect &&
 	git rev-list --glob=does-not-match-anything >actual &&
 	test_cmp expect actual
-- 
2.14.0.rc1.586.g00244b0b6

