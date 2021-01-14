Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC43C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37D623436
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbhANTee (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:34:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:56332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbhANTee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:34:34 -0500
Received: (qmail 17037 invoked by uid 109); 14 Jan 2021 19:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 19:33:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17285 invoked by uid 111); 14 Jan 2021 19:33:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 14:33:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 14:33:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
Message-ID: <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
 <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 10:43:37PM -0800, Junio C Hamano wrote:

> >  		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
> > -			pos = p->revindex[i].nr;
> > +			pos = pack_pos_to_index(p, i);
> 
> It wasn't too bad before this series formally defined what
> "position", "index" and "offset" mean, but now this has become
> highly misleading. The variable "pos" here holds what we consider
> "index" while "i" holds what we call "position" [*1*].

I don't think "position" is a meaningful term by itself. I would say the
useful terms are "pack position", "index position", and "offset" (or
"pack offset" if you like). I don't think anything in the definitions
added by earlier patches contradicts that, but perhaps we can make it
more clear.

So "pos" in this case is not wrong. But I agree that it could stand to
be more clear. Saying "nth" does not help things IMHO (there is an "nth"
pack position, as well).

But maybe this makes it more clear (or possibly just the name change
without the comment):

diff --git a/packfile.c b/packfile.c
index de47c9f4f8..6035b80466 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2078,19 +2078,30 @@ int for_each_object_in_pack(struct packed_git *p,
 	}
 
 	for (i = 0; i < p->num_objects; i++) {
-		uint32_t pos;
+		uint32_t index_pos;
 		struct object_id oid;
 
+		/*
+		 * We are iterating "i" from 0 up to num_objects, but its
+		 * meaning may be different:
+		 *
+		 *   - in object-name order, it is the same as the index order
+		 *     given to us by nth_packed_object_id(), and we can use it
+		 *     directly
+		 *
+		 *   - in pack-order, it is pack position, which we must
+		 *     convert to an index position in order to get the oid.
+		 */
 		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
-			pos = p->revindex[i].nr;
+			index_pos = p->revindex[i].nr;
 		else
-			pos = i;
+			index_pos = i;
 
-		if (nth_packed_object_id(&oid, p, pos) < 0)
+		if (nth_packed_object_id(&oid, p, index_pos) < 0)
 			return error("unable to get sha1 of object %u in %s",
-				     pos, p->pack_name);
+				     index_pos, p->pack_name);
 
-		r = cb(&oid, p, pos, data);
+		r = cb(&oid, p, index_pos, data);
 		if (r)
 			break;
 	}


> *1* The nth_packed_object_id() call we make later using the value we
> obtain here should be documented to take "index" as its last
> parameter, now that is what we call the location in the index, which
> is in object name order.

I would love to see the function given a more descriptive name. Having
worked on the bitmap code a lot, where the norm is pack-order, saying
"nth" is confusing and error-prone.

But I think that's out of scope for this series.

-Peff
