Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFFEC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C6960F38
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhIOSgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:36:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:48404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhIOSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:45 -0400
Received: (qmail 453 invoked by uid 109); 15 Sep 2021 18:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:35:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26872 invoked by uid 111); 15 Sep 2021 18:35:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:35:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:35:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 04/11] serve: provide "receive" function for object-format
 capability
Message-ID: <YUI864c4ubcMQyOj@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We get any "object-format" specified by the client by searching for it
in the collected list of capabilities the client sent. We can instead
just handle it as soon as they send it. This is slightly more efficient,
and gets us one step closer to dropping that collected list.

Note that we do still have to do our final hash check after receiving
all capabilities (because they might not have sent an object-format line
at all, and we still have to check that the default matches our
repository algorithm). Since the check_algorithm() function would now be
down to a single if() statement, I've just inlined it in its only
caller.

There should be no change of behavior here, except for two
broken-protocol cases:

  - if the client sends multiple conflicting object-format capabilities
    (which they should not), we'll now choose the last one rather than
    the first. We could also detect and complain about the duplicates
    quite easily now, which we could not before, but I didn't do so
    here.

  - if the client sends a bogus "object-format" with no equals sign,
    we'll now say so, rather than "unknown object format: ''"

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/serve.c b/serve.c
index a161189984..f6ea2953eb 100644
--- a/serve.c
+++ b/serve.c
@@ -10,6 +10,7 @@
 #include "upload-pack.h"
 
 static int advertise_sid = -1;
+static int client_hash_algo = GIT_HASH_SHA1;
 
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
@@ -33,6 +34,17 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
+static void object_format_receive(struct repository *r,
+				  const char *algo_name)
+{
+	if (!algo_name)
+		die("object-format capability requires an argument");
+
+	client_hash_algo = hash_algo_by_name(algo_name);
+	if (client_hash_algo == GIT_HASH_UNKNOWN)
+		die("unknown object format '%s'", algo_name);
+}
+
 static int session_id_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_sid == -1 &&
@@ -104,6 +116,7 @@ static struct protocol_capability capabilities[] = {
 	{
 		.name = "object-format",
 		.advertise = object_format_advertise,
+		.receive = object_format_receive,
 	},
 	{
 		.name = "session-id",
@@ -228,22 +241,6 @@ static int has_capability(const struct strvec *keys, const char *capability,
 	return 0;
 }
 
-static void check_algorithm(struct repository *r, struct strvec *keys)
-{
-	int client = GIT_HASH_SHA1, server = hash_algo_by_ptr(r->hash_algo);
-	const char *algo_name;
-
-	if (has_capability(keys, "object-format", &algo_name)) {
-		client = hash_algo_by_name(algo_name);
-		if (client == GIT_HASH_UNKNOWN)
-			die("unknown object format '%s'", algo_name);
-	}
-
-	if (client != server)
-		die("mismatched object format: server %s; client %s\n",
-		    r->hash_algo->name, hash_algos[client].name);
-}
-
 enum request_state {
 	PROCESS_REQUEST_KEYS,
 	PROCESS_REQUEST_DONE,
@@ -317,7 +314,10 @@ static int process_request(void)
 	if (!command)
 		die("no command requested");
 
-	check_algorithm(the_repository, &keys);
+	if (client_hash_algo != hash_algo_by_ptr(the_repository->hash_algo))
+		die("mismatched object format: server %s; client %s\n",
+		    the_repository->hash_algo->name,
+		    hash_algos[client_hash_algo].name);
 
 	if (has_capability(&keys, "session-id", &client_sid))
 		trace2_data_string("transfer", NULL, "client-sid", client_sid);
-- 
2.33.0.917.g33ebf6a5f6

