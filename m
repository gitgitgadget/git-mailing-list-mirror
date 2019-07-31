Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDF91F462
	for <e@80x24.org>; Wed, 31 Jul 2019 01:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGaB1s (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 21:27:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:56280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725209AbfGaB1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 21:27:48 -0400
Received: (qmail 10232 invoked by uid 109); 31 Jul 2019 01:27:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 01:27:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12566 invoked by uid 111); 31 Jul 2019 01:29:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 21:29:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 21:27:46 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731012746.GB13880@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731012336.GA13880@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 09:23:36PM -0400, Jeff King wrote:

>  test_expect_success 'iterate (case insensitive)' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -iterate" "NULL
> -NULL
> -NULL
> -fooBarFrotz value3
> -key2 value2
> -key1 value1" ignorecase

By the way, I found it curious that this test is repeated both with and
without ignorecase, but in the case-insensitive we never have any
case-equivalent names!

I guess it is testing that we preserved the name of fooBarFrotz, but I
would think that this:

diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 5343ffd3f9..2807dff644 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -195,14 +195,15 @@ test_expect_success 'iterate (case insensitive)' '
 	put key1 value1
 	put key2 value2
 	put fooBarFrotz value3
+	put foobarfrotz value4
 	iterate
 	EOF
 
 	cat >expect <<-\EOF &&
 	NULL
 	NULL
 	NULL
-	fooBarFrotz value3
+	fooBarFrotz value4
 	key1 value1
 	key2 value2
 	EOF

on top of my other patch would be a good addition. However, it yields
this result:

--- expect	2019-07-31 01:26:07.284231899 +0000
+++ actual	2019-07-31 01:26:07.284231899 +0000
@@ -1,6 +1,7 @@
 NULL
 NULL
 NULL
-fooBarFrotz value4
+foobarfrotz value4
 key1 value1
 key2 value2
+value3

The first line is a matter of taste I think (whether to keep the
original case or replace it with the new key). But the empty-keyed
retention of value3 seems wrong. I'm not sure if this is a bug in the
actual hashmap code, or just a weirdness with the way test-tool prints
it.

I'm going offline for a bit, so if anybody feels like following up on
the mystery, be my guest. Otherwise I may take a look later tonight.

-Peff
