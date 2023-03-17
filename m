Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F8C7618A
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCQTRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCQTRM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:17:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4CDE41FB
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:16:44 -0700 (PDT)
Received: (qmail 25990 invoked by uid 109); 17 Mar 2023 19:16:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 19:16:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27508 invoked by uid 111); 17 Mar 2023 19:16:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 15:16:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 15:16:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] http: drop unused parameter from start_object_request()
Message-ID: <ZBS8kqjaq2DIZMEG@coredump.intra.peff.net>
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We take a "walker" parameter for the request, but don't actually look at
it. This is due to 5424bc557f (http*: add helper methods for fetching
objects (loose), 2009-06-06). Before then, we consulted the "walker"
struct to tell us if we should be verbose, but now those messages are
printed elsewhere.

Let's drop the unused parameter to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index b8f0f98ae14..6b9bdb529b5 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -52,8 +52,7 @@ static void fetch_alternates(struct walker *walker, const char *base);
 
 static void process_object_response(void *callback_data);
 
-static void start_object_request(struct walker *walker,
-				 struct object_request *obj_req)
+static void start_object_request(struct object_request *obj_req)
 {
 	struct active_request_slot *slot;
 	struct http_object_request *req;
@@ -110,7 +109,7 @@ static void process_object_response(void *callback_data)
 			obj_req->repo =
 				obj_req->repo->next;
 			release_http_object_request(obj_req->req);
-			start_object_request(walker, obj_req);
+			start_object_request(obj_req);
 			return;
 		}
 	}
@@ -138,7 +137,7 @@ static int fill_active_slot(struct walker *walker)
 			if (has_object_file(&obj_req->oid))
 				obj_req->state = COMPLETE;
 			else {
-				start_object_request(walker, obj_req);
+				start_object_request(obj_req);
 				return 1;
 			}
 		}
-- 
2.40.0.581.g8d688c70eca

