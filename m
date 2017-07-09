Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5044820357
	for <e@80x24.org>; Sun,  9 Jul 2017 10:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdGIKAs (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 06:00:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:34720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751774AbdGIKAr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 06:00:47 -0400
Received: (qmail 2992 invoked by uid 109); 9 Jul 2017 10:00:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 10:00:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32333 invoked by uid 111); 9 Jul 2017 10:00:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 06:00:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 06:00:45 -0400
Date:   Sun, 9 Jul 2017 06:00:45 -0400
From:   Jeff King <peff@peff.net>
To:     Leo Razoumov <slonik.az@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] branch: set remote color in ref-filter branch immediately
Message-ID: <20170709100045.neb5ovc776wnfphs@sigill.intra.peff.net>
References: <20170709095708.moymrozmqdv2oixx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170709095708.moymrozmqdv2oixx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We set the current and local branch colors at the top of the
build_format() function. Let's do the same for the remote
color. This saves a little bit of repetition, but more
importantly it puts all of the color-setting in the same
place. That makes it easier to see that we are coloring all
possibilities.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ee4e93c3a..8a0595e11 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -338,7 +338,8 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
 		    branch_get_color(BRANCH_COLOR_CURRENT),
 		    branch_get_color(BRANCH_COLOR_LOCAL));
-	strbuf_addf(&remote, "  ");
+	strbuf_addf(&remote, "  %s",
+		    branch_get_color(BRANCH_COLOR_REMOTE));
 
 	if (filter->verbose) {
 		struct strbuf obname = STRBUF_INIT;
@@ -361,17 +362,17 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		else
 			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
 
-		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
+		strbuf_addf(&remote, "%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
 			    "%%(if)%%(symref)%%(then) -> %%(symref:short)"
 			    "%%(else) %s %%(contents:subject)%%(end)",
-			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
+			    maxwidth, quote_literal_for_format(remote_prefix),
 			    branch_get_color(BRANCH_COLOR_RESET), obname.buf);
 		strbuf_release(&obname);
 	} else {
 		strbuf_addf(&local, "%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
 			    branch_get_color(BRANCH_COLOR_RESET));
-		strbuf_addf(&remote, "%s%s%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
-			    branch_get_color(BRANCH_COLOR_REMOTE), quote_literal_for_format(remote_prefix),
+		strbuf_addf(&remote, "%s%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    quote_literal_for_format(remote_prefix),
 			    branch_get_color(BRANCH_COLOR_RESET));
 	}
 
-- 
2.13.2.1066.gabaed60bd
