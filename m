Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0666202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbdGGJIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:08:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:33512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752459AbdGGJIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:08:32 -0400
Received: (qmail 8474 invoked by uid 109); 7 Jul 2017 09:08:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:08:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20775 invoked by uid 111); 7 Jul 2017 09:08:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:08:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:08:30 -0400
Date:   Fri, 7 Jul 2017 05:08:30 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 5/7] rev-list: check reflog_info before showing usage
Message-ID: <20170707090829.45pcas7vwxn5hvby@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-rev-list sees no pending commits, it shows a usage
message. This works even when reflog-walking is requested,
because the reflog-walk code currently puts the reflog tips
into the pending queue.

In preparation for refactoring the reflog-walk code, let's
explicitly check whether we have any reflogs to walk. For
now this is a noop, but the existing reflog tests will make
sure that it kicks in after the refactoring. Likewise, we'll
add a test that "rev-list -g" without specifying any reflogs
continues to fail (so that we know our check does not kick
in too aggressively).

Note that the implementation needs to go into its own
sub-function, as the walk code does not expose its innards
outside of reflog-walk.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c     | 3 ++-
 reflog-walk.c          | 5 +++++
 reflog-walk.h          | 2 ++
 t/t1414-reflog-walk.sh | 4 ++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 95d84d5cda..53a746dd89 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -11,6 +11,7 @@
 #include "graph.h"
 #include "bisect.h"
 #include "progress.h"
+#include "reflog-walk.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -348,7 +349,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		/* Only --header was specified */
 		revs.commit_format = CMIT_FMT_RAW;
 
-	if ((!revs.commits &&
+	if ((!revs.commits && reflog_walk_empty(revs.reflog_info) &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
diff --git a/reflog-walk.c b/reflog-walk.c
index 081f89b70d..98c2f42de9 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -365,3 +365,8 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		strbuf_release(&selector);
 	}
 }
+
+int reflog_walk_empty(struct reflog_walk_info *info)
+{
+	return !info || !info->reflogs.nr;
+}
diff --git a/reflog-walk.h b/reflog-walk.h
index 27886f793e..af32361072 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -20,4 +20,6 @@ extern void get_reflog_selector(struct strbuf *sb,
 		const struct date_mode *dmode, int force_date,
 		int shorten);
 
+extern int reflog_walk_empty(struct reflog_walk_info *walk);
+
 #endif
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 6426829352..289c502725 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -102,4 +102,8 @@ test_expect_failure 'walk prefers reflog to ref tip' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list -g complains when there are no reflogs' '
+	test_must_fail git rev-list -g
+'
+
 test_done
-- 
2.13.2.1000.g8590c1af5d

