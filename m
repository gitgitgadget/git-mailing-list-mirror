Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE67C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B866113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhINPcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:32:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:47012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234167AbhINPcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 11:32:08 -0400
Received: (qmail 24303 invoked by uid 109); 14 Sep 2021 15:30:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 15:30:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24223 invoked by uid 111); 14 Sep 2021 15:30:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 11:30:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 11:30:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/9] serve: return capability "value" from get_capability()
Message-ID: <YUDAKg0g9dLf5014@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the client sends v2 capabilities, they may be simple, like:

  foo

or have a value like:

  foo=bar

(all of the current capabilities actually expect a value, but the
protocol allows for boolean ones).

We use get_capability() to make sure the client's pktline matches a
capability. In doing so, we parse enough to see the "=" and the value
(if any), but we immediately forget it. Nobody cares for now, because they end
up parsing the values out later using has_capability(). But in
preparation for changing that, let's pass back a pointer so the callers
know what we found.

Note that unlike has_capability(), we'll return NULL for a "simple"
capability. Distinguishing these will be useful for some future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
We get rid of has_capability() later, so the inconsistency in return
types will go away.

 serve.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/serve.c b/serve.c
index fd88b95343..78a4e83554 100644
--- a/serve.c
+++ b/serve.c
@@ -139,7 +139,7 @@ void protocol_v2_advertise_capabilities(void)
 	strbuf_release(&value);
 }
 
-static struct protocol_capability *get_capability(const char *key)
+static struct protocol_capability *get_capability(const char *key, const char **value)
 {
 	int i;
 
@@ -149,16 +149,25 @@ static struct protocol_capability *get_capability(const char *key)
 	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 		const char *out;
-		if (skip_prefix(key, c->name, &out) && (!*out || *out == '='))
+		if (!skip_prefix(key, c->name, &out))
+			continue;
+		if (!*out) {
+			*value = NULL;
 			return c;
+		}
+		if (*out++ == '=') {
+			*value = out;
+			return c;
+		}
 	}
 
 	return NULL;
 }
 
 static int is_valid_capability(const char *key)
 {
-	const struct protocol_capability *c = get_capability(key);
+	const char *value;
+	const struct protocol_capability *c = get_capability(key, &value);
 
 	return c && c->advertise(the_repository, NULL);
 }
@@ -168,7 +177,8 @@ static int parse_command(const char *key, struct protocol_capability **command)
 	const char *out;
 
 	if (skip_prefix(key, "command=", &out)) {
-		struct protocol_capability *cmd = get_capability(out);
+		const char *value;
+		struct protocol_capability *cmd = get_capability(out, &value);
 
 		if (*command)
 			die("command '%s' requested after already requesting command '%s'",
-- 
2.33.0.887.g5b1f44e68d

