Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFA31F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439295AbfJRE6x (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:58:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:51728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2436473AbfJRE6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:52 -0400
Received: (qmail 9473 invoked by uid 109); 18 Oct 2019 04:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:58:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14381 invoked by uid 111); 18 Oct 2019 05:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:01:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:58:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/23] fsck: only require an oid for skiplist functions
Message-ID: <20191018045851.GN17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The skiplist is inherently an oidset, so we don't need a full object
struct. Let's take just the oid to give our callers more flexibility.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index c036ba09ab..2309c40a11 100644
--- a/fsck.c
+++ b/fsck.c
@@ -277,9 +277,10 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 	strbuf_addstr(sb, ": ");
 }
 
-static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
+static int object_on_skiplist(struct fsck_options *opts,
+			      const struct object_id *oid)
 {
-	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
+	return opts && oid && oidset_contains(&opts->skiplist, oid);
 }
 
 __attribute__((format (printf, 4, 5)))
@@ -293,7 +294,7 @@ static int report(struct fsck_options *options, struct object *object,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, object))
+	if (object_on_skiplist(options, &object->oid))
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
@@ -935,7 +936,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 		return 0;
 	oidset_insert(&gitmodules_done, &blob->object.oid);
 
-	if (object_on_skiplist(options, &blob->object))
+	if (object_on_skiplist(options, &blob->object.oid))
 		return 0;
 
 	if (!buf) {
-- 
2.23.0.1228.gee29b05929

