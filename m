Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC19C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC060F38
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhIOSh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:37:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:48468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhIOShz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:37:55 -0400
Received: (qmail 547 invoked by uid 109); 15 Sep 2021 18:36:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:36:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26923 invoked by uid 111); 15 Sep 2021 18:36:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:36:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:36:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 09/11] serve: reject bogus v2 "command=ls-refs=foo"
Message-ID: <YUI9MRXNAFxzVoA3@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see a line from the client like "command=ls-refs", we parse
everything after the equals sign as a capability, which we check against
our capabilities table. If we don't recognize the command (e.g.,
"command=foo"), we'll reject it.

But in parse_command(), we use the same get_capability() parser for
parsing non-command lines. So if we see "command=ls-refs=foo", we will
feed "ls-refs=foo" to get_capability(), which will say "OK, that's
ls-refs, with value 'foo'". But then we simply ignore the value
entirely.

The client is violating the spec here, which says:

      command = PKT-LINE("command=" key LF)
      key = 1*(ALPHA | DIGIT | "-_")

I.e., the key is not even allowed to have an equals sign in it. Whereas
a real non-command capability does allow a value:

      capability = PKT-LINE(key[=value] LF)

So by reusing the same get_capability() parser, we are mixing up the
"key" and "capability" tokens. However, since that parser tells us
whether it saw an "=", we can still use it; we just need to reject any
input that produces a non-NULL value field.

The current behavior isn't really hurting anything (the client should
never send such a request, and if it does, we just ignore the "value"
part). But since it does violate the spec, let's tighten it up to
prevent any surprising behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c              |  2 +-
 t/t5701-git-serve.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 1a7c8a118f..db5ecfed2d 100644
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
index 520672f842..2e51886def 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -72,6 +72,16 @@ test_expect_success 'request invalid command' '
 	test_i18ngrep "invalid command" err
 '
 
+test_expect_success 'requested command is command=value' '
+	test-tool pkt-line pack >in <<-EOF &&
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
2.33.0.917.g33ebf6a5f6

