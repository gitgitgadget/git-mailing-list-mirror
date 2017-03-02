Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B4A20133
	for <e@80x24.org>; Thu,  2 Mar 2017 10:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdCBKKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 05:10:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:37112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbdCBKKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 05:10:02 -0500
Received: (qmail 22725 invoked by uid 109); 2 Mar 2017 08:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:23:20 +0000
Received: (qmail 15237 invoked by uid 111); 2 Mar 2017 08:23:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:23:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:23:18 -0500
Date:   Thu, 2 Mar 2017 03:23:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 8/8] checkout: restrict @-expansions when finding branch
Message-ID: <20170302082318.cw7fyll6saittcoh@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we parse "git checkout $NAME", we try to interpret
$NAME as a local branch-name. If it is, then we point HEAD
to that branch. Otherwise, we detach the HEAD at whatever
commit $NAME points to.

We do the interpretation by calling strbuf_branchname(), and
then blindly sticking "refs/heads/" on the front. This leads
to nonsense results when expansions like "@{upstream}" or
"@" point to something besides a local branch. We end up
with a local branch name like "refs/heads/origin/master" or
"refs/heads/HEAD".

Normally this has no user-visible effect because those
branches don't exist, and so we fallback to feeding the
result to get_sha1(), which resolves them correctly.

But as the new test in t3204 shows, there are corner cases
where the effect is observable, and we check out the wrong
local branch rather than detaching to the correct one.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c                    |  2 +-
 t/t3204-branch-name-interpretation.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 05eefd994..81f07c3ef 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -452,7 +452,7 @@ static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_branchname(&buf, branch->name, 0);
+	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
 	if (strcmp(buf.buf, branch->name))
 		branch->name = xstrdup(buf.buf);
 	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 05e88f92d..698d9cc4f 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -120,4 +120,14 @@ test_expect_success 'delete branch named "@"' '
 	expect_deleted refs/heads/@
 '
 
+test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
+	git update-ref refs/remotes/origin/checkout one &&
+	git branch --set-upstream-to=origin/checkout &&
+	git update-ref refs/heads/origin/checkout two &&
+	git update-ref refs/heads/remotes/origin/checkout two &&
+
+	git checkout @{upstream} &&
+	expect_branch HEAD one
+'
+
 test_done
-- 
2.12.0.367.gb23790f66
