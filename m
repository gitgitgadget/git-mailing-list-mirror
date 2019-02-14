Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEC01F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405418AbfBNFto (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:49:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:43736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733014AbfBNFtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:49:43 -0500
Received: (qmail 832 invoked by uid 109); 14 Feb 2019 05:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:49:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6893 invoked by uid 111); 14 Feb 2019 05:49:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:49:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:49:42 -0500
Date:   Thu, 14 Feb 2019 00:49:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/10] diff: drop complete_rewrite parameter from
 run_external_diff()
Message-ID: <20190214054941.GD20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our builtin_diff() wants to know whether break-detection found a
complete rewrite, because it changes how the diff is shown. However,
when calling out to an external diff, we don't pass this information
along (and doing so would require designing a new interface to the
user-provided program).

Let's drop the unused parameter to make this fact more clear.

Signed-off-by: Jeff King <peff@peff.net>
---
An alternative is to pass $COMPLETE_REWRITE in the environment. That
would avoid disrupting existing external diff callers, and they could
peek at the information if they really cared. But given that nobody has
actually asked for this, I'm inclined not to add a new interface element
that we'd then have to support forever.

 diff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d24843b531..e3f263769b 100644
--- a/diff.c
+++ b/diff.c
@@ -4178,7 +4178,6 @@ static void run_external_diff(const char *pgm,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
 			      const char *xfrm_msg,
-			      int complete_rewrite,
 			      struct diff_options *o)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
@@ -4336,8 +4335,7 @@ static void run_diff_cmd(const char *pgm,
 	}
 
 	if (pgm) {
-		run_external_diff(pgm, name, other, one, two, xfrm_msg,
-				  complete_rewrite, o);
+		run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
 		return;
 	}
 	if (one && two)
-- 
2.21.0.rc1.567.g648f076c3f

