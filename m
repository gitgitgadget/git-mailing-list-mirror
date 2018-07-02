Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196AD1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeGBVMp (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:12:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:56878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752789AbeGBVMo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:12:44 -0400
Received: (qmail 7951 invoked by uid 109); 2 Jul 2018 21:12:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 21:12:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27401 invoked by uid 111); 2 Jul 2018 21:12:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 17:12:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 17:12:42 -0400
Date:   Mon, 2 Jul 2018 17:12:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Aleksandr Makarov <aleksandr.o.makarov@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 3/3] ref-filter: avoid backend filtering with --ignore-case
Message-ID: <20180702211242.GC23324@sigill.intra.peff.net>
References: <20180702211100.GA20885@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702211100.GA20885@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When for-each-ref is used with --ignore-case, we expect
match_name_as_path() to do a case-insensitive match. But
there's an extra layer of filtering that happens before we
even get there. Since commit cfe004a5a9 (ref-filter: limit
traversal to prefix, 2017-05-22), we feed the prefix to the
ref backend so that it can optimize the ref iteration.

There's no mechanism for us to tell the backend we're
matching case-insensitively. And nor is there likely to be
one anytime soon, since the packed backend relies on
binary-searching the sorted list of refs. Let's just punt on
this case. The extra filtering is an optimization that we
simply can't do. We'll still give the correct answer via the
filtering in match_name_as_path().

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            | 9 +++++++++
 t/t6300-for-each-ref.sh | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5c0cbde52b..52704c7be6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1868,6 +1868,15 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_in("", cb, cb_data, broken);
 	}
 
+	if (filter->ignore_case) {
+		/*
+		 * we can't handle case-insensitive comparisons,
+		 * so just return everything and let the caller
+		 * sort it out.
+		 */
+		return for_each_fullref_in("", cb, cb_data, broken);
+	}
+
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
 		return for_each_fullref_in("", cb, cb_data, broken);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b2bc81103f..e0496da812 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -795,7 +795,7 @@ test_expect_success ':remotename and :remoteref' '
 	)
 '
 
-test_expect_failure 'for-each-ref --ignore-case ignores case' '
+test_expect_success 'for-each-ref --ignore-case ignores case' '
 	>expect &&
 	git for-each-ref --format="%(refname)" refs/heads/MASTER >actual &&
 	test_cmp expect actual &&
-- 
2.18.0.359.ge51c883f96
