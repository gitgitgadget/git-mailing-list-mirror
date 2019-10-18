Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FED01F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbfJRFMR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:12:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732046AbfJRFMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:12:17 -0400
Received: (qmail 9327 invoked by uid 109); 18 Oct 2019 04:45:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:45:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14045 invoked by uid 111); 18 Oct 2019 04:48:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:48:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:45:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/23] parse_tag_buffer(): treat NULL tag pointer as parse
 error
Message-ID: <20191018044534.GC17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing a tag, we may end up with a NULL "tagged" field when
there's a type mismatch (e.g., the tag claims to point to object X as a
commit, but we previously saw X as a blob in the same process), but we
do not otherwise indicate a parse failure to the caller.

This is similar to the case discussed in the previous commit, where a
commit could end up with a NULL tree field: while slightly convenient
for callers who want to overlook a corrupt object, it means that normal
callers have to explicitly deal with this case (rather than just relying
on the return code from parsing). And most don't, leading to segfault
fixes like the one in c77722b3ea (use get_tagged_oid(), 2019-09-05).

Let's address this more centrally, by returning an error code from the
parse itself, which most callers would already notice (adventurous
callers are free to ignore the error and continue looking at the
struct).

This also covers the case where the tag contains a nonsensical "type"
field (there we produced a user-visible error but still returned success
to the caller; now we'll produce a slightly better message and return an
error).

Signed-off-by: Jeff King <peff@peff.net>
---
It's possible that c77722b3ea fixed all of the segfaults here, though of
course new callers must remember to use it instead of accessing
tag->tagged directly. We could _possibly_ get rid of that check now, but
that assumes that all of the caller notice parse_tag() or parse_object()
failing. Having both gives us belt-and-suspenders protection against a
segfault.

 tag.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index bfa0e31435..6a51efda8d 100644
--- a/tag.c
+++ b/tag.c
@@ -167,10 +167,15 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	} else if (!strcmp(type, tag_type)) {
 		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
-		error("Unknown type %s", type);
-		item->tagged = NULL;
+		return error("unknown tag type '%s' in %s",
+			     type, oid_to_hex(&item->object.oid));
 	}
 
+	if (!item->tagged)
+		return error("bad tag pointer to %s in %s",
+			     oid_to_hex(&oid),
+			     oid_to_hex(&item->object.oid));
+
 	if (bufptr + 4 < tail && starts_with(bufptr, "tag "))
 		; 		/* good */
 	else
-- 
2.23.0.1228.gee29b05929

