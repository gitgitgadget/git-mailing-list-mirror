Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862C820133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbdCBI36 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:29:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:37059 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdCBI34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:29:56 -0500
Received: (qmail 22716 invoked by uid 109); 2 Mar 2017 08:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:23:15 +0000
Received: (qmail 15232 invoked by uid 111); 2 Mar 2017 08:23:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:23:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:23:14 -0500
Date:   Thu, 2 Mar 2017 03:23:14 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 7/8] strbuf_check_ref_format(): expand only local branches
Message-ID: <20170302082313.uzh7vburrk6tqcuo@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function asks strbuf_branchname() to expand any @-marks
in the branchname, and then we blindly stick refs/heads/ in
front of the result. This is obviously nonsense if the
expansion is "HEAD" or a ref in refs/remotes/.

The most obvious end-user effect is that creating or
renaming a branch with an expansion may have confusing
results (e.g., creating refs/heads/origin/master from
"@{upstream}" when the operation should be disallowed).

We can fix this by telling strbuf_branchname() that we are
only interested in local expansions. Any unexpanded bits are
then fed to check_ref_format(), which either disallows them
(in the case of "@{upstream}") or lets them through
("refs/heads/@" is technically valid, if a bit silly).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                           | 2 +-
 t/t3204-branch-name-interpretation.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7f754b60c..26ceec1d7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1319,7 +1319,7 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
-	strbuf_branchname(sb, name, 0);
+	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 4f4af1fb4..05e88f92d 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -42,7 +42,7 @@ test_expect_success 'update branch via local @{upstream}' '
 	expect_branch local two
 '
 
-test_expect_failure 'disallow updating branch via remote @{upstream}' '
+test_expect_success 'disallow updating branch via remote @{upstream}' '
 	git update-ref refs/remotes/origin/remote one &&
 	git branch --set-upstream-to=origin/remote &&
 
@@ -109,7 +109,7 @@ test_expect_success 'disallow deleting remote branch via @{-1}' '
 # and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
 # sane thing, but it _is_ technically allowed for now. If we disallow it, these
 # can be switched to test_must_fail.
-test_expect_failure 'create branch named "@"' '
+test_expect_success 'create branch named "@"' '
 	git branch -f @ one &&
 	expect_branch refs/heads/@ one
 '
-- 
2.12.0.367.gb23790f66

