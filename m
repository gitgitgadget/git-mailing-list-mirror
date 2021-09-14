Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A70C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5DE6113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhINXyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:54:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:47662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235966AbhINXyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:54:06 -0400
Received: (qmail 28683 invoked by uid 109); 14 Sep 2021 23:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 23:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30687 invoked by uid 111); 14 Sep 2021 23:52:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 19:52:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 19:52:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 10/11] serve: reject commands used as capabilities
Message-ID: <YUE1zZ+DXBET15VS@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our table of v2 "capabilities" contains everything we might tell the
client we support. But there are differences in how we expect the client
to respond. Some of the entries are true capabilities (i.e., we expect
the client to say "yes, I support this"), and some are ones we expect
them to send as commands (with "command=ls-refs" or similar).

When we receive a capability used as a command, we complain about that.
But when we receive a command used as a capability (e.g., just "ls-refs"
in a pkt-line by itself), we silently ignore it.

This isn't really hurting anything (clients shouldn't send it, and we'll
ignore it), but we can tighten up the protocol to match what we expect
to happen.

There are two new tests here. The first one checks a capability used as
a command, which already passes. The second tests a command as a
capability, which this patch fixes.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c              |  2 +-
 t/t5701-git-serve.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 63ee1be7ff..0636b79f92 100644
--- a/serve.c
+++ b/serve.c
@@ -201,7 +201,7 @@ static int receive_client_capability(const char *key)
 	const char *value;
 	const struct protocol_capability *c = get_capability(key, &value);
 
-	if (!c || !c->advertise(the_repository, NULL))
+	if (!c || c->command || !c->advertise(the_repository, NULL))
 		return 0;
 
 	if (c->receive)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index ab15078bc0..b027ba9b06 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -72,6 +72,25 @@ test_expect_success 'request invalid command' '
 	test_i18ngrep "invalid command" err
 '
 
+test_expect_success 'request capability as command' '
+	test-tool pkt-line pack >in <<-\EOF &&
+	command=agent
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	grep invalid.command.*agent err
+'
+
+test_expect_success 'request command as capability' '
+	test-tool pkt-line pack >in <<-\EOF &&
+	command=ls-refs
+	fetch
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	grep unknown.capability err
+'
+
 test_expect_success 'requested command is command=value' '
 	test-tool pkt-line pack >in <<-\EOF &&
 	command=ls-refs=whatever
-- 
2.33.0.917.gae6ecbedc7

