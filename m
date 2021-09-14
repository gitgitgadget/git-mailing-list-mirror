Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B381BC433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C3860F36
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhINPik (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:38:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:47036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhINPij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 11:38:39 -0400
Received: (qmail 24345 invoked by uid 109); 14 Sep 2021 15:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 15:37:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24288 invoked by uid 111); 14 Sep 2021 15:37:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 11:37:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 11:37:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 8/9] serve: reject bogus v2 "command=ls-refs=foo"
Message-ID: <YUDBsdTeX8myV1vY@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see a line from the client like "command=ls-refs", we parse
everything after the equals sign as a capability, which we check against
our capabilities table. If we don't recognize the command (e.g.,
"command=foo"), we'll reject it. But we use the same parser that checks
for regular capabilities like "object-format=sha256". And so we'll
accept "ls-refs=foo", even though everything after the equals is bogus,
and simply ignored.

This isn't really hurting anything, but the request does violate the
spec. Let's tighten it up to prevent any surprising behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c              |  2 +-
 t/t5701-git-serve.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index baa0a17502..123abbaa83 100644
--- a/serve.c
+++ b/serve.c
@@ -220,7 +220,7 @@ static int parse_command(const char *key, struct protocol_capability **command)
 		if (*command)
 			die("command '%s' requested after already requesting command '%s'",
 			    out, (*command)->name);
-		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
+		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command || value)
 			die("invalid command '%s'", out);
 
 		*command = cmd;
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index b095bfa0ac..ebb41657ab 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -72,6 +72,16 @@ test_expect_success 'request invalid command' '
 	test_i18ngrep "invalid command" err
 '
 
+test_expect_success 'requested command is command=value' '
+	test-tool pkt-line pack >in <<-\EOF &&
+	command=ls-refs=whatever
+	object-format=$(test_oid algo)
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	grep invalid.command.*ls-refs=whatever err
+'
+
 test_expect_success 'wrong object-format' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
-- 
2.33.0.887.g5b1f44e68d

