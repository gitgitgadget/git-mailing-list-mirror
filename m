Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42208211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAKWQd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:16:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:34222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726116AbfAKWQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:16:33 -0500
Received: (qmail 15791 invoked by uid 109); 11 Jan 2019 22:16:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:16:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13451 invoked by uid 111); 11 Jan 2019 22:16:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:16:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:16:31 -0500
Date:   Fri, 11 Jan 2019 17:16:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] init: make a copy of $GIT_DIR string
Message-ID: <20190111221631.GD10188@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221414.GA31335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass the result of getenv("GIT_DIR") to init_db() and assume that the
string remains valid. But that's not guaranteed across calls to setenv()
or even getenv(), although it often works in practice. Let's make a copy
of the string so that we follow the rules.

Note that we need to mark it with UNLEAK(), since the value persists
until the end of program (but we have no opportunity to free it).

This patch also handles $GIT_WORK_TREE the same way. It actually doesn't
have as long a lifetime and is probably fine, but it's simpler to just
treat the two side-by-side variables the same.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 41faffd28d..93eff7618c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -542,8 +542,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 	 * without --bare.  Catch the error early.
 	 */
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	git_dir = xstrdup_or_null(getenv(GIT_DIR_ENVIRONMENT));
+	work_tree = xstrdup_or_null(getenv(GIT_WORK_TREE_ENVIRONMENT));
 	if ((!git_dir || is_bare_repository_cfg == 1) && work_tree)
 		die(_("%s (or --work-tree=<directory>) not allowed without "
 			  "specifying %s (or --git-dir=<directory>)"),
@@ -582,6 +582,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(real_git_dir);
+	UNLEAK(git_dir);
+	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, flags);
-- 
2.20.1.651.g2d41a78c67

