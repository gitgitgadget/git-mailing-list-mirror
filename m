Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A32EC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBXGi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBXGiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:38:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BB01814B
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:38:24 -0800 (PST)
Received: (qmail 3663 invoked by uid 109); 24 Feb 2023 06:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31087 invoked by uid 111); 24 Feb 2023 06:38:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:38:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:38:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/21] serve: mark unused parameters in virtual functions
Message-ID: <Y/hbXxnWeK5DxAXU@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each v2 "serve" action has a virtual function for advertising and
implementing the command. A few of these are so trivial that they don't
need to look at their parameters, especially the "repository" parameter.
We can mark them so that -Wunused-parameter doesn't complain.

Note that upload_pack_v2() probably _should_ be using its repository
pointer. But teaching the functions it calls to do so is non-trivial.
Even using it for something as simple as reading config is tricky, both
because it shares code with the v1 upload pack, and because the
git_protected_config() mechanism it uses does not have a repo-specific
interface. So we'll just annotate it for now, and cleaning it up can be
part of the larger work to drop references to the_repository.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c       | 10 +++++-----
 upload-pack.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 2ccc03c16b..e08a980083 100644
--- a/serve.c
+++ b/serve.c
@@ -12,13 +12,13 @@
 static int advertise_sid = -1;
 static int client_hash_algo = GIT_HASH_SHA1;
 
-static int always_advertise(struct repository *r,
-			    struct strbuf *value)
+static int always_advertise(struct repository *r UNUSED,
+			    struct strbuf *value UNUSED)
 {
 	return 1;
 }
 
-static int agent_advertise(struct repository *r,
+static int agent_advertise(struct repository *r UNUSED,
 			   struct strbuf *value)
 {
 	if (value)
@@ -34,7 +34,7 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
-static void object_format_receive(struct repository *r,
+static void object_format_receive(struct repository *r UNUSED,
 				  const char *algo_name)
 {
 	if (!algo_name)
@@ -57,7 +57,7 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
 	return 1;
 }
 
-static void session_id_receive(struct repository *r,
+static void session_id_receive(struct repository *r UNUSED,
 			       const char *client_sid)
 {
 	if (!client_sid)
diff --git a/upload-pack.c b/upload-pack.c
index bcb702a5ba..f6f4da0fef 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1699,7 +1699,7 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r, struct packet_reader *request)
+int upload_pack_v2(struct repository *r UNUSED, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
-- 
2.39.2.981.g6157336f25

