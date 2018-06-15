Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8601F403
	for <e@80x24.org>; Fri, 15 Jun 2018 03:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965509AbeFODcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 23:32:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:45328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965120AbeFODca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 23:32:30 -0400
Received: (qmail 17545 invoked by uid 109); 15 Jun 2018 03:32:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 03:32:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18155 invoked by uid 111); 15 Jun 2018 03:32:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 23:32:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 23:32:28 -0400
Date:   Thu, 14 Jun 2018 23:32:28 -0400
From:   Jeff King <peff@peff.net>
To:     Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/3] ewah: drop ewah_serialize_native function
Message-ID: <20180615033228.GC20390@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615032850.GA23241@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't call this function, and never have. The on-disk
bitmap format uses network-byte-order integers, meaning that
we cannot use the native-byte-order format written here.

Let's drop it in the name of simplicity.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/ewah_io.c | 26 --------------------------
 ewah/ewok.h    |  1 -
 2 files changed, 27 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 97c74266da..586396122f 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -20,32 +20,6 @@
 #include "ewok.h"
 #include "strbuf.h"
 
-int ewah_serialize_native(struct ewah_bitmap *self, int fd)
-{
-	uint32_t write32;
-	size_t to_write = self->buffer_size * 8;
-
-	/* 32 bit -- bit size for the map */
-	write32 = (uint32_t)self->bit_size;
-	if (write(fd, &write32, 4) != 4)
-		return -1;
-
-	/** 32 bit -- number of compressed 64-bit words */
-	write32 = (uint32_t)self->buffer_size;
-	if (write(fd, &write32, 4) != 4)
-		return -1;
-
-	if (write(fd, self->buffer, to_write) != to_write)
-		return -1;
-
-	/** 32 bit -- position for the RLW */
-	write32 = self->rlw - self->buffer;
-	if (write(fd, &write32, 4) != 4)
-		return -1;
-
-	return (3 * 4) + to_write;
-}
-
 int ewah_serialize_to(struct ewah_bitmap *self,
 		      int (*write_fun)(void *, const void *, size_t),
 		      void *data)
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 7e25ca2e61..e6102e6c75 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -87,7 +87,6 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 		      int (*write_fun)(void *out, const void *buf, size_t len),
 		      void *out);
 int ewah_serialize(struct ewah_bitmap *self, int fd);
-int ewah_serialize_native(struct ewah_bitmap *self, int fd);
 int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *);
 
 ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
-- 
2.18.0.rc2.534.g53d976aeb8
