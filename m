Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789A4202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdGGJH3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:07:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:33466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752776AbdGGJH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:07:28 -0400
Received: (qmail 8365 invoked by uid 109); 7 Jul 2017 09:07:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:07:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20738 invoked by uid 111); 7 Jul 2017 09:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:07:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:07:16 -0400
Date:   Fri, 7 Jul 2017 05:07:16 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 2/7] revision: disallow reflog walking with revs->limited
Message-ID: <20170707090716.kj63rvq4aj4bj7lb@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reflog-walk code doesn't work with limit_list().  That
function traverses down the real history graph, not the fake
reflog history that get_revision() returns. So it's not
going to actually examine all of the commits we're going to
show, because we'd add them to the pending list only during
the actual traversal.

In practice this limitation doesn't really matter, because
the options that require list-limiting generally need
UNINTERESTING endpoints or symmetric ranges, which already
are forbidden for reflog walks. Still, there are likely some
corner cases that would behave oddly. We're better off to
warn the user that we can't fulfill their request than to
generate potentially wrong output.

This will also make it easier to refactor the reflog-walking
code, because it eliminates a whole area of corner cases
we'd have to consider (that already don't work anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index e181ad1b70..6678de04d9 100644
--- a/revision.c
+++ b/revision.c
@@ -2366,6 +2366,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->reverse && revs->reflog_info)
 		die("cannot combine --reverse with --walk-reflogs");
+	if (revs->reflog_info && revs->limited)
+		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
 		die("cannot combine --parents and --children");
 
-- 
2.13.2.1000.g8590c1af5d

