Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783EEC433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD826105A
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhIOSiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:38:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:48492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhIOSiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:38:02 -0400
Received: (qmail 583 invoked by uid 109); 15 Sep 2021 18:36:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:36:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26939 invoked by uid 111); 15 Sep 2021 18:36:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:36:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:36:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 11/11] ls-refs: reject unknown arguments
Message-ID: <YUI9NmyHeCNw0+zz@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2 ls-refs command may receive extra arguments from the client, one
per pkt-line. The spec is pretty clear that the arguments must come from
a specified set, but we silently ignore any unknown entries. For a
well-behaved client this doesn't matter, but it makes testing and
debugging more confusing. Let's tighten this up to match the spec.

In theory this liberal behavior _could_ be useful for extending the
protocol. But:

  - every other part of the protocol requires that the server first
    indicate that it supports the argument; this includes the fetch and
    object-info commands, plus the "unborn" capability added to ls-refs
    itself

  - it's not a very good extension mechanism anyway; without the server
    advertising support, clients would have no idea if the argument was
    silently ignored, or accepted and simply had no effect

So we're not really losing anything by tightening this.

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c            |  2 ++
 t/t5701-git-serve.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/ls-refs.c b/ls-refs.c
index 18c4f41e87..460ac9b229 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -168,6 +168,8 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 		}
 		else if (!strcmp("unborn", arg))
 			data.unborn = allow_unborn;
+		else
+			die(_("unexpected line: '%s'"), arg);
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 3928424e1b..aa1827d841 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -147,6 +147,19 @@ test_expect_success 'basics of ls-refs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-refs complains about unknown options' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	object-format=$(test_oid algo)
+	0001
+	no-such-arg
+	0000
+	EOF
+
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	grep unexpected.line.*no-such-arg err
+'
+
 test_expect_success 'basic ref-prefixes' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
-- 
2.33.0.917.g33ebf6a5f6
