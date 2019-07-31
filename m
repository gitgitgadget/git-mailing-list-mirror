Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4EB1F462
	for <e@80x24.org>; Wed, 31 Jul 2019 01:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGaBXi (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 21:23:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:56254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727491AbfGaBXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 21:23:38 -0400
Received: (qmail 10195 invoked by uid 109); 31 Jul 2019 01:23:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 01:23:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12543 invoked by uid 111); 31 Jul 2019 01:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 21:25:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 21:23:37 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731012336.GA13880@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731005933.GA9610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 08:59:33PM -0400, Jeff King wrote:

> > OTOH, this is not just any hashmap, but an oidmap, and I could imagine
> > that there might be use cases where it would be beneficial if the
> > iteration order were to match the oid order (but don't know whether we
> > actually have such a use case).
> 
> I don't think we can promise anything about iteration order. This test
> is relying on the order at least being deterministic between runs, but
> if we added a new entry and had to grow the table, all bets are off.
> 
> So regardless of the endian thing above, it probably does make sense for
> any hashmap iteration output to be sorted before comparing. That goes
> for t0011, too; it doesn't have this endian thing, but it looks to be
> relying on hash order that could change if we swapped out hash
> functions.

So here's an actual patch.

-- >8 --
Subject: [PATCH] t: sort output of hashmap iteration

The iteration order of a hashmap is undefined, and may depend on things
like the exact set of items added, or the table has been grown or
shrunk. In the case of an oidmap, it even depends on endianness, because
we take the oid hash by casting sha1 bytes directly into an unsigned
int.

Let's sort the test-tool output from any hash iterators. In the case of
t0011, this is just future-proofing. But for t0016, it actually fixes a
reported failure on the big-endian s390 and nonstop ports.

I didn't bother to teach the helper functions to optionally sort output.
They are short enough that it's simpler to just repeat them inline for
the iteration tests than it is to add a --sort option.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0011-hashmap.sh | 58 ++++++++++++++++++++++++++++------------------
 t/t0016-oidmap.sh  | 30 +++++++++++++++---------
 2 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 9c96b3e3b1..5343ffd3f9 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -170,31 +170,45 @@ NULL
 '
 
 test_expect_success 'iterate' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-iterate" "NULL
-NULL
-NULL
-key2 value2
-key1 value1
-fooBarFrotz value3"
-
+	test-tool hashmap >actual.raw <<-\EOF &&
+	put key1 value1
+	put key2 value2
+	put fooBarFrotz value3
+	iterate
+	EOF
+
+	cat >expect <<-\EOF &&
+	NULL
+	NULL
+	NULL
+	fooBarFrotz value3
+	key1 value1
+	key2 value2
+	EOF
+
+	sort <actual.raw >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'iterate (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-iterate" "NULL
-NULL
-NULL
-fooBarFrotz value3
-key2 value2
-key1 value1" ignorecase
-
+	test-tool hashmap ignorecase >actual.raw <<-\EOF &&
+	put key1 value1
+	put key2 value2
+	put fooBarFrotz value3
+	iterate
+	EOF
+
+	cat >expect <<-\EOF &&
+	NULL
+	NULL
+	NULL
+	fooBarFrotz value3
+	key1 value1
+	key2 value2
+	EOF
+
+	sort <actual.raw >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'grow / shrink' '
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index bbe719e950..31f8276ba8 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -86,17 +86,25 @@ NULL"
 '
 
 test_expect_success 'iterate' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-iterate" "NULL
-NULL
-NULL
-$(git rev-parse two) 2
-$(git rev-parse one) 1
-$(git rev-parse three) 3"
-
+	test-tool oidmap >actual.raw <<-\EOF &&
+	put one 1
+	put two 2
+	put three 3
+	iterate
+	EOF
+
+	# sort "expect" too so we do not rely on the order of particular oids
+	sort >expect <<-EOF &&
+	NULL
+	NULL
+	NULL
+	$(git rev-parse one) 1
+	$(git rev-parse two) 2
+	$(git rev-parse three) 3
+	EOF
+
+	sort <actual.raw >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.23.0.rc0.426.gbdee707ba7

