Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A8620286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdIMRLb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:11:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:37038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751063AbdIMRLa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:11:30 -0400
Received: (qmail 22545 invoked by uid 109); 13 Sep 2017 17:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:11:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16354 invoked by uid 111); 13 Sep 2017 17:12:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:12:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:11:28 -0400
Date:   Wed, 13 Sep 2017 13:11:28 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/7] get-tar-commit-id: check write_in_full() return against 0
Message-ID: <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We ask to write 41 bytes and make sure that the return value
is at least 41. This is the same "dangerous" pattern that
was fixed in the prior commit (wherein a negative return
value is promoted to unsigned), though it is not dangerous
here because our "41" is a constant, not an unsigned
variable.

But we should convert it anyway to avoid modeling a
dangerous construct.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/get-tar-commit-id.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index e21c5416cd..6d9a79f9b3 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -33,8 +33,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	if (!skip_prefix(content, "52 comment=", &comment))
 		return 1;
 
-	n = write_in_full(1, comment, 41);
-	if (n < 41)
+	if (write_in_full(1, comment, 41) < 0)
 		die_errno("git get-tar-commit-id: write error");
 
 	return 0;
-- 
2.14.1.874.ge7b2e05270

