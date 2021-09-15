Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CEC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB85060F38
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhIOSgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:36:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhIOSgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:44 -0400
Received: (qmail 435 invoked by uid 109); 15 Sep 2021 18:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26864 invoked by uid 111); 15 Sep 2021 18:35:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:35:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:35:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 03/11] serve: add "receive" method for v2 capabilities
 table
Message-ID: <YUI85uvjn+7LB5gN@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a capabilities table that tells us what we should tell the
client we are capable of, and what to do when a client gives us a
particular command (e.g., "command=ls-refs"). But it doesn't tell us
what to do when the client sends us back a capability (e.g.,
"object-format=sha256"). We just collect them all in a strvec and hope
somebody can use them later.

Instead, let's provide a function pointer in the table to act on these.
This will eventually help us avoid collecting the strings, which will be
more efficient and less prone to mischief.

Using the new method is optional, which helps in two ways:

  - we can move existing capabilities over to this new system gradually
    in individual commits

  - some capabilities we don't actually do anything with anyway. For
    example, the client is free to say "agent=git/1.2.3" to us, but we
    do not act on the information in any way.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index 78a4e83554..a161189984 100644
--- a/serve.c
+++ b/serve.c
@@ -70,6 +70,16 @@ struct protocol_capability {
 	 * This field should be NULL for capabilities which are not commands.
 	 */
 	int (*command)(struct repository *r, struct packet_reader *request);
+
+	/*
+	 * Function called when a client requests the capability as a
+	 * non-command. This may be NULL if the capability does nothing.
+	 *
+	 * For a capability of the form "foo=bar", the value string points to
+	 * the content after the "=" (i.e., "bar"). For simple capabilities
+	 * (just "foo"), it is NULL.
+	 */
+	void (*receive)(struct repository *r, const char *value);
 };
 
 static struct protocol_capability capabilities[] = {
@@ -164,12 +174,17 @@ static struct protocol_capability *get_capability(const char *key, const char **
 	return NULL;
 }
 
-static int is_valid_capability(const char *key)
+static int receive_client_capability(const char *key)
 {
 	const char *value;
 	const struct protocol_capability *c = get_capability(key, &value);
 
-	return c && c->advertise(the_repository, NULL);
+	if (!c || !c->advertise(the_repository, NULL))
+		return 0;
+
+	if (c->receive)
+		c->receive(the_repository, value);
+	return 1;
 }
 
 static int parse_command(const char *key, struct protocol_capability **command)
@@ -262,7 +277,7 @@ static int process_request(void)
 		case PACKET_READ_NORMAL:
 			/* collect request; a sequence of keys and values */
 			if (parse_command(reader.line, &command) ||
-			    is_valid_capability(reader.line))
+			    receive_client_capability(reader.line))
 				strvec_push(&keys, reader.line);
 			else
 				die("unknown capability '%s'", reader.line);
-- 
2.33.0.917.g33ebf6a5f6

