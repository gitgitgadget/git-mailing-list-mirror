Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C451208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdIEMO1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:57136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751129AbdIEMOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:25 -0400
Received: (qmail 31267 invoked by uid 109); 5 Sep 2017 12:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12194 invoked by uid 111); 5 Sep 2017 12:14:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:14:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:23 -0400
Date:   Tue, 5 Sep 2017 08:14:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/20] verify_signed_buffer: prefer close_tempfile() to
 close()
Message-ID: <20170905121422.sf467ufqkone3xn7@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do a manual close() on the descriptor provided to us by
mks_tempfile. But this runs contrary to the advice in
tempfile.h, which notes that you should always use
close_tempfile(). Otherwise the descriptor may be reused
without the tempfile object knowing it, and the later call
to delete_tempfile() could close a random descriptor.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index d936f3a32f..455b6c04b4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -215,7 +215,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		delete_tempfile(&temp);
 		return -1;
 	}
-	close(fd);
+	close_tempfile(&temp);
 
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
-- 
2.14.1.721.gc5bc1565f1

