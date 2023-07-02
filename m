Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D1EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 22:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGBWic (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGBWib (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 18:38:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C61B7
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 15:38:30 -0700 (PDT)
Received: (qmail 18057 invoked by uid 109); 2 Jul 2023 22:38:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 22:38:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16728 invoked by uid 111); 2 Jul 2023 22:38:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 18:38:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 18:38:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 3/3] ref-filter: simplify return type of match_points_at
Message-ID: <20230702223829.GC3494279@coredump.intra.peff.net>
References: <20230702223342.GA1598765@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230702223342.GA1598765@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We return the oid that matched, but the sole caller only cares whether
we matched anything at all. This is mostly academic, since there's only
one caller, but the lifetime of the returned pointer is not immediately
clear. Sometimes it points to an oid in a tag struct, which should live
forever. And sometimes to the oid passed in, which only lives as long as
the each_ref_fn callback we're called from.

Simplify this to a boolean return which is more direct and obvious. As a
bonus, this lets us avoid the weird pattern of overwriting our "oid"
parameter in the loop (since we now only refer to the tagged oid one
time, and can just inline the call to get it).

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f5ac486430..0629435f08 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2209,20 +2209,22 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 /*
  * Given a ref (oid, refname), check if the ref belongs to the array
  * of oids. If the given ref is a tag, check if the given tag points
- * at one of the oids in the given oid array.
+ * at one of the oids in the given oid array. Returns non-zero if a
+ * match is found.
+ *
  * NEEDSWORK:
  * As the refs are cached we might know what refname peels to without
  * the need to parse the object via parse_object(). peel_ref() might be a
  * more efficient alternative to obtain the pointee.
  */
-static const struct object_id *match_points_at(struct oid_array *points_at,
-					       const struct object_id *oid,
-					       const char *refname)
+static int match_points_at(struct oid_array *points_at,
+			   const struct object_id *oid,
+			   const char *refname)
 {
 	struct object *obj;
 
 	if (oid_array_lookup(points_at, oid) >= 0)
-		return oid;
+		return 1;
 	obj = parse_object_with_flags(the_repository, oid,
 				      PARSE_OBJECT_SKIP_HASH_CHECK);
 	while (obj && obj->type == OBJ_TAG) {
@@ -2233,15 +2235,14 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 			break;
 		}
 
-		oid = get_tagged_oid(tag);
-		if (oid_array_lookup(points_at, oid) >= 0)
-			return oid;
+		if (oid_array_lookup(points_at, get_tagged_oid(tag)) >= 0)
+			return 1;
 
 		obj = tag->tagged;
 	}
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
-	return NULL;
+	return 0;
 }
 
 /*
-- 
2.41.0.586.g3c0cc15bc7
