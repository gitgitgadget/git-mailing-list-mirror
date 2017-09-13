Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C7A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdIMRRw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:17:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751413AbdIMRRq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:17:46 -0400
Received: (qmail 23084 invoked by uid 109); 13 Sep 2017 17:17:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:17:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17582 invoked by uid 111); 13 Sep 2017 17:18:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:18:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:17:44 -0400
Date:   Wed, 13 Sep 2017 13:17:44 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 6/7] notes-merge: use ssize_t for write_in_full() return value
Message-ID: <20170913171744.32cmtjkdcp7yf7pt@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We store the return value of write_in_full() in a long,
though the return is actually an ssize_t. This probably
doesn't matter much in practice (since the buffer size is
alredy an unsigned long), but it might if the size if
between what can be represented in "long" and "unsigned
long", and if your size_t is larger than a "long" (as it is
on 64-bit Windows).

Signed-off-by: Jeff King <peff@peff.net>
---
 notes-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes-merge.c b/notes-merge.c
index b04d2f2131..597d43f65c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -302,7 +302,7 @@ static void write_buf_to_worktree(const struct object_id *obj,
 	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
 
 	while (size > 0) {
-		long ret = write_in_full(fd, buf, size);
+		ssize_t ret = write_in_full(fd, buf, size);
 		if (ret < 0) {
 			/* Ignore epipe */
 			if (errno == EPIPE)
-- 
2.14.1.874.ge7b2e05270

