Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81BC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 22:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiKQWiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKQWiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 17:38:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF682203
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:37:59 -0800 (PST)
Received: (qmail 28700 invoked by uid 109); 17 Nov 2022 22:37:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 22:37:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18662 invoked by uid 111); 17 Nov 2022 22:37:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 17:37:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 17:37:58 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: [PATCH 1/2] parse_object(): drop extra "has" check before checking
 object type
Message-ID: <Y3a3xnYNyiDQknTM@coredump.intra.peff.net>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing an object of unknown type, we check to see if it's a blob,
so we can use our streaming code path. This uses oid_object_info() to
check the type, but before doing so we call repo_has_object_file(). This
latter is pointless, as oid_object_info() will already fail if the
object is missing. Checking it ahead of time just complicates the code
and is a waste of resources (albeit small).

Let's drop the redundant check.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 8a74eb85e9..16eb944e98 100644
--- a/object.c
+++ b/object.c
@@ -287,8 +287,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	}
 
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
-	    (!obj && repo_has_object_file(r, oid) &&
-	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
+	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
-- 
2.38.1.890.g50b10763b9

