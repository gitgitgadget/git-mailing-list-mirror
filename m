Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5391F1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeGBVMC (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:12:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:56864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752842AbeGBVMB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:12:01 -0400
Received: (qmail 7896 invoked by uid 109); 2 Jul 2018 21:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 21:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27382 invoked by uid 111); 2 Jul 2018 21:12:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 17:12:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 17:11:59 -0400
Date:   Mon, 2 Jul 2018 17:11:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Aleksandr Makarov <aleksandr.o.makarov@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/3] for-each-ref: consistently pass WM_IGNORECASE flag
Message-ID: <20180702211159.GB23324@sigill.intra.peff.net>
References: <20180702211100.GA20885@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702211100.GA20885@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleksandr Makarov <aleksandr.o.makarov@gmail.com>

The match_name_as_path() function learned to set
WM_IGNORECASE in the "flags" field when the user passed
--ignore-case. But it forgot to actually pass the flags to
wildmatch()!

As a result, the --ignore-case feature has been broken since
it was added in 3bb16a8bf2 (tag, branch, for-each-ref: add
--ignore-case for sorting and filtering, 2016-12-04). We
didn't notice because we added tests only for git-branch and
git-tag. Whereas git-for-each-ref has slightly different
matching rules, and thus uses a different function (the
related function match_pattern() does it correctly).

Incidentally, this also caused clang's scan-build to
complain about the code; the assignment to "flags" was dead
code.

Note that we can't flip the test in t6300 to expect_success
yet. There's another bug, which will be dealt with in the
next patch.

Commit-message-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index fa3685d91f..5c0cbde52b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1813,7 +1813,7 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
 		     refname[plen] == '/' ||
 		     p[plen-1] == '/'))
 			return 1;
-		if (!wildmatch(p, refname, WM_PATHNAME))
+		if (!wildmatch(p, refname, flags))
 			return 1;
 	}
 	return 0;
-- 
2.18.0.359.ge51c883f96

