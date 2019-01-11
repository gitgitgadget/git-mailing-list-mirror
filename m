Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3111211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAKWQ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:16:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:34228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725812AbfAKWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:16:57 -0500
Received: (qmail 15800 invoked by uid 109); 11 Jan 2019 22:16:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:16:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13467 invoked by uid 111); 11 Jan 2019 22:16:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:16:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:16:55 -0500
Date:   Fri, 11 Jan 2019 17:16:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] merge-recursive: copy $GITHEAD strings
Message-ID: <20190111221655.GE10188@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221414.GA31335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If $GITHEAD_1234abcd is set in the environment, we use its value as a
"better branch name" in generating conflict markers. However, we pick
these better names early in the process, and the return value from
getenv() is not guaranteed to stay valid.

Let's make a copy of the returned string. And to make memory management
easier, let's just always return an allocated string from
better_branch_name(), so we know that it must always be freed.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge-recursive.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 9b2f707c29..7545136c2a 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -7,16 +7,16 @@
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
 
-static const char *better_branch_name(const char *branch)
+static char *better_branch_name(const char *branch)
 {
 	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
 	char *name;
 
 	if (strlen(branch) != the_hash_algo->hexsz)
-		return branch;
+		return xstrdup(branch);
 	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
 	name = getenv(githead_env);
-	return name ? name : branch;
+	return xstrdup(name ? name : branch);
 }
 
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
@@ -26,6 +26,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	int i, failed;
 	struct object_id h1, h2;
 	struct merge_options o;
+	char *better1, *better2;
 	struct commit *result;
 
 	init_merge_options(&o);
@@ -70,13 +71,17 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (get_oid(o.branch2, &h2))
 		die(_("could not resolve ref '%s'"), o.branch2);
 
-	o.branch1 = better_branch_name(o.branch1);
-	o.branch2 = better_branch_name(o.branch2);
+	o.branch1 = better1 = better_branch_name(o.branch1);
+	o.branch2 = better2 = better_branch_name(o.branch2);
 
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
 
 	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
+
+	free(better1);
+	free(better2);
+
 	if (failed < 0)
 		return 128; /* die() error code */
 	return failed;
-- 
2.20.1.651.g2d41a78c67

