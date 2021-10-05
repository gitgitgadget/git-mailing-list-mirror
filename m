Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277CFC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02636610A4
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhJEUjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:39:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:33354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236553AbhJEUiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:38:10 -0400
Received: (qmail 17636 invoked by uid 109); 5 Oct 2021 20:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 20:36:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6516 invoked by uid 111); 5 Oct 2021 20:36:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 16:36:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 16:36:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] cat-file: split ordered/unordered batch-all-objects
 callbacks
Message-ID: <YVy3QU6/SGGvBhVS@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we originally added --batch-all-objects, it stuffed everything into
an oid_array(), and then iterated over that array with a callback to
write the actual output.

When we later added --unordered, that code path writes immediately as we
discover each object, but just calls the same batch_object_cb() as our
entry point to the writing code. That callback has a narrow interface;
it only receives the oid, but we know much more about each object in the
unordered write (which we'll make use of in the next patch). So let's
just call batch_object_write() directly. The callback wasn't saving us
much effort.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b713be545e..b533935d5c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -470,7 +470,9 @@ static int batch_unordered_object(const struct object_id *oid, void *vdata)
 	if (oidset_insert(data->seen, oid))
 		return 0;
 
-	return batch_object_cb(oid, data);
+	oidcpy(&data->expand->oid, oid);
+	batch_object_write(NULL, data->scratch, data->opt, data->expand);
+	return 0;
 }
 
 static int batch_unordered_loose(const struct object_id *oid,
-- 
2.33.0.1231.g45ae28b974

