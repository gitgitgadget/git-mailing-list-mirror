Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A74DC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C0160F38
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhIOSiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:38:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:48482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhIOSh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:37:57 -0400
Received: (qmail 565 invoked by uid 109); 15 Sep 2021 18:36:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:36:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26931 invoked by uid 111); 15 Sep 2021 18:36:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:36:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 10/11] serve: reject commands used as capabilities
Message-ID: <YUI9NKMvGn/tsjW1@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
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
 t/t5701-git-serve.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index db5ecfed2d..b3fe9b5126 100644
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
index 2e51886def..3928424e1b 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -72,6 +72,27 @@ test_expect_success 'request invalid command' '
 	test_i18ngrep "invalid command" err
 '
 
+test_expect_success 'request capability as command' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=agent
+	object-format=$(test_oid algo)
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	grep invalid.command.*agent err
+'
+
+test_expect_success 'request command as capability' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	object-format=$(test_oid algo)
+	fetch
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	grep unknown.capability err
+'
+
 test_expect_success 'requested command is command=value' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs=whatever
-- 
2.33.0.917.g33ebf6a5f6

