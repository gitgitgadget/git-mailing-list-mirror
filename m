Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F041FAA8
	for <e@80x24.org>; Mon, 15 May 2017 07:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759623AbdEOHuP (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 03:50:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51731 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755249AbdEOHuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 03:50:13 -0400
Received: (qmail 11397 invoked by uid 109); 15 May 2017 07:50:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 07:50:13 +0000
Received: (qmail 14471 invoked by uid 111); 15 May 2017 07:50:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:50:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 03:50:11 -0400
Date:   Mon, 15 May 2017 03:50:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] clone: use free_refspec() to free refspec list
Message-ID: <20170515075011.5pm6j3k3fwentm2o@sigill.intra.peff.net>
References: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using free() on a refspec was always leaky, as its string
fields also need freed. But it became more so when ad00f128d
(clone: respect configured fetch respecs during initial
fetch, 2016-03-30) taught clone to create a list of
refspecs, each of which need to be freed.

Signed-off-by: Jeff King <peff@peff.net>
---
It's doubtful anyone cares, as this is right before program exit anyway.
But if we're going to bother to free(), we may as well do it right.

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 645cfa4fd..672c5b0a6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1144,6 +1144,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(refspec);
+	free_refspec(refspec_count, refspec);
 	return err;
 }
-- 
2.13.0.458.g025404205
