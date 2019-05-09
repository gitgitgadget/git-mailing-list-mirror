Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9501F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEIVcF (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:32:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:53720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:32:05 -0400
Received: (qmail 10115 invoked by uid 109); 9 May 2019 21:32:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:32:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6593 invoked by uid 111); 9 May 2019 21:32:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:32:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:32:03 -0400
Date:   Thu, 9 May 2019 17:32:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/14] rev-list: drop unused void pointer from finish_commit()
Message-ID: <20190509213203.GL15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our finish_commit() function used to be passed directly to the revision
machinery as a callback. But after 989937221a (rev-list: fix
--verify-objects --quiet becoming --objects, 2012-02-28), it is used
only as a helper in show_commit().

It doesn't use its void "data" parameter, and we no longer have to
conform to the callback interface. Let's drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9f31837d30..660172b014 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -77,7 +77,7 @@ static enum missing_action arg_missing_action;
 
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
-static void finish_commit(struct commit *commit, void *data);
+static void finish_commit(struct commit *commit);
 static void show_commit(struct commit *commit, void *data)
 {
 	struct rev_list_info *info = data;
@@ -86,7 +86,7 @@ static void show_commit(struct commit *commit, void *data)
 	display_progress(progress, ++progress_counter);
 
 	if (info->flags & REV_LIST_QUIET) {
-		finish_commit(commit, data);
+		finish_commit(commit);
 		return;
 	}
 
@@ -99,7 +99,7 @@ static void show_commit(struct commit *commit, void *data)
 			revs->count_left++;
 		else
 			revs->count_right++;
-		finish_commit(commit, data);
+		finish_commit(commit);
 		return;
 	}
 
@@ -188,10 +188,10 @@ static void show_commit(struct commit *commit, void *data)
 			putchar('\n');
 	}
 	maybe_flush_or_die(stdout, "stdout");
-	finish_commit(commit, data);
+	finish_commit(commit);
 }
 
-static void finish_commit(struct commit *commit, void *data)
+static void finish_commit(struct commit *commit)
 {
 	if (commit->parents) {
 		free_commit_list(commit->parents);
-- 
2.21.0.1382.g4c6032d436

