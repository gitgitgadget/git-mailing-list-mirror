Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006EA202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965290AbdIYU2A (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:28:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:49590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965241AbdIYU17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:27:59 -0400
Received: (qmail 2359 invoked by uid 109); 25 Sep 2017 20:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:27:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28493 invoked by uid 111); 25 Sep 2017 20:28:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:28:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 16:27:57 -0400
Date:   Mon, 25 Sep 2017 16:27:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] notes-merge: drop dead zero-write code
Message-ID: <20170925202757.w6eb556kq3ecyks3@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
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
2.14.1.1148.ga2561536a1

