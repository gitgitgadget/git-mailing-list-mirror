Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19BE20133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbdCBI3v (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:29:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:37054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdCBI3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:29:50 -0500
Received: (qmail 22698 invoked by uid 109); 2 Mar 2017 08:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:23:08 +0000
Received: (qmail 15222 invoked by uid 111); 2 Mar 2017 08:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:23:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:23:06 -0500
Date:   Thu, 2 Mar 2017 03:23:06 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 5/8] t3204: test git-branch @-expansion corner cases
Message-ID: <20170302082306.n6kfc5uqz2kdxtpm@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-branch feeds the branch names from the command line to
strbuf_branchname(), but we do not yet tell that function
which kinds of expansions should be allowed. Let's create a
set of tests that cover both the allowed and disallowed
cases.

That shows off some breakages where we currently create or
delete the wrong ref (and will make sure that we do not
break any cases that _should_ be working when we do add more
restrictions).

Note that we check branch creation and deletion, but do not
bother with renames. Those follow the same code path as
creation.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3204-branch-name-interpretation.sh | 123 ++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 t/t3204-branch-name-interpretation.sh

diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
new file mode 100755
index 000000000..e671a7a64
--- /dev/null
+++ b/t/t3204-branch-name-interpretation.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='interpreting exotic branch name arguments
+
+Branch name arguments are usually names which are taken to be inside of
+refs/heads/, but we interpret some magic syntax like @{-1}, @{upstream}, etc.
+This script aims to check the behavior of those corner cases.
+'
+. ./test-lib.sh
+
+expect_branch() {
+	git log -1 --format=%s "$1" >actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+expect_deleted() {
+	test_must_fail git rev-parse --verify "$1"
+}
+
+test_expect_success 'set up repo' '
+	test_commit one &&
+	test_commit two &&
+	git remote add origin foo.git
+'
+
+test_expect_success 'update branch via @{-1}' '
+	git branch previous one &&
+
+	git checkout previous &&
+	git checkout master &&
+
+	git branch -f @{-1} two &&
+	expect_branch previous two
+'
+
+test_expect_success 'update branch via local @{upstream}' '
+	git branch local one &&
+	git branch --set-upstream-to=local &&
+
+	git branch -f @{upstream} two &&
+	expect_branch local two
+'
+
+test_expect_failure 'disallow updating branch via remote @{upstream}' '
+	git update-ref refs/remotes/origin/remote one &&
+	git branch --set-upstream-to=origin/remote &&
+
+	test_must_fail git branch -f @{upstream} two
+'
+
+test_expect_success 'create branch with pseudo-qualified name' '
+	git branch refs/heads/qualified two &&
+	expect_branch refs/heads/refs/heads/qualified two
+'
+
+test_expect_success 'delete branch via @{-1}' '
+	git branch previous-del &&
+
+	git checkout previous-del &&
+	git checkout master &&
+
+	git branch -D @{-1} &&
+	expect_deleted previous-del
+'
+
+test_expect_success 'delete branch via local @{upstream}' '
+	git branch local-del &&
+	git branch --set-upstream-to=local-del &&
+
+	git branch -D @{upstream} &&
+	expect_deleted local-del
+'
+
+test_expect_success 'delete branch via remote @{upstream}' '
+	git update-ref refs/remotes/origin/remote-del two &&
+	git branch --set-upstream-to=origin/remote-del &&
+
+	git branch -r -D @{upstream} &&
+	expect_deleted origin/remote-del
+'
+
+# Note that we create two oddly named local branches here. We want to make
+# sure that we do not accidentally delete either of them, even if
+# shorten_unambiguous_ref() tweaks the name to avoid ambiguity.
+test_expect_failure 'delete @{upstream} expansion matches -r option' '
+	git update-ref refs/remotes/origin/remote-del two &&
+	git branch --set-upstream-to=origin/remote-del &&
+	git update-ref refs/heads/origin/remote-del two &&
+	git update-ref refs/heads/remotes/origin/remote-del two &&
+
+	test_must_fail git branch -D @{upstream} &&
+	expect_branch refs/heads/origin/remote-del two &&
+	expect_branch refs/heads/remotes/origin/remote-del two
+'
+
+test_expect_failure 'disallow deleting remote branch via @{-1}' '
+	git update-ref refs/remotes/origin/previous one &&
+
+	git checkout -b origin/previous two &&
+	git checkout master &&
+
+	test_must_fail git branch -r -D @{-1} &&
+	expect_branch refs/remotes/origin/previous one &&
+	expect_branch refs/heads/origin/previous two
+'
+
+# The thing we are testing here is that "@" is the real branch refs/heads/@,
+# and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
+# sane thing, but it _is_ technically allowed for now. If we disallow it, these
+# can be switched to test_must_fail.
+test_expect_failure 'create branch named "@"' '
+	git branch -f @ one &&
+	expect_branch refs/heads/@ one
+'
+
+test_expect_failure 'delete branch named "@"' '
+	git update-ref refs/heads/@ two &&
+	git branch -D @ &&
+	expect_deleted refs/heads/@
+'
+
+test_done
-- 
2.12.0.367.gb23790f66

