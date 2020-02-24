Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD3C35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7EC20661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgBXEhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:37:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:52352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEhc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:37:32 -0500
Received: (qmail 5249 invoked by uid 109); 24 Feb 2020 04:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:37:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7003 invoked by uid 111); 24 Feb 2020 04:46:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:46:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:37:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 09/10] packed_object_info(): use object_id internally for
 delta base
Message-ID: <20200224043731.GI1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit changed the public interface of packed_object_info()
to return a struct object_id rather than a bare hash. That enables us to
convert our internal helper, as well. We can use nth_packed_object_id()
directly for OFS_DELTA, but we'll still have to use oidread() to pull
the hash for a REF_DELTA out of the packfile.

There should be no additional cost, since we're copying directly into
the object_id the caller provided us (just as we did before; it's just
happening now via nth_packed_object_id()).

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index ec7349bb86..90cb5a05ac 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1225,30 +1225,32 @@ off_t get_delta_base(struct packed_git *p,
  * the final object lookup), but more expensive for OFS deltas (we
  * have to load the revidx to convert the offset back into a sha1).
  */
-static const unsigned char *get_delta_base_sha1(struct packed_git *p,
-						struct pack_window **w_curs,
-						off_t curpos,
-						enum object_type type,
-						off_t delta_obj_offset)
+static int get_delta_base_oid(struct packed_git *p,
+			      struct pack_window **w_curs,
+			      off_t curpos,
+			      struct object_id *oid,
+			      enum object_type type,
+			      off_t delta_obj_offset)
 {
 	if (type == OBJ_REF_DELTA) {
 		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
-		return base;
+		oidread(oid, base);
+		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
 		struct revindex_entry *revidx;
 		off_t base_offset = get_delta_base(p, w_curs, &curpos,
 						   type, delta_obj_offset);
 
 		if (!base_offset)
-			return NULL;
+			return -1;
 
 		revidx = find_pack_revindex(p, base_offset);
 		if (!revidx)
-			return NULL;
+			return -1;
 
-		return nth_packed_object_sha1(p, revidx->nr);
+		return nth_packed_object_id(oid, p, revidx->nr);
 	} else
-		return NULL;
+		return -1;
 }
 
 static int retry_bad_packed_offset(struct repository *r,
@@ -1558,16 +1560,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 	if (oi->delta_base_oid) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			const unsigned char *base;
-
-			base = get_delta_base_sha1(p, &w_curs, curpos,
-						   type, obj_offset);
-			if (!base) {
+			if (get_delta_base_oid(p, &w_curs, curpos,
+					       oi->delta_base_oid,
+					       type, obj_offset) < 0) {
 				type = OBJ_BAD;
 				goto out;
 			}
-
-			hashcpy(oi->delta_base_oid->hash, base);
 		} else
 			oidclr(oi->delta_base_oid);
 	}
-- 
2.25.1.823.g95c5488cf7

