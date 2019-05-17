Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76241F461
	for <e@80x24.org>; Fri, 17 May 2019 08:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfEQIzM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 04:55:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:60536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726685AbfEQIzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 04:55:11 -0400
Received: (qmail 25510 invoked by uid 109); 17 May 2019 08:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 08:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12836 invoked by uid 111); 17 May 2019 08:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 May 2019 04:55:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 May 2019 04:55:10 -0400
Date:   Fri, 17 May 2019 04:55:10 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190517085509.GA20039@sigill.intra.peff.net>
References: <20190516214257.GD10787@sigill.intra.peff.net>
 <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net>
 <20190517012234.GA31027@sigill.intra.peff.net>
 <20190517043939.GA12063@sigill.intra.peff.net>
 <CACsJy8CNyug3wvZ+6ts1nzgWyPF1JqC0LceP-HzMHjqvCr2Ugw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CNyug3wvZ+6ts1nzgWyPF1JqC0LceP-HzMHjqvCr2Ugw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 02:20:42PM +0700, Duy Nguyen wrote:

> On Fri, May 17, 2019 at 12:35 PM Jeff King <peff@peff.net> wrote:
> > As it turns out, index-pack does not handle these complicated cases at
> > all! In the final fix_unresolved_deltas(), we are only looking for thin
> > deltas, and anything that was not yet resolved is assumed to be a thin
> > object. In many of these cases we _could_ resolve them if we tried
> > harder. But that is good news for us because it means that these
> > expectations about delta relationships are already there, and the
> > pre-fetch done by your patch should always be 100% correct and
> > efficient.
> 
> Is it worth keeping some of these notes in the "third pass" comment
> block in index-pack.c to help future readers?

Perhaps. I started on the patch below, but I had trouble in the commit
message. I couldn't find the part of the code that explains why we would
never produce this combination, though empirically we do not.

-- >8 --
Subject: [PATCH] index-pack: describe an implication of our thin resolving

After digging into the delta resolution code, I discovered a surprising
(to me, anyway) implication of our strategy: we could never find a
non-thin delta with a thin delta as its base. This is OK because
pack-objects will never produce such a combination, because....?

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ccf4eb7e9b..f40f4560d4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1224,6 +1224,13 @@ static void resolve_deltas(void)
  * Third pass:
  * - append objects to convert thin pack to full pack if required
  * - write the final pack hash
+ *
+ * Note that we assume all deltas at this phase are thin. We take only a
+ * single pass over the unresolved objects, and we look for bases only
+ * in our set of already-existing objects, _not_ other objects within this
+ * pack. This means that we would never find an object A stored as a delta
+ * against another object B in this pack, when B is a thin delta against a base
+ * not in the pack.
  */
 static void fix_unresolved_deltas(struct hashfile *f);
 static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned char *pack_hash)
-- 
2.22.0.rc0.544.g1eb4087842

