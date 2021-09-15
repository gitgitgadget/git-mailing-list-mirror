Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AAEC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33CA60F38
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhIOShE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:37:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:48434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhIOSgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:51 -0400
Received: (qmail 493 invoked by uid 109); 15 Sep 2021 18:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:35:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26888 invoked by uid 111); 15 Sep 2021 18:35:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:35:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:35:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 06/11] serve: drop "keys" strvec
Message-ID: <YUI88Zu5UydDxLre@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We collect the set of capabilities the client sends us in a strvec.
While this is usually small, there's no limit to the number of
capabilities the client can send us (e.g., they could just send us
"agent" pkt-lines over and over, and we'd keep adding them to the list).

Since all code has been converted away from using this list, let's get
rid of it. This avoids a potential attack where clients waste our
memory.

Note that we do have to replace it with a flag, because some of the
flush-packet logic checks whether we've seen any valid commands or keys.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/serve.c b/serve.c
index 6bbf54cbbe..1a7c8a118f 100644
--- a/serve.c
+++ b/serve.c
@@ -239,7 +239,7 @@ static int process_request(void)
 {
 	enum request_state state = PROCESS_REQUEST_KEYS;
 	struct packet_reader reader;
-	struct strvec keys = STRVEC_INIT;
+	int seen_capability_or_command = 0;
 	struct protocol_capability *command = NULL;
 
 	packet_reader_init(&reader, 0, NULL, 0,
@@ -260,10 +260,9 @@ static int process_request(void)
 		case PACKET_READ_EOF:
 			BUG("Should have already died when seeing EOF");
 		case PACKET_READ_NORMAL:
-			/* collect request; a sequence of keys and values */
 			if (parse_command(reader.line, &command) ||
 			    receive_client_capability(reader.line))
-				strvec_push(&keys, reader.line);
+				seen_capability_or_command = 1;
 			else
 				die("unknown capability '%s'", reader.line);
 
@@ -275,7 +274,7 @@ static int process_request(void)
 			 * If no command and no keys were given then the client
 			 * wanted to terminate the connection.
 			 */
-			if (!keys.nr)
+			if (!seen_capability_or_command)
 				return 1;
 
 			/*
@@ -309,7 +308,6 @@ static int process_request(void)
 
 	command->command(the_repository, &reader);
 
-	strvec_clear(&keys);
 	return 0;
 }
 
-- 
2.33.0.917.g33ebf6a5f6

