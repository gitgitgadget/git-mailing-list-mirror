Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF13A1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 06:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfBVGUj (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 01:20:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:53834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725873AbfBVGUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 01:20:39 -0500
Received: (qmail 29146 invoked by uid 109); 22 Feb 2019 06:20:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 06:20:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19697 invoked by uid 111); 22 Feb 2019 06:20:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 01:20:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 01:20:37 -0500
Date:   Fri, 22 Feb 2019 01:20:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: [PATCH 1/3] bisect: use string arguments to feed internal diff-tree
Message-ID: <20190222062037.GA10248@sigill.intra.peff.net>
References: <20190222061949.GA9875@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222061949.GA9875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e22278c0a0 (bisect: display first bad commit without forking a
new process, 2009-05-28) converted our external call to diff-tree to
an internal use of the log_tree_commit(). But rather than individually
setting options in the rev_info struct (and explaining in comments how
they map to command-line options), we can just pass the command-line
options to setup_revisions().

This is shorter, easier to change, and less likely to break if
revision.c internals change.

Note that we unconditionally set the output format to "raw". The
conditional in the original code didn't actually do anything useful,
since nobody had an opportunity to set the format to anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3af955c4bc..8c81859835 100644
--- a/bisect.c
+++ b/bisect.c
@@ -896,24 +896,15 @@ static void show_diff_tree(struct repository *r,
 			   const char *prefix,
 			   struct commit *commit)
 {
+	const char *argv[] = {
+		"diff-tree", "--pretty", "--no-abbrev", "--raw", NULL
+	};
 	struct rev_info opt;
 
-	/* diff-tree init */
 	repo_init_revisions(r, &opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	opt.abbrev = 0;
-	opt.diff = 1;
 
-	/* This is what "--pretty" does */
-	opt.verbose_header = 1;
-	opt.use_terminator = 0;
-	opt.commit_format = CMIT_FMT_DEFAULT;
-
-	/* diff-tree init */
-	if (!opt.diffopt.output_format)
-		opt.diffopt.output_format = DIFF_FORMAT_RAW;
-
-	setup_revisions(0, NULL, &opt, NULL);
+	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
 	log_tree_commit(&opt, commit);
 }
 
-- 
2.21.0.rc2.577.g06bbe9cbd1

