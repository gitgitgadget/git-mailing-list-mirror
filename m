Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D999EC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B426E61107
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFVQHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:07:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:36026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhFVQHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:07:48 -0400
Received: (qmail 5823 invoked by uid 109); 22 Jun 2021 16:05:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 16:05:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28315 invoked by uid 111); 22 Jun 2021 16:05:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 12:05:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 12:05:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/5] object.h: expand docstring for lookup_unknown_object()
Message-ID: <YNIKSzVjBZgfCAIm@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lookup_unknown_object() system is not often used and is somewhat
confusing. Let's try to explain it a bit more (which is especially
important as I'm adding a related but slightly different function in the
next commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 object.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 8bca310713..eb7e481c39 100644
--- a/object.h
+++ b/object.h
@@ -144,7 +144,18 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  */
 struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
-/** Returns the object, with potentially excess memory allocated. **/
+/*
+ * Allocate and return an object struct, even if you do not know the type of
+ * the object. The returned object may have its "type" field set to a real type
+ * (if somebody previously called lookup_blob(), etc), or it may be set to
+ * OBJ_NONE. In the latter case, subsequent calls to lookup_blob(), etc, will
+ * set the type field as appropriate.
+ *
+ * Use this when you do not know the expected type of an object and want to
+ * avoid parsing it for efficiency reasons. Try to avoid it otherwise; it
+ * may allocate excess memory, since the returned object must be as large as
+ * the maximum struct of any type.
+ */
 struct object *lookup_unknown_object(struct repository *r, const struct object_id *oid);
 
 struct object_list *object_list_insert(struct object *item,
-- 
2.32.0.352.gff02c21e72

