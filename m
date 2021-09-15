Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCFDC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFC660F38
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhIOShP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:37:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:48446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhIOSgz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:55 -0400
Received: (qmail 511 invoked by uid 109); 15 Sep 2021 18:35:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:35:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26896 invoked by uid 111); 15 Sep 2021 18:35:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:35:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:35:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 07/11] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUI88/ok92tZ+JNo@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because each "ref-prefix" capability from the client comes in its own
pkt-line, there's no limit to the number of them that a misbehaving
client may send. We read them all into a strvec, which means the client
can waste arbitrary amounts of our memory by just sending us "ref-prefix
foo" over and over.

One possible solution is to just drop the connection when the limit is
reached. If we set it high enough, then only misbehaving or malicious
clients would hit it. But "high enough" is vague, and it's unfriendly if
we guess wrong and a legitimate client hits this.

But we can do better. Since supporting the ref-prefix capability is
optional anyway, the client has to further cull the response based on
their own patterns. So we can simply ignore the patterns once we cross a
certain threshold. Note that we have to ignore _all_ patterns, not just
the ones past our limit (since otherwise we'd send too little data).

The limit here is fairly arbitrary, and probably much higher than anyone
would need in practice. It might be worth limiting it further, if only
because we check it linearly (so with "m" local refs and "n" patterns,
we do "m * n" string comparisons). But if we care about optimizing this,
an even better solution may be a more advanced data structure anyway.

I didn't bother making the limit configurable, since it's so high and
since Git should behave correctly in either case. It wouldn't be too
hard to do, but it makes both the code and documentation more complex.

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c            | 20 ++++++++++++++++++--
 t/t5701-git-serve.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index a1a0250607..18c4f41e87 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -40,6 +40,12 @@ static void ensure_config_read(void)
 	config_read = 1;
 }
 
+/*
+ * If we see this many or more "ref-prefix" lines from the client, we consider
+ * it "too many" and will avoid using the prefix feature entirely.
+ */
+#define TOO_MANY_PREFIXES 65536
+
 /*
  * Check if one of the prefixes is a prefix of the ref.
  * If no prefixes were provided, all refs match.
@@ -156,15 +162,25 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 			data.peel = 1;
 		else if (!strcmp("symrefs", arg))
 			data.symrefs = 1;
-		else if (skip_prefix(arg, "ref-prefix ", &out))
-			strvec_push(&data.prefixes, out);
+		else if (skip_prefix(arg, "ref-prefix ", &out)) {
+			if (data.prefixes.nr < TOO_MANY_PREFIXES)
+				strvec_push(&data.prefixes, out);
+		}
 		else if (!strcmp("unborn", arg))
 			data.unborn = allow_unborn;
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ls-refs arguments"));
 
+	/*
+	 * If we saw too many prefixes, we must avoid using them at all; as
+	 * soon as we have any prefix, they are meant to form a comprehensive
+	 * list.
+	 */
+	if (data.prefixes.nr >= TOO_MANY_PREFIXES)
+		strvec_clear(&data.prefixes);
+
 	send_possibly_unborn_head(&data);
 	if (!data.prefixes.nr)
 		strvec_push(&data.prefixes, "");
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 930721f053..520672f842 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -158,6 +158,37 @@ test_expect_success 'refs/heads prefix' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ignore very large set of prefixes' '
+	# generate a large number of ref-prefixes that we expect
+	# to match nothing; the value here exceeds TOO_MANY_PREFIXES
+	# from ls-refs.c.
+	{
+		echo command=ls-refs &&
+		echo object-format=$(test_oid algo) &&
+		echo 0001 &&
+		perl -le "print \"ref-prefix refs/heads/\$_\" for (1..65536)" &&
+		echo 0000
+	} |
+	test-tool pkt-line pack >in &&
+
+	# and then confirm that we see unmatched prefixes anyway (i.e.,
+	# that the prefix was not applied).
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse refs/heads/dev) refs/heads/dev
+	$(git rev-parse refs/heads/main) refs/heads/main
+	$(git rev-parse refs/heads/release) refs/heads/release
+	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
+	$(git rev-parse refs/tags/one) refs/tags/one
+	$(git rev-parse refs/tags/two) refs/tags/two
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'peel parameter' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
-- 
2.33.0.917.g33ebf6a5f6

