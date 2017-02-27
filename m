Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2665E201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 09:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdB0JZo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 04:25:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:34630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdB0JZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:25:43 -0500
Received: (qmail 18589 invoked by uid 109); 27 Feb 2017 09:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 09:25:42 +0000
Received: (qmail 25952 invoked by uid 111); 27 Feb 2017 09:25:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 04:25:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 04:25:40 -0500
Date:   Mon, 27 Feb 2017 04:25:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] interpret_branch_name(): handle auto-namelen for @{-1}
Message-ID: <20170227092540.ob2oy4qpgfukqwtc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interpret_branch_name() function takes a ptr/len pair
for the name, but you can pass "0" for "namelen", which will
cause it to check the length with strlen().

However, before we do that auto-namelen magic, we call
interpret_nth_prior_checkout(), which gets fed the bogus
"0". This was broken by 8cd4249c4 (interpret_branch_name:
always respect "namelen" parameter, 2014-01-15).  Though to
be fair to that commit, it was broken in the _opposite_
direction before, where we would always treat "name" as a
string even if a length was passed.

You can see the bug with "git log -g @{-1}". That code path
always passes "0", and without this patch it cannot figure
out which branch's reflog to show.

We can fix it by a small reordering of the code.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed while digging on the nearby thread:

  http://public-inbox.org/git/20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net/

 sha1_name.c         | 3 ++-
 t/t0100-previous.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 73a915ff1..9b5d14b4b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1263,11 +1263,12 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *at;
 	const char *start;
-	int len = interpret_nth_prior_checkout(name, namelen, buf);
+	int len;
 
 	if (!namelen)
 		namelen = strlen(name);
 
+	len = interpret_nth_prior_checkout(name, namelen, buf);
 	if (!len) {
 		return len; /* syntax Ok, not enough switches */
 	} else if (len > 0) {
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index e0a694023..58c0b7e9b 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -56,5 +56,13 @@ test_expect_success 'merge @{-100} before checking out that many branches yet' '
 	test_must_fail git merge @{-100}
 '
 
+test_expect_success 'log -g @{-1}' '
+	git checkout -b last_branch &&
+	git checkout -b new_branch &&
+	echo "last_branch@{0}" >expect &&
+	git log -g --format=%gd @{-1} >actual &&
+	test_cmp expect actual
+'
+
 test_done
 
-- 
2.12.0.624.gbb1b07a2c
