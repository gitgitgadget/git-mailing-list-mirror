Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AAC20A04
	for <e@80x24.org>; Fri, 26 May 2017 19:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944550AbdEZTLH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:58618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S944602AbdEZTK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:56 -0400
Received: (qmail 21884 invoked by uid 109); 26 May 2017 19:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:10:55 +0000
Received: (qmail 32208 invoked by uid 111); 26 May 2017 19:11:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:11:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:10:53 -0400
Date:   Fri, 26 May 2017 15:10:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 6/6] verify_filename(): flip order of checks
Message-ID: <20170526191053.v2mmx7oour6u5chp@sigill.intra.peff.net>
References: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The looks_like_pathspec() check is much cheaper than
check_filename(), which actually stats the file. Since
either is sufficient for our return value, we should do the
cheaper one first, potentially short-circuiting the other.

Signed-off-by: Jeff King <peff@peff.net>
---
Probably doesn't matter, but it bugged me and it was subtle enough that
I pulled it out into its own commit.

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 89fcc12ab..1de87ed84 100644
--- a/setup.c
+++ b/setup.c
@@ -229,7 +229,7 @@ void verify_filename(const char *prefix,
 {
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
-	if (check_filename(prefix, arg) || looks_like_pathspec(arg))
+	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
 }
-- 
2.13.0.496.ge44ba89db
