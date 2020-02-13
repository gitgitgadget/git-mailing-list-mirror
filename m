Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08ECC352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6B720724
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgBMCVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:21:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:42118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729348AbgBMCVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:21:51 -0500
Received: (qmail 9875 invoked by uid 109); 13 Feb 2020 02:20:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:20:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8754 invoked by uid 111); 13 Feb 2020 02:30:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:30:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:21:50 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/13] bitmap: add bitmap_unset() function
Message-ID: <20200213022150.GJ1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've never needed to unset an individual bit in a bitmap until now.
Typically they start with all bits unset and we bitmap_set() them, or we
are applying another bitmap as a mask. But the easiest way to apply an
object filter to a bitmap result will be to unset the individual bits.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/bitmap.c | 8 ++++++++
 ewah/ewok.h   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 52f1178db4..1c31b3e249 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -45,6 +45,14 @@ void bitmap_set(struct bitmap *self, size_t pos)
 	self->words[block] |= EWAH_MASK(pos);
 }
 
+void bitmap_unset(struct bitmap *self, size_t pos)
+{
+	size_t block = EWAH_BLOCK(pos);
+
+	if (block < self->word_alloc)
+		self->words[block] &= ~EWAH_MASK(pos);
+}
+
 int bitmap_get(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 84b2a29faa..59f4ef7c4f 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -173,6 +173,7 @@ struct bitmap {
 
 struct bitmap *bitmap_new(void);
 void bitmap_set(struct bitmap *self, size_t pos);
+void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
-- 
2.25.0.785.g49bcbe7794

