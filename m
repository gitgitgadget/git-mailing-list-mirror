Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3247203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 09:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbcHKJZh (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 05:25:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:53520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752443AbcHKJZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 05:25:36 -0400
Received: (qmail 462 invoked by uid 109); 11 Aug 2016 09:25:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 09:25:34 +0000
Received: (qmail 8353 invoked by uid 111); 11 Aug 2016 09:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 05:25:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 05:25:32 -0400
Date:	Thu, 11 Aug 2016 05:25:32 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 2/4] sha1_file: make packed_object_info public
Message-ID: <20160811092531.5iudoerqgwej7fq4@sigill.intra.peff.net>
References: <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some code may have a pack/offset pair for an object, but
would like to look up more information. Using
sha1_object_info() is too heavy-weight; it starts from the
sha1 and has to find the pack again (so not only does it waste
time, it might not even find the same instance).

In some cases, this problem is solved by helpers like
get_size_from_delta(), which is used by pack-objects to take
a shortcut for objects whose packed representation has
already been found. But there's no similar function for
getting the object type, for instance. Rather than introduce
one, let's just make the whole packed_object_info() available.
It is smart enough to spend effort only on the items the
caller wants.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 1 +
 sha1_file.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index b2e4969..f23968e 100644
--- a/cache.h
+++ b/cache.h
@@ -1558,6 +1558,7 @@ struct object_info {
 #define OBJECT_INFO_INIT {NULL}
 
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
+extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index b8cc76b..5ca0ffa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1970,8 +1970,8 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 	goto out;
 }
 
-static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      struct object_info *oi)
+int packed_object_info(struct packed_git *p, off_t obj_offset,
+		       struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
-- 
2.9.2.790.gaa5bc72

