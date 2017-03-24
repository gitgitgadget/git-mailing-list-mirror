Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DAA1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdCXR1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:27:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:51115 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdCXR1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:27:35 -0400
Received: (qmail 17655 invoked by uid 109); 24 Mar 2017 17:26:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 17:26:52 +0000
Received: (qmail 2700 invoked by uid 111); 24 Mar 2017 17:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 13:27:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 13:26:50 -0400
Date:   Fri, 24 Mar 2017 13:26:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] pack.h: define largest possible encoded object size
Message-ID: <20170324172650.x76jk4ahef6tvvjw@sigill.intra.peff.net>
References: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several callers use fixed buffers for storing the pack
object header, and they've picked 10 as a magic number. This
is reasonable, since it handles objects up to 2^67. But
let's give them a constant so it's clear that the number
isn't pulled out of thin air.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 6 ++++--
 pack.h                 | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cf3fc50a2..84af7c232 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -239,7 +239,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 					   unsigned long limit, int usable_delta)
 {
 	unsigned long size, datalen;
-	unsigned char header[10], dheader[10];
+	unsigned char header[MAX_PACK_OBJECT_HEADER],
+		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 	enum object_type type;
 	void *buf;
@@ -353,7 +354,8 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 	off_t offset;
 	enum object_type type = entry->type;
 	off_t datalen;
-	unsigned char header[10], dheader[10];
+	unsigned char header[MAX_PACK_OBJECT_HEADER],
+		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 
 	if (entry->delta)
diff --git a/pack.h b/pack.h
index 87e456d5e..5c2158746 100644
--- a/pack.h
+++ b/pack.h
@@ -84,6 +84,12 @@ extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uin
 extern off_t write_pack_header(struct sha1file *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
+
+/*
+ * The "hdr" output buffer should be at least this big, which will handle sizes
+ * up to 2^67.
+ */
+#define MAX_PACK_OBJECT_HEADER 10
 extern int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 					enum object_type, uintmax_t);
 
-- 
2.12.1.843.g1937c56c2
