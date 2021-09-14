Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE38C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE55B60F21
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhINPe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:34:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:47024 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhINPe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 11:34:27 -0400
Received: (qmail 24322 invoked by uid 109); 14 Sep 2021 15:33:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 15:33:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24235 invoked by uid 111); 14 Sep 2021 15:33:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 11:33:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 11:33:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 5/9] serve: provide "receive" function for session-id
 capability
Message-ID: <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than pulling the session-id string from the list of collected
capabilities, we can handle it as soon as we receive it. This gets us
closer to dropping the collected list entirely.

The behavior should be the same, with one exception. Previously if the
client sent us multiple session-id lines, we'd report only the first.
Now we'll pass each one along to trace2. This shouldn't matter in
practice, since clients shouldn't do that (and if they do, it's probably
sensible to log them all).

As this removes the last caller of the static has_capability(), we can
remove it, as well (and in fact we must to avoid -Wunused-function
complaining).

Signed-off-by: Jeff King <peff@peff.net>
---
I had originally dropped has_capability() in a separate patch, to keep
this one more readable. That breaks bisectability, but only with
-Werror. I'm not sure where we should fall on that spectrum (I generally
bisect with -Wno-error just because warnings may come and go when
working with different compilers than what was normal at the time).

Not that big a deal either way for this patch, but I wonder if people
have opinions in general.

 serve.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/serve.c b/serve.c
index f6ea2953eb..6bbf54cbbe 100644
--- a/serve.c
+++ b/serve.c
@@ -57,6 +57,14 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
 	return 1;
 }
 
+static void session_id_receive(struct repository *r,
+			       const char *client_sid)
+{
+	if (!client_sid)
+		client_sid = "";
+	trace2_data_string("transfer", NULL, "client-sid", client_sid);
+}
+
 struct protocol_capability {
 	/*
 	 * The name of the capability.  The server uses this name when
@@ -121,6 +129,7 @@ static struct protocol_capability capabilities[] = {
 	{
 		.name = "session-id",
 		.advertise = session_id_advertise,
+		.receive = session_id_receive,
 	},
 	{
 		.name = "object-info",
@@ -221,26 +230,6 @@ static int parse_command(const char *key, struct protocol_capability **command)
 	return 0;
 }
 
-static int has_capability(const struct strvec *keys, const char *capability,
-			  const char **value)
-{
-	int i;
-	for (i = 0; i < keys->nr; i++) {
-		const char *out;
-		if (skip_prefix(keys->v[i], capability, &out) &&
-		    (!*out || *out == '=')) {
-			if (value) {
-				if (*out == '=')
-					out++;
-				*value = out;
-			}
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 enum request_state {
 	PROCESS_REQUEST_KEYS,
 	PROCESS_REQUEST_DONE,
@@ -252,7 +241,6 @@ static int process_request(void)
 	struct packet_reader reader;
 	struct strvec keys = STRVEC_INIT;
 	struct protocol_capability *command = NULL;
-	const char *client_sid;
 
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -319,9 +307,6 @@ static int process_request(void)
 		    the_repository->hash_algo->name,
 		    hash_algos[client_hash_algo].name);
 
-	if (has_capability(&keys, "session-id", &client_sid))
-		trace2_data_string("transfer", NULL, "client-sid", client_sid);
-
 	command->command(the_repository, &reader);
 
 	strvec_clear(&keys);
-- 
2.33.0.887.g5b1f44e68d

