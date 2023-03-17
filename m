Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C08C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCQTRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCQTR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:17:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F21C7F2
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:17:20 -0700 (PDT)
Received: (qmail 25999 invoked by uid 109); 17 Mar 2023 19:17:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 19:17:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27517 invoked by uid 111); 17 Mar 2023 19:17:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 15:17:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 15:17:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] transport: mark unused parameters in
 fetch_refs_from_bundle()
Message-ID: <ZBS8vt97YJj3wMxn@coredump.intra.peff.net>
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't look at the "to_fetch" or "nr_heads" parameters at all. At
first glance this seems like a bug (or at least pessimisation), because
it means we fetch more objects from the bundle than we actually need.
But the bundle does not have any way of computing the set of reachable
objects itself (we'd have to pull all of the objects out to walk them).
And anyway, we've probably already paid most of the cost of grabbing the
objects, since we must copy the bundle locally before accessing it.

So it's perfectly reasonable for the bundle code to just pull everything
into the local object store. Unneeded objects can be dropped later via
gc, etc.

But we should mark these unused parameters as such to avoid the wrath of
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 81950bf755f..c5abf26f31e 100644
--- a/transport.c
+++ b/transport.c
@@ -167,7 +167,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+				  int nr_heads UNUSED,
+				  struct ref **to_fetch UNUSED)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
-- 
2.40.0.581.g8d688c70eca
