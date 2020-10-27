Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EEC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DEF2071A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507815AbgJ0HgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:36:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:38314 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbgJ0HgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:36:03 -0400
Received: (qmail 14410 invoked by uid 109); 27 Oct 2020 07:36:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:36:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15169 invoked by uid 111); 27 Oct 2020 07:36:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:36:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:36:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] checkout-index: drop error message from empty --stage=all
Message-ID: <20201027073602.GA3794137@coredump.intra.peff.net>
References: <20201027073000.GA3651896@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027073000.GA3651896@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If checkout-index is given --stage=all for a specific path, it will try
to write stages 1-3 (if present) for that path to temporary files.
However, if the file is present only at stage 0, it writes nothing but
gives a confusing message:

  $ git checkout-index --stage=all -- Makefile
  git checkout-index: Makefile does not exist at stage 4

This is nonsense. There is no stage 4 (it's just an internal enum value
we use for "all"), and the documentation clearly states:

  Paths which only have a stage 0 entry will always be omitted from the
  output.

Here it's talking about the list of tempfiles written to stdout, but it
seems clear that this case was not meant to be an error. We even have a
test which covers it, but it only checks that the command reports an
exit code of 0, not its stderr. And it reports 0 only because of another
bug which fails to propagate errors (which will be fixed in a subsequent
patch).

So let's make the test more thorough. We'll also cover the case that we
found _no_ entry, not even a stage zero, which should still be an error.
However, because of the other bug, we'll have to mark this as expecting
failure for the moment.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c       |  8 ++++++++
 t/t2004-checkout-cache-temp.sh | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a854fd16e7..195165d8bd 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -79,6 +79,14 @@ static int checkout_file(const char *name, const char *prefix)
 		return errs > 0 ? -1 : 0;
 	}
 
+	/*
+	 * At this point we know we didn't try to check anything out. If it was
+	 * because we did find an entry but it was stage 0, that's not an
+	 * error.
+	 */
+	if (has_same_name && checkout_stage == CHECKOUT_ALL)
+		return 0;
+
 	if (!state.quiet) {
 		fprintf(stderr, "git checkout-index: %s ", name);
 		if (!has_same_name)
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index a12afe93f3..4308d698b9 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -88,9 +88,17 @@ test_expect_success 'checkout all stage 2 to temporary files' '
 	done
 '
 
+test_expect_failure 'checkout all stages of unknown path' '
+	rm -f path* .merge_* actual &&
+	test_must_fail git checkout-index --stage=all --temp \
+		-- does-not-exist 2>stderr &&
+	test_i18ngrep not.in.the.cache stderr
+'
+
 test_expect_success 'checkout all stages/one file to nothing' '
 	rm -f path* .merge_* actual &&
-	git checkout-index --stage=all --temp -- path0 >actual &&
+	git checkout-index --stage=all --temp -- path0 >actual 2>stderr &&
+	test_must_be_empty stderr &&
 	test_line_count = 0 actual
 '
 
-- 
2.29.1.634.g9e41dc1bf2

