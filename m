Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E2C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCQTR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCQTRW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:17:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE3E2517
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:17:09 -0700 (PDT)
Received: (qmail 25996 invoked by uid 109); 17 Mar 2023 19:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 19:17:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27514 invoked by uid 111); 17 Mar 2023 19:17:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 15:17:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 15:17:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] http: mark unused parameter in fill_active_slot()
 callbacks
Message-ID: <ZBS8tD4KjwQ8aYov@coredump.intra.peff.net>
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a generic "fill" function that is used by both the dumb http
push and fetch code paths. It takes a void parameter in case the caller
wants to pass along extra data, but (since the previous commit) neither
does so.

So we could simply drop the extra parameter. But since it's good
practice to provide a void pointer for in callback functions, we'll
leave it here for the future, and just annotate it as unused (to appease
-Wunused-parameter).

While we're marking it, let's also fix the type in http-walker's
function to have the correct "void" type. The original had to cast the
function pointer and was technically undefined behavior (though
generally OK in practice).

Signed-off-by: Jeff King <peff@peff.net>
---
Every time I touch these files I dream of just deleting all of the
dumb-http completely.

 http-push.c   | 2 +-
 http-walker.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7f71316456c..8eaba6ddf0a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -601,7 +601,7 @@ static void finish_request(struct transfer_request *request)
 }
 
 static int is_running_queue;
-static int fill_active_slot(void *unused)
+static int fill_active_slot(void *data UNUSED)
 {
 	struct transfer_request *request;
 
diff --git a/http-walker.c b/http-walker.c
index 6b9bdb529b5..32369aa2d74 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -126,7 +126,7 @@ static void release_object_request(struct object_request *obj_req)
 	free(obj_req);
 }
 
-static int fill_active_slot(struct walker *walker)
+static int fill_active_slot(void *data UNUSED)
 {
 	struct object_request *obj_req;
 	struct list_head *pos, *tmp, *head = &object_queue_head;
@@ -612,7 +612,7 @@ struct walker *get_http_walker(const char *url)
 	walker->cleanup = cleanup;
 	walker->data = data;
 
-	add_fill_function(walker, (int (*)(void *)) fill_active_slot);
+	add_fill_function(NULL, fill_active_slot);
 
 	return walker;
 }
-- 
2.40.0.581.g8d688c70eca

