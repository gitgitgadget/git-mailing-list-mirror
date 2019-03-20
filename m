Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C306420248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCTINo (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:13:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:57402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727528AbfCTINo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:13:44 -0400
Received: (qmail 19587 invoked by uid 109); 20 Mar 2019 08:13:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:13:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6254 invoked by uid 111); 20 Mar 2019 08:14:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:14:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:13:42 -0400
Date:   Wed, 20 Mar 2019 04:13:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/13] log: drop unused rev_info from early output
Message-ID: <20190320081342.GB10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The early output code passes around a rev_info struct but doesn't need
it. The setup step only turns on global signal handlers, and the
"estimate" step is done completely from the rev->commits list that is
passed in separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ab859f5904..6595471ddf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -251,7 +251,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
  * This gives a rough estimate for how many commits we
  * will print out in the list.
  */
-static int estimate_commit_count(struct rev_info *rev, struct commit_list *list)
+static int estimate_commit_count(struct commit_list *list)
 {
 	int n = 0;
 
@@ -289,7 +289,7 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 		switch (simplify_commit(revs, commit)) {
 		case commit_show:
 			if (show_header) {
-				int n = estimate_commit_count(revs, list);
+				int n = estimate_commit_count(list);
 				show_early_header(revs, "incomplete", n);
 				show_header = 0;
 			}
@@ -333,7 +333,7 @@ static void early_output(int signal)
 	show_early_output = log_show_early;
 }
 
-static void setup_early_output(struct rev_info *rev)
+static void setup_early_output(void)
 {
 	struct sigaction sa;
 
@@ -364,7 +364,7 @@ static void setup_early_output(struct rev_info *rev)
 
 static void finish_early_output(struct rev_info *rev)
 {
-	int n = estimate_commit_count(rev, rev->commits);
+	int n = estimate_commit_count(rev->commits);
 	signal(SIGALRM, SIG_IGN);
 	show_early_header(rev, "done", n);
 }
@@ -376,7 +376,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	int saved_dcctc = 0, close_file = rev->diffopt.close_file;
 
 	if (rev->early_output)
-		setup_early_output(rev);
+		setup_early_output();
 
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
-- 
2.21.0.701.g4401309e11

