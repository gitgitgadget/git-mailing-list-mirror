Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C1E1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdFETP1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 15:15:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:35024 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751181AbdFETP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 15:15:27 -0400
Received: (qmail 32133 invoked by uid 109); 5 Jun 2017 19:15:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 19:15:27 +0000
Received: (qmail 17203 invoked by uid 111); 5 Jun 2017 19:16:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 15:16:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jun 2017 15:15:25 -0400
Date:   Mon, 5 Jun 2017 15:15:25 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t5313: make extended-table test more deterministic
Message-ID: <20170605191525.666opa3se7gabdbv@sigill.intra.peff.net>
References: <20170605185601.yzbq5e6r2tfbgzqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170605185601.yzbq5e6r2tfbgzqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit a1283866b (t5313: test bounds-checks of
corrupted/malicious pack/idx files, 2016-02-25) added a test
that requires our corrupted pack index to have two objects.
The entry for the first one remains untouched, but we
corrupt the entry for second one. Since the index stores the
entries in sha1-sorted order, this means that the test must
make sure that the sha1 of the object we expect to be
corrupted ("$object") sorts after the other placeholder
object.

That commit used the HEAD commit as the placeholder, but the
script never calls test_tick. That means that the commit
object (and thus its sha1) depends on the timestamp when the
test script is run. This usually works in practice, because
the sha1 of $object starts with "fff". The commit object
will sort after that only 1 in 4096 times, but when it does
the test will fail.

One obvious solution is to add the test_tick call to get a
deterministic commit sha1. But since we're relying on the
sort order for the test to function, let's make that very
explicit by just generating a second blob with a known sha1.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5313-pack-bounds-checks.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index a8a587abc..9372508c9 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -139,7 +139,13 @@ test_expect_success 'bogus offset into v2 extended table' '
 test_expect_success 'bogus offset inside v2 extended table' '
 	# We need two objects here, so we can plausibly require
 	# an extended table (if the first object were larger than 2^31).
-	do_pack "$object $(git rev-parse HEAD)" --index-version=2 &&
+	#
+	# Note that the value is important here. We want $object as
+	# the second entry in sorted-sha1 order. The sha1 of 1485 starts
+	# with "000", which sorts before that of $object (which starts
+	# with "fff").
+	second=$(echo 1485 | git hash-object -w --stdin) &&
+	do_pack "$object $second" --index-version=2 &&
 
 	# We have to make extra room for the table, so we cannot
 	# just munge in place as usual.
-- 
2.13.1.662.g6e89c999d
