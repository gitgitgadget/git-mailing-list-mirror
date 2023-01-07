Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA14C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjAGNtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAGNtR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:49:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547EB61450
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:49:16 -0800 (PST)
Received: (qmail 23490 invoked by uid 109); 7 Jan 2023 13:49:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23785 invoked by uid 111); 7 Jan 2023 13:49:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:49:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:49:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/5] streaming: inline call to read_object_file_extended()
Message-ID: <Y7l4W/3kgT8/Ti2H@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The open_istream_incore() function is the only direct user of
read_object_file_extended(), and the only caller which unsets the
lookup_replace flag. Since read_object_file_extended() is now just a
thin wrapper around oid_object_info_extended(), let's inline the call.
That will let us simplify read_object_file_extended() in the next patch.

The inlined version here is a few more lines because of the query setup,
but it's much more flexible, since we can pass (or omit) any flags we
want.

Note the updated comment in the istream struct definition. It was
already slightly wrong (we never called read_object(); it has been
read_object_file_extended() since day one), but should now be accurate.

Signed-off-by: Jeff King <peff@peff.net>
---
 streaming.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index 7b2f8b2b93..27841dc1d9 100644
--- a/streaming.c
+++ b/streaming.c
@@ -38,7 +38,7 @@ struct git_istream {
 
 	union {
 		struct {
-			char *buf; /* from read_object() */
+			char *buf; /* from oid_object_info_extended() */
 			unsigned long read_ptr;
 		} incore;
 
@@ -388,12 +388,17 @@ static ssize_t read_istream_incore(struct git_istream *st, char *buf, size_t sz)
 static int open_istream_incore(struct git_istream *st, struct repository *r,
 			       const struct object_id *oid, enum object_type *type)
 {
-	st->u.incore.buf = read_object_file_extended(r, oid, type, &st->size, 0);
+	struct object_info oi = OBJECT_INFO_INIT;
+
 	st->u.incore.read_ptr = 0;
 	st->close = close_istream_incore;
 	st->read = read_istream_incore;
 
-	return st->u.incore.buf ? 0 : -1;
+	oi.typep = type;
+	oi.sizep = &st->size;
+	oi.contentp = (void **)&st->u.incore.buf;
+	return oid_object_info_extended(r, oid, &oi,
+					OBJECT_INFO_DIE_IF_CORRUPT);
 }
 
 /*****************************************************************************
-- 
2.39.0.469.g9000b9c396

