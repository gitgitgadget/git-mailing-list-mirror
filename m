Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA1E202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbdGGJIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:08:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:33500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752109AbdGGJIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:08:15 -0400
Received: (qmail 8449 invoked by uid 109); 7 Jul 2017 09:08:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:08:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20767 invoked by uid 111); 7 Jul 2017 09:08:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:08:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:07:58 -0400
Date:   Fri, 7 Jul 2017 05:07:58 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 4/7] get_revision_1(): replace do-while with an early
 return
Message-ID: <20170707090758.pcwhc6pytzigs6ts@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_revision_1() function tries to avoid entering its
main loop at all when there are no commits to look at. But
it's perfectly safe to call pop_commit() on an empty list
(in which case it will return NULL). Switching to an early
return from the loop lets us skip repeating the loop
condition before we enter the do-while. That will get more
important when we start pulling reflog-walk commits from a
source besides the revs->commits queue, as that condition
will get much more complicated.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 6678de04d9..4019e8cf23 100644
--- a/revision.c
+++ b/revision.c
@@ -3111,12 +3111,12 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 
 static struct commit *get_revision_1(struct rev_info *revs)
 {
-	if (!revs->commits)
-		return NULL;
-
-	do {
+	while (1) {
 		struct commit *commit = pop_commit(&revs->commits);
 
+		if (!commit)
+			return NULL;
+
 		if (revs->reflog_info) {
 			save_parents(revs, commit);
 			fake_reflog_parent(revs->reflog_info, commit);
@@ -3150,8 +3150,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				track_linear(revs, commit);
 			return commit;
 		}
-	} while (revs->commits);
-	return NULL;
+	}
 }
 
 /*
-- 
2.13.2.1000.g8590c1af5d

