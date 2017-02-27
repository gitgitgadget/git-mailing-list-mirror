Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E18201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdB0J35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 04:29:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:34633 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdB0J3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:29:55 -0500
Received: (qmail 18837 invoked by uid 109); 27 Feb 2017 09:29:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 09:29:33 +0000
Received: (qmail 13073 invoked by uid 111); 27 Feb 2017 09:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 04:29:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 04:29:31 -0500
Date:   Mon, 27 Feb 2017 04:29:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t6300: avoid creating refs/heads/HEAD
Message-ID: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one test, we use "git checkout --orphan HEAD" to create
an unborn branch. Confusingly, the resulting branch is named
"refs/heads/HEAD". The original probably meant something
like:

  git checkout --orphan orphaned-branch HEAD

Let's just use "orphaned-branch" here to make this less
confusing. Putting HEAD in the second argument is already
implied.

Signed-off-by: Jeff King <peff@peff.net>
---
This comes originally from Junio's 84679d470. I cannot see how naming
the new branch HEAD would make any difference to the test, but perhaps I
am missing something.

I noticed this while digging on a nearby issue around "git branch -m @".
This does happen to be the only test that checks that we can make a
branch called refs/heads/HEAD, and I found it because it triggers if you
try to disallow "git branch -m HEAD". :)

If we care about that, though, I think we should make an explicit test
for "git branch HEAD". But I'm not sure we _do_ care about that. Making
a branch called HEAD is moderately insane, and I don't think it would be
unreasonable for us to outlaw it at some point.

 t/t6300-for-each-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index aea1dfc71..a468041c5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -558,7 +558,7 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout master" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
 	sed -e "s/^\* /  /" actual >expect &&
-	git checkout --orphan HEAD &&
+	git checkout --orphan orphaned-branch &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
 	test_cmp expect actual
 '
-- 
2.12.0.624.gbb1b07a2c
