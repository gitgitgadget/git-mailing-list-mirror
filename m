Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D601F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbdARVv3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:51:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:41161 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752685AbdARVv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:51:28 -0500
Received: (qmail 22609 invoked by uid 109); 18 Jan 2017 21:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 21:51:23 +0000
Received: (qmail 32413 invoked by uid 111); 18 Jan 2017 21:52:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 16:52:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2017 16:51:20 -0500
Date:   Wed, 18 Jan 2017 16:51:20 -0500
From:   Jeff King <peff@peff.net>
To:     Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@freebsd.org>
Cc:     Ed Maste <emaste@freebsd.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git fast-import crashing on big imports
Message-ID: <20170118215120.6hle2uxgkcvvtlox@sigill.intra.peff.net>
References: <20170112082138.GJ4426@acme.spoerlein.net>
 <20170118140117.GK4426@acme.spoerlein.net>
 <20170118143814.or34vxxwjwnzg5jz@sigill.intra.peff.net>
 <20170118200646.6larm2qu32xm73on@sigill.intra.peff.net>
 <CAJ9axoSzZJXD4RKvVx+D60dw4sakMJWgNmOP-cREWA53Ae3C3w@mail.gmail.com>
 <20170118202704.w6pjxfvnge7utk34@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170118202704.w6pjxfvnge7utk34@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 03:27:04PM -0500, Jeff King wrote:

> On Wed, Jan 18, 2017 at 09:20:07PM +0100, Ulrich Spörlein wrote:
> 
> > I found your commit via bisect in case you were wondering. Thanks for
> > picking this up.
> 
> Still downloading. However, just looking at the code, the obvious
> culprit would be clear_delta_base_cache(), which is called from
> literally nowhere except fast-import, and then only when checkpointing.

Hmm. I haven't reproduced your exact issue, but I was able to produce
some hijinks in that function.

The problem is that the hashmap_iter interface is unreliable if entries
are added or removed from the map during the iteration.

I suspect the patch below may fix things for you. It works around it by
walking over the lru list (either is fine, as they both contain all
entries, and since we're clearing everything, we don't care about the
order).

---
 sha1_file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1eb47f611..d20714d6b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2342,11 +2342,10 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 
 void clear_delta_base_cache(void)
 {
-	struct hashmap_iter iter;
-	struct delta_base_cache_entry *entry;
-	for (entry = hashmap_iter_first(&delta_base_cache, &iter);
-	     entry;
-	     entry = hashmap_iter_next(&iter)) {
+	struct list_head *lru, *tmp;
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *entry =
+			list_entry(lru, struct delta_base_cache_entry, lru);
 		release_delta_base_cache(entry);
 	}
 }
-- 
2.11.0.698.gd6b48ab4c




> 
> -Peff
