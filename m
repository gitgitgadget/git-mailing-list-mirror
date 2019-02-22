Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D195D1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 06:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfBVGVf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 01:21:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:53846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725868AbfBVGVf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 01:21:35 -0500
Received: (qmail 29172 invoked by uid 109); 22 Feb 2019 06:21:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 06:21:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19717 invoked by uid 111); 22 Feb 2019 06:21:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 01:21:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 01:21:33 -0500
Date:   Fri, 22 Feb 2019 01:21:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: [PATCH 2/3] bisect: fix internal diff-tree config loading
Message-ID: <20190222062133.GB10248@sigill.intra.peff.net>
References: <20190222061949.GA9875@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222061949.GA9875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run our internal diff-tree to show the bisected commit, we call
init_revisions(), then load config, then setup_revisions(). But that
order is wrong: we copy the configured defaults into the rev_info struct
during the init_revisions step, so our config load wasn't actually doing
anything.

Signed-off-by: Jeff King <peff@peff.net>
---
It does feel a little weird loading config at all here, since it would
potentially affect other in-process operations. This is where an
external process might be cleaner.

 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 8c81859835..b04d7b2f63 100644
--- a/bisect.c
+++ b/bisect.c
@@ -901,8 +901,8 @@ static void show_diff_tree(struct repository *r,
 	};
 	struct rev_info opt;
 
-	repo_init_revisions(r, &opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	repo_init_revisions(r, &opt, prefix);
 
 	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
 	log_tree_commit(&opt, commit);
-- 
2.21.0.rc2.577.g06bbe9cbd1

