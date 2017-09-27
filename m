Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C9E20281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbdI0GAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:00:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:51544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752432AbdI0GAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:00:10 -0400
Received: (qmail 25295 invoked by uid 109); 27 Sep 2017 05:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 05:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11399 invoked by uid 111); 27 Sep 2017 06:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:00:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:00:08 -0400
Date:   Wed, 27 Sep 2017 02:00:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] notes-merge: drop dead zero-write code
Message-ID: <20170927060007.hcoesuhxqtwvdjj3@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We call write_in_full() with a size that we know is greater
than zero. The return value can never be zero, then, since
write_in_full() converts such a failed write() into ENOSPC
and returns -1.  We can just drop this branch of the error
handling entirely.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 notes-merge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 597d43f65c..4352c34a6e 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -308,8 +308,6 @@ static void write_buf_to_worktree(const struct object_id *obj,
 			if (errno == EPIPE)
 				break;
 			die_errno("notes-merge");
-		} else if (!ret) {
-			die("notes-merge: disk full?");
 		}
 		size -= ret;
 		buf += ret;
-- 
2.14.2.988.g01c8b37dde

